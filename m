Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843C424E445
	for <lists+linux-pm@lfdr.de>; Sat, 22 Aug 2020 02:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgHVArM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 20:47:12 -0400
Received: from cmta16.telus.net ([209.171.16.89]:49840 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbgHVArK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Aug 2020 20:47:10 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id 9HgYkzvRm5b7l9HgZkaPn6; Fri, 21 Aug 2020 18:47:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1598057228; bh=Psa7fI7Z3L3lxeYPlncS5NMGLnaW8PNZQHPuQ8gGcvM=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=AnovVmBj5cZaY/dsWCErSoUlUNFwKqxrZgg+sQCwnZFxuB+lTPtVZ0sCR/h75Fxaf
         Iu8+yZRTGbhELG97roWU6XDSi9XBlPC00bWC2pZoxAWYk1AHX7s178s1S+KmquQjLN
         KaWnK72CzwccDsWjsbJJ/5qm3nKof7qjP/9vg+/xrc0x5IHNNW/HBfZjr6upwxUhbu
         biik0SEcN2UUXEuvFi4cGt70nRojEBIhZIlw3XSwo/i2n65VkYSzJ5o17RfmHW92ei
         LFjA3k4ScaHecC3Cjxke3qOlboevPHnKLlq66GDr7JObEf3uK8kc+Rhlxi0A/uiYuW
         DtILc/3ZQkSaA==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=YPHhNiOx c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8
 a=Y7FGJ6OeAZ36y6Ov-ncA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>
Cc:     "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
References: <2283366.Lr8yYYnyev@kreacher>
In-Reply-To: <2283366.Lr8yYYnyev@kreacher>
Subject: RE: [PATCH 0/4] cpufreq: intel_pstate: Address some HWP-related oddities
Date:   Fri, 21 Aug 2020 17:47:05 -0700
Message-ID: <000401d6781d$c33910d0$49ab3270$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdZ3EHA5sccuDNJbQaKe6bdcNjj7fgA8T6rA
Content-Language: en-ca
X-CMAE-Envelope: MS4wfMVlZzu426mFyMmsXVUWyBEA/NOQhZfn/VxzgpsIox71t2ZTuUM1BiQoOfLUprFpzZ6ZAa7n+wsxYlWxteCIHrM1fSIpqQvYWM0ZZK7DLcgZ5BsezGP7
 DfyHSniqIy1ZcE6NWXGXavQ7uRxxvxOatMZKIWG4wSfG7Gs8BhTkqBlLi2CLD1/586fEAj3E7Nu0IL5wz/RtdyjtiagwqsNQW3o6owpFCGQHZvYOsEhc81B2
 ri2Uv2AMo5XzMyG0aqi9vCNO8/Cx0Rfph3Nm7gDihNj8gL8OxUsw2jEHM4k5vKBS
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 2020.08.20 09:35 Rafael J. Wysocki wrote:
> 
> The purpose of this series is to address some peculiarities related to
> taking CPUs offline/online and switching between different operation
> modes with HWP enabled that have become visible after allowing the
> driver to work in the passive mode with HWP enabled in 5.9-rc1 (and
> one that was there earlier, but can be addressed easily after the
> changes madein 5.9-rc1).
> 
> Please refer to the patch changelogs for details.
> 
> For easier testing/review, the series is available from the git branch at:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  intel_pstate-testing

Thanks for that.

There still seems to be a problem with EPP getting messed up.
I have not been able to find the exact spot in the code.

One problem is that EPP can end up as 0, and thereafter stays
at 0. In sysfs terms, it ends up as "performance" and thereafter
stays as "performance". Meanwhile I never modified it, and it started
as "balance_performance".

It happens when changing from active to passive if the governor is performance.
If the governor is not performance things work as expected.

Another problem is that EPP will end up as 128 when changing from passive
to active. This erroneous condition is cleared by changing the governor to
powersave and back to performance. It also doesn't occur the first
time after boot, when booting to intel_cpufreq/performance/HWP.
(confused yet?) The sysfs value is O.K. during this.

Supporting data:
Example 1:

Grub:
GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1 consoleblank=450 msr.allow_writes=on cpuidle.governor=teo"

So I boot to intel_pstate/performance/HWP:

# /home/doug/c/msr-decoder (always edited for only relevant parts)
6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
    raw: 00002E2E : 00002E2E : 00002E2E : 00002E2E : 00002E2E : 00002E2E :
    epp:        0 :        0 :        0 :        0 :        0 :        0 :

# cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_driver
intel_pstate
# cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
performance
# cat  /sys/devices/system/cpu/cpufreq/policy3/energy_performance_preference
balance_performance

# echo passive > /sys/devices/system/cpu/intel_pstate/status

Note: the following results are incorrect:

# cat  /sys/devices/system/cpu/cpufreq/policy3/energy_performance_preference
performance
# echo "ondemand" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
ondemand
# cat  /sys/devices/system/cpu/cpufreq/policy3/energy_performance_preference
performance
# /home/doug/c/msr-decoder
6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
    raw: 00002E08 : 00002E08 : 00002E08 : 00002E0B : 00002E13 : 00002E08 :
    epp:        0 :        0 :        0 :        0 :        0 :        0 :

# echo active > /sys/devices/system/cpu/intel_pstate/status
# cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
performance
# cat  /sys/devices/system/cpu/cpufreq/policy3/energy_performance_preference
performance
# echo "powersave" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
powersave
# cat  /sys/devices/system/cpu/cpufreq/policy3/energy_performance_preference
performance
# cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
powersave
# cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_driver
intel_pstate

Example 2:
Grub:
GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1 consoleblank=450 intel_pstate=passive msr.allow_writes=on cpuidle.governor=teo"

So I boot to intel_cpufreq/performance/HWP:

# /home/doug/c/msr-decoder
6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
    raw: 80002E2E : 80002E2E : 80002E2E : 80002E2E : 80002E2E : 80002E2E :
    epp:      128 :      128 :      128 :      128 :      128 :      128 :

# cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_driver
intel_cpufreq
# cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
performance
# cat /sys/devices/system/cpu/cpufreq/policy3/energy_performance_preference
balance_performance
# echo active > /sys/devices/system/cpu/intel_pstate/status
# cat /sys/devices/system/cpu/cpufreq/policy3/energy_performance_preference
balance_performance
# cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
performance
# cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_driver
intel_pstate
# /home/doug/c/msr-decoder
6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
    raw: 00002E2E : 00002E2E : 00002E2E : 00002E2E : 00002E2E : 00002E2E :
    epp:        0 :        0 :        0 :        0 :        0 :        0 :

# echo passive > /sys/devices/system/cpu/intel_pstate/status
# /home/doug/c/msr-decoder
6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
    raw: 80002E2E : 80002E2E : 80002E2E : 80002E2E : 80002E2E : 80002E2E :
    epp:      128 :      128 :      128 :      128 :      128 :      128 :
# echo active > /sys/devices/system/cpu/intel_pstate/status

Note: the following results are incorrect:

# /home/doug/c/msr-decoder
6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
    raw: 80002E2E : 80002E2E : 80002E2E : 80002E2E : 80002E2E : 80002E2E :
    epp:      128 :      128 :      128 :      128 :      128 :      128 :
# cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
performance
# cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_driver
intel_pstate
# cat /sys/devices/system/cpu/cpufreq/policy3/energy_performance_preference
balance_performance

Note: But the problem can be cleared:

# echo "powersave" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
powersave
# echo "performance" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
performance
# /home/doug/c/msr-decoder
6.) 0x774: IA32_HWP_REQUEST:    CPU 0-5 :
    raw: 00002E2E : 00002E2E : 00002E2E : 00002E2E : 00002E2E : 00002E2E :
    epp:        0 :        0 :        0 :        0 :        0 :        0 :

... Doug


