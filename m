Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C334AD911
	for <lists+linux-pm@lfdr.de>; Tue,  8 Feb 2022 14:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245610AbiBHNQS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Feb 2022 08:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344019AbiBHMvx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Feb 2022 07:51:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 575C5C03FEC0
        for <linux-pm@vger.kernel.org>; Tue,  8 Feb 2022 04:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644324711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ozy/9ZDhbwfk85kVKNH1o3PvBRUleemNPRbQ9NmI8Ms=;
        b=bYTBud7HgcymhVxq3zNmRyhdtIGiBIBYRQFYbpFsKdYT4nelSkqH36PbHXqf0VQd8BZT9m
        aONy3uXBQV+ABnH+QBD/aDIIkjcluSFqJW/yLDmZAdPDHWcDqg2owqFSWtLOm4no4xq9vY
        y28IByZ/k7Ib0pnFjvje/rCGQVeY/Lk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-RtPO2PPDOUK7EWVa-vW1HA-1; Tue, 08 Feb 2022 07:51:50 -0500
X-MC-Unique: RtPO2PPDOUK7EWVa-vW1HA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DF378143E5;
        Tue,  8 Feb 2022 12:51:49 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E4D67C0CE;
        Tue,  8 Feb 2022 12:51:48 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: axp288-charger: Set Vhold to 4.4V
Date:   Tue,  8 Feb 2022 13:51:47 +0100
Message-Id: <20220208125147.512145-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The AXP288's recommended and factory default Vhold value (minimum
input voltage below which the input current draw will be reduced)
is 4.4V. This lines up with other charger IC's such as the TI
bq2419x/bq2429x series which use 4.36V or 4.44V.

For some reason some BIOS-es initialize Vhold to 4.6V or even 4.7V
which combined with the typical voltage drop over typically low
wire gauge micro-USB cables leads to the input-current getting
capped below 1A (with a 2A capable dedicated charger) based on Vhold.

This leads to slow charging, or even to the device slowly discharging
if the device is in heavy use.

As the Linux AXP288 drivers use the builtin BC1.2 charger detection
and send the input-current-limit according to the detected charger
there really is no reason not to use the recommended 4.4V Vhold.

Set Vhold to 4.4V to fix the slow charging issue on various devices.

There is one exception, the special-case of the HP X2 2-in-1s which
combine this BC1.2 capable PMIC with a Type-C port and a 5V/3A factory
provided charger with a Type-C plug which does not do BC1.2. These
have their input-current-limit hardcoded to 3A (like under Windows)
and use a higher Vhold on purpose to limit the current when used
with other chargers. To avoid touching Vhold on these HP X2 laptops
the code setting Vhold is added to an else branch of the if checking
for these models.

Note this also fixes the sofar unused VBUS_ISPOUT_VHOLD_SET_MASK
define, which was wrong.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index ec41f6cd3f93..c498e62ab4e2 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -42,11 +42,11 @@
 #define VBUS_ISPOUT_CUR_LIM_1500MA	0x1	/* 1500mA */
 #define VBUS_ISPOUT_CUR_LIM_2000MA	0x2	/* 2000mA */
 #define VBUS_ISPOUT_CUR_NO_LIM		0x3	/* 2500mA */
-#define VBUS_ISPOUT_VHOLD_SET_MASK	0x31
+#define VBUS_ISPOUT_VHOLD_SET_MASK	0x38
 #define VBUS_ISPOUT_VHOLD_SET_BIT_POS	0x3
 #define VBUS_ISPOUT_VHOLD_SET_OFFSET	4000	/* 4000mV */
 #define VBUS_ISPOUT_VHOLD_SET_LSB_RES	100	/* 100mV */
-#define VBUS_ISPOUT_VHOLD_SET_4300MV	0x3	/* 4300mV */
+#define VBUS_ISPOUT_VHOLD_SET_4400MV	0x4	/* 4400mV */
 #define VBUS_ISPOUT_VBUS_PATH_DIS	BIT(7)
 
 #define CHRG_CCCV_CC_MASK		0xf		/* 4 bits */
@@ -769,6 +769,16 @@ static int charger_init_hw_regs(struct axp288_chrg_info *info)
 		ret = axp288_charger_vbus_path_select(info, true);
 		if (ret < 0)
 			return ret;
+	} else {
+		/* Set Vhold to the factory default / recommended 4.4V */
+		val = VBUS_ISPOUT_VHOLD_SET_4400MV << VBUS_ISPOUT_VHOLD_SET_BIT_POS;
+		ret = regmap_update_bits(info->regmap, AXP20X_VBUS_IPSOUT_MGMT,
+					 VBUS_ISPOUT_VHOLD_SET_MASK, val);
+		if (ret < 0) {
+			dev_err(&info->pdev->dev, "register(%x) write error(%d)\n",
+				AXP20X_VBUS_IPSOUT_MGMT, ret);
+			return ret;
+		}
 	}
 
 	/* Read current charge voltage and current limit */
-- 
2.33.1

