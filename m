Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE1D10CA42
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 15:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfK1OSc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 09:18:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40349 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfK1OS2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 09:18:28 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so6715324wrn.7
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2019 06:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JT/cyXM4c3hlhS/42ul0Bg6b/PSo9qW/fW/jL/8JN5I=;
        b=aBW4RYhYozIkFwfWySiGzURoUK9gm0MvN+lR/Cel+fVCRq9AHk7CUDGMkIS89R3axU
         A2hDkR2Y3fkuG60BOe5DzK1Qnv2jNQ8ziyx8MRBjX1NicgfFIYbmUHlI3UKoeIJDyCxC
         Mw6q4RgeIqt0DHN03YALF2tnD/hYDDaHNccs1LgxIcY2KztA8IrK0meBV3r7KofbQuSi
         wnpUPgz9f2WYd1mjOa/1oDAAXEyOnmYIWkOD9BhkI2tl9ZjovrH2oAFhpHsHOuTVvkvZ
         YebdzA76BVW5RqTmgJ7qaTsII7a2hzcqc8t3cgTy7YYOzqw2oL9LtO9CwmEZ8ZDy4FLC
         gsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JT/cyXM4c3hlhS/42ul0Bg6b/PSo9qW/fW/jL/8JN5I=;
        b=U06FvFLZUHiCzg+qrJpGOq9xvdF45zreyjoPu47akbD7ws53rWYUkEGohW1XAYCM+7
         WRFmiUUHpGzSgIuTO2EiE1+3ohahbvQiMphgO30mig/VP6dU5oAjPgOZowqM2NYvw9wZ
         W7YON6zTnPzbC+NU6njv7mU9Lqo8pIAgJEI0P0CtaktcmlduhBDYLTHBitNiUFN/F2yZ
         40w7TWwwSQxGqiJicEbikcs4qh5MutlKm9WtX9yYYobNTk/wKtb7PFyZrjl1YqiYXwMT
         bpMS+BBIrZaIzB7kAutbLQcOrjKPzSPCZMXu5jPGrQDQ10rfIxJ7o1qrM8w6EEauxYBe
         5p9Q==
X-Gm-Message-State: APjAAAU/o2bnF1yuFJDHQA4YUuKmfTtS00jVpcpSoT4dbu6H30E5FCJe
        lHhIOKjBG4WQzAr3IgdqJUvdL1U2EHk=
X-Google-Smtp-Source: APXvYqycAPzTOk7jiYu0x7chzYsqp4QkBnI1R5T6PVG42h5covchwVRihpX7Va66RoE5RKSY6KNu2g==
X-Received: by 2002:a5d:6652:: with SMTP id f18mr6935257wrw.246.1574950704416;
        Thu, 28 Nov 2019 06:18:24 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id f6sm23947092wrr.15.2019.11.28.06.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 06:18:23 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     rostedt@goodmis.org, mingo@redhat.com, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, daidavid1@codeaurora.org,
        okukatla@codeaurora.org, evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v4 3/3] interconnect: Add basic tracepoints
Date:   Thu, 28 Nov 2019 16:18:18 +0200
Message-Id: <20191128141818.32168-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128141818.32168-1-georgi.djakov@linaro.org>
References: <20191128141818.32168-1-georgi.djakov@linaro.org>
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

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/Makefile |  1 +
 drivers/interconnect/core.c   |  7 +++
 drivers/interconnect/trace.h  | 88 +++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)
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
index c9e16bc1331e..0e4852feb395 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -21,6 +21,9 @@
 
 #include "internal.h"
 
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
 static DEFINE_IDR(icc_idr);
 static LIST_HEAD(icc_providers);
 static DEFINE_MUTEX(icc_lock);
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
index 000000000000..3d668ff566bf
--- /dev/null
+++ b/drivers/interconnect/trace.h
@@ -0,0 +1,88 @@
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
