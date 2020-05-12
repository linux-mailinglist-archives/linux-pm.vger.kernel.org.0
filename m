Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA431CF503
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 14:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgELMyC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 08:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729901AbgELMx7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 08:53:59 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FBCC061A0F
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 05:53:59 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g14so9313422wme.1
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2020 05:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+rGKvfoFiAjDdQtTJ+6Vf7qeLWqTDG31CN5bbQtUQo8=;
        b=R9bsk+7Bfx6aoIZswCKHfN5y9yBMNHag58e4lfCBuVfHphfHNW9fb8fAa+v4hEOqHR
         jWKg8MG1csnW15D6ckwBgpCyyZtwk3rRq+T0DP6hrMm6FZmqP58jylNfhns/Pa4qDnfk
         OfFJHqXMukabQLkOuzbxfNYlfTQVCuWoOy0wTOhXRER6dIwsS6RETC6W1+Ua+jUnwZOU
         r/pOp2X0EgJaGApqO5iWRwEExGO5LXycsC8+b5gjb4bE4pGSfA5hPJAq+0M0YnxJ4WlH
         fero2AQKwoUddyP2V4V45egrl2kvvj19KEER8L0B5nmqccdJuPqgzW46McVZgvAVuhuQ
         ByJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+rGKvfoFiAjDdQtTJ+6Vf7qeLWqTDG31CN5bbQtUQo8=;
        b=GMft9NR7udemshT4QdleWqxJ2nV+1UQ6gtii99u8WaNEpHGGQT9cxhTdaoUZ0sMs4+
         A6Y7df3eVsNhkHizDy7kzbI+B6Os66uLTdkuvABMEiE4C+B1vDunLXtP7lAJTVg+ODxU
         5nUWEYR+q6bpkKKkkXPg4JlQfZjVtN0e6Lp/BoFhHQ7MmCmavjgrKWUR+6VBo0Jws4p2
         PAPJcecRkZ1k5geXo9XHE0E2+J1Un/SrKLogZmGdwJLFhMskoKJj40obdk6Th6En/0jJ
         4lrGVjzHc26rJLPaVXdewiN1O/4tUDUtUauY7lihvjBWoM3Zmqakm21ui7e3aob12Ae5
         e4ew==
X-Gm-Message-State: AGi0PuZuPKWSYcuUL6sAAKzs8XWg5cluMym6ob7cnIyxxX4q7LOQGvhy
        Vt2xYbdX4IThTcT3sITQiCxRhA==
X-Google-Smtp-Source: APiQypLVCbH0uBXG8DFqpYqzRwWsWiqSkdNCTz/vDUVtGWJZXox+WKeuIqWoT6/6hqCEQhI68x/oSQ==
X-Received: by 2002:a1c:c242:: with SMTP id s63mr27560918wmf.180.1589288038141;
        Tue, 12 May 2020 05:53:58 -0700 (PDT)
Received: from localhost.localdomain (212-39-89-66.ip.btc-net.bg. [212.39.89.66])
        by smtp.googlemail.com with ESMTPSA id n13sm2433938wrs.2.2020.05.12.05.53.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 05:53:57 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org
Cc:     robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v8 03/10] interconnect: Add of_icc_get_by_index() helper function
Date:   Tue, 12 May 2020 15:53:20 +0300
Message-Id: <20200512125327.1868-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512125327.1868-1-georgi.djakov@linaro.org>
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is the same as the traditional of_icc_get() function, but the
difference is that it takes index as an argument, instead of name.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v8:
* Dropped unneeded initializations.
* Picked reviewed-by tags.

 drivers/interconnect/core.c  | 72 +++++++++++++++++++++++++++---------
 include/linux/interconnect.h |  6 +++
 2 files changed, 60 insertions(+), 18 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 2c6515e3ecf1..aba5d38ea9d1 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -351,9 +351,9 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
 }
 
 /**
- * of_icc_get() - get a path handle from a DT node based on name
+ * of_icc_get_by_index() - get a path handle from a DT node based on index
  * @dev: device pointer for the consumer device
- * @name: interconnect path name
+ * @idx: interconnect path index
  *
  * This function will search for a path between two endpoints and return an
  * icc_path handle on success. Use icc_put() to release constraints when they
@@ -365,13 +365,12 @@ static struct icc_node *of_icc_get_from_provider(struct of_phandle_args *spec)
  * Return: icc_path pointer on success or ERR_PTR() on error. NULL is returned
  * when the API is disabled or the "interconnects" DT property is missing.
  */
-struct icc_path *of_icc_get(struct device *dev, const char *name)
+struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
 {
-	struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
+	struct icc_path *path;
 	struct icc_node *src_node, *dst_node;
-	struct device_node *np = NULL;
+	struct device_node *np;
 	struct of_phandle_args src_args, dst_args;
-	int idx = 0;
 	int ret;
 
 	if (!dev || !dev->of_node)
@@ -391,12 +390,6 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
 	 * lets support only global ids and extend this in the future if needed
 	 * without breaking DT compatibility.
 	 */
-	if (name) {
-		idx = of_property_match_string(np, "interconnect-names", name);
-		if (idx < 0)
-			return ERR_PTR(idx);
-	}
-
 	ret = of_parse_phandle_with_args(np, "interconnects",
 					 "#interconnect-cells", idx * 2,
 					 &src_args);
@@ -439,12 +432,8 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
 		return path;
 	}
 
-	if (name)
-		path->name = kstrdup_const(name, GFP_KERNEL);
-	else
-		path->name = kasprintf(GFP_KERNEL, "%s-%s",
-				       src_node->name, dst_node->name);
-
+	path->name = kasprintf(GFP_KERNEL, "%s-%s",
+			       src_node->name, dst_node->name);
 	if (!path->name) {
 		kfree(path);
 		return ERR_PTR(-ENOMEM);
@@ -452,6 +441,53 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
 
 	return path;
 }
+EXPORT_SYMBOL_GPL(of_icc_get_by_index);
+
+/**
+ * of_icc_get() - get a path handle from a DT node based on name
+ * @dev: device pointer for the consumer device
+ * @name: interconnect path name
+ *
+ * This function will search for a path between two endpoints and return an
+ * icc_path handle on success. Use icc_put() to release constraints when they
+ * are not needed anymore.
+ * If the interconnect API is disabled, NULL is returned and the consumer
+ * drivers will still build. Drivers are free to handle this specifically,
+ * but they don't have to.
+ *
+ * Return: icc_path pointer on success or ERR_PTR() on error. NULL is returned
+ * when the API is disabled or the "interconnects" DT property is missing.
+ */
+struct icc_path *of_icc_get(struct device *dev, const char *name)
+{
+	struct device_node *np;
+	int idx = 0;
+
+	if (!dev || !dev->of_node)
+		return ERR_PTR(-ENODEV);
+
+	np = dev->of_node;
+
+	/*
+	 * When the consumer DT node do not have "interconnects" property
+	 * return a NULL path to skip setting constraints.
+	 */
+	if (!of_find_property(np, "interconnects", NULL))
+		return NULL;
+
+	/*
+	 * We use a combination of phandle and specifier for endpoint. For now
+	 * lets support only global ids and extend this in the future if needed
+	 * without breaking DT compatibility.
+	 */
+	if (name) {
+		idx = of_property_match_string(np, "interconnect-names", name);
+		if (idx < 0)
+			return ERR_PTR(idx);
+	}
+
+	return of_icc_get_by_index(dev, idx);
+}
 EXPORT_SYMBOL_GPL(of_icc_get);
 
 /**
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index d70a914cba11..34e97231a6ab 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -28,6 +28,7 @@ struct device;
 struct icc_path *icc_get(struct device *dev, const int src_id,
 			 const int dst_id);
 struct icc_path *of_icc_get(struct device *dev, const char *name);
+struct icc_path *of_icc_get_by_index(struct device *dev, int idx);
 void icc_put(struct icc_path *path);
 int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
 void icc_set_tag(struct icc_path *path, u32 tag);
@@ -46,6 +47,11 @@ static inline struct icc_path *of_icc_get(struct device *dev,
 	return NULL;
 }
 
+static inline struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
+{
+	return NULL;
+}
+
 static inline void icc_put(struct icc_path *path)
 {
 }
