Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B201E56D196
	for <lists+linux-pm@lfdr.de>; Sun, 10 Jul 2022 23:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiGJV0g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Jul 2022 17:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiGJVZ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Jul 2022 17:25:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EC81581E
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:25:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d16so4742991wrv.10
        for <linux-pm@vger.kernel.org>; Sun, 10 Jul 2022 14:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M2wfLrxXnyl/4VAOjy10YdLX3f8bz6C8KrI7vU13mPo=;
        b=GF3P6Ppzi5+tUgEUE3vCUVcj/Lq0AuDieMw0s4jyfEKnnDNqI0hX1t2JtNhMRXSERR
         dZ+pTJQx5YaUVt8cT8ctcyB8Oe+eQ36Pnvp+ICr5uH04C47g+yfNNxoBSrsZSLtqcWTC
         tDgwObfr8ClF78HSehzFcQ3jgomp5rag+Fqfz597GQt3mABMbgMIBUAgBQMvFx+6r30j
         rfXXXg52iclx77Enq9KsjF041SeWnpJx573n1qjlDMAF+F9wIFOak5pNAeQiRxDl2AIJ
         XpOEiPtT7yitt798THZk+5n7Pv5npwnuIycLTZ8pVN1VJAZJOoPaEKrjmPTCdTK6aNFn
         gY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M2wfLrxXnyl/4VAOjy10YdLX3f8bz6C8KrI7vU13mPo=;
        b=piWBJTiYwEI2udEbx5E8QizJwmTFvKUAoz50sZ2sqi0kU2Rfpkgxs/gubyRGfxVO0Z
         zJjOBvvowPlpMbsHIGIUu86PZlH50k3GWbkOyF5LBIOswOaaQ39fjqUK0nvYVF33T5xB
         GOPLDW9kG87A93g/UeqqpZDuT7VJQb5grNwEuyQ3eYRYWEGOt5AXBxXOVE5BYVLGFOgu
         oiMILPcfYWF0tMccEOs7nl+Q+ZjMja1R4/SOSkH94JUJLxm8RxktfTVzxMhaodAN5PJr
         tEz81k3bP4S9npOE5A2IDRYucnPTvDKGzVFl0ljU27Fi8zPPwEor4601s3oSC+VgJjpT
         S+Ug==
X-Gm-Message-State: AJIora8KENM4njor5F6h+B92p6wWuTvrp9E7afDXjv5y/fj83Q7ZDoCW
        d96jWNXPMAnEsdPVtOSzz01CkA==
X-Google-Smtp-Source: AGRyM1tbyrl3D/MULNcGXt5KDLm/AiRAo6WzJyqoCBnaHv/g+Na1lzusD3ORcFiw4Iiv/pgV6cV1VQ==
X-Received: by 2002:adf:9d82:0:b0:21a:3906:59cc with SMTP id p2-20020adf9d82000000b0021a390659ccmr13761133wre.289.1657488307710;
        Sun, 10 Jul 2022 14:25:07 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c7c0:6823:f3ce:2447])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c3b1300b003a2dd0d21f0sm7142759wms.13.2022.07.10.14.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 14:25:07 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 18/33] thermal/drivers/rzg2l: Switch to new of API
Date:   Sun, 10 Jul 2022 23:24:08 +0200
Message-Id: <20220710212423.681301-19-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710212423.681301-1-daniel.lezcano@linexp.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach.

Use this new API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/rzg2l_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index be07e04c6926..22eb58b69f4a 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -73,9 +73,9 @@ static inline void rzg2l_thermal_write(struct rzg2l_thermal_priv *priv, u32 reg,
 	iowrite32(data, priv->base + reg);
 }
 
-static int rzg2l_thermal_get_temp(void *devdata, int *temp)
+static int rzg2l_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct rzg2l_thermal_priv *priv = devdata;
+	struct rzg2l_thermal_priv *priv = tz->devdata;
 	u32 result = 0, dsensor, ts_code_ave;
 	int val, i;
 
@@ -111,7 +111,7 @@ static int rzg2l_thermal_get_temp(void *devdata, int *temp)
 	return 0;
 }
 
-static const struct thermal_zone_of_device_ops rzg2l_tz_of_ops = {
+static struct thermal_zone_device_ops rzg2l_tz_of_ops = {
 	.get_temp = rzg2l_thermal_get_temp,
 };
 
@@ -203,8 +203,8 @@ static int rzg2l_thermal_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	zone = devm_thermal_zone_of_sensor_register(dev, 0, priv,
-						    &rzg2l_tz_of_ops);
+	zone = devm_thermal_of_zone_register(dev, 0, priv,
+					     &rzg2l_tz_of_ops);
 	if (IS_ERR(zone)) {
 		dev_err(dev, "Can't register thermal zone");
 		ret = PTR_ERR(zone);
-- 
2.25.1

