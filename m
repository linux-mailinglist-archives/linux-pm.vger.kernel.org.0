Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 876701074CC
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2019 16:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfKVP1Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Nov 2019 10:27:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43365 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfKVP1V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Nov 2019 10:27:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id n1so9060784wra.10
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2019 07:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hEkNkSrp8km0CreoucFi1BgIya/dvxAxyWgm3O9Oa4A=;
        b=QSk14tTRm3kPhwN6nMGxS2I+AOA5Yl5RN2zUYTGICyoS2r9hGYszK6D+SeVAFo5k/E
         rZg5dQhJeMELMLUnot7FxpdB3tvbuncb16aLcyDf9TXGIZaAJ2JMHmY/odWmuX7XGiHx
         j5wzKu8913t98T0zibWM+lYRjiaZrw73nDpenqq6+8FPBd9arcSxRuPX145b9U7tU2Ms
         FnWatqUXBw3z14nvMiybYtO3SyScaMZhmCO1JrNfwQQFsaM2uozdSmHRRFzLghUwRZBe
         qscpyU8Bg/mHWr3AYzCpkkttdkI/CeGHFIQawqX7VhHU+ZkuSwXVj/1b8tGNnk4gNmF2
         hD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hEkNkSrp8km0CreoucFi1BgIya/dvxAxyWgm3O9Oa4A=;
        b=EeY2VGzKPFk7hHrT9EynpCm6emIWyEu2dAvVB1VdgxQ2ThUfFV1qMhW9asKZgK/en+
         UsgfysVPsO+rjvH5YDSSyFl9hUUfNr74qv9rO7w4Jy2aQhwKKjNL1+VFqsyMT17nRjJS
         dzj8Z/B307KTVcS0pKiT3Sc3eJxNiQhkivgu/9sDF15PL9J3FBoSe6XoGjPpBHxZ7uQl
         6VCNOFCqqVXctsSa/KxfWckXbbIz06cG4x10V7Vx0tYbUsTWayihD3jG++wdTZC+mbU/
         TYYMZcUlGcYMRmOHZWNks+QKXxfd1M5PoPH7YUg0H8gtlWwe8nd0atqWyAukvrt8trYD
         iBFQ==
X-Gm-Message-State: APjAAAWKKb+HTPmm1z6OMK4aBrauSqtqR8SM5na2A0TKuz1uJjobJphR
        tM2ZODb17OKKk2O2cMr+Smz64n8HHIQ=
X-Google-Smtp-Source: APXvYqzisXnUeVOdqP1dS2D+LXMimH6hbmBWtHQ0u9pukgly+38mDbFsbQyPNY45Eg2lEr3tB7fKRQ==
X-Received: by 2002:adf:f987:: with SMTP id f7mr18326940wrr.284.1574436438619;
        Fri, 22 Nov 2019 07:27:18 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a206sm4061081wmf.15.2019.11.22.07.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Nov 2019 07:27:17 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v3 3/3] interconnect: Add basic tracepoints
Date:   Fri, 22 Nov 2019 17:27:12 +0200
Message-Id: <20191122152712.19105-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122152712.19105-1-georgi.djakov@linaro.org>
References: <20191122152712.19105-1-georgi.djakov@linaro.org>
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
 drivers/interconnect/Makefile |  1 +
 drivers/interconnect/core.c   |  7 +++
 drivers/interconnect/trace.h  | 90 +++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 drivers/interconnect/trace.h

diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index 28f2ab0824d5..725029ae7a2c 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CFLAGS_core.o				:= -I$(src)
 icc-core-objs				:= core.o
 
 obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 1ddad8ef3cf0..b218a2609f6b 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -19,6 +19,9 @@
 #include <linux/of.h>
 #include <linux/overflow.h>
 
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
 #include "internal.h"
 
 static DEFINE_IDR(icc_idr);
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
diff --git a/drivers/interconnect/trace.h b/drivers/interconnect/trace.h
new file mode 100644
index 000000000000..d2421bf7b389
--- /dev/null
+++ b/drivers/interconnect/trace.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Interconnect framework tracepoints
+ * Copyright (c) 2019, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM interconnect
+
+#if !defined(_TRACE_INTERCONNECT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_INTERCONNECT_H
+
+#include <linux/interconnect.h>
+#include <linux/tracepoint.h>
+
+#include "internal.h"
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
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+#include <trace/define_trace.h>
