Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFAF2EC35D
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 14:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKANAl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 09:00:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38243 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfKANAj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 09:00:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id z19so4834493wmk.3
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2019 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vdqefEnwwSmeWlyY7LqNRP7A0Jfu2xnxdFd7DKez+Eg=;
        b=bUDJJG+23eqX6KZQoGdk2sEHTjQPmMr4vkBJVUs/pZZ6o0jCph4R8XrVXBu/gFj7wV
         HMnq/tWuzBWdq03vu+Q4gElsm7hp19gQa5MO1ZQhlJ6B5MHT0myv4Td2qRUAqZ2IB5SN
         fV5sHTqmRmljG9kEh5StGOdn1iwfPalyjActElCE4kNs1Sq7NLZbV7K3Ckhl56sSmdAX
         ztUqts+ijvXVUx2Hhgy3p7XMATkLB/i+cyNMJCSVIAv+X/uVDJ4nK/DCrUSTY1QyyPW0
         iUg++ah7iI3JRO9mKbHDVqRwtVzxXCMBAyQnuhd8fu3mAvVgO9lq5v1n5trX8KOkGukw
         +waA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vdqefEnwwSmeWlyY7LqNRP7A0Jfu2xnxdFd7DKez+Eg=;
        b=UnJBYxErO5YmSkFh/e8Oxh2wPtpUjoo7uopfrgUr8O7Gk3gSxZ3JmrXcVDuwC3wUlD
         QYoSBgb1c7oBYVyIeSqfwSXNSYs2Im8FJHK9KSjPenP6EOk0zDxQ3ufQNCjJgJsbOUMA
         eOYxz//C9+ZIt8PbLIDg337DFKoX+6/QqAVtN1xgFPT7YPj1f/V1q1SMnkMd6lp+6DSt
         FP0rxZcGLsmrAuDEm3V40eD4rkoaIoowmkpAxJz39f2SbZG5TwvTUD5Z8AsFSZz1t9Gw
         KHGwCdoGXW5rig3qeE2QCSov4bumRqoF3Jw/J6HQyANCPjNVtFmWpCZgnTbaPj67obMj
         GEIg==
X-Gm-Message-State: APjAAAUQUbvzo+PyvxxSlpJ8UKkMSGOxtrZfTnbPC2iPjNZumef/L8ih
        lCZpC4cFoJMMYdbxh6RpVG3X8SFlAmo=
X-Google-Smtp-Source: APXvYqxvhkfA4en93HsMZXZcrEg4ywjQHlN2xcKmJ6QSfkzisNRc1LTflF1kCytSr7J4643Kq4D8Rg==
X-Received: by 2002:a05:600c:21c4:: with SMTP id x4mr9758411wmj.172.1572613236108;
        Fri, 01 Nov 2019 06:00:36 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id x7sm14208476wrg.63.2019.11.01.06.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Nov 2019 06:00:35 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v2 2/3] interconnect: Add a name to struct icc_path
Date:   Fri,  1 Nov 2019 15:00:30 +0200
Message-Id: <20191101130031.27996-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101130031.27996-1-georgi.djakov@linaro.org>
References: <20191101130031.27996-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When debugging interconnect things, it turned out that saving the path
name and including it in the traces is quite useful, especially for
devices with multiple paths.

For the path name we use the one specified in DT, or if we use platform
data, the name is based on the source and destination node names.

Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c     | 18 +++++++++++++++---
 drivers/interconnect/internal.h |  2 ++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 86ca6245fe6e..df44ef713db5 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -356,9 +356,17 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
 
 	mutex_lock(&icc_lock);
 	path = path_find(dev, src_node, dst_node);
-	if (IS_ERR(path))
-		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
 	mutex_unlock(&icc_lock);
+	if (IS_ERR(path)) {
+		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
+		return path;
+	}
+
+	if (name)
+		path->name = kstrdup(name, GFP_KERNEL);
+	else
+		path->name = kasprintf(GFP_KERNEL, "%s-%s",
+				       src_node->name, dst_node->name);
 
 	return path;
 }
@@ -481,9 +489,12 @@ struct icc_path *icc_get(struct device *dev, const int src_id, const int dst_id)
 		goto out;
 
 	path = path_find(dev, src, dst);
-	if (IS_ERR(path))
+	if (IS_ERR(path)) {
 		dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
+		goto out;
+	}
 
+	path->name = kasprintf(GFP_KERNEL, "%s-%s", src->name, dst->name);
 out:
 	mutex_unlock(&icc_lock);
 	return path;
@@ -519,6 +530,7 @@ void icc_put(struct icc_path *path)
 	}
 	mutex_unlock(&icc_lock);
 
+	kfree(path->name);
 	kfree(path);
 }
 EXPORT_SYMBOL_GPL(icc_put);
diff --git a/drivers/interconnect/internal.h b/drivers/interconnect/internal.h
index 5853e8faf223..bf18cb7239df 100644
--- a/drivers/interconnect/internal.h
+++ b/drivers/interconnect/internal.h
@@ -29,10 +29,12 @@ struct icc_req {
 
 /**
  * struct icc_path - interconnect path structure
+ * @name: a string name of the path (useful for ftrace)
  * @num_nodes: number of hops (nodes)
  * @reqs: array of the requests applicable to this path of nodes
  */
 struct icc_path {
+	const char *name;
 	size_t num_nodes;
 	struct icc_req reqs[];
 };
