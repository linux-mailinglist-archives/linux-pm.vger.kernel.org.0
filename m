Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A12F140730
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 10:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgAQJ7Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 04:59:24 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37135 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgAQJ60 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 04:58:26 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so6920708wmf.2
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 01:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=69zkeA3EsoksrgUY9Um/6N1yWF5rzIHjf5tDoqGZRjI=;
        b=sea0KpwGHD3wCe5ufSr5NLlr4rEoNNOinI4ctaz8jmXEG28tG4zKZtlJL3i9I4qW/M
         T8AwNZyC2VQTGl3AgkVCvsvAvG7OhnaHBNy8hghQ1N+D+dGW9J9/e61CUgtx4BAARx22
         Mm/2g7FfeNT5T/HobvqAlKUJjjrQ8yceJ0dVgXPsdJPYHyxoEcp2uCcRbYOaecrgLqUW
         vp3aa3OrIdCOm63ZPndB6GwSYPGB+nGgNbIJIBkvcJ/eCT8bdwX4IUR0v285L9YBoXIs
         IDcSN+uNsOFxv0s8Gj37bEftJBxtW18p+eIO8HbtyujAraPC24OYil5Oc7JBXkPW3Dzd
         X28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=69zkeA3EsoksrgUY9Um/6N1yWF5rzIHjf5tDoqGZRjI=;
        b=KsNiN4zM07rnQxgmvuJTlxRMC2nbpnPyoX4cM361A7kyXgkE9WEorxH3+ARxT5X8Pb
         n6u0TQC/81ogSxDfU+AJ3ABiGk+5thGeMn/MIGxVtwbZ1Xv72/aOkrJTpvYAIPOZ4uZK
         HOUwXWXw9o2rp+oujqrwQtdj3U8dr57Of4YEcntXMjrLDG7Wq/YagPgOALwdJ/niSP8L
         SCwy/olOxrrJTn82BsE8KFzMbqU+DxLCUpqxRzThl2L4HNa4MQQEYEn5XY4Oz+8Amxhg
         B9IKmC3x4nON35JElVWknOU8/586OQZkQsh6WesCII7M/RMpFtwRHUMGYN3BbBb4nB05
         YkqQ==
X-Gm-Message-State: APjAAAXS9OtnY9K7duR2/rmp8G8J3xbeBkELdRgvJeKIm+q4DVpBZaOV
        NfGT7MSgof75o5/Bei1NNP1sGQ==
X-Google-Smtp-Source: APXvYqwo0Z7gY5lIK21vyoJch58yh5Dhjb6c6doWW6Fay3i1RC5pYgBybK/0QI27Sif2nJLw+LPoYw==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr3950050wmk.68.1579255105355;
        Fri, 17 Jan 2020 01:58:25 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r62sm9967007wma.32.2020.01.17.01.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jan 2020 01:58:24 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 05/12] interconnect: Add basic tracepoints
Date:   Fri, 17 Jan 2020 11:58:09 +0200
Message-Id: <20200117095816.23575-6-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117095816.23575-1-georgi.djakov@linaro.org>
References: <20200117095816.23575-1-georgi.djakov@linaro.org>
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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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
index 4f9bdb7f9165..fbec2e4fdfeb 100644
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
