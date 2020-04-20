Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AA61B0047
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 05:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgDTDmi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Apr 2020 23:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgDTDmi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 23:42:38 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25606C061A0C;
        Sun, 19 Apr 2020 20:42:38 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d24so3444722pll.8;
        Sun, 19 Apr 2020 20:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=JPkmqM71b4rRcya2ozpKiJUdZzbf1Gon6Qti46oIwaA=;
        b=Bk6/BCTVD1ZAHzejtmXrV3+jLdv6LQkBP0LYPnF4Ucp/a3qndVwhWy1ZtQeE0MS/qw
         weUC89nR/sjUffGzE2w9oQOgdca+na1G0unMsg/EatfVOT8vTf2UHF7Urtr1jJyxTSvB
         TSWWnpjvrmfGxJ/oxz3gipUNLFIV/jRJ6LksBykOdGAFp7wv0amXK4b/tr7yRFVwS93m
         ShRAirVTdO6NVHnwGsqPRZJBDOgn4fKQmzA0yChLEFJkb1wJWPJQJiA7Bx1Cg0ZnrV2N
         o/qQjVuFUR2lK9v69ccI2HoTenb6vOaXc1BIytS+BIdECiHAiNoc/7kfyPUA1bxqFnyA
         tlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=JPkmqM71b4rRcya2ozpKiJUdZzbf1Gon6Qti46oIwaA=;
        b=cPjAWV9b2HvdnypNQIJr/nU4T51SC+w/yOfvhClj7POUjbNwsO5sL3ZEmnXtdHKE56
         i1x9OJDQc7T/I11J8PK8jp8BkU1lucxpf0WTd9/m4v5d5RJFfqYUqWrw1VJoM3W16mh6
         4Ow9atCf+uB4E4bkEXQAW4YjhUKnMz8EHdTsuMjdAIvwuG2C3vbJX3XhPYlTEjGru+zW
         zrDWyk9J//mAtqhFtRN5GbGeKkTiexvbkIzLZcYqAuGWn22Oli2/A2eSjRN2Lz7fNzhW
         Jke3pMDRO80W41luCFtXBE53YqdajPOMM3HDTZJ/vmNPWCjQtQ7Co2ozxqzFMKxiBbOR
         BeKQ==
X-Gm-Message-State: AGi0Pubk6FhE87WLQoZnWMTSTprz9tpX5PsM3lwIZgXqmClZ5E24CsRE
        pa1gvU58YqP4NPczyZVTGak=
X-Google-Smtp-Source: APiQypI33jIQSddwQUXo9j6helHzRk1c5D1UbVoCy7dqJrqCVAYsxAnBOMj17HR/KQXa1HNADfhY2w==
X-Received: by 2002:a17:902:690b:: with SMTP id j11mr15468699plk.145.1587354157716;
        Sun, 19 Apr 2020 20:42:37 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id d21sm12467660pjs.3.2020.04.19.20.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 20:42:37 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     sre@kernel.org
Cc:     baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        yuanjiang.yu@unisoc.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] power: supply: sc27xx: Add CURRENT_NOW/VOLTAGE_NOW properties support
Date:   Mon, 20 Apr 2020 11:42:06 +0800
Message-Id: <0e3fe8941e93d520fafa69282bd0d717d203d541.1587353854.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587353854.git.baolin.wang7@gmail.com>
References: <cover.1587353854.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1587353854.git.baolin.wang7@gmail.com>
References: <cover.1587353854.git.baolin.wang7@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

Add new properties to get present current and voltage of the fuel gauge.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/power/supply/sc27xx_fuel_gauge.c | 60 +++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 5970d4a78016..82d0c64ef269 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -42,6 +42,8 @@
 #define SC27XX_FGU_USER_AREA_SET	0xa0
 #define SC27XX_FGU_USER_AREA_CLEAR	0xa4
 #define SC27XX_FGU_USER_AREA_STATUS	0xa8
+#define SC27XX_FGU_VOLTAGE_BUF		0xd0
+#define SC27XX_FGU_CURRENT_BUF		0xf0
 
 #define SC27XX_WRITE_SELCLB_EN		BIT(0)
 #define SC27XX_FGU_CLBCNT_MASK		GENMASK(15, 0)
@@ -376,6 +378,44 @@ static int sc27xx_fgu_get_clbcnt(struct sc27xx_fgu_data *data, int *clb_cnt)
 	return 0;
 }
 
+static int sc27xx_fgu_get_vol_now(struct sc27xx_fgu_data *data, int *val)
+{
+	int ret;
+	u32 vol;
+
+	ret = regmap_read(data->regmap, data->base + SC27XX_FGU_VOLTAGE_BUF,
+			  &vol);
+	if (ret)
+		return ret;
+
+	/*
+	 * It is ADC values reading from registers which need to convert to
+	 * corresponding voltage values.
+	 */
+	*val = sc27xx_fgu_adc_to_voltage(data, vol);
+
+	return 0;
+}
+
+static int sc27xx_fgu_get_cur_now(struct sc27xx_fgu_data *data, int *val)
+{
+	int ret;
+	u32 cur;
+
+	ret = regmap_read(data->regmap, data->base + SC27XX_FGU_CURRENT_BUF,
+			  &cur);
+	if (ret)
+		return ret;
+
+	/*
+	 * It is ADC values reading from registers which need to convert to
+	 * corresponding current values.
+	 */
+	*val = sc27xx_fgu_adc_to_current(data, cur - SC27XX_FGU_CUR_BASIC_ADC);
+
+	return 0;
+}
+
 static int sc27xx_fgu_get_capacity(struct sc27xx_fgu_data *data, int *cap)
 {
 	int ret, cur_clbcnt, delta_clbcnt, delta_cap, temp;
@@ -577,7 +617,7 @@ static int sc27xx_fgu_get_property(struct power_supply *psy,
 		val->intval = value;
 		break;
 
-	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
 		ret = sc27xx_fgu_get_vbat_vol(data, &value);
 		if (ret)
 			goto error;
@@ -601,7 +641,6 @@ static int sc27xx_fgu_get_property(struct power_supply *psy,
 		val->intval = value;
 		break;
 
-	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_CURRENT_AVG:
 		ret = sc27xx_fgu_get_current(data, &value);
 		if (ret)
@@ -625,6 +664,22 @@ static int sc27xx_fgu_get_property(struct power_supply *psy,
 
 		break;
 
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = sc27xx_fgu_get_vol_now(data, &value);
+		if (ret)
+			goto error;
+
+		val->intval = value * 1000;
+		break;
+
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = sc27xx_fgu_get_cur_now(data, &value);
+		if (ret)
+			goto error;
+
+		val->intval = value * 1000;
+		break;
+
 	default:
 		ret = -EINVAL;
 		break;
@@ -694,6 +749,7 @@ static enum power_supply_property sc27xx_fgu_props[] = {
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_VOLTAGE_OCV,
+	POWER_SUPPLY_PROP_VOLTAGE_AVG,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
-- 
2.17.1

