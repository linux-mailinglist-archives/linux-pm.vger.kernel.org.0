Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A174A2AB7
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jan 2022 01:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344756AbiA2Avp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jan 2022 19:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344747AbiA2Avp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jan 2022 19:51:45 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3781C061714
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:44 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bu18so15047542lfb.5
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PDKGOZnqKCsIhFi68DWiekODPCtMos39pnNHIoBYyvE=;
        b=QAGQv5cJncDUdEJYvvNzrsuUcRUQanTaxQuuOemMXeCMeErnz1SD6fkFRIHUn219fJ
         eVOU5k8CSNgGjeWikI3Muv9aU5AYElOWbJ1/e0DDuj7Aa5m7ylNfNUeRg9JEunApgRnn
         LzTGarUoRBPuJ2mHaPPmngmOb+K26jNduoGia/2nj1Q4ZyCwu/UH0qYQ7M/s8F1Cw77K
         AUChRJo4tnIqNKGZpkLbeNRh85+sPzXAytnoEnNaeIdYepkH3AYAH9J7K1YHPzJYDdmj
         iDXzRq8WbEKbLN1vFIfL6Izwq8JG1nPsJCde8p29ceFglcOxdymAi8dqjnRzagCwg7/l
         Cnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PDKGOZnqKCsIhFi68DWiekODPCtMos39pnNHIoBYyvE=;
        b=U3q9T1B2SXI3EtLf4L8Jlt89WSxNYmqVpjtn+qfirK+whNwiIdYCwnimIgDUaQwCep
         +Z31XGwz3Rv/I3wpL6oCTuN2otxpS03M2AQ/W1aFBnU5qsUh1jSF2cDVDRyxVtKNDZXf
         LGBfclL3gDV4pJwQ8pAUicqbw80NOPCtqMcPkYPmRmOTasuUGfXrYc7ukqawgVYv2ile
         RooOQ9DYywvodOzALNEnOsKgTdLNv22u5ozP273O/oQ5IFey3hBaz2mXaAN5rO0LFIAh
         P9QyluVySKh5qNsoWcartphVdKaGgMXm9DeMuAioDHYrFMWABsmjjab5+Deh13O3/nbo
         cF5w==
X-Gm-Message-State: AOAM532Z3Xxx8NtlUT5lbIjvx5IRG7J9Dj6+Md3gqbWtLwfQwMZR3sN/
        4jN8edFwK/YN+ZbFEFuR9PbvaA==
X-Google-Smtp-Source: ABdhPJxier6besGZ4ak56+sCUn4KLy67zeXEdDv9X53WF3VWtuQ9YH/TkaQEFMEUCQv3C1Yk0G4qRg==
X-Received: by 2002:a05:6512:3123:: with SMTP id p3mr8135719lfd.298.1643417503342;
        Fri, 28 Jan 2022 16:51:43 -0800 (PST)
Received: from localhost.localdomain ([92.34.204.253])
        by smtp.gmail.com with ESMTPSA id m17sm2232903lfr.24.2022.01.28.16.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 16:51:42 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 06/11 v2] power: supply: ab8500_fg: Safeguard compensated voltage
Date:   Sat, 29 Jan 2022 01:49:20 +0100
Message-Id: <20220129004925.639684-7-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129004925.639684-1-linus.walleij@linaro.org>
References: <20220129004925.639684-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In some cases when the platform is dissapating more than
500mA the voltage measurements and compensation will become
instable. Add a parameter to bail out of the voltage
measurement if this happens.

This code was found in a Samsung vendor tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Resending with other patches, no changes.
---
 drivers/power/supply/ab8500_fg.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 1797518c4b0e..c659fdc8babd 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -46,6 +46,8 @@
 
 #define NBR_AVG_SAMPLES			20
 #define WAIT_FOR_INST_CURRENT_MAX	70
+/* Currents higher than -500mA (dissipating) will make compensation unstable */
+#define IGNORE_VBAT_HIGHCUR		-500000
 
 #define LOW_BAT_CHECK_INTERVAL		(HZ / 16) /* 62.5 ms */
 
@@ -911,12 +913,13 @@ static int ab8500_fg_battery_resistance(struct ab8500_fg *di)
 /**
  * ab8500_load_comp_fg_bat_voltage() - get load compensated battery voltage
  * @di:		pointer to the ab8500_fg structure
+ * @always:	always return a voltage, also uncompensated
  *
  * Returns compensated battery voltage (on success) else error code.
  * If always is specified, we always return a voltage but it may be
  * uncompensated.
  */
-static int ab8500_load_comp_fg_bat_voltage(struct ab8500_fg *di)
+static int ab8500_load_comp_fg_bat_voltage(struct ab8500_fg *di, bool always)
 {
 	int i = 0;
 	int vbat_uv = 0;
@@ -941,6 +944,14 @@ static int ab8500_load_comp_fg_bat_voltage(struct ab8500_fg *di)
 
 	ab8500_fg_inst_curr_finalize(di, &di->inst_curr_ua);
 
+	/*
+	 * If there is too high current dissipation, the compensation cannot be
+	 * trusted so return an error unless we must return something here, as
+	 * enforced by the "always" parameter.
+	 */
+	if (!always && di->inst_curr_ua < IGNORE_VBAT_HIGHCUR)
+		return -EINVAL;
+
 	vbat_uv = vbat_uv / i;
 
 	/* Next we apply voltage compensation from internal resistance */
@@ -964,7 +975,7 @@ static int ab8500_fg_load_comp_volt_to_capacity(struct ab8500_fg *di)
 {
 	int vbat_comp_uv;
 
-	vbat_comp_uv = ab8500_load_comp_fg_bat_voltage(di);
+	vbat_comp_uv = ab8500_load_comp_fg_bat_voltage(di, true);
 
 	return ab8500_fg_volt_to_capacity(di, vbat_comp_uv);
 }
-- 
2.34.1

