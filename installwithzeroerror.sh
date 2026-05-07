#!/bin/sh

# Function: Strictly control each step
run_step() {
    local step_name="$1"
    local command="$2"

    while true; do
        echo "------------------------------------------------"
        echo "👉 Step: $step_name"
        echo -n "▶ Press 'y' and Enter to start (or 'n' to cancel): "
        read user_choice

        # Default to 'y' if Enter is pressed
        if [ -z "$user_choice" ] || [ "$user_choice" = "y" ]; then
            echo "⏳ Running..."
            
            # Execute the command
            eval "$command"
            local status=$?
            
            # Check if the command was successful
            if [ $status -eq 0 ]; then
                echo "✅ Success: $step_name completed!"
                break # Exit loop and move to the next step if successful
            else
                echo "⚠️ Error! This step failed."
                echo "🛑 By rule, you cannot proceed to the next step until this is successful."
                echo -n "🔄 Press 'y' to retry after fixing the issue (or 'n' to abort installation): "
                read retry_choice
                
                if [ "$retry_choice" = "n" ]; then
                    echo "❌ Installation aborted."
                    exit 1
                fi
                echo "🔄 Retrying..."
            fi
        elif [ "$user_choice" = "n" ]; then
            echo "❌ Installation cancelled."
            exit 1
        else
            echo "Please type 'y' or 'n'."
        fi
    done
}

clear
echo "🚀 Starting BDIX Strict Installer..."

# Step 1: Update
run_step "Updating package list (opkg update)" \
"opkg update"

# Step 2: Install packages
run_step "Installing required packages" \
"opkg install iptables iptables-mod-nat-extra redsocks 6in4 ipv6helper irqbalance luci-app-ttyd shellsync"

# Step 3: Setup configuration safely (prevents false errors on retry)
run_step "Backing up old configuration and setting up new files" \
"service redsocks stop 2>/dev/null || true ; [ -f /etc/redsocks.conf ] && mv /etc/redsocks.conf /etc/redsocks.conf.bkp ; wget -O /etc/bdix.conf https://github.com/IXWRT/BNET/raw/main/bdix.conf && [ -f /etc/init.d/redsocks ] && mv /etc/init.d/redsocks /etc/init.d/redsocks.bkp ; wget -O /etc/init.d/bdix https://github.com/IXWRT/BNET/raw/main/bdix && chmod +x /etc/init.d/bdix"

# Step 4: Enable service
run_step "Enabling BDIX auto boot-start" \
"service bdix enable"

# Step 5: Start service
run_step "Starting BDIX service" \
"service bdix start"

# Step 6: Install theme
run_step "Installing LuCI theme Aurora" \
"wget -O /tmp/aurora.ipk 'https://github.com/eamonxg/luci-theme-aurora/releases/download/v0.11.0/luci-theme-aurora_0.11.0-r20260208_all.ipk' && opkg install /tmp/aurora.ipk && rm /tmp/aurora.ipk"

echo "------------------------------------------------"
echo "🎉 Congratulations! All steps completed successfully and BDIX is now running."
