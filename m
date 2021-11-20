Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0C7457F26
	for <lists+linux-pm@lfdr.de>; Sat, 20 Nov 2021 16:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhKTP7F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Nov 2021 10:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237614AbhKTP7E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Nov 2021 10:59:04 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEA0C061574
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:56:01 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id f18so58186758lfv.6
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yz20Oc2L50SJxsk74pwz6TMRhUegAZOxkOBwhSag3JQ=;
        b=f8Ai1HTijH6hbRf43wv10gMO+68FA8A75v8+utcjnCQTI5sIEwHAzDLAUDsingF3AU
         b3+n3nujgKm4znMsKguHWNc1oX6eRZHY98yXdwc2ld8ifdcZxb2RNH+BFsgJ9EY+PvSA
         SuM4BLazEakkPovcEOXw6nr6W6WFhajP7sd+W4PNVBx/nHRZi936Xh3yS+16BoxvD0dr
         P8YepUzKky4tAKe2yetCF5XY7I7Ksg5C6y0oeaKrto4b9sisM5/UreH09x3jW7V2vObs
         1qYH92nU0Y+oY98Hs0vknNF4cN/P9jMJz3Xl4uThm1QgVyJS1Cb5nCcvjtV+UwWHlZIu
         gbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yz20Oc2L50SJxsk74pwz6TMRhUegAZOxkOBwhSag3JQ=;
        b=xGGBGTY5yfTmxDR9YQu/GSoSgGsxn6XpbwlDsTXHIMxs8AtI0wguRKSduB8sIvDlb7
         B99sI8jlBPRGZfRSzxqHurc50RQWi6EZRUbKbwNZ9R8NOhaJNmC3CEqmzBvhLVmc/syt
         G/s+RnT16JRBSg1qL2xmzU0DSbCQOGQcpSfeCqHflNrNw9vsTuP/bwWaedNoy3aHrB+E
         SWNGkaE5577O4x5bAZWeLI+Ib4X8UvGsDI1gVBhxRTUjLm6tfWQ1qtzSizAZWhsl6JPz
         s0HlkD9XfBhcBxaQSlFp7GXruYCk3gQAqs8w8vA99nd59tlq8sm2R6/XyG6peadNPuT8
         RVSw==
X-Gm-Message-State: AOAM531zjV86iKVbxBL5Z6I3hvwX9SsLVJEpk/f5d+XYw6UFQZzZholF
        GxQe763VMtpJcr8RBG4oXe6Baw==
X-Google-Smtp-Source: ABdhPJzqbSm8c4HzwhJOOlSF2ZmNq8ftW9+eL524EIcwcI6203HXNi/wl46Ov6P5fHmqUhmqQMM7bw==
X-Received: by 2002:a05:6512:10c5:: with SMTP id k5mr43200518lfg.34.1637423759535;
        Sat, 20 Nov 2021 07:55:59 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t12sm280922ljg.63.2021.11.20.07.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 07:55:58 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 10/16] power: supply: ab8500: Standardize internal resistance
Date:   Sat, 20 Nov 2021 16:53:20 +0100
Message-Id: <20211120155326.2891664-11-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211120155326.2891664-1-linus.walleij@linaro.org>
References: <20211120155326.2891664-1-linus.walleij@linaro.org>
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
ChangeLog v1->v2:
- Rebase on the other patches
---
 drivers/power/supply/ab8500-bm.h     | 2 --
 drivers/power/supply/ab8500_bmdata.c | 4 +++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index b21d3a99471f..7e00f480756b 100644
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
index 684cefccebd1..981003105af6 100644
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

