Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BED5B464D
	for <lists+linux-pm@lfdr.de>; Sat, 10 Sep 2022 14:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIJMrK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Sep 2022 08:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiIJMrJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Sep 2022 08:47:09 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D93B5756C
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 05:47:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bq23so7249210lfb.7
        for <linux-pm@vger.kernel.org>; Sat, 10 Sep 2022 05:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TxrB+xzXcIbg2kPlqQv8V5RPFZvr7T/st6qWl58n8ds=;
        b=SEPZv1Vew6IXsBVfgCi1dIDAmnaxQKruFh52oB1vHY7fEmuTeRm3aiyircMyAUNgJw
         CqESxYrOhWHZt/97DGFDT1NUMyDBvnmJKqxoUTxyaLctkplefdwZDcGUClSBCw2TefHP
         V6cQY/dgX/5oJvaYK7MOePctM1NMf9D87XO6lmMsVOg8ypFIHeli/7Sz1xVcI5fyhXvL
         tmcjSLKHbAz0FczE3w7S6Lm/KORyrPMg//MBU6+v5dJor4v3iYv8ei7iC3QWAZt886VN
         Nx20hpC/s/6kioyFgyd//dz/8BrB28fgVsxpe8kyT0AWD4CbnLhaljeAsrun5/4dEjWY
         qjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TxrB+xzXcIbg2kPlqQv8V5RPFZvr7T/st6qWl58n8ds=;
        b=lZ0YbP/gOPJBGo3xPC4+OwYRmc6w5LAcn99MOqSQF6LoPEgCedMi9gMTwWeGb3ZcMc
         t8f64EQ9N9mRIskebFkHhIqM1uWD/L3o6bGNfZYclXRbe5evBtPQOTEHKExirKbTT7ri
         Xv4ZKvki9uLCbAitxa1nkLSjf5auSIfzsVBFFFmgjFDSEDOfrfiflZVEB3XQjoNrxqEN
         LTr3uexDF8It5dEV2lpngklthkDxPyACKfiVpk+yh4LmwGSHuMw86Hi7PYYeyeXyrQHD
         u4aAihQl6LPX9m6x1rikxeERRk7TToJcSJ7itge2aM2xZAHK+sGFHk4VbwCf6O3LRLEC
         dMhg==
X-Gm-Message-State: ACgBeo1DEiyJkPXr2ZT4AlDRoVLwP0REx3Ov46yA/Tu3bh+MQYvhBGDx
        1njI5CJsUfk1lbSmQr3McHXXEQ==
X-Google-Smtp-Source: AA6agR5Q5mDFxvykXW1L9Goka43Fws1Tj9i5dMULtqO1AcZ861wmqXlDYcgeINLWKqQqzGRmz2RfCA==
X-Received: by 2002:ac2:4bd0:0:b0:497:abfd:3572 with SMTP id o16-20020ac24bd0000000b00497abfd3572mr4846435lfq.200.1662814025809;
        Sat, 10 Sep 2022 05:47:05 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k14-20020a2e920e000000b002677a3ad1d9sm327463ljg.76.2022.09.10.05.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 05:47:05 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC PATCH 04/10] thermal/drivers/tsens: drop single-cell code for mdm9607
Date:   Sat, 10 Sep 2022 15:46:55 +0300
Message-Id: <20220910124701.4060321-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org>
References: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no dtsi file for mdm9607 in the kernel sources. Drop the
compatibility with unofficial dtsi and remove support for handling the
single-cell calibration data on mdm9607.

Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens-v0_1.c | 84 +------------------------------
 1 file changed, 1 insertion(+), 83 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index add5d9dbc9d4..c3613b7ccc19 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -133,39 +133,6 @@
 
 #define BIT_APPEND		0x3
 
-/* eeprom layout data for mdm9607 */
-#define MDM9607_BASE0_MASK	0x000000ff
-#define MDM9607_BASE1_MASK	0x000ff000
-#define MDM9607_BASE0_SHIFT	0
-#define MDM9607_BASE1_SHIFT	12
-
-#define MDM9607_S0_P1_MASK	0x00003f00
-#define MDM9607_S1_P1_MASK	0x03f00000
-#define MDM9607_S2_P1_MASK	0x0000003f
-#define MDM9607_S3_P1_MASK	0x0003f000
-#define MDM9607_S4_P1_MASK	0x0000003f
-
-#define MDM9607_S0_P2_MASK	0x000fc000
-#define MDM9607_S1_P2_MASK	0xfc000000
-#define MDM9607_S2_P2_MASK	0x00000fc0
-#define MDM9607_S3_P2_MASK	0x00fc0000
-#define MDM9607_S4_P2_MASK	0x00000fc0
-
-#define MDM9607_S0_P1_SHIFT	8
-#define MDM9607_S1_P1_SHIFT	20
-#define MDM9607_S2_P1_SHIFT	0
-#define MDM9607_S3_P1_SHIFT	12
-#define MDM9607_S4_P1_SHIFT	0
-
-#define MDM9607_S0_P2_SHIFT	14
-#define MDM9607_S1_P2_SHIFT	26
-#define MDM9607_S2_P2_SHIFT	6
-#define MDM9607_S3_P2_SHIFT	18
-#define MDM9607_S4_P2_SHIFT	6
-
-#define MDM9607_CAL_SEL_MASK	0x00700000
-#define MDM9607_CAL_SEL_SHIFT	20
-
 static int calibrate_8916(struct tsens_priv *priv)
 {
 	int base0 = 0, base1 = 0, i;
@@ -370,56 +337,7 @@ static int calibrate_8974(struct tsens_priv *priv)
 
 static int calibrate_9607(struct tsens_priv *priv)
 {
-	int base, i;
-	u32 p1[5], p2[5];
-	int mode = 0;
-	u32 *qfprom_cdata;
-	int ret;
-
-	ret = tsens_calibrate_nvmem(priv, 2);
-	if (!ret)
-		return 0;
-
-	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
-	if (IS_ERR(qfprom_cdata))
-		return PTR_ERR(qfprom_cdata);
-
-	mode = (qfprom_cdata[2] & MDM9607_CAL_SEL_MASK) >> MDM9607_CAL_SEL_SHIFT;
-	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
-
-	switch (mode) {
-	case TWO_PT_CALIB:
-		base = (qfprom_cdata[2] & MDM9607_BASE1_MASK) >> MDM9607_BASE1_SHIFT;
-		p2[0] = (qfprom_cdata[0] & MDM9607_S0_P2_MASK) >> MDM9607_S0_P2_SHIFT;
-		p2[1] = (qfprom_cdata[0] & MDM9607_S1_P2_MASK) >> MDM9607_S1_P2_SHIFT;
-		p2[2] = (qfprom_cdata[1] & MDM9607_S2_P2_MASK) >> MDM9607_S2_P2_SHIFT;
-		p2[3] = (qfprom_cdata[1] & MDM9607_S3_P2_MASK) >> MDM9607_S3_P2_SHIFT;
-		p2[4] = (qfprom_cdata[2] & MDM9607_S4_P2_MASK) >> MDM9607_S4_P2_SHIFT;
-		for (i = 0; i < priv->num_sensors; i++)
-			p2[i] = ((base + p2[i]) << 2);
-		fallthrough;
-	case ONE_PT_CALIB2:
-		base = (qfprom_cdata[0] & MDM9607_BASE0_MASK);
-		p1[0] = (qfprom_cdata[0] & MDM9607_S0_P1_MASK) >> MDM9607_S0_P1_SHIFT;
-		p1[1] = (qfprom_cdata[0] & MDM9607_S1_P1_MASK) >> MDM9607_S1_P1_SHIFT;
-		p1[2] = (qfprom_cdata[1] & MDM9607_S2_P1_MASK) >> MDM9607_S2_P1_SHIFT;
-		p1[3] = (qfprom_cdata[1] & MDM9607_S3_P1_MASK) >> MDM9607_S3_P1_SHIFT;
-		p1[4] = (qfprom_cdata[2] & MDM9607_S4_P1_MASK) >> MDM9607_S4_P1_SHIFT;
-		for (i = 0; i < priv->num_sensors; i++)
-			p1[i] = ((base + p1[i]) << 2);
-		break;
-	default:
-		for (i = 0; i < priv->num_sensors; i++) {
-			p1[i] = 500;
-			p2[i] = 780;
-		}
-		break;
-	}
-
-	compute_intercept_slope(priv, p1, p2, mode);
-	kfree(qfprom_cdata);
-
-	return 0;
+	return tsens_calibrate_nvmem(priv, 2);
 }
 
 /* v0.1: 8916, 8939, 8974, 9607 */
-- 
2.35.1

