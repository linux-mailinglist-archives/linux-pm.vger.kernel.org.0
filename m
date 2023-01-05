Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2508465E175
	for <lists+linux-pm@lfdr.de>; Thu,  5 Jan 2023 01:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbjAEAW3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Jan 2023 19:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbjAEAW1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Jan 2023 19:22:27 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C941E43A3E
        for <linux-pm@vger.kernel.org>; Wed,  4 Jan 2023 16:22:26 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id v25so5432086lfe.12
        for <linux-pm@vger.kernel.org>; Wed, 04 Jan 2023 16:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NMmTiUGV9FdUmug/UYdoZYx4aroDbr73GnE3YCbpaI=;
        b=aXDWs1rUKThWuSv0XaZges+BWAdi4FGvQ94RQts9a1uldSBdCQd9tn8os0tWrR0zs3
         HuPkmFZLFUyjb9C73vyNnjvdA4m2MvI5zRzXh4ETQyileKrSmyXLbzT5ivuxgvom3shz
         vs5cjCqLcMxOWzHAvWLjBTW54aWgo+l4SSSk+KNcm23AAIbdcvB0YDigGLHahxERaE/S
         tyHq0i/dJBEeRO+uMiEeW4na3ysFLJUwfnvu4lnAEuSPAKcmblB2690qDppViPmHaQ+i
         TwoPDYXbJqzK6lNC3+x6/auGesqsNswjUW23v/m+Ral41leWcBUxm3Ka7IJbMrpfswwk
         zDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NMmTiUGV9FdUmug/UYdoZYx4aroDbr73GnE3YCbpaI=;
        b=B0Z8AxPN94zHdgiiwhX2x1EiyF4RE0GejIOAzv/IvLpKS4VdQXhIpFsmvcRLeVAxxD
         BYQLzhwQWM3FcmMDCrUF3YFEuEAy9aRDZDCuhwqRtCpj97tPTgz0dkUsA4xhRZe+fDVo
         5e9DOHBW+1u2aE3iwQlY46fdSAAd39Yr8sr8rZMaiUtYUllbLXoklE3a3ns9hSYUoT1D
         9NudEnvHB8EfO1+TM4nJTCfEVqhftZ3GHPI9zVMnpaKiXjYvlzd1S8d0C3qS2CuNqUPd
         M1LOurBNW2hx08mgDTBLVm2EPBRxBkLiibs/kh1BV6SoNMbls+EEzQ2TKXVIoiO+vlcL
         b1JQ==
X-Gm-Message-State: AFqh2krIrmuGD//MuR2rA5r/ZRsu7HbxOMjRCe/kYC1F+uJguTcKYBPf
        DhoCJFnhqQZD/zhhp997QQkP8Q==
X-Google-Smtp-Source: AMrXdXsJqbZdjoEp+2dq+ytY4cwMflOU6RNck2fSP/PIoPEMXt3kw4RFQfbmnajicseYubv2ice4Gg==
X-Received: by 2002:a05:6512:3d08:b0:4b5:9b84:2366 with SMTP id d8-20020a0565123d0800b004b59b842366mr15797279lfv.58.1672878145191;
        Wed, 04 Jan 2023 16:22:25 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id d18-20020ac241d2000000b004b4cbc942a3sm5291992lfi.127.2023.01.04.16.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 16:22:24 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/3] interconnect: qcom: sm8450: switch to qcom_icc_rpmh_* function
Date:   Thu,  5 Jan 2023 02:22:20 +0200
Message-Id: <20230105002221.1416479-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105002221.1416479-1-dmitry.baryshkov@linaro.org>
References: <20230105002221.1416479-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change sm8450 interconnect driver to use generic qcom_icc_rpmh_*
functions rather than embedding a copy of thema. This also fixes an
overallocation of memory for icc_onecell_data structure.

Fixes: fafc114a468e ("interconnect: qcom: Add SM8450 interconnect provider driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/sm8450.c | 98 +-----------------------------
 1 file changed, 2 insertions(+), 96 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index e3a12e3d6e06..2d7a8e7b85ec 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -1844,100 +1844,6 @@ static const struct qcom_icc_desc sm8450_system_noc = {
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
-		dev_err(&pdev->dev, "error adding interconnect provider\n");
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
 	{ .compatible = "qcom,sm8450-aggre1-noc",
 	  .data = &sm8450_aggre1_noc},
@@ -1966,8 +1872,8 @@ static const struct of_device_id qnoc_of_match[] = {
 MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
-	.probe = qnoc_probe,
-	.remove = qnoc_remove,
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sm8450",
 		.of_match_table = qnoc_of_match,
-- 
2.39.0

