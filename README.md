<h1> Hands-on lab on AWS - SSL-VPN, Log4Shell, SQL Injection, Cookie Tampering and Web Scrapping </h1>
<h2>Intro</h2>
This hands-on lab is just for a PoC, testing vulnerabilities such as:

- Log4Shell
- SQL Injection
- Cookie Tampering
- Web Scrapping


We demonstrated how to attack these vulnerabilities in a web server hosted on AWS and how to defend it using FortiGate and FortiWeb. Also, you can find information on how to configure SSL-VPN on FortiGate here.

All the cloud resources were deployed using Terraform.

<h2>Deploy</h2>

![Topology](https://github.com/FortiLatam/handsonlab-fgt-fwb/blob/main/DOCS/Intro.png?raw=true)

We will deploy the resources shown above. Fortinet products used are PAYG, but you can change the files to use your own license.
FortiGate will be configured with NAT and initial firewall policies.
FortiWeb doesnt contain any initial settings
Web Legacy is an Ubuntu with Docker, and Log4Shell scripts
Web Internal is an Ubuntu with Docker, DVWA, NGINX and Log4Shell containers
