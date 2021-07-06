Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76B13BDE2C
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 21:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhGFTsl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 15:48:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59363 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229811AbhGFTsk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jul 2021 15:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625600761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0lzOK3mNHZjRxYRggPARjfbhZ+54iSiODJM7MfNEdlE=;
        b=RsAAOgyzXblO1tOWCG1bs/fpABR/RQ4h7qC54t1SVKXXWtfAKK0vu46wh0dEC8Q6mmRohK
        AgdQ8AtDGJUDt1sljtjl14lktnWGVd5fj5kfUsWFJUmaiMS0led5ZX76KAnPEyeGmsU8mW
        KmaJmd+iP6Cl78X0ORFR0wNCdQAxVNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-DlAxHlpPN-2ksNdoQhAVUA-1; Tue, 06 Jul 2021 15:45:58 -0400
X-MC-Unique: DlAxHlpPN-2ksNdoQhAVUA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0855218414AD;
        Tue,  6 Jul 2021 19:45:57 +0000 (UTC)
Received: from localhost (ovpn-113-53.rdu2.redhat.com [10.10.113.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 459CC60854;
        Tue,  6 Jul 2021 19:45:53 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 2/2] power: supply: bq24735: add watchdog timer delay support
Date:   Tue,  6 Jul 2021 16:45:38 -0300
Message-Id: <20210706194538.368792-3-bmeneg@redhat.com>
In-Reply-To: <20210706194538.368792-1-bmeneg@redhat.com>
References: <20210706194538.368792-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 .../bindings/power/supply/bq24735.yaml        | 13 +++++
 drivers/power/supply/bq24735-charger.c        | 48 +++++++++++++++++++
 include/linux/power/bq24735-charger.h         |  1 +
 3 files changed, 62 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq24735.yaml b/Documentation/devicetree/bindings/power/supply/bq24735.yaml
index 131be6782c4b..62399efab467 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24735.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq24735.yaml
@@ -56,6 +56,19 @@ properties:
       The POR value is 0x1000h. This number is in mA (e.g. 8064).
       See the spec for more information about the InputCurrent (0x3fh) register.
 
+  ti,wdt-timeout:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Used to control and set the charger watchdog delay between consecutive
+      charge voltage and charge current commands.
+      This value must be:
+        0 - disabled
+        1 - 44 seconds
+        2 - 88 seconds
+        3 - 175 seconds
+      The POR value is 0x11 (3).
+      See the spec for more information about the ChargeOptions(0x12h) register.
+
   ti,external-control:
     type: boolean
     description: |
diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index 3ce36d09c017..88f1cb1e9fee 100644
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
 
+	if (pdata->wdt_timeout) {
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
 
@@ -347,6 +363,17 @@ static struct bq24735_platform *bq24735_parse_dt_data(struct i2c_client *client)
 	if (!ret)
 		pdata->input_current = val;
 
+	ret = of_property_read_u32(np, "ti,wdt-timeout", &val);
+	if (!ret) {
+		if (val <= 3) {
+			pdata->wdt_timeout = val;
+		} else {
+			dev_warn(&client->dev,
+				 "Invalid value for ti,wdt-timeout: %d",
+				 val);
+		}
+	}
+
 	pdata->ext_control = of_property_read_bool(np, "ti,external-control");
 
 	return pdata;
@@ -476,6 +503,27 @@ static int bq24735_charger_probe(struct i2c_client *client,
 			return 0;
 		if (!charger->poll_interval)
 			return 0;
+		if (charger->pdata->wdt_timeout) {
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
index 321dd009ce66..ecf4ab6bfbd7 100644
--- a/include/linux/power/bq24735-charger.h
+++ b/include/linux/power/bq24735-charger.h
@@ -12,6 +12,7 @@ struct bq24735_platform {
 	uint32_t charge_current;
 	uint32_t charge_voltage;
 	uint32_t input_current;
+	uint8_t wdt_timeout;
 
 	const char *name;
 
-- 
2.31.1

