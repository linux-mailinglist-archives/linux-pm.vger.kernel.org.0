Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D6565E177
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jan 2023 01:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbjAEAWb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Jan 2023 19:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbjAEAWa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Jan 2023 19:22:30 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040BB43A34
        for <linux-pm@vger.kernel.org>; Wed,  4 Jan 2023 16:22:29 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id cf42so52847389lfb.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Jan 2023 16:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ndoGo0L0trdB1SJI5vVwfFWDuQ8EsWjbtAz+We2f9E=;
        b=oTeMSShq7t40VB0qniYCwFnFoh8geFbWJjFWyePKeAgjzdjoGs8O8EFAeApKozOWrH
         EGJE4pajj7MZByog8CGg4xqNnal86ET28iJMtUwQgcXKaxTyPJmi+5/fO7GRCUPtbNr3
         xreAh/8FA+czumvdHjpIfPbAzfcegE1Po5Lor2dyfc8kx9E2l3r1PsU4k9qKgThJ6r0Q
         Kzo+VHWpzWkf666Rk2YMLQnee2l7EvzQYYfPudKauT12hMj7Ba0NLNr+MyO80M8l/amv
         5OH7+QunZ6eKii+k+egFL8DAhh6uLd0w6GVwsb8sWUtbsm9Fx3TZ7cbGDvG5UbQYEUms
         hyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ndoGo0L0trdB1SJI5vVwfFWDuQ8EsWjbtAz+We2f9E=;
        b=1wMsEj9jyqGrxI9xROSH4VvH+29YLyp7UR0ozrEa3XUZ30SEwOaJ1k9jn/+e2Xqa98
         q5S1z2XrdVRSq313aFXNKt+ZQJJ6syTGuy5o3rcaufvqjC7Y09YGx5cJTZyDZNIi2hAJ
         NscHMZact80Whtou3PPJ4UXoh/Cbb5OZAKbNrUssIt7tgE82GJ0Q9jecaDQJRSB3+Zud
         ESJcV+9LThbIr1eL1IiVnEAXsSQd+mHuz4Bi/p1NCrIPeswu6m8o60R7MONOsVR+sGBN
         aAlwTb+0lBOhEwzNygMZ1reyHrtF+O/w0WRgycpxXHluTC6nR6Q6tF0ZQ58p+clRCesf
         PDxw==
X-Gm-Message-State: AFqh2kpM5t8EbgfusGEH5JBBD2kN2rcJHxfAdZULdG7AhcnJWGd1EEBJ
        o0u0s4co/s31fLt/EMxA3w/VPA==
X-Google-Smtp-Source: AMrXdXtJFiQ17gwDglGRIuACrY0HZ132bP+xsoouZJ5HYi6uoB0LGj6sS88T+m8y9bEInVaCzLsxEg==
X-Received: by 2002:a05:6512:142:b0:4b5:a207:8d73 with SMTP id m2-20020a056512014200b004b5a2078d73mr12928034lfo.52.1672878147385;
        Wed, 04 Jan 2023 16:22:27 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id d18-20020ac241d2000000b004b4cbc942a3sm5291992lfi.127.2023.01.04.16.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 16:22:25 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 3/3] interconnect: qcom: sm8550: switch to qcom_icc_rpmh_* function
Date:   Thu,  5 Jan 2023 02:22:21 +0200
Message-Id: <20230105002221.1416479-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105002221.1416479-1-dmitry.baryshkov@linaro.org>
References: <20230105002221.1416479-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change sm8550 interconnect driver to use generic qcom_icc_rpmh_*
functions rather than embedding a copy of thema. This also fixes an
overallocation of memory for icc_onecell_data structure.

Fixes: e6f0d6a30f73 ("interconnect: qcom: Add SM8550 interconnect provider driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/sm8550.c | 99 +-----------------------------
 1 file changed, 2 insertions(+), 97 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8550.c b/drivers/interconnect/qcom/sm8550.c
index 54fa027ab961..d823ba988ef6 100644
--- a/drivers/interconnect/qcom/sm8550.c
+++ b/drivers/interconnect/qcom/sm8550.c
@@ -2165,101 +2165,6 @@ static const struct qcom_icc_desc sm8550_system_noc = {
 	.num_bcms = ARRAY_SIZE(system_noc_bcms),
 };
 
-static int qnoc_probe(struct platform_device *pdev)
-{
-	const struct qcom_icc_desc *desc;
-	struct icc_onecell_data *data;
-	struct icc_provider *provider;
-	struct qcom_icc_node * const *qnodes;
-	struct qcom_icc_provider *qp;
-	struct icc_node *node;
-	size_t num_nodes, i;
-	int ret;
-
-	desc = device_get_match_data(&pdev->dev);
-	if (!desc)
-		return -EINVAL;
-
-	qnodes = desc->nodes;
-	num_nodes = desc->num_nodes;
-
-	qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
-	if (!qp)
-		return -ENOMEM;
-
-	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	provider = &qp->provider;
-	provider->dev = &pdev->dev;
-	provider->set = qcom_icc_set;
-	provider->pre_aggregate = qcom_icc_pre_aggregate;
-	provider->aggregate = qcom_icc_aggregate;
-	provider->xlate_extended = qcom_icc_xlate_extended;
-	INIT_LIST_HEAD(&provider->nodes);
-	provider->data = data;
-
-	qp->dev = &pdev->dev;
-	qp->bcms = desc->bcms;
-	qp->num_bcms = desc->num_bcms;
-
-	qp->voter = of_bcm_voter_get(qp->dev, NULL);
-	if (IS_ERR(qp->voter))
-		return PTR_ERR(qp->voter);
-
-	ret = icc_provider_add(provider);
-	if (ret) {
-		dev_err_probe(&pdev->dev, ret,
-			      "error adding interconnect provider\n");
-		return ret;
-	}
-
-	for (i = 0; i < qp->num_bcms; i++)
-		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
-
-	for (i = 0; i < num_nodes; i++) {
-		size_t j;
-
-		if (!qnodes[i])
-			continue;
-
-		node = icc_node_create(qnodes[i]->id);
-		if (IS_ERR(node)) {
-			ret = PTR_ERR(node);
-			goto err;
-		}
-
-		node->name = qnodes[i]->name;
-		node->data = qnodes[i];
-		icc_node_add(node, provider);
-
-		for (j = 0; j < qnodes[i]->num_links; j++)
-			icc_link_create(node, qnodes[i]->links[j]);
-
-		data->nodes[i] = node;
-	}
-	data->num_nodes = num_nodes;
-
-	platform_set_drvdata(pdev, qp);
-
-	return 0;
-err:
-	icc_nodes_remove(provider);
-	icc_provider_del(provider);
-	return ret;
-}
-
-static int qnoc_remove(struct platform_device *pdev)
-{
-	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
-
-	icc_nodes_remove(&qp->provider);
-	icc_provider_del(&qp->provider);
-
-	return 0;
-}
-
 static const struct of_device_id qnoc_of_match[] = {
 	{ .compatible = "qcom,sm8550-aggre1-noc",
 	  .data = &sm8550_aggre1_noc},
@@ -2294,8 +2199,8 @@ static const struct of_device_id qnoc_of_match[] = {
 MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
-	.probe = qnoc_probe,
-	.remove = qnoc_remove,
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sm8550",
 		.of_match_table = qnoc_of_match,
-- 
2.39.0

