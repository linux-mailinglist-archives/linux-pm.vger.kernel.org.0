Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C7C49D761
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jan 2022 02:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbiA0BO7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Jan 2022 20:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiA0BO6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jan 2022 20:14:58 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE5EC06161C
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 17:14:58 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id e17so2009590ljk.5
        for <linux-pm@vger.kernel.org>; Wed, 26 Jan 2022 17:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IrjM1MQ0G3FDaMRIIRJA5dUwbfXPuiWXnRfRN9yfCGg=;
        b=VTyiQGofjVVGxfgX8nhW+RrcsQ4MDxnqT8D2u3YwESeYdlT5/Js6ANjWs2lAlBWjy7
         2ZTCUk+7TW8ND2zSO6U6cIK4bcolPI32lbyJI18LDIxAFnyjPZZsGXRHkd+Oe2NAPJZ0
         xqRCYOwr10vtVKmr9m+dqeTihUz2XD4Cof8rSQZfcwMwRzW0BuLyy1fRqRdNV5LWk/9R
         cRiJURqzD6yooPVA8XuvIAOgqR0pfFSkhBYol43KwmHk2sXRPIwVgH4Md5qivnhOjwpV
         u7gGlIGVcl91DsMtIGGvH93pWQ7ysr7Js7fOdH06w/U7sY/HUSK9KjeuiyX3Pxvi9qOk
         7VuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IrjM1MQ0G3FDaMRIIRJA5dUwbfXPuiWXnRfRN9yfCGg=;
        b=Dbp+VndXXuEhCKPQfH84wbOpfZ1DlEfWVxhFIdjS72n/5FAB74u5sWm9ieUA3itKp6
         NbIHqaARaDiLipTM1pa3PjqU3E09dslrkVzfaXobnxUiBV7tOxH2yQr2CLI6FJFdB69V
         ApE3CEwrlQ+VzNUlkYNTT8RaFG32kCTRIQsaf/vByaDLRKdE81PCFtQB9FtPUexcwy+h
         iys+9w3Ggn/PKNpFcnuF8rzR0iDuPm2H+51xSm0E0ZUDbb3CBvbz8gvYLkZmDg9k3DEl
         aug7kW2MMK1Ks/oYpD9H4nIalz5UVtzO120GkW6Mp2AP2hyiFWiAgc1YLmkjkbLIJZ7F
         1x+Q==
X-Gm-Message-State: AOAM532KmAiEqVQBwEOaruckoMmOVdCFCwBSe2ENa6E7KCdt4EcyVof3
        jAxNelHZ/Fx8eHfd8hubGncJEg==
X-Google-Smtp-Source: ABdhPJwHxTO5JSUWk/GCdV1dOFx1HsvVxIbAOvCwWDFsDzhoQe9W67wp8jHZP/Q4nUHN47Kf3S1/rA==
X-Received: by 2002:a2e:a378:: with SMTP id i24mr1299003ljn.240.1643246096749;
        Wed, 26 Jan 2022 17:14:56 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u14sm1028337lji.40.2022.01.26.17.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:14:56 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 06/11] power: supply: ab8500_fg: Safeguard compensated voltage
Date:   Thu, 27 Jan 2022 02:12:31 +0100
Message-Id: <20220127011236.332687-7-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127011236.332687-1-linus.walleij@linaro.org>
References: <20220127011236.332687-1-linus.walleij@linaro.org>
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
 drivers/power/supply/ab8500_fg.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 8c907900a56d..323f6bacefd8 100644
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

