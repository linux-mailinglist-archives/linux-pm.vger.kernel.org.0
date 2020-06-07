Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B22B1F0C1E
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 16:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgFGOpz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 10:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgFGOpV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 10:45:21 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E86EC08C5C4;
        Sun,  7 Jun 2020 07:45:21 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id x18so838764lji.1;
        Sun, 07 Jun 2020 07:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FBWrwuGDYKLF1vOWbwPhfzrgLBpIGQxKlTKbvNiY2ss=;
        b=h5k/BpkWLZlZJyeH4iWB7dTj3NqUreNyP4nokCg0nqCnreEhjJQ37Mb8Uyr62J10p0
         ZU/5EGzD1sXYrsRf2HNkMVl0jB/FsKYbGJ6nbHKOnnKde7WCrBFaSnISynVP/2+NbqWO
         wNBmkRJiX1pcXaHm9KH0CqNZjCslESM2m61q16NXhNQk/SFK0zlPz9FvvOiXtj484lWR
         AkEw0kLHgKN5p12imeG+ZpziGh47a/8VjAh+E2vsq7Y1D759p2pBODb+Sxt1wF3Kgsfl
         H6dKsrTJqF61qLsasH/KT5zhL8/LkCQi2sQ4NAe4jD4vqpSjsBP7jLMsxKhUtFUda78Y
         RGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FBWrwuGDYKLF1vOWbwPhfzrgLBpIGQxKlTKbvNiY2ss=;
        b=g8Jk/68Iig6WoALRiAXQv3wNmbGKXCw2I8dnaO+pFgCzhceLtx1zPtaayeVwAHPBEd
         YGji49DOilAUg2ppCdsu63x/jrG0A6zEjgB2jLpoi+6FkH9rd4QQIJKG5drOnyf3FRr1
         OXFGvld6x4lds7emAGbgjTLEaEoxIGscaTp+hYnpaUv8k4tLi8dpCdEYz4AWVSjN26Ct
         ScH2n56rnLYhX2ejh2p7SWnIroZ1y/uLRquZ0Y/uhXP3J7ZpqT1aAEyj8hzakey82mmg
         BI9Lyg2zPnWe7cu85+dwCzaR+gu6kuhuxIPhgInjC4hmak4qX9ae21wQSpRefSsgdeSE
         8PNQ==
X-Gm-Message-State: AOAM532Sz31eSESMcMWR+POuNzdnAUMR52oCBq6GycbhGzhzzhbOFHGA
        oz3JfVYn29MsDbuK4j/TU18=
X-Google-Smtp-Source: ABdhPJwduQ6Mg5XXVMUnf5kjLG+sCaJFsEsnZP6qobIVMm1rtA3asW69nA6EPCERg0uVYiLDxboYsg==
X-Received: by 2002:a2e:8747:: with SMTP id q7mr8329350ljj.459.1591541119855;
        Sun, 07 Jun 2020 07:45:19 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id g24sm4059724lfh.90.2020.06.07.07.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 07:45:19 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>
Subject: [PATCH v2 3/9] power: supply: Support battery temperature device-tree properties
Date:   Sun,  7 Jun 2020 17:41:07 +0300
Message-Id: <20200607144113.10202-4-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607144113.10202-1-digetx@gmail.com>
References: <20200607144113.10202-1-digetx@gmail.com>
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
 drivers/power/supply/power_supply_core.c | 18 ++++++++++++++++++
 include/linux/power_supply.h             |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 02b37fe6061c..8b54a5a107d7 100644
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
 
@@ -638,6 +644,18 @@ int power_supply_get_battery_info(struct power_supply *psy,
 			     &info->constant_charge_voltage_max_uv);
 	of_property_read_u32(battery_np, "factory-internal-resistance-micro-ohms",
 			     &info->factory_internal_resistance_uohm);
+	of_property_read_u32(battery_np, "temperature-ambient-min-alert-celsius",
+			     &info->temp_ambient_alert_min);
+	of_property_read_u32(battery_np, "temperature-ambient-max-alert-celsius",
+			     &info->temp_ambient_alert_max);
+	of_property_read_u32(battery_np, "temperature-min-alert-celsius",
+			     &info->temp_alert_min);
+	of_property_read_u32(battery_np, "temperature-max-alert-celsius",
+			     &info->temp_alert_max);
+	of_property_read_u32(battery_np, "temperature-min-celsius",
+			     &info->temp_min);
+	of_property_read_u32(battery_np, "temperature-max-celsius",
+			     &info->temp_max);
 
 	len = of_property_count_u32_elems(battery_np, "ocv-capacity-celsius");
 	if (len < 0 && len != -EINVAL) {
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index ac1345a48ad0..31fcadd81d63 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -361,6 +361,12 @@ struct power_supply_battery_info {
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
2.26.0

