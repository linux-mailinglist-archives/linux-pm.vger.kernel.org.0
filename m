Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6656F113FA3
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 11:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfLEKs1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 05:48:27 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47013 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbfLEKs1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 05:48:27 -0500
Received: from 79.184.254.100.ipv4.supernova.orange.pl (79.184.254.100) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 5b3b4b2c53ae0e89; Thu, 5 Dec 2019 11:48:22 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
Date:   Thu, 05 Dec 2019 11:48:22 +0100
Message-ID: <4087016.QifdzW7851@kreacher>
In-Reply-To: <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com> <DB3PR0402MB3916C8F16045625489E776F4F5460@DB3PR0402MB3916.eurprd04.prod.outlook.com> <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, December 5, 2019 9:53:20 AM CET Anson Huang wrote:
> Hi, Rafael
> 	This issue is very weird, the irq_work used in cpufreq_governor.c is very
> 	simple, ONLY one entry to claim the irq_work, and cpufreq_governor's irq_work
> 	is a private irq_work structure, no other drivers use it. I added some trace
> 	event in cpufreq_governor.c and irq_work.c, every time, the issue happened at
> 	the point of CPU1/2/3 all off, and CPU1 start ON line, but when CPU1 tried to
> 	sync the irq_work in cpufreq_dbs_governor_stop(), the irq_work shows that
> 	previous work is pending on CPU3 which is offline, I also had the trace event
> 	in irq_work_claim(),  but no any log shows the cpufreq_governor irq_work is
> 	claimed on CPU3 after CPU3 offline, below is the debug patch I added and the
> 	log on 2 consoles:
> 	If I understand it correctly, the irq work used in cpufreq_governor ONLY has
> 	one entry of calling irq_work_queue() which will be ONLY claimed on the CPU
> 	calling the irq_work_queue(), but from trace result, I have NOT see where
> 	CPU3 could call irq_work_queue() after it finishes the irq work sync before
> 	offline.

Right.

Which means that this particular irq_work only runs on the CPU that has
run irq_work_queue() for it.

> 	Could it something wrong related to cache maintain during CPU hotplug?

I'm not sure what is going on, but I do agree that it is weird enough. :-)

[cut]

> LOG on console 1 which does CPU1/2/3 offline and online stress test:
> CPUHotplug: 4575 times remaining
> [ 1047.401185] CPU1: shutdown
> [ 1047.403917] psci: CPU1 killed.
> [ 1047.449153] CPU2: shutdown
> [ 1047.451880] psci: CPU2 killed.
> [ 1047.501131] CPU3: shutdown
> [ 1047.503857] psci: CPU3 killed.
> [ 1048.541939] Detected VIPT I-cache on CPU1
> [ 1048.541983] GICv3: CPU1: found redistributor 1 region 0:0x0000000051b20000
> [ 1048.542050] CPU1: Booted secondary processor 0x0000000001 [0x410fd042]
> [ 1048.585024] Detected VIPT I-cache on CPU2
> [ 1048.585061] GICv3: CPU2: found redistributor 2 region 0:0x0000000051b40000
> [ 1048.585121] CPU2: Booted secondary processor 0x0000000002 [0x410fd042]
> [ 1048.645070] Detected VIPT I-cache on CPU3
> [ 1048.645112] GICv3: CPU3: found redistributor 3 region 0:0x0000000051b60000
> [ 1048.645181] CPU3: Booted secondary processor 0x0000000003 [0x410fd042]
> CPUHotplug: 4574 times remaining
> [ 1049.769187] CPU1: shutdown
> [ 1049.771913] psci: CPU1 killed.
> [ 1049.809126] CPU2: shutdown
> [ 1049.811856] psci: CPU2 killed.
> [ 1049.853135] CPU3: shutdown
> [ 1049.855868] psci: CPU3 killed.
> 
> Waiting here forever.....
> 
> LOG on console 2 which enables the trace events I added upper:
>              sed-4591  [003] d..4  1049.705561: cpu_frequency_irq_claim: cpu_id=3, flag=3
>              sed-4591  [003] dNh1  1049.705604: cpu_frequency_irq_run_list: cpu_id=3, flag=0

So here CPU3 runs an IRQ work, presumably the cpufreq governor's one.

After that its raised_list should be empty and it doesn't claim any IRQ works going
forward.

>           <idle>-0     [001] d.s2  1049.716308: cpu_frequency_irq_work: cpu_id=1, cpu=-1
>           <idle>-0     [001] d.s2  1049.716319: cpu_frequency_irq_claim: cpu_id=1, flag=3
>           <idle>-0     [001] dNH2  1049.716338: cpu_frequency_irq_run_list: cpu_id=1, flag=0

And now CPU1 runs the cpufreq governor IRQ work, so it sets work->cpu to 1 and
then to -1 (when flushing raised_list). 

>           <idle>-0     [002] d.s2  1049.728303: cpu_frequency_irq_work: cpu_id=2, cpu=-1
>           <idle>-0     [002] d.s2  1049.728307: cpu_frequency_irq_claim: cpu_id=2, flag=3
>           <idle>-0     [002] dNH2  1049.728320: cpu_frequency_irq_run_list: cpu_id=2, flag=0
>           <idle>-0     [001] d.s2  1049.740305: cpu_frequency_irq_work: cpu_id=1, cpu=-1
>           <idle>-0     [001] d.s2  1049.740307: cpu_frequency_irq_claim: cpu_id=1, flag=3
>           <idle>-0     [001] dNH2  1049.740319: cpu_frequency_irq_run_list: cpu_id=1, flag=0
>           <idle>-0     [001] d.s2  1049.752305: cpu_frequency_irq_work: cpu_id=1, cpu=-1
>           <idle>-0     [001] d.s2  1049.752307: cpu_frequency_irq_claim: cpu_id=1, flag=3
>           <idle>-0     [001] dNH2  1049.752316: cpu_frequency_irq_run_list: cpu_id=1, flag=0
>          cpuhp/1-13    [001] ....  1049.768340: cpu_frequency_irq_work_sync: cpu_id=1, cpu=-1, flag=0
>          cpuhp/1-13    [001] d..4  1049.768681: cpu_frequency_irq_work: cpu_id=1, cpu=-1
>          cpuhp/1-13    [001] d..4  1049.768683: cpu_frequency_irq_claim: cpu_id=1, flag=3
>          cpuhp/1-13    [001] dNh1  1049.768698: cpu_frequency_irq_run_list: cpu_id=1, flag=0
>      smp_test.sh-734   [000] ...1  1049.771903: cpu_frequency_irq_claim: cpu_id=0, flag=7
>      smp_test.sh-734   [000] dNh1  1049.775009: cpu_frequency_irq_run_list: cpu_id=0, flag=4
>      smp_test.sh-734   [000] ...1  1049.776084: cpu_frequency_irq_claim: cpu_id=0, flag=7
>      smp_test.sh-734   [000] dNh.  1049.776392: cpu_frequency_irq_run_list: cpu_id=0, flag=4
>      smp_test.sh-734   [000] d..2  1049.779093: cpu_frequency_irq_work: cpu_id=0, cpu=-1
>      smp_test.sh-734   [000] d..2  1049.779103: cpu_frequency_irq_claim: cpu_id=0, flag=3
>           <idle>-0     [000] dNh2  1049.779162: cpu_frequency_irq_run_list: cpu_id=0, flag=0
>           <idle>-0     [000] d.s2  1049.792305: cpu_frequency_irq_work: cpu_id=0, cpu=-1
>           <idle>-0     [000] d.s2  1049.792315: cpu_frequency_irq_claim: cpu_id=0, flag=3
>           <idle>-0     [000] dNH2  1049.792329: cpu_frequency_irq_run_list: cpu_id=0, flag=0
>          cpuhp/2-18    [002] ....  1049.808315: cpu_frequency_irq_work_sync: cpu_id=2, cpu=-1, flag=0
>          cpuhp/2-18    [002] d..4  1049.808642: cpu_frequency_irq_work: cpu_id=2, cpu=-1
>          cpuhp/2-18    [002] d..4  1049.808645: cpu_frequency_irq_claim: cpu_id=2, flag=3
>          cpuhp/2-18    [002] dNh1  1049.808658: cpu_frequency_irq_run_list: cpu_id=2, flag=0
>      smp_test.sh-734   [000] ...1  1049.811848: cpu_frequency_irq_claim: cpu_id=0, flag=7
>      smp_test.sh-734   [000] dNh1  1049.814949: cpu_frequency_irq_run_list: cpu_id=0, flag=4
>      smp_test.sh-734   [000] ...1  1049.815988: cpu_frequency_irq_claim: cpu_id=0, flag=7
>      smp_test.sh-734   [000] dNh1  1049.816321: cpu_frequency_irq_run_list: cpu_id=0, flag=4
>      smp_test.sh-734   [000] d..3  1049.818936: cpu_frequency_irq_work: cpu_id=0, cpu=-1
>      smp_test.sh-734   [000] d..3  1049.818946: cpu_frequency_irq_claim: cpu_id=0, flag=3
>      smp_test.sh-734   [000] dNh2  1049.818973: cpu_frequency_irq_run_list: cpu_id=0, flag=0
>           <idle>-0     [000] d.s4  1049.832308: cpu_frequency_irq_work: cpu_id=0, cpu=-1
>           <idle>-0     [000] d.s4  1049.832317: cpu_frequency_irq_claim: cpu_id=0, flag=3
>           <idle>-0     [000] dNH3  1049.832332: cpu_frequency_irq_run_list: cpu_id=0, flag=0
>          cpuhp/3-23    [003] ....  1049.852314: cpu_frequency_irq_work_sync: cpu_id=3, cpu=-1, flag=0
> 
> [Anson] when CPU3 offline, the irq work sync is successfully, no irq work pending any more;
> 
>      smp_test.sh-734   [000] ...1  1049.855859: cpu_frequency_irq_claim: cpu_id=0, flag=7
>      smp_test.sh-734   [000] dNh1  1049.858958: cpu_frequency_irq_run_list: cpu_id=0, flag=4
>      smp_test.sh-734   [000] ...1  1049.859990: cpu_frequency_irq_claim: cpu_id=0, flag=7
>      smp_test.sh-734   [000] dNh.  1049.860346: cpu_frequency_irq_run_list: cpu_id=0, flag=4
>           <idle>-0     [001] d.h1  1050.896329: cpu_frequency_irq_run_list: cpu_id=1, flag=4
>          cpuhp/1-13    [001] ....  1050.916319: cpu_frequency_irq_work_sync: cpu_id=1, cpu=3, flag=3
> 
> [Anson] we can see when CPU1 start online and tried to sync irq work, found
> it is pending on CPU3 which is offline, and in this period, no irq work
> claimed by cpufreq_governor, 

So I'm wondering how it is possible at all that work->cpu value is 3 at this
point.

The last CPU that wrote to work->cpu was CPU0 and the written value was -1, and
CPU3 saw that value when it was running irq_work_sync().

There is no sane way by which work->cpu can be equal to 3 from CPU1's perspective,
because the last value written to it by CPU1 itself was -1 and the last value
written to it by any other CPU also was -1.

Moreover, after CPU3 had updated it last time (and the last value written to it
by CPU3 had been -1), other CPUs, *including* CPU1, updated it too (and that
for multiple times).

So the only theory that can explain why CPU1 sees 3 in there when it is going
online appears to be some silent memory corruption.

That said, have you tried to make the READ_ONCE() change suggested a while ago?



