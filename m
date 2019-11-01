Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2250BEC35A
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 14:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfKANAk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 09:00:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33531 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfKANAh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 09:00:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id s1so9625082wro.0
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2019 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zgv/LTWdUPNIRDPJwbY82R6L2iDmim3JZRo8TtTz+DY=;
        b=m2c6kB/LVRJSVWZHgdelDlqhnHhd5gEDgD5WOy08yss+OVxQy2bbNOOeJaFURNoD9b
         IY4afffJgN/frvFyhGmkcCMoq/UF7Sbh5NnoHOxAEsyVJ6bO68psGKCkJX9N0XRgRlFB
         JKW77qcnOQpcON/+CJ/eVyh8vtjYQYKpizevs/fyavmUpTrcFfLCi2L3t21CNocpfrDV
         nsTLEO0Q8YWTVScdy/et75XKbtTSLsjX7dIGEWdmjlf51ZUZYdZNgdOsgOVS99oZ8FvC
         j1GFB+IvgSxmIgZRtw4qnZPAaR0wfCueJW7nHNaAXt9B3G+5M0WSqI+G2nTMEfjvYRCz
         nugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zgv/LTWdUPNIRDPJwbY82R6L2iDmim3JZRo8TtTz+DY=;
        b=K+OfHUhq2cYnoBfmpocO/svBrZjH4WofbgOyExOhkqJAzX6Jksvflbk6NwxR8eMR+4
         ZBe733vjFC5zwdjAEedlX3ifaIi5iFbTezq88ucFyjk+CdFJ5x1YtZerH4iIdQAk5r51
         Tpxn94U5hdYZ/IwFStDw0JW3VblQch5w3pzmb0SrFps+3iYxDIYLR9u5pdwHhqE4QXJD
         7JyphnkNs8+x60R7ywJvg734K7xj4PtioScOnuA5GEWwBzCuRseszVrEYEdJ+SxUPK34
         psaMzUte+y1xqyPCAhPoIqY7qnQpzmUeSDqsUFy0JR609RuYN9lEbjYnivvss0/1dtcD
         Ob4A==
X-Gm-Message-State: APjAAAW6b5wPghWjVgvcz5G1pSx1iipen6M4bf883lAcFQoXkqLhiUGk
        PCkjfER+9gcW5GD6zigfVqWy3pUBK+0=
X-Google-Smtp-Source: APXvYqwVGRprB/tc1woV5aX/nx+Hv/+U5SrzfdXyQ9nfNAQlvzclYFxj361Z1IW2A+ySlxSqPA7lag==
X-Received: by 2002:adf:e8cf:: with SMTP id k15mr18778wrn.256.1572613234712;
        Fri, 01 Nov 2019 06:00:34 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id x7sm14208476wrg.63.2019.11.01.06.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Nov 2019 06:00:34 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v2 1/3] interconnect: Move internal structs into a separate file
Date:   Fri,  1 Nov 2019 15:00:29 +0200
Message-Id: <20191101130031.27996-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101130031.27996-1-georgi.djakov@linaro.org>
References: <20191101130031.27996-1-georgi.djakov@linaro.org>
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
index 56cc4bacea5b..86ca6245fe6e 100644
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
