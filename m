Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4C9740356
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jun 2023 20:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjF0SbM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jun 2023 14:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjF0Sa7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jun 2023 14:30:59 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D1A1FF0
        for <linux-pm@vger.kernel.org>; Tue, 27 Jun 2023 11:30:57 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f957a45b10so6620098e87.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Jun 2023 11:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687890655; x=1690482655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlJNXwesiBvinVlCm08BsBVW76YCVdXRX2U7PUbcI/o=;
        b=eldDyj+vrO8B1EHdlEMPLEOHFCl6Si0hRnQUWciBEd3htvn9vdm6kAyicutqD76S0g
         bGgWtm34+fKxqnz0FT5RSv1j8tOoh1DE8FEUBE6TFikADzN/k/qfb8gNg0eAAIqb0ols
         wsxmDPYyNPikkpL5q4J/wvHYv+azzdwd1FylVlMD+zCTEh7dMs/HtN1/Xfn73L67Yqqr
         0s8Mr8ib8dHxbk4xv9DFlSlIlbqop+IogDwUSJwaf/fLpuG1we7DVl7+BPSIWv+EhfQu
         rX76z9OPET8WM7HJQkiZ863JQtr3PP9YlzUOuKN4VBae/83/QllOXFzUv5dM9tQ6rfPc
         2QRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687890655; x=1690482655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlJNXwesiBvinVlCm08BsBVW76YCVdXRX2U7PUbcI/o=;
        b=h+WZPcDG3rb0ue/7Oq/cWWVE0pu6Fu2in3T+aQ7cYLgSOW32mEFFS87TfBiS0qEMXl
         Ww4+eKKiHK5uLir9WizxHQmEiwmIHH42qstA6a5d8mI5+S6RUwsSCk8rEOMpVajS0648
         fYaW9znHX0Z9rgFWm4kAx4feJX/FHR0Bz1+jTQxnYwmY07e7XN1i3woklVcTncyzZx5D
         Q9H7k0qJSzfd4P/DaYmRTzZAi6Yv/LD1BJtrm83rSHy8DiTgtMH4pAx3BACEQ9E6FCp4
         JQNTTbnOH8UoQxGSW8zu3/eVUyFb5HWW9Q40tw+cUUUnUM9j37l2WP6LXzugTCLnUX49
         3UBw==
X-Gm-Message-State: AC+VfDw6MwBMbK3M8zX21NuojWSf9S3oYuUQUATy2o8Is+0EsL6Xl9u0
        K4cdezZTTxVS4GKT0LA2Tz/6fg==
X-Google-Smtp-Source: ACHHUZ4FmTiVlBb6s2iYb8rw/PrKV2+x4L8lUJLEKXdVIPwYmJ8d6A/4Qw5G8r23xXlLiMWv+a/Clw==
X-Received: by 2002:a19:5e0b:0:b0:4f8:72fd:ed95 with SMTP id s11-20020a195e0b000000b004f872fded95mr13852593lfb.22.1687890655186;
        Tue, 27 Jun 2023 11:30:55 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id q16-20020ac25290000000b004f640b0fb04sm1605205lfm.212.2023.06.27.11.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 11:30:54 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 27 Jun 2023 20:30:41 +0200
Subject: [PATCH v11 5/9] soc: qcom: cpr-common: Add support for flat fuse
 adjustment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v11-5-ba22b4daa5d6@linaro.org>
References: <20230217-topic-cpr3h-v11-0-ba22b4daa5d6@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v11-0-ba22b4daa5d6@linaro.org>
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
        linux-pm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687890646; l=2032;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=PZkzlg9a1T62vJjNL6pym3+YcX1sRFAyVy3l058FxdA=;
 b=Jypq10op7Z+li1iCijvCe2nLKNbkLjsWKK5RAHWVm+FoT/8W3Lflq5ZzgQ9bTceYQ5dFZ+Mn3
 hR2F0M7g/scBQPRCt1AExVa6Pwry++CGbTcN+a6RIhxkdmuAJDiKrcT
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

CPR3 makes use of post-calculation flat value adjustments. Add the
necessary bits to the common functions to support it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Konrad: separate this patch out of a bigger one]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/cpr-common.c | 9 ++++++---
 drivers/soc/qcom/cpr-common.h | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/cpr-common.c b/drivers/soc/qcom/cpr-common.c
index ea85f6b4bef8..44c681bbbf13 100644
--- a/drivers/soc/qcom/cpr-common.c
+++ b/drivers/soc/qcom/cpr-common.c
@@ -49,7 +49,7 @@ int cpr_populate_ring_osc_idx(struct device *dev,
 EXPORT_SYMBOL_GPL(cpr_populate_ring_osc_idx);
 
 static int cpr_read_fuse_uV(int init_v_width, int step_size_uV, int ref_uV,
-			    int step_volt, const char *init_v_efuse,
+			    int adj, int step_volt, const char *init_v_efuse,
 			    struct device *dev)
 {
 	int steps, uV;
@@ -67,6 +67,9 @@ static int cpr_read_fuse_uV(int init_v_width, int step_size_uV, int ref_uV,
 
 	uV = ref_uV + steps * step_size_uV;
 
+	/* Apply open-loop fixed adjustments to fused values */
+	uV += adj;
+
 	return DIV_ROUND_UP(uV, step_volt) * step_volt;
 }
 
@@ -119,8 +122,8 @@ int cpr_populate_fuse_common(struct device *dev,
 
 	/* Populate uV */
 	uV = cpr_read_fuse_uV(init_v_width, init_v_step,
-			      fdata->ref_uV, step_volt,
-			      cpr_fuse->init_voltage, dev);
+			      fdata->ref_uV, fdata->volt_oloop_adjust,
+			      step_volt, cpr_fuse->init_voltage, dev);
 	if (uV < 0)
 		return uV;
 
diff --git a/drivers/soc/qcom/cpr-common.h b/drivers/soc/qcom/cpr-common.h
index 1f2ebf9394cf..0aa227617d2f 100644
--- a/drivers/soc/qcom/cpr-common.h
+++ b/drivers/soc/qcom/cpr-common.h
@@ -22,6 +22,7 @@ struct fuse_corner_data {
 	int ref_uV;
 	int max_uV;
 	int min_uV;
+	int volt_oloop_adjust;
 	int max_volt_scale;
 	int max_quot_scale;
 	/* fuse quot */

-- 
2.41.0

