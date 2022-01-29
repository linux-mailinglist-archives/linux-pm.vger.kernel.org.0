Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100E24A2AB5
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jan 2022 01:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344734AbiA2Avp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jan 2022 19:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344747AbiA2Avo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jan 2022 19:51:44 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59C1C061748
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:43 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id t9so11290632lji.12
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=12XBgT9PT9MtaDXb3QbnTrwikfYLy9sRhzeHqlQFG+Y=;
        b=IOFePUryf4nCBwifJZh1j8zanuWFVrrrxwdhSUwAqf9JwgvGCzCXTlPH6L3ifMLH/y
         9lWgCHdfGty5JZ7RtReq9xPs6vJEyLvASElIaq7QhM/9pSpS+sqv7eMlk6vMrc0y97N2
         pKRuhIqhpIipiR4llGoYbTibBWG0pD99raBCfTG+w/9vt5VvE1T6dbKAMPeBm+8iqVkm
         3kw7OxszJg/FYzF68lOSRcis4p1ktUFe4pBbEQXBeECjFrfeJalfHEwbXxiC0tb+Z8iM
         yRufwM6slkLyDlukOefZOvHBf99H35VfKkssgliWzccN8yNHERw/w3RTm9INAMatP8hQ
         xujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=12XBgT9PT9MtaDXb3QbnTrwikfYLy9sRhzeHqlQFG+Y=;
        b=3f7L/2/7LLL4xCp0iy0m/knQTrBO0udWLoz1iRzlynB7wZRp+Rss7+L86aDzdr+7ei
         eeCmYp0kcJDHdcUY+u+4Vj7oJqv87o6yxvW0t2oVRvsK+R6UBg+Pojz2/ssWelKt5edy
         NF3XTrFYzvkMVbHkc19NZM7IVEMwVAGiEhu+Zas0KcrhDloQdTCocNc2gfrQ8yCwMTfD
         K74FeyoX5xxXV8Xa4XQ1aqXoekUKqw6OdMpAv9OOPmA02SAdAs+zEf0P+1UEhFboKLl8
         bitFaKmgcclfahF0CTyzbFo5J7p7fBl9sYwHKrqbhXi16BLVUxsfaGYIk6mB4ZD/SbN5
         XIwQ==
X-Gm-Message-State: AOAM531Eosz4slpL/92Frqg6PnNLkNw/OzcEKfSmTIqdsubMN8OYUPpA
        NiIommIs/LkjyzOo8tHVLGHvXQ==
X-Google-Smtp-Source: ABdhPJxhdGE6oZ7jAMR4ndksEVA5ofHkMf0GeqIzrdc51zfPsiSopWynQpkto0n1DVQ6AFfZ9nlFAQ==
X-Received: by 2002:a2e:874d:: with SMTP id q13mr7327327ljj.304.1643417502126;
        Fri, 28 Jan 2022 16:51:42 -0800 (PST)
Received: from localhost.localdomain ([92.34.204.253])
        by smtp.gmail.com with ESMTPSA id m17sm2232903lfr.24.2022.01.28.16.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 16:51:41 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 05/11 v2] power: supply: ab8500_fg: Break out load compensated voltage
Date:   Sat, 29 Jan 2022 01:49:19 +0100
Message-Id: <20220129004925.639684-6-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129004925.639684-1-linus.walleij@linaro.org>
References: <20220129004925.639684-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Break out the part of the function providing the load compensated
capacity that provides the load compensated voltage and use
that to get the load compensated capacity.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Fix patch ordering issue: I was using a uv argument to
  ab8500_fg_battery_resistance() however that refactoring is
  later on in the series. Fixed now.
---
 drivers/power/supply/ab8500_fg.c | 50 ++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 29896f09fd17..1797518c4b0e 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -909,18 +909,20 @@ static int ab8500_fg_battery_resistance(struct ab8500_fg *di)
 }
 
 /**
- * ab8500_fg_load_comp_volt_to_capacity() - Load compensated voltage based capacity
+ * ab8500_load_comp_fg_bat_voltage() - get load compensated battery voltage
  * @di:		pointer to the ab8500_fg structure
  *
- * Returns battery capacity based on battery voltage that is load compensated
- * for the voltage drop
+ * Returns compensated battery voltage (on success) else error code.
+ * If always is specified, we always return a voltage but it may be
+ * uncompensated.
  */
-static int ab8500_fg_load_comp_volt_to_capacity(struct ab8500_fg *di)
+static int ab8500_load_comp_fg_bat_voltage(struct ab8500_fg *di)
 {
-	int vbat_comp_uv, res;
 	int i = 0;
 	int vbat_uv = 0;
+	int rcomp;
 
+	/* Average the instant current to get a stable current measurement */
 	ab8500_fg_inst_curr_start(di);
 
 	do {
@@ -932,25 +934,37 @@ static int ab8500_fg_load_comp_volt_to_capacity(struct ab8500_fg *di)
 
 	if (i > WAIT_FOR_INST_CURRENT_MAX) {
 		dev_err(di->dev,
-			"TIMEOUT: return capacity based on uncompensated measurement of VBAT\n");
-		goto calc_cap;
+			"TIMEOUT: return uncompensated measurement of VBAT\n");
+		di->vbat_uv = vbat_uv / i;
+		return di->vbat_uv;
 	}
 
 	ab8500_fg_inst_curr_finalize(di, &di->inst_curr_ua);
 
-calc_cap:
-	di->vbat_uv = vbat_uv / i;
-	res = ab8500_fg_battery_resistance(di);
+	vbat_uv = vbat_uv / i;
 
-	/*
-	 * Use Ohms law to get the load compensated voltage.
-	 * Divide by 1000 to get from milliohms to ohms.
-	 */
-	vbat_comp_uv = di->vbat_uv - (di->inst_curr_ua * res) / 1000;
+	/* Next we apply voltage compensation from internal resistance */
+	rcomp = ab8500_fg_battery_resistance(di);
+	vbat_uv = vbat_uv - (di->inst_curr_ua * rcomp) / 1000;
+
+	/* Always keep this state at latest measurement */
+	di->vbat_uv = vbat_uv;
+
+	return vbat_uv;
+}
+
+/**
+ * ab8500_fg_load_comp_volt_to_capacity() - Load compensated voltage based capacity
+ * @di:		pointer to the ab8500_fg structure
+ *
+ * Returns battery capacity based on battery voltage that is load compensated
+ * for the voltage drop
+ */
+static int ab8500_fg_load_comp_volt_to_capacity(struct ab8500_fg *di)
+{
+	int vbat_comp_uv;
 
-	dev_dbg(di->dev, "%s Measured Vbat: %d uV,Compensated Vbat %d uV, "
-		"R: %d mOhm, Current: %d uA Vbat Samples: %d\n",
-		__func__, di->vbat_uv, vbat_comp_uv, res, di->inst_curr_ua, i);
+	vbat_comp_uv = ab8500_load_comp_fg_bat_voltage(di);
 
 	return ab8500_fg_volt_to_capacity(di, vbat_comp_uv);
 }
-- 
2.34.1

