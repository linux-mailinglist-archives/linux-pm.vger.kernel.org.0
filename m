Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F355A6D9B6D
	for <lists+linux-pm@lfdr.de>; Thu,  6 Apr 2023 16:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239192AbjDFO7D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Apr 2023 10:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbjDFO67 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Apr 2023 10:58:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E511BCB
        for <linux-pm@vger.kernel.org>; Thu,  6 Apr 2023 07:58:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v1so39810712wrv.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Apr 2023 07:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680793136; x=1683385136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYyNPnzqae4khg3KV2Lt1ECRlr8f32FnQfafbs3QB5I=;
        b=vtPP+7phDU/ux5+X1AMnqZmBs1GAc2PM6+xWc18/6ktYNlGaOycSjJMMyF1BBXC+nu
         4QZDU9v9WinnH1FsOEkpH4dmI5ellAVQizYtvNkBWHZFWaYZaZboK1o65kSN/SeLRIaX
         Mc1eGzGQBy9IOVt2PAdVYiujotTNItSEkduNACho30kG6upWUZ0lrSRT61tPUh/3f0n7
         qxnxt4EZgiDFO/6sSBUmmG/CiRcw1mtKZGIDPbZ3k1i+ZEonu9CtMIGyfolTacyKP4O8
         3/1dkQ0GqFz2waoLRBVnZiAL0B9aHM715lDxWSH6vZnD/GKwTBzx5eejjgRH/DV1TzpG
         owRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680793136; x=1683385136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYyNPnzqae4khg3KV2Lt1ECRlr8f32FnQfafbs3QB5I=;
        b=LWwS+kV5kkXDIjHDzRS/FA3NAU4Yg7QU0IOVZ0G1N3RMe3VXO2bNIss6QbRNONoLSt
         KPdCekvhclN5w1e5cFp+8omKdeqEZuVnplTmohDd1TO3B/WHyaEDKMIn2oCYmEaO7B1w
         0xhESYVyHX0Qvs1/t3wXlop5SWn21CnH1Ys8XXiMTMfSLME0LvCbpPIFsRjjsAe86d0F
         Oc9OhU8u2ImwdSyeMf2iHw4uSdYInl+HwFX8HRWM6NgrsqgQG5w+KtnGhGUyWD3lC9Db
         r2tIf0VEQzmIx6BQDyyyhGVevKi7btHsM7YQgZPaSYssLZeHFawUuaGH6BccuqMz/+Oa
         UYwg==
X-Gm-Message-State: AAQBX9eowj9SPjWWWvwIRsS2ZP6VeJa9FrM+T4VEFMjXTtjFS5+nz8RP
        65L6Ui6VK+FiMo70rctgxJTJnw==
X-Google-Smtp-Source: AKy350YVmezFAiNqfMgn8vCKeCz1co1VaJgEQqfzy5k/qQyVn240yKSvpXq066F1GHjVmN8wzocQ6A==
X-Received: by 2002:adf:ce0a:0:b0:2c8:9cfe:9e29 with SMTP id p10-20020adfce0a000000b002c89cfe9e29mr6532039wrn.38.1680793136560;
        Thu, 06 Apr 2023 07:58:56 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d10-20020a1c730a000000b003f0373d077csm1768160wmb.47.2023.04.06.07.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:58:56 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     amitk@kernel.org, thara.gopinath@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        dmitry.baryshkov@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 3/3] thermal/drivers/tsens: Extract and shift-in optional MSB
Date:   Thu,  6 Apr 2023 15:58:50 +0100
Message-Id: <20230406145850.357296-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406145850.357296-1-bryan.odonoghue@linaro.org>
References: <20230406145850.357296-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In msm8939 some of the sensor calibration data traverses byte boundaries.
Two examples of this are thermal sensor 2 point 1 and sensor 9 point 2.

For sensor 2 point 1 we can get away with a simple read traversing byte
boundaries as the calibration most significant bits are adjacent to the
least significant across the byte boundary.

In this case a read starting at the end of the first byte for nine bits
will deliver up the data we want.

In the case of sensor 9 point 2 however, the most significant bits are not
adjacent and so therefore we need to perform two reads and or the bits
together.

If reg.p1_shift or reg.p2_shift is set then automatically search for
pX_sY_msb in the dts applying pX_shift as a right shift or into the pX_sY
value.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index a260f563b4889..eff2c8671c343 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -74,6 +74,7 @@ int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2,
 {
 	u32 mode;
 	u32 base1, base2;
+	u32 msb;
 	char name[] = "sXX_pY_backup"; /* s10_p1_backup */
 	int i, ret;
 
@@ -122,6 +123,22 @@ int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2,
 
 		dev_dbg(priv->dev, "%s 0x%x\n", name, p1[i]);
 
+		if (priv->reg && priv->reg[i].p1_shift) {
+			ret = snprintf(name, sizeof(name), "s%d_p1_msb",
+				       priv->sensor[i].hw_id);
+			if (ret < 0)
+				return ret;
+
+			ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &msb);
+			if (ret) {
+				dev_err(priv->dev, "Failed to read %s\n", name);
+				return ret;
+			}
+
+			dev_dbg(priv->dev, "%s 0x%x\n", name, msb);
+			p1[i] |= msb >> priv->reg[i].p1_shift;
+		}
+
 		ret = snprintf(name, sizeof(name), "s%d_p2%s", priv->sensor[i].hw_id,
 			       backup ? "_backup" : "");
 		if (ret < 0)
@@ -134,6 +151,22 @@ int tsens_read_calibration(struct tsens_priv *priv, int shift, u32 *p1, u32 *p2,
 		}
 
 		dev_dbg(priv->dev, "%s 0x%x\n", name, p2[i]);
+
+		if (priv->reg && priv->reg[i].p2_shift) {
+			ret = snprintf(name, sizeof(name), "s%d_p2_msb",
+				       priv->sensor[i].hw_id);
+			if (ret < 0)
+				return ret;
+
+			ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &msb);
+			if (ret) {
+				dev_err(priv->dev, "Failed to read %s\n", name);
+				return ret;
+			}
+
+			dev_dbg(priv->dev, "%s 0x%x\n", name, msb);
+			p2[i] |= msb >> priv->reg[i].p2_shift;
+		}
 	}
 
 	switch (mode) {
-- 
2.39.2

