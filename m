Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FE721508B
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jul 2020 02:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgGFAai (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jul 2020 20:30:38 -0400
Received: from gateway36.websitewelcome.com ([192.185.201.2]:30782 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728141AbgGFAai (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jul 2020 20:30:38 -0400
X-Greylist: delayed 1228 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Jul 2020 20:30:37 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id E8A11402BA9C7
        for <linux-pm@vger.kernel.org>; Sun,  5 Jul 2020 18:32:13 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id sEhzjLEGuSxZVsEhzjJGX6; Sun, 05 Jul 2020 19:10:07 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tFT+lYrClbv1RBpt99UCi3E8tbXznUEvjiYn8KUfP58=; b=wxw3C083q8ACLRXCqboryrRsGc
        AEGoxOm5j7bBK1LOgz3g56ksyQp7sUzNBgA+moz51VRVKNOW1Tr6TzSxV9ZfFt9OE1GMnlmgpoEoE
        vP0zbdh8UzJeImr3SNlAO5ETGYq7gAHDF+v+gvA4aKVcfy+DFSOqoVe9nbLJH1i0T7Ws21hqPg6Je
        PLnIcEfwSjys2eu70fl9WD+LQ1JkrzF1IxueldUAYfhkGb/n06RAqJQSzJIRx/i+gNlIOudD5ma9g
        EU8tsbhyf5gGsZ6F+rvzNPwt43jdlLSdauDZqMqkLRaNazW/WY1MLCpfFVI6YlVs1wTAXjjJ0zMbM
        76c+luPg==;
Received: from [189.59.31.158] (port=43104 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1jsEhz-000qqT-Dd; Sun, 05 Jul 2020 21:10:07 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v1] power: supply: max17040: Add POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN
Date:   Sun,  5 Jul 2020 21:10:03 -0300
Message-Id: <20200706001003.663763-1-matheus@castello.eng.br>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 189.59.31.158
X-Source-L: No
X-Exim-ID: 1jsEhz-000qqT-Dd
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [189.59.31.158]:43104
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 1
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adds the property POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN to export the
chip->low_soc_alert and add the property as writeable, implementing
max17040_prop_writeable and max17040_set_property, so with that the
user space can readjust the alerts.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/power/supply/max17040_battery.c | 51 ++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 48aa44665e2f..6cb31b9a958d 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -69,6 +69,9 @@ static int max17040_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CAPACITY:
 		val->intval = chip->soc;
 		break;
+	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
+		val->intval = chip->low_soc_alert;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -256,19 +259,57 @@ static int max17040_enable_alert_irq(struct max17040_chip *chip)
 	return ret;
 }

+static int max17040_prop_writeable(struct power_supply *psy,
+				   enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static int max17040_set_property(struct power_supply *psy,
+			    enum power_supply_property psp,
+			    const union power_supply_propval *val)
+{
+	struct max17040_chip *chip = power_supply_get_drvdata(psy);
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
+		/* alert threshold can be programmed from 1% up to 32% */
+		if ((val->intval < 1) || (val->intval > 32)) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = max17040_set_low_soc_alert(chip->client, val->intval);
+		chip->low_soc_alert = val->intval;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static enum power_supply_property max17040_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN,
 };

 static const struct power_supply_desc max17040_battery_desc = {
-	.name		= "battery",
-	.type		= POWER_SUPPLY_TYPE_BATTERY,
-	.get_property	= max17040_get_property,
-	.properties	= max17040_battery_props,
-	.num_properties	= ARRAY_SIZE(max17040_battery_props),
+	.name			= "battery",
+	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.get_property		= max17040_get_property,
+	.set_property		= max17040_set_property,
+	.property_is_writeable  = max17040_prop_writeable,
+	.properties		= max17040_battery_props,
+	.num_properties		= ARRAY_SIZE(max17040_battery_props),
 };

 static int max17040_probe(struct i2c_client *client,
--
2.27.0

