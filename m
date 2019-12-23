Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C30129272
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2019 08:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbfLWHr1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Dec 2019 02:47:27 -0500
Received: from cmta18.telus.net ([209.171.16.91]:52828 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfLWHr0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Dec 2019 02:47:26 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id jIQvigyuAgu2QjIQwi7ZIf; Mon, 23 Dec 2019 00:47:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1577087243; bh=Jwgvbo2U0qvOJ93hl0IUKtykoHW9JqN+wX2qOdwH8Ck=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=atoawWD3g1EFWdhUpjQlAmMEY/KZtDoP8PpeV3CEt9cunTw+2c/m/I+LR/7SRpibc
         Oe590VVc6I65pPMg4L5fGmU7v0uy8gdfwC2RRdJ9jvPUrgWcv21fQSR+wGPI6CWcuk
         4ooI6SS2h7NJpXrNjW0/o8eCY9EwWlEFMCo/kFsFtihuDTQMG+xYIubdLYh0R5e/T2
         jDSp/2au70uyLNxSVN3mniNmUF+FxjLCiB4Pq5D/2ErmlMFlhZYtK9GE+nymRRZPkN
         RO+yuRJ2cS2bVVa71xBHkRFp2QPDRV3K3jTQKwQ5vF7SYyyVsP1UAQ0EZzpLQzxAAJ
         Z8duWUVl+cu4w==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=QIcWuTDL c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=FGbulvE0AAAA:8 a=97DWnaIJ-xXPV0tYBjcA:9
 a=yO5PLp8mKzlI0jgp:21 a=qNIUBZJt_dAcIzSL:21 a=QEXdDO2ut3YA:10
 a=-iX3Hlif3BsA:10 a=svzTaB3SJmTkU8mK-ULk:22
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Qais Yousef'" <qais.yousef@arm.com>
Cc:     "'Giovanni Gherdovich'" <ggherdovich@suse.cz>, <x86@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Mel Gorman'" <mgorman@techsingularity.net>,
        "'Matt Fleming'" <matt@codeblueprint.co.uk>,
        "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Juri Lelli'" <juri.lelli@redhat.com>,
        "'Paul Turner'" <pjt@google.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Vincent Guittot'" <vincent.guittot@linaro.org>,
        "'Quentin Perret'" <qperret@qperret.net>,
        "'Dietmar Eggemann'" <dietmar.eggemann@arm.com>,
        "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Ingo Molnar'" <mingo@redhat.com>,
        "'Borislav Petkov'" <bp@suse.de>, "'Len Brown'" <lenb@kernel.org>,
        "'Rafael J . Wysocki'" <rjw@rjwysocki.net>
References: <20191113124654.18122-1-ggherdovich@suse.cz> <20191113124654.18122-2-ggherdovich@suse.cz> <000001d5a29b$c944fd70$5bcef850$@net> <1574697961.16378.5.camel@suse.cz> <000801d5a41e$a7fce2c0$f7f6a840$@net> <1574781600.7677.2.camel@suse.cz> <001d01d5a4f4$d96b21b0$8c416510$@net> <003d01d5a63d$f6ab3950$e401abf0$@net> <20191219104813.6fr34qavpaplecoz@e107158-lin>
In-Reply-To: <20191219104813.6fr34qavpaplecoz@e107158-lin>
Subject: RE: [PATCH v4 1/6] x86,sched: Add support for frequency invariance
Date:   Sun, 22 Dec 2019 23:47:16 -0800
Message-ID: <000701d5b965$361b6c60$a2524520$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdW2WdRzAEmdSsEeRaWFEpFfJzpcegCu7A3A
Content-Language: en-ca
X-CMAE-Envelope: MS4wfICamaUgJKJFZSB+OEa/gIupSuooeItkWqTX/mXcvgwl9Vor4lT+ktWAAnKSVdOszOWIGi+kvwAiXh9IEG0SfqUdaCCWk2OpbvhC7GhJCcPP3mZ0wRiU
 wp1w4KrqJJZux1Ey5DL1eDUrBFWwqZAcqNoXfafZuPHTUVwxOvTAvLEMv5EdDWB9YtuPHmU0eY4tI02BF78SW0W5SD5IcIilynhutfx6IeI3Q0M4z5nUJxxM
 1kom94wEYZCecwqDTsgJV+dapMLxuHR5zG2TBCWj1NzSrxaj13r8b1Sfpa2aQUZ4wJmcPU1NXXph1OyMfaUOhLcTrUZvdki9Oi3bJpex//CPXGAG0eHTiVmv
 zh0PspgrmBcFpEtVTPk2pjjol3MDbr9aL8p+UyXZcHzrdrht0DdAiWEw21xJMi8qpJFTDigw80NCdSeQrE3vzZi69TGJJap9Nn/9Ezl8ZbUpXY5OkNw84nCQ
 kkT+uLXNYs81INW7/rk1it62teIZ3yDiRvv8AkldwKFbxCMhUcak6V8gShhmjTAZDAkz+rISMK/h/Q8NhFs3oAJL0emHmbbJG+UVeXqEeMvl32fuAKFqiwOp
 3WfoEMHNjd2Ag3QJg2BL9kW8TtVF6dE38Uh3QCQvUDKsPBE+8vsq2cmRpNBAaUCUkJAMNKkclsyrJZ6UWT1CohEyOXtmHwDall8pStgojjzgfvgZFP7kGmmg
 636okUVg/I1E0owN80OQ4IlRpPLN5ii0UybRoqlfa7ceSVK/AxNMc6HvdB0zfghUwrSWH2isJ2A=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Qais,

Thank you for your follow up.

On 2019.12.19 02:48 Qais Yousef wrote:
> On 11/28/19 14:48, Doug Smythies wrote:
>> Summary: There never was an issue here.
>> 
>> Sorry for the noise of this thread, and the resulting waste of time.
>> 
>> On 2019.11.26 23:33 Doug Smythies wrote:
>>> On 2019.11.26 07:20 Giovanni Gherdovich wrote:
>>>> On Mon, 2019-11-25 at 21:59 -0800, Doug Smythies wrote:
>>>>> [...]
>>>>> The issue with the schedutil governor not working properly in the 5.4 RC series
>>>>> appears to be hardware dependant.
>> 
>> No it 's not.
>> 
>> Issues with my Sandy Bridge, i7-2600K, test computer and kernel 5.4
>> seem to be because it is running an older Ubuntu server version,
>> apparently somewhat dependant on cgroup V1 and their cgmanager package.
>> I am unable to remove the package to test further because I do use VMs
>> that seem to depend on it.
>> 
>> In the kernel configuration when CONFIG_UCLAMP_TASK_GROUP=y
>> the computer behaves as though the new parameter "cpu.uclamp.min"
>> is set to max rather than 0, but I can not prove it.
>
> I just noticed this. This option shouldn't cause any problem, if it does there
> might be a bug that we need to fix.
>
> So cpu.uclamp.min reads 0 but you think it's not taking effect, correct?

Actually, on the i7-2600K older distro test computer, I couldn't find
cpu.uclamp.min to read its setting. However, yes the behaviour of the governor
was as though that value was set to maximum (read on).

>
> In the quotes above I see 5.4 RC, if you haven't tried this against the final
> 5.4 release, do you mind trying to see if you can reproduce? Trying 5.5-rc2
> would be helpful too if 5.4 fails.

My test setup and baseline distribution versions have changed since November,
when I did those tests. However, I was able to rig up a bootable old ssd
and was able to reproduce the issue with kernel 5.5-rc2. More importantly,
I was to reproduce the issue with the current i7-2600K test computer
(Ubuntu server 20.04 development, upgraded version) and kernel 5.5-rc2.
Note that I have access to another i5-9600K based test computer (Ubuntu
server 20.04 development, fresh install), that does not show this issue.

Detail:

If formatting gets messed up in this e-mail, then the content,
and links to more details, is also here:
http://www.smythies.com/~doug/linux/single-threaded/k54regression/qais.html

CPU frequency scaling driver: intel_pstate, in passive (intel-cpufreq) mode.
CPU frequency scaling governor: various.
CPU Idle driver: intel_idle; Governor: teo.

kernels ("stock", "notset" and "nocgv1"):
stock: CONFIG_UCLAMP_TASK_GROUP=y
notset: # CONFIG_UCLAMP_TASK_GROUP is not set
nocgv1: is "stock" booted with "cgroup_no_v1=all" on the grub kernel command line.

Linux s15 5.5.0-rc2-stock #768 SMP PREEMPT Fri Dec 20 16:19:44 PST 2019 x86_64 x86_64 x86_64 GNU/Linux
Linux s18 5.5.0-rc2-notset #769 SMP PREEMPT Fri Dec 20 18:43:59 PST 2019 x86_64 x86_64 x86_64 GNU/Linux

kernel configuration differences:

doug@s15:~/temp-k-git/linux$ scripts/diffconfig /boot/config-5.5.0-rc2-stock /boot/config-5.5.0-rc2-notset
 UCLAMP_TASK_GROUP y -> n
doug@s15:~/temp-k-git/linux$

Test methods used herein are greatly sped up, by switching
to just a couple of PID per seconds samples, instead of
a great many. Also disk I/O is not used, eliminating any
access time related non-repeatability, and saving thrashing
my SSD. Note that several governors had CPU frequency variations
with time, resulting in variability in the PIDs per second number.

There are two tests, the performance metric being
the number of PIDs per second consumed:

test 1:

Dountil terminated:
   launch a null program (uses a new PID per call).
   Wait for it to finish
Enduntil

test 2:

Dountil terminated:
   launch a program with a package of work to do (uses a new PID per call).
   Wait for it to finish
Enduntil

The assumed fastest and master reference test run is using the performance governor
and forcing CPU affinity. All other calculations are relative to this result.

Results:

i7-2600K computer booted with Ubuntu server 16.04.6, test 1 only:

Governor	kernel
		notset	stock			notset
		PID/S ratio	PID/S ratio		PID/S ratio
schedutil	1650 2.4	3935 1.0 FAIL	1645 2.4
ondemand	2787 1.4	2787 1.4		2787 1.4
performance	3925 1.0	3940 1.0		3940 1.0
conservative2545 1.5	2540 1.5		2530 1.6
powersave	1645 2.4	1655 2.4		1650 2.4
reference	3934 1.0	3917 1.0		3950 1.0

i7-2600K computer booted with Ubuntu server 20.04 dev, test 1:

Governor	kernel
		stock			notset		stock		notset	nocgv1
		PID/S ratio		PID/S ratio	PID/S ratio		PID/S ratio	PID/S ratio
schedutil	3310 1.1 FAIL	1455 2.4	3250 1.1 FAIL	1465 2.4	3220 1.1 FAIL
ondemand	2510 1.4		2485 1.4	2495 1.4		2490 1.4	2460 1.4
performance	3333 1.1		3254 1.1	3250 1.1		3360 1.0	3220 1.1
conservative2230 1.6		2260 1.5	2280 1.5		2220 1.6	2230 1.6
powersave	1470 2.4		1455 2.4	1460 2.4		1470 2.4	1450 2.4
reference	3521 1.0		3500 1.0	3526 1.0		3500 1.0	3500 1.0

i7-2600K computer booted with Ubuntu server 20.04 dev, test 2:

Governor	kernel
		stock			notset		nocgv1
		PID/S ratio		PID/S ratio	PID/S ratio
schedutil	405 1.1 FAIL	177 2.4		405 1.1 FAIL
ondemand	371 1.1		371 1.1		371 1.1
performance	408 1.0		405 1.0		405 1.0
conservative362 1.2		365 1.2		365 1.2
powersave	177 2.4		177 2.4		177 2.4
reference	423 1.0		423 1.0		423 1.0

The "nocgv1" (cgroup_no_v1=all) kernel is of particular interest because
now uclamp variables are available:

root@s15:/sys/fs/cgroup/user.slice# echo "+cpu" > cgroup.subtree_control
root@s15:/sys/fs/cgroup/user.slice# cat cgroup.subtree_control
cpu memory pids
root@s15:/sys/fs/cgroup/user.slice# grep . cpu\.uclamp*
cpu.uclamp.max:max
cpu.uclamp.min:0.00

This is repeatable:
To make the schedutil governor respond as expected thereafter
and until the next re-boot, do this:

# echo 0 > cpu.uclamp.min

Attempts to kick the schedutil governor response via
/sys/devices/system/cpu/intel_pstate/max_perf_pct and
/sys/devices/system/cpu/intel_pstate/min_perf_pct didn't.
Other modifications of the cpu.uclamp.min and max variables also
kick the schedutil governor out of whatever state it was in.

This test was done 5 times:

Re-boot to the nocgv1 (stock + cgroup_no_v1=all) kernel.
set the schedutil governor.
launch test 2 and related monitoring tools.
verify performance governor like behavior.
echo 0 > /sys/fs/cgroup/user.slice/cpu.uclamp.min 
verify schedutil governor like behaviour.

... Doug


