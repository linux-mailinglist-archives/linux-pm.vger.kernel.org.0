Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BD623BE94
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 19:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgHDRHB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 13:07:01 -0400
Received: from cmta16.telus.net ([209.171.16.89]:49311 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729610AbgHDRFr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Aug 2020 13:05:47 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id 30Mhk7TkK5b7l30MjkMSUA; Tue, 04 Aug 2020 11:04:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1596560684; bh=JALEurWlvnPlBMa78OmCHzscxaUV9ayGqlorUWPpLOM=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=zVnmGtazlqkbIHxU1KvaCnW3nzLccpDF9ASaAOTmhWU5ao6Yx2cLjD3h/MTBwosWL
         EcBqJIipYr0b9a9sRgQCDQFyqwv7ToTvf3HYhWClksm/SLRBVtnL4oXYlK699thob4
         KWS0gQG8QteOJsg+8gYNpRrzJoW5+XTMiNChpuWjQZei1a/zjdv1OlivGu1jH/C7kJ
         Ju3WPS4a3XsMMAvpcGc84ome4taezNNpaHPZ1BjEXRnRM1U5Yi28Ohiy/7Cx4LLkaP
         jUV6CRaqb+StqS00Dusz6S3pVDJLr2TbZjJSQ3jxEgFvRrzt8hGG+bVYKwovRrhcxy
         8HvtPLBF0AfiA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=YPHhNiOx c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8
 a=Z_ZUgUZAPj2aFtWniJYA:9 a=cGtpBKYyCqBvOoDN:21 a=WcyYtQ8uXPS6tcuo:21
 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Linux Documentation'" <linux-doc@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <4981405.3kqTVLv5tO@kreacher> <1709487.Bxjb1zNRZM@kreacher> <1633168.eVXp6ieOpF@kreacher>
In-Reply-To: <1633168.eVXp6ieOpF@kreacher>
Subject: RE: [PATCH v6] cpufreq: intel_pstate: Implement passive mode with HWP enabled
Date:   Tue, 4 Aug 2020 10:04:39 -0700
Message-ID: <000d01d66a81$59326a50$0b973ef0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdZqcXRb5nHqAAAiRZmLFRLLJ0EJBwADBFCQ
X-CMAE-Envelope: MS4wfBOrrTL5LsPq/idhG+0L5OvyXACBr/DULF4vCaqFGVMhei+w3S6yiPRw3grLdg+/glA+uxKI07NL98+BawXlQOhJgzZcp7fpBZnqXy1sMI39ZGNCWo63
 A2uFt62HCprVZQCBp8YnNS+wFr/4r2J6CqWPVnvxaqcaN560lgwWv1lsWWaIDaNI2rVJXMjeXDPyBI9yVrj/O83kCcnwrX956X7iTSoRcogG3U7PKAmxvKHs
 jMhESBBqhMZZFJzZ63PoLMUZ7vvLVsxaxk1uWwuO0yu8N7UoA+Wtl015NHE6AWBdftg/WWzbD6Or7rdN/lvuH80m5Vyh1Y1an06wtR8bv9xgx+Wb9SP2E6zR
 +n8jMdLbyLSbhYrLBsMSgxN3Ilt7w/IjAn2JPU7Def8Z3AGIa2xRzt1WyiK6UyHwPK8vsE4eYk54XPOUtuHCIQ3h6Q/w1nzjK+eQMfj/WeGlq8ep0Fk=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

I was just writing you about V5 when this V6 came.

On 2020.08.04 08:11 Rafael J. Wysocki wrote:
...
> This is on top of the material already in the mainline.

Oh, should have read that part better,
but did get there in the end.
...
> v5 -> v6:
>    * Fix the problem with the EPP setting via sysfs not working with the
>      performance and powersave governors by stopping and restarting the
>      governor around the sysfs-based EPP updates in the passive mode.
>    * Because of that, use the epp_cached field just for avoiding the above
>      if the new EPP value for the given CPU is the same as the old one.
>    * Export cpufreq_start/stop_governor() from the core (for the above).

EPP is still not right.
I am not messing with it at all, just observing via my msr-decoder.

I booted without any intel_pstate related directives for the
kernel command line. The below is as expected (performance gov.):

# /home/doug/c/msr-decoder
How many CPUs?: 6
8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :  46 :  46 :  46 :  46 :  46 :  46 :
B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
1.) 0x19C: IA32_THERM_STATUS: 88450000
2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OOB Bit 8 reset OOB Bit 18 reset
3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88430000
4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : EEO disable : RHO disable
5.) 0x771: IA32_HWP_CAPABILITIES (performance): 109252E : high 46 : guaranteed 37 : efficient 9 : lowest 1
6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
    raw: 00002E2E : 00002E2E : 00002E2E : 00002E2E : 00002E2E : 00002E2E :
    min:       46 :       46 :       46 :       46 :       46 :       46 :
    max:       46 :       46 :       46 :       46 :       46 :       46 :
    des:        0 :        0 :        0 :        0 :        0 :        0 :
    epp:        0 :        0 :        0 :        0 :        0 :        0 :
    act:        0 :        0 :        0 :        0 :        0 :        0 :
7.) 0x777: IA32_HWP_STATUS: 4 : high 4 : guaranteed 0 : efficient 0 : lowest 0

and then switched to passive mode later. EPP is not as expected. Expect 0
(performance mode):

# /home/doug/c/msr-decoder
How many CPUs?: 6
8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :  46 :  46 :  46 :  46 :  46 :  46 :
B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
1.) 0x19C: IA32_THERM_STATUS: 88440000
2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OOB Bit 8 reset OOB Bit 18 reset
3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88420000
4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : EEO disable : RHO disable
5.) 0x771: IA32_HWP_CAPABILITIES (performance): 108252E : high 46 : guaranteed 37 : efficient 8 : lowest 1
6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
    raw: FF002E2E : FF002E2E : FF002E2E : FF002E2E : FF002E2E : FF002E2E :
    min:       46 :       46 :       46 :       46 :       46 :       46 :
    max:       46 :       46 :       46 :       46 :       46 :       46 :
    des:        0 :        0 :        0 :        0 :        0 :        0 :
    epp:      255 :      255 :      255 :      255 :      255 :      255 :
    act:        0 :        0 :        0 :        0 :        0 :        0 :
7.) 0x777: IA32_HWP_STATUS: 4 : high 4 : guaranteed 0 : efficient 0 : lowest 0

Then switched to ondemand governor, and put 100% load on 2 CPUs.
EPP is not as expected, which I don't actually know what to expect,
but assume 128:

# /home/doug/c/msr-decoder
How many CPUs?: 6
8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :  46 :  46 :  46 :  46 :  46 :  46 :
B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
1.) 0x19C: IA32_THERM_STATUS: 883B0000
2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OOB Bit 8 reset OOB Bit 18 reset
3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 882B0000
4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : EEO disable : RHO disable
5.) 0x771: IA32_HWP_CAPABILITIES (performance): 10B252E : high 46 : guaranteed 37 : efficient 11 : lowest 1
6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
    raw: FF002E09 : FF002E0C : FF002E2E : FF002E08 : FF002E2E : FF002E18 :
    min:        9 :       12 :       46 :        8 :       46 :       24 :
    max:       46 :       46 :       46 :       46 :       46 :       46 :
    des:        0 :        0 :        0 :        0 :        0 :        0 :
    epp:      255 :      255 :      255 :      255 :      255 :      255 :
    act:        0 :        0 :        0 :        0 :        0 :        0 :
7.) 0x777: IA32_HWP_STATUS: 4 : high 4 : guaranteed 0 : efficient 0 : lowest 0

For what it's worth, Kernel:

78b39581ed85 (HEAD -> dtemp) cpufreq: intel_pstate: Implement passive mode with HWP enabled
c0842fbc1b18 (origin/master, origin/HEAD, master) random32: move the pseudo-random 32-bit definitions to prandom.h
2baa85d6927d Merge tag 'acpi-5.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
04084978003c Merge tag 'pm-5.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

... Doug


