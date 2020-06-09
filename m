Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7771F4703
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 21:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbgFITWv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 15:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgFITWu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 15:22:50 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265AEC03E97C
        for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2020 12:22:50 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y18so8421334plr.4
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2020 12:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+UJnkDxVkadhbJZh7bYn2L5UqyxoXGSxqxY/M/szSR4=;
        b=BrU/V7wm9SzSTlMa8d22kFnOE4mN00rol//Jjz+04Hn6J1erJsseYX8zVrPSDUiylf
         GCiRfTPX3BJzekyQUwvZG0UkyfGeJKUXqpeqCIPoehqbw3R5pqXRqXmpwlyZwepS/TGr
         YAH9JlZLOfppxeutohPijYHDPE5e6jQ6REAiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+UJnkDxVkadhbJZh7bYn2L5UqyxoXGSxqxY/M/szSR4=;
        b=KOKl1hAlSVIArqKILWalWuH54GycY6gW5YAgMtRnlJkl33vXHj03MAIUKYB+dhqrh9
         fme/zKuLK4KLTTRW2n+CKIdOQzUKBnAGt4i0XE9Igb1aUqs7nc+pWH8nJ6FMMmTSbvyu
         K+Qt24CoE/28R7KRUOG6KCsFblF4fGOw80LAEL+Y8VektU2NR3DKF6KZZeBS90oNZGA9
         STxYwTarN1j/hmh9AMtP7Fts8hJQZQ6i4ruj4QMpEpnR1xvkYl2lb4DwYJXga56vpO+A
         J8XIvTf+ja6GB8X3gJ/Vms73pB8rzGc7UBs1wd5xH0koSIE7fM2IAdD2Qef7VqZzhxvE
         7+PQ==
X-Gm-Message-State: AOAM532wRREbsMwHoHHmi4+AxsJyitIRT4vqajhrG/nUk+WMK2GkmBGz
        yYmQHmrCbRwAcRHjt6BXbT+qRA==
X-Google-Smtp-Source: ABdhPJw5bzT4J550aXlAie2EH+LaVisk2G8Dq9u2jRv5dhmd33lWlXPfhVg3c11tavyjDtI3hU2d3Q==
X-Received: by 2002:a17:902:a513:: with SMTP id s19mr4474055plq.140.1591730569654;
        Tue, 09 Jun 2020 12:22:49 -0700 (PDT)
Received: from twawrzynczak.bld.corp.google.com ([161.97.245.194])
        by smtp.gmail.com with ESMTPSA id p12sm10883174pfq.69.2020.06.09.12.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 12:22:49 -0700 (PDT)
From:   Tim Wawrzynczak <twawrzynczak@chromium.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Subject: [PATCH 2/2] power: supply: sbs_battery: Support Manufacture Date field
Date:   Tue,  9 Jun 2020 13:22:37 -0600
Message-Id: <20200609192237.32571-2-twawrzynczak@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200609192237.32571-1-twawrzynczak@chromium.org>
References: <20200609192237.32571-1-twawrzynczak@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds support for the sbs-battery driver to export a battery's
manufacture date as a field in sysfs. It is exported as a simple Y/M/D
format for ease of consumption.

Signed-off-by: Tim Wawrzynczak <twawrzynczak@chromium.org>
Change-Id: Ia952624f33700587f4d71ad09ad68c0940c7f508
---
 drivers/power/supply/sbs-battery.c | 31 +++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index f8d74e9f79317..989625be80743 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -42,6 +42,7 @@ enum {
 	REG_DESIGN_VOLTAGE_MAX,
 	REG_MANUFACTURER,
 	REG_MODEL_NAME,
+	REG_MANUFACTURE_DATE,
 };
 
 /* Battery Mode defines */
@@ -112,6 +113,10 @@ static const struct chip_data {
 		SBS_DATA(POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN, 0x19, 0, 65535),
 	[REG_DESIGN_VOLTAGE_MAX] =
 		SBS_DATA(POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN, 0x19, 0, 65535),
+	/* Manufacture Date is encoded as a 16-bit register, but is exported
+	 * from here as a string */
+	[REG_MANUFACTURE_DATE] =
+		SBS_DATA(POWER_SUPPLY_PROP_MANUFACTURE_DATE, 0x1B, 0, 65535),
 	[REG_SERIAL_NUMBER] =
 		SBS_DATA(POWER_SUPPLY_PROP_SERIAL_NUMBER, 0x1C, 0, 65535),
 	/* Properties of type `const char *' */
@@ -145,7 +150,8 @@ static enum power_supply_property sbs_properties[] = {
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_PROP_MANUFACTURER,
-	POWER_SUPPLY_PROP_MODEL_NAME
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURE_DATE,
 };
 
 /* Supports special manufacturer commands from TI BQ20Z75 IC. */
@@ -170,6 +176,10 @@ static char model_name[I2C_SMBUS_BLOCK_MAX + 1];
 static char manufacturer[I2C_SMBUS_BLOCK_MAX + 1];
 static bool force_load;
 
+/* manufacture_date is returned as a 16-bit word in the smart battery itself.
+ * It is decoded here and displayed as "%4d/%2d/%2d", Y/m/d format. */
+static char manufacture_date[11];
+
 static int sbs_read_word_data(struct i2c_client *client, u8 address)
 {
 	struct sbs_info *chip = i2c_get_clientdata(client);
@@ -682,6 +692,25 @@ static int sbs_get_property(struct power_supply *psy,
 		ret = sbs_get_battery_property(client, ret, psp, val);
 		break;
 
+	case POWER_SUPPLY_PROP_MANUFACTURE_DATE:
+		ret = sbs_get_property_index(client, psp);
+		if (ret < 0)
+			break;
+
+		ret = sbs_get_battery_property(client, ret, psp, val);
+
+		/* Convert encoded data (from the SBS 1.1 spec) into a string:
+		 * bits 9-15 are the year, encoded as years since 1980
+		 * bits 5-8 are the month, encoded as 1-12
+		 * bits 0-4 are the day of the month, encoded as 1-31 */
+		snprintf(manufacture_date, sizeof(manufacture_date),
+			 "%4d/%2d/%2d",
+			 ((val->intval >> 9) & 0x7f) + 1980,
+			 (val->intval >> 5) & 0xf,
+			 val->intval & 0x1f);
+		val->strval = manufacture_date;
+		break;
+
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		ret = sbs_get_property_index(client, psp);
 		if (ret < 0)
-- 
2.26.2

