Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E5D6A351C
	for <lists+linux-pm@lfdr.de>; Sun, 26 Feb 2023 23:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjBZW42 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Feb 2023 17:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjBZWzx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Feb 2023 17:55:53 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9B41A64B
        for <linux-pm@vger.kernel.org>; Sun, 26 Feb 2023 14:55:30 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j19-20020a05600c1c1300b003e9b564fae9so5956521wms.2
        for <linux-pm@vger.kernel.org>; Sun, 26 Feb 2023 14:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2s/AS9OMV5i6t0w60QjnkUP8k7sKtqb93EMncEZug0=;
        b=RrXcIqzcrWf2lNRMsPY+D8nUU5rGWSM/ctrK4w2nFXbnQIS281ZCN9hQiySwkMaUmg
         upw/yejus11mTRnMf9kyQ8gqoPpRUayc7Le6DAYr8ShIyNEV8dg63GJFOplB+8exl3wJ
         Em6nycsPTYfFl+zDoWh5qQ9+mHwo48EJhqJK0rjys+U3DHccFifM5dHgsYx+C/EWFYRc
         cbKjrnTFV1f9nQ4eHFai6JIqCKWyRn/dQWMKYr/8MrIJLqCcfaP4SlVyfdiQOaLEvGGb
         cVnH3W/4JRlsSbhTSaUAhTampVjDhPKyEAtrQ7rClYMgA3/L96CQykGpc6QpVg+ie+VQ
         ICRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2s/AS9OMV5i6t0w60QjnkUP8k7sKtqb93EMncEZug0=;
        b=QBLqFf9GPsu8C7rXFC1p15hxGNzgEVNSoOnIcvlMn1RrwmJBILxz2uaKBG5K8K2QNJ
         3mSYPpsEMJ866d9+QrmDqL/njcFxcYyaNg7VAH11pDVboXJYq+VBA4S1rJwtT9R4eL5f
         IzCnG208XJII/hopHYJV5o0nwP/mCbruj24TxmOMm7z38wUuBZmBeR1Kgv+88Dgpw9V3
         7CDmXZ50KzQWOMfImO8QGtKd7zQ37vVfDur5/HxmW/TwVqyzOmpbtCy20UQmB5o6uZ1p
         ogBSPlRMZDJjDGbDrxVInZYtz6GZcRmrESqxOoMqET0g6rb8UF/DQpsR8Am6A9qZQtdr
         BziQ==
X-Gm-Message-State: AO0yUKUL28w5NlwZTUCSSwVXgw32H2WmBh4DCobgBRmw4WWNFmQ9B7tl
        kzwMaqKodTm09zEJTwuynrfIsQ==
X-Google-Smtp-Source: AK7set/kFC/e3JlZYmMRVlzQDE+2UMKDg2IK1WyToa9A8POY4T7GJ/bhhVXjg1e/yJdRr/Fu6abtUw==
X-Received: by 2002:a05:600c:3089:b0:3eb:29fe:734a with SMTP id g9-20020a05600c308900b003eb29fe734amr6436608wmn.39.1677452121129;
        Sun, 26 Feb 2023 14:55:21 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8baa:6b32:391b:62de])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b003eb369abd92sm6138074wms.2.2023.02.26.14.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 14:55:20 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH v3 17/20] thermal/tegra: Do not enable the thermal zone, it is already enabled
Date:   Sun, 26 Feb 2023 23:54:03 +0100
Message-Id: <20230226225406.979703-18-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226225406.979703-1-daniel.lezcano@linaro.org>
References: <20230226225406.979703-1-daniel.lezcano@linaro.org>
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

The code enables the thermal zone after setting it up. But the thermal
zone is already enabled by thermal_of_zone_register() function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/tegra/tegra30-tsensor.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index 3506c3f3c474..e38902abf207 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -346,7 +346,7 @@ static int tegra_tsensor_enable_hw_channel(const struct tegra_tsensor *ts,
 {
 	const struct tegra_tsensor_channel *tsc = &ts->ch[id];
 	struct thermal_zone_device *tzd = tsc->tzd;
-	int err, hot_trip = 0, crit_trip = 0;
+	int hot_trip = 0, crit_trip = 0;
 	u32 val;
 
 	if (!tzd) {
@@ -401,12 +401,6 @@ static int tegra_tsensor_enable_hw_channel(const struct tegra_tsensor *ts,
 	val |= FIELD_PREP(TSENSOR_SENSOR0_CONFIG0_INTR_THERMAL_RST_EN, 1);
 	writel_relaxed(val, tsc->regs + TSENSOR_SENSOR0_CONFIG0);
 
-	err = thermal_zone_device_enable(tzd);
-	if (err) {
-		dev_err(ts->dev, "ch%u: failed to enable zone: %d\n", id, err);
-		return err;
-	}
-
 	return 0;
 }
 
-- 
2.34.1

