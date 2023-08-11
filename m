Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC6F778F04
	for <lists+linux-pm@lfdr.de>; Fri, 11 Aug 2023 14:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbjHKMQd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Aug 2023 08:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbjHKMQI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2023 08:16:08 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6B635B0
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 05:15:47 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so29511061fa.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Aug 2023 05:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691756146; x=1692360946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plFxWu6MrnjklTKyfUiQRogMzOBwj0uVmuM1ybjVJ0M=;
        b=vUj0BmX+WL1A24Rt8soYTJlfN1bcCo9rfCH3ylrIi6mVhlMLn7fGYCDZ9k4wNjke+n
         ZpB7dzPImyCdMDn0l/tEppIxjeMk2qbqWjxo2JOuNP7CJEWuML3VkVG1w7JY+2TQ5OLN
         4yGvPtk2RTCCzVTmdFgTiX21NQkIs4nKrnxz3kzf/hBXGAVVOdXFeD1KZt7uZr6OiKjk
         WrxA+ysaLdqe/MTHx7UBQS/dvE9mcK/1bLMfnzyDZW6NYwaL/x2ZKdvwrXXNBmAniXse
         FAfFHbqH+EAzN2beac4Ca2Xyqb2Bb+42kxRpOTQDRpg1ND4SpKcNuh+jQOVm2xGU9Kvf
         Gvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756146; x=1692360946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plFxWu6MrnjklTKyfUiQRogMzOBwj0uVmuM1ybjVJ0M=;
        b=SrtRwHHGTNY4T6sf7m9EFK33X4BRUMvAsS9lO8vAFbxd2EPIMJHyVttIINSyeDaDX/
         Tg/TIjk2voWv9tY0BJHC62tGSjYm+U8hZmT4AI1cRo/9pbVRTWeAWGw4RFWtW6iWiYmb
         5yxPyt1WtbilmMIHu3CZ9UxffBSvWRO8vCRC59u88Z9ePa3a2qbfrivm1cGLr3D+BV9Z
         0Nb1qTDS3qHvua9WpkW1n4VWQcFv5NcOMcvq3IxuFKgLvpIG3OxKxRwnDLCZv/7S5i6F
         uQRm2GZ33UkbRX6B+0g9Qr1NqLb+q5pZcxEDOdkCDhhY09Ff9tRzwkcG1fUSl19FyTov
         inkg==
X-Gm-Message-State: AOJu0Yx/Z2TX64qgnnwoaHxV0695NJIGoa+gVuhMR3qweBWgw6SihH99
        xVIGVb5mvXtjyyiVzCen3E3ki3xYPv1GSPLsm+8=
X-Google-Smtp-Source: AGHT+IFGiYb1H114UT+2FepHwg2cP+bceINb6jCRhyeufKXS4JZRn/28WedlYIsBkDS6Wh86fMmNfQ==
X-Received: by 2002:a2e:9d88:0:b0:2b6:d7d1:95bf with SMTP id c8-20020a2e9d88000000b002b6d7d195bfmr1577248ljj.9.1691756146188;
        Fri, 11 Aug 2023 05:15:46 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id m12-20020a2e870c000000b002b9ec22d9fasm848487lji.29.2023.08.11.05.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:15:45 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 14:15:26 +0200
Subject: [PATCH 15/20] interconnect: qcom: sdx65: Retire DEFINE_QBCM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-icc_retire_macrosd-v1-15-c03aaeffc769@linaro.org>
References: <20230811-topic-icc_retire_macrosd-v1-0-c03aaeffc769@linaro.org>
In-Reply-To: <20230811-topic-icc_retire_macrosd-v1-0-c03aaeffc769@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691756124; l=5498;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=+bCZbOUjtABeEewpBsHIYTDZR0ZkPtJzO7JFJS0jyLk=;
 b=dFLyPKARrtKHqgsiwiptuc5L3IWc0vD32q/B8Je4yxy91yEJOO6t0a/tqghFym+BGTPCVQRq8
 5rQuOdyvfOwBShSjktgjgy4KOVvD9Xhji9AvEBycpoMOV2RVcwakJfn
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The struct definition macros are hard to read and comapre, expand them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sdx65.c | 185 +++++++++++++++++++++++++++++++++-----
 1 file changed, 165 insertions(+), 20 deletions(-)

diff --git a/drivers/interconnect/qcom/sdx65.c b/drivers/interconnect/qcom/sdx65.c
index 6ebfd835c714..d3a6c6c148e5 100644
--- a/drivers/interconnect/qcom/sdx65.c
+++ b/drivers/interconnect/qcom/sdx65.c
@@ -604,26 +604,171 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.buswidth = 8,
 };
 
-DEFINE_QBCM(bcm_ce0, "CE0", false, &qxm_crypto);
-DEFINE_QBCM(bcm_mc0, "MC0", true, &ebi);
-DEFINE_QBCM(bcm_pn0, "PN0", true, &qhm_snoc_cfg, &qhs_aoss, &qhs_apss, &qhs_audio, &qhs_blsp1, &qhs_clk_ctl, &qhs_crypto0_cfg, &qhs_ddrss_cfg, &qhs_ecc_cfg, &qhs_imem_cfg, &qhs_ipa, &qhs_mss_cfg, &qhs_pcie_parf, &qhs_pdm, &qhs_prng, &qhs_qdss_cfg, &qhs_qpic, &qhs_sdc1, &qhs_snoc_cfg, &qhs_spmi_fetcher, &qhs_spmi_vgi_coex, &qhs_tcsr, &qhs_tlmm, &qhs_usb3, &qhs_usb3_phy, &srvc_snoc);
-DEFINE_QBCM(bcm_pn1, "PN1", false, &xm_sdc1);
-DEFINE_QBCM(bcm_pn2, "PN2", false, &qhm_audio, &qhm_spmi_fetcher1);
-DEFINE_QBCM(bcm_pn3, "PN3", false, &qhm_blsp1, &qhm_qpic);
-DEFINE_QBCM(bcm_pn4, "PN4", false, &qxm_crypto);
-DEFINE_QBCM(bcm_sh0, "SH0", true, &qns_llcc);
-DEFINE_QBCM(bcm_sh1, "SH1", false, &qns_memnoc_snoc);
-DEFINE_QBCM(bcm_sh3, "SH3", false, &xm_apps_rdwr);
-DEFINE_QBCM(bcm_sn0, "SN0", true, &qns_snoc_memnoc);
-DEFINE_QBCM(bcm_sn1, "SN1", false, &qxs_imem);
-DEFINE_QBCM(bcm_sn2, "SN2", false, &xs_qdss_stm);
-DEFINE_QBCM(bcm_sn3, "SN3", false, &xs_sys_tcu_cfg);
-DEFINE_QBCM(bcm_sn5, "SN5", false, &xs_pcie);
-DEFINE_QBCM(bcm_sn6, "SN6", false, &qhm_qdss_bam, &xm_qdss_etr);
-DEFINE_QBCM(bcm_sn7, "SN7", false, &qnm_aggre_noc, &xm_pcie, &xm_usb3, &qns_aggre_noc);
-DEFINE_QBCM(bcm_sn8, "SN8", false, &qnm_memnoc);
-DEFINE_QBCM(bcm_sn9, "SN9", false, &qnm_memnoc_pcie);
-DEFINE_QBCM(bcm_sn10, "SN10", false, &qnm_ipa, &xm_ipa2pcie_slv);
+static struct qcom_icc_bcm bcm_ce0 = {
+	.name = "CE0",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_mc0 = {
+	.name = "MC0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &ebi },
+};
+
+static struct qcom_icc_bcm bcm_pn0 = {
+	.name = "PN0",
+	.keepalive = true,
+	.num_nodes = 26,
+	.nodes = { &qhm_snoc_cfg,
+		   &qhs_aoss,
+		   &qhs_apss,
+		   &qhs_audio,
+		   &qhs_blsp1,
+		   &qhs_clk_ctl,
+		   &qhs_crypto0_cfg,
+		   &qhs_ddrss_cfg,
+		   &qhs_ecc_cfg,
+		   &qhs_imem_cfg,
+		   &qhs_ipa,
+		   &qhs_mss_cfg,
+		   &qhs_pcie_parf,
+		   &qhs_pdm,
+		   &qhs_prng,
+		   &qhs_qdss_cfg,
+		   &qhs_qpic,
+		   &qhs_sdc1,
+		   &qhs_snoc_cfg,
+		   &qhs_spmi_fetcher,
+		   &qhs_spmi_vgi_coex,
+		   &qhs_tcsr,
+		   &qhs_tlmm,
+		   &qhs_usb3,
+		   &qhs_usb3_phy,
+		   &srvc_snoc
+	},
+};
+
+static struct qcom_icc_bcm bcm_pn1 = {
+	.name = "PN1",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &xm_sdc1 },
+};
+
+static struct qcom_icc_bcm bcm_pn2 = {
+	.name = "PN2",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &qhm_audio, &qhm_spmi_fetcher1 },
+};
+
+static struct qcom_icc_bcm bcm_pn3 = {
+	.name = "PN3",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &qhm_blsp1, &qhm_qpic },
+};
+
+static struct qcom_icc_bcm bcm_pn4 = {
+	.name = "PN4",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxm_crypto },
+};
+
+static struct qcom_icc_bcm bcm_sh0 = {
+	.name = "SH0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_llcc },
+};
+
+static struct qcom_icc_bcm bcm_sh1 = {
+	.name = "SH1",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qns_memnoc_snoc },
+};
+
+static struct qcom_icc_bcm bcm_sh3 = {
+	.name = "SH3",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &xm_apps_rdwr },
+};
+
+static struct qcom_icc_bcm bcm_sn0 = {
+	.name = "SN0",
+	.keepalive = true,
+	.num_nodes = 1,
+	.nodes = { &qns_snoc_memnoc },
+};
+
+static struct qcom_icc_bcm bcm_sn1 = {
+	.name = "SN1",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qxs_imem },
+};
+
+static struct qcom_icc_bcm bcm_sn2 = {
+	.name = "SN2",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &xs_qdss_stm },
+};
+
+static struct qcom_icc_bcm bcm_sn3 = {
+	.name = "SN3",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &xs_sys_tcu_cfg },
+};
+
+static struct qcom_icc_bcm bcm_sn5 = {
+	.name = "SN5",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &xs_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn6 = {
+	.name = "SN6",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &qhm_qdss_bam, &xm_qdss_etr },
+};
+
+static struct qcom_icc_bcm bcm_sn7 = {
+	.name = "SN7",
+	.keepalive = false,
+	.num_nodes = 4,
+	.nodes = { &qnm_aggre_noc, &xm_pcie, &xm_usb3, &qns_aggre_noc },
+};
+
+static struct qcom_icc_bcm bcm_sn8 = {
+	.name = "SN8",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_memnoc },
+};
+
+static struct qcom_icc_bcm bcm_sn9 = {
+	.name = "SN9",
+	.keepalive = false,
+	.num_nodes = 1,
+	.nodes = { &qnm_memnoc_pcie },
+};
+
+static struct qcom_icc_bcm bcm_sn10 = {
+	.name = "SN10",
+	.keepalive = false,
+	.num_nodes = 2,
+	.nodes = { &qnm_ipa, &xm_ipa2pcie_slv },
+};
 
 static struct qcom_icc_bcm * const mc_virt_bcms[] = {
 	&bcm_mc0,

-- 
2.41.0

