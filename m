Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DE420A1E7
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 17:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405786AbgFYP1p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 11:27:45 -0400
Received: from cmta18.telus.net ([209.171.16.91]:35307 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405766AbgFYP1o (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Jun 2020 11:27:44 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id oTmujDjcOVEJfoTmvjEWnX; Thu, 25 Jun 2020 09:27:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1593098862; bh=RVs4Ovnc/me+FGPNSUhJjaVhnerEivhzrjX5EcfsJe0=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=vxZs0Hs9Y7GBWHOfrw8VYgHkMNp48ti+qPJJZGQZ2ARKIc3GUP+a3zVMON4Gu+XQI
         IBKFXdS0pJxJDDpY3LODIOdXaUMLfNtAmIG2pSyp1encgxPmZggM9aaW6dI2XgFXH6
         0RdrPAhXtMs/9hQn58M8gzPk7Pgn6OrEx1W80sGJ86XUNJFMmYul147dLkDFB1PZfo
         05SdAolSXfCM3ZZfkHqxk9qvk2OU/Aq+BqenMD432Qx7wuVigQgeXw4uLY9yt0EpXi
         sQcglk+allPR6djD4Pioq16thBpgqZXHitCD9+yWSwhPM6wAIfcqn6SWf8/Rf6Ccjv
         xt1XTBtoowrOA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=KIck82No c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8
 a=m-Cm7fCOe7P8hAMx0BIA:9 a=maVp5vB5daoMQ-QU:21 a=U_Z0NZ6cXKdVcP4U:21
 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Len Brown'" <len.brown@intel.com>
Cc:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <000701d643f0$fa0f3140$ee2d93c0$@net>
In-Reply-To: <000701d643f0$fa0f3140$ee2d93c0$@net>
Subject: RE: x86_energy_perf_policy
Date:   Thu, 25 Jun 2020 08:27:39 -0700
Message-ID: <000101d64b05$2ac63200$80529600$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdZD8PfSy8WNOn4USb644svYuN0mPAHEIpTg
X-CMAE-Envelope: MS4wfPEt0Ghxhu2u6K+2htjzQWe/xp+uWtbItmLhsjWzNyqBRbNoPrvka31qeeV54VHSyfqUk9HIGMPN2vEUO6Zky+UyZ9SqsrwaWzJF2NITPXrYME9XiCIy
 5QQVp9z4bFV5gIBSv/ONx3MXJ+x0v/1TqtJMQ8ZOjVinIg4rv3GjmGKdC8EYeLVUcIQtdD0NAE2kI3R5N/sA3WE96zg0kM0bqT3F7q5sMBGOxwE0Sk0Gwg6i
 5vkufCstLh5/sksfrr7NJA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Len,

When I look at the dates for patches,
I do not think that

tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c

even knows about intel_cpufreq (intel_pstate in passive mode).
Anyway this tool is now banned from my computers.

I'll re-phrase my previous e-mail, in a much more blunt way:

tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c

should be fixed or removed.

... Doug

> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-owner@vger.kernel.org] On Behalf Of Doug
> Smythies
> Sent: June 16, 2020 8:15 AM
> To: 'Len Brown'
> Cc: 'Srinivas Pandruvada'; 'Linux PM'
> Subject: x86_energy_perf_policy
> 
> Hi Len,
> 
> I have been using x86_energy_perf_policy to manage EPB while I do some tests.
> I noticed it says this:
> 
> "HWP can be enabled using '--hwp-enable'"
> 
> So, I thought great, I can now in one boot do:
> 
> intel_pstate, no-HWP, performance/powersave.
> intel_cpufreq, no-HWP, all governors
> 
> run: x86_energy_perf_policy --hwp-enable
> 
> then repeat the above, but only passive, if trying some of Rafael's RFC stuff,
> which is NOT part of this e-mail.
> 
> However, enabling HWP via this method leaves my system in an unusable state.
> 
> Please confirm or deny if I am supposed to be able to enable HWP via
> x86_energy_perf_policy?
> 
> No need to read on:
> 
> Examples (kernel 5.8=rc1):
> 
> Note: I wrote my own MSR decoder. I know I could use turbostat, and do
> have it running virtually 100% of the time. However, writing my own
> decoder forced me to learn more.
> 
> Fresh boot (no=hwp forced):
> 
> root@s18:/home/doug# /home/doug/c/msr-decoder
> 8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :   8 :   8 :   8 :   8 :   8 :   8 :
> B.) 0x770: IA32_PM_ENABLE: 0 : HWP disable
> 9.) 0x199: IA32_PERF_CTL        : CPU 0-5 :   9 :   8 :   8 :   8 :  19 :  26 :
> C.) 0x1B0: IA32_ENERGY_PERF_BIAS: CPU 0-5 :   6 :   6 :   6 :   6 :   6 :   6 :
> 1.) 0x19C: IA32_THERM_STATUS: 88480000
> 2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OOB Bit 8 reset OOB Bit 18
> reset
> 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88470000
> 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
> A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : RHO disable : EEO disable
> 
> Now,
> 
> # x86_energy_perf_policy --hwp-enable
> 
> root@s18:/home/doug# /home/doug/c/msr-decoder
> 8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :   8 :   8 :   8 :   8 :   8 :   8 :
> B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
> 1.) 0x19C: IA32_THERM_STATUS: 88480000
> 2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OOB Bit 8 reset OOB Bit 18
> reset
> 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88460000
> 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
> A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : RHO disable : EEO disable
> 5.) 0x771: IA32_HWP_CAPABILITIES (performance): 108252E : high 46 : guaranteed 37 : efficient 8 :
> lowest 1
> 6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
>     raw: 8000FF01 : 8000FF01 : 8000FF01 : 8000FF01 : 8000FF01 : 8000FF01 :
>     min:        1 :        1 :        1 :        1 :        1 :        1 :
>     max:      255 :      255 :      255 :      255 :      255 :      255 :
>     des:        0 :        0 :        0 :        0 :        0 :        0 :
>     epp:      128 :      128 :      128 :      128 :      128 :      128 :
>     act:        0 :        0 :        0 :        0 :        0 :        0 :
> 7.) 0x777: IA32_HWP_STATUS: 0 : high 0 : guaranteed 0 : efficient 0 : lowest 0
> 
> Notice that EPP is 128, and I can not achieve full CPU speed for a workflow that should.
> Ok. So maybe I just need to toggle between performance and powersave and back. No difference.
> I tried many variations. There are many situations where the misbehaves.
> 
> If I boot with HWP enabled, I can observe EPP (and min and max) behave as expected
> and as a function of the governor. The system seems to behave.
> 
> intel_pstate / powersave:
> 
> root@s18:/home/doug# /home/doug/c/msr-decoder
> 8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :   8 :   8 :   8 :   8 :   8 :   8 :
> B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
> 1.) 0x19C: IA32_THERM_STATUS: 88480800 PWL
> 2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OOB Bit 8 reset OOB Bit 18
> reset
> 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88470800 PWL
> 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 4000000 PL1L
> A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : RHO disable : EEO disable
> 5.) 0x771: IA32_HWP_CAPABILITIES (performance): 108252E : high 46 : guaranteed 37 : efficient 8 :
> lowest 1
> 6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
>     raw: 80002E08 : 80002E08 : 80002E08 : 80002E08 : 80002E08 : 80002E08 :
>     min:        8 :        8 :        8 :        8 :        8 :        8 :
>     max:       46 :       46 :       46 :       46 :       46 :       46 :
>     des:        0 :        0 :        0 :        0 :        0 :        0 :
>     epp:      128 :      128 :      128 :      128 :      128 :      128 :
>     act:        0 :        0 :        0 :        0 :        0 :        0 :
> 7.) 0x777: IA32_HWP_STATUS: 4 : high 4 : guaranteed 0 : efficient 0 : lowest 0
> 
> intel_pstate / performance:
> 
> root@s18:/home/doug# /home/doug/c/msr-decoder
> 8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :  46 :  46 :  46 :  46 :  46 :  46 :
> B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
> 1.) 0x19C: IA32_THERM_STATUS: 88470800 PWL
> 2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OOB Bit 8 reset OOB Bit 18
> reset
> 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88460800 PWL
> 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 4000000 PL1L
> A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : RHO disable : EEO disable
> 5.) 0x771: IA32_HWP_CAPABILITIES (performance): 108252E : high 46 : guaranteed 37 : efficient 8 :
> lowest 1
> 6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
>     raw: 00002E2E : 00002E2E : 00002E2E : 00002E2E : 00002E2E : 00002E2E :
>     min:       46 :       46 :       46 :       46 :       46 :       46 :
>     max:       46 :       46 :       46 :       46 :       46 :       46 :
>     des:        0 :        0 :        0 :        0 :        0 :        0 :
>     epp:        0 :        0 :        0 :        0 :        0 :        0 :
>     act:        0 :        0 :        0 :        0 :        0 :        0 :
> 7.) 0x777: IA32_HWP_STATUS: 4 : high 4 : guaranteed 0 : efficient 0 : lowest 0
> 
> ... Doug


