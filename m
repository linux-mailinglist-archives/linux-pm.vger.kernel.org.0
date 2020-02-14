Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB4E15D2CA
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 08:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgBNH3Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 02:29:24 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45880 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbgBNH3Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 02:29:24 -0500
Received: by mail-lj1-f193.google.com with SMTP id e18so9526570ljn.12;
        Thu, 13 Feb 2020 23:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZwqGu8ChHjxGfrcOrBJFV2Ot6Ric8uxzSVIUFemYPKk=;
        b=KcK9BiWgUEaGDyAfikS7gCdoDSUf1IMBCr0OX4UZSeDceMU9c80QBQUdvUINpW5j9R
         vliKr9ZwOyFbIXrVuIgaWM0c9HkLyoJd7Mioc2pyCUsKLNeOVZf8jGKwp/Z6m7ViLKWX
         QSffPYEP6U1fOF+ZMd7Tz+V+1KNJ2+ci1g3M+guHZescD9CE7WdPsXARfoiLELQBWcFM
         mQklawtRvySazAxc2qfe8cDdQsHdj9kZbi5pnDhb7KzqiK4d67F8HXR5Y29jY65fuNTl
         Sd6NirNcOtSWZN4m6wWrytQV1X1+UA3MdxZr6kuZy3R5/GXQknqXKjdvCTzFJHQeoH2Y
         tsRw==
X-Gm-Message-State: APjAAAX2meje+RyKBy2BQL9ScU5JmABVRPheOcBHW5oXytJZayO3zPiu
        aJnRw+RzqzMTsCcDUzHcqOg=
X-Google-Smtp-Source: APXvYqyEbxVufY8W2afrBWSz0x0tOYU/hMBFPgDXQTZqb2x7NyLKNGkm3WRJBUShkEk/npve1OlMKQ==
X-Received: by 2002:a2e:556:: with SMTP id 83mr1152204ljf.127.1581665360309;
        Thu, 13 Feb 2020 23:29:20 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id k24sm3796667ljj.27.2020.02.13.23.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 23:29:19 -0800 (PST)
Date:   Fri, 14 Feb 2020 09:29:05 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     mikko.mutanen@fi.rohmeurope.com, markus.laine@fi.rohmeurope.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/5] Support ROHM BD99954 charger IC
Message-ID: <cover.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Support ROHM BD99954 Battery Management IC

ROHM BD99954 is a Battery Management IC for 1-4 cell Lithium-Ion
secondary battery. BD99954 is intended to be used in space-constraint
equipment such as Low profile Notebook PC, Tablets and other
applications.

Series introduces "linear ranges" helper intended to help converting
real-world values to register values when conversion is linear. This
version just meld the helpers in power/supply. Idea is stolen from
regulator framework's linear-ranges handling.

This version of series introduces new battry DT binding entries and
adds the parsing in power_supply_get_battery_info(). These properties
can be converted to ROHM specific properties and parsing can be moved
to the BD99954 driver if this does not seem like a right thing to do.
I just have a feeling the the BD99954 is not the only charger which
could utilize these.

We also add ROHM specific charger parameters for limiting the input
current(s). I think these parameters are pretty common and maybe the
"rohm,"-prefix should be dropped and we should try having common
input limiting properties for different chips?

Series is based on v5.5-rc7

Changelog RFC-v2:
 DT-bindings:
   - Used the battery parameters described in battery.txt
   - Added few new parameters to battery.txt
   - Added ASCII art charging profile chart for BD99954 to explain
     states and limits.
 Linear ranges:
   - Fixed division by zero error from linear-ranges code if step 0 is
     used.
 Power-supply core:
   - Added parsing of new battery parameters.
 BD99954 driver:
   - converted to use battery parameters from battery node
   - Added step 0 ranges for reg values which do not change voltage
   - added dt-node to psy-config

Patch 1:
	DT binding docs for the new battery parameters
Patch 2:
	BD99954 charger DT binding docs
Patch 3:
	Linear ranges helpers
Patch 4:
	Parsing of new battery parameters
Patch 5:
	BD99954 driver

---

Matti Vaittinen (5):
  dt-bindings: battry: add new battery parameters
  dt_bindings: ROHM BD99954 Charger
  power: Add linear_range helper
  power: supply: add battery parameters
  power: supply: Support ROHM bd99954 charger

 .../bindings/power/supply/battery.txt         |    6 +
 .../bindings/power/supply/rohm,bd9995x.yaml   |  167 +++
 drivers/power/supply/Kconfig                  |   14 +
 drivers/power/supply/Makefile                 |    2 +
 drivers/power/supply/bd70528-charger.c        |   65 +-
 drivers/power/supply/bd99954-charger.c        | 1140 +++++++++++++++++
 drivers/power/supply/linear-ranges.h          |   36 +
 drivers/power/supply/linear_ranges.c          |   92 ++
 drivers/power/supply/power_supply_core.c      |    8 +
 include/linux/power/bd99954-charger.h         | 1075 ++++++++++++++++
 include/linux/power_supply.h                  |    4 +
 11 files changed, 2552 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml
 create mode 100644 drivers/power/supply/bd99954-charger.c
 create mode 100644 drivers/power/supply/linear-ranges.h
 create mode 100644 drivers/power/supply/linear_ranges.c
 create mode 100644 include/linux/power/bd99954-charger.h

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
