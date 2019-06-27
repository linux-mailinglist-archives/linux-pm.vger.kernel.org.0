Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 390BD58CAB
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfF0VMo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:12:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33249 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfF0VMn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:12:43 -0400
Received: by mail-lf1-f68.google.com with SMTP id y17so2553013lfe.0;
        Thu, 27 Jun 2019 14:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WL6ybvxAVNlR4TTLM5Kmje/mrbensrN2xlijRfZ0E9Y=;
        b=m3u0eT0fyJWMynBSLnbQfNVTGU4S9x4syGLD+LpWnGRuaL1/QoZevsoLeMqQJ4rFUG
         RgYcN07faSHn0gaqKeOP9PhiJ7wmR2AAWivjlCSASKR0wiJWFd533AnHOzGXq+Zxh/Jn
         NfpdhrU4oXkNB+jL63wwmu3WKkZ1xbhtcqtAfDWcpoueZ8rVveYlkkTuw5bXlF4m6QRz
         6ln2R79lgsrdr860eojWFY7bjBKpG0nLLzuJ4dvz0cLZlOcfGI0s1Q+n1lL4Sxb5m6u6
         szs4eZF048bUs8ID5yC0oLbpxtd0BZd7bkoJoFyKs7arQut7N7vvznmTCvbv3SLdgxRn
         hI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WL6ybvxAVNlR4TTLM5Kmje/mrbensrN2xlijRfZ0E9Y=;
        b=UU/wcK0zsLBEsHmMIa9O3ym7mSJaUnDi61NqB9C9uUO42WZx/SzDRwXbyJHW7eORWQ
         qosR46TGNplOTGTwmD76CXQdW3UAiIgo/c3jyOf9wcAfENp4X830O3OnhwQMv7Hx0cof
         jq+Dv3uJsRgTgXPfWCnjJrUafHjaYBLz/LlhI1LWOLF81hWsAWLi3CMvOSx0YALdP0nw
         nHE04JAvCZphtR70P9ofXdNCdeNM7OLY0PSeZRrip+57movQa0boOckT8jZ0A+tUaej+
         JWj/UVINTGQ0JNo9Wcny3VF/jOdMlmH5J1ioHLHlBZ+/ILSCQYe6ZPrzK6fVxmBy5w6R
         EBzQ==
X-Gm-Message-State: APjAAAUdu/zDwetAss9DjSXXgZCu68ytgqce3m5GaH/33IB3Mo11yWZp
        aPbKiJ/nQ8/wAoIslMjZtqU=
X-Google-Smtp-Source: APXvYqxqvTyzQRGnX3mcz0HT0iNna4R2ZODz0DNBrdZHvzUZbVDisbwBWU5zICfQR7676GLC+QRqSA==
X-Received: by 2002:a19:8cc:: with SMTP id 195mr3264753lfi.150.1561669961099;
        Thu, 27 Jun 2019 14:12:41 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id p29sm30485ljp.87.2019.06.27.14.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:12:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 17/22] PM / devfreq: tegra30: Use tracepoints for debugging
Date:   Fri, 28 Jun 2019 00:11:10 +0300
Message-Id: <20190627211115.21138-18-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627211115.21138-1-digetx@gmail.com>
References: <20190627211115.21138-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Debug messages create too much CPU and memory activity by themselves,
so it's difficult to debug lower rates and catch unwanted interrupts
that happen rarely. Tracepoints are ideal in that regards because they
do not contribute to the sampled date at all. This allowed me to catch
few problems which are fixed by the followup patches, without tracepoints
it would be much harder to do.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c      |  43 +++-------
 include/trace/events/tegra30_devfreq.h | 105 +++++++++++++++++++++++++
 2 files changed, 117 insertions(+), 31 deletions(-)
 create mode 100644 include/trace/events/tegra30_devfreq.h

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 61d9601766fc..c1ab7af07daa 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -19,6 +19,9 @@
 #include <linux/reset.h>
 #include <linux/workqueue.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/tegra30_devfreq.h>
+
 #include "governor.h"
 
 #define ACTMON_GLB_STATUS					0x0
@@ -283,9 +286,6 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
 					 unsigned long *lower,
 					 unsigned long *upper)
 {
-	struct device *ddev = tegra->devfreq->dev.parent;
-	u32 offset = dev->config->offset;
-
 	/*
 	 * Memory frequencies are guaranteed to have 1MHz granularity
 	 * and thus we need this rounding down to get a proper watermarks
@@ -298,8 +298,8 @@ static void tegra_actmon_get_lower_upper(struct tegra_devfreq *tegra,
 	*lower = tegra_actmon_lower_freq(tegra, target_freq);
 	*upper = tegra_actmon_upper_freq(tegra, target_freq);
 
-	dev_dbg(ddev, "%03x: target_freq %lu lower freq %lu upper freq %lu\n",
-		offset, target_freq, *lower, *upper);
+	trace_device_lower_upper(dev->config->offset, target_freq,
+				 *lower, *upper);
 
 	/*
 	 * The upper watermark should take into account CPU's frequency
@@ -377,30 +377,13 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
 	device_writel(dev, lower + delta, ACTMON_DEV_LOWER_WMARK);
 }
 
-static void actmon_device_debug(struct tegra_devfreq *tegra,
-				struct tegra_devfreq_device *dev,
-				const char *prefix)
-{
-	dev_dbg(tegra->devfreq->dev.parent,
-		"%03x: %s: 0x%08x 0x%08x a %u %u %u c %u %u %u b %lu cpu %u\n",
-		dev->config->offset, prefix,
-		device_readl(dev, ACTMON_DEV_INTR_STATUS),
-		device_readl(dev, ACTMON_DEV_CTRL),
-		device_readl(dev, ACTMON_DEV_AVG_COUNT),
-		device_readl(dev, ACTMON_DEV_AVG_LOWER_WMARK),
-		device_readl(dev, ACTMON_DEV_AVG_UPPER_WMARK),
-		device_readl(dev, ACTMON_DEV_COUNT),
-		device_readl(dev, ACTMON_DEV_LOWER_WMARK),
-		device_readl(dev, ACTMON_DEV_UPPER_WMARK),
-		dev->boost_freq, cpufreq_get(0));
-}
-
 static void actmon_isr_device(struct tegra_devfreq *tegra,
 			      struct tegra_devfreq_device *dev)
 {
 	u32 intr_status, dev_ctrl, avg_intr_mask, avg_count;
 
-	actmon_device_debug(tegra, dev, "isr+");
+	trace_device_isr_enter(tegra->regs, dev->config->offset,
+			       dev->boost_freq, cpufreq_get(0));
 
 	intr_status = device_readl(dev, ACTMON_DEV_INTR_STATUS);
 	avg_count = device_readl(dev, ACTMON_DEV_AVG_COUNT);
@@ -455,7 +438,8 @@ static void actmon_isr_device(struct tegra_devfreq *tegra,
 	device_writel(dev, dev_ctrl, ACTMON_DEV_CTRL);
 	device_writel(dev, ACTMON_INTR_STATUS_CLEAR, ACTMON_DEV_INTR_STATUS);
 
-	actmon_device_debug(tegra, dev, "isr-");
+	trace_device_isr_exit(tegra->regs, dev->config->offset,
+			      dev->boost_freq, cpufreq_get(0));
 }
 
 static unsigned long actmon_update_target(struct tegra_devfreq *tegra,
@@ -748,7 +732,6 @@ static struct devfreq_dev_profile tegra_devfreq_profile = {
 static int tegra_governor_get_target(struct devfreq *devfreq,
 				     unsigned long *freq)
 {
-	struct device *ddev = devfreq->dev.parent;
 	struct devfreq_dev_status *stat;
 	struct tegra_devfreq *tegra;
 	struct tegra_devfreq_device *dev;
@@ -769,13 +752,11 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
 		dev = &tegra->devices[i];
 
 		dev_target_freq = actmon_update_target(tegra, dev);
-
 		target_freq = max(target_freq, dev_target_freq);
 
-		dev_dbg(ddev, "%03x: upd: dev_target_freq %lu\n",
-			dev->config->offset, dev_target_freq);
-
-		actmon_device_debug(tegra, dev, "upd");
+		trace_device_target_freq(dev->config->offset, dev_target_freq);
+		trace_device_target_update(tegra->regs, dev->config->offset,
+					   dev->boost_freq, cpufreq_get(0));
 	}
 
 	*freq = target_freq;
diff --git a/include/trace/events/tegra30_devfreq.h b/include/trace/events/tegra30_devfreq.h
new file mode 100644
index 000000000000..8f264a489daf
--- /dev/null
+++ b/include/trace/events/tegra30_devfreq.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM tegra30_devfreq
+
+#if !defined(_TRACE_TEGRA30_DEVFREQ_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_TEGRA30_DEVFREQ_H
+
+#include <linux/io.h>
+#include <linux/tracepoint.h>
+#include <linux/types.h>
+
+DECLARE_EVENT_CLASS(device_state,
+	TP_PROTO(void __iomem *base, u32 offset, u32 boost, u32 cpufreq),
+	TP_ARGS(base, offset, boost, cpufreq),
+	TP_STRUCT__entry(
+		__field(u32, offset)
+		__field(u32, intr_status)
+		__field(u32, ctrl)
+		__field(u32, avg_count)
+		__field(u32, avg_lower)
+		__field(u32, avg_upper)
+		__field(u32, count)
+		__field(u32, lower)
+		__field(u32, upper)
+		__field(u32, boost_freq)
+		__field(u32, cpu_freq)
+	),
+	TP_fast_assign(
+		__entry->offset		= offset;
+		__entry->intr_status	= readl_relaxed(base + offset + 0x24);
+		__entry->ctrl		= readl_relaxed(base + offset + 0x0);
+		__entry->avg_count	= readl_relaxed(base + offset + 0x20);
+		__entry->avg_lower	= readl_relaxed(base + offset + 0x14);
+		__entry->avg_upper	= readl_relaxed(base + offset + 0x10);
+		__entry->count		= readl_relaxed(base + offset + 0x1c);
+		__entry->lower		= readl_relaxed(base + offset + 0x8);
+		__entry->upper		= readl_relaxed(base + offset + 0x4);
+		__entry->boost_freq	= boost;
+		__entry->cpu_freq	= cpufreq;
+	),
+	TP_printk("%03x: intr 0x%08x ctrl 0x%08x avg %010u %010u %010u cnt %010u %010u %010u boost %010u cpu %u",
+		__entry->offset,
+		__entry->intr_status,
+		__entry->ctrl,
+		__entry->avg_count,
+		__entry->avg_lower,
+		__entry->avg_upper,
+		__entry->count,
+		__entry->lower,
+		__entry->upper,
+		__entry->boost_freq,
+		__entry->cpu_freq)
+);
+
+DEFINE_EVENT(device_state, device_isr_enter,
+	TP_PROTO(void __iomem *base, u32 offset, u32 boost, u32 cpufreq),
+	TP_ARGS(base, offset, boost, cpufreq));
+
+DEFINE_EVENT(device_state, device_isr_exit,
+	TP_PROTO(void __iomem *base, u32 offset, u32 boost, u32 cpufreq),
+	TP_ARGS(base, offset, boost, cpufreq));
+
+DEFINE_EVENT(device_state, device_target_update,
+	TP_PROTO(void __iomem *base, u32 offset, u32 boost, u32 cpufreq),
+	TP_ARGS(base, offset, boost, cpufreq));
+
+TRACE_EVENT(device_lower_upper,
+	TP_PROTO(u32 offset, u32 target, u32 lower, u32 upper),
+	TP_ARGS(offset, target, lower, upper),
+	TP_STRUCT__entry(
+		__field(u32, offset)
+		__field(u32, target)
+		__field(u32, lower)
+		__field(u32, upper)
+	),
+	TP_fast_assign(
+		__entry->offset = offset;
+		__entry->target = target;
+		__entry->lower = lower;
+		__entry->upper = upper;
+	),
+	TP_printk("%03x: freq %010u lower freq %010u upper freq %010u",
+		__entry->offset,
+		__entry->target,
+		__entry->lower,
+		__entry->upper)
+);
+
+TRACE_EVENT(device_target_freq,
+	TP_PROTO(u32 offset, u32 target),
+	TP_ARGS(offset, target),
+	TP_STRUCT__entry(
+		__field(u32, offset)
+		__field(u32, target)
+	),
+	TP_fast_assign(
+		__entry->offset = offset;
+		__entry->target = target;
+	),
+	TP_printk("%03x: freq %010u", __entry->offset, __entry->target)
+);
+#endif /* _TRACE_TEGRA30_DEVFREQ_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.22.0

