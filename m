Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE6210C987
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 14:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfK1Nep (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 08:34:45 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50293 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfK1Nep (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 08:34:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id l17so11019556wmh.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2019 05:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8VrphYeqahrQ5kATlO0grU5q+TZ5g96u9ghQO6Q2fFc=;
        b=w7KZ1TIqRorqFk6V1hPTFmPCV+1JsZnF6guXwmyWEmd2W7y9YMCY2uwvxnvykWSA6f
         OsOSqJsju0xA5ElMwpLTwVTRv+KgcOwVqfZccUsaSaxCRkyLOSj0qvii+PazYdpeCffQ
         IC4Xunj4UuQIFPzmkkZANHwXqAB64nMhMa+ixovKeNQUyJtjA9TjeYonMCz20PF1aonP
         A33R5BIWPqXSNyxyGTgTP0WYofOi2L1YNjBeTEXqgCAJH7ZCXxOuZP13AGhJLI9pqIqn
         ZeNR8Op/b22RzqQAWtf4p1HVMSovwHjxeyFFkV0+fLXM6lwm21OXN5OetG6ysGEnCuc/
         o80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8VrphYeqahrQ5kATlO0grU5q+TZ5g96u9ghQO6Q2fFc=;
        b=IjcOom8F6pUeDcgsU1tRDdLFKjU8PNBGPPW33oU3XdVcN9kPdyYaC7LWr5Co2JACpj
         AZl6k9xHhbzA6EI+dzDNWPGbD/FXQC70zCmLQ6YaLqesHsmJeu1wqU9Ooi74A2qc3J4H
         yjJ2J9moGdqKgGH9FKjEk3zKteHqAyIitb0HLz6jEm7Jpf6OcFI9P02Uq7Fgglr4Gljd
         MSH54/JqFlKtxo2DLrLywOvgrva0VpH16udnZaQB6vPsy3lI0NF4ZyU/37jISbpHCWW3
         uYyDjLNLpKf5CG69VVQP6bTl755qLxj1fF2OQtBQRZEqFzI0Mjr/IYpDzknkNUWD0DvR
         6gEw==
X-Gm-Message-State: APjAAAXKg/6p5eNB2a+CVpaCuXBWojyNif5g13VTeUAJZG6AAmv3eRse
        eU4256hsivhM+DFQ4X6wJTE6YCHmNOc=
X-Google-Smtp-Source: APXvYqyDndcOfTmJ55lnby2VAYUUKyUwBpprxa7XtgXE/tKbSY5omtNvM2XPx2ePvPyTj7Mg+KyTJQ==
X-Received: by 2002:a1c:1b88:: with SMTP id b130mr8979340wmb.4.1574948082044;
        Thu, 28 Nov 2019 05:34:42 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y20sm2220451wmi.25.2019.11.28.05.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 05:34:41 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, digetx@gmail.com,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        masneyb@onstation.org, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH 5/5] interconnect: qcom: Use the new common helper for node removal
Date:   Thu, 28 Nov 2019 15:34:35 +0200
Message-Id: <20191128133435.25667-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128133435.25667-1-georgi.djakov@linaro.org>
References: <20191128133435.25667-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a new helper function for removing all nodes. Let's use it instead
of duplicating the code.

In addition to the above, instead of duplicating the code, simplify the
probe function error path by calling driver removal function directly.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/msm8974.c | 40 ++++++++++-------------------
 drivers/interconnect/qcom/qcs404.c  | 31 ++++++++--------------
 drivers/interconnect/qcom/sdm845.c  | 29 +++++++--------------
 3 files changed, 33 insertions(+), 67 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index 0a1a8ba6afa7..8823dce811c3 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -644,6 +644,15 @@ static int msm8974_icc_set(struct icc_node *src, struct icc_node *dst)
 	return 0;
 }
 
+static int msm8974_icc_remove(struct platform_device *pdev)
+{
+	struct msm8974_icc_provider *qp = platform_get_drvdata(pdev);
+
+	icc_nodes_remove(&qp->provider);
+	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+	return icc_provider_del(&qp->provider);
+}
+
 static int msm8974_icc_probe(struct platform_device *pdev)
 {
 	const struct msm8974_icc_desc *desc;
@@ -701,7 +710,8 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 	ret = icc_provider_add(provider);
 	if (ret) {
 		dev_err(dev, "error adding interconnect provider: %d\n", ret);
-		goto err_disable_clks;
+		clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+		return ret;
 	}
 
 	for (i = 0; i < num_nodes; i++) {
@@ -710,7 +720,7 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 		node = icc_node_create(qnodes[i]->id);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
-			goto err_del_icc;
+			goto err;
 		}
 
 		node->name = qnodes[i]->name;
@@ -731,34 +741,12 @@ static int msm8974_icc_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_del_icc:
-	list_for_each_entry_safe(node, &provider->nodes, node_list) {
-		icc_node_del(node);
-		icc_node_destroy(node->id);
-	}
-	icc_provider_del(provider);
-
-err_disable_clks:
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+err:
+	msm8974_icc_remove(pdev);
 
 	return ret;
 }
 
-static int msm8974_icc_remove(struct platform_device *pdev)
-{
-	struct msm8974_icc_provider *qp = platform_get_drvdata(pdev);
-	struct icc_provider *provider = &qp->provider;
-	struct icc_node *n;
-
-	list_for_each_entry_safe(n, &provider->nodes, node_list) {
-		icc_node_del(n);
-		icc_node_destroy(n->id);
-	}
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
-
-	return icc_provider_del(provider);
-}
-
 static const struct of_device_id msm8974_noc_of_match[] = {
 	{ .compatible = "qcom,msm8974-bimc", .data = &msm8974_bimc},
 	{ .compatible = "qcom,msm8974-cnoc", .data = &msm8974_cnoc},
diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index d2b455021416..a4c6ba715f61 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -406,6 +406,15 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	return 0;
 }
 
+static int qnoc_remove(struct platform_device *pdev)
+{
+	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
+
+	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
+	icc_nodes_remove(&qp->provider);
+	return icc_provider_del(&qp->provider);
+}
+
 static int qnoc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -494,31 +503,11 @@ static int qnoc_probe(struct platform_device *pdev)
 
 	return 0;
 err:
-	list_for_each_entry_safe(node, &provider->nodes, node_list) {
-		icc_node_del(node);
-		icc_node_destroy(node->id);
-	}
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
-	icc_provider_del(provider);
+	qnoc_remove(pdev);
 
 	return ret;
 }
 
-static int qnoc_remove(struct platform_device *pdev)
-{
-	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
-	struct icc_provider *provider = &qp->provider;
-	struct icc_node *n;
-
-	list_for_each_entry_safe(n, &provider->nodes, node_list) {
-		icc_node_del(n);
-		icc_node_destroy(n->id);
-	}
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
-
-	return icc_provider_del(provider);
-}
-
 static const struct of_device_id qcs404_noc_of_match[] = {
 	{ .compatible = "qcom,qcs404-bimc", .data = &qcs404_bimc },
 	{ .compatible = "qcom,qcs404-pcnoc", .data = &qcs404_pcnoc },
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 924c2d056d85..2b8f13e78471 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -768,6 +768,14 @@ static int cmp_vcd(const void *_l, const void *_r)
 		return 1;
 }
 
+static int qnoc_remove(struct platform_device *pdev)
+{
+	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
+
+	icc_nodes_remove(&qp->provider);
+	return icc_provider_del(&qp->provider);
+}
+
 static int qnoc_probe(struct platform_device *pdev)
 {
 	const struct qcom_icc_desc *desc;
@@ -855,29 +863,10 @@ static int qnoc_probe(struct platform_device *pdev)
 
 	return ret;
 err:
-	list_for_each_entry(node, &provider->nodes, node_list) {
-		icc_node_del(node);
-		icc_node_destroy(node->id);
-	}
-
-	icc_provider_del(provider);
+	qnoc_remove(pdev);
 	return ret;
 }
 
-static int qnoc_remove(struct platform_device *pdev)
-{
-	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
-	struct icc_provider *provider = &qp->provider;
-	struct icc_node *n;
-
-	list_for_each_entry_safe(n, &provider->nodes, node_list) {
-		icc_node_del(n);
-		icc_node_destroy(n->id);
-	}
-
-	return icc_provider_del(provider);
-}
-
 static const struct of_device_id qnoc_of_match[] = {
 	{ .compatible = "qcom,sdm845-rsc-hlos", .data = &sdm845_rsc_hlos },
 	{ },
