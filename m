Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBEF6B1FFB
	for <lists+linux-pm@lfdr.de>; Thu,  9 Mar 2023 10:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjCIJ2k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Mar 2023 04:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCIJ2k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Mar 2023 04:28:40 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1905D46C
        for <linux-pm@vger.kernel.org>; Thu,  9 Mar 2023 01:28:38 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so3263574wms.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Mar 2023 01:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678354117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9b973OIjh2A0q4it2tRxdKfeAcI3pT5uZD5jTJWInpI=;
        b=G+l5L/kty7Cqd1UGH7h73jbKUw7aklIia6azseJH39wkkEaOOPIHa+jUVGAKq39HuS
         F+rNWQnOoNPXodONWQLntoaQ0fYQegKV1wB6xzs6i0QzX0SrhxHtokArpDSXHJGchZHT
         vaX/4pZMBZpnvAWjCzbMJNXEVKIx42yMyLcWdAeg6ZU362GZorQMtXl8VYyv++dDVHLt
         hAw4zHxpdg2+W+MfGur3ZAhdibifekvB3KCfSkGfoVoMHOHtq6LsEqbrPo+K2K2dv6+k
         Rq3LyjhJe1MHyxsV3KsOGjVOl6iBrx5RvBoIjyvCZHbLtHY8qp8szWH+pzoYMa07LOK+
         sSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678354117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9b973OIjh2A0q4it2tRxdKfeAcI3pT5uZD5jTJWInpI=;
        b=65SNGuvrCsC+M+5r/QFDgcDsMBfFuozAd9wYgI4gzB4mgdwjVYZf9Dt/pDptKn8ogU
         FURaG1txyDeWWMKy42rGWGFJNNi73DUy7uoeitbcJWSSku1RfCuevtzU0UPt0y1RZWFu
         7oRwj2Xw7q3YCpbDxl/S4tgS+0idg5X8B81kPuAAvLG32w016UD0RnMn/PQf/vKQWJDm
         CTXXTEEmiy61Wp66I9i3qS5D/bnAJTOZtTrH9Rq4DHNBPM8VXqkGWQaF87Lkj4o1LUl/
         3LK6V8RFneMPYksve2/Ko2Nr2Bbu+BFvtBtfJH2YqnJ7UddBquesnubiChjsotiCNGL8
         86fg==
X-Gm-Message-State: AO0yUKU6UUCeh7eQr/BsiUnkcDNZjVPOOK6sFFwnYlK0r2HSlEeIABOm
        sid7Bzzd5eiPMZo0KTizThpQd4TRnI0lpyYJsT4=
X-Google-Smtp-Source: AK7set9CmFy5X9yst6x08qHlf6fDRK2tjy3pL7GjWnLHumXofZsdSLKRxGtBypu4Cq+yfr2HvfJi0A==
X-Received: by 2002:a05:600c:3d14:b0:3df:9858:c033 with SMTP id bh20-20020a05600c3d1400b003df9858c033mr18417688wmb.8.1678354117269;
        Thu, 09 Mar 2023 01:28:37 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:fbda:65f5:e873:7527])
        by smtp.gmail.com with ESMTPSA id t24-20020a1c7718000000b003e209186c07sm1888894wmi.19.2023.03.09.01.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 01:28:36 -0800 (PST)
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
Subject: [PATCH v2 1/2] thermal/drivers/imx: Remove get_trip_temp ops
Date:   Thu,  9 Mar 2023 10:28:20 +0100
Message-Id: <20230309092821.1590586-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

