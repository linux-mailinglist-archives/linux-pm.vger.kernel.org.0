Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CB72DD591
	for <lists+linux-pm@lfdr.de>; Thu, 17 Dec 2020 17:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgLQQ6t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Dec 2020 11:58:49 -0500
Received: from cmta20.telus.net ([209.171.16.93]:41433 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbgLQQ6s (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Dec 2020 11:58:48 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id pwbKkbQnWwL1vpwbLkWtQp; Thu, 17 Dec 2020 09:58:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1608224285; bh=iN5BbZKiwRdlYvZDMhhMMQ1GmpYQaB5SvyBSBuZlh3A=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=u7kSWNcggciWJlvXKsjVfEN1li38QzP50LG5g++BPi+LyzaS0wUozenyw9hUWb4Zm
         qOdpS6Rf4Z7v77+AFNBqUD+xjRYKoI9jS5nqKVTXoMIrDGzzuxHbkZTaSde6CD1HQh
         iEVJfX49OHMUohOriRWtxeoqBeKL8nrXpz/UlGwdcLyJCQyLD45bTHGDAuT9/KRUUG
         QM+oAycw7jdsYZM3l2J5JizsfeSe4nGKPyDAiwaBX8Is3DHfvg6ZmBFypdhtyScPNj
         A3jGtccsVhNa1O5gqXR92+C63IoRylbcoGradXqrfN//kbj+3/OLM3pzWVLKGERMQR
         BVfSeSefULtxw==
X-Telus-Authed: none
X-Authority-Analysis: v=2.4 cv=cOElDnSN c=1 sm=1 tr=0 ts=5fdb8e1d
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8
 a=XRVjyzJIJYxxt8OlZVsA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>
Cc:     "'Len Brown'" <len.brown@intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Giovanni Gherdovich'" <ggherdovich@suse.cz>,
        "'Francisco Jerez'" <francisco.jerez.plata@intel.com>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
References: <2931539.RsFqoHxarq@kreacher>        <000001d6376a$03bbaae0$0b3300a0$@net>   <b624a148cdb91340dd8d8831c7b033017cab737e.camel@linux.intel.com>        <000201d63776$2d56f330$8804d990$@net> <000b01d65535$d148b8c0$73da2a40$@net>     <000501d668da$5bfd6260$13f82720$@net> <e33e435aa22cc68f832e7377b264278654c62e04.camel@linux.intel.com>
In-Reply-To: <e33e435aa22cc68f832e7377b264278654c62e04.camel@linux.intel.com>
Subject: RE: cpufreq: intel_pstate: HWP mode issue
Date:   Thu, 17 Dec 2020 08:58:01 -0800
Message-ID: <000b01d6d495$c9402c50$5bc084f0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdZo+WOHHpaV5x6KSvSJz/i6a9bBXhrm9aRA
X-CMAE-Envelope: MS4xfGCKoj3nK6AgprpxvX295aeAVCetp0t7S50gP12x4TmhZbIDpyb49TzO80AxaFltryjc4b1y7IjK5tYfm+X97FmlO2SLBzgvf+0K16E6bFBtPNZy4nQb
 YVseXTogEbLjiRngn6Hp9Iq1N0rDqHhQH+6fTa2Z5Mp12wTvJSJNvLWC3d/Ds4lyjIdug3/05GejsqnKuNJp/7kmYqn7hV4ivBlp33M+Mgh3J895TLKOY7cv
 RxEGhP4U59jiV+rARA3K/IeAivKGDrpkEEr3I+jR/cHjbcSEMbIOF+yVSIs/D2gUusE9w9WTCxc1coXw3lbiUNfBg1Ek09GHaWQb27u6juyxsOESVViMYKj/
 82MmpTFA8ROHtsLgZR2zGWc+KK0NQTMDu7rr0RU6zlpZ+bpkeoc=
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020.08.02 Srinivas Pandruvada wrote:
> On Sun, 2020-08-02 at 07:36 -0700, Doug Smythies wrote:
> > Hi Srinivas, or anybody at Intel,
> >
> > Any chance of you looking into this issue.
> > I first raised it over 2 months ago.
> 
> Hi Doug,
> 
> Unfortunately, didn't reach to this yet.

O.K., I created a bug report:

https://bugzilla.kernel.org/show_bug.cgi?id=210741

> 
> Thanks,
> Srinivas
> 
> 
> >
> > On 2020.07.08 07:41 Doug Smythies wrote:
> > > On 2020.06.30 11:41 Doug Smythies wrote:
> > > > Hi Srinivas,
> > > >
> > > > O.K. let's try this again, starting a new thread, with address
> > > > list similar to a few weeks ago.
> > > > I believe I have untangled my multiple issues, such that this e-
> > > > mail should be only about
> > > > the single issue of HWP capable processors incorrectly deciding
> > > > to lower the CPU frequency
> > > > under some conditions. Also, my previous assertion as to the
> > > > issue was indeed incorrect.
> > > >
> > > > I now:
> > > > . never use x86_energy_perf_policy.
> > > > . For HWP disabled: never change from active to passive or via
> > > > versa, but rather do it via boot.
> > > > . after boot always check and reset the various power limit log
> > > > bits that are set.
> > > > . never compile the kernel (well, until after any tests), which
> > > > will set those bits again.
> > > > . never run prime95 high heat torture test, which will set those
> > > > bits again.
> > > > . Note that the tests done for this e-mail never ever set those
> > > > bits again.
> > > > . Invented an entirely new way to manifest, demonstrate, and
> > > > exploit the issue (also mentioned June
> > > > 6th).
> > > > . All tests were repeated on another HWP capable computer, so a
> > > > i5-9600K and a i5-6200U.
> > > >
> > > > New method (old was periodic workflow):
> > > >
> > > > Long busy, short gap, busy but taking loop time samples so as to
> > > > estimate CPU frequency.
> > > > I am calling it an inverse impulse response test.
> > > >
> > > > Assertion:
> > > >
> > > > If the short sleep is somehow simultaneous with some sort of 5.0
> > > > millisecond (200 Hertz)
> > > > periodic event (either in HWP itself, or via the driver, I am
> > > > unable to determine which,
> > > > but think it is inside the black box that is HWP),
> > >
> > > I have been attempting to characterise the "black box" that is HWP.
> > > In terms of system response verses EPP, I only observe the HWP loop
> > > time as the
> > > response variable.
> > >
> > > 0 <= EPP <= 1 : My test can not measure loop time.
> > > 2 <= EPP <= 39 : HWP servo loop time 2 milliseconds
> > > 40 <= EPP <= 55 : HWP servo loop time 3 milliseconds
> > > 56 <= EPP <= 79 : HWP servo loop time 4 milliseconds
> > > 80 <= EPP <= 133 : HWP servo loop time 5 milliseconds
> > > 134 <= EPP <= 143 : HWP servo loop time 6 milliseconds
> > > 144 <= EPP <= 154 : HWP servo loop time 7 milliseconds
> > > 155 <= EPP <= 175 : HWP servo loop time 8 milliseconds
> > > 176 <= EPP <= 255 : HWP servo loop time 9 milliseconds
> > >
> > > If there are other system response differences within
> > > those groups, I haven't been able to detect them,
> > > but would be grateful for any further insight.
> > >
> > > Otherwise, in future, I do not see a need to test anything
> > > other than 9 values of EPP, one from each group.
> > >
> > > > then there is a possibility that the
> > > > CPU frequency will drop significantly and will take an excessive
> > > > amount of time to recover.
> > > > Frequency step ups are exactly on 5.0 millisecond boundaries +/-
> > > > the short gap time.
> > > >
> > > > . The probability is somewhat inconsistent and a function of
> > > > whatever else the computer is doing.
> > > > . The time to recover is a function of EPP, and if EPP is low
> > > > enough my test never fails.
> > > > . These tests were all done with default settings.
> > > > . The "5.0" mSec is only for those default settings, it actually
> > > > depends on EPP.
> > > >   . Crude step boundaries, mSec: EPP=32, 2; EPP=64, 4; EPP=128,
> > > > 5.00; EPP=196, 9
> > >
> > > Now fully understood, as listed above.
> > >
> > > > . High level: i5-9600K: 2453 tests, 60 failures, 2.45% fail rate.
> > > > (HWP - powersave)
> > > > . High level: i5-6200U: 4134 tests, 128 failures, 3.1% fail rate.
> > > > (HWP - powersave)
> > > > . Low level (capture waveforms): i5-9600K: 1842 captured failure
> > > > waveforms. See graph.
> > > > . Low level (capture waveforms): i5-6200U: 458 captured failure
> > > > waveforms. See graph.
> > > > . Verify acpi-cpufreq/ondemand works fine: i5-9600K: 8975 tests.
> > > > 0 failures.
> > > > . Verify acpi-cpufreq/ondemand works fine: i5-6200U: 8575 tests.
> > > > 0 failures.
> > >
> > > The tests were all done using the teo idle governor.
> > > While the menu governor does not fail for this particular test, it
> > > fails
> > > in other scenarios.
> > >
> > > I have yet to find a failure scenario when idle state 2 is
> > > disabled.
> > > I have captured and analyzed about 400 megabytes of trace data,
> > > and have not been able to isolate an exact correlation.
> > >
> > > > The short gap was 842 uSeconds for all these tests, and for no
> > > > particular reason.
> > > >
> > > > While I have not re-done the bounds investigation, I have no
> > > > reason to doubt
> > > > my previous work, re-stated below:
> > > >
> > > > > Gap definition:
> > > > > lower limit not known, but < 747 uSeconds.
> > > > > Upper limit is between 952 and 955 uSeconds (there will be some
> > > > > overhead uncertainties).
> > >
> > > The only new information I have is that the upper bound is bigger.
> > >
> > > > > Must be preceded by busy time spanning a couple of HWP sampling
> > > > > boundaries
> > > > > or jiffy boundaries or something (I don't actually know how HWP
> > > > > does stuff).
> > > >
> > > > Rather than point to graphs, which nobody seems to look at, they
> > > > are attached,
> > > > and so might get striped for some of you.
> > > >
> > > > ... Doug
> > > >
> > > > Addendum: Some of the MSRs you have requested in the past:
> > > >
> > > > i5-9600K (HWP - powersave after test):
> > > >
> > > > root@s18:/home/doug# /home/doug/c/msr-decoder
> > > > 8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :   8 :   8 :   8 :   8
> > > > :   8 :   8 :
> > > > B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
> > > > 1.) 0x19C: IA32_THERM_STATUS: 88480000
> > > > 2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination
> > > > enabled OOB Bit 8 reset OOB Bit 18
> > > > reset
> > > > 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88460000
> > > > 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
> > > > A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : EEO disable :
> > > > RHO disable
> > > > 5.) 0x771: IA32_HWP_CAPABILITIES (performance): 108252E : high 46
> > > > : guaranteed 37 : efficient 8 :
> > > > lowest 1
> > > > 6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
> > > >     raw: 80002E08 : 80002E08 : 80002E08 : 80002E08 : 80002E08 :
> > > > 80002E08 :
> > > >     min:        8 :        8 :        8 :        8 :        8
> > > > :        8 :
> > > >     max:       46 :       46 :       46 :       46 :       46
> > > > :       46 :
> > > >     des:        0 :        0 :        0 :        0 :        0
> > > > :        0 :
> > > >     epp:      128 :      128 :      128 :      128 :      128
> > > > :      128 :
> > > >     act:        0 :        0 :        0 :        0 :        0
> > > > :        0 :
> > > > 7.) 0x777: IA32_HWP_STATUS: 0 : high 0 : guaranteed 0 : efficient
> > > > 0 : lowest 0
> > > >
> > > > i5-9600K (no HWP - acpi-cpufreq/ondemand after test):
> > > >
> > > > root@s18:/home/doug/c# /home/doug/c/msr-decoder
> > > > 8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :   8 :   8 :   8 :   8
> > > > :   8 :   8 :
> > > > B.) 0x770: IA32_PM_ENABLE: 0 : HWP disable
> > > > 9.) 0x199: IA32_PERF_CTL        : CPU 0-5 :   8 :   8 :   8 :   8
> > > > :   8 :   8 :
> > > > C.) 0x1B0: IA32_ENERGY_PERF_BIAS: CPU 0-5 :   6 :   6 :   6 :   6
> > > > :   6 :   6 :
> > > > 1.) 0x19C: IA32_THERM_STATUS: 88480000
> > > > 2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination
> > > > enabled OOB Bit 8 reset OOB Bit 18
> > > > reset
> > > > 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88460000
> > > > 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
> > > > A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : EEO disable :
> > > > RHO disable
> > > >
> > > > i5-6200U (HWP - powersave after test):
> > > >
> > > > 8.) 0x198: IA32_PERF_STATUS : CPU 0-3 : 19 : 19 : 19 : 19 :
> > > > B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
> > > > 1.) 0x19C: IA32_THERM_STATUS: 88430000
> > > > 2.) 0x1AA: MSR_MISC_PWR_MGMT: 4018C0 EIST enabled Coordination
> > > > enabled OOB Bit 8 reset OOB Bit 18
> > > > reset
> > > > 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88420000
> > > > 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
> > > > A.) 0x1FC: MSR_POWER_CTL: 24005D : C1E disable : EEO enable : RHO
> > > > enable
> > > > 5.) 0x771: IA32_HWP_CAPABILITIES (performance): 105171C : high 28
> > > > : guaranteed 23 : efficient 5 :
> > > > lowest 1
> > > > 6.) 0x774: IA32_HWP_REQUEST: CPU 0-3 :
> > > >     raw: 80001B04 : 80001B04 : 80001B04 : 80001B04 :
> > > >     min:        4 :        4 :        4 :        4 :
> > > >     max:       27 :       27 :       27 :       27 :
> > > >     des:        0 :        0 :        0 :        0 :
> > > >     epp:      128 :      128 :      128 :      128 :
> > > >     act:        0 :        0 :        0 :        0 :
> > > > 7.) 0x777: IA32_HWP_STATUS: 4 : high 4 : guaranteed 0 : efficient
> > > > 0 : lowest 0
> > > >
> > > > i5-6200U (no HWP - acpi-cpufreq/ondemand after test):
> > > >
> > > > 8.) 0x198: IA32_PERF_STATUS     : CPU 0-3 :  23 :  23 :  23 :  23
> > > > :
> > > > B.) 0x770: IA32_PM_ENABLE: 0 : HWP disable
> > > > 9.) 0x199: IA32_PERF_CTL        : CPU 0-3 :  11 :   5 :   5 :   5
> > > > :
> > > > C.) 0x1B0: IA32_ENERGY_PERF_BIAS: CPU 0-3 :   6 :   6 :   6 :   6
> > > > :
> > > > 1.) 0x19C: IA32_THERM_STATUS: 88440000
> > > > 2.) 0x1AA: MSR_MISC_PWR_MGMT: 4018C0 EIST enabled Coordination
> > > > enabled OOB Bit 8 reset OOB Bit 18
> > > > reset
> > > > 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88430000
> > > > 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
> > > > A.) 0x1FC: MSR_POWER_CTL: 24005D : C1E disable : EEO enable : RHO
> > > > enable
> >
> >

