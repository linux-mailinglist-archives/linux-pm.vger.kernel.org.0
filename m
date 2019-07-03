Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C312B5DA71
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 03:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfGCBKp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 21:10:45 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:44425 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfGCBKo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 21:10:44 -0400
Received: by mail-pg1-f201.google.com with SMTP id a21so498653pgh.11
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2019 18:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dWSTEB7RleZh8XkGrKFTJOfmQbdpdA8YvLb6+yLjiBI=;
        b=GQP3lyPaiOWVdY7hddYL/HQhNvDTl81zOg4nL0V/I6lx5L0cBJkii5mqEgmUSkDIaU
         O3U9k5/hTnRIvVzHZX+BxSQA9Ul3gei1PEJdwTf5irvmc5BlbteZ+in5aiHi+OQUzltL
         jqzY6gGgQoYasy92jwTiE/fnngT4SR5BthJWETwbYHfwo0pHvmR8ECVWdg8cfU/w8bJN
         GeKuJk4Am5G9A1ZIAw/ic9QKTksdAMWj2qfn/ALIhP1LrFBEJVmahjxY3vL+3lHh3wpv
         B0bqCyOr87MhKPN/hTBrsgtaHUjc5OU/5L5P6SqNN07sN9O2KGy7rf9ONme5RwQk81sQ
         sIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dWSTEB7RleZh8XkGrKFTJOfmQbdpdA8YvLb6+yLjiBI=;
        b=ZpC+oV0m+JudMR3PPuV/OSArOydoJ8aMmFellqljILSMcwnxfw6oy0VGBkJkSpTV87
         xJhKPIASCW2Ot4ugUKdBdVFtAGNE8C+nQVz0vmk1YvYg2Cto+Ft6PHxrZrQjOE+mY1KM
         H5aB9a92ixIQ1mcMaLtozf9sw7lnuUw8MKZC3K4Qy8fI4c1vGVAu7H9cKIZy8ZhdDS9V
         iYnqMZw/IdQsTCcmz8rnC50E61Pt6AX435x2Z0Q12Q528ueBNFAlz5qJC2HK1JDxCCKN
         zvDS4x/DRFmBw1oaipKeQynk82Extjn6jhxRL4LEYs8E42Vlpu4R6+zNLIiaFL2WzFpO
         EBMQ==
X-Gm-Message-State: APjAAAVEfF3G4rnwamUIgK9eUF3a7MVCiKHpNApHmGKWbVfWYkRAMKUA
        JO73QkFeor/o3ZAYB7Vzw8y4qN2PI8hkLOw=
X-Google-Smtp-Source: APXvYqzWDTUputAqKDd6ILTyuM86jYoIJkzu7BT12HhgBGatoUR02aCN152bsgijRYOJekQeK0A37JZDsLThSyw=
X-Received: by 2002:a65:62c2:: with SMTP id m2mr34089166pgv.413.1562116243633;
 Tue, 02 Jul 2019 18:10:43 -0700 (PDT)
Date:   Tue,  2 Jul 2019 18:10:20 -0700
In-Reply-To: <20190703011020.151615-1-saravanak@google.com>
Message-Id: <20190703011020.151615-7-saravanak@google.com>
Mime-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 6/6] interconnect: Add OPP table support for interconnects
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>, vincent.guittot@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Interconnect paths can have different performance points. Now that OPP
framework supports bandwidth OPP tables, add OPP table support for
interconnects.

Devices can use the interconnect-opp-table DT property to specify OPP
tables for interconnect paths. And the driver can obtain the OPP table for
an interconnect path by calling icc_get_opp_table().

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/interconnect/core.c  | 27 ++++++++++++++++++++++++++-
 include/linux/interconnect.h |  7 +++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 871eb4bc4efc..881bac80bc1e 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -47,6 +47,7 @@ struct icc_req {
  */
 struct icc_path {
 	size_t num_nodes;
+	struct opp_table *opp_table;
 	struct icc_req reqs[];
 };
 
@@ -313,7 +314,7 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
 {
 	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
 	struct icc_node *src_node, *dst_node;
-	struct device_node *np = NULL;
+	struct device_node *np = NULL, *opp_node;
 	struct of_phandle_args src_args, dst_args;
 	int idx = 0;
 	int ret;
@@ -381,10 +382,34 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
 		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
 	mutex_unlock(&icc_lock);
 
+	opp_node = of_parse_phandle(np, "interconnect-opp-table", idx);
+	if (opp_node) {
+		path->opp_table = dev_pm_opp_of_find_table_from_node(opp_node);
+		of_node_put(opp_node);
+	}
+
+
 	return path;
 }
 EXPORT_SYMBOL_GPL(of_icc_get);
 
+/**
+ * icc_get_opp_table() - Get the OPP table that corresponds to a path
+ * @path: reference to the path returned by icc_get()
+ *
+ * This function will return the OPP table that corresponds to a path handle.
+ * If the interconnect API is disabled, NULL is returned and the consumer
+ * drivers will still build. Drivers are free to handle this specifically, but
+ * they don't have to.
+ *
+ * Return: opp_table pointer on success. NULL is returned when the API is
+ * disabled or the OPP table is missing.
+ */
+struct opp_table *icc_get_opp_table(struct icc_path *path)
+{
+	return path->opp_table;
+}
+
 /**
  * icc_set_bw() - set bandwidth constraints on an interconnect path
  * @path: reference to the path returned by icc_get()
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index dc25864755ba..0c0bc55f0e89 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -9,6 +9,7 @@
 
 #include <linux/mutex.h>
 #include <linux/types.h>
+#include <linux/pm_opp.h>
 
 /* macros for converting to icc units */
 #define Bps_to_icc(x)	((x) / 1000)
@@ -28,6 +29,7 @@ struct device;
 struct icc_path *icc_get(struct device *dev, const int src_id,
 			 const int dst_id);
 struct icc_path *of_icc_get(struct device *dev, const char *name);
+struct opp_table *icc_get_opp_table(struct icc_path *path);
 void icc_put(struct icc_path *path);
 int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
 
@@ -49,6 +51,11 @@ static inline void icc_put(struct icc_path *path)
 {
 }
 
+static inline struct opp_table *icc_get_opp_table(struct icc_path *path)
+{
+	return NULL;
+}
+
 static inline int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 {
 	return 0;
-- 
2.22.0.410.gd8fdbe21b5-goog

