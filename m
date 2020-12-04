Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16EB2CEE42
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 13:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgLDMkU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 07:40:20 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33679 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgLDMkT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 07:40:19 -0500
Received: by mail-lf1-f65.google.com with SMTP id l11so7473007lfg.0;
        Fri, 04 Dec 2020 04:39:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=F2EiTXQ+grZfv5m36YbBmt+caw2P1Axi2eSAmuzDH0s=;
        b=O73mKd+iL3mPCsCoJ2GivEsDWVVHkI2lftiZK+oYbj0vkodhv4TgxW8yxmKNBGfnw3
         9o3Du+jlltGvo57xzmtI/vWYLx8vz35MCcWR5qMG2xf9WZf7O3psh9WO8FO+DUm9ncwD
         UNQmJmpp/iEO7DzDfjKsajWSjBoLvVaQFU8gO/A914c6d2Yh/uGCjIUYgkcqvclp7t+m
         23KsasYqVtgxC8NVgoaIRpUYlDIRajZ62v9WxxLh/ohEKQ2ejiDF2CsGmkQ3h7HhN1NQ
         yy9kTEAgsAHzLT8cHvYLoLzf/3AMLCkmEqhMbuVStvVk2LVzmpB19dhCpQOsle1EwTKR
         S6eg==
X-Gm-Message-State: AOAM531YVegmfQiCwpp3wt4aslCGhhVs7MXUw/l0eLlovgLYcncvVNBl
        j5k0QAdI9VQHdFuWB7GhCNI=
X-Google-Smtp-Source: ABdhPJyRh9KhDsHQ2zn/MabYlp4I3KouQX9i2SI01HpTvRaqRAHSXYfPhRaQgKATvycIsrd9Ic6KTw==
X-Received: by 2002:a19:d85:: with SMTP id 127mr80841lfn.382.1607085570570;
        Fri, 04 Dec 2020 04:39:30 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id q13sm1645985lfk.147.2020.12.04.04.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 04:39:29 -0800 (PST)
Date:   Fri, 4 Dec 2020 14:39:21 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Cong Pham <cpham2403@gmail.com>, rostokus@gmail.com,
        fan.chen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [RFC PATCH v2 0/6] power: supply: Add some fuel-gauge logic
Message-ID: <cover.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sorry again folks - I picked you as recipients just because I assumed
you could have something to say in here. Again, please let me know
if you wish to be dropped from CC if this gets any further.

power: supply: add sw-gauge for SOC estimation and CC correction

This RFC has still not been properly tested in HW - even if I
actually managed to run the iteration at some point of development :)
So still no accurate review or any kind of final acceptance is asked. I
am hoping to get some opinions/guidance regarding this :) All help is
highly appreciated! "The thing" for which I would like to get the
initial feedback is in patch 2 - rest of the patches give some context
to it :)

I have couple of ROHM PMIC drivers for devices with battery charger
and coulomb counter in device. Some users have asked me if these
drivers could be added upstream - and I actually think it would help
people. While evaluating these drivers I saw they do implement
some fuel-gauging/CC correcting logic - which might be useful for
other similar ICs. Hence I am wondering if I should try pulling the
logic out of IC drivers to power-supply core while leaving just IC
specific code in drivers. This RFC is first result for pulling the
logic out of drivers.

In other words, this is an early state RFC for adding some
fuel-gauge logic to power-supply core. I am overall asking if this
kind of functionality would be welcome in power-supply core, and if
yes - then I would like to get some overall direction for this.
I am for example wondering if this should be added as a own entity
which uses power-supply class underneath (in a way this RFC
introduces it) - or if it should be meld in existing power-supply
class.  But there's no point in pondering this if this kind of
functionality has no chance being accepted :)

Is this seen as potentially useful feature which should be
in-kernel? (I think this has it's place in-kernel as HW details
like coulomb-counter adjustment should really not be something
user-space should care. Another reason is that few low-power
embedded devices actually do periodical wake-up from suspend/
other low-power states just to do CC adjustment - even though
the wake-up costs some power. If this is ever to be supported
by mainline kernel - then waking up the whole user-space just
to do this CC adjustment iteration is not preferable. But that
wake-up is not covered by this RFC, it is just one motvation
behind putting this in-kernel - where it in my opinion would be
better to be generic and available for all ICs than written in
each IC specific driver).

Oh, please let me know if you wish to see some more documentation,
I can try adding something in Documentation folder too.

Changelog RFC v2:
 - lots of logic fixes.
 - rechecked units
 - changed low-voltage correction to capacity correction
 - added first draft of IC driver which could use the swgauge

Patch 1:
 - Adds cap2ocv helper (should be reworked to allow 0.1% accuracy for cap)
Patch 2:
 - Add the swgauge (better name would be nice). The main thing in this
   RFC
Patch 3, 4:
 - bring in some charger register descriptions etc for the driver
Patch 5:
 - add charger driver for ROHM BD718(27/28/78) PMICs as an example
Patch 6:
 - fix the device ID

---

Matti Vaittinen (6):
  power: supply: add cap2ocv batinfo helper
  power: supply: add sw-gauge for SOC estimation and CC correction
  mfd: prepare to support BD718xx-charger
  mfd: add BD71827 header
  power: supply: Add bd718(27/28/78) charger driver
  MFD: bd71828: differentiate bd71828 and bd71827 chargers

 drivers/mfd/rohm-bd71828.c                  |    2 +-
 drivers/power/supply/Kconfig                |   18 +
 drivers/power/supply/Makefile               |    2 +
 drivers/power/supply/bd71827-power.c        | 2162 +++++++++++++++++++
 drivers/power/supply/power_supply_core.c    |   51 +
 drivers/power/supply/power_supply_swgauge.c | 1025 +++++++++
 include/linux/mfd/rohm-bd71827.h            |  295 +++
 include/linux/mfd/rohm-bd71828.h            |   65 +
 include/linux/mfd/rohm-generic.h            |    2 +
 include/linux/power/sw_gauge.h              |  225 ++
 include/linux/power_supply.h                |   11 +
 11 files changed, 3857 insertions(+), 1 deletion(-)
 create mode 100644 drivers/power/supply/bd71827-power.c
 create mode 100644 drivers/power/supply/power_supply_swgauge.c
 create mode 100644 include/linux/mfd/rohm-bd71827.h
 create mode 100644 include/linux/power/sw_gauge.h


base-commit: 09162bc32c880a791c6c0668ce0745cf7958f576
-- 
2.25.4


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
