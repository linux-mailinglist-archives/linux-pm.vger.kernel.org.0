Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 351657BDF0
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 12:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbfGaKBK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 06:01:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40416 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387724AbfGaKBG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 06:01:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so30212374pla.7
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 03:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=XF5mZ6TSVo4eSNdQwLP31itinD3L/9CCtkqFjn0djlU=;
        b=UHCfglolFc+DiKNqu28PP7eW3FZEIuVvD/ZAL0ARBydSmw5J1AvOi7RqECGvzy6OyG
         JjznumgXnMlrgA+kEdFEsntSef0+YnGvMTLpX+q4IecNPm57QuzzIsAAWnE3sBhklwoQ
         aYzQ3bw8+p+ZPNrOrSDamq+nkI+kJfTvuVAL4kdLH6lmo3FnsURjQaFVeGvWtuV/dx7M
         Oesx0zR11jotI5yl8mxyz374bO4ddYQKkHky0Sx447WMBTRl/sKaHqp16dEOPi1Tzgev
         2vBnBHlc0ZsG6mTdF49WwAunGzn3pS9UeqSoQFADQK3GU6s/SIfyzE1ni8WGsDTjD2ek
         FFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=XF5mZ6TSVo4eSNdQwLP31itinD3L/9CCtkqFjn0djlU=;
        b=T4LjJ+gasMVF1GF4oNvpV3q/M7jQzaeTmi+j7pNtCi4QObLhfxz8+bvnL/CcBGHYUf
         rzP3AM8sJH0XVKT/HaUYimknanjyoQiR7DcRzkK+VdcryDGg4GK+0e7wX6+PftEMGzwD
         8ZFb1p9UCT2yqvDq/8vqwZDrXH4BjKHsfOSS5jo03acjCB+qTjpqIecX5dxexpaiBi8o
         L+a4RLSOeg4r+U7torUBh/ItsTRkGuTW22pE9+gHtHnf0w1skt3LD23DPdgVpRGHwpRK
         a4VBaTGezzi0lS7CN+Asd/56PXCMopGUaZs7k6vi3Hg5+DEOCdvDzUZB2N0go/jGRCvj
         SVwA==
X-Gm-Message-State: APjAAAWMg/sjjUpG2Ziqb3eMPNLu7CrD8yDUzq1aaVpq1AEAO+nzrPfv
        QJSUHVrcss3W4kjDHusQL62BPg==
X-Google-Smtp-Source: APXvYqwNQvRYJbmUxrXwPc+d2Y+WlvIn2qkESp52+VZCGPtoCkNpZLLC2P1EOSKz+HvgKnVzuGG4XA==
X-Received: by 2002:a17:902:a514:: with SMTP id s20mr113281631plq.162.1564567265611;
        Wed, 31 Jul 2019 03:01:05 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m6sm68611352pfb.151.2019.07.31.03.01.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 03:01:05 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] power: supply: sc27xx: Add POWER_SUPPLY_PROP_CALIBRATE attribute
Date:   Wed, 31 Jul 2019 18:00:28 +0800
Message-Id: <554dd7e2ef4f3c5247322d8b185607748144b1e6.1564566425.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1564566425.git.baolin.wang@linaro.org>
References: <cover.1564566425.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1564566425.git.baolin.wang@linaro.org>
References: <cover.1564566425.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

Add the 'POWER_SUPPLY_PROP_CALIBRATE' attribute to allow chareger manager
to calibrate the battery capacity.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c |   27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index fa85f40..6363c48 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -111,6 +111,7 @@ struct sc27xx_fgu_data {
 static int sc27xx_fgu_cap_to_clbcnt(struct sc27xx_fgu_data *data, int capacity);
 static void sc27xx_fgu_capacity_calibration(struct sc27xx_fgu_data *data,
 					    int cap, int int_mode);
+static void sc27xx_fgu_adjust_cap(struct sc27xx_fgu_data *data, int cap);
 
 static const char * const sc27xx_charger_supply_name[] = {
 	"sc2731_charger",
@@ -610,17 +611,25 @@ static int sc27xx_fgu_set_property(struct power_supply *psy,
 	struct sc27xx_fgu_data *data = power_supply_get_drvdata(psy);
 	int ret;
 
-	if (psp != POWER_SUPPLY_PROP_CAPACITY)
-		return -EINVAL;
-
 	mutex_lock(&data->lock);
 
-	ret = sc27xx_fgu_save_last_cap(data, val->intval);
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CAPACITY:
+		ret = sc27xx_fgu_save_last_cap(data, val->intval);
+		if (ret < 0)
+			dev_err(data->dev, "failed to save battery capacity\n");
+		break;
 
-	mutex_unlock(&data->lock);
+	case POWER_SUPPLY_PROP_CALIBRATE:
+		sc27xx_fgu_adjust_cap(data, val->intval);
+		ret = 0;
+		break;
 
-	if (ret < 0)
-		dev_err(data->dev, "failed to save battery capacity\n");
+	default:
+		ret = -EINVAL;
+	}
+
+	mutex_unlock(&data->lock);
 
 	return ret;
 }
@@ -635,7 +644,8 @@ static void sc27xx_fgu_external_power_changed(struct power_supply *psy)
 static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
 					    enum power_supply_property psp)
 {
-	return psp == POWER_SUPPLY_PROP_CAPACITY;
+	return psp == POWER_SUPPLY_PROP_CAPACITY ||
+		psp == POWER_SUPPLY_PROP_CALIBRATE;
 }
 
 static enum power_supply_property sc27xx_fgu_props[] = {
@@ -651,6 +661,7 @@ static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CALIBRATE,
 };
 
 static const struct power_supply_desc sc27xx_fgu_desc = {
-- 
1.7.9.5

