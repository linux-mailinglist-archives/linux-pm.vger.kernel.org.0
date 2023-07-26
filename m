Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523AF763C5B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jul 2023 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjGZQZ4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jul 2023 12:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjGZQZz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jul 2023 12:25:55 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3167A269A
        for <linux-pm@vger.kernel.org>; Wed, 26 Jul 2023 09:25:54 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe05fbe250so3351884e87.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Jul 2023 09:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690388752; x=1690993552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlpQZDurU7cDEuQbGYsNutn1v1rksKhpV41bGEsl56Y=;
        b=d0qbGGspyEurSFGz6ibFBd9VXfvQDBS5jWzy27V21n690MR0SekTFD3hRDP/B+vZxh
         eWDgpSkh5X7KWTFPzBS5KVBJde6jXk7jnZ0zce4BuQNVcfamgv3BhDlVxNuxOe6+b1n/
         dhHuJRbLEUHpyUirV2YPPwwaTgsNDf8Q4LZN/wwVddlbFQj+F1wx6G3lpLPYfUeO/3K7
         XmEO3EJv3fUMKUWJEwq4R+frPOLKzlOPq3nPX568dwLPEfjaT+Qd0SoLSKTpt5yFhngD
         4IEzNIbAukIDNCz0WppD2Tp4Q+hcbL+grIh2MMv2lMy1vOerje0MuQx7G6bGyMiRbrLx
         8igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690388752; x=1690993552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlpQZDurU7cDEuQbGYsNutn1v1rksKhpV41bGEsl56Y=;
        b=e9vCzX7nX61v0/hBKfk7sZX7gv49sQPMzUNdCdWVaU1wQVHETIwyq5iaawqvUCwvSA
         m0xYokkbi9IEcUqLZZ1ib0FtWhtZRlhhIffBLILhg8whm05nNN8oNXzHEeQ4sdMuG7hZ
         6Yfh7MCSxd527GsytD+6/9ka6FDfp6Va2i4/LoKrqZiONC1jUQyvXM8Qv2sFSnmPetxw
         MhjR3r2bLsB92B+d2nRXYIIye/atQM8S5Vb6xkNkmtnADhNVRV4YQaJ5hlpAOWFlrbjT
         /6/u8VmCZzjSLoI0tBNgFuEUzt6HBWvp+mLmtesD6HnOyMdwEL81yglZJ74cNe0JtCNS
         aMVQ==
X-Gm-Message-State: ABy/qLYA3EJ6z8uBjShPgqmd0enbX09rDWn1dxAwnUB9O4/tMoWDpj6O
        QpRmS3t3URd0oUdMtRkq8l6Idg==
X-Google-Smtp-Source: APBJJlEJk+BzPWqQ3r46/z6B3t7RlEJOYE0WpUtOC9pOPofBwWUXInVqT6m29hsvbmoe6DYC+HU+WQ==
X-Received: by 2002:a19:ca4d:0:b0:4f8:7781:9875 with SMTP id h13-20020a19ca4d000000b004f877819875mr1657082lfj.60.1690388752491;
        Wed, 26 Jul 2023 09:25:52 -0700 (PDT)
Received: from [192.168.1.101] (abxh240.neoplus.adsl.tpnet.pl. [83.9.1.240])
        by smtp.gmail.com with ESMTPSA id a14-20020a056512374e00b004fba5c20ab1sm3336299lfs.167.2023.07.26.09.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 09:25:52 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 26 Jul 2023 18:25:44 +0200
Subject: [PATCH 2/4] interconnect: qcom: qcm2290: Set AB coefficients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v1-2-31616960818c@linaro.org>
References: <20230726-topic-icc_coeff-v1-0-31616960818c@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v1-0-31616960818c@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690388749; l=1342;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=w4cMQBcUUhS3DdTuB4xqxb90xCVKGorFLtRylK/3djI=;
 b=VzuUA4qmeTaeThHfdDDCqxCLSixVY7h/MqF0qXGcr6a6t4nUGFFSFReEkhZniL1Pn0i/q4IQQ
 xDwTTWh2T1gAK59yATGeYkNMjAvMhwQOXg1chChmR7oXHRtchVysNeR
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some buses need additional manual adjustments atop the usual
calculations. Fill in the missing coefficients.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/qcm2290.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index 3c3b24264a5b..457e5713ae43 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -1198,6 +1198,7 @@ static const struct qcom_icc_desc qcm2290_bimc = {
 	.regmap_cfg = &qcm2290_bimc_regmap_config,
 	/* M_REG_BASE() in vendor msm_bus_bimc_adhoc driver */
 	.qos_offset = 0x8000,
+	.ab_percent = 153,
 };
 
 static struct qcom_icc_node * const qcm2290_cnoc_nodes[] = {
@@ -1324,6 +1325,7 @@ static const struct qcom_icc_desc qcm2290_mmnrt_virt = {
 	.bus_clk_desc = &mmaxi_0_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
 	.qos_offset = 0x15000,
+	.ab_percent = 142,
 };
 
 static struct qcom_icc_node * const qcm2290_mmrt_virt_nodes[] = {
@@ -1339,6 +1341,7 @@ static const struct qcom_icc_desc qcm2290_mmrt_virt = {
 	.bus_clk_desc = &mmaxi_1_clk,
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
 	.qos_offset = 0x15000,
+	.ab_percent = 139,
 };
 
 static const struct of_device_id qcm2290_noc_of_match[] = {

-- 
2.41.0

