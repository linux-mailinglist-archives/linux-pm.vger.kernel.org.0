Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C10E3F8D2F
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 11:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfKLKsP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 05:48:15 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58672 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfKLKsM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2019 05:48:12 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20191112104810euoutp0218427d3d4d20e457356295134f3e8f90~WZJAzkZih2590525905euoutp02O
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2019 10:48:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20191112104810euoutp0218427d3d4d20e457356295134f3e8f90~WZJAzkZih2590525905euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573555690;
        bh=t8KznA7MRgrnEYRKvcDPTJukI3s+wjik+zG/HLqSrhE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=BlgpjxZKPvpQKov/BRNZTTGrQDQ/CALe4BJGUnP3HTCYxMKdLHCewMcSErYgC7OhK
         lkxA2rAZIPzoEB1kPj3sIEYGaFOg10RTRl3CKjPsUcD9PZWDi4gV4nB1eQ98D3Qz9O
         4rT2wDiBSye7x6Z9UM8jNICJA8NRPyKKsHLMLK2I=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191112104810eucas1p268ae9639c29066621d052902a18533e7~WZJAgxx0h3014730147eucas1p2J;
        Tue, 12 Nov 2019 10:48:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D8.55.04374.9ED8ACD5; Tue, 12
        Nov 2019 10:48:09 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191112104809eucas1p14d5d364021a359861788472b513e43e5~WZJAKlszV0983309833eucas1p1o;
        Tue, 12 Nov 2019 10:48:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191112104809eusmtrp2d07a4e70cace8fc02e31669927b654b4~WZJAJ9p_90713307133eusmtrp2l;
        Tue, 12 Nov 2019 10:48:09 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-27-5dca8de999f1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F4.36.04117.9ED8ACD5; Tue, 12
        Nov 2019 10:48:09 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191112104809eusmtip288c305a2268c9a86e11a8b17ad1701fc~WZI-t-Z1V2537125371eusmtip2w;
        Tue, 12 Nov 2019 10:48:09 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] PM / devfreq: Add missing locking while setting
 suspend_freq
Date:   Tue, 12 Nov 2019 11:47:34 +0100
Message-Id: <20191112104734.31074-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7djPc7ove0/FGmxdYG2xccZ6VovrX56z
        Wpw/v4HdYsXdj6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3+LzhMaPF7cYVbA5cHrMbLrJ4bFrV
        yeax8d0OJo++LasYPT5vkgtgjeKySUnNySxLLdK3S+DKaPyQWDBXpuLdqh72BsYzEl2MnBwS
        AiYSFy8/Y+li5OIQEljBKLF59hd2COcLo8SVX3+ZIJzPjBKrDn1igmmZfvwVVMtyRomtL36z
        wLXMODoPrIpNwFCi620XWxcjB4eIQLzE+q9WIDXMAluYJM7/7mUEqREW8Jd4+vkDO4jNIqAq
        0TW/iRXE5hWwlVh99wgzxDZ5idUbDjCDNEsIvGaT+L1tK9QZLhLz5hxggbCFJV4d38IOYctI
        /N85nwmioZlR4uG5tewQTg+jxOWmGYwQVdYSh49fZAU5j1lAU2L9Ln2IsKPE+tu7wMISAnwS
        N94KgoSZgcxJ26YzQ4R5JTrahCCq1SRmHV8Ht/bghUtQJR4S1z7qgoSFBGIl2s9sZZ3AKDcL
        YdUCRsZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsYgYni9L/jX3cw7vuTdIhRgINRiYeX
        IeFkrBBrYllxZe4hRgkOZiUR3h0VJ2KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ81YzPIgWEkhP
        LEnNTk0tSC2CyTJxcEo1MLYqnhfqe3DOSLh4skPjhYWuB+LvbXOQrmGYqGbq9f12gPnUrvCj
        SVde3Kv4/Dwxmj97wcMZb2ZVXupy6PtheGrL1QZBFfEu+9QnXMaHnk3/Lrjv9nwrL8YSdof5
        IRuqe/Zw+W/zkT29vfrx5Ck8Ly5Efrp+cta9gqn7jN6s/Pe56YVry6ajvJFKLMUZiYZazEXF
        iQBl2CUnEAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsVy+t/xe7ove0/FGkw8qmKxccZ6VovrX56z
        Wpw/v4HdYsXdj6wWl3fNYbP43HuE0WLG+X1MFmuP3GW3+LzhMaPF7cYVbA5cHrMbLrJ4bFrV
        yeax8d0OJo++LasYPT5vkgtgjdKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV
        0rezSUnNySxLLdK3S9DLaPyQWDBXpuLdqh72BsYzEl2MnBwSAiYS04+/Yuli5OIQEljKKLHh
        2D42iISMxMlpDawQtrDEn2tdYHEhgU+MEreWu4PYbAKGEl1vIeIiAokSD3qes4MMYhbYwSTx
        be1ydpCEsICvxJzmN2BFLAKqEl3zm8CG8grYSqy+e4QZYoG8xOoNB5gnMPIsYGRYxSiSWlqc
        m55bbKRXnJhbXJqXrpecn7uJERig24793LKDsetd8CFGAQ5GJR5ehoSTsUKsiWXFlbmHGCU4
        mJVEeHdUnIgV4k1JrKxKLcqPLyrNSS0+xGgKtHwis5Rocj4wevJK4g1NDc0tLA3Njc2NzSyU
        xHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTAy3Jt5/1oqQ0vT6/z+VK8nN1rLFYNC920JmLd0
        /rwJ+yX2Nt3jyWKWYA/aue6eh/eiRkVV53MsSmsMH6adk/kQNCGFv61t/Z1P3a9cDz0IK5F8
        G67M/3f5tL+VizZE+T8NaPh63HmneKBsC+vRsxI7CrYuPJwVYbqrydGa2UZ4szqrtPMBI0Ul
        luKMREMt5qLiRAD23Ue2ZgIAAA==
X-CMS-MailID: 20191112104809eucas1p14d5d364021a359861788472b513e43e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191112104809eucas1p14d5d364021a359861788472b513e43e5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191112104809eucas1p14d5d364021a359861788472b513e43e5
References: <CGME20191112104809eucas1p14d5d364021a359861788472b513e43e5@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 2abb0d5268ae ("PM / devfreq: Lock devfreq in trans_stat_show")
revealed a missing locking while calling devfreq_update_status() function
during suspend/resume cycle.

Code analysis revealed that devfreq_set_target() function was called
without needed locks held for setting device specific suspend_freq if such
has been defined. This patch fixes that by adding the needed locking, what
fixes following kernel warning on Exynos4412-based OdroidU3 board during
system suspend:

PM: suspend entry (deep)
Filesystems sync: 0.002 seconds
Freezing user space processes ... (elapsed 0.001 seconds) done.
OOM killer disabled.
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
------------[ cut here ]------------
WARNING: CPU: 2 PID: 1385 at drivers/devfreq/devfreq.c:204 devfreq_update_status+0xc0/0x188
Modules linked in:
CPU: 2 PID: 1385 Comm: rtcwake Not tainted 5.4.0-rc6-next-20191111 #6848
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[<c0112588>] (unwind_backtrace) from [<c010e070>] (show_stack+0x10/0x14)
[<c010e070>] (show_stack) from [<c0afb010>] (dump_stack+0xb4/0xe0)
[<c0afb010>] (dump_stack) from [<c01272e0>] (__warn+0xf4/0x10c)
[<c01272e0>] (__warn) from [<c01273a8>] (warn_slowpath_fmt+0xb0/0xb8)
[<c01273a8>] (warn_slowpath_fmt) from [<c07d105c>] (devfreq_update_status+0xc0/0x188)
[<c07d105c>] (devfreq_update_status) from [<c07d2d70>] (devfreq_set_target+0xb0/0x15c)
[<c07d2d70>] (devfreq_set_target) from [<c07d3598>] (devfreq_suspend+0x2c/0x64)
[<c07d3598>] (devfreq_suspend) from [<c05de0b0>] (dpm_suspend+0xa4/0x57c)
[<c05de0b0>] (dpm_suspend) from [<c05def74>] (dpm_suspend_start+0x98/0xa0)
[<c05def74>] (dpm_suspend_start) from [<c0195b58>] (suspend_devices_and_enter+0xec/0xc74)
[<c0195b58>] (suspend_devices_and_enter) from [<c0196a20>] (pm_suspend+0x340/0x410)
[<c0196a20>] (pm_suspend) from [<c019480c>] (state_store+0x6c/0xc8)
[<c019480c>] (state_store) from [<c033fc50>] (kernfs_fop_write+0x10c/0x228)
[<c033fc50>] (kernfs_fop_write) from [<c02a6d3c>] (__vfs_write+0x30/0x1d0)
[<c02a6d3c>] (__vfs_write) from [<c02a9afc>] (vfs_write+0xa4/0x180)
[<c02a9afc>] (vfs_write) from [<c02a9d58>] (ksys_write+0x60/0xd8)
[<c02a9d58>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
Exception stack(0xed3d7fa8 to 0xed3d7ff0)
...
irq event stamp: 9667
hardirqs last  enabled at (9679): [<c0b1e7c4>] _raw_spin_unlock_irq+0x20/0x58
hardirqs last disabled at (9698): [<c0b16a20>] __schedule+0xd8/0x818
softirqs last  enabled at (9694): [<c01026fc>] __do_softirq+0x4fc/0x5fc
softirqs last disabled at (9719): [<c012fe68>] irq_exit+0x16c/0x170
---[ end trace 41ac5b57d046bdbc ]---
------------[ cut here ]------------

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/devfreq/devfreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 94fb8e821e12..65a4b6cf3fa5 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -957,7 +957,9 @@ int devfreq_suspend_device(struct devfreq *devfreq)
 	}
 
 	if (devfreq->suspend_freq) {
+		mutex_lock(&devfreq->lock);
 		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
+		mutex_unlock(&devfreq->lock);
 		if (ret)
 			return ret;
 	}
@@ -985,7 +987,9 @@ int devfreq_resume_device(struct devfreq *devfreq)
 		return 0;
 
 	if (devfreq->resume_freq) {
+		mutex_lock(&devfreq->lock);
 		ret = devfreq_set_target(devfreq, devfreq->resume_freq, 0);
+		mutex_unlock(&devfreq->lock);
 		if (ret)
 			return ret;
 	}
-- 
2.17.1

