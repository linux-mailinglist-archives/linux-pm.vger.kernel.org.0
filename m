Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A2D19079D
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 09:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgCXIcz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 04:32:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39258 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgCXIcz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 04:32:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id j15so12467306lfk.6;
        Tue, 24 Mar 2020 01:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IjEhO5KyVk/mLcThJc5nXrYak70vFV8lM7HnSm/e624=;
        b=iSfp+yokQFXJu02saPFgRFF5uu1zAUJUfM+mrHxAJ5YBhX6H3dip6pxhCtEh+9leN+
         tihKJX8C5g0uRtDcJ7yjONen/Y//0v3nK3/UJoiFut1/jOZNC4f5XuGMxjsF1lLoFXAj
         I7t3Nq5h8/p95xWbd1iEPjFORPw43IkhkPQr02TNLlypYnLmxIzWwyiONHRLbBW4YKKh
         0uMW8Ixi2sFiGmnzJ8qWYFqMjoUmLSqPeawroX08LM38/Q65S4tAPhcnggq4eslWvGHc
         PlFyISkiQgfqsjozYi//1iKO7SduXCdM+amVCzdKJl6mx4szLj3M3VXpofmxyvkk5xQ+
         fibw==
X-Gm-Message-State: ANhLgQ3qj/An1UFdw3yMR6GxNyMndwAKfvKoy2YjrVFVwQUDIPrDp1IQ
        c1POUQ12epENh1HJ/tV+wqk=
X-Google-Smtp-Source: ADFU+vuC45OXgiz6TjtQcTQMN3L5NES8EFGGHuoS2ueBD2YrdjSO5K8ew9zzfTU1QU/wwYGsXD/iBQ==
X-Received: by 2002:a19:41c5:: with SMTP id o188mr4980992lfa.52.1585038771993;
        Tue, 24 Mar 2020 01:32:51 -0700 (PDT)
Received: from localhost.localdomain (dc7t7ryyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16e1:b700::3])
        by smtp.gmail.com with ESMTPSA id g21sm9431033lfh.12.2020.03.24.01.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 01:32:51 -0700 (PDT)
Date:   Tue, 24 Mar 2020 10:32:43 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Changbin Du <changbin.du@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Gow <davidgow@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Gary Hook <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tal Gilboa <talgi@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v6 10/10] power: supply: Fix Kconfig help text indentiation
Message-ID: <4301575089b89ff8953d5c94613c17cfd33bfdbf.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Indent the help text as explained in
Documentation/process/coding-style.rst

---

I just learned the help text in Kconfigs should be indented by two
spaces. I fixed this for BD99954 as suggested by Randy and decided
that I could do this for few other entries as well while I was at
it anyways.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/power/supply/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index af96d7fa56b1..f606ba069e4e 100644
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
