Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2468A710DE5
	for <lists+linux-pm@lfdr.de>; Thu, 25 May 2023 16:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbjEYOCn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 May 2023 10:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241495AbjEYOCe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 May 2023 10:02:34 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D1CE67
        for <linux-pm@vger.kernel.org>; Thu, 25 May 2023 07:02:10 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-309382efe13so1508142f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 25 May 2023 07:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685023328; x=1687615328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00zbO/h32JbOBK4pj9NMcyYg6KfU8i34rsNlNDxLhwU=;
        b=WqiKxZE9ZACdkHhs/a94AzeA/I0y8YTIHAIfJS41qFT48zEv9pAwMfMC0Y9tq3zc+R
         zZz7vOUhG2LrYLlq2yoFzOjYRa3OBZA5Sttsdkitc7wmouzZmYA/ZdaVtMgyGrTKHApr
         +HnIPQDzpREbZRzcCkWhKn1o8x5QQpeNX2/w+VVh1JD702Lj6xl6GQYvBVnrP1w8BLg/
         b+ky7KJk7gNHqJV2xEpTBvTN1G1Vclx9W2nYUu2St6/c53Z6KM93zAthmZlGFs6JGdQx
         QACkydqiSFpCRqeAFzEJsn8YFNp9H6Oq0LXlBSJA6S+BQCBRWfhMns817mFlI2j6dTtr
         iIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685023328; x=1687615328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00zbO/h32JbOBK4pj9NMcyYg6KfU8i34rsNlNDxLhwU=;
        b=UXdewDGSR5Bn86D4SpemWgROPucEavHAlpRmGC2aZwuM+1NvxCz8uZujKjsJZ51KOw
         LFc4Er8EJ528ip/ta8HI1AMUTMgaVtmMG+fPCIQoZIaTlPzDQMuIAviR8/vvSjzPiXPx
         SHo4tuyKnYuel/puBa9gK4Gi6nuXr/ojMLFVurbFgg8njQOMKmR9Tof1jtqkbqov2U+B
         cZ4NnyT5AwPpIvR5pizU9+JUevfnzu0O9xP8MRXXdxqaucxlj7/WYHx5m7x2UB9MD8+U
         9cskrpz2CkLqQmpIGUcKgjzgH45PYDmBq/vf0IjTwChRdjow/wlaXYGShb1+LujHna5o
         6xug==
X-Gm-Message-State: AC+VfDyY2Jl8uOn6j1bi6+1k7C2qUFyWv6kgXNWBzmvb7ZEfizF6OThN
        P0s0lXsdlRvB00WxJX9fFQKokw==
X-Google-Smtp-Source: ACHHUZ6v7mcKs1ULB0e/sneWV6xt3S8X1TWh52w1LQ58NQpdPLcw+H3cCfaVH8wNWaIxhLUQsyVHiQ==
X-Received: by 2002:a05:6000:1208:b0:309:3ddc:1c8c with SMTP id e8-20020a056000120800b003093ddc1c8cmr2608310wrx.20.1685023328305;
        Thu, 25 May 2023 07:02:08 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5aef:8608:89d7:7961])
        by smtp.gmail.com with ESMTPSA id u4-20020adfdd44000000b003063176ef09sm1944866wrm.6.2023.05.25.07.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 07:02:07 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 6/8] thermal/drivers/int340x: Do not check the thermal zone state
Date:   Thu, 25 May 2023 16:01:33 +0200
Message-Id: <20230525140135.3589917-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver is accessing the thermal zone state to ensure the state is
different from the one we want to set.

We don't want the driver to access the thermal zone device internals.

Actually, the thermal core code already checks if the thermal zone's
state is different before calling this function, thus this check is
duplicate.

Remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../intel/int340x_thermal/int3400_thermal.c   | 32 ++++++++-----------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 66e34241b33a..cba636d6784d 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -503,32 +503,28 @@ static int int3400_thermal_change_mode(struct thermal_zone_device *thermal,
 {
 	struct int3400_thermal_priv *priv = thermal_zone_device_priv(thermal);
 	int result = 0;
+	int enabled;
 
 	if (!priv)
 		return -EINVAL;
 
-	if (mode != thermal->mode) {
-		int enabled;
+	enabled = mode == THERMAL_DEVICE_ENABLED;
 
-		enabled = mode == THERMAL_DEVICE_ENABLED;
-
-		if (priv->os_uuid_mask) {
-			if (!enabled) {
-				priv->os_uuid_mask = 0;
-				result = set_os_uuid_mask(priv, priv->os_uuid_mask);
-			}
-			goto eval_odvp;
+	if (priv->os_uuid_mask) {
+		if (!enabled) {
+			priv->os_uuid_mask = 0;
+			result = set_os_uuid_mask(priv, priv->os_uuid_mask);
 		}
-
-		if (priv->current_uuid_index < 0 ||
-		    priv->current_uuid_index >= INT3400_THERMAL_MAXIMUM_UUID)
-			return -EINVAL;
-
-		result = int3400_thermal_run_osc(priv->adev->handle,
-						 int3400_thermal_uuids[priv->current_uuid_index],
-						 &enabled);
+		goto eval_odvp;
 	}
 
+	if (priv->current_uuid_index < 0 ||
+	    priv->current_uuid_index >= INT3400_THERMAL_MAXIMUM_UUID)
+		return -EINVAL;
+
+	result = int3400_thermal_run_osc(priv->adev->handle,
+					 int3400_thermal_uuids[priv->current_uuid_index],
+					 &enabled);
 eval_odvp:
 	evaluate_odvp(priv);
 
-- 
2.34.1

