Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DAE1C8250
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 08:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgEGGPb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 02:15:31 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45575 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgEGGPa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 02:15:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id h4so4976036ljg.12;
        Wed, 06 May 2020 23:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3qIvzDxmqP7D/AjiF6m94r9Ud+ISzBYrfJ2jwWGrV6Y=;
        b=X5HvGVeh/rgZSeBajdcu4qGP6d9fXGV55Jm5lrcDq4vakQiAboS5GMpfXZSqSiYYsU
         YBcp7/IxJXGAhtnURfPGIVg7PjkMx2bHx2Vtp596oPRvMPjfE3wJBHU9PHpC/AgnsdUM
         zs6U4x7BV3ToYHR86VWkWa1Ot7YQP4OxgsA+c6ZpitXQGIKnwI2i2NqNlN8zHtaaUcQT
         aJDRTvAmViwq8qqryHd8NsJMuc8IgifHN/fCQOsxnMLSuj3UQdfs5PKVKIEDQIRMr1vB
         AJuaNRQvJCzz2yVWQudKOx6WrhG4qj7UNjKOWml6pn59RQLxK63rusSSzn62yU7JkR1e
         69Mg==
X-Gm-Message-State: AGi0PubWt3p9lsHn2A6RxMZMcKaTABxCOSloFOikmIxR0oOR6sEJRDJe
        xsQlZ76KyfWdnBPcKqEAksMrM6Ya8B8=
X-Google-Smtp-Source: APiQypLkOvmovG4cIaecZOEuvMIPHiLdmTXwYpc2/bd6cZKqZpXPwhOh9Asch3vzQ1WDMdBIU6h37w==
X-Received: by 2002:a2e:6c16:: with SMTP id h22mr6745374ljc.30.1588832127833;
        Wed, 06 May 2020 23:15:27 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id 25sm3062447lfr.92.2020.05.06.23.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 23:15:26 -0700 (PDT)
Date:   Thu, 7 May 2020 09:14:41 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 10/11] power: supply: Fix Kconfig help text indentiation
Message-ID: <de722e2031eb01bb26cba8bb1e72dffb6ac26865.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
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
