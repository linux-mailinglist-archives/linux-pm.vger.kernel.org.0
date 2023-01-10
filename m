Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F00664197
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jan 2023 14:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjAJNWs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Jan 2023 08:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238330AbjAJNWd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2023 08:22:33 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2491EEEE
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2023 05:22:24 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j17so18392408lfr.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2023 05:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aO6p1hpxr6E0ri+d7k8hVyJIX5zUXCUNgUhxA4wjaeQ=;
        b=Zle/652Rjcg66Pa8TitLSj9B4mUpqu0rEMANYRIcRYKW4ECjs40P52y26kyjR0cSmM
         9pAoFi/2fIWN+IxJ2JO0w5hoX2EDloG69jM0W2Efet9uCr/DWqr4Q6XWx0d6tuaH7e4I
         a6GdD+tCFTOdHZEqfveY5paA0lG2GOVh3AhrSZlD7AHPd5LFA54Mp6nhILrnwRi1wpxx
         rld8NFnoFJzoCScgvTNqE734h4ZEzHbAvtE92y7DTLLSMOBj5N1ZUx8tZT/Ibq5iqUVF
         Rh8bIFdVhco4UDIhZeCU2L5Cl3BupiwkTJ1WKuXZ0HZsGsI4Oz8uFPgXQiBnTBF7bWG/
         jSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aO6p1hpxr6E0ri+d7k8hVyJIX5zUXCUNgUhxA4wjaeQ=;
        b=DomAa72prP+xFfJccr7FzaoYolbaxVeOLm/cuXAENJoZ/anxiGVxHhCulRs8AgFMSe
         majAJpBEIG3yspnwz492XcRUqlTtOCY3fYpmi5u2L4WQahB2UrIi5TuC7fNG+Xv2pmbs
         qZlPpXsaQgGmxLJusr5coM1tOdbL2MeX+bpfZlkjHZX3ODETFF4WOPm7wkfoZ7PVb9zv
         kQrBWcZZ8GKv4TFWJYVCAxcirbZH30sWqJRw2EeuguWstyIYCqeCUFX3Lkmsqmv7pKtX
         vrufAimfikw65Re2Bbc6JKViVPp9pzkYEGaaF3vm1baQOxOwDrvgrSRbbPRHUTtTaV+q
         kUPw==
X-Gm-Message-State: AFqh2kroYQyh2QjFrws4XfDx5Z7zm5IIVrSCkt4Y9Nvvw3eo3MxV7C9n
        MgCmrEmod8BB8N+SZ8Sp3Rix+A==
X-Google-Smtp-Source: AMrXdXtKL6s9s2ABpjhtMbw/Ao9E3+C/X5gKjtrRbTXH//TTj2rSCQ/BoD5DgqadFUGT0a1TXhhwiA==
X-Received: by 2002:a05:6512:b81:b0:4b5:869e:b5ec with SMTP id b1-20020a0565120b8100b004b5869eb5ecmr1350572lfv.61.1673356942213;
        Tue, 10 Jan 2023 05:22:22 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id w4-20020a19c504000000b004b5812207dbsm2183000lfe.201.2023.01.10.05.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 05:22:21 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, bryan.odonoghue@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/10] interconnect: qcom: rpm: Add a way to always set QoS registers
Date:   Tue, 10 Jan 2023 14:22:01 +0100
Message-Id: <20230110132202.956619-10-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110132202.956619-1-konrad.dybcio@linaro.org>
References: <20230110132202.956619-1-konrad.dybcio@linaro.org>
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

On newer SoCs (there's no clear boundary, but probably "new enough"
means every interconnect provider is either BIMC or QNoC and there
are no old-style NoC hosts) we're expected to set QoS registers
regardless of the ap_owned param. Add a bool in the qcom_icc_provider
and make the logic assume it's okay to set the registers when it's
set.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 2 +-
 drivers/interconnect/qcom/icc-rpm.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 12c58f9237e8..804ba75bcd79 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -250,7 +250,7 @@ static int __qcom_icc_set(struct icc_node *n, struct qcom_icc_node *qn,
 	bool vote_ap, vote_rpm;
 	int ret;
 
-	if (qp->type == QCOM_ICC_QNOC) {
+	if (qp->type == QCOM_ICC_QNOC || qp->always_set_qos) {
 		vote_ap = true;
 		vote_rpm = true;
 	} else {
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index b4888e4cb74a..f3afaaee14f2 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -28,6 +28,7 @@ enum qcom_icc_type {
  * @type: the ICC provider type
  * @regmap: regmap for QoS registers read/write access
  * @qos_offset: offset to QoS registers
+ * @always_set_qos: whether to always set QoS registers regardless of bus type
  * @bus_clk_rate: bus clock rate in Hz
  * @bus_clks: the clk_bulk_data table of bus clocks
  * @intf_clks: the clk_bulk_data table of interface clocks
@@ -39,6 +40,7 @@ struct qcom_icc_provider {
 	enum qcom_icc_type type;
 	struct regmap *regmap;
 	int qos_offset;
+	bool always_set_qos;
 	u64 bus_clk_rate[2];
 	struct clk_bulk_data bus_clks[2];
 	struct clk_bulk_data intf_clks[];
-- 
2.39.0

