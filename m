Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D488CD7AA7
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 17:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbfJOP5m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 11:57:42 -0400
Received: from foss.arm.com ([217.140.110.172]:41816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfJOP5m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Oct 2019 11:57:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5124B28;
        Tue, 15 Oct 2019 08:57:41 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BADF23F68E;
        Tue, 15 Oct 2019 08:57:40 -0700 (PDT)
Date:   Tue, 15 Oct 2019 16:57:35 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: NULL pointer dereference in cpufreq_set_policy
Message-ID: <20191015155735.GA29105@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

I was trying to unify Vexpress SPC driver and arm_big_little generic
driver as it's the only user of bL driver and switcher in the mainline.
I did this a while ago(v5.3) and encountered the kernel crash with NULL
pointer reference(crash log with some debug enabled below).

Since dev_pm_qos_* was added in v5.3 with the Commit 18c49926c4bf
("cpufreq: Add QoS requests for userspace constraints"), I just tried
reverting that and it fixed the crash. I haven't spent much time
debugging, since it has been for a while I wanted to report it.

Regards,
Sudeep

Crash Log
-->8

cpufreq: setting new policy for CPU 0: 500000 - 1200000 kHz
cpufreq: new min and max freqs are 500000 - 1200000 kHz
cpufreq: governor switch
cpufreq: cpufreq_init_governor: for CPU 0
cpufreq: cpufreq_start_governor: for CPU 0
cpufreq: target for CPU 0: 1200000 kHz, relation 1, requested 1200000 kHz
cpufreq: __target_index: cpu: 0, oldfreq: 1000000, new freq: 1200000
cpufreq: notification 0 of frequency transition to 1200000 kHz
cpufreq: handle_update for cpu 0 called
cpufreq: notification 1 of frequency transition to 1200000 kHz
cpufreq: FREQ: 1200000 - CPUs: 0-1
cpufreq: governor change
cpufreq: initialization complete
cpufreq: cpufreq_online: bringing CPU1 online
cpufreq: cpufreq_online: bringing CPU2 online
cpu cpu2: ve_spc_cpufreq_init: CPU 2 initialized
cpufreq: setting new policy for CPU 2: 350000 - 1000000 kHz
cpufreq: new min and max freqs are 350000 - 1000000 kHz
cpufreq: governor switch
cpufreq: cpufreq_init_governor: for CPU 2
cpufreq: cpufreq_start_governor: for CPU 2
cpufreq: target for CPU 2: 1000000 kHz, relation 1, requested 1000000 kHz
cpufreq: __target_index: cpu: 2, oldfreq: 800000, new freq: 1000000
cpufreq: notification 0 of frequency transition to 1000000 kHz
cpufreq: handle_update for cpu 2 called
cpufreq: notification 1 of frequency transition to 1000000 kHz
cpufreq: FREQ: 1000000 - CPUs: 2-4
cpufreq: governor change
cpufreq: initialization complete
cpufreq: cpufreq_online: bringing CPU3 online
cpufreq: cpufreq_online: bringing CPU4 online
cpufreq: driver vexpress-spc up and running
vexpress_spc_cpufreq: ve_spc_cpufreq_probe: Registered platform driver: vexpress-spc
cpufreq: updating policy for CPU 2
cpufreq: setting new policy for CPU 2: 350000 - 1000000 kHz
cpufreq: new min and max freqs are 350000 - 1000000 kHz
cpufreq: governor limits update
cpufreq: cpufreq_governor_limits: for CPU 2
cpufreq: target for CPU 2: 1000000 kHz, relation 1, requested 1000000 kHz
cpufreq: updating policy for CPU 0
cpufreq: setting new policy for CPU 0: 500000 - 1200000 kHz
cpufreq: new min and max freqs are 500000 - 1200000 kHz
cpufreq: governor limits update
cpufreq: cpufreq_governor_limits: for CPU 0
cpufreq: target for CPU 0: 1200000 kHz, relation 1, requested 1200000 kHz
big.LITTLE switcher initializing
cpufreq: unregistering driver vexpress-spc
cpufreq: cpufreq_offline: unregistering CPU 0
cpufreq: cpufreq_stop_governor: for CPU 0
cpufreq: cpufreq_start_governor: for CPU 1
cpufreq: target for CPU 1: 1200000 kHz, relation 1, requested 1200000 kHz
cpufreq: cpufreq_offline: unregistering CPU 1
cpufreq: cpufreq_stop_governor: for CPU 1
cpufreq: cpufreq_exit_governor: for CPU 1
cpufreq: last reference is dropped
cpufreq: waiting for dropping of refcount
cpufreq: wait complete
cpufreq: cpufreq_offline: unregistering CPU 2
cpufreq: cpufreq_stop_governor: for CPU 2
cpufreq: cpufreq_start_governor: for CPU 3
cpufreq: target for CPU 3: 1000000 kHz, relation 1, requested 1000000 kHz
cpufreq: cpufreq_offline: unregistering CPU 3
cpufreq: cpufreq_stop_governor: for CPU 3
cpufreq: cpufreq_start_governor: for CPU 4
cpufreq: target for CPU 4: 1000000 kHz, relation 1, requested 1000000 kHz
cpufreq: cpufreq_offline: unregistering CPU 4
cpufreq: cpufreq_stop_governor: for CPU 4
cpufreq: cpufreq_exit_governor: for CPU 4
cpufreq: last reference is dropped
cpufreq: waiting for dropping of refcount
cpufreq: wait complete
CPU0 paired with CPU4
CPU1 paired with CPU3
GIC ID for CPU 0 cluster 0 is 0
GIC ID for CPU 1 cluster 0 is 1
GIC ID for CPU 0 cluster 1 is 2
Offlining CPU 0 cluster 1 ...
cpufreq: handle_update for cpu 1 called
cpufreq: updating policy for CPU 1
cpufreq: setting new policy for CPU 1: 500000 - 1200000 kHz
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 0000001c
pgd = (ptrval)
[0000001c] *pgd=80000080204003, *pmd=00000000
Internal error: Oops: 206 [#1] SMP THUMB2
Modules linked in:
CPU: 0 PID: 34 Comm: kworker/0:1 Not tainted 5.4.0-rc1-00006-g67f5a8081a4b-dirty #86
Hardware name: ARM-Versatile Express
Workqueue: events handle_update
PC is at cpufreq_set_policy+0x58/0x228
LR is at dev_pm_qos_read_value+0x77/0xac
pc : [<c0ae29d4>]    lr : [<c08b56f3>]    psr: 00000173
sp : e61d9dc8  ip : 00124f80  fp : eab71580
r10: 00000000  r9 : c179a324  r8 : 00000000
r7 : eab7a250  r6 : e5076400  r5 : c17f3204  r4 : e61d9de0
r3 : 00000000  r2 : eab7a2cc  r1 : 00000153  r0 : e61d9de0
Flags: nzcv  IRQs on  FIQs off  Mode SVC_32  ISA Thumb  Segment user
Control: 70c5387d  Table: 80203000  DAC: fffffffd
Process kworker/0:1 (pid: 34, stack limit = 0x(ptrval))
Stack: (0xe61d9dc8 to 0xe61da000)
9dc0:                   e61d8000 e5076400 e5076400 eab74700 00000000 c0ae2bdb
9de0: e5076600 00000003 00000000 00000000 00000001 00000000 00124f80 0007a120
9e00: 000f4240 00000000 ffffffff 00124f80 000f4240 00000000 00000000 00000000
9e20: c1779d58 00000000 66726570 616d726f 0065636e 00000000 00000000 e507645c
9e40: e507645c c0ae2c79 e5068580 e506859c 00000000 00000001 00000100 00000122
9e60: e50684c0 e5076484 e5076484 00000000 00000000 c1779bb0 00000000 00000000
9e80: 00000001 00000000 00020002 e50764ac e50764ac 00000001 e60e5640 00000000
9ea0: 00030003 e50764c4 e50764c4 00000000 00000000 00000000 ffffffff 00000000
9ec0: 00000000 00010001 00010001 e50764ec e50764ec 00000000 00000000 00000000
9ee0: 00000000 c0ae0e39 00000000 00000000 c0ae0e1d 00000000 00000000 f29a212c
9f00: c127bdd4 e5076458 e50764b4 c0ae2ca7 e5076458 e6114280 eab71580 c0465111
9f20: ffffe000 eab71580 e61d9f40 e6114280 eab71580 e6114294 c1604d00 eab71598
9f40: ffffe000 00000008 eab71580 c046546f ffffe000 c1604d00 c17999b5 c1159018
9f60: e61d9f78 e619a100 e6116000 00000000 e61d8000 e6114280 c0465371 e60bde9c
9f80: e619a11c c0469f43 00000001 e6116000 c0469e45 00000000 00000000 00000000
9fa0: 00000000 00000000 00000000 c04011e9 00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[<c0ae29d4>] (cpufreq_set_policy) from [<c0ae2bdb>] (refresh_frequency_limits.part.24+0x37/0x48)
[<c0ae2bdb>] (refresh_frequency_limits.part.24) from [<c0ae2ca7>] (handle_update+0x2f/0x38)
[<c0ae2ca7>] (handle_update) from [<c0465111>] (process_one_work+0x16d/0x3cc)
[<c0465111>] (process_one_work) from [<c046546f>] (worker_thread+0xff/0x414)
[<c046546f>] (worker_thread) from [<c0469f43>] (kthread+0xff/0x100)
[<c0469f43>] (kthread) from [<c04011e9>] (ret_from_fork+0x11/0x28)
Exception stack(0xe61d9fb0 to 0xe61d9ff8)
9fa0:                                     00000000 00000000 00000000 00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
Code: fe57 682b 62a0 4620 (69db) 4798
---[ end trace ca670bee3386a225 ]---
