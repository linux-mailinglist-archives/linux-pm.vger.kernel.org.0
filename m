Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 915C119077D
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 09:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgCXI1w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 04:27:52 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41313 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgCXI1w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 04:27:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id z23so739441lfh.8;
        Tue, 24 Mar 2020 01:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nh4UhvTKl+29tzL3tROO0vjxlPcLXCH4Rq0vuGpKBTo=;
        b=HLeOiseNYjPG2lfh0VXxr5lYklmXhLSOLIwiGXvVHTQ3YxdSROLfwyquo9IdclOLMX
         xCaa5tcUONHQtfyC5rdw2FfTuJX9X0bmh3BEb4/4PFFxKS4iYez9BfO8LsGDXdI1aLQX
         e/yTO+b+QC3PaiiYka3OksVJP1oGRy2L9sxj1EQpIqYYHj+U9Sm8XHnY5bvPtoSJZ0AV
         2nMR3N3PxMY/ucU5+2qdymHkHpqVxiCPD5YkXmG2Zfh3Dwf+CWHIRukY3kFuYc4u3fub
         4z46tCKOjKiIzQ4MeG0i4/s+wpoDljDsOEHBeseJ6VDf3OSaObC/Y9LCCXyjcmGZXfx4
         dB0Q==
X-Gm-Message-State: ANhLgQ2pEPxP2sewP/jt5Xz4liuupjPNntqlhX/ndwQFXOvRwy3qvtEa
        nrzAq5VDbAkhMcgB7RGS4ic=
X-Google-Smtp-Source: ADFU+vtkwISRZYUD057P5cbGw2XfbCNUGZ9hKV/Bm2rbq/yVznyKoWqXE3G9XB0HXlwOHdE5NVb5tg==
X-Received: by 2002:ac2:4854:: with SMTP id 20mr7658197lfy.146.1585038468890;
        Tue, 24 Mar 2020 01:27:48 -0700 (PDT)
Received: from localhost.localdomain (dc7t7ryyyyyyyyyyyyybt-3.rev.dnainternet.fi. [2001:14ba:16e1:b700::3])
        by smtp.gmail.com with ESMTPSA id m15sm9584811ljo.8.2020.03.24.01.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 01:27:48 -0700 (PDT)
Date:   Tue, 24 Mar 2020 10:27:39 +0200
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
Subject: [PATCH v6 01/10] dt-bindings: battery: add new battery parameters
Message-ID: <ee741f391911a4e7c272ed86955ccd1e81ad236f.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
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

Add:

 - trickle-charge-current-microamp:

Some chargers have 3 charging stages. First one when battery is almost
empty is often called as trickle-charge. Last state when battery has been
"woken up" is usually called as fast-charge. In addition to this some
chargers have a 'middle state' which ROHM BD99954 data-sheet describes as
pre-charge. Some batteries can benefit from this 3-phase charging
[citation needed].

Introduce trickle-charge-current-microamp so that batteries can give
charging current limit for all three states.

 - precharge-upper-limit-microvolt:

When battery voltage has reached certain limit we change from
trickle-charge to next charging state (pre-charge for BD99954). Allow
battery to specify this limit.

 - re-charge-voltage-microvolt:

Allow giving a battery specific voltage limit for chargers which can
automatically re-start charging when battery has discharghed down to
this limit.

- over-voltage-threshold-microvolt

Allow specifying voltage threshold after which the battery is assumed to
be faulty.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/power/supply/battery.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index 3049cf88bdcf..5e29595edd74 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -11,15 +11,21 @@ different type. This prevents unpredictable, potentially harmful,
 behavior should a replacement that changes the battery type occur
 without a corresponding update to the dtb.
 
+Please note that not all charger drivers respect all of the properties.
+
 Required Properties:
  - compatible: Must be "simple-battery"
 
 Optional Properties:
+ - over-voltage-threshold-microvolt: battery over-voltage limit
+ - re-charge-voltage-microvolt: limit to automatically start charging again
  - voltage-min-design-microvolt: drained battery voltage
  - voltage-max-design-microvolt: fully charged battery voltage
  - energy-full-design-microwatt-hours: battery design energy
  - charge-full-design-microamp-hours: battery design capacity
+ - trickle-charge-current-microamp: current for trickle-charge phase
  - precharge-current-microamp: current for pre-charge phase
+ - precharge-upper-limit-microvolt: limit when to change to constant charging
  - charge-term-current-microamp: current for charge termination phase
  - constant-charge-current-max-microamp: maximum constant input current
  - constant-charge-voltage-max-microvolt: maximum constant input voltage
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
