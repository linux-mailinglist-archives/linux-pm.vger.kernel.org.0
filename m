Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFAE8798A
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 14:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406732AbfHIMNc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 08:13:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45999 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406727AbfHIMNb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 08:13:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id a30so6304448lfk.12
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2019 05:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v4HP1f9I8mZkiZqFopwmMMkehyPq4NgMHQsfAEytrfU=;
        b=YNpI9pugYlzXXWEm7gvqKyZ01t+lvLxfzMQZiq59XfUVgFGPJSbUlfe4rqqKT0qjZt
         zP+128kHF9/RGUY6FezeDq/qvifSWqPdbxljDgOC6D0oM8xlzrh7EitXNjyYbu72NoyD
         G1RBLtHBAE+yXmg9p0uod0qMvwQtig15ihwTFoSKcE3N3OTQca80egF+ZDEK65CBdIXr
         5zHyABz9YSHvgVqC25nm+rkOuCOP+yAb8dhnX3YrQhv1yCjgzE3VLXDeM4FZSz+hZFtn
         l98vNV9rA0UNUpZJAJeWj8ITArn9q0Hx5MF4ploQT5yqdCdbYb+aWSCvTBvCayZWihjb
         egbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v4HP1f9I8mZkiZqFopwmMMkehyPq4NgMHQsfAEytrfU=;
        b=HWlv7Rgi+5BooeA380ZZxAimG/jJ82I1EWjX3QkIfDlXd+9aPqjQb3MYDMrZhYAbJj
         XSYyihN0yIqW6cRQ7sy/tqUPQ8tS1I3nvh6r8168uteAgyV3oRWessVWLfIEX+CTmT34
         0wD9gyB/3LaXfo5CSRFcoMoWIb1f72j8x7EckDwx8LgfUnZFV6ibP0J0/16YgpLlo7Ph
         0Zn2+uxMgmDZwILcOAxr0f5Hu3bQvv1wqdh5nCsATb5rgblOXVIoG300gj08z3N9MeS1
         nW69355E3BohBha1rfRIWI0XUmLoJLrRWviSPY6H78uRkSSQNcvzBXJILI1Ke6KXL3x5
         wyFw==
X-Gm-Message-State: APjAAAUhsjV63PEMWmgwK/hcA1PZpam5g7mKUHTUOMmXNlLDZ+X0WH8B
        1eBP+L4I9UNxFVAOHQq3IO89m/Vtjvs=
X-Google-Smtp-Source: APXvYqxmjyKjeMK8fWu72LvCNug/pYb/vqLExyqM5AiKSKKLOIVnzMvhRgy2sxOc2Cwh6GXm5loGfw==
X-Received: by 2002:ac2:54bc:: with SMTP id w28mr11690638lfk.17.1565352809592;
        Fri, 09 Aug 2019 05:13:29 -0700 (PDT)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id f23sm1083425lfc.25.2019.08.09.05.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Aug 2019 05:13:29 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, evgreen@chromium.org
Cc:     daidavid1@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        dianders@chromium.org, seansw@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v3 1/3] interconnect: Add support for path tags
Date:   Fri,  9 Aug 2019 15:13:23 +0300
Message-Id: <20190809121325.8138-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809121325.8138-1-georgi.djakov@linaro.org>
References: <20190809121325.8138-1-georgi.djakov@linaro.org>
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
