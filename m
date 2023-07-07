Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CF374B819
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 22:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjGGUh7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 16:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjGGUh5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 16:37:57 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A350A1994
        for <linux-pm@vger.kernel.org>; Fri,  7 Jul 2023 13:37:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbf1b82dc7so25040295e9.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2023 13:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688762275; x=1691354275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INi3JugwL05IgttziwnbGPvMFEJjhzc+9jyw1opOkqE=;
        b=ARupnTbks4h3FT95+Y36hjBDayLzdEXaLdFPPyr+ek3g+mJSB/XJYX++SAyGlBMAb/
         jMfh1kQ1dMnmOwlxCYORpntRz6a6D/j5C9kxQXyv8STSihhLMggreKVFyIoh8b0QFI6j
         gOxVQ2XqTMrmwEybx7nUyYG67ccuGB9YL3qp9GVxZSBcGQyGqISD+h7r6O86bztPtrab
         woGGaQfuANLzpBnzv5Y2yTEZLYbKnJI3JxG1tsAsASUixNLJwFUMrjl9PVkTf0TvbWJe
         JGmMA3SmmkylQsYK1qwa6i7SVb1C0Ikl5qsXyb0wUHiBtwbOsCsL+yqIYY0wA/FdBj8E
         EOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688762275; x=1691354275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INi3JugwL05IgttziwnbGPvMFEJjhzc+9jyw1opOkqE=;
        b=g+24SGwWVUaC3UkQQYj23wUWhkhhcomEcPg0qnrKZBBmjX01csqGGGtV+jQb/zufGb
         8ug9EKOJWcp4epO4u5K6sZ8oDKRjwX827102RltCpp3ajGTERsMmAE8rWnGIpbYxBBiE
         iZvfQM7OQuRGsiau32up9ae+Fs4e0jbL6XhDZVwXzPN7hmEU9QTJkYGdDVXTNhhNUGot
         7dQUUQlBN3GUj5e7fc4p+5rPBCQsWycc4qHC/VSINne/9ILM0EdQByjHGFIr8MbXKmKn
         hN+S+s8j4HuD0AYY/zWsl4ogrv28vUk1rCg9Juo33vgc0zQ/lXGkboSfOmYl2v3LFFSb
         v4Ag==
X-Gm-Message-State: ABy/qLbRadVAO1RMPfBzJqAywtb8as3VU/VRGnhI2oE171tIBhOcei9v
        F3XwGYvmpglUhjBR4j33GYW75Q==
X-Google-Smtp-Source: APBJJlE3ves+dG+pjqCsX+JqO34D54faHcVRS3DfpFlTo0Qi/49l4OTkpixz/vyc/5OcmUfGCN7guA==
X-Received: by 2002:a05:6000:887:b0:313:f4b9:99cc with SMTP id cs7-20020a056000088700b00313f4b999ccmr5156584wrb.68.1688762275135;
        Fri, 07 Jul 2023 13:37:55 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id i4-20020adfefc4000000b003143be36d99sm5260674wrp.58.2023.07.07.13.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 13:37:54 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Dhruva Gole <d-gole@ti.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH v2 4/4] thermal/drivers/int340x: Do not check the thermal zone state
Date:   Fri,  7 Jul 2023 22:37:31 +0200
Message-Id: <20230707203731.848188-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707203731.848188-1-daniel.lezcano@linaro.org>
References: <20230707203731.848188-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Acked-by: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../intel/int340x_thermal/int3400_thermal.c   | 32 ++++++++-----------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 72a6e28ded2e..c40b03d6c29f 100644
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

