Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC4A788CB1
	for <lists+linux-pm@lfdr.de>; Fri, 25 Aug 2023 17:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343924AbjHYPjD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Aug 2023 11:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244306AbjHYPil (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Aug 2023 11:38:41 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3278C26A6
        for <linux-pm@vger.kernel.org>; Fri, 25 Aug 2023 08:38:35 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe61ae020bso1589380e87.2
        for <linux-pm@vger.kernel.org>; Fri, 25 Aug 2023 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692977913; x=1693582713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMSCeQq+U/vd11NjyVrj4R2ylX9PoMYtwDoMYa3Rm8Y=;
        b=bGXhmKbu6qMXbPm775Q8scMcejoAdFvHX4YzW8UBOqXw/WSbgBpxw+gPZMpaITKW4+
         u2ZSJWZvgIAOTsOOJ79Fbx//cpeTlyMAMAtma/mDQriRMhlPSZuhKqmqjUDHrDEHG68J
         rEgVBFlUA6YfRSlBRQxwS1t7gj/oNodWbnE3z2fHloRIMh8lKS/Eufcsha5+RzwqGwn5
         uR5QDSYDEC5ZN6VjmyHRaheiPPBpLS5e/95pDrh0cXuSSXbuh0Ugvpd5EfzUF7xepQhF
         JAtPLUgwL1BMGMalzcdunWJo4ImZwt5iYtGdAOn1vu6bC3b8liuRIrSfZruNfz7CmxmQ
         MC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692977913; x=1693582713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMSCeQq+U/vd11NjyVrj4R2ylX9PoMYtwDoMYa3Rm8Y=;
        b=eEJZgKNdFzdf0yBvaoG5Sv8Q5g8awgWuPSnfLvTsojObNRBWzRa+vU95PjLw4xe0KZ
         efvYMsMrjhewl7W8Yc4oAhMIs0xbdiTi3a9lmPCWx8bkGaRVVrLM06vAJN7bbLW11mHr
         xE1W29vzYjJZ6f2ItRGCIIB449x6QGJmSqsmu9L2klyiZUIY2VjxZQ9i3oFzJvUo1weM
         b8Vz5BflzjkEsJXbWAgZ56PL480zte7YJy7C7XClLbQi9LtmBiL+qBuh0k7Mj9VyPlYh
         rY37G7LwL/u4vUt5akknKSg1CjxnVQ94q+7Bcmbnkx4QrQHpr0BCKlsPH5oijjRZv5PL
         lqDg==
X-Gm-Message-State: AOJu0YygTxGcOO4GBHbYO7wWB7UGRFgZbK5+dQ7rjVZlT08x5FAQ8qJf
        dEQvDQQS2n3SXnR5Gl+fbVthYQ==
X-Google-Smtp-Source: AGHT+IH41lbtOTjRnPa3aqwfKiZCJa2eg2dWOOYiX3wbk60QmprMTvTj4pxcwmlMiRnKVg1gkS84Jg==
X-Received: by 2002:a05:6512:3706:b0:4fb:820a:f87f with SMTP id z6-20020a056512370600b004fb820af87fmr12756547lfr.10.1692977913567;
        Fri, 25 Aug 2023 08:38:33 -0700 (PDT)
Received: from [192.168.1.101] (abxh59.neoplus.adsl.tpnet.pl. [83.9.1.59])
        by smtp.gmail.com with ESMTPSA id y17-20020a197511000000b004fe432108absm326002lfe.182.2023.08.25.08.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:38:33 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 25 Aug 2023 17:38:28 +0200
Subject: [PATCH v4 06/10] interconnect: qcom: qcm2290: Set AB coefficients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v4-6-c04b60caa467@linaro.org>
References: <20230726-topic-icc_coeff-v4-0-c04b60caa467@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v4-0-c04b60caa467@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692977905; l=1293;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=aFY/90aKNDx1nzjcFFL7/POIPB/o+2FqU9SnuM8+AC0=;
 b=l8uD5o/GnikDkg+xmGJbXq5fumoWL7jXS+VePD3K+ELdHkIxpkriVq0oYa1n1fwtbATyJpSWP
 YMPbWwl2u3JBX6Z4qC5SRDdeY9MkyqFgKpeN31HZezkaoADlkgvmQ3C
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 026e4c82d6d4..7abc0c449220 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -1202,6 +1202,7 @@ static const struct qcom_icc_desc qcm2290_bimc = {
 	.keep_alive = true,
 	/* M_REG_BASE() in vendor msm_bus_bimc_adhoc driver */
 	.qos_offset = 0x8000,
+	.ab_coeff = 153,
 };
 
 static struct qcom_icc_node * const qcm2290_cnoc_nodes[] = {
@@ -1332,6 +1333,7 @@ static const struct qcom_icc_desc qcm2290_mmnrt_virt = {
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
 	.keep_alive = true,
 	.qos_offset = 0x15000,
+	.ab_coeff = 142,
 };
 
 static struct qcom_icc_node * const qcm2290_mmrt_virt_nodes[] = {
@@ -1348,6 +1350,7 @@ static const struct qcom_icc_desc qcm2290_mmrt_virt = {
 	.regmap_cfg = &qcm2290_snoc_regmap_config,
 	.keep_alive = true,
 	.qos_offset = 0x15000,
+	.ab_coeff = 139,
 };
 
 static const struct of_device_id qcm2290_noc_of_match[] = {

-- 
2.42.0

