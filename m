Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55B6C146BDF
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 15:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbgAWOxl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jan 2020 09:53:41 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50650 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbgAWOxf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2020 09:53:35 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200123145332euoutp01e80c83ab06dab7bb40bd2bf0ac0c5e1b~si7zXHIyo2816728167euoutp01P
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2020 14:53:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200123145332euoutp01e80c83ab06dab7bb40bd2bf0ac0c5e1b~si7zXHIyo2816728167euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579791212;
        bh=SyUER5XtPQaR5PqGkKYS+jSgkqDS6pK5BSu+qlUCJYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ob6VQ1S8rJ7P4DYyTZEhL8EbgqXdkUtf9eulBuV1UkPNLymD6YuDQhhrE1GyAOOhi
         L4EampRN1MQgYk1gz4RLthi3ijJhKLVk0TA6EqjBo/vglcY8RCdypnyF45WIsC3XAi
         aka7tMtwdTgcr6D7uWaUEpsH9YkHiIz+bRlA/ma8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200123145332eucas1p2606cd936f36ce1f56049ab637b69a2d2~si7zKRhYA1403614036eucas1p2b;
        Thu, 23 Jan 2020 14:53:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2F.C5.60679.C63B92E5; Thu, 23
        Jan 2020 14:53:32 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200123145331eucas1p29464e7f22e1e775cc8c4fc1e330f8eee~si7y1Gz1K1422014220eucas1p2c;
        Thu, 23 Jan 2020 14:53:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200123145331eusmtrp10bcd5d98a5e5ae8e69a9052e3740b3f5~si7y0aCZB2757127571eusmtrp1T;
        Thu, 23 Jan 2020 14:53:31 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-14-5e29b36cd0a8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EA.43.07950.B63B92E5; Thu, 23
        Jan 2020 14:53:31 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200123145331eusmtip2fe5b4288716d44cd5b7278e98aabf150~si7yHF-tL1688616886eusmtip2Y;
        Thu, 23 Jan 2020 14:53:31 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 2/3] PM / devfreq: exynos-bus: prepare for change in load
 calc in exynos-nocp
Date:   Thu, 23 Jan 2020 15:53:12 +0100
Message-Id: <20200123145313.27539-3-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200123145313.27539-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djPc7o5mzXjDCbc5bDYOGM9q8X1L89Z
        LRZ8msFq0f/4NbPF+fMb2C3ONr1ht7i8aw6bxefeI4wWM87vY7JYe+Quu8XtxhVsDtwem1Z1
        snn0bVnF6PF5k1wAcxSXTUpqTmZZapG+XQJXxsWO2cwF/0Qq9qxYwdjAOE2wi5GTQ0LAROLC
        wk2MILaQwApGiTtTEroYuYDsL4wSy299YIRwPjNKvN7yjA2mY83WM2wQieWMEv9ndrHCtWz8
        +5UdpIpNQF/i4NmTLCC2iIC0ROeiiUwgNrNAF7PE+a+mILawQLzEuxltzCA2i4CqxLfWXWB3
        8ArYSOyaP5UZYpu8xOzG02CbOQVsJaY+WMgGUSMocXLmExaImfISzVtnQ9VPZ5f4/tkYwnaR
        uHvgFQuELSzx6vgWdghbRuL05B6oeLnE04V97CAPSAi0MEo8aP8IlbCWuHPuF9AyDqAFmhLr
        d+lDhB0l3q2bxQISlhDgk7jxVhDiBD6JSdumM0OEeSU62oQgqlUlnp/qYYKwpSW6/q9jhbA9
        JHZ9+8k+gVFxFpJnZiF5ZhbC3gWMzKsYxVNLi3PTU4uN8lLL9YoTc4tL89L1kvNzNzECk8/p
        f8e/7GDc9SfpEKMAB6MSD69Er2acEGtiWXFl7iFGCQ5mJRFexjCgEG9KYmVValF+fFFpTmrx
        IUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYzmj3Pqol9P3R3tap138dAELqZ7Fd/q
        5eY8mvtkU5v/J7tqoR/dP0/P+5trwMi06NeVSTOn8JV3zomVuqixRyRwXe3znVXX3vCyzOhV
        ex8T8Gud6enU7G9vddbyHb82gXnTzTf5ZQmf55sc1k44wukWKulpePxWSM/D/hMabWLLwsp2
        iHR8tFqvxFKckWioxVxUnAgAARTEyjoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xe7rZmzXjDB6e0bXYOGM9q8X1L89Z
        LRZ8msFq0f/4NbPF+fMb2C3ONr1ht7i8aw6bxefeI4wWM87vY7JYe+Quu8XtxhVsDtwem1Z1
        snn0bVnF6PF5k1wAc5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpq
        TmZZapG+XYJexsWO2cwF/0Qq9qxYwdjAOE2wi5GTQ0LARGLN1jNsXYxcHEICSxkljh2ZxwSR
        kJZoPL0ayhaW+HOtC6roE6PE0+m3WUASbAL6EgfPngSzRYAaOhdNZAIpYhaYxCyx58UzNpCE
        sECsxL33f8BsFgFViW+tuxhBbF4BG4ld86cyQ2yQl5jdeBqshlPAVmLqg4VgthBQzeddx1kh
        6gUlTs58AraMGai+eets5gmMArOQpGYhSS1gZFrFKJJaWpybnltspFecmFtcmpeul5yfu4kR
        GCvbjv3csoOx613wIUYBDkYlHl6JXs04IdbEsuLK3EOMEhzMSiK8jGFAId6UxMqq1KL8+KLS
        nNTiQ4ymQE9MZJYSTc4HxnFeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+
        Jg5OqQbGs8cebX/EEiNz5d2K2p+Me004xRO5tKb8s1sfzsM/nfv2yftz3cN95sZu9f/Fbbz3
        D0ORJ8OxjxIqPU9kWhaFtHXJOFlNlDhwZuqK5oJvTgdLYoMXaDUzX2Pd0nx9wgSPj0msZyKn
        GxbP8We/9Xbqju+ZtwKzE3iqdaM81Jyv3J0rPJ1FTe2GEktxRqKhFnNRcSIAZZdxJqsCAAA=
X-CMS-MailID: 20200123145331eucas1p29464e7f22e1e775cc8c4fc1e330f8eee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200123145331eucas1p29464e7f22e1e775cc8c4fc1e330f8eee
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200123145331eucas1p29464e7f22e1e775cc8c4fc1e330f8eee
References: <20200123145313.27539-1-k.konieczny@samsung.com>
        <CGME20200123145331eucas1p29464e7f22e1e775cc8c4fc1e330f8eee@eucas1p2.samsung.com>
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

