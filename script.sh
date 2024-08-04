                                                                                                               
#!/bin/bash

# Define input log file and output summary report
LOG_FILE="/var/log/alternatives.log"
SUMMARY_REPORT="/var/log/summary_report.txt"

# Ensure the log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Log file $LOG_FILE does not exist."
    exit 1
fi

# Initialize the summary report file
echo "Summary Report - $(date)" > "$SUMMARY_REPORT"
echo "-----------------------------------" >> "$SUMMARY_REPORT"

# Extract and count error messages
echo "Error Messages:" >> "$SUMMARY_REPORT"
grep "ERROR" "$LOG_FILE" | tee -a "$SUMMARY_REPORT" | wc -l | awk '{print "Total Errors: " $1}' >> "$SUMMARY_REPORT"
echo >> "$SUMMARY_REPORT"

# Extract and count user activity (e.g., user logins)
echo "User Activity:" >> "$SUMMARY_REPORT"
grep "LOGIN" "$LOG_FILE" | tee -a "$SUMMARY_REPORT" | wc -l | awk '{print "Total Logins: " $1}' >> "$SUMMARY_REPORT"
echo >> "$SUMMARY_REPORT"

# Extract specific patterns or fields (customize as needed)
echo "Specific Patterns:" >> "$SUMMARY_REPORT"
awk '/PATTERN/ {print $0}' "$LOG_FILE" | tee -a "$SUMMARY_REPORT" | wc -l | awk '{print "Total Patterns: " $1}' >> "$SUMMARY_REPORT"
echo >> "$SUMMARY_REPORT"

# Example of using sed to format the log (e.g., remove timestamps)
echo "Formatted Log Entries:" >> "$SUMMARY_REPORT"
sed 's/^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2} //g' "$LOG_FILE" | tee -a "$SUMMARY_REPORT" | head -n 10 >> "$SUMMARY_REPORT"
echo >> "$SUMMARY_REPORT"

echo "Summary report generated at $SUMMARY_REPORT"


