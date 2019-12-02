Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85CE310ED05
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 17:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfLBQVq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 11:21:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36600 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbfLBQVo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 11:21:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so45034682wru.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2019 08:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GH8jZgvcmqwZW7+ZZ9HpIyzBO+HHjblMrgUlhjTkr1o=;
        b=wwtDicZu/7SddGtkXbL33maSZtHCYO1JIf/RboO5KNIbTfhdubKaXiB0DDzKrNXSFd
         mvW7wprl/QvhrWIV6DVSHClsxvjmXgXb5C3Fdiom2wnOk+/ZqtUyKgua2NP3D7dgZwPl
         W4aEAsm+q7hDiDs3N+PdYefY9Yb1gL92Tiq2cJq7I8qz/k1fcHJTM4eY56UHAgpD+E5u
         9IM7JZegB0O6G+9j4AdIaykPuWdwa3oDEcv45hGOEq4foDjRFHRkxVfEz3St9EO7bl1m
         5S+QFGCE96gNpq2PMDEiHRgiVmCzFnpXQNj/Mn0rfk6KsiNM7xWjEIht+gBKGoR2XUXE
         8nkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GH8jZgvcmqwZW7+ZZ9HpIyzBO+HHjblMrgUlhjTkr1o=;
        b=UEDFE9+F2gHMq8dwF8TJFuQWv/cQsHTMt0Em8hTneSxykrTt+Z5C91OE/V97APaUU8
         s2CLerchZT/d7MlgCyvLeEqQNoQ0Y9gzHTLTO+qwJY/kO+8ctlZVCWEHauMvuKX/q5aZ
         WZSxCnsspcXQkCa4CJfFNTafkjDtgUIeNsJhPW3sQxJIvJUerD1ypBaQg+02Di5tMOmM
         fewjil9SKqeDKfkpJ/g/IGYxh/CeurvJskbk25RmpJvvcqPQUf6n0W8NuW5HSFfquj9j
         z9g2+iwK909nlpIyl0GWqzsYrVyHivit5fSc1QMi4ExZTou+SW9nHDaaPSGAX+mdKf3b
         skEg==
X-Gm-Message-State: APjAAAURmHelHh4O9aLzY2Qvr48759OhaqgSihtdOdaX+cOhti7+05S1
        n9AZ+ojP6IonDCwWeNn1tnnBJYtzQpg=
X-Google-Smtp-Source: APXvYqxQ41lsZfDRrcuKTvuCttSqE810g1FSOk7cNXrgWNOJ3ZSaBSAP/qUrkDe+9tsAVhFD4Yasug==
X-Received: by 2002:adf:b19a:: with SMTP id q26mr25103882wra.79.1575303701678;
        Mon, 02 Dec 2019 08:21:41 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id i9sm39204516wrb.2.2019.12.02.08.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Dec 2019 08:21:41 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, digetx@gmail.com,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        masneyb@onstation.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v2 5/5] interconnect: qcom: Use the new common helper for node removal
Date:   Mon,  2 Dec 2019 18:21:33 +0200
Message-Id: <20191202162133.7089-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202162133.7089-1-georgi.djakov@linaro.org>
References: <20191202162133.7089-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a new helper function for removing all nodes. Let's use it instead
of duplicating the code.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v2:
- Don't call qnoc_remove() directly from probe. (Dmitry)

 drivers/interconnect/qcom/msm8974.c | 17 ++++-------------
 drivers/interconnect/qcom/qcs404.c  | 17 ++++-------------
 drivers/interconnect/qcom/sdm845.c  | 16 +++-------------
 3 files changed, 11 insertions(+), 39 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index ca25f31e5f0b..3a313e11e73d 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -643,7 +643,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct icc_onecell_data *data;
 	struct icc_provider *provider;
-	struct icc_node *node, *tmp;
+	struct icc_node *node;
 	size_t num_nodes, i;
 	int ret;
 
@@ -723,10 +723,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 	return 0;
 
 err_del_icc:
-	list_for_each_entry_safe(node, tmp, &provider->nodes, node_list) {
-		icc_node_del(node);
-		icc_node_destroy(node->id);
-	}
+	icc_nodes_remove(provider);
 	icc_provider_del(provider);
 
 err_disable_clks:
@@ -738,16 +735,10 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 static int msm8974_icc_remove(struct platform_device *pdev)
 {
 	struct msm8974_icc_provider *qp = platform_get_drvdata(pdev);
-	struct icc_provider *provider = &qp->provider;
-	struct icc_node *n, *tmp;
 
-	list_for_each_entry_safe(n, tmp, &provider->nodes, node_list) {
-		icc_node_del(n);
-		icc_node_destroy(n->id);
-	}
+	icc_nodes_remove(&qp->provider);
 	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
-
-	return icc_provider_del(provider);
+	return icc_provider_del(&qp->provider);
 }
 
 static const struct of_device_id msm8974_noc_of_match[] = {
diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 9064f6bdaa69..d4769a5ea182 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -405,7 +405,7 @@ static int qnoc_probe(struct platform_device *pdev)
 	struct icc_provider *provider;
 	struct qcom_icc_node **qnodes;
 	struct qcom_icc_provider *qp;
-	struct icc_node *node, *tmp;
+	struct icc_node *node;
 	size_t num_nodes, i;
 	int ret;
 
@@ -485,10 +485,7 @@ static int qnoc_probe(struct platform_device *pdev)
 
 	return 0;
 err:
-	list_for_each_entry_safe(node, tmp, &provider->nodes, node_list) {
-		icc_node_del(node);
-		icc_node_destroy(node->id);
-	}
+	icc_nodes_remove(provider);
 	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
 	icc_provider_del(provider);
 
@@ -498,16 +495,10 @@ static int qnoc_probe(struct platform_device *pdev)
 static int qnoc_remove(struct platform_device *pdev)
 {
 	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
-	struct icc_provider *provider = &qp->provider;
-	struct icc_node *n, *tmp;
 
-	list_for_each_entry_safe(n, tmp, &provider->nodes, node_list) {
-		icc_node_del(n);
-		icc_node_destroy(n->id);
-	}
+	icc_nodes_remove(&qp->provider);
 	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
-
-	return icc_provider_del(provider);
+	return icc_provider_del(&qp->provider);
 }
 
 static const struct of_device_id qcs404_noc_of_match[] = {
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 387267ee9648..f078cf0fce56 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -855,11 +855,7 @@ static int qnoc_probe(struct platform_device *pdev)
 
 	return ret;
 err:
-	list_for_each_entry(node, &provider->nodes, node_list) {
-		icc_node_del(node);
-		icc_node_destroy(node->id);
-	}
-
+	icc_nodes_remove(provider);
 	icc_provider_del(provider);
 	return ret;
 }
@@ -867,15 +863,9 @@ static int qnoc_probe(struct platform_device *pdev)
 static int qnoc_remove(struct platform_device *pdev)
 {
 	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
-	struct icc_provider *provider = &qp->provider;
-	struct icc_node *n, *tmp;
-
-	list_for_each_entry_safe(n, tmp, &provider->nodes, node_list) {
-		icc_node_del(n);
-		icc_node_destroy(n->id);
-	}
 
-	return icc_provider_del(provider);
+	icc_nodes_remove(&qp->provider);
+	return icc_provider_del(&qp->provider);
 }
 
 static const struct of_device_id qnoc_of_match[] = {
