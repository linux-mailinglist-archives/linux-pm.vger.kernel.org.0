Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6518A1FB5D1
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 17:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgFPPPh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 11:15:37 -0400
Received: from cmta20.telus.net ([209.171.16.93]:39400 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729602AbgFPPPg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jun 2020 11:15:36 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id lDJBjqoxCdVYHlDJDjJ187; Tue, 16 Jun 2020 09:15:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1592320533; bh=NbczxlLRu3vy6jAkxmYdKnx+Hd2ie45o/i3ggecOi8Q=;
        h=From:To:Cc:Subject:Date;
        b=5wCkbLbrv2hR1R5j02LA21Gc1fbs+1vo46+RM9vlE1Ws0v1c61QOIjyVkeRQv+kJF
         KcjkpSCGo2UmUYvc4ILCDV4sQ6CCQbWXd9HBW7PZGWCrktHsD23Tvypp+Aa5obf95r
         3TAsLIBu/CRGSdCWEaUu8RY+H1RXYEfFP0c4OvJxzY+Dp68jiTRHnGX6/GVUJ2s7tN
         FJtmuiWU+fwhamzoa5yiVFaroHC0KAcMqNlr9GWYkoyuG35M7uhX8nKjKqxaLfNmJp
         vDOyim3s2nxPZnB7IUaHCQIHxm0xx4SobKzYBFbjv52ZcUazYO2gKzMyzzXUNDkmDR
         rNGDJTXz6BFPA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=Y5CGTSWN c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=Ev0T8Em6HKORIEQ_FE0A:9
 a=xbpGSC-4GgXBv2ZT:21 a=Kr0RsjRkwfzBDhq0:21 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Len Brown'" <len.brown@intel.com>
Cc:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
Subject: x86_energy_perf_policy
Date:   Tue, 16 Jun 2020 08:15:28 -0700
Message-ID: <000701d643f0$fa0f3140$ee2d93c0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdZD8PfSy8WNOn4USb644svYuN0mPA==
X-CMAE-Envelope: MS4wfNsgNt5QvKKlP4UcOxCm4pbZtuMZwYCP1rIhkW0LxkbS0eCtTlI6BXHLnanzPNB8k0zv6DSRdfIxOW2jMPG6WlqTqrvgi9NJWMNZAanHZYZPZI1ELlIv
 8bju4GUG+uOCMqL0qGQvE09hbvgD/iVjbY3/27F1oluGjyG5Oi+DZQVvcEybiMTydQIW2ICKj9EZFgyY68Bcc178Vyb6w7CuXwa+m7pJI6UMnuhFNhhk5+z/
 yh4CUiNMQHKd1RdkIFOgqA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Len,

I have been using x86_energy_perf_policy to manage EPB while I do some tests.
I noticed it says this:

"HWP can be enabled using '--hwp-enable'"

So, I thought great, I can now in one boot do:

intel_pstate, no-HWP, performance/powersave.
intel_cpufreq, no-HWP, all governors

run: x86_energy_perf_policy --hwp-enable

then repeat the above, but only passive, if trying some of Rafael's RFC stuff,
which is NOT part of this e-mail.

However, enabling HWP via this method leaves my system in an unusable state.

Please confirm or deny if I am supposed to be able to enable HWP via
x86_energy_perf_policy?

No need to read on:

Examples (kernel 5.8=rc1):

Note: I wrote my own MSR decoder. I know I could use turbostat, and do
have it running virtually 100% of the time. However, writing my own
decoder forced me to learn more.

Fresh boot (no=hwp forced):

root@s18:/home/doug# /home/doug/c/msr-decoder
8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :   8 :   8 :   8 :   8 :   8 :   8 :
B.) 0x770: IA32_PM_ENABLE: 0 : HWP disable
9.) 0x199: IA32_PERF_CTL        : CPU 0-5 :   9 :   8 :   8 :   8 :  19 :  26 :
C.) 0x1B0: IA32_ENERGY_PERF_BIAS: CPU 0-5 :   6 :   6 :   6 :   6 :   6 :   6 :
1.) 0x19C: IA32_THERM_STATUS: 88480000
2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OOB Bit 8 reset OOB Bit 18 reset
3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88470000
4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : RHO disable : EEO disable

Now,

# x86_energy_perf_policy --hwp-enable

root@s18:/home/doug# /home/doug/c/msr-decoder
8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :   8 :   8 :   8 :   8 :   8 :   8 :
B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
1.) 0x19C: IA32_THERM_STATUS: 88480000
2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OOB Bit 8 reset OOB Bit 18 reset
3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88460000
4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : RHO disable : EEO disable
5.) 0x771: IA32_HWP_CAPABILITIES (performance): 108252E : high 46 : guaranteed 37 : efficient 8 : lowest 1
6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
    raw: 8000FF01 : 8000FF01 : 8000FF01 : 8000FF01 : 8000FF01 : 8000FF01 :
    min:        1 :        1 :        1 :        1 :        1 :        1 :
    max:      255 :      255 :      255 :      255 :      255 :      255 :
    des:        0 :        0 :        0 :        0 :        0 :        0 :
    epp:      128 :      128 :      128 :      128 :      128 :      128 :
    act:        0 :        0 :        0 :        0 :        0 :        0 :
7.) 0x777: IA32_HWP_STATUS: 0 : high 0 : guaranteed 0 : efficient 0 : lowest 0

Notice that EPP is 128, and I can not achieve full CPU speed for a workflow that should.
Ok. So maybe I just need to toggle between performance and powersave and back. No difference.
I tried many variations. There are many situations where the misbehaves.

If I boot with HWP enabled, I can observe EPP (and min and max) behave as expected
and as a function of the governor. The system seems to behave.

intel_pstate / powersave:

root@s18:/home/doug# /home/doug/c/msr-decoder
8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :   8 :   8 :   8 :   8 :   8 :   8 :
B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
1.) 0x19C: IA32_THERM_STATUS: 88480800 PWL
2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OOB Bit 8 reset OOB Bit 18 reset
3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88470800 PWL
4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 4000000 PL1L
A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : RHO disable : EEO disable
5.) 0x771: IA32_HWP_CAPABILITIES (performance): 108252E : high 46 : guaranteed 37 : efficient 8 : lowest 1
6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
    raw: 80002E08 : 80002E08 : 80002E08 : 80002E08 : 80002E08 : 80002E08 :
    min:        8 :        8 :        8 :        8 :        8 :        8 :
    max:       46 :       46 :       46 :       46 :       46 :       46 :
    des:        0 :        0 :        0 :        0 :        0 :        0 :
    epp:      128 :      128 :      128 :      128 :      128 :      128 :
    act:        0 :        0 :        0 :        0 :        0 :        0 :
7.) 0x777: IA32_HWP_STATUS: 4 : high 4 : guaranteed 0 : efficient 0 : lowest 0

intel_pstate / performance:

root@s18:/home/doug# /home/doug/c/msr-decoder
8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :  46 :  46 :  46 :  46 :  46 :  46 :
B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
1.) 0x19C: IA32_THERM_STATUS: 88470800 PWL
2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OOB Bit 8 reset OOB Bit 18 reset
3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88460800 PWL
4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 4000000 PL1L
A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : RHO disable : EEO disable
5.) 0x771: IA32_HWP_CAPABILITIES (performance): 108252E : high 46 : guaranteed 37 : efficient 8 : lowest 1
6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
    raw: 00002E2E : 00002E2E : 00002E2E : 00002E2E : 00002E2E : 00002E2E :
    min:       46 :       46 :       46 :       46 :       46 :       46 :
    max:       46 :       46 :       46 :       46 :       46 :       46 :
    des:        0 :        0 :        0 :        0 :        0 :        0 :
    epp:        0 :        0 :        0 :        0 :        0 :        0 :
    act:        0 :        0 :        0 :        0 :        0 :        0 :
7.) 0x777: IA32_HWP_STATUS: 4 : high 4 : guaranteed 0 : efficient 0 : lowest 0

... Doug


