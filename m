Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746E8651908
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 03:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiLTCrc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Dec 2022 21:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbiLTCra (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2022 21:47:30 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EC413D1E
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 18:47:28 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b13so16607476lfo.3
        for <linux-pm@vger.kernel.org>; Mon, 19 Dec 2022 18:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6cA4Rv7ZGDOj4S5hrIclxaFxqbwYxf0WlThWIKncNA=;
        b=rUvApwrSs9vfqMF8Vi8V3PDqUh98q/tIojUp9FEPgX3MGwGR69faAxsLZxLKHbaW1S
         MW78lft/1pBBSt4kil8sBMV5PFNpT1ql/hhGm5r3VFdTP4KSj3D1xeYA8ilj4I4yGF9m
         iEiBwXVTIpXYmXnuS0DxEcNoY5OLmtQrJt1wtgrM1VB45BdI117v9xzLm/y2msyhoduE
         wvlz33uBQ03ErA/EHDHBgxfjFT12Z43BU3eYi1NJv23FyOpeTrMbm9FiT7C5WyJJuFUP
         fZqa9+iklIAjrU4aFEvXPbFKPhsaCoIyzeppFfeqj9lt1Wbxn6hz3jwEYjzlHwK1Ok4N
         0/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6cA4Rv7ZGDOj4S5hrIclxaFxqbwYxf0WlThWIKncNA=;
        b=VbLAvi39mZhuHs10pOuYB/wb2yBwpHH3SUgL12P9IzienNNSaLfBoopCbBmCj1JMtH
         yS3pcrK6JQ1pyNpS9IOYc0eWIOWfjfpFIss+o8sJyL9kKOGFK70V7Xwnw/FBUs7tN1Z0
         p247kw/DR8JrVxP0by0Tl+FqFtV8NmZcCKZlTNP9TKebCbq5yQBgCIohzIktuflqBJyJ
         bxSTFa30ZSlB+2hT2quoqcTZuTpk8+H1BSIp1Ezqc8AAMVx71xu1Puq+DxIo3gcBqMRr
         V+H9Ts4e8be65FnSdcns74/zRpOjid9JBrJxSR5wG/2OJIq0FdAc2MtmzIMKoIU67siy
         BxKA==
X-Gm-Message-State: ANoB5plhPRWCmznDfWXHOh27xpIPV/PdtYXJsxQAGAhOwlRBwzHHLipQ
        KrQ6TXgHjXpRKn/lmKqeWZyveQ==
X-Google-Smtp-Source: AA0mqf715PGiK/skZorsDOENFytM9RM+oBCdBzGyr61asr6z7VClRX1OV3qERQpG1a7XFGWIfKH5nQ==
X-Received: by 2002:a05:6512:3092:b0:4a4:68b7:e736 with SMTP id z18-20020a056512309200b004a468b7e736mr15617696lfd.32.1671504446773;
        Mon, 19 Dec 2022 18:47:26 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id e13-20020a05651236cd00b004b5a85e369asm1274866lfs.252.2022.12.19.18.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 18:47:26 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 05/15] thermal/drivers/tsens: Drop msm8976-specific defines
Date:   Tue, 20 Dec 2022 04:47:11 +0200
Message-Id: <20221220024721.947147-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
References: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
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

Drop msm8976-specific defines, which duplicate generic ones.

Fixes: 0e580290170d ("thermal: qcom: tsens-v1: Add support for MSM8956 and MSM8976")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/tsens-v1.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 96ef12d47bff..a7f53966156b 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -78,11 +78,6 @@
 
 #define MSM8976_CAL_SEL_MASK	0x3
 
-#define MSM8976_CAL_DEGC_PT1	30
-#define MSM8976_CAL_DEGC_PT2	120
-#define MSM8976_SLOPE_FACTOR	1000
-#define MSM8976_SLOPE_DEFAULT	3200
-
 /* eeprom layout data for qcs404/405 (v1) */
 #define BASE0_MASK	0x000007f8
 #define BASE1_MASK	0x0007f800
@@ -160,8 +155,8 @@ static void compute_intercept_slope_8976(struct tsens_priv *priv,
 	priv->sensor[10].slope = 3286;
 
 	for (i = 0; i < priv->num_sensors; i++) {
-		priv->sensor[i].offset = (p1[i] * MSM8976_SLOPE_FACTOR) -
-				(MSM8976_CAL_DEGC_PT1 *
+		priv->sensor[i].offset = (p1[i] * SLOPE_FACTOR) -
+				(CAL_DEGC_PT1 *
 				priv->sensor[i].slope);
 	}
 }
-- 
2.35.1

