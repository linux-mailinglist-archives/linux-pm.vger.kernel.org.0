Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48F11140732
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 10:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgAQJ6X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 04:58:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42940 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAQJ6W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 04:58:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so21967270wro.9
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 01:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jckVpy+7MLaoCGpB18Y5CDbGaFI7k6lN9q4aC94sn/w=;
        b=a7F+4NzaG6nErX9ZFsm8pI50tYua1LxgJ05Mid/gl91bgJv9k2cZUC4HWmck1C5Gk1
         SclLphlGq6kgHE0LY/FT7BCZgshPB+umWygv/bMdEboZ90rsmeOfEynEEdZWo4WAQd45
         3DJaLic6/Ocjjw27DmcBoa4wylG2EJpWMh6ysUpzEq54OyKZdCmb+tV+117gt2KjQTiC
         7g7b0VNvSkvv5WF7peAlIxwHcFgJjpHoeU6t8g0AR78gcmWEuLAJjzIjaUOJVxpK2/N6
         rhYPUnE6dcjba/K7YSzMryn/z50xvMSmcWfTJvSvCkpXRcQKkcH969T1K1GdufkzSulg
         OpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jckVpy+7MLaoCGpB18Y5CDbGaFI7k6lN9q4aC94sn/w=;
        b=MMjY0sE4qO1G1/VYAevZZLSa+ItzwquSxw33s+29gKSVStIiYOP7R79tHUOXIj8PVq
         BVJMJ+Flq15V1NFL29z/oyYeQXbA5brUdXXMHPgaf4FL+OB6p1hpbIfjfGMnGezIrz4m
         yCvQxdq7cYcLcn2FLE44DW6xb28MOd3+QRdYi/5/ThBPeleG20lyPfZRRh1Wn83svfY9
         iubgwKetmANmwyzKjXXet7HJHw5/sSzqj9aZIHc7pu8QAUv9khA7sfMk7pkYmDUO4eVg
         TPbR0INZ+EQ435HXgKLERYRel+NTZL4RU79Ff4C6VblhR/A6IgHxWZ7/8YBdC7SYOsgD
         tb5Q==
X-Gm-Message-State: APjAAAWlJvzPF/AlU3KgwCeq952mGGP5H4egHvzXONP0QJ+yUeZwhAXd
        78l2QxG7YTYtiMS75hE2jMkPmQ==
X-Google-Smtp-Source: APXvYqzIiC3YI/2B2zzYl/B5TRecNos/ii4Q8Q2wDhIo4FTTeo69JCuhMTeHUgPq6e6kpqfq1ZvO9Q==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr2181235wrh.121.1579255100900;
        Fri, 17 Jan 2020 01:58:20 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r62sm9967007wma.32.2020.01.17.01.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jan 2020 01:58:20 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 02/12] interconnect: qcom: Use the new common helper for node removal
Date:   Fri, 17 Jan 2020 11:58:06 +0200
Message-Id: <20200117095816.23575-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117095816.23575-1-georgi.djakov@linaro.org>
References: <20200117095816.23575-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a new helper function for removing all nodes. Let's use it instead
of duplicating the code.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/msm8974.c | 17 ++++-------------
 drivers/interconnect/qcom/qcs404.c  | 17 ++++-------------
 drivers/interconnect/qcom/sdm845.c  | 16 +++-------------
 3 files changed, 11 insertions(+), 39 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index bf8bd1aee358..e669a1f726d2 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -652,7 +652,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct icc_onecell_data *data;
 	struct icc_provider *provider;
-	struct icc_node *node, *tmp;
+	struct icc_node *node;
 	size_t num_nodes, i;
 	int ret;
 
@@ -732,10 +732,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 	return 0;
 
 err_del_icc:
-	list_for_each_entry_safe(node, tmp, &provider->nodes, node_list) {
-		icc_node_del(node);
-		icc_node_destroy(node->id);
-	}
+	icc_nodes_remove(provider);
 	icc_provider_del(provider);
 
 err_disable_clks:
@@ -747,16 +744,10 @@ static int msm8974_icc_probe(struct platform_device *pdev)
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
index 8e0735a87040..c8eb1276cce8 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -414,7 +414,7 @@ static int qnoc_probe(struct platform_device *pdev)
 	struct icc_provider *provider;
 	struct qcom_icc_node **qnodes;
 	struct qcom_icc_provider *qp;
-	struct icc_node *node, *tmp;
+	struct icc_node *node;
 	size_t num_nodes, i;
 	int ret;
 
@@ -494,10 +494,7 @@ static int qnoc_probe(struct platform_device *pdev)
 
 	return 0;
 err:
-	list_for_each_entry_safe(node, tmp, &provider->nodes, node_list) {
-		icc_node_del(node);
-		icc_node_destroy(node->id);
-	}
+	icc_nodes_remove(provider);
 	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
 	icc_provider_del(provider);
 
@@ -507,16 +504,10 @@ static int qnoc_probe(struct platform_device *pdev)
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
