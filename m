Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305165FA6D1
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 23:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJJVDu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 17:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJJVDd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 17:03:33 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF44BFE6
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 14:03:30 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 680B784882;
        Mon, 10 Oct 2022 23:03:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665435808;
        bh=et1WuGEgCEo3FZS2w9Z1FIFHVSIkQPT04exuPz74HKE=;
        h=From:To:Cc:Subject:Date:From;
        b=Tj6HldqagJq6OUzQC2vBcObstMgD3x0UXdX++OsuK/jbCifS3WN/Lm+FrG01LDd2w
         rKGxyDKMMBdGYXVnpCB2yKfyb2ojR61aT85uv7k7kCwldYGDcU3Sp0FmKdSdBRkjcW
         nuO3pe4ByUdNM8DBCwUG6ygLmgUYyK1tiPryHPAfLswqpZemw+54X8DZyil4zKSlVp
         apEQG4TsT2tD8NempwUUAoyv1jse4uVhQPJ6xD10zd05htCMjNiSoq/WtQ5s8NGR79
         14tHlpMcUxb+5mtmuSuomrqyCbJIE15I7FqisyjmYvcljXzcFkFChbKSr4YpI5nkTV
         EK5HTm7cg9myQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 1/7] power: supply: bq25890: Document POWER_SUPPLY_PROP_CURRENT_NOW
Date:   Mon, 10 Oct 2022 23:03:04 +0200
Message-Id: <20221010210310.165461-1-marex@denx.de>
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

Document that POWER_SUPPLY_PROP_CURRENT_NOW really does refer to ADC-sampled
immediate battery charge current I_BAT , since the meaning is not clear with
all the currents which might be measured by charger chips.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org
---
 drivers/power/supply/bq25890_charger.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 6020b58c641d2..1298d5720aa4b 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -588,7 +588,14 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
 		val->intval = 2304000 + ret * 20000;
 		break;
 
-	case POWER_SUPPLY_PROP_CURRENT_NOW:
+	case POWER_SUPPLY_PROP_CURRENT_NOW:	/* I_BAT now */
+		/*
+		 * This is ADC-sampled immediate charge current supplied
+		 * from charger to battery. The property name is confusing,
+		 * for clarification refer to:
+		 * Documentation/ABI/testing/sysfs-class-power
+		 * /sys/class/power_supply/<supply_name>/current_now
+		 */
 		ret = bq25890_field_read(bq, F_ICHGR); /* read measured value */
 		if (ret < 0)
 			return ret;
-- 
2.35.1

