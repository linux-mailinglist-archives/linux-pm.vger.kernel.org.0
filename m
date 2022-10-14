Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629D15FF2E8
	for <lists+linux-pm@lfdr.de>; Fri, 14 Oct 2022 19:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJNRYp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Oct 2022 13:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiJNRYo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Oct 2022 13:24:44 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4B8F581
        for <linux-pm@vger.kernel.org>; Fri, 14 Oct 2022 10:24:42 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E17A584B2B;
        Fri, 14 Oct 2022 19:24:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665768281;
        bh=Z/JdrWVE+bUsHIAmKuHFgeNsx+Og1FVroPqDTEuFGhw=;
        h=From:To:Cc:Subject:Date:From;
        b=l5Jr81REN6lIEe2dmy3EwM70R+UsPjQvayBzO2Ul/1S0Iwue4SL294rY65+xiYSvd
         6t3E2rAiQL2DLccKLo+xKvc64kSPpFOYa4sJFvNNYxhdJDlu0I9B40Fl2PgB0IkjAt
         8jeqSAgWyIyLdRWMT1dl8N9uTRwnBe6TI/dDTjCQp6aRbgVi67AbOhsPi+GK+/BZM1
         DhHGsJvlskS33M3m4Q6uI5xucDLXsZOMgIjznK8C/jqFk2fNCrVFTs1sVw40cDYgCi
         ecrUGbBjJLrNhuhGqbgyk1HaGC/+0bROVrPK7LrZioE/bFy5uoM2DtDJeP3Gl0EsW0
         BvRETDFXhmtnw==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 1/7] power: supply: bq25890: Document POWER_SUPPLY_PROP_CURRENT_NOW
Date:   Fri, 14 Oct 2022 19:24:21 +0200
Message-Id: <20221014172427.128512-1-marex@denx.de>
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

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org
---
V2: Add RB from Hans
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

