Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BD1250C45
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 01:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgHXXWs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 19:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXXWr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 19:22:47 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A926C061574;
        Mon, 24 Aug 2020 16:22:47 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v9so11650542ljk.6;
        Mon, 24 Aug 2020 16:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tJC/UBgyWpfgi2eM97bxX8k1Z19oULrPgPyyWbwUwmw=;
        b=dwHmQnD2RQ9x9a0EgnJ6wBZSSpi2fEDGnepPRGx2uPWjCqllwwmP9vDI6bm5i8Z4Om
         aX5ElKLCKGiXpTMd5biNiwAcICYUBfFGvWiI+NwJBeyQkyuGo6OnF/DeS7H9eeA7AzhU
         MvnQcWu83AZvE8pvHxlUuCo6XKw8OzMerYecmwPRIT5D9n2zZu57hPspuwTacUNPXPCK
         kqkYGXak3+jEZuA8EeSgTdxiUSskqWBEXSfqL+X45uq/Iib4XyuNe5LgEJZJDonjtOk5
         dQL/P7g52jafoj3ugJ1laDxFkNxfJroxoG7IIj15hMxMgxJhEKyPHhYsOUq4HRYfCVPr
         HMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tJC/UBgyWpfgi2eM97bxX8k1Z19oULrPgPyyWbwUwmw=;
        b=q6xa3Zn68GK6dDI95/+g93AFVwz1Qj/SMBRwtcUXrBZeQjKHs5XaMfj94HOhGsR+Ao
         A07+n+FSFS50PvlQ7yPwFWe/95ZHhYE55OfrEUNzaoXm96Gj2j36M+Ad3fJWTW3LcGOo
         xwJqe0u+gBYsg5IK9+fJXglj3iUY0PcbbkEz2sNjbBksdOuxJtWt0o9aTuql3EXwdJTs
         Ocr6ZZ6Hwi2FIZB6rEVk7Bbzo7CggJ0Vcj08JC7KhVAFgkG0NVVFeOwhDckrytHLMkmp
         F8AN1LpfptXJq3ezoLoAy0ijgVfr8PKdseKYKzboQDhKW6Bk5pwAxuhnQqV0R0T+v1Ib
         buPQ==
X-Gm-Message-State: AOAM531P6/WVjVN8zB9wcc9EFpUOSdgxvKQvsWvQ7entrqzku2UCxZXu
        7126HibFHWIlJOHNxe7+DqyQ+toOOo+sOQ==
X-Google-Smtp-Source: ABdhPJwBfzQamH/59LWQDRfJZrX8tHgPvlC6jdfu4OpMpb0Gha5XCBFcvaV6Hklo2fImc9985Vuyaw==
X-Received: by 2002:a2e:918a:: with SMTP id f10mr3749128ljg.78.1598311365605;
        Mon, 24 Aug 2020 16:22:45 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id o16sm2454414ljc.66.2020.08.24.16.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 16:22:44 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] power: supply: bq2515x: Constify static variables
Date:   Tue, 25 Aug 2020 01:22:28 +0200
Message-Id: <20200824232228.38423-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Constify a number of static variables that are not modified to allow the
compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/power/supply/bq2515x_charger.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq2515x_charger.c b/drivers/power/supply/bq2515x_charger.c
index 36b0c8c98d40..9dcb61ea4cf2 100644
--- a/drivers/power/supply/bq2515x_charger.c
+++ b/drivers/power/supply/bq2515x_charger.c
@@ -188,7 +188,7 @@ struct bq2515x_device {
 	struct bq2515x_init_data init_data;
 };
 
-static struct reg_default bq25150_reg_defaults[] = {
+static const struct reg_default bq25150_reg_defaults[] = {
 	{BQ2515X_FLAG0, 0x0},
 	{BQ2515X_FLAG1, 0x0},
 	{BQ2515X_FLAG2, 0x0},
@@ -227,7 +227,7 @@ static struct reg_default bq25150_reg_defaults[] = {
 	{BQ2515X_DEVICE_ID, 0x20},
 };
 
-static struct reg_default bq25155_reg_defaults[] = {
+static const struct reg_default bq25155_reg_defaults[] = {
 	{BQ2515X_FLAG0, 0x0},
 	{BQ2515X_FLAG1, 0x0},
 	{BQ2515X_FLAG2, 0x0},
@@ -886,14 +886,14 @@ static int bq2515x_battery_get_property(struct power_supply *psy,
 	return 0;
 }
 
-static enum power_supply_property bq2515x_battery_properties[] = {
+static const enum power_supply_property bq2515x_battery_properties[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 };
 
-static enum power_supply_property bq2515x_mains_properties[] = {
+static const enum power_supply_property bq2515x_mains_properties[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_HEALTH,
@@ -905,7 +905,7 @@ static enum power_supply_property bq2515x_mains_properties[] = {
 	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 };
 
-static struct power_supply_desc bq2515x_mains_desc = {
+static const struct power_supply_desc bq2515x_mains_desc = {
 	.name			= "bq2515x-mains",
 	.type			= POWER_SUPPLY_TYPE_MAINS,
 	.get_property		= bq2515x_mains_get_property,
@@ -915,7 +915,7 @@ static struct power_supply_desc bq2515x_mains_desc = {
 	.property_is_writeable	= bq2515x_power_supply_property_is_writeable,
 };
 
-static struct power_supply_desc bq2515x_battery_desc = {
+static const struct power_supply_desc bq2515x_battery_desc = {
 	.name			= "bq2515x-battery",
 	.type			= POWER_SUPPLY_TYPE_BATTERY,
 	.get_property		= bq2515x_battery_get_property,
-- 
2.28.0

