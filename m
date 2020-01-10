Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE8E3136A7B
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 11:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgAJKGX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 05:06:23 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53666 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbgAJKGW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 05:06:22 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200110100621euoutp016e1048c4b21e0ea6a7f65cf7bab44525~ofoV6m6Lj0893308933euoutp01e
        for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2020 10:06:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200110100621euoutp016e1048c4b21e0ea6a7f65cf7bab44525~ofoV6m6Lj0893308933euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578650781;
        bh=p4sNZBD2GdpPljSI2a6b2CmX3yAWPhs1wFoE2/fvN2A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=qBCfB4KuJp5n3ycJU6AcGbCfsW4VAWSqesUK2NseczmvBH1t6+DtXfUwWyBq79ytI
         09cynpagFs7u5elWOup7WOoyRd/ZGrHnqK1bM4kfr/Jnkk7SFx+IaTuu3hsHJ1KMmH
         ShMJ/pyamswZ3x/JmkJqqFBIvZmlsTLCK9lFuzN4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200110100620eucas1p1695d36f9a458f68a39a95f1c3c264963~ofoVgDQWd2865128651eucas1p1X;
        Fri, 10 Jan 2020 10:06:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3D.6B.61286.C9C481E5; Fri, 10
        Jan 2020 10:06:20 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200110100620eucas1p12fff62b485570e93b283e23c7a9e5b57~ofoVCrNq70796707967eucas1p1z;
        Fri, 10 Jan 2020 10:06:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200110100620eusmtrp24f34024f9e843db99ed9e1725e1c0a02~ofoVB_xdL1290112901eusmtrp2g;
        Fri, 10 Jan 2020 10:06:20 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-d4-5e184c9c6034
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 99.6D.07950.C9C481E5; Fri, 10
        Jan 2020 10:06:20 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200110100619eusmtip2203efaed9efa87e527be7ecd0c229ad0~ofoUkheud2870828708eusmtip27;
        Fri, 10 Jan 2020 10:06:19 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] power: supply: max17040: Correct IRQ wake handling
Date:   Fri, 10 Jan 2020 11:05:40 +0100
Message-Id: <20200110100540.27371-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsWy7djP87pzfCTiDDa8V7bYOGM9q8X58xvY
        LS7vmsNm8bn3CKPFjPP7mCzWHrkLFDu/jsni7ms/Bw6PJ3cus3nsuLuE0WPTqk42j74tqxg9
        Pm+SC2CN4rJJSc3JLEst0rdL4MqYOmc3a8Eq6Yoj26+yNDD+Fe9i5OSQEDCR2HR3IXMXIxeH
        kMAKRon5DzYzQThfGCUWPXgGlfnMKPFu2UtGmJbrWw6yQiSWM0p0rG5ghmuZcvgWWBWbgKFE
        19suNhBbRMBeYu62yWBzmQUmM0nM+rcOLCEs4CzxuO04C4jNIqAq8XHFaiYQm1fAVuJI9z52
        iHXyEqs3HADbICFwm02if+FmqISLROvUIywQtrDEq+NboOIyEv93zmeCaGhmlHh4bi07hNPD
        KHG5aQbUF9YSd879AjqDA+gmTYn1u/Qhwo4SOye3s4KEJQT4JG68FQQJMwOZk7ZNZ4YI80p0
        tAlBVKtJzDq+Dm7twQuXmCFsD4mnXY1g5UICsRLrrhVMYJSbhbBqASPjKkbx1NLi3PTUYsO8
        1HK94sTc4tK8dL3k/NxNjMC0cPrf8U87GL9eSjrEKMDBqMTDe0BUPE6INbGsuDL3EKMEB7OS
        CO/RG2JxQrwpiZVVqUX58UWlOanFhxilOViUxHmNF72MFRJITyxJzU5NLUgtgskycXBKNTBm
        3SmwNk57U3dIJJnJw6/9QolUjVbQ8lk7xFoOlqYsD5SZ8EIyY17B/oKc17v5961OaVe+kBOv
        o/RaWJX1xLflb7M/sTv+M9vzber61hVPSk7uWnm9IdDolCTTsgtl+ya5KU/Yuynv1ONZ958/
        8HH48vLkbMaSYxMn+KjyqAjr3u4NkEjh2BGrxFKckWioxVxUnAgAhmxxOAcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t/xe7pzfCTiDP7M4LTYOGM9q8X58xvY
        LS7vmsNm8bn3CKPFjPP7mCzWHrkLFDu/jsni7ms/Bw6PJ3cus3nsuLuE0WPTqk42j74tqxg9
        Pm+SC2CN0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL
        0MuYOmc3a8Eq6Yoj26+yNDD+Fe9i5OSQEDCRuL7lIGsXIxeHkMBSRomDn9awQyRkJE5Oa2CF
        sIUl/lzrYoMo+sQoMXfOOSaQBJuAoUTXW5AEJ4eIgKNE257/zCBFzAJTmSQOrzwF1i0s4Czx
        uO04C4jNIqAq8XHFarBmXgFbiSPd+6C2yUus3nCAeQIjzwJGhlWMIqmlxbnpucVGesWJucWl
        eel6yfm5mxiB4bjt2M8tOxi73gUfYhTgYFTi4c0QFo8TYk0sK67MPcQowcGsJMJ79IZYnBBv
        SmJlVWpRfnxRaU5q8SFGU6DlE5mlRJPzgbGSVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2x
        JDU7NbUgtQimj4mDU6qB0SYoovVQvbwT02M2mc5Fi3duu6eXtfrTjmsz2o3nKp2I+BRUOOXy
        iekBooZ3dXQY1oox+BZ85912jouX25VDuPpyT3tqr+qhKQfzL/xZ63HmolRy189bNntf/I8u
        MLrxy+FgWumuoMfpor9+y9/X+nkhctnRE9Os6ybdjvqU55Dgttv7++fpM5RYijMSDbWYi4oT
        AQopWoVdAgAA
X-CMS-MailID: 20200110100620eucas1p12fff62b485570e93b283e23c7a9e5b57
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200110100620eucas1p12fff62b485570e93b283e23c7a9e5b57
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200110100620eucas1p12fff62b485570e93b283e23c7a9e5b57
References: <CGME20200110100620eucas1p12fff62b485570e93b283e23c7a9e5b57@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Don't disable IRQ wake feature without prior enabling it.

This fixes following warning observed on Exynos3250-based Rinato board:
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1288 at kernel/irq/manage.c:724 irq_set_irq_wake+0xfc/0x134
Unbalanced IRQ 83 wake disable
Modules linked in:
CPU: 0 PID: 1288 Comm: rtcwake Not tainted 5.5.0-rc5-next-20200110-00031-g6289fffbb3f5 #7266
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c0112e48>] (unwind_backtrace) from [<c010e090>] (show_stack+0x10/0x14)
[<c010e090>] (show_stack) from [<c0b25b28>] (dump_stack+0xa4/0xd0)
[<c0b25b28>] (dump_stack) from [<c0128088>] (__warn+0xf4/0x10c)
[<c0128088>] (__warn) from [<c0128114>] (warn_slowpath_fmt+0x74/0xb8)
[<c0128114>] (warn_slowpath_fmt) from [<c019e9a0>] (irq_set_irq_wake+0xfc/0x134)
[<c019e9a0>] (irq_set_irq_wake) from [<c0772708>] (max17040_suspend+0x50/0x58)
[<c0772708>] (max17040_suspend) from [<c05f55ac>] (dpm_run_callback+0xb4/0x400)
[<c05f55ac>] (dpm_run_callback) from [<c05f5e38>] (__device_suspend+0x140/0x814)
[<c05f5e38>] (__device_suspend) from [<c05f9548>] (dpm_suspend+0x16c/0x564)
[<c05f9548>] (dpm_suspend) from [<c05fa2e4>] (dpm_suspend_start+0x90/0x98)
[<c05fa2e4>] (dpm_suspend_start) from [<c01977f4>] (suspend_devices_and_enter+0xec/0xc0c)
[<c01977f4>] (suspend_devices_and_enter) from [<c019862c>] (pm_suspend+0x318/0x3e8)
[<c019862c>] (pm_suspend) from [<c01963cc>] (state_store+0x68/0xc8)
[<c01963cc>] (state_store) from [<c03531a4>] (kernfs_fop_write+0x10c/0x220)
[<c03531a4>] (kernfs_fop_write) from [<c02b44c4>] (__vfs_write+0x2c/0x1c4)
[<c02b44c4>] (__vfs_write) from [<c02b7288>] (vfs_write+0xa4/0x180)
[<c02b7288>] (vfs_write) from [<c02b74d0>] (ksys_write+0x58/0xcc)
[<c02b74d0>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
Exception stack(0xd6e83fa8 to 0xd6e83ff0)
...
irq event stamp: 18028
hardirqs last  enabled at (18027): [<c014b99c>] cancel_delayed_work+0x84/0xf8
hardirqs last disabled at (18028): [<c0b49b1c>] _raw_spin_lock_irqsave+0x1c/0x58
softirqs last  enabled at (17876): [<c01026d8>] __do_softirq+0x4f0/0x5e4
softirqs last disabled at (17869): [<c0130d34>] irq_exit+0x16c/0x170
---[ end trace 0728005730004e60 ]---

Fixes: 2e17ed94de68 ("power: supply: max17040: Add IRQ handler for low SOC alert")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/power/supply/max17040_battery.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index c1188e94cf54..8a1f0ee493aa 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -351,12 +351,8 @@ static int max17040_suspend(struct device *dev)
 
 	cancel_delayed_work(&chip->work);
 
-	if (client->irq) {
-		if (device_may_wakeup(dev))
-			enable_irq_wake(client->irq);
-		else
-			disable_irq_wake(client->irq);
-	}
+	if (client->irq && device_may_wakeup(dev))
+		enable_irq_wake(client->irq);
 
 	return 0;
 }
@@ -369,12 +365,8 @@ static int max17040_resume(struct device *dev)
 	queue_delayed_work(system_power_efficient_wq, &chip->work,
 			   MAX17040_DELAY);
 
-	if (client->irq) {
-		if (device_may_wakeup(dev))
-			disable_irq_wake(client->irq);
-		else
-			enable_irq_wake(client->irq);
-	}
+	if (client->irq && device_may_wakeup(dev))
+		disable_irq_wake(client->irq);
 
 	return 0;
 }
-- 
2.17.1

