Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5AA2C51CD
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 11:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732883AbgKZKJN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 05:09:13 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38849 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgKZKJM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 05:09:12 -0500
Received: by mail-lf1-f67.google.com with SMTP id s27so1709961lfp.5;
        Thu, 26 Nov 2020 02:09:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=eW8rVlKYblufr25dJFt7P8D/4U9Fps3APdQ1oTwqjCs=;
        b=lvnyTXi7x19r7yAZR7zs24HZLjXhI0gZqXkV78xSQdQb0n/qzXGdT2sbPROWSfyRZI
         AOBMva13vFYAr7Ui3xVum6n8l9q37EqPiRO9GsSPKFVA4o55G6DyHAW0cK4fJPU6UPYA
         wIIKK93jszIL0i2N1mzTKss+wJlbP08Ee7AXCXWFQm56ssuyHkWbmytWHDsfiP7TfPXp
         6lvBOOe+QE3vyXxHptEojx7Vy3krj5uYF2V3P50JBiPVhNyXaZMlvdlQ38a6ZjqzJw5m
         c2HguQKieRJqX/JapI9f6gLfh2X+wttVAgHzgFMcdnrqLTON+GPm53x0n9CNNsXOGwlm
         oyQg==
X-Gm-Message-State: AOAM530iVfxwN3sHRspu1838Vzia5H8er/stBATWZRCMRRVeyfW9VjfB
        E0HflmEp11EZEAw7tBqtjqQ=
X-Google-Smtp-Source: ABdhPJzkbLnKETyLBzbhFeI2tWkn6WN7SO2lO80StzAh2q1hwm1lUCT65bECHok74zGz05HahLXZVg==
X-Received: by 2002:a05:6512:3f6:: with SMTP id n22mr1008390lfq.393.1606385348714;
        Thu, 26 Nov 2020 02:09:08 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id o17sm254173lfg.136.2020.11.26.02.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 02:09:07 -0800 (PST)
Date:   Thu, 26 Nov 2020 12:09:01 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [RFC PATCH 0/2] power: supply: Add some fuel-gauge logic
Message-ID: <cover.1606384967.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sorry folks - I picked you as recipients just because I saw
your name in few recent commits to power-supply (well,
obviously Sebastian would have been picked anyways). I assumed
you could have something to say in here. Please let me know if you
wish to be dropped from CC if this gets any further.



power: supply: add sw-gauge for SOC estimation and CC correction

I have couple of ROHM PMIC drivers for devices with battery charger
and coulomb counter in device. Some users have asked me if these
drivers could be added upstream - and I actually think it would help
people. While evaluating these drivers I saw they do implement
some fuel-gauging/CC correcting logic - which might be useful for
other similar ICs. Hence I am wondering if I should try pulling the
logic out of IC drivers to power-supply core while leaving just IC
specific code in drivers. This RFC is first result for pulling the
logic out of drivers.

The goal of this RFC is really to clarify if I should just abandon
this idea and keep this logic in charger-driver(s) - or if there
already is some "de-facto" way of achieving the same (in which
case I should again abandon this and get new direction).

In other words, this is an early state RFC for adding some
fuel-gauge logic to power-supply core. I would highly appreciate if
the idea of adding _something_ like this was first discussed and
evaluated. This RFC has only been compile-tested this far so no
accurate reviewing or "acceptance" for this version is requested.
The code may still have few issues here and there...  So instead of
asking for proper code review here, I am overall asking if this
kind of functionality would be welcome in power-supply core, and if
yes - then I would like to get some overall direction for this.
I am for example wondering if this should be added as a own entity
which uses power-supply class underneath (in a way this RFC
introduces it) - or if it should be meld in existing power-supply
class. But there's no point in pondering this if this kind of
functionality has no chance being accepted :)

Is seen as potentially useful feature which should be
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

Anyways, enough of babbling for now - thanks for reading all the
way here:)


Matti Vaittinen (2):
  power: supply: add cap2ocv batinfo helper
  power: supply: add sw-gauge for SOC estimation and CC correction

 drivers/power/supply/Kconfig                |   8 +
 drivers/power/supply/Makefile               |   1 +
 drivers/power/supply/power_supply_core.c    |  51 ++
 drivers/power/supply/power_supply_swgauge.c | 808 ++++++++++++++++++++
 include/linux/power/sw_gauge.h              | 203 +++++
 include/linux/power_supply.h                |  11 +
 6 files changed, 1082 insertions(+)
 create mode 100644 drivers/power/supply/power_supply_swgauge.c
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
