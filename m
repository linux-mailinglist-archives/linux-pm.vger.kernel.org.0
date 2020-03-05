Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFF4C17A369
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2020 11:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgCEKul (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Mar 2020 05:50:41 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50115 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgCEKul (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Mar 2020 05:50:41 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200305105039euoutp026dc0b5f2ddb8f3b1a1f61ad155095d51~5YtuxHSy43029330293euoutp02w
        for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2020 10:50:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200305105039euoutp026dc0b5f2ddb8f3b1a1f61ad155095d51~5YtuxHSy43029330293euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583405439;
        bh=m2DocWs0W8JqOXw8iNUMgfIuTJQ+ltmeE/y33yJH1qs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KcDduG/kOvuxBhySV9SHyMz1eOgP2RAYE/ltX9Lo3X9bzncqqUwEyODcQUCgmdi48
         HSUGztdpFcX+tAXDFrB1V7uOi2Qzj2fe2c2RQ71a1KmSC9slWCp0OK1iTAhkvm67D2
         bMWgnHQ0RXSQ7ttdlOnSCi9OnpjI+eM5dxyYAPtQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200305105039eucas1p203880c199ebd7fe505b7150d6e920c93~5YtuXpg0X2482924829eucas1p2g;
        Thu,  5 Mar 2020 10:50:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 38.08.60698.F79D06E5; Thu,  5
        Mar 2020 10:50:39 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200305105038eucas1p1bad0e1bd4b12a28e05ecd14615b31af2~5YttzfQdF0864108641eucas1p1X;
        Thu,  5 Mar 2020 10:50:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200305105038eusmtrp2293aebd793446f18650cf15100b6f18e~5YttyeWWO3251632516eusmtrp2W;
        Thu,  5 Mar 2020 10:50:38 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-ac-5e60d97fabb7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D3.C9.07950.E79D06E5; Thu,  5
        Mar 2020 10:50:38 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200305105038eusmtip28725bfdfc615a30a4d6530520ef8c01e~5YttLinjx1192311923eusmtip2b;
        Thu,  5 Mar 2020 10:50:37 +0000 (GMT)
Subject: Re: [PATCH] Default enable RCU list lockdep debugging with
 PROVE_RCU
To:     madhuparnabhowmik10@gmail.com, paulmck@kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, Amol Grover <frextrite@gmail.com>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <59f5554c-3343-7bf6-d7d8-bba53710afae@samsung.com>
Date:   Thu, 5 Mar 2020 11:50:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228092451.10455-1-madhuparnabhowmik10@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djP87r1NxPiDDqm81tsnLGe1WLRl1Ns
        FlPX7mayWNagavF/Qb7F+fMb2C0u75rDZvG59wijxYzz+5gs+nZ9YrbYfPYMs8WnJd9YLPZ1
        PGBy4PVYevoNm8fOWXfZPVr23WL3WPjpK6vHrde2HptWdbJ59G1ZxejxeZNcAEcUl01Kak5m
        WWqRvl0CV8bu8z9ZCm40MFbMnfaNrYFxRUEXIyeHhICJxMRtS1m7GLk4hARWMEps6NzNCOF8
        YZRY/eMcE4TzmVFi04mHjDAtzTdnQVUtZ5T4cq+dHcJ5yyjRMmEBUIaDQ1jAX2LCEhuQuIjA
        VkaJuX+/gI1iFpjGJPFwzXuwUWwChhJdb7vYQGxeATuJizd/sYLYLAIqEhPaP4HFRQViJWav
        PMwCUSMocXLmEzCbU8BZYv/TlWD1zALyEs1bZzND2OISt57MB1smIfCRXeLfpm5WkIskBFwk
        jszngXhBWOLV8S3sELaMxP+dMPXNjBIPz61lh3B6GCUuN82Aetpa4s65X2wgg5gFNCXW79KH
        CDtKzJv5lBFiPp/EjbeCEDfwSUzaNp0ZIswr0dEmBFGtJjHr+Dq4tQcvXGKewKg0C8lns5B8
        MwvJN7MQ9i5gZFnFKJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kRmNxO/zv+dQfjvj9JhxgF
        OBiVeHhfTI2PE2JNLCuuzD3EKMHBrCTCK2wKFOJNSaysSi3Kjy8qzUktPsQozcGiJM5rvOhl
        rJBAemJJanZqakFqEUyWiYNTqoHRu/X/X8b9N/fduKvD+jYu78ICgese7ZIMp4wKr3m9r+o2
        0Pm/54+L2IywngdBvxl88tY8eVJwYoX1/VOTJswSvff4v2Jph1Plq9rUq3Xn/N+lcKS6blSo
        F9V5amwgVbnhI/eqZvb8ENegjKq/B0SthKSEpK5H7sifaaSU+e5FvO4xfs4TklpKLMUZiYZa
        zEXFiQD3/lIdagMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsVy+t/xe7p1NxPiDHruKlpsnLGe1WLRl1Ns
        FlPX7mayWNagavF/Qb7F+fMb2C0u75rDZvG59wijxYzz+5gs+nZ9YrbYfPYMs8WnJd9YLPZ1
        PGBy4PVYevoNm8fOWXfZPVr23WL3WPjpK6vHrde2HptWdbJ59G1ZxejxeZNcAEeUnk1RfmlJ
        qkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbu8z9ZCm40MFbM
        nfaNrYFxRUEXIyeHhICJRPPNWYxdjFwcQgJLGSW+PDnLApGQkTg5rYEVwhaW+HOtiw2i6DWj
        xMlnJ9lAEsICvhJXz/1jAUmICGxllHh/8jNYgllgBpPEpT+qILaQgJPEpF9TwCaxCRhKdL3t
        AqvhFbCTuHjzF1icRUBFYkL7J7C4qECsxI2ZHUwQNYISJ2c+AbuIU8BZYv/TlawQ880k5m1+
        yAxhy0s0b50NZYtL3Hoyn2kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV5
        6XrJ+bmbGIHRvO3Yzy07GLveBR9iFOBgVOLhXWCeECfEmlhWXJl7iFGCg1lJhFfYND5OiDcl
        sbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OBiSavJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJ
        anZqakFqEUwfEwenVANjqq7vRG2VxNI32xI9duyWOdQV1jNFsu/QR5c5vb3SPS9sFAzu+7Zt
        mfTvbJfojVmz76i/jvyf+tROY0W12pVY3QXJm30PyOlkTGl/0f9q2yKrCe+4l+ZHcJe7JMu6
        fn4lHjVh3ZGgjFMv62pn/D8cPlFAfLWf/cklyc66nKpli+cnzVpbzH9FiaU4I9FQi7moOBEA
        naMhBfwCAAA=
X-CMS-MailID: 20200305105038eucas1p1bad0e1bd4b12a28e05ecd14615b31af2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200305105038eucas1p1bad0e1bd4b12a28e05ecd14615b31af2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200305105038eucas1p1bad0e1bd4b12a28e05ecd14615b31af2
References: <20200228092451.10455-1-madhuparnabhowmik10@gmail.com>
        <CGME20200305105038eucas1p1bad0e1bd4b12a28e05ecd14615b31af2@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear All,

On 28.02.2020 10:24, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>
> This patch default enables CONFIG_PROVE_RCU_LIST option with
> CONFIG_PROVE_RCU for RCU list lockdep debugging.
>
> With this change, RCU list lockdep debugging will be default
> enabled in CONFIG_PROVE_RCU=y kernels.
>
> Most of the RCU users (in core kernel/, drivers/, and net/
> subsystem) have already been modified to include lockdep
> expressions hence RCU list debugging can be enabled by
> default.
>
> However, there are still chances of enountering
> false-positive lockdep splats because not everything is converted,
> in case RCU list primitives are used in non-RCU read-side critical
> section but under the protection of a lock. It would be okay to
> have a few false-positives, as long as bugs are identified, since this
> patch only affects debugging kernels.
>
> Co-developed-by: Amol Grover <frextrite@gmail.com>
> Signed-off-by: Amol Grover <frextrite@gmail.com>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

This patch landed in today's linux-next (20200305) as commit 
c9af03c14bfdfd21515e556c3a90ffe2aadc964d. It causes the following kernel 
warning during system suspend/resume cycle on all ARM 32bit Samsung 
Exynos-based boards (kernel compiled from exynos_defconfig):

# rtcwake -s 10 -m mem
rtcwake: wakeup from "mem" using /dev/rtc0 at Sat Jan  1 00:01:13 2000
PM: suspend entry (deep)
Filesystems sync: 0.008 seconds
Freezing user space processes ... (elapsed 0.003 seconds) done.
OOM killer disabled.
Freezing remaining freezable tasks ... (elapsed 0.013 seconds) done.
printk: Suspending console(s) (use no_console_suspend to debug)

=============================
WARNING: suspicious RCU usage
5.6.0-rc1-00177-gc9af03c14bfd #7728 Not tainted
-----------------------------
drivers/base/power/main.c:326 RCU-list traversed in non-reader section!!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
5 locks held by rtcwake/1452:
  #0: edba7270 (sb_writers#7){.+.+}, at: vfs_write+0x16c/0x180
  #1: ece71f44 (&of->mutex){+.+.}, at: kernfs_fop_write+0xd0/0x228
  #2: eda72008 (kn->count#98){.+.+}, at: kernfs_fop_write+0xd8/0x228
  #3: c121223c (system_transition_mutex){+.+.}, at: pm_suspend+0xc0/0x480
  #4: c1285d98 (device_links_srcu){....}, at: 
device_links_read_lock+0x0/0x50

stack backtrace:
CPU: 7 PID: 1452 Comm: rtcwake Not tainted 5.6.0-rc1-00177-gc9af03c14bfd 
#7728
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c0112710>] (unwind_backtrace) from [<c010e1f4>] (show_stack+0x10/0x14)
[<c010e1f4>] (show_stack) from [<c0b5c50c>] (dump_stack+0xb4/0xe0)
[<c0b5c50c>] (dump_stack) from [<c061ea2c>] 
(dpm_wait_for_subordinate+0xf4/0xfc)
[<c061ea2c>] (dpm_wait_for_subordinate) from [<c061f578>] 
(__device_suspend+0x20/0x838)
[<c061f578>] (__device_suspend) from [<c0622e1c>] (dpm_suspend+0x188/0x57c)
[<c0622e1c>] (dpm_suspend) from [<c0623bfc>] (dpm_suspend_start+0x98/0xa0)
[<c0623bfc>] (dpm_suspend_start) from [<c0197e20>] 
(suspend_devices_and_enter+0xec/0xc74)
[<c0197e20>] (suspend_devices_and_enter) from [<c0198da0>] 
(pm_suspend+0x3f8/0x480)
[<c0198da0>] (pm_suspend) from [<c019696c>] (state_store+0x6c/0xc8)
[<c019696c>] (state_store) from [<c0356c78>] (kernfs_fop_write+0x10c/0x228)
[<c0356c78>] (kernfs_fop_write) from [<c02b52c8>] (__vfs_write+0x30/0x1d0)
[<c02b52c8>] (__vfs_write) from [<c02b8264>] (vfs_write+0xa4/0x180)
[<c02b8264>] (vfs_write) from [<c02b84c0>] (ksys_write+0x60/0xd8)
[<c02b84c0>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
Exception stack(0xeac89fa8 to 0xeac89ff0)
9fa0:                   00000004 0002b440 00000004 0002b440 00000004 
00000000
9fc0: 00000004 0002b440 000291b0 00000004 0002b440 00000004 be980bfc 
00028160
9fe0: 0000006c be980ac8 b6eae000 b6f0b634

=============================
WARNING: suspicious RCU usage
5.6.0-rc1-00177-gc9af03c14bfd #7728 Not tainted
-----------------------------
drivers/base/power/main.c:1698 RCU-list traversed in non-reader section!!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
6 locks held by rtcwake/1452:
  #0: edba7270 (sb_writers#7){.+.+}, at: vfs_write+0x16c/0x180
  #1: ece71f44 (&of->mutex){+.+.}, at: kernfs_fop_write+0xd0/0x228
  #2: eda72008 (kn->count#98){.+.+}, at: kernfs_fop_write+0xd8/0x228
  #3: c121223c (system_transition_mutex){+.+.}, at: pm_suspend+0xc0/0x480
  #4: ebecd984 (&dev->mutex){....}, at: __device_suspend+0xf8/0x838
  #5: c1285d98 (device_links_srcu){....}, at: 
device_links_read_lock+0x0/0x50

stack backtrace:
CPU: 7 PID: 1452 Comm: rtcwake Not tainted 5.6.0-rc1-00177-gc9af03c14bfd 
#7728
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c0112710>] (unwind_backtrace) from [<c010e1f4>] (show_stack+0x10/0x14)
[<c010e1f4>] (show_stack) from [<c0b5c50c>] (dump_stack+0xb4/0xe0)
[<c0b5c50c>] (dump_stack) from [<c061f8bc>] (__device_suspend+0x364/0x838)
[<c061f8bc>] (__device_suspend) from [<c0622e1c>] (dpm_suspend+0x188/0x57c)
[<c0622e1c>] (dpm_suspend) from [<c0623bfc>] (dpm_suspend_start+0x98/0xa0)
[<c0623bfc>] (dpm_suspend_start) from [<c0197e20>] 
(suspend_devices_and_enter+0xec/0xc74)
[<c0197e20>] (suspend_devices_and_enter) from [<c0198da0>] 
(pm_suspend+0x3f8/0x480)
[<c0198da0>] (pm_suspend) from [<c019696c>] (state_store+0x6c/0xc8)
[<c019696c>] (state_store) from [<c0356c78>] (kernfs_fop_write+0x10c/0x228)
[<c0356c78>] (kernfs_fop_write) from [<c02b52c8>] (__vfs_write+0x30/0x1d0)
[<c02b52c8>] (__vfs_write) from [<c02b8264>] (vfs_write+0xa4/0x180)
[<c02b8264>] (vfs_write) from [<c02b84c0>] (ksys_write+0x60/0xd8)
[<c02b84c0>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
Exception stack(0xeac89fa8 to 0xeac89ff0)
9fa0:                   00000004 0002b440 00000004 0002b440 00000004 
00000000
9fc0: 00000004 0002b440 000291b0 00000004 0002b440 00000004 be980bfc 
00028160
9fe0: 0000006c be980ac8 b6eae000 b6f0b634
wake enabled for irq 160
wake enabled for irq 164
samsung-pinctrl 13400000.pinctrl: Setting external wakeup interrupt 
mask: 0xffffffe7

=============================
WARNING: suspicious RCU usage
5.6.0-rc1-00177-gc9af03c14bfd #7728 Not tainted
-----------------------------
drivers/base/power/wakeup.c:408 RCU-list traversed in non-reader section!!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
5 locks held by rtcwake/1452:
  #0: edba7270 (sb_writers#7){.+.+}, at: vfs_write+0x16c/0x180
  #1: ece71f44 (&of->mutex){+.+.}, at: kernfs_fop_write+0xd0/0x228
  #2: eda72008 (kn->count#98){.+.+}, at: kernfs_fop_write+0xd8/0x228
  #3: c121223c (system_transition_mutex){+.+.}, at: pm_suspend+0xc0/0x480
  #4: c128722c (wakeup_srcu){....}, at: 
device_wakeup_arm_wake_irqs+0x0/0x124

stack backtrace:
CPU: 5 PID: 1452 Comm: rtcwake Not tainted 5.6.0-rc1-00177-gc9af03c14bfd 
#7728
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c0112710>] (unwind_backtrace) from [<c010e1f4>] (show_stack+0x10/0x14)
[<c010e1f4>] (show_stack) from [<c0b5c50c>] (dump_stack+0xb4/0xe0)
[<c0b5c50c>] (dump_stack) from [<c0625740>] 
(device_wakeup_arm_wake_irqs+0xdc/0x124)
[<c0625740>] (device_wakeup_arm_wake_irqs) from [<c0622120>] 
(dpm_suspend_noirq+0x1c/0x5a0)
[<c0622120>] (dpm_suspend_noirq) from [<c019805c>] 
(suspend_devices_and_enter+0x328/0xc74)
[<c019805c>] (suspend_devices_and_enter) from [<c0198da0>] 
(pm_suspend+0x3f8/0x480)
[<c0198da0>] (pm_suspend) from [<c019696c>] (state_store+0x6c/0xc8)
[<c019696c>] (state_store) from [<c0356c78>] (kernfs_fop_write+0x10c/0x228)
[<c0356c78>] (kernfs_fop_write) from [<c02b52c8>] (__vfs_write+0x30/0x1d0)
[<c02b52c8>] (__vfs_write) from [<c02b8264>] (vfs_write+0xa4/0x180)
[<c02b8264>] (vfs_write) from [<c02b84c0>] (ksys_write+0x60/0xd8)
[<c02b84c0>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
Exception stack(0xeac89fa8 to 0xeac89ff0)
9fa0:                   00000004 0002b440 00000004 0002b440 00000004 
00000000
9fc0: 00000004 0002b440 000291b0 00000004 0002b440 00000004 be980bfc 
00028160
9fe0: 0000006c be980ac8 b6eae000 b6f0b634

=============================
WARNING: suspicious RCU usage
5.6.0-rc1-00177-gc9af03c14bfd #7728 Not tainted
-----------------------------
drivers/base/power/main.c:1238 RCU-list traversed in non-reader section!!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
5 locks held by rtcwake/1452:
  #0: edba7270 (sb_writers#7){.+.+}, at: vfs_write+0x16c/0x180
  #1: ece71f44 (&of->mutex){+.+.}, at: kernfs_fop_write+0xd0/0x228
  #2: eda72008 (kn->count#98){.+.+}, at: kernfs_fop_write+0xd8/0x228
  #3: c121223c (system_transition_mutex){+.+.}, at: pm_suspend+0xc0/0x480
  #4: c1285d98 (device_links_srcu){....}, at: 
device_links_read_lock+0x0/0x50

stack backtrace:
CPU: 5 PID: 1452 Comm: rtcwake Not tainted 5.6.0-rc1-00177-gc9af03c14bfd 
#7728
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c0112710>] (unwind_backtrace) from [<c010e1f4>] (show_stack+0x10/0x14)
[<c010e1f4>] (show_stack) from [<c0b5c50c>] (dump_stack+0xb4/0xe0)
[<c0b5c50c>] (dump_stack) from [<c06202d4>] 
(__device_suspend_noirq+0x234/0x304)
[<c06202d4>] (__device_suspend_noirq) from [<c0622284>] 
(dpm_suspend_noirq+0x180/0x5a0)
[<c0622284>] (dpm_suspend_noirq) from [<c019805c>] 
(suspend_devices_and_enter+0x328/0xc74)
[<c019805c>] (suspend_devices_and_enter) from [<c0198da0>] 
(pm_suspend+0x3f8/0x480)
[<c0198da0>] (pm_suspend) from [<c019696c>] (state_store+0x6c/0xc8)
[<c019696c>] (state_store) from [<c0356c78>] (kernfs_fop_write+0x10c/0x228)
[<c0356c78>] (kernfs_fop_write) from [<c02b52c8>] (__vfs_write+0x30/0x1d0)
[<c02b52c8>] (__vfs_write) from [<c02b8264>] (vfs_write+0xa4/0x180)
[<c02b8264>] (vfs_write) from [<c02b84c0>] (ksys_write+0x60/0xd8)
[<c02b84c0>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
Exception stack(0xeac89fa8 to 0xeac89ff0)
9fa0:                   00000004 0002b440 00000004 0002b440 00000004 
00000000
9fc0: 00000004 0002b440 000291b0 00000004 0002b440 00000004 be980bfc 
00028160
9fe0: 0000006c be980ac8 b6eae000 b6f0b634
Disabling non-boot CPUs ...
IRQ 51: no longer affine to CPU1
IRQ 52: no longer affine to CPU2
IRQ 53: no longer affine to CPU3
IRQ 54: no longer affine to CPU4
IRQ 55: no longer affine to CPU5
IRQ 56: no longer affine to CPU6
IRQ 57: no longer affine to CPU7
Enabling non-boot CPUs ...
CPU1 is up
CPU2 is up
CPU3 is up
CPU4: detected I-Cache line size mismatch, workaround enabled
CPU4 is up
CPU5: detected I-Cache line size mismatch, workaround enabled
CPU5 is up
CPU6: detected I-Cache line size mismatch, workaround enabled
CPU6 is up
CPU7: detected I-Cache line size mismatch, workaround enabled
CPU7 is up

=============================
WARNING: suspicious RCU usage
5.6.0-rc1-00177-gc9af03c14bfd #7728 Not tainted
-----------------------------
drivers/base/power/main.c:269 RCU-list traversed in non-reader section!!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
5 locks held by rtcwake/1452:
  #0: edba7270 (sb_writers#7){.+.+}, at: vfs_write+0x16c/0x180
  #1: ece71f44 (&of->mutex){+.+.}, at: kernfs_fop_write+0xd0/0x228
  #2: eda72008 (kn->count#98){.+.+}, at: kernfs_fop_write+0xd8/0x228
  #3: c121223c (system_transition_mutex){+.+.}, at: pm_suspend+0xc0/0x480
  #4: c1285d98 (device_links_srcu){....}, at: 
device_links_read_lock+0x0/0x50

stack backtrace:
CPU: 0 PID: 1452 Comm: rtcwake Not tainted 5.6.0-rc1-00177-gc9af03c14bfd 
#7728
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c0112710>] (unwind_backtrace) from [<c010e1f4>] (show_stack+0x10/0x14)
[<c010e1f4>] (show_stack) from [<c0b5c50c>] (dump_stack+0xb4/0xe0)
[<c0b5c50c>] (dump_stack) from [<c061ebf0>] 
(dpm_wait_for_superior+0x114/0x12c)
[<c061ebf0>] (dpm_wait_for_superior) from [<c061fe98>] 
(device_resume_noirq+0x74/0x238)
[<c061fe98>] (device_resume_noirq) from [<c0620a34>] 
(dpm_resume_noirq+0x160/0x53c)
[<c0620a34>] (dpm_resume_noirq) from [<c01983c8>] 
(suspend_devices_and_enter+0x694/0xc74)
[<c01983c8>] (suspend_devices_and_enter) from [<c0198da0>] 
(pm_suspend+0x3f8/0x480)
[<c0198da0>] (pm_suspend) from [<c019696c>] (state_store+0x6c/0xc8)
[<c019696c>] (state_store) from [<c0356c78>] (kernfs_fop_write+0x10c/0x228)
[<c0356c78>] (kernfs_fop_write) from [<c02b52c8>] (__vfs_write+0x30/0x1d0)
[<c02b52c8>] (__vfs_write) from [<c02b8264>] (vfs_write+0xa4/0x180)
[<c02b8264>] (vfs_write) from [<c02b84c0>] (ksys_write+0x60/0xd8)
[<c02b84c0>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
Exception stack(0xeac89fa8 to 0xeac89ff0)
9fa0:                   00000004 0002b440 00000004 0002b440 00000004 
00000000
9fc0: 00000004 0002b440 000291b0 00000004 0002b440 00000004 be980bfc 
00028160
9fe0: 0000006c be980ac8 b6eae000 b6f0b634
s3c-i2c 12c80000.i2c: slave address 0x00
s3c-i2c 12c80000.i2c: bus frequency set to 65 KHz

=============================
WARNING: suspicious RCU usage
5.6.0-rc1-00177-gc9af03c14bfd #7728 Not tainted
-----------------------------
drivers/base/power/wakeup.c:424 RCU-list traversed in non-reader section!!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
5 locks held by rtcwake/1452:
  #0: edba7270 (sb_writers#7){.+.+}, at: vfs_write+0x16c/0x180
  #1: ece71f44 (&of->mutex){+.+.}, at: kernfs_fop_write+0xd0/0x228
  #2: eda72008 (kn->count#98){.+.+}, at: kernfs_fop_write+0xd8/0x228
  #3: c121223c (system_transition_mutex){+.+.}, at: pm_suspend+0xc0/0x480
  #4: c128722c (wakeup_srcu){....}, at: 
device_wakeup_disarm_wake_irqs+0x0/0x124

stack backtrace:
CPU: 0 PID: 1452 Comm: rtcwake Not tainted 5.6.0-rc1-00177-gc9af03c14bfd 
#7728
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c0112710>] (unwind_backtrace) from [<c010e1f4>] (show_stack+0x10/0x14)
[<c010e1f4>] (show_stack) from [<c0b5c50c>] (dump_stack+0xb4/0xe0)
[<c0b5c50c>] (dump_stack) from [<c0625864>] 
(device_wakeup_disarm_wake_irqs+0xdc/0x124)
[<c0625864>] (device_wakeup_disarm_wake_irqs) from [<c0620b84>] 
(dpm_resume_noirq+0x2b0/0x53c)
[<c0620b84>] (dpm_resume_noirq) from [<c01983c8>] 
(suspend_devices_and_enter+0x694/0xc74)
[<c01983c8>] (suspend_devices_and_enter) from [<c0198da0>] 
(pm_suspend+0x3f8/0x480)
[<c0198da0>] (pm_suspend) from [<c019696c>] (state_store+0x6c/0xc8)
[<c019696c>] (state_store) from [<c0356c78>] (kernfs_fop_write+0x10c/0x228)
[<c0356c78>] (kernfs_fop_write) from [<c02b52c8>] (__vfs_write+0x30/0x1d0)
[<c02b52c8>] (__vfs_write) from [<c02b8264>] (vfs_write+0xa4/0x180)
[<c02b8264>] (vfs_write) from [<c02b84c0>] (ksys_write+0x60/0xd8)
[<c02b84c0>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
Exception stack(0xeac89fa8 to 0xeac89ff0)
9fa0:                   00000004 0002b440 00000004 0002b440 00000004 
00000000
9fc0: 00000004 0002b440 000291b0 00000004 0002b440 00000004 be980bfc 
00028160
9fe0: 0000006c be980ac8 b6eae000 b6f0b634

I can help debugging this issue.

> ---
>   kernel/rcu/Kconfig.debug | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> index 4aa02eee8f6c..ec4bb6c09048 100644
> --- a/kernel/rcu/Kconfig.debug
> +++ b/kernel/rcu/Kconfig.debug
> @@ -9,15 +9,10 @@ config PROVE_RCU
>   	def_bool PROVE_LOCKING
>   
>   config PROVE_RCU_LIST
> -	bool "RCU list lockdep debugging"
> -	depends on PROVE_RCU && RCU_EXPERT
> -	default n
> +	def_bool PROVE_RCU
>   	help
> -	  Enable RCU lockdep checking for list usages. By default it is
> -	  turned off since there are several list RCU users that still
> -	  need to be converted to pass a lockdep expression. To prevent
> -	  false-positive splats, we keep it default disabled but once all
> -	  users are converted, we can remove this config option.
> +	  Enable RCU lockdep checking for list usages. It is default
> +	  enabled with CONFIG_PROVE_RCU.
>   
>   config TORTURE_TEST
>   	tristate

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

