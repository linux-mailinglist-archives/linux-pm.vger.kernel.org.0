Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377C55798AE
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jul 2022 13:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbiGSLnh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jul 2022 07:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiGSLnh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jul 2022 07:43:37 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA243F304
        for <linux-pm@vger.kernel.org>; Tue, 19 Jul 2022 04:43:35 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id u14so9058774lju.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Jul 2022 04:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u8k7Jf5aTFxu0icKTRZ2sE0N8FLv2IMIzpwDjXshk98=;
        b=cSwe5PvnXwn3X0icLxJOtCwPVN/kjhYx9fYT1YB7s6QdgCGaSwdmuWaImDd3dghmxO
         xUa7duWnbLNT2Wpzzan4HDm0qCUm7QYMgIr2paUoiGHpzlQjc44qdW1bMovhI1RCNdA8
         aozQwwH4rq+nF6c6EMUYiWLJEHBBFM+TcCCvfUAhPG1KWDHy+R1pfuSM+xxt/1AITXbC
         U7JTl7UgQ+gl3co0C/P0kfA3wa+yb+cHHgDaBrOUrb303YP1UmxAjHJLXxwTq25nY45X
         9VDMo6w8TWV+OwMdbDJsyxJDkXSMmd7wswSa0bHPZI1UC8nftQJQtizbxUqMbrSY1HMl
         A4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u8k7Jf5aTFxu0icKTRZ2sE0N8FLv2IMIzpwDjXshk98=;
        b=Y8fiB76K0GxcrXboxosISEO22iGBNLGxltdpSdmOcMarX+CAgA3SRHHcIWoEcRQCIM
         kBgE6hmxmhLHRojt7FUYQrqGmztD01qdy1RkXAuUn4TsFAjQsg0E4NWFq3kViXnjr0Jk
         ZldVhkjmWmQvI4uN15FHtTdd/jqeRBuuOoFKsYkq+L1ua6vGK9v3aJsQL1VOstI6a46C
         J8KXeL/kLHLStu8TQ3GromfoRgBpw+TwKc3E9uRaFiaL4SR+yCWXEBg4n6syRQPXh6eN
         2nwhzQy4p/ZcJvbTP7Mmxnfmi2L0XMorUvuC+oLQsfXvJpmFAWMbDflDudXXqXYBPSsW
         MB4A==
X-Gm-Message-State: AJIora/PfncraaBA4mydIL6xlgKjfPy2HLL7riLsEro8quYbBPFdAilJ
        Gs8PEhnIme+CncYm8CAx7gqjyeJ2BKFag9Ee
X-Google-Smtp-Source: AGRyM1vcRgL48RnejKUjwqB8IqMKdJD4CzKqiUBkc/e9/ooKx7NuJoexZW7atEdWRnm1rPmsGrNx/A==
X-Received: by 2002:a2e:a317:0:b0:25d:83e8:ce60 with SMTP id l23-20020a2ea317000000b0025d83e8ce60mr15124649lje.111.1658231013636;
        Tue, 19 Jul 2022 04:43:33 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u14-20020a19790e000000b00489da8b29e8sm3179255lfc.123.2022.07.19.04.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 04:43:33 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Matti Vaittineen <matti.vaittinen@fi.rohmeurope.com>
Subject: [PATCH] power: supply: Explain maintenance charging
Date:   Tue, 19 Jul 2022 13:41:31 +0200
Message-Id: <20220719114131.62470-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order for everyone to understand clearly why we want to use
maintenance charging for batteries, expand the description with two
diagrams and some text.

Cc: Matti Vaittineen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/power_supply.h | 48 +++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index cb380c1d9459..aa2c4a7c4826 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -374,9 +374,37 @@ struct power_supply_vbat_ri_table {
  *   These timers should be chosen to align with the typical discharge curve
  *   for the battery.
  *
- * When the main CC/CV charging is complete the battery can optionally be
- * maintenance charged at the voltages from this table: a table of settings is
- * traversed using a slightly lower current and voltage than what is used for
+ * Ordinary CC/CV charging will stop charging when the charge current goes
+ * below charge_term_current_ua, and then restart it (if the device is still
+ * plugged into the charger) at charge_restart_voltage_uv. This happens in most
+ * consumer products because the power usage while connected to a charger is
+ * not zero, and devices are not manufactured to draw power directly from the
+ * charger: instead they will at all times dissipate the battery a little, like
+ * the power used in standby mode. This will over time give a charge graph
+ * such as this:
+ *
+ * Energy
+ *  ^      ...        ...      ...      ...      ...      ...      ...
+ *  |    .   .       .  .     .  .     .  .     .  .     .  .     .
+ *  |  ..     .   ..     .  ..    .  ..    .  ..    .  ..    .  ..
+ *  |.          ..        ..       ..       ..       ..       ..
+ *  +-------------------------------------------------------------------> t
+ *
+ * Practically this means that the Li-ions are wandering back and forth in the
+ * battery and this causes degeneration of the battery anode and cathode.
+ * To prolong the life of the battery, maintenance charging is applied after
+ * reaching charge_term_current_ua to hold up the charge in the battery while
+ * consuming power, thus lowering the wear on the battery:
+ *
+ * Energy
+ *  ^      .......................................
+ *  |    .                                        ......................
+ *  |  ..
+ *  |.
+ *  +-------------------------------------------------------------------> t
+ *
+ * Maintenance charging uses the voltages from this table: a table of settings
+ * is traversed using a slightly lower current and voltage than what is used for
  * CC/CV charging. The maintenance charging will for safety reasons not go on
  * indefinately: we lower the current and voltage with successive maintenance
  * settings, then disable charging completely after we reach the last one,
@@ -385,14 +413,22 @@ struct power_supply_vbat_ri_table {
  * ordinary CC/CV charging from there.
  *
  * As an example, a Samsung EB425161LA Lithium-Ion battery is CC/CV charged
- * at 900mA to 4340mV, then maintenance charged at 600mA and 4150mV for
- * 60 hours, then maintenance charged at 600mA and 4100mV for 200 hours.
+ * at 900mA to 4340mV, then maintenance charged at 600mA and 4150mV for up to
+ * 60 hours, then maintenance charged at 600mA and 4100mV for up to 200 hours.
  * After this the charge cycle is restarted waiting for
  * charge_restart_voltage_uv.
  *
  * For most mobile electronics this type of maintenance charging is enough for
  * the user to disconnect the device and make use of it before both maintenance
- * charging cycles are complete.
+ * charging cycles are complete, if the current and voltage has been chosen
+ * appropriately. These need to be determined from battery discharge curves
+ * and expected standby current.
+ *
+ * If the voltage anyway drops to charge_restart_voltage_uv during maintenance
+ * charging, ordinary CC/CV charging is restarted. This can happen if the
+ * device is e.g. actively used during charging, so more current is drawn than
+ * the expected stand-by current. Also overvoltage protection will be applied
+ * as usual.
  */
 struct power_supply_maintenance_charge_table {
 	int charge_current_max_ua;
-- 
2.36.1

