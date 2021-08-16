Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E793EDBBE
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 18:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhHPQxZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 12:53:25 -0400
Received: from server34.i7host.com.br ([186.227.200.26]:47100 "EHLO
        server34.i7host.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhHPQxY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 12:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smartgreen.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OrBsyv6kacBNfisU0RQX4TMcMUGdXKLlH7ItSqKFb3M=; b=oAxqbvsdM+26G6Br4jVmkIdn78
        76UfNeUKnVZHzsca9sHf1j1d6TAj0m8HRwPe9LcD2ZqwSZQb6lWqJNm0s6YTnfdRv7QCrMohtjg0x
        jeD2SaPUaDy5oRMqA9lxOV2jCYhFF++TOx/RYU4mx6M+LuXlVykePWVX/rK5yyUreqMuM/d4A/i4I
        hnqdkCjYtEWLLrwOO8UqJzSL/7JEjvCzm0IBhiGNkTdqWGEMtKJUrkVkQcvwQZ+joABt61cdlAowy
        snBmbXLUO/h9f0eokyyXSZsu++bera5sjLAspXJsXsVAPvlhvxSG5Uea/2DF5D+Cj5QAEx9w6U+vM
        UBIme0WA==;
Received: from [177.220.172.187] (port=34271 helo=localhost)
        by server34.i7host.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <bruno.meneguele@smartgreen.net>)
        id 1mFfqz-00GtZz-IF; Mon, 16 Aug 2021 13:52:50 -0300
From:   Bruno Meneguele <bruno.meneguele@smartgreen.net>
To:     sre@kernel.org, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bruno Meneguele <bruno.meneguele@smartgreen.net>
Subject: [PATCH v4 1/2] power: supply: bq24735: add watchdog timer delay support
Date:   Mon, 16 Aug 2021 13:52:44 -0300
Message-Id: <20210816165245.40416-2-bruno.meneguele@smartgreen.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210816165245.40416-1-bruno.meneguele@smartgreen.net>
References: <20210816165245.40416-1-bruno.meneguele@smartgreen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server34.i7host.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - smartgreen.net
X-Get-Message-Sender-Via: server34.i7host.com.br: authenticated_id: bruno.meneguele@smartgreen.net
X-Authenticated-Sender: server34.i7host.com.br: bruno.meneguele@smartgreen.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The BQ24735 charger allows the user to set the watchdog timer delay between
two consecutives ChargeCurrent or ChargeVoltage command writes, if the IC
doesn't receive any command before the timeout happens, the charge is turned
off.

This patch adds the support to the user to change the default/POR value with
four discrete values:

  0 - disabled
  1 - enabled, 44 sec
  2 - enabled, 88 sec
  3 - enabled, 175 sec (default at POR)

These are the options supported in the ChargeOptions register bits 13&14.

Also, this patch make one additional check when poll-interval is set by the
user: if the interval set is greater than the WDT timeout it'll fail during
the probe stage, preventing the user to set non-compatible values between
the two options.

Signed-off-by: Bruno Meneguele <bruno.meneguele@smartgreen.net>
---
Changelog:
  v3 - check wdt_timeout for the maximum and minimum available values 

 drivers/power/supply/bq24735-charger.c | 54 ++++++++++++++++++++++++++
 include/linux/power/bq24735-charger.h  |  1 +
 2 files changed, 55 insertions(+)

diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index 3ce36d09c017..7e8d0c23df9a 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -45,6 +45,8 @@
 /* ChargeOptions bits of interest */
 #define BQ24735_CHARGE_OPT_CHG_DISABLE	(1 << 0)
 #define BQ24735_CHARGE_OPT_AC_PRESENT	(1 << 4)
+#define BQ24735_CHARGE_OPT_WDT_OFFSET	13
+#define BQ24735_CHARGE_OPT_WDT		(3 << BQ24735_CHARGE_OPT_WDT_OFFSET)
 
 struct bq24735 {
 	struct power_supply		*charger;
@@ -156,6 +158,20 @@ static int bq24735_config_charger(struct bq24735 *charger)
 		}
 	}
 
+	if (pdata->wdt_timeout >= 0 && pdata->wdt_timeout <= 3) {
+		value = pdata->wdt_timeout;
+
+		ret = bq24735_update_word(charger->client, BQ24735_CHARGE_OPT,
+					  BQ24735_CHARGE_OPT_WDT,
+					  (value << BQ24735_CHARGE_OPT_WDT_OFFSET));
+		if (ret < 0) {
+			dev_err(&charger->client->dev,
+				"Failed to write watchdog timer: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -347,6 +363,23 @@ static struct bq24735_platform *bq24735_parse_dt_data(struct i2c_client *client)
 	if (!ret)
 		pdata->input_current = val;
 
+	ret = of_property_read_u32(np, "ti,wdt-timeout", &val);
+	if (!ret) {
+		if (val >= 0 && val <= 3) {
+			pdata->wdt_timeout = val;
+		} else {
+			dev_warn(&client->dev,
+				 "Invalid value for ti,wdt-timeout: %d",
+				 val);
+		}
+	} else {
+		/* Since 0 is a valid value (disabled), set something
+		 * greater than the maximum limit accepted from the user to
+		 * represent the "no change" state. */
+		pdata->wdt_timeout = 4;
+	}
+
+
 	pdata->ext_control = of_property_read_bool(np, "ti,external-control");
 
 	return pdata;
@@ -476,6 +509,27 @@ static int bq24735_charger_probe(struct i2c_client *client,
 			return 0;
 		if (!charger->poll_interval)
 			return 0;
+		if (charger->pdata->wdt_timeout > 0) {
+			int wdt_ms;
+
+			switch (charger->pdata->wdt_timeout) {
+			case 1:
+				wdt_ms = 44000;
+				break;
+			case 2:
+				wdt_ms = 88000;
+				break;
+			case 3:
+				wdt_ms = 175000;
+				break;
+			}
+
+			if (charger->poll_interval > wdt_ms) {
+				dev_err(&client->dev,
+					"Poll interval greater than WDT timeout\n");
+				return -EINVAL;
+			}
+		}
 
 		ret = devm_delayed_work_autocancel(&client->dev, &charger->poll,
 						   bq24735_poll);
diff --git a/include/linux/power/bq24735-charger.h b/include/linux/power/bq24735-charger.h
index 321dd009ce66..ce5a030ca111 100644
--- a/include/linux/power/bq24735-charger.h
+++ b/include/linux/power/bq24735-charger.h
@@ -12,6 +12,7 @@ struct bq24735_platform {
 	uint32_t charge_current;
 	uint32_t charge_voltage;
 	uint32_t input_current;
+	uint32_t wdt_timeout;
 
 	const char *name;
 
-- 
2.31.1

