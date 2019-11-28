Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBACC10CA3E
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 15:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfK1OSY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 09:18:24 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45662 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfK1OSY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 09:18:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so5483549wrj.12
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2019 06:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bnMxp132Vd6L+3AapluWQFT+FYtyktAJGLaxzIjZpzU=;
        b=v8Lraqn+HwF1Jmnt9l7ey+j9HyaetIIlDY3yX1tnMX9Muug090zyvm0w6i3cU4pd/K
         Pa2OKpyX475YQw3p2FFtBoJO1iTAoSy9EeDen5vcawxNnvMHuELNp1gxnW9pgmc+BXpV
         La6x8X6j3yVOszKKghMEX2Lfkea4i57LamXpzukoN5Fpr1D9LIPGl14cHGeQbwrXzRGK
         jpjsCrtj/Fz6G6DutIfiPOiMUKRsScuurqCBE+UHtNHdC47r4FaIX75OVVk6CId06kVB
         o0f+dM55SChfzPXMtQWLJY/r2IeFWVJZF5cBsKe2EYstl4RprPkAFlMLFYBr+yaK4qP9
         /xUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bnMxp132Vd6L+3AapluWQFT+FYtyktAJGLaxzIjZpzU=;
        b=VG0ROEDaDsFL5htsI6WRNIZDB0UWVO+0Gf6sctiwcR889YnqdmrgR3n88NkDseB2RP
         nhnKfw8bjrxLOvq1bRNw3IUoYEHT3301YycRGyMk05NCDbZLNf1xh1HSvflD902FTZte
         6sQVwLQN5f/jkoGxzeM1n+yXoE6Z3j8IifhYTtt+Rl6D4qbK/8qqWm68YkE1cN559yJa
         dZ1RBTUYs0u1hysNhQd8B7nPrGkLWfNRZ8rLAQFTZ/xX+A6+B6okfKi/Xy1E0KLFlHaW
         rJ+FIW1TS+Q/LVpEWDXBskQ+ZNc+yfuCKhKDmZSoBDyEK5uLGMGcJHJ8KpEovOv184BE
         BpEw==
X-Gm-Message-State: APjAAAW84o/RsQQ0NthPSoArlgsSOy/0P+uKZVMLKPwvNCOs1q3w5hql
        qTDUO3+jylcFR84kgcab0rL7sRdpExk=
X-Google-Smtp-Source: APXvYqxCS1zWwYMGux3VT17qKlhcgF1FX0vEaM5jx7QSq/PBF1udA38wr/OTGj0D25QUERplroOaYw==
X-Received: by 2002:adf:d848:: with SMTP id k8mr2430296wrl.328.1574950701769;
        Thu, 28 Nov 2019 06:18:21 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id f6sm23947092wrr.15.2019.11.28.06.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 06:18:21 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     rostedt@goodmis.org, mingo@redhat.com, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, daidavid1@codeaurora.org,
        okukatla@codeaurora.org, evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v4 1/3] interconnect: Move internal structs into a separate file
Date:   Thu, 28 Nov 2019 16:18:16 +0200
Message-Id: <20191128141818.32168-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128141818.32168-1-georgi.djakov@linaro.org>
References: <20191128141818.32168-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Move the interconnect framework internal structs into a separate file,
so that it can be included and used by ftrace code. This will allow us
to expose some more useful information in the traces.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c     | 30 ++-----------------------
 drivers/interconnect/internal.h | 40 +++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 28 deletions(-)
 create mode 100644 drivers/interconnect/internal.h

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 1b811423020a..f30a326dc7ce 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -19,39 +19,13 @@
 #include <linux/of.h>
 #include <linux/overflow.h>
 
+#include "internal.h"
+
 static DEFINE_IDR(icc_idr);
 static LIST_HEAD(icc_providers);
 static DEFINE_MUTEX(icc_lock);
 static struct dentry *icc_debugfs_dir;
 
-/**
- * struct icc_req - constraints that are attached to each node
- * @req_node: entry in list of requests for the particular @node
- * @node: the interconnect node to which this constraint applies
- * @dev: reference to the device that sets the constraints
- * @tag: path tag (optional)
- * @avg_bw: an integer describing the average bandwidth in kBps
- * @peak_bw: an integer describing the peak bandwidth in kBps
- */
-struct icc_req {
-	struct hlist_node req_node;
-	struct icc_node *node;
-	struct device *dev;
-	u32 tag;
-	u32 avg_bw;
-	u32 peak_bw;
-};
-
-/**
- * struct icc_path - interconnect path structure
- * @num_nodes: number of hops (nodes)
- * @reqs: array of the requests applicable to this path of nodes
- */
-struct icc_path {
-	size_t num_nodes;
-	struct icc_req reqs[];
-};
-
 static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
 {
 	if (!n)
diff --git a/drivers/interconnect/internal.h b/drivers/interconnect/internal.h
new file mode 100644
index 000000000000..5853e8faf223
--- /dev/null
+++ b/drivers/interconnect/internal.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Interconnect framework internal structs
+ *
+ * Copyright (c) 2019, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_INTERNAL_H
+#define __DRIVERS_INTERCONNECT_INTERNAL_H
+
+/**
+ * struct icc_req - constraints that are attached to each node
+ * @req_node: entry in list of requests for the particular @node
+ * @node: the interconnect node to which this constraint applies
+ * @dev: reference to the device that sets the constraints
+ * @tag: path tag (optional)
+ * @avg_bw: an integer describing the average bandwidth in kBps
+ * @peak_bw: an integer describing the peak bandwidth in kBps
+ */
+struct icc_req {
+	struct hlist_node req_node;
+	struct icc_node *node;
+	struct device *dev;
+	u32 tag;
+	u32 avg_bw;
+	u32 peak_bw;
+};
+
+/**
+ * struct icc_path - interconnect path structure
+ * @num_nodes: number of hops (nodes)
+ * @reqs: array of the requests applicable to this path of nodes
+ */
+struct icc_path {
+	size_t num_nodes;
+	struct icc_req reqs[];
+};
+
+#endif
