Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A37EC35C
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 14:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKANAl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 09:00:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35392 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfKANAk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 09:00:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id 8so1989882wmo.0
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2019 06:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ux6o8Ncrgfjd9hT9inKPay1u+1v9WsFB/qk1kBdey4=;
        b=CTKLIytn7ZTjITu7BzPyvUo9TrjzAxCK7D9g0LWLpfABh3mg3wOEt2dDeKYe3NC5K3
         NDfD8U9F0Vc9h3bulWoAp8VdhDmNvDasPBFq3y2ENx9dC0ZpxuYi1OWuq+CVrFjetyj4
         S6oLIS5rxMNIUGK9h1Noo0i1G4NAE8ZC8A/BoJJAl03Umjl8w3RWQCvW6T8tjVeHf7Lw
         ehGkVwo8laANr6Ilbmt+scU0l40+hY6LQ1vB4++/iaUb+H12OdoRfAQYvYAyi0xEJy6s
         vst3FbrJ+lD7d21A07SwpYnLXz09JHNbWyXn2spBIGM8C4WApvkB+F43M02X06oT9mZy
         ojaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ux6o8Ncrgfjd9hT9inKPay1u+1v9WsFB/qk1kBdey4=;
        b=Rb42bmcxxrmFEDzjHdgB5X84HsM3pNTnZWzXF/mUkdel6HVo+ROHB6tqHzeM3SPTLq
         xfsTlmbJTrUSCsqNUqU8ATv9i1TVcES+gE59CzU0ixklVRGgLwpxXwFGTbHCANDSd2y7
         4lEgiyBzMcWs5t7wAMNz7DoUoEgyzYFAeINdSLF+lov7YCDFNxUMhtjLsbKcDvDO0TBv
         oxcnGM55ih5yiU+45/zZsFb+oqTZaSg+e1MouUe2o7jDqpQQa4QaQJmjf5yINBPPQGyX
         ZEgZiKO2WRnxIk76k8zi97jqrrdsggoYml3dd1d19Oa6fPbpLpJzaBUnG2N1UozWyYJa
         i4wQ==
X-Gm-Message-State: APjAAAUaYUQzEs++9u/8LwmWTRf/ac4XJHU8npLnDojOxaAvWAjja5UB
        NT4Z7zOz6Y9KZEYK7DOLVqU497bFwGE=
X-Google-Smtp-Source: APXvYqzcma1qwrrHm8nBTfaVgmdLBFM2hKith8MUY3GNBuouABkehfdmx4SI9jj3UBnwWNhoH/fJqA==
X-Received: by 2002:a1c:c90c:: with SMTP id f12mr9719141wmb.97.1572613237769;
        Fri, 01 Nov 2019 06:00:37 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id x7sm14208476wrg.63.2019.11.01.06.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Nov 2019 06:00:36 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v2 3/3] interconnect: Add basic tracepoints
Date:   Fri,  1 Nov 2019 15:00:31 +0200
Message-Id: <20191101130031.27996-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101130031.27996-1-georgi.djakov@linaro.org>
References: <20191101130031.27996-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The tracepoints can help with understanding the system behavior of a
given interconnect path when the consumer drivers change their bandwidth
demands. This might be interesting when we want to monitor the requested
interconnect bandwidth for each client driver. The paths may share the
same nodes and this will help to understand "who and when is requesting
what". All this is useful for subsystem drivers developers and may also
provide hints when optimizing the power and performance profile of the
system.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 MAINTAINERS                         |  1 +
 drivers/interconnect/core.c         |  7 +++
 include/trace/events/interconnect.h | 81 +++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 include/trace/events/interconnect.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a69e6db80c79..16f28fa515f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8522,6 +8522,7 @@ F:	drivers/interconnect/
 F:	include/dt-bindings/interconnect/
 F:	include/linux/interconnect-provider.h
 F:	include/linux/interconnect.h
+F:	include/trace/events/interconnect.h
 
 INVENSENSE MPU-3050 GYROSCOPE DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index df44ef713db5..15e11e22ddf7 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -26,6 +26,9 @@ static LIST_HEAD(icc_providers);
 static DEFINE_MUTEX(icc_lock);
 static struct dentry *icc_debugfs_dir;
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/interconnect.h>
+
 static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
 {
 	if (!n)
@@ -435,6 +438,8 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 
 		/* aggregate requests for this node */
 		aggregate_requests(node);
+
+		trace_icc_set_bw(path, node, i, avg_bw, peak_bw);
 	}
 
 	ret = apply_constraints(path);
@@ -453,6 +458,8 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 
 	mutex_unlock(&icc_lock);
 
+	trace_icc_set_bw_end(path, ret);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(icc_set_bw);
diff --git a/include/trace/events/interconnect.h b/include/trace/events/interconnect.h
new file mode 100644
index 000000000000..64b646aa7bd3
--- /dev/null
+++ b/include/trace/events/interconnect.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#if !defined(_TRACE_INTERCONNECT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_INTERCONNECT_H
+
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM interconnect
+
+#include "../../../drivers/interconnect/internal.h"
+
+TRACE_EVENT(icc_set_bw,
+
+	TP_PROTO(struct icc_path *p, struct icc_node *n, int i,
+		 u32 avg_bw, u32 peak_bw),
+
+	TP_ARGS(p, n, i, avg_bw, peak_bw),
+
+	TP_STRUCT__entry(
+		__string(path_name, p->name)
+		__string(dev, dev_name(p->reqs[i].dev))
+		__string(node_name, n->name)
+		__field(u32, avg_bw)
+		__field(u32, peak_bw)
+		__field(u32, node_avg_bw)
+		__field(u32, node_peak_bw)
+	),
+
+	TP_fast_assign(
+		__assign_str(path_name, p->name);
+		__assign_str(dev, dev_name(p->reqs[i].dev));
+		__assign_str(node_name, n->name);
+		__entry->avg_bw = avg_bw;
+		__entry->peak_bw = peak_bw;
+		__entry->node_avg_bw = n->avg_bw;
+		__entry->node_peak_bw = n->peak_bw;
+	),
+
+	TP_printk("path=%s dev=%s node=%s avg_bw=%u peak_bw=%u agg_avg=%u agg_peak=%u",
+		  __get_str(path_name),
+		  __get_str(dev),
+		  __get_str(node_name),
+		  __entry->avg_bw,
+		  __entry->peak_bw,
+		  __entry->node_avg_bw,
+		  __entry->node_peak_bw)
+);
+
+TRACE_EVENT(icc_set_bw_end,
+
+	TP_PROTO(struct icc_path *p, int ret),
+
+	TP_ARGS(p, ret),
+
+	TP_STRUCT__entry(
+		__string(path_name, p->name)
+		__string(dev, dev_name(p->reqs[0].dev))
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__assign_str(path_name, p->name);
+		__assign_str(dev, dev_name(p->reqs[0].dev));
+		__entry->ret = ret;
+	),
+
+	TP_printk("path=%s dev=%s ret=%d",
+		  __get_str(path_name),
+		  __get_str(dev),
+		  __entry->ret)
+);
+
+#endif /* _TRACE_INTERCONNECT_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
