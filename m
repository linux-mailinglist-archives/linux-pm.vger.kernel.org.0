Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F5E74EE4D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 14:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjGKMUr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 08:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjGKMUP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 08:20:15 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939901718
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:19:27 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b63e5f94f1so70073031fa.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077941; x=1691669941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjEw0XoxZw/g1nfL12bHFSyvJYF4vER1wXRrobCe4VQ=;
        b=SO8G7gtbOhkPbaLWlVi2A26EGBnLGR8WhCcdISpfIxmVj2nnLs76mUyH9u5Yb2u/zl
         O23xnH972rd94DWKwWGzotqQfkg95kfDfWHlh5AwRuw1ZGZ4bY/8DqOBJTYTItniJ6Lj
         aQH/9+u3Vne8pGuwL8tZ738RoU25IpWGAj+cpGd8oqvT4Drh3wWkBBGPwZ8XTpE9+qxH
         YchmIVyssp9NL7wM2Ki7YOMCj60Qr+oA4/6793eA385fc9B6i2ASKEtGNhlj2cjXScM3
         tYk8EidHxGtCZY+XbqdO+hQND0yUzPS0xkzjN/ddpZsPdYtnrTAi2iSvEz5n+XSYzQLU
         DmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077941; x=1691669941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjEw0XoxZw/g1nfL12bHFSyvJYF4vER1wXRrobCe4VQ=;
        b=R6BVMrJpfogBBxkN2R4AR8NNM6L39vm1+KigcabwzbWMBgGF9Mq7joDHnPJTxswwwe
         7cHgbHhyZBPf1TTS3wSGikGzTSyhRouum7PEYwgWgllLuc/9/Q3kUwwDTdUw3SEK2PVr
         fU41QE2TgfCL5Oz0Q+84EPhnJWoM9sFy5JYvMnrKALQ4CJ/jIJz+uLKNETcvf7WItbG3
         HzrjOms/ylYkddGc2JxFKf8xZ/Rp20yJY7eLeXn2nDaZuTf3Gb+limRV2PMCTOiijukm
         QJrR4z09cu9jmjsGh+W5lGwZZBy3NaAZnCfPPN+/0P4vhIFs91m0YegnLjU1vlvTQqBs
         TSQA==
X-Gm-Message-State: ABy/qLbLoOXdMLjBXtBasfOte/HckAkPMnSFp2uGvdaRexLiiHEPExcC
        2SgyJ/to6K63TEtXE5+M27OLXA==
X-Google-Smtp-Source: APBJJlGKDLEVUmAQ4vDYyP+R6V2LmaGS1gibL6+XogxgT4lITsG4VyRmSVusTQuIFb+0n7h7tR0lUQ==
X-Received: by 2002:a2e:8e35:0:b0:2b6:ee7a:f5ae with SMTP id r21-20020a2e8e35000000b002b6ee7af5aemr7635646ljk.16.1689077941421;
        Tue, 11 Jul 2023 05:19:01 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:01 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:25 +0200
Subject: [PATCH 26/53] interconnect: qcom: qdu1000: Explicitly assign
 voter_idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-26-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=2723;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9xNumb4mlVPJURVONYP61q5QOzs9rfLdvbN1jnXwzpk=;
 b=IUepLalcILF7YN5hx4w8ucTFotgb8EVQk+WRRg8BB2vlIGoZ5lTxmAmV/VZbcNjfozWT0W6Bq
 V1lkz8druzNCYbmJ0YerskqCPBdQR+cpC3t0UpsAEdKCdRw2G5z5+Mu
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To avoid confusion, explicitly assign the BCM voter index.

Note the assignment may be incorrect, but this commit brings no
functional change.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/qdu1000.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/interconnect/qcom/qdu1000.c b/drivers/interconnect/qcom/qdu1000.c
index a4cf559de2b0..f9c54e9ad9d1 100644
--- a/drivers/interconnect/qcom/qdu1000.c
+++ b/drivers/interconnect/qcom/qdu1000.c
@@ -768,18 +768,21 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &ebi },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qxm_crypto },
 };
 
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 44,
 	.nodes = { &qhm_qpic, &qhm_qspi,
 		   &qnm_gemnoc_cnoc, &qnm_gemnoc_modem_slave,
@@ -808,24 +811,28 @@ static struct qcom_icc_bcm bcm_cn0 = {
 
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &ebi },
 };
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 2,
 	.nodes = { &qup0_core_slave, &qup1_core_slave },
 };
 
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_bcm bcm_sh1 = {
 	.name = "SH1",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 11,
 	.nodes = { &alm_sys_tcu, &chm_apps,
 		   &qnm_ecpri_dma, &qnm_fec_2_gemnoc,
@@ -838,12 +845,14 @@ static struct qcom_icc_bcm bcm_sh1 = {
 
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 6,
 	.nodes = { &qhm_gic, &qxm_pimem,
 		   &xm_gic, &xm_qdss_etr0,
@@ -853,6 +862,7 @@ static struct qcom_icc_bcm bcm_sn1 = {
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 5,
 	.nodes = { &qnm_aggre_noc, &qxm_ecpri_gsi,
 		   &xm_ecpri_dma, &qns_anoc_snoc_gsi,
@@ -862,6 +872,7 @@ static struct qcom_icc_bcm bcm_sn2 = {
 
 static struct qcom_icc_bcm bcm_sn7 = {
 	.name = "SN7",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 2,
 	.nodes = { &qns_pcie_gemnoc, &xs_pcie },
 };

-- 
2.41.0

