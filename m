Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72D95F8DB0
	for <lists+linux-pm@lfdr.de>; Sun,  9 Oct 2022 21:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiJITSz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 9 Oct 2022 15:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJITSw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Oct 2022 15:18:52 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B9D23388
        for <linux-pm@vger.kernel.org>; Sun,  9 Oct 2022 12:18:50 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D953384D7A;
        Sun,  9 Oct 2022 21:18:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665343127;
        bh=18wNtkoEPHEZXSeMPxyUmW8gYwdNnViL95mGEje+OQo=;
        h=From:To:Cc:Subject:Date:From;
        b=gtMFw5R5KL7EB47kFCyTfRIH0mq6c3I8C/H7nAJwfdMcwA7OHjN/dV1oLNNuVkbDc
         ixiL0TBC4uV6nbWrImV3Ru/3+l6+I6A/PPTzeeRgP6vR9DyBu/hD3bEd4csaXWiAo6
         D+QKDbdP8l68rWPiQ1wbWB1475THeEyDB1Xm/5LPMiX3oBWcGiOTRUIDdw7K8ZW4mk
         6JE6kFyR9w6n+QxHghabiBbb+iv7IdzZ3f5fm8UgAPklEgx+AD2o5fY102AVdcFuq3
         dMgZqNEhDlIihjnAQo83YLaULI5HlD0Oh7jbVc/poBhGlrLOIp82EgiaQZYgZw/DDS
         2BfhEaeageP1Q==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 1/2] power: supply: bq25890: Add CC voltage to ADC properties
Date:   Sun,  9 Oct 2022 21:18:38 +0200
Message-Id: <20221009191839.102686-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE , representing register
REG0E field BATV is an ADC conversion of Battery Voltage (VBAT). Mark
the property as ADC one.

Fixes: 21d90eda433f ("power: bq25890: fix ADC mode configuration")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org
---
 drivers/power/supply/bq25890_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 6020b58c641d2..34dbd498f0f51 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -432,6 +432,7 @@ static bool bq25890_is_adc_property(enum power_supply_property psp)
 {
 	switch (psp) {
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 	case POWER_SUPPLY_PROP_TEMP:
 		return true;
-- 
2.35.1

