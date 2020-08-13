Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196822440A1
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 23:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgHMVfP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 17:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHMVef (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 17:34:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F22C061757;
        Thu, 13 Aug 2020 14:34:35 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w25so7768217ljo.12;
        Thu, 13 Aug 2020 14:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O0yugzvKqUofOFg3gQRSvSu6LWWdYaLpdIpz8+ZfmFw=;
        b=ddXLjfWdJqtVi9h0B0q10kZwaUeFC21Cmph08cYVhcYpcRipvwLkeLriefbwYCcpfX
         rTbmC4KnsQCFYU1rdDlTWecPjwDSsDLO0G9zds2gZZnxBSQJhpBB8eZyzGKKcrfUsMP5
         Wgjm8jGtpOif/83zPKkw4ljD/qMIMU83AwkYSQHDVKGr3Bq4R65FeRZtz6yKlyBPyrlM
         UqtZt738ZsXQNjSx4hnPkugPw2chvbDcI55NsFClym66wv7t5DhKasIYMvBFadijib66
         0/TKzIYHWVHIZ0T6/IJWuQIIFqb/5/pdyLklEFcHBXmO4h1/5+WakWOaLYVwEnp62K2/
         ctrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O0yugzvKqUofOFg3gQRSvSu6LWWdYaLpdIpz8+ZfmFw=;
        b=AaFxAwx3nuyXBGW7x+TZQ6dRu87S/cERD+71sfmvaJ+vkysbU65q1B6eMXPXAD/DRf
         HANBl7yKd0Lzzd2npDcr3rDHG/69zCWrACU1puwG0ewKUajyzp1z4okPhh9x9ZGaTKZA
         5eLsIKEw8PNOwhg6Lw4p6J0I9T6gPbKE4nHEIMZ1X+aUs1SfFwvjqwtx3BEyA1REfZIk
         TogQPEeQXxYuIHmGWY6fBM4Vyn1PjQuJGEdMbOwritLLrIMhqmAW+LQn1x6T4ZcJ/SwS
         Z7dc43Exw2Sx92bb6zV30GrQSEZSfDssR1GXC49baCZrl2h/C7/53E6wXMRxqmhQ9cyh
         mPng==
X-Gm-Message-State: AOAM532m+TRPHsz4q51w3Wx4zukBgqae9llOy2ZqlGrictq6FSyxliyZ
        Hc7rwyMCybe0uj/uFctADXU=
X-Google-Smtp-Source: ABdhPJznWI2df852Z9LPq9Z2Nw9rDffTl31+GknxyxBxb5ZTU/I2CWkvoOOdoGCj8Zd191VQqU6etw==
X-Received: by 2002:a2e:9449:: with SMTP id o9mr3142556ljh.403.1597354473868;
        Thu, 13 Aug 2020 14:34:33 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id j2sm1345309ljb.98.2020.08.13.14.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:34:33 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Bruce E . Robertson" <bruce.e.robertson@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 03/10] power: supply: Support battery temperature device-tree properties
Date:   Fri, 14 Aug 2020 00:34:02 +0300
Message-Id: <20200813213409.24222-4-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200813213409.24222-1-digetx@gmail.com>
References: <20200813213409.24222-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The generic battery temperature properties are already supported by the
power-supply core. Let's support parsing of the common battery temperature
properties from a device-tree.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/power/supply/power_supply_core.c | 19 +++++++++++++++++++
 include/linux/power_supply.h             |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index ccbad435ed12..38e3aa642131 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -579,6 +579,12 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	info->charge_term_current_ua         = -EINVAL;
 	info->constant_charge_current_max_ua = -EINVAL;
 	info->constant_charge_voltage_max_uv = -EINVAL;
+	info->temp_ambient_alert_min         = INT_MIN;
+	info->temp_ambient_alert_max         = INT_MAX;
+	info->temp_alert_min                 = INT_MIN;
+	info->temp_alert_max                 = INT_MAX;
+	info->temp_min                       = INT_MIN;
+	info->temp_max                       = INT_MAX;
 	info->factory_internal_resistance_uohm  = -EINVAL;
 	info->resist_table = NULL;
 
@@ -639,6 +645,19 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	of_property_read_u32(battery_np, "factory-internal-resistance-micro-ohms",
 			     &info->factory_internal_resistance_uohm);
 
+	of_property_read_u32_index(battery_np, "ambient-celsius",
+				   0, &info->temp_ambient_alert_min);
+	of_property_read_u32_index(battery_np, "ambient-celsius",
+				   1, &info->temp_ambient_alert_max);
+	of_property_read_u32_index(battery_np, "alert-celsius",
+				   0, &info->temp_alert_min);
+	of_property_read_u32_index(battery_np, "alert-celsius",
+				   1, &info->temp_alert_max);
+	of_property_read_u32_index(battery_np, "operating-range-celsius",
+				   0, &info->temp_min);
+	of_property_read_u32_index(battery_np, "operating-range-celsius",
+				   1, &info->temp_max);
+
 	len = of_property_count_u32_elems(battery_np, "ocv-capacity-celsius");
 	if (len < 0 && len != -EINVAL) {
 		err = len;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 97cc4b85bf61..d0684362a392 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -365,6 +365,12 @@ struct power_supply_battery_info {
 	int constant_charge_voltage_max_uv; /* microVolts */
 	int factory_internal_resistance_uohm;   /* microOhms */
 	int ocv_temp[POWER_SUPPLY_OCV_TEMP_MAX];/* celsius */
+	int temp_ambient_alert_min;             /* celsius */
+	int temp_ambient_alert_max;             /* celsius */
+	int temp_alert_min;                     /* celsius */
+	int temp_alert_max;                     /* celsius */
+	int temp_min;                           /* celsius */
+	int temp_max;                           /* celsius */
 	struct power_supply_battery_ocv_table *ocv_table[POWER_SUPPLY_OCV_TEMP_MAX];
 	int ocv_table_size[POWER_SUPPLY_OCV_TEMP_MAX];
 	struct power_supply_resistance_temp_table *resist_table;
-- 
2.27.0

