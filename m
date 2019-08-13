Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 683718BC1A
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 16:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfHMOxu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 10:53:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40057 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbfHMOxu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 10:53:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id e27so6681424ljb.7
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2019 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y81htq0qWga2/VQdP2NnxV1AFdEaOoqWk/i4jXZklUs=;
        b=jXTzuTFEFDiZV2QAxMYNPLSt8fvMT7nuiiwiLWUveK8qo34SZTRX5ronDf5drNmVmJ
         gaXgeh5svX208l/ojeW4DHZRfOnpDUJP1xeLrPJNGVi0XsodrlGdlpMewGmxys+NH9lb
         m+UKtBufS5TsYHmNXgCphkAaqT2xJZbPqHyir9w1hvcOfhjXuR7/oY2lmasooVPK8BRi
         G2PWJ2dh5/ZPn1sdDKyr8Fq/XgHwNPm1cBsXvZar7nL6L5DIZtmBliz0vaDq4mUuhEPV
         X11mXrV5pHK2YlvZM56V6yRbLPl+K/YMF/OGWEbi86OPdZ3zT26y8dC0TATmPVEzrkyE
         0E9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y81htq0qWga2/VQdP2NnxV1AFdEaOoqWk/i4jXZklUs=;
        b=naU8tfw6xnMBnHd/7j3EzJSYJRYOONxItSQX82RxE43SoOMM78awObY/2Ik314mtqu
         +keTaZhJTcwrPqPZaVZ4+TsvWctBBgKaWJe6OCiPY3ncCEKZuaNdW7wI/7ff6bdbu1Ry
         kkfADQ/FOlIbID+ZyCRYRDvxEFCkPYYGYNbQbgqyqOKs/AD10d5A+xyZSPPPkFFvbLdk
         KhO9dQi5/Rp49eLR9283ATg+Kvw1eQ4O401k+LR9dbmVuPycesF5z8xdrLWmPdh5TGmz
         iYoWz2mRTbL822UyYHbBuN4vpPykhz/mZGRXlqhkcJPiZj0IJoNAfmS6Nwu6rQkFX7Ke
         7juQ==
X-Gm-Message-State: APjAAAX222kc1c0b1V9Mru4/akjWdmA60VMgaMgvmnoLApNqYnmFgrw3
        hGlu9pzyO2CbuV7plBEgjro7JM/irMI=
X-Google-Smtp-Source: APXvYqxrn54bNkxbTxOvMSXY4AaWq7/wup5YqNr3G36g5D7q0jr2XqfZzPL4m5lhoijit1CZcVqHvg==
X-Received: by 2002:a05:651c:29b:: with SMTP id b27mr13462823ljo.74.1565708027750;
        Tue, 13 Aug 2019 07:53:47 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r68sm19628100lff.52.2019.08.13.07.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 07:53:47 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, evgreen@chromium.org
Cc:     daidavid1@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        dianders@chromium.org, seansw@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v4 1/3] interconnect: Add support for path tags
Date:   Tue, 13 Aug 2019 17:53:39 +0300
Message-Id: <20190813145341.28530-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190813145341.28530-1-georgi.djakov@linaro.org>
References: <20190813145341.28530-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Consumers may have use cases with different bandwidth requirements based
on the system or driver state. The consumer driver can append a specific
tag to the path and pass this information to the interconnect platform
driver to do the aggregation based on this state.

Introduce icc_set_tag() function that will allow the consumers to append
an optional tag to each path. The aggregation of these tagged paths is
platform specific.

Reviewed-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c           | 24 +++++++++++++++++++++++-
 drivers/interconnect/qcom/sdm845.c    |  2 +-
 include/linux/interconnect-provider.h |  4 ++--
 include/linux/interconnect.h          |  5 +++++
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 871eb4bc4efc..251354bb7fdc 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -29,6 +29,7 @@ static struct dentry *icc_debugfs_dir;
  * @req_node: entry in list of requests for the particular @node
  * @node: the interconnect node to which this constraint applies
  * @dev: reference to the device that sets the constraints
+ * @tag: path tag (optional)
  * @avg_bw: an integer describing the average bandwidth in kBps
  * @peak_bw: an integer describing the peak bandwidth in kBps
  */
@@ -36,6 +37,7 @@ struct icc_req {
 	struct hlist_node req_node;
 	struct icc_node *node;
 	struct device *dev;
+	u32 tag;
 	u32 avg_bw;
 	u32 peak_bw;
 };
@@ -204,7 +206,7 @@ static int aggregate_requests(struct icc_node *node)
 	node->peak_bw = 0;
 
 	hlist_for_each_entry(r, &node->req_list, req_node)
-		p->aggregate(node, r->avg_bw, r->peak_bw,
+		p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
 			     &node->avg_bw, &node->peak_bw);
 
 	return 0;
@@ -385,6 +387,26 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
 }
 EXPORT_SYMBOL_GPL(of_icc_get);
 
+/**
+ * icc_set_tag() - set an optional tag on a path
+ * @path: the path we want to tag
+ * @tag: the tag value
+ *
+ * This function allows consumers to append a tag to the requests associated
+ * with a path, so that a different aggregation could be done based on this tag.
+ */
+void icc_set_tag(struct icc_path *path, u32 tag)
+{
+	int i;
+
+	if (!path)
+		return;
+
+	for (i = 0; i < path->num_nodes; i++)
+		path->reqs[i].tag = tag;
+}
+EXPORT_SYMBOL_GPL(icc_set_tag);
+
 /**
  * icc_set_bw() - set bandwidth constraints on an interconnect path
  * @path: reference to the path returned by icc_get()
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 4915b78da673..fb526004c82e 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -626,7 +626,7 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 	bcm->dirty = false;
 }
 
-static int qcom_icc_aggregate(struct icc_node *node, u32 avg_bw,
+static int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 			      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
 {
 	size_t i;
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 63caccadc2db..4ee19fd41568 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -45,8 +45,8 @@ struct icc_provider {
 	struct list_head	provider_list;
 	struct list_head	nodes;
 	int (*set)(struct icc_node *src, struct icc_node *dst);
-	int (*aggregate)(struct icc_node *node, u32 avg_bw, u32 peak_bw,
-			 u32 *agg_avg, u32 *agg_peak);
+	int (*aggregate)(struct icc_node *node, u32 tag, u32 avg_bw,
+			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
 	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
 	struct device		*dev;
 	int			users;
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index dc25864755ba..d70a914cba11 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -30,6 +30,7 @@ struct icc_path *icc_get(struct device *dev, const int src_id,
 struct icc_path *of_icc_get(struct device *dev, const char *name);
 void icc_put(struct icc_path *path);
 int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
+void icc_set_tag(struct icc_path *path, u32 tag);
 
 #else
 
@@ -54,6 +55,10 @@ static inline int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	return 0;
 }
 
+static inline void icc_set_tag(struct icc_path *path, u32 tag)
+{
+}
+
 #endif /* CONFIG_INTERCONNECT */
 
 #endif /* __LINUX_INTERCONNECT_H */
