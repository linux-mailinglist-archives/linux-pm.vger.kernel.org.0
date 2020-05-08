Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DCE1CB3FC
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 17:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgEHPwc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 11:52:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33201 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgEHPwb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 11:52:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id z22so1813954lfd.0;
        Fri, 08 May 2020 08:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3qIvzDxmqP7D/AjiF6m94r9Ud+ISzBYrfJ2jwWGrV6Y=;
        b=KAJtUO12mnXXCzi3aj/YQup0pcFHuumLmlFxrG7OHjT1gDEPaPs7XAZFQASozbyDCe
         fbxHYDvR805Lkg3Mswe2qh5KMDx0ueg/G8w1ByGhn6NWfmCN8bIfWf3rP+NHqA5Oi//a
         fblbvG3xqZD3aSi/tUwlvOGtWAvX004uPUyVIQtU04RiNu6FIiOhGbN3VHqCOqXnrm5D
         kJDbSNBYJthSD5IBSGE9PulVcIAM8iM9ckLXnyZQU3emHgKYlJK5nbHS+CLRzweNay+f
         wAF4ZdFYSJUD9ttfUM3xEY7RAsViNaVDOP6xTth8pLH4RBuhNX4Mpo69Trvmj0L8tBJf
         z3lA==
X-Gm-Message-State: AOAM533OD2ZVwMEYesvBisW6m595fBA6Av7k4dj9UHhdKyPlVRzk5rmA
        cHOsh14ZvsioQ7OUF5R7x5M=
X-Google-Smtp-Source: ABdhPJy5GSDxWUa4jQw2b8yXSkPwp/Wt651C6V9/mfvGmrvtu9t969ynQzuHKVe2zaAV8N+Y0WOGSA==
X-Received: by 2002:a19:4f1b:: with SMTP id d27mr2385773lfb.81.1588953149263;
        Fri, 08 May 2020 08:52:29 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id v17sm1504445lfi.49.2020.05.08.08.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 08:52:28 -0700 (PDT)
Date:   Fri, 8 May 2020 18:51:42 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        brendanhiggins@google.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 10/11] power: supply: Fix Kconfig help text indentiation
Message-ID: <f557d685dd2d664a45f5938dca08a5bda2b496d7.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Indent the help text as explained in
Documentation/process/coding-style.rst

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

---

I just learned the help text in Kconfigs should be indented by two
spaces. I fixed this for BD99954 as suggested by Randy and decided
that I could do this for few other entries as well while I was at
it anyways.
---
 drivers/power/supply/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 436680ee8523..ec028e47c3c2 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -415,7 +415,7 @@ config CHARGER_PCF50633
 	tristate "NXP PCF50633 MBC"
 	depends on MFD_PCF50633
 	help
-	 Say Y to include support for NXP PCF50633 Main Battery Charger.
+	  Say Y to include support for NXP PCF50633 Main Battery Charger.
 
 config BATTERY_RX51
 	tristate "Nokia RX-51 (N900) battery driver"
@@ -609,15 +609,15 @@ config CHARGER_TPS65090
 	tristate "TPS65090 battery charger driver"
 	depends on MFD_TPS65090
 	help
-	 Say Y here to enable support for battery charging with TPS65090
-	 PMIC chips.
+	  Say Y here to enable support for battery charging with TPS65090
+	  PMIC chips.
 
 config CHARGER_TPS65217
 	tristate "TPS65217 battery charger driver"
 	depends on MFD_TPS65217
 	help
-	 Say Y here to enable support for battery charging with TPS65217
-	 PMIC chips.
+	  Say Y here to enable support for battery charging with TPS65217
+	  PMIC chips.
 
 config BATTERY_GAUGE_LTC2941
 	tristate "LTC2941/LTC2943 Battery Gauge Driver"
@@ -671,16 +671,16 @@ config CHARGER_SC2731
 	tristate "Spreadtrum SC2731 charger driver"
 	depends on MFD_SC27XX_PMIC || COMPILE_TEST
 	help
-	 Say Y here to enable support for battery charging with SC2731
-	 PMIC chips.
+	  Say Y here to enable support for battery charging with SC2731
+	  PMIC chips.
 
 config FUEL_GAUGE_SC27XX
 	tristate "Spreadtrum SC27XX fuel gauge driver"
 	depends on MFD_SC27XX_PMIC || COMPILE_TEST
 	depends on IIO
 	help
-	 Say Y here to enable support for fuel gauge with SC27XX
-	 PMIC chips.
+	  Say Y here to enable support for fuel gauge with SC27XX
+	  PMIC chips.
 
 config CHARGER_UCS1002
 	tristate "Microchip UCS1002 USB Port Power Controller"
@@ -698,9 +698,9 @@ config CHARGER_BD70528
 	select LINEAR_RANGES
 	default n
 	help
-	 Say Y here to enable support for getting battery status
-	 information and altering charger configurations from charger
-	 block of the ROHM BD70528 Power Management IC.
+	  Say Y here to enable support for getting battery status
+	  information and altering charger configurations from charger
+	  block of the ROHM BD70528 Power Management IC.
 
 config CHARGER_BD99954
 	tristate "ROHM bd99954 charger driver"
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
