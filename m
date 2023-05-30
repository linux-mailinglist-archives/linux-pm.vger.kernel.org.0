Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDD9715B97
	for <lists+linux-pm@lfdr.de>; Tue, 30 May 2023 12:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjE3KVr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 May 2023 06:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjE3KVF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 May 2023 06:21:05 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D24E40
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 03:20:24 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f50470d77cso1929855e87.0
        for <linux-pm@vger.kernel.org>; Tue, 30 May 2023 03:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685442023; x=1688034023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qSFOcsV0DAXJFWKPUmOzUAy/JWGLyINLrQd4hvqeSM=;
        b=FpbpdslZAFcI2oaJi04YzwD3fpnArOhrFp+b98rHH3m23Xct7Fr1tmhnN2ecsoIT7K
         9DW1o6ISIs1aKI4H/mA2GrNEUQ1mXRwYd/vbSYfmSyRIuV0HlSCVhOZDzFEE9ADfCrLb
         iw+Rp4WalZVVoDS58K94Y3oRaTxR/7FxaQjEv0LMu5gBRjwFxzlr2Kf0Xeh1/WfV1LiY
         0XlrYzKUdIsUlXKpB1yY4d+r3Xu4zJH3mgiyhn4pAv2QaUB/GrlWR6aHU00nU1cZvt0P
         36WJP1ACUNQwyiZvyBq06V/TUYuiHYaGXFKmHfPO8M9aplqmj3MLrId3VCDQtc2Ec13I
         lR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685442023; x=1688034023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qSFOcsV0DAXJFWKPUmOzUAy/JWGLyINLrQd4hvqeSM=;
        b=PsY5EGodO1Y8Z8cQcK5Jc3T1lLazwrDpPhFLmBZ3GgPHzlX8A24TxqBDaWgGKcY0Ro
         aa6NqQToBupdxdlINMufJ295g1iYu6HShhP4/uzYTKqmVFvoIdPvkYRm0j/q8MFy802R
         DLWYFAhRuSZj1XAJ+417sxYzqSctBvTSEvWuouNECrBxahEMmmznWmuQyioT0xFrcbIY
         d4dUWtj2N9LHibh7hnFBeNjjRhI7E1K5OgMId20kaCdyGrd+YdRYLhZK5aKsm2/hCKXg
         E01JMWFOBrE9btYFvAMhGBeH/5ZoGRBw9w8O2djzZIYgMxZzIU57TD8S0nR++682QtWl
         HDlA==
X-Gm-Message-State: AC+VfDzWDEU+7rWmnIeUjV3QRk7JeA9nZCHbYF7NbBAgKkkBJHmwfLm2
        9Wrw8lhmBwgWgpAci5c1LviVc28pphhgR0NnN8Q=
X-Google-Smtp-Source: ACHHUZ6QQvouPXfYS8BugnmPnCGYIcty49vUckZ7sy4PVMOc33IY4PYaE+yeNeF/RCfguWkDJnKMPw==
X-Received: by 2002:ac2:5605:0:b0:4f4:ce78:2f17 with SMTP id v5-20020ac25605000000b004f4ce782f17mr502768lfd.13.1685442023213;
        Tue, 30 May 2023 03:20:23 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c25-20020ac24159000000b004cc8196a308sm290902lfi.98.2023.05.30.03.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:20:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 30 May 2023 12:20:14 +0200
Subject: [PATCH 15/20] interconnect: qcom: msm8916: Hook up RPM bus clk
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v1-15-1bf8e6663c4e@linaro.org>
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685442001; l=1325;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=PpYTHoQR3MZyHfK/p/ldjvDJLVIB+4TUtliZoMmCQCI=;
 b=RB0sQmu+yq6qlV9WxbTiZ2dx6GlzrzVs3Abp9B3pjGMXqhbKMK/+HqtDJw4rFrkyWcJdaNZW+
 STMgFUUosIFAegR+d8oIgwxmrZaQq11w2NQ8Z9zdE1aFP5587g4EsJz
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Assign the necessary definitions to migrate to the new bus clock
handling mechanism.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/msm8916.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index 196b05879896..be2a190a8b52 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -1231,6 +1231,7 @@ static const struct qcom_icc_desc msm8916_snoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8916_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_snoc_nodes),
+	.bus_clk_desc = &bus_1_clk,
 	.regmap_cfg = &msm8916_snoc_regmap_config,
 	.qos_offset = 0x7000,
 };
@@ -1259,6 +1260,7 @@ static const struct qcom_icc_desc msm8916_bimc = {
 	.type = QCOM_ICC_BIMC,
 	.nodes = msm8916_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_bimc_nodes),
+	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &msm8916_bimc_regmap_config,
 	.qos_offset = 0x8000,
 };
@@ -1328,6 +1330,7 @@ static const struct qcom_icc_desc msm8916_pcnoc = {
 	.type = QCOM_ICC_NOC,
 	.nodes = msm8916_pcnoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8916_pcnoc_nodes),
+	.bus_clk_desc = &bus_0_clk,
 	.regmap_cfg = &msm8916_pcnoc_regmap_config,
 	.qos_offset = 0x7000,
 };

-- 
2.40.1

