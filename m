Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54CC455298
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 03:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242496AbhKRCXX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 21:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242492AbhKRCXU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 21:23:20 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AD5C061764
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:20 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b40so18100539lfv.10
        for <linux-pm@vger.kernel.org>; Wed, 17 Nov 2021 18:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2SmpuYl2ABnUfey0UDONLQlUHk1m7GyEzeYLIiNTVc=;
        b=Ye8/5x3879+HgQH6LM5rL2wntnqZQYdiCesoY39KeRHqi5R9tF3sxjZqi4kYa4hB1A
         X/2dlNue3QATkm0myDYOqX6/MRzP6pFPMmqaRuFtGGpCSpJSuNuCO+wSm58g8lyHZInY
         YDbdIAIV8SkJ+ulJqjCNPqIGQw5FAdFdMrIHCR6hDSkR8IXXv0EzJOmQjpZzhkEn+gRf
         6XDjHIsfKzGRYYTqB4lrwYvLVVMuWMwff3jUOBOnrS1HkfNxNWnNilZD5gv3s23oZPQU
         ut08/tBX4BEu0cZSWX3xFzu6gcvv34RSf6fHWhDEcPnJG/B7opZ1e3K68rLp0gA+5jAP
         iYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2SmpuYl2ABnUfey0UDONLQlUHk1m7GyEzeYLIiNTVc=;
        b=f4SmZeqoWif5Qik2UqE7N8zOnV8f3BGO4I93NDcUIxxTL6UlSp9hARTbGVhYPuE/fk
         x29o2mv3IQvWFsj5/62qHXXvLmQuctnFnJMil1KZqK5Yz72Zgy34pBQWwLkAXwqoXwU/
         mNNsQrelKvoprR6uOv5viWDRxeUulshjCOvI2sm/+IxRLnWsMXxjEE24zMi4dYVZnNK2
         iYuT6bjD/x3fFaRofYBYcKGiUtNCzgSiBsdSXh8t1KnDYJwW3h+2SHhiBGbpSXYJZKM4
         AKXpD1fLwKOeaz1OEPDhr5EtilelFRq07NRL5dzMDzpJ7k7fzcYNlQ0FJH9I9EfbmBBl
         uE3w==
X-Gm-Message-State: AOAM532eYBCO5dt6oXsTZqto04LPzRvi1e8cm2kJYI5jHVy5EObrOWLl
        taF0W+1aqcwNu6ZgOhC+y3DjCATCAwYLgg==
X-Google-Smtp-Source: ABdhPJy0BtM9uM+piO8Hy74LjFy5Ass8s4CDaPpiCYp9v/cT29/7xzZCMuwnDqEyTI+9lskHIxrRZQ==
X-Received: by 2002:a2e:9b47:: with SMTP id o7mr8519729ljj.346.1637202019118;
        Wed, 17 Nov 2021 18:20:19 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id j19sm165321lfe.120.2021.11.17.18.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 18:20:18 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 10/16] power: supply: ab8500: Standardize internal resistance
Date:   Thu, 18 Nov 2021 03:17:46 +0100
Message-Id: <20211118021752.2262818-11-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118021752.2262818-1-linus.walleij@linaro.org>
References: <20211118021752.2262818-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The nominal internal resistance isn't used by the AB8500
charging code, instead this resistance is measured continuously,
but we anyways migrate this to the standard property in
struct power_supply_battery_info.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500-bm.h     | 2 --
 drivers/power/supply/ab8500_bmdata.c | 4 +++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 233fa86f9b2f..e6c5c9f5d4c5 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -388,7 +388,6 @@ struct ab8500_maxim_parameters {
  * @maint_b_chg_timer_h:	charge time in maintenance B state
  * @low_high_cur_lvl:		charger current in temp low/high state in mA
  * @low_high_vol_lvl:		charger voltage in temp low/high state in mV'
- * @battery_resistance:		battery inner resistance in mOhm.
  * @n_r_t_tbl_elements:		number of elements in r_to_t_tbl
  * @r_to_t_tbl:			table containing resistance to temp points
  * @n_v_cap_tbl_elements:	number of elements in v_to_cap_tbl
@@ -411,7 +410,6 @@ struct ab8500_battery_type {
 	int maint_b_chg_timer_h;
 	int low_high_cur_lvl;
 	int low_high_vol_lvl;
-	int battery_resistance;
 	int n_temp_tbl_elements;
 	const struct ab8500_res_to_temp *r_to_t_tbl;
 	int n_v_cap_tbl_elements;
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 17df619cdf36..2532499afe5f 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -83,7 +83,6 @@ static const struct batres_vs_temp temp_to_batres_tbl_thermistor[] = {
 static struct ab8500_battery_type bat_type_thermistor_unknown = {
 	.resis_high = 0,
 	.resis_low = 0,
-	.battery_resistance = 300,
 	.termination_curr = 200,
 	.recharge_cap = 95,
 	.normal_cur_lvl = 400,
@@ -204,6 +203,9 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 		bi->overvoltage_limit_uv = 4050000;
 	}
 
+	if (bi->factory_internal_resistance_uohm < 0)
+		bi->factory_internal_resistance_uohm = 300000;
+
 	if (bi->temp_min == INT_MIN)
 		bi->temp_min = AB8500_TEMP_UNDER;
 	if (bi->temp_max == INT_MAX)
-- 
2.31.1

