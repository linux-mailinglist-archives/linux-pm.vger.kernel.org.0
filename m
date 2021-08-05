Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068193E10B6
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 11:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhHEJAu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 05:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhHEJAt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 05:00:49 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3FDC061765
        for <linux-pm@vger.kernel.org>; Thu,  5 Aug 2021 02:00:35 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t9so9672519lfc.6
        for <linux-pm@vger.kernel.org>; Thu, 05 Aug 2021 02:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0jPitpwrLWs8upJmUfHM9pLts94cUU2HAf+gduXaN9c=;
        b=FhH63W2sAvg06MqYrl7Sds2Xf+WGV8f8I8AC5Ywr2/o1Qv6OgeEHsIwW6F68BKRpmP
         +x8Ctxj1hIQVKUBPVRIOyPXO6oSAWj+w+vI94AP+HByjbaGd84/bY2SF2AUJOIl94k+3
         DZAKaBIvFtFxTSLFGxiqIi9sV7SdmeTn4ALBxcgO+huQLVXFqDJiL29vziAMoNoR0FbI
         /wxRM4fxAcfFbgHpyAw8GrVx5Ifqw8XcOysxfnAQqlh460pawsyzlVs3o/ZMi136F0FZ
         45q5wyaB9MyZCeIXnN1dKBB8Y6zyP8Rejfhzj76v81VfNdCjc7I7mC18L82k9UX3Ju2k
         AF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0jPitpwrLWs8upJmUfHM9pLts94cUU2HAf+gduXaN9c=;
        b=P/PECFaC7rL1wyvshNI6FZxuwAY0O5FFu5zperIInjD0D9KXsJgmvTzDXXL5p3El7/
         Wpu4FLn925GtGjnruAjiYxoaqcA7fQWGC5K+0bBx5nrU7tvOzXmjuS45kXpG9iNK6S0P
         mIvobHW3+8/OK8bnu4ddsXDaLLnXJTHIDQXyBNLVIWnOrwF23HqoXNzW7TtSE8BXH4TC
         nOA34V/5gW7Es9HOaYlkcqftI0kUOHkYIi1jijRl0A/8FIWURxJ+HPIJlLZReTsFOdO+
         oirk0QAaeFVm14b489GJe5BkgkvovDmdu8Zi4VXA5zqah3z9v3HsU79xTUIpelT2EIBq
         DGVQ==
X-Gm-Message-State: AOAM532xSRtw3YDcpyY0VdiEBdoHnN9f0uB2ojL+Izc3WMpLzAX3Qin0
        erSIsT6FZI3WVTYKCDDr/sd23g==
X-Google-Smtp-Source: ABdhPJw8jrsLvPAqmn363e+w6OKvc/f2IDnPo97OaEVtCBQjeCBSK7qu36ztsxb2s9SFiCYt2GkwMg==
X-Received: by 2002:ac2:4a7a:: with SMTP id q26mr2831992lfp.582.1628154034027;
        Thu, 05 Aug 2021 02:00:34 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id z1sm447901lfu.222.2021.08.05.02.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 02:00:33 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2 v2] power: supply: core: Parse battery type/technology
Date:   Thu,  5 Aug 2021 10:58:28 +0200
Message-Id: <20210805085828.3451909-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210805085828.3451909-1-linus.walleij@linaro.org>
References: <20210805085828.3451909-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Drop the accidental double assignment of err as reported
  by the kernel test robot et al.
- Switch to "device-chemistry" instead of "battery-type"
  to indicate the type.
This is needed to migrate the STE AB8500 custom battery bindings
and parser to the generic parser.
---
 drivers/power/supply/power_supply_core.c | 20 ++++++++++++++++++++
 include/linux/power_supply.h             |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index d99e2f11c183..dd62c871b2b5 100644
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
 
+	err = of_property_read_string(battery_np, "device-chemistry", &value);
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

