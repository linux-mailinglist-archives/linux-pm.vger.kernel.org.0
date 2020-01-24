Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6201486AC
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2020 15:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390349AbgAXOPR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jan 2020 09:15:17 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54079 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388801AbgAXOPJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2020 09:15:09 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200124141507euoutp028d5b67447ab8688f523f37b6bfd5ff5e~s2DizuAW_3064830648euoutp02C
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2020 14:15:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200124141507euoutp028d5b67447ab8688f523f37b6bfd5ff5e~s2DizuAW_3064830648euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579875307;
        bh=SyUER5XtPQaR5PqGkKYS+jSgkqDS6pK5BSu+qlUCJYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZ7Y+9+BtznngctigeIfqyrwg73fDmKNSzev+TZGgrOmkuD1XrvefeVkQTA4XQG2p
         t34FzZxTyiGW0RiWgSE7LRQh5xhpF0OztPvbknyrJ9MhKDhEO0o8yn4u37vfljbK+K
         b4IkfRw7Wb/IesdBLZJaalAQXy+XpJgfwEHwOGaE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200124141507eucas1p172a87a1033df439ed837dc0b47b57b1b~s2DinRh-E2191621916eucas1p1q;
        Fri, 24 Jan 2020 14:15:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B6.5F.61286.BEBFA2E5; Fri, 24
        Jan 2020 14:15:07 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200124141506eucas1p1d2fdb3b5d26d123272cafeddecd5708a~s2DiVyscR2198621986eucas1p1z;
        Fri, 24 Jan 2020 14:15:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200124141506eusmtrp135a260c16c8b2bb95fb23a90621d2573~s2DiVJB9j1786817868eusmtrp1e;
        Fri, 24 Jan 2020 14:15:06 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-4c-5e2afbeb61a9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A6.C2.07950.AEBFA2E5; Fri, 24
        Jan 2020 14:15:06 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200124141506eusmtip1eea5f29f451889f60fd8d12840c623cc~s2DhoZx_00071400714eusmtip1C;
        Fri, 24 Jan 2020 14:15:06 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH RESEND 2/3] PM / devfreq: exynos-bus: prepare for change in
 load calc in exynos-nocp
Date:   Fri, 24 Jan 2020 15:14:48 +0100
Message-Id: <20200124141449.19844-3-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124141449.19844-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djPc7qvf2vFGbx9zWaxccZ6VovrX56z
        Wiz4NIPVov/xa2aL8+c3sFucbXrDbrHp8TVWi8u75rBZfO49wmgx4/w+Jou1R+6yW9xuXMHm
        wOOxaVUnm8fmJfUefVtWMXp83iQXwBLFZZOSmpNZllqkb5fAlXGxYzZzwT+Rij0rVjA2ME4T
        7GLk5JAQMJE4duIeM4gtJLCCUaJ7p3cXIxeQ/YVR4tmDVlYI5zOjxL65PYwwHSsmrWeGSCxn
        lJi8egYjXMua9r3sIFVsAvoSB8+eZAGxRQSkJToXTWQCKWIW2MQsceDpFCaQhLBAmsTk2UfA
        bBYBVYltZ5rBDuEVsJHY1XKOGWKdvMTsxtNsIDangK3EqjOr2CFqBCVOznwCtoAZqKZ562yo
        +nXsEn92+EDYLhIfHjxgh7CFJV4d3wJly0icntzDAmGXSzxd2McOcpyEQAujxIP2j1AJa4k7
        534BLeYAWqApsX6XPkTYUWLOjf1gYQkBPokbbwUhTuCTmLRtOjNEmFeio00IolpV4vmpHiYI
        W1qi6/86VogSD4ktOysmMCrOQvLLLCS/zEJYu4CReRWjeGppcW56arFhXmq5XnFibnFpXrpe
        cn7uJkZgOjr97/inHYxfLyUdYhTgYFTi4Z1xTytOiDWxrLgy9xCjBAezkggvY5hmnBBvSmJl
        VWpRfnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNLUrNTUwtSi2CyTBycUg2M1jHa51NqTn5Kndgr
        K7sowoKJb0bi3mdN9jY2GmIWwlO4+Mzfq+xJ2N68ru+e1d93xh+3z/HcNts0RWbZ6yN5hzLZ
        lp5oTV6XLejgtCAx//aDdvWZ75WXOd3nUq5YOfHB7zeBqVULJwrIe1gdWiV9J5/dJWlxaLl+
        u17GWYNETj3ZzzUcn64osRRnJBpqMRcVJwIA8caDNUMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xu7qvfmvFGTx6q2+xccZ6VovrX56z
        Wiz4NIPVov/xa2aL8+c3sFucbXrDbrHp8TVWi8u75rBZfO49wmgx4/w+Jou1R+6yW9xuXMHm
        wOOxaVUnm8fmJfUefVtWMXp83iQXwBKlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
        a2VkqqRvZ5OSmpNZllqkb5egl3GxYzZzwT+Rij0rVjA2ME4T7GLk5JAQMJFYMWk9cxcjF4eQ
        wFJGie55S9ghEtISjadXM0HYwhJ/rnWxQRR9YpTYO30DI0iCTUBf4uDZkywgtghQQ+eiiUwg
        RcwCu5gltly+yAqSEBZIkXjzdypYA4uAqsS2M83MIDavgI3ErpZzzBAb5CVmN55mA7E5BWwl
        Vp1ZBXaFEFDNlK2rGCHqBSVOznwCtowZqL5562zmCYwCs5CkZiFJLWBkWsUoklpanJueW2yk
        V5yYW1yal66XnJ+7iREYPduO/dyyg7HrXfAhRgEORiUeXoc7WnFCrIllxZW5hxglOJiVRHgZ
        wzTjhHhTEiurUovy44tKc1KLDzGaAj0xkVlKNDkfGNl5JfGGpobmFpaG5sbmxmYWSuK8HQIH
        Y4QE0hNLUrNTUwtSi2D6mDg4pRoYG8Kn690oDXPpdLE3amA8Ea/Uf8lGNcevhZvBc8HDpgPz
        eBdvFRH9onn29Kfncqaiy/5KT3G5cTK5R7ddicF86W1BtXQ7Zd2szMW/jtb9rmY//+/8t8OL
        1XZEKuqn3rwsYvFnz6nURw+Vpsf4aR+c41cUJNw//+mOJqlm9d2L5ISybtx6en+CEktxRqKh
        FnNRcSIAEuiY97QCAAA=
X-CMS-MailID: 20200124141506eucas1p1d2fdb3b5d26d123272cafeddecd5708a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200124141506eucas1p1d2fdb3b5d26d123272cafeddecd5708a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200124141506eucas1p1d2fdb3b5d26d123272cafeddecd5708a
References: <20200124141449.19844-1-k.konieczny@samsung.com>
        <CGME20200124141506eucas1p1d2fdb3b5d26d123272cafeddecd5708a@eucas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add time to struct exynos_bus and time and current frequency to
struct devfreq_event_data. This will allow to calculate load and
max bandwidth in exynos-nocp driver.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
---
 drivers/devfreq/exynos-bus.c  | 21 ++++++++++++++++++++-
 include/linux/devfreq-event.h |  4 ++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 8fa8eb541373..f04ce5b84e75 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -14,6 +14,7 @@
 #include <linux/devfreq-event.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pm_opp.h>
@@ -31,6 +32,7 @@ struct exynos_bus {
 	struct mutex lock;
 
 	unsigned long curr_freq;
+	unsigned long prev_time;
 
 	struct opp_table *opp_table;
 	struct clk *clk;
@@ -57,7 +59,22 @@ static int exynos_bus_##ops(struct exynos_bus *bus)		\
 }
 exynos_bus_ops_edev(enable_edev);
 exynos_bus_ops_edev(disable_edev);
-exynos_bus_ops_edev(set_event);
+
+static int exynos_bus_set_event(struct exynos_bus *bus)
+{
+	int i, ret;
+
+	bus->prev_time = jiffies;
+	for (i = 0; i < bus->edev_count; i++) {
+		if (!bus->edev[i])
+			continue;
+		ret = devfreq_event_set_event(bus->edev[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
 
 static int exynos_bus_get_event(struct exynos_bus *bus,
 				struct devfreq_event_data *edata)
@@ -66,6 +83,8 @@ static int exynos_bus_get_event(struct exynos_bus *bus,
 	unsigned long load_count = 0, total_count = 0;
 	int i, ret = 0;
 
+	event_data.curr_freq = bus->curr_freq;
+	event_data.prev_time = bus->prev_time;
 	for (i = 0; i < bus->edev_count; i++) {
 		if (!bus->edev[i])
 			continue;
diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
index f14f17f8cb7f..b57ccfcb775b 100644
--- a/include/linux/devfreq-event.h
+++ b/include/linux/devfreq-event.h
@@ -41,12 +41,16 @@ struct devfreq_event_dev {
  *		  each count may represent a clock cycle, a time unit
  *		  (ns/us/...), or anything the device driver wants.
  *		  Generally, utilization is load_count / total_count.
+ * @prev_time	: jiffies for interval calculations with polling.
+ * @curr_freq	: current frequency for calculating max bandwidth.
  *
  * This structure contains the data of devfreq-event device for polling period.
  */
 struct devfreq_event_data {
 	unsigned long load_count;
 	unsigned long total_count;
+	unsigned long prev_time;
+	unsigned long curr_freq;
 };
 
 /**
-- 
2.25.0

