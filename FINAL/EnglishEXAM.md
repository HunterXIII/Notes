# Вопросы 
### 1. Explain what an IP address is and name its primary function in a network.

A IP-address is an unique number for your device on the Internet. Its primary function is to identify devices  and help send data to each other.
### 2. Describe a common method for finding out your own public IP address. What about finding the IP address of a website?

You can find your public IP address by searching "What is my IP" on Google. To find the IP address of a website you can use "ping" or "nslookup" command  in the terminal.

### 3. What are browser cookies, and what kind of user information can they typically store or help retrieve?

Cookies are small files saved by websites. They store user information like login status, website setting, shopping cart items. 

### 4. What is the difference between cookies and cache? How can you enable and remove cookies?

Cookies store user settings and session data, while cache stores website files like images to load pages sfaster. You can enable and remove cookies in your browser settings. 

### 5. What is digital fingerprinting? Can you be tracked without cookies (e.g. cookies are blocked)?

Digital fingerprinting collects imformation about your browser, OS and hardware. Yes, websites can track you without cookies by using this data. 

### 6. What, in your opinion, are the key characteristics of a strong password? What makes a password weak and easily guessable?

Password must be long and include characters, numbers and symbols. A weak password is short, uses simple words or personal data like names or birthdays.

### 7. Why using the same password for multiple websites is considered to be a critical security risk?

If a hacker steals your password from one website, he can access all your other accounts. This is called credential stuffing.

### 8. Is passwordless future possible? What are there other ways to log in securely without using a password?

Yes, a passwordless future is posible. Other ways to log are biometrics like fingerprints, hardware security keys and passkeys. 

### 9. Why is keeping software and operating systems updated considered a cornerstone of internet security?

Updates fix security vulnerabilities that hackers use to attack systems. If you don't update. your system remains vulnerable.  

### 10. How does a firewall contribute to internet security for a home network or a business?

A firewall monitors network traffic. It blocks unauthorized access and stops malicios data from entering the network.

### 11. What security advice would you give to a non-technical person about using public Wi-Fi networks?

Never log into bank account and type sensetive passwords on public WiFi. Always use VPN to encrypt your internet traffic and protect your data.

### 12. List three common types of cyber threats (e.g., malware, phishing) and briefly describe how each one works.

Phishing uses fake emails to steal your passwords. Ransomware encrypts your files and demands money. Spyware records your screen and keystrokes. 

### 13. What are some effective ways to protect against phishing attacks?

Always check the sender's email address and do not click on suspicios links. You should enable 2FA

### 14. What is a brute force attack in the context of cybersecurity? How can a system administrator protect against brute force attacks on user accounts?

A brute force attack is when hacker tries different password combinations to find the correct one. Administrator can protect by limiting login attempts.

### 15. What unique security challenges does remote work introduce that are less common in a traditional office?

Remote work uses unsecure home WiFi networks and personal devices. Also, IT companies can't controlthe security envirmonets outside office.

### 16. Why is a VPN (Virtual Private Network) so often mandated for remote company access?

A VPN creates an encrypted tunnels between the remote employee and the compamy network. It protect sencitive corporate data.

### 17. What is "multi-factor authentication (MFA)," and why has it become a standard requirement for remote access?

MFA requires two or more proofs of identity, like a password and phone code. It is a standart now because if hacker steals a password, he can't access the account.

### 18. Compare the main differences between Agile and Waterfall methodologies. In which situations would Waterfall still be a better choice than Agile?

Agile is a flexible and develops software in short cycles. Waterfall is linear and follows a plan step by step. Waterfall is better for small projects with fixed requirements and clear budgets. 

### 19. How does Agile address changing requirements during a project, and why is this difficult in Waterfall?

Agile works in short sprints, so it can change the plan at any time. Waterfall follows a strict plan from start to finish, so changes break everything. 

### 20. What are the typical phases of the SDLC, and why is each one important?

The phases are planning, design, coding, testing and release. Planning finds goals. Design describes architecture. Coding builds the app. Testing checks for bugs. Release delivers it to users. 

### 21. Who are the key stakeholders involved in the requirements gathering phase, and what can go wrong if this phase is rushed?

The key stakeholders are clients, users and developers. If this phase is rushed, team will build a wrong producr and waste time.

### 22. What is the Scrum ceremonies and daily stand-ups? What is the role of the Scrum Master?

Scrum ceremonies are team meetings like sprint planning, reviews and daily stand-ups. The daily stand-ups is a quick meetings before starting work. The Scrum master helps the teams follow Scrum rules and removes blocks.   

### 23. Imagine a developer misses the daily Scrum three days in a row. What problems could this cause, and how would the Scrum Master address it using Jira’s tracking features?

If a developer misses meetings, the team don't know his progress and  problems. Scrum master can check Jirs to see active tasks, comments and time logs to understand their status.

### 24. What is the difference between traditional on-premise infrastructure and cloud computing? Give an example of when you would choose each.

Traditional on-premise infrasructure is when you buy physical server in your office. Cloud computing is when you rent servers from providers over the Internet. Choose on-premise for high security and cloud for fast scaling. 

### 25. How do virtual machines (VMs) differ from containers in terms of resource usage and isolation?

VMs have full isolation because each has its own OS, but they uses a lot of resources. Containers use less resources because they share the host OS, but they has weaker isolation.

### 26. Imagine a team has one powerful physical server. They need to run three applications, each with slightly different Linux distributions (e.g., Ubuntu 18.04, CentOS 7, and Debian 10). Which technology is better suited – VMs or containers? Justify your answer.

Virtualization is better because it can **run multiple virtual machines (VMs) simultaneously**. The hypervisor can then **allocate the necessary power to each VM as needed**.

### 27. If your company needed to run an old, critical application that only works on a specific older version of Windows, would you choose virtualization or containerization? Why?

I would choose a virtualizations because it creates a virtual physical resources. This allows to run a specific older version OS. 