Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA82E6B1479
	for <lists+linux-pm@lfdr.de>; Wed,  8 Mar 2023 22:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCHVs6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Mar 2023 16:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjCHVs4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2023 16:48:56 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CEE99D51
        for <linux-pm@vger.kernel.org>; Wed,  8 Mar 2023 13:48:40 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h14so33025wru.4
        for <linux-pm@vger.kernel.org>; Wed, 08 Mar 2023 13:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678312118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9b973OIjh2A0q4it2tRxdKfeAcI3pT5uZD5jTJWInpI=;
        b=YMAZmJORveNcNQt8Xuwzh04+SXOMfA0xiAPvb6CaAqKSZGmF0QwHOHB2Qmu1jT1yxQ
         Y4WWPCF9Nj+IS21dbGu7Hh1bRdn5iwZJTGmgxGn7OfVXfTLVjaCxt0puIxF/msRd9np4
         pgszGCaIjfQCdHQDxsxpzWwcopep3sj7QnEz6xk0unVb+rg3gKtoWSh4Vm8cNuqPDGae
         vR1lm6gamA6AnRxa+PiJ/QrI1Hd4fA7PifMMitRNmRPWjXnALM8Mp9FQBVCeMe/af4L3
         8Y/FDU9hCDAOqDc61m5MYZugAa9DLbj1B4t696f0Pyx3K7WoL+OZUWBm7d/Lhky4Nhjw
         ms4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678312118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9b973OIjh2A0q4it2tRxdKfeAcI3pT5uZD5jTJWInpI=;
        b=54GWQBEOguTzbpOlKwx1WxyUvD4EAx7ZydNwI63Fc7RKtpUU7H8PuqLsKjQ3tPDlEe
         JejJPoMMSLEUrvWhdt2ZpJe7mzQkLZ76QMkOPgsMGBYJX3y0G/t+cFOuQVcC06yJmKr9
         BcArVbz+Zeme5StsBXUcTkNESv+vCIsHxA1Xd9fQo/j/pSH3/tJCjXV2ey4HznPYpHEv
         YR3fBhSNBCMKmQBOpaICKEmUUgzyQXEVDN9UEuN0Q+2ucx2qh+5nTIJToXXvwleJuhuI
         jhGhHAMn5ms5hiUFblYTe4c9rq9ylTZDo8C6lGLO6CB4k3++FzzgOQMaPMC8VrYE+mx5
         wfzw==
X-Gm-Message-State: AO0yUKVfGI/1QnDEiaiPcL0e+q17jimn8Wh7aFc1AZ1wV3HVjv/1vW/4
        OBLcbhOUSzvi/dS2nGlHAeHSHw==
X-Google-Smtp-Source: AK7set9dNQIoqJwJ1YDp+pOXC2yzZe8SPtUpY47j+15NDVfKGPTAxNPVDJYhNaO50DjaF0ITnaNgKQ==
X-Received: by 2002:a5d:62c3:0:b0:2c5:5237:3b21 with SMTP id o3-20020a5d62c3000000b002c552373b21mr13902966wrv.69.1678312118499;
        Wed, 08 Mar 2023 13:48:38 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:fbda:65f5:e873:7527])
        by smtp.gmail.com with ESMTPSA id z6-20020adfd0c6000000b002c55efa9cbesm16065713wrh.39.2023.03.08.13.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:48:38 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Subject: [PATCH 1/2] thermal/drivers/imx: Remove get_trip_temp ops
Date:   Wed,  8 Mar 2023 22:48:21 +0100
Message-Id: <20230308214822.1317086-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The i.MX thermal sensor uses the generic trip points. The thermal
framework can return the critical temperature directly.

Remove the pointless get_trip_temp ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/imx_thermal.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index c3136978adee..69ed482167f7 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -330,13 +330,6 @@ static int imx_change_mode(struct thermal_zone_device *tz,
 	return 0;
 }
 
-static int imx_get_crit_temp(struct thermal_zone_device *tz, int *temp)
-{
-	*temp = trips[IMX_TRIP_CRITICAL].temperature;
-
-	return 0;
-}
-
 static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
 			     int temp)
 {
@@ -384,7 +377,6 @@ static struct thermal_zone_device_ops imx_tz_ops = {
 	.unbind = imx_unbind,
 	.get_temp = imx_get_temp,
 	.change_mode = imx_change_mode,
-	.get_crit_temp = imx_get_crit_temp,
 	.set_trip_temp = imx_set_trip_temp,
 };
 
-- 
2.34.1

