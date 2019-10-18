Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3661DC6C7
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 16:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408689AbfJROCa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 10:02:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38083 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393987AbfJROC3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 10:02:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so6227544wmi.3
        for <linux-pm@vger.kernel.org>; Fri, 18 Oct 2019 07:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RDn754hJYJ5LXSqXyPnQWWQyanYkEGiwZFxOe9DtcOE=;
        b=AH91Q1XfnZCl/d/15l+fjFcQuHg1w75bjEGEkukNimRFUCp87vXsuwuSrKVy4gmdUQ
         uaTBX6DuofdOwaI6pOsr3HL4lwXbYY4+CFY4NMtyKFas4QTX9j/GRY28MFHpm6dV6hTW
         oZ7K0OtoHtM0rVADGSP1taKaliCFr1hNV0Qiu1F9HSyr1IZiwZM0Ayq+xcM77jaHpswu
         vkGlwvlCNm3NkWS0P0NFZk1aRYlnwtCOGd+32EmH5l7tPNxzIMIu4dTiacvpNH1bP4fH
         vl2VJ8b2XJb4ppVtXE/cqed1xOFVA/zKgW6J12DyOlZjboI5BYS1hb+0I/U297mmEl1n
         spZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RDn754hJYJ5LXSqXyPnQWWQyanYkEGiwZFxOe9DtcOE=;
        b=Df6ZOk7Fs25kpNYlNI6uF5ooNySfrAmb+8S7uzB1AS/jaksshKN54G+GIndSi+YeBR
         ZiVrfoa1TB4ACEoblLdTH6kTxKsIPVFk+lcytO8Sa1Byp8cRDgOLcAqqO3ha2GTphcJk
         R9fDXv3i0XgOLTJ7HiG277KhR85mOvz9VM2sjaio8J2ZGyxFi6nt8Xo/A7rlEuvW86DD
         y4WcVf87HMCy0s8KossacrXk+33Ymkw3qe+lBIliMdKhabWnRYYZ0pxeVaDf5Capjfb4
         YizC20ChxDfLGnFJmMAGJ+nXesR0qgjwHZOK5JzFXufKkO75V84/Xe28JXZkbCLYLiiz
         8f3Q==
X-Gm-Message-State: APjAAAWOwWpEj872Zu/r9eoCbPh+cQ9rFP9BAKQ6raU7hhw0hw1DfxLG
        TR6gJUe+khyE4oF/gWoBdMeFh6Rvkt07Uw==
X-Google-Smtp-Source: APXvYqy8C8A1yxjB9QJGBZ5lZGdFU4Ebb9IrYpQS+iwsus9/jn/K+GzPf78khldHJMvnhkTEoCROEA==
X-Received: by 2002:a7b:c44f:: with SMTP id l15mr7774951wmi.121.1571407346358;
        Fri, 18 Oct 2019 07:02:26 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id 26sm5192909wmf.20.2019.10.18.07.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Oct 2019 07:02:25 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] interconnect: Add basic tracepoints
Date:   Fri, 18 Oct 2019 17:02:24 +0300
Message-Id: <20191018140224.15087-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.23.0
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
 drivers/interconnect/core.c         |  9 +++++
 include/trace/events/interconnect.h | 52 +++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)
 create mode 100644 include/trace/events/interconnect.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 55199ef7fa74..c307c4b8f677 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8526,6 +8526,7 @@ F:	drivers/interconnect/
 F:	include/dt-bindings/interconnect/
 F:	include/linux/interconnect-provider.h
 F:	include/linux/interconnect.h
+F:	include/trace/events/interconnect.h
 
 INVENSENSE MPU-3050 GYROSCOPE DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 7b971228df38..e24092558c29 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -24,6 +24,9 @@ static LIST_HEAD(icc_providers);
 static DEFINE_MUTEX(icc_lock);
 static struct dentry *icc_debugfs_dir;
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/interconnect.h>
+
 /**
  * struct icc_req - constraints that are attached to each node
  * @req_node: entry in list of requests for the particular @node
@@ -449,6 +452,9 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 
 		/* aggregate requests for this node */
 		aggregate_requests(node);
+
+		trace_icc_set_bw(node, dev_name(path->reqs[i].dev),
+				 avg_bw, peak_bw);
 	}
 
 	ret = apply_constraints(path);
@@ -461,6 +467,9 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 			path->reqs[i].avg_bw = old_avg;
 			path->reqs[i].peak_bw = old_peak;
 			aggregate_requests(node);
+
+			trace_icc_set_bw(node, dev_name(path->reqs[i].dev),
+					 old_avg, old_peak);
 		}
 		apply_constraints(path);
 	}
diff --git a/include/trace/events/interconnect.h b/include/trace/events/interconnect.h
new file mode 100644
index 000000000000..8e001382e9b0
--- /dev/null
+++ b/include/trace/events/interconnect.h
@@ -0,0 +1,52 @@
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
+struct icc_node;
+
+TRACE_EVENT(icc_set_bw,
+
+	TP_PROTO(struct icc_node *n, const char *cdev, u32 avg_bw, u32 peak_bw),
+
+	TP_ARGS(n, cdev, avg_bw, peak_bw),
+
+	TP_STRUCT__entry(
+		__string(node_name, n->name)
+		__field(u32, node_avg_bw)
+		__field(u32, node_peak_bw)
+		__string(cdev, cdev)
+		__field(u32, avg_bw)
+		__field(u32, peak_bw)
+	),
+
+	TP_fast_assign(
+		__assign_str(node_name, n->name);
+		__entry->node_avg_bw = n->avg_bw;
+		__entry->node_peak_bw = n->peak_bw;
+		__assign_str(cdev, cdev);
+		__entry->avg_bw = avg_bw;
+		__entry->peak_bw = peak_bw;
+	),
+
+	TP_printk("%s avg_bw=%u peak_bw=%u cdev=%s avg_bw=%u peak_bw=%u",
+		__get_str(node_name),
+		__entry->node_avg_bw,
+		__entry->node_peak_bw,
+		__get_str(cdev),
+		__entry->avg_bw,
+		__entry->peak_bw)
+);
+#endif /* _TRACE_INTERCONNECT_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
