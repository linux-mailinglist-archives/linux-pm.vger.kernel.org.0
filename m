Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5154140731
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 10:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAQJ6Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 04:58:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35030 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgAQJ6Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 04:58:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so22029747wro.2
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 01:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oEZO1tHQEt0bWv28Oy3IvAVUFn4DqaeIaGai6PraEec=;
        b=wxhfBwQL5TJ5/9yiN3RRUZhvbaAPPzkRwHzceE/VHVWj5GUh+gxYgKe2jP+kwmzeMI
         EaHvdmSNhR9Opw+UwIewCo8H/OZ+xC44WdBtaYLGW6pw/+OWO4Y1NuKkTvFrCJXol58J
         70aYgF06gtm4NOgU6/s4hfIkDiLWb0RN25NaOyN/bu19vRvxn1dSvWIwHZiT//34vz8o
         esPVhMJNpnDTzyjuO2EEiSvSKriq/kQBzPpgmeN2w/JckYDrUXppa/xJle4iK6p5Oxug
         oI5z44S2FUUTxyYQW2vdalOX/KG75fWRRJF+8OWKdSlyn22OS1nuuPNXiw+L21bB5ESE
         tSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oEZO1tHQEt0bWv28Oy3IvAVUFn4DqaeIaGai6PraEec=;
        b=b5UKr3oY1nsOLbL5eJ7q9FgZOxljVG6//tg8QjHp8dq7GBJx/3Qvn1r5l+vTXM3JNN
         cVWL+VkSKMXawYg/3Q4oNKw6MzZihYby3JsSqZeEQ/i+SHEaAMEg3Ya7rQ9yDy8LU/4z
         XGYFT28BrPgvPLY2NKoY5G1aX/5TQAJbCNOurIQY7smadC3nnNUnW9KGZqIlBSYoHF+D
         wVfJY6tenIWFtOS/TiYYcmTlIOexmkbElsBF1OIpXL0K2ZuuhkrONp6Rg9wVU2RbakGL
         JV/udnROiZMa2/BEKHIUgcY9/pSgBIQawjHHoRUFRyNT4VWD0U7LfqBct0RI/v7ZEc+x
         TeGg==
X-Gm-Message-State: APjAAAWaDwbbaNTd/95ChMvdp66KFxgHHGr5tA6U6dSSNRaQoYTk4cza
        IjZu0CWI6hIAC62ksqCTHld3v+q3IkA=
X-Google-Smtp-Source: APXvYqwpFZ3pwsF1/ou9d0DgmDePMhDP3yynADnlPd6NBv83FW+DWmoD0ul6gRA+QrkhUB+1vzP6ZA==
X-Received: by 2002:adf:f28c:: with SMTP id k12mr2226628wro.360.1579255102370;
        Fri, 17 Jan 2020 01:58:22 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r62sm9967007wma.32.2020.01.17.01.58.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jan 2020 01:58:21 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 03/12] interconnect: Move internal structs into a separate file
Date:   Fri, 17 Jan 2020 11:58:07 +0200
Message-Id: <20200117095816.23575-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117095816.23575-1-georgi.djakov@linaro.org>
References: <20200117095816.23575-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Move the interconnect framework internal structs into a separate file,
so that it can be included and used by ftrace code. This will allow us
to expose some more useful information in the traces.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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
