Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5C1741350
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jun 2023 16:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjF1ODL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Jun 2023 10:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjF1OBr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jun 2023 10:01:47 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9AD2D78
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2023 07:00:59 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f8775126d3so8344658e87.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Jun 2023 07:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687960858; x=1690552858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8b95YyrPSuupI481LxGuPH0W0Ev0Q0xP5dP+IZGpzvg=;
        b=GXyD7n9AIosDIZkXLIVkkwaxQn6nxHqixAueYldTJN1tISQFqyIYcH57YvtWYC3kbK
         JFNXWiIvXhU2dOZ2Ro87B79Lm4eXi5XMAwt4MQ+CUGzXRu9IwgF4H2KG1EY9E9ARDMvC
         ifqfBiUOP8HIGfUq+iqpkIdGu/Nc7jFfGufDRPNRoWzmNi6C6lyLEh/6jmdbJQsIubSo
         mvCKss89EsyLvDBAmgTDjmDWvdjjMHsGd3CuzmkCRly75D4iCbkLPnsnA6mMh5/EG/Es
         RutCpk8IvwZsgoBdcihFhi3x/HjM2I9j8pa54xx/2iZNZm6Y92AkLN8F/ysKYEqKLeyj
         15hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687960858; x=1690552858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8b95YyrPSuupI481LxGuPH0W0Ev0Q0xP5dP+IZGpzvg=;
        b=lxHkJLKDpqwIcMy20Z1q4WR7b8nYoaXjYmEHM9BUjQ8Z315NyGpuyj54lGy0hUl61u
         ror1gUU7q/4iaoDTgM4h/fpweDwTAcZG7193XogATiYjIvchbzEZD+ke63pvsytP1fia
         71rK/b22t5LZ+aZvU7pA9pcmnxQKA2mvxIVN1Tp5myhI6a6Nr9qSMopVB+vXCIlB+nNn
         uLf/tEn0euOEV8AT09tM9QBzXQxEuVNtn8M0UVb8qljEXxVu7z9YYpu06T9O9TnTSzX4
         9wnq2CwaRiZrUEHolXUuD0f509hELgLLmIV8FtAHJANo2PbHCrvaoSx6Ney9yrOsnjp2
         wE/Q==
X-Gm-Message-State: AC+VfDxKWOzSkU7WkGkS0gRhAh/OcTiNV8OBeLo27a9Vvu+gpkin9lYz
        wDDnPhvbtDOcd5EGZ32R+aeFPA==
X-Google-Smtp-Source: ACHHUZ4J3wZQQ2+X+QSFmCRsHtuDPTJv44gypfwW4A8nwbuo8MrNX/D1zWkfitegHfE4OMnkBulkDQ==
X-Received: by 2002:a19:6445:0:b0:4f8:74b5:b4ec with SMTP id b5-20020a196445000000b004f874b5b4ecmr19101455lfj.41.1687960857816;
        Wed, 28 Jun 2023 07:00:57 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id w2-20020a05651204c200b004f8586ab633sm1941359lfq.279.2023.06.28.07.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 07:00:56 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 28 Jun 2023 16:00:46 +0200
Subject: [PATCH v12 07/10] soc: qcom: cpr: Use u64 for frequency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v12-7-1a4d050e1e67@linaro.org>
References: <20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687960842; l=4633;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=PWlHXLBc6eYCIQOuwoDLOgk0BhchBWn8dDGTg2w8H7k=;
 b=0JGVm89AazNICKETJE/s/6QEfJQZxPuyLNjwGmBRqeDUB7YMT54OCVG2DBkRbJSa/IKpkdXDG
 sJwes9YByc7D03jP1ZTCHnRsUzgbIxYUFfDDYlOWc3uHwtWjuR9j3qn
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

32 bits is not enough for over-2.changeGHz frequencies. Move all variables
that operate on Hz to u64 to avoid overflows.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/cpr-common.c | 13 +++++++------
 drivers/soc/qcom/cpr-common.h |  9 ++++-----
 drivers/soc/qcom/cpr.c        |  8 ++++----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/qcom/cpr-common.c b/drivers/soc/qcom/cpr-common.c
index 44c681bbbf13..3e3a4a61cfde 100644
--- a/drivers/soc/qcom/cpr-common.c
+++ b/drivers/soc/qcom/cpr-common.c
@@ -218,7 +218,7 @@ unsigned int cpr_get_fuse_corner(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(cpr_get_fuse_corner);
 
-unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
+u64 cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
 				     struct device *cpu_dev)
 {
 	u64 rate = 0;
@@ -250,7 +250,7 @@ unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
 out_ref:
 	of_node_put(desc_np);
 
-	return (unsigned long) rate;
+	return rate;
 }
 EXPORT_SYMBOL_GPL(cpr_get_opp_hz_for_req);
 
@@ -260,7 +260,7 @@ int cpr_calculate_scaling(struct device *dev,
 			  const struct corner *corner)
 {
 	u32 quot_diff = 0;
-	unsigned long freq_diff;
+	u64 freq_diff;
 	int scaling;
 	const struct fuse_corner *fuse, *prev_fuse;
 	int ret;
@@ -280,8 +280,9 @@ int cpr_calculate_scaling(struct device *dev,
 	}
 
 	freq_diff = fuse->max_freq - prev_fuse->max_freq;
-	freq_diff /= 1000000; /* Convert to MHz */
-	scaling = 1000 * quot_diff / freq_diff;
+	freq_diff = div_u64(freq_diff, 1000000); /* Convert to MHz */
+	scaling = 1000 * quot_diff;
+	do_div(scaling, freq_diff);
 	return min(scaling, fdata->max_quot_scale);
 }
 EXPORT_SYMBOL_GPL(cpr_calculate_scaling);
@@ -289,7 +290,7 @@ EXPORT_SYMBOL_GPL(cpr_calculate_scaling);
 int cpr_interpolate(const struct corner *corner, int step_volt,
 		    const struct fuse_corner_data *fdata)
 {
-	unsigned long f_high, f_low, f_diff;
+	u64 f_high, f_low, f_diff;
 	int uV_high, uV_low, uV;
 	u64 temp, temp_limit;
 	const struct fuse_corner *fuse, *prev_fuse;
diff --git a/drivers/soc/qcom/cpr-common.h b/drivers/soc/qcom/cpr-common.h
index 0aa227617d2f..1b2fa344eb09 100644
--- a/drivers/soc/qcom/cpr-common.h
+++ b/drivers/soc/qcom/cpr-common.h
@@ -42,7 +42,7 @@ struct fuse_corner {
 	int step_quot;
 	const struct reg_sequence *accs;
 	int num_accs;
-	unsigned long max_freq;
+	u64 max_freq;
 	u8 ring_osc_idx;
 };
 
@@ -54,13 +54,13 @@ struct corner {
 	int quot_adjust;
 	u32 save_ctl;
 	u32 save_irq;
-	unsigned long freq;
+	u64 freq;
 	struct fuse_corner *fuse_corner;
 };
 
 struct corner_data {
 	unsigned int fuse_corner;
-	unsigned long freq;
+	u64 freq;
 };
 
 struct acc_desc {
@@ -92,8 +92,7 @@ int cpr_populate_fuse_common(struct device *dev,
 int cpr_find_initial_corner(struct device *dev, struct clk *cpu_clk,
 			    struct corner *corners, int num_corners);
 u32 cpr_get_fuse_corner(struct dev_pm_opp *opp);
-unsigned long cpr_get_opp_hz_for_req(struct dev_pm_opp *ref,
-				     struct device *cpu_dev);
+u64 cpr_get_opp_hz_for_req(struct dev_pm_opp *ref, struct device *cpu_dev);
 int cpr_calculate_scaling(struct device *dev,
 			  const char *quot_offset,
 			  const struct fuse_corner_data *fdata,
diff --git a/drivers/soc/qcom/cpr.c b/drivers/soc/qcom/cpr.c
index cc1e4c462d1f..49c33b13b82b 100644
--- a/drivers/soc/qcom/cpr.c
+++ b/drivers/soc/qcom/cpr.c
@@ -827,8 +827,8 @@ static int cpr_corner_init(struct cpr_drv *drv)
 	struct corner_data *cdata;
 	const struct fuse_corner_data *fdata;
 	bool apply_scaling;
-	unsigned long freq_diff, freq_diff_mhz;
-	unsigned long freq;
+	unsigned long freq_diff_mhz;
+	u64 freq, freq_diff;
 	int step_volt = regulator_get_linear_step(drv->vdd_apc);
 	struct dev_pm_opp *opp;
 
@@ -867,7 +867,7 @@ static int cpr_corner_init(struct cpr_drv *drv)
 		cdata[level - 1].freq = freq;
 
 		fuse = &drv->fuse_corners[fnum];
-		dev_dbg(drv->dev, "freq: %lu level: %u fuse level: %u\n",
+		dev_dbg(drv->dev, "freq: %llu level: %u fuse level: %u\n",
 			freq, dev_pm_opp_get_level(opp) - 1, fnum);
 		if (freq > fuse->max_freq)
 			fuse->max_freq = freq;
@@ -941,7 +941,7 @@ static int cpr_corner_init(struct cpr_drv *drv)
 
 		if (apply_scaling) {
 			freq_diff = fuse->max_freq - corner->freq;
-			freq_diff_mhz = freq_diff / 1000000;
+			freq_diff_mhz = (u32)div_u64(freq_diff, 1000000);
 			corner->quot_adjust = scaling * freq_diff_mhz / 1000;
 
 			corner->uV = cpr_interpolate(corner, step_volt, fdata);

-- 
2.41.0

