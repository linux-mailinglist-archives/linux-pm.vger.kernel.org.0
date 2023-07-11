Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500FE74EE56
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 14:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjGKMUr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 08:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjGKMUS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 08:20:18 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A21A1724
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:19:29 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6f52e1c5cso88506721fa.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Jul 2023 05:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077943; x=1691669943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=InZYjJK59SO/+Ay8B5RTmrMRVJCA6dyKOvQqkkaczAs=;
        b=Ot38pV7C2gN8XjT3a5GXRhNqRN1ECdxSL9pz3VG35IKSPv4mkY83Gas9yCZtIdgR/g
         ugCCJygr6AVsNLEuL3hR1zVCcl0YUnID+eznum23Lde1R52ENMPXUUuos+IxU9cKoiYy
         KJ++/JvtexC489swv/KXohpBH4d0AlyXiFPgE7aIGKYYRAzbAV5xwnFuoDEr4rxJ6RZk
         M8C5OIlMDrbshINYXvJ1IsfqfdED0/WTSYDI/rpuhnQdhf/pRrNLB6Nv1dNOSUQKNdh/
         Rl7plMlLJHYofbKYVDzCrhMPMLMF/MdJXe/9FQPLpIr+tewqJyuNmyBHgTE3Mn4zwMgC
         tleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077943; x=1691669943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InZYjJK59SO/+Ay8B5RTmrMRVJCA6dyKOvQqkkaczAs=;
        b=TUwW9ztcaFetz1L2jBvqbMkfXaT2F/9oP2AHh2fcvIPYdocjuUfZ5E1jMpBaTJIl3g
         H4qgrGMxpOTaoMBhPNIFZftm2pY4C9wTQ4JA5SEalW+4sE4GZF4NBYh+d1BziYju5roK
         U2/DgHlOb3H86Lv9003FzStepuLKegfB1tTkltjfLjzzq7cjPn3F1Imn1JejLubvXnQc
         QBlz5pH4WCHArq/wBEZq1SZ+M8SKdmsMjhqkEqP3kPdct2P6RJDmmTsC2HZr7UNvDLyq
         qjhVIbmVCeymQyoAnIGhC8GehVIWjJZ4wWT+Mj9mkFumvheREBf4Hsg727ktBKVkjHeE
         TqNA==
X-Gm-Message-State: ABy/qLb0qlljLYwzgptZc6vyDMXGsamRLIOsRGCYRLdVd6a1JQ2tlmV5
        9NYykExn09nhuvqqZZc1I8JDSg==
X-Google-Smtp-Source: APBJJlH/dO3vuT9rgke0QWGpDoFjOWQDqO0i+YvVXlS7/ci7XeSzZDVsjly6ryxGYykB3rTDrKQlsg==
X-Received: by 2002:a05:651c:1045:b0:2b6:d13a:8e34 with SMTP id x5-20020a05651c104500b002b6d13a8e34mr621168ljm.46.1689077942709;
        Tue, 11 Jul 2023 05:19:02 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:02 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:26 +0200
Subject: [PATCH 27/53] interconnect: qcom: sa8775p: Explicitly assign
 voter_idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-27-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=6180;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hOvbaOTw9Rft7PbhGwWzFvl3fJ55nEvjw1n3n0o+bvA=;
 b=bgBgJk9B9qnxSbwV2qtOwPqT0zxWHu4caPLE/qW7xFxyp0JDmlS4/+qKJ/fj7t1TS2QpTfbW1
 k9/9xeqbpMyBVZ8bZBghyIsifPl/3HndxIGab11sgNllsV5rphubazj
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/interconnect/qcom/sa8775p.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
index f56538669de0..0c8ef127f8a8 100644
--- a/drivers/interconnect/qcom/sa8775p.c
+++ b/drivers/interconnect/qcom/sa8775p.c
@@ -1873,6 +1873,7 @@ static struct qcom_icc_node srvc_snoc = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.enable_mask = 0x8,
 	.num_nodes = 1,
 	.nodes = { &ebi },
@@ -1880,6 +1881,7 @@ static struct qcom_icc_bcm bcm_acv = {
 
 static struct qcom_icc_bcm bcm_ce0 = {
 	.name = "CE0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 2,
 	.nodes = { &qxm_crypto_0, &qxm_crypto_1 },
 };
@@ -1887,12 +1889,14 @@ static struct qcom_icc_bcm bcm_ce0 = {
 static struct qcom_icc_bcm bcm_cn0 = {
 	.name = "CN0",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 2,
 	.nodes = { &qnm_gemnoc_cnoc, &qnm_gemnoc_pcie },
 };
 
 static struct qcom_icc_bcm bcm_cn1 = {
 	.name = "CN1",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 76,
 	.nodes = { &qhs_ahb2phy0, &qhs_ahb2phy1,
 		   &qhs_ahb2phy2, &qhs_ahb2phy3,
@@ -1936,6 +1940,7 @@ static struct qcom_icc_bcm bcm_cn1 = {
 
 static struct qcom_icc_bcm bcm_cn2 = {
 	.name = "CN2",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 4,
 	.nodes = { &qhs_qup0, &qhs_qup1,
 		   &qhs_qup2, &qhs_qup3 },
@@ -1943,18 +1948,21 @@ static struct qcom_icc_bcm bcm_cn2 = {
 
 static struct qcom_icc_bcm bcm_cn3 = {
 	.name = "CN3",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 2,
 	.nodes = { &xs_pcie_0, &xs_pcie_1 },
 };
 
 static struct qcom_icc_bcm bcm_gna0 = {
 	.name = "GNA0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qxm_dsp0 },
 };
 
 static struct qcom_icc_bcm bcm_gnb0 = {
 	.name = "GNB0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qxm_dsp1 },
 };
@@ -1962,6 +1970,7 @@ static struct qcom_icc_bcm bcm_gnb0 = {
 static struct qcom_icc_bcm bcm_mc0 = {
 	.name = "MC0",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &ebi },
 };
@@ -1969,6 +1978,7 @@ static struct qcom_icc_bcm bcm_mc0 = {
 static struct qcom_icc_bcm bcm_mm0 = {
 	.name = "MM0",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 5,
 	.nodes = { &qnm_camnoc_hf, &qnm_mdp0_0,
 		   &qnm_mdp0_1, &qnm_mdp1_0,
@@ -1977,6 +1987,7 @@ static struct qcom_icc_bcm bcm_mm0 = {
 
 static struct qcom_icc_bcm bcm_mm1 = {
 	.name = "MM1",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 7,
 	.nodes = { &qnm_camnoc_icp, &qnm_camnoc_sf,
 		   &qnm_video0, &qnm_video1,
@@ -1986,30 +1997,35 @@ static struct qcom_icc_bcm bcm_mm1 = {
 
 static struct qcom_icc_bcm bcm_nsa0 = {
 	.name = "NSA0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 2,
 	.nodes = { &qns_hcp, &qns_nsp_gemnoc },
 };
 
 static struct qcom_icc_bcm bcm_nsa1 = {
 	.name = "NSA1",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qxm_nsp },
 };
 
 static struct qcom_icc_bcm bcm_nsb0 = {
 	.name = "NSB0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 2,
 	.nodes = { &qns_nspb_gemnoc, &qns_nspb_hcp },
 };
 
 static struct qcom_icc_bcm bcm_nsb1 = {
 	.name = "NSB1",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qxm_nspb },
 };
 
 static struct qcom_icc_bcm bcm_pci0 = {
 	.name = "PCI0",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qns_pcie_mem_noc },
 };
@@ -2017,6 +2033,7 @@ static struct qcom_icc_bcm bcm_pci0 = {
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.vote_scale = 1,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
 };
@@ -2024,6 +2041,7 @@ static struct qcom_icc_bcm bcm_qup0 = {
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.vote_scale = 1,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qup1_core_slave },
 };
@@ -2031,6 +2049,7 @@ static struct qcom_icc_bcm bcm_qup1 = {
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
 	.vote_scale = 1,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 2,
 	.nodes = { &qup2_core_slave, &qup3_core_slave },
 };
@@ -2038,12 +2057,14 @@ static struct qcom_icc_bcm bcm_qup2 = {
 static struct qcom_icc_bcm bcm_sh0 = {
 	.name = "SH0",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_bcm bcm_sh2 = {
 	.name = "SH2",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &chm_apps },
 };
@@ -2051,42 +2072,49 @@ static struct qcom_icc_bcm bcm_sh2 = {
 static struct qcom_icc_bcm bcm_sn0 = {
 	.name = "SN0",
 	.keepalive = true,
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qns_gemnoc_sf },
 };
 
 static struct qcom_icc_bcm bcm_sn1 = {
 	.name = "SN1",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qns_gemnoc_gc },
 };
 
 static struct qcom_icc_bcm bcm_sn2 = {
 	.name = "SN2",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &qxs_pimem },
 };
 
 static struct qcom_icc_bcm bcm_sn3 = {
 	.name = "SN3",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 2,
 	.nodes = { &qns_a1noc_snoc, &qnm_aggre1_noc },
 };
 
 static struct qcom_icc_bcm bcm_sn4 = {
 	.name = "SN4",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 2,
 	.nodes = { &qns_a2noc_snoc, &qnm_aggre2_noc },
 };
 
 static struct qcom_icc_bcm bcm_sn9 = {
 	.name = "SN9",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 2,
 	.nodes = { &qns_sysnoc, &qnm_lpass_noc },
 };
 
 static struct qcom_icc_bcm bcm_sn10 = {
 	.name = "SN10",
+	.voter_idx = ICC_BCM_VOTER_APPS,
 	.num_nodes = 1,
 	.nodes = { &xs_qdss_stm },
 };

-- 
2.41.0

