Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D202FF45F
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 20:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbhAUTS5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 14:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbhAUTR7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 14:17:59 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4186FC061794;
        Thu, 21 Jan 2021 11:16:55 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id g15so2298612pjd.2;
        Thu, 21 Jan 2021 11:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yP+8b8XvGsdxgGgAFZqhFaVyr9bwBdl4LtN4K2NEQ40=;
        b=F3/fX+nIsjIqArVF4sHR0hFqYdbZKyD+cLISGK+Yu7+I2zpt6HoVolNpC3uv0HIC6Y
         b75T6m0qjcTcqk2fNUdfxkX1UNI6LoZ16xC8DIDIXYQvakT0mh+pajsQoWKA3no4XgG3
         8m6UhKba89bZG0ldbO4H5yH44LX1SN8P+LlYGhDlWzKJZHzytrwFQZc1kTGWwgON68j+
         W33OzWtVO1ve5bmCiHEif+qFDdAafx0GMQ/AReXl779mht/z4SnBmeOs5+ZXkDG7gXy8
         0vBj/VBPsvcfjYdusSWKgxbDWVQ2+/pFtChf+mhr8S1NW8QnTgQ9m/3Y/jJCOQuGF90S
         P7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yP+8b8XvGsdxgGgAFZqhFaVyr9bwBdl4LtN4K2NEQ40=;
        b=eNVpK6jh+EvnomK9zK7+EJp+sqeo11jpgvtuVeJA/oR9fUmFIA8fkHzkUpfVSUhse8
         s54XvjNMtZiy5TMSc7oJsNhDdfiq95wnsKjAEHUwqsMxluEweLc+Y9S5beOLX2YBoka8
         wY35bt7H8BoLjlo/n8UWIswMD/x508/A9p1IwghqbMeiIqWN1f+piKPVt6+ZnO6P8rIS
         tDINAW1S4JEJhwJqGeI6lZr8nicdDdgti9X8oFakILFjmC9ZB9W01XIs+41/bEc3hd60
         VrPIHrE1f7Elj5CYEquX+pnqo0yi7UugmI8mPmy9Td5nZGNeUk0gcxnw375sERfLyxjr
         wGCQ==
X-Gm-Message-State: AOAM532zrCIDjMl5wV1tPyz7kVm3wiRRCbRg03LxSf1Fdl9HYYWxpitz
        0zXPOCmfqklEDnTkA/mPAX8=
X-Google-Smtp-Source: ABdhPJwWDMkGkRWSv8MetyQC3EHii10tkXaZA+VJdPrzZmAhRPSoNxNtMQjUsLTONQbML4YKvfxmMQ==
X-Received: by 2002:a17:902:e8cf:b029:de:a91c:5ec9 with SMTP id v15-20020a170902e8cfb02900dea91c5ec9mr1159215plg.27.1611256614744;
        Thu, 21 Jan 2021 11:16:54 -0800 (PST)
Received: from ansuel-xps20.localdomain (host-79-41-39-5.retail.telecomitalia.it. [79.41.39.5])
        by smtp.googlemail.com with ESMTPSA id gg6sm11291013pjb.2.2021.01.21.11.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 11:16:53 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/8] drivers: thermal: tsens: Use init_common for msm8960
Date:   Thu, 21 Jan 2021 20:15:56 +0100
Message-Id: <20210121191601.14403-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121191601.14403-1-ansuelsmth@gmail.com>
References: <20210121191601.14403-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use init_common and drop custom init for msm8960.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/thermal/qcom/tsens-8960.c | 52 +------------------------------
 1 file changed, 1 insertion(+), 51 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 3f4fc1ffe679..86585f439985 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -173,56 +173,6 @@ static void disable_8960(struct tsens_priv *priv)
 	regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
 }
 
-static int init_8960(struct tsens_priv *priv)
-{
-	int ret, i;
-	u32 reg_cntl;
-
-	priv->tm_map = dev_get_regmap(priv->dev, NULL);
-	if (!priv->tm_map)
-		return -ENODEV;
-
-	/*
-	 * The status registers for each sensor are discontiguous
-	 * because some SoCs have 5 sensors while others have more
-	 * but the control registers stay in the same place, i.e
-	 * directly after the first 5 status registers.
-	 */
-	for (i = 0; i < priv->num_sensors; i++) {
-		if (i >= 5)
-			priv->sensor[i].status = S0_STATUS_ADDR + 40;
-		priv->sensor[i].status += i * 4;
-	}
-
-	reg_cntl = SW_RST;
-	ret = regmap_update_bits(priv->tm_map, CNTL_ADDR, SW_RST, reg_cntl);
-	if (ret)
-		return ret;
-
-	if (priv->num_sensors > 1) {
-		reg_cntl |= SLP_CLK_ENA | (MEASURE_PERIOD << 18);
-		reg_cntl &= ~SW_RST;
-		ret = regmap_update_bits(priv->tm_map, CONFIG_ADDR,
-					 CONFIG_MASK, CONFIG);
-	} else {
-		reg_cntl |= SLP_CLK_ENA_8660 | (MEASURE_PERIOD << 16);
-		reg_cntl &= ~CONFIG_MASK_8660;
-		reg_cntl |= CONFIG_8660 << CONFIG_SHIFT_8660;
-	}
-
-	reg_cntl |= GENMASK(priv->num_sensors - 1, 0) << SENSOR0_SHIFT;
-	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
-	if (ret)
-		return ret;
-
-	reg_cntl |= EN;
-	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static int calibrate_8960(struct tsens_priv *priv)
 {
 	int i;
@@ -346,7 +296,7 @@ static const struct reg_field tsens_8960_regfields[MAX_REGFIELDS] = {
 };
 
 static const struct tsens_ops ops_8960 = {
-	.init		= init_8960,
+	.init		= init_common,
 	.calibrate	= calibrate_8960,
 	.get_temp	= get_temp_8960,
 	.enable		= enable_8960,
-- 
2.29.2

