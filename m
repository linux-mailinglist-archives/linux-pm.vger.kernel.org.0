Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796053B55F0
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jun 2021 01:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhF0XuH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Jun 2021 19:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbhF0XuH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Jun 2021 19:50:07 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D91C061574
        for <linux-pm@vger.kernel.org>; Sun, 27 Jun 2021 16:47:41 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t17so28827810lfq.0
        for <linux-pm@vger.kernel.org>; Sun, 27 Jun 2021 16:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=glA9TK5P5iHSShuGWIVMW4Eq1VPD8SNYNXKEfMbnS78=;
        b=RN1McoY0FeX+jvsdvzIgN1C5YfIngRnTw6/j0eq8zvWscvoLeLygd9+9DK3HrsxgL2
         IxyOjyY+y3T/S8PDqcAuBzqbZEJFkdO673aDHBOTnhUBYICUT4nN9HiChFkihn/ycMq9
         yP8miFmqW8EpyzaoUwEgjnAkP7wOOsiE2MyfmpHGCR432aprE/dnWUFvLT3gKWhsi2By
         oERBjMC8cC4m1OfKFT/T47t+YuTAznIQFO2Za6u+jceS9ID85JvIDrm5FyAaRYlcAHgo
         JWOWn6quCp05T9SnDjGjGjXwWbVJ0vq7DTNlYafRi0X+73EkvWOt8cgLOWb9GPTCcDf4
         rPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=glA9TK5P5iHSShuGWIVMW4Eq1VPD8SNYNXKEfMbnS78=;
        b=enrdQEHFyDZYiRCaKC+kxFECgybyghN/nn1yKAmx13Qd8/txAC5aRU1BsF292KL/Uj
         2hZRjDSxlw9PwU++v1hvJYvWkgbYR6fN3nDxg7MG8W5FPtTxtUlAd9fg19iElaicgyFS
         xx6l+PbdtaJDgjdU95vbW6kwmfoLMAfXXbMzGzMfzX6GVhQEBqlhcCZGJlZHzUqwmYSe
         m1u62/AzcjEoZi94IpQcKhGbNHTWTj4H8gjlIxjkVGeHg3tELNl9VzAGYCLgQQgykAbN
         3gXkps+pdyMVjg1nn6ke0WCKae9BfcbMDm0d0soBoynZv6iu8LqC/gtAKzNDI2hLXIrJ
         qkmQ==
X-Gm-Message-State: AOAM532NGgYi1Cd0xpx1Cc3ytv4W49d95uV/Kmqp67XoMIaapHw9VhGz
        qIkGq3YIn1caLJr08EdBC/0ixw==
X-Google-Smtp-Source: ABdhPJwOCDX11LIdDCifcA17Y8IPQHvwbKwbF4NE72ig4MfBJh5Q2sM9YMCeKD6liPkwJD898QQotw==
X-Received: by 2002:a05:6512:219:: with SMTP id a25mr17631395lfo.295.1624837659765;
        Sun, 27 Jun 2021 16:47:39 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id l14sm1151890lfg.221.2021.06.27.16.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 16:47:39 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] power: supply: core: Parse battery type/technology
Date:   Mon, 28 Jun 2021 01:45:15 +0200
Message-Id: <20210627234515.3057935-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210627234515.3057935-1-linus.walleij@linaro.org>
References: <20210627234515.3057935-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This extends the struct power_supply_battery_info with a
"technology" field makes the core DT parser optionally obtain
this from the device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This is needed to migrate the STE AB8500 custom battery bindings
and parser to the generic parser.
---
 drivers/power/supply/power_supply_core.c | 20 ++++++++++++++++++++
 include/linux/power_supply.h             |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index d99e2f11c183..9771a3236932 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -571,6 +571,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	int err, len, index;
 	const __be32 *list;
 
+	info->technology                     = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
 	info->energy_full_design_uwh         = -EINVAL;
 	info->charge_full_design_uah         = -EINVAL;
 	info->voltage_min_design_uv          = -EINVAL;
@@ -618,6 +619,25 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	 * Documentation/power/power_supply_class.rst.
 	 */
 
+	err = err = of_property_read_string(battery_np, "battery-type", &value);
+	if (!err) {
+		if (!strcmp("nickel-cadmium", value))
+			info->technology = POWER_SUPPLY_TECHNOLOGY_NiCd;
+		else if (!strcmp("nickel-metal-hydride", value))
+			info->technology = POWER_SUPPLY_TECHNOLOGY_NiMH;
+		else if (!strcmp("lithium-ion", value))
+			/* Imprecise lithium-ion type */
+			info->technology = POWER_SUPPLY_TECHNOLOGY_LION;
+		else if (!strcmp("lithium-ion-polymer", value))
+			info->technology = POWER_SUPPLY_TECHNOLOGY_LIPO;
+		else if (!strcmp("lithium-ion-iron-phosphate", value))
+			info->technology = POWER_SUPPLY_TECHNOLOGY_LiFe;
+		else if (!strcmp("lithium-ion-manganese-oxide", value))
+			info->technology = POWER_SUPPLY_TECHNOLOGY_LiMn;
+		else
+			dev_warn(&psy->dev, "%s unknown battery type\n", value);
+	}
+
 	of_property_read_u32(battery_np, "energy-full-design-microwatt-hours",
 			     &info->energy_full_design_uwh);
 	of_property_read_u32(battery_np, "charge-full-design-microamp-hours",
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index be203985ecdd..9ca1f120a211 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -352,6 +352,7 @@ struct power_supply_resistance_temp_table {
  */
 
 struct power_supply_battery_info {
+	unsigned int technology;	    /* from the enum above */
 	int energy_full_design_uwh;	    /* microWatt-hours */
 	int charge_full_design_uah;	    /* microAmp-hours */
 	int voltage_min_design_uv;	    /* microVolts */
-- 
2.31.1

