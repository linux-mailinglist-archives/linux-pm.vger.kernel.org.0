Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AA931AB1E
	for <lists+linux-pm@lfdr.de>; Sat, 13 Feb 2021 12:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhBML7I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Feb 2021 06:59:08 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:33776 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhBML7I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Feb 2021 06:59:08 -0500
Received: by mail-lf1-f50.google.com with SMTP id b2so3338062lfq.0;
        Sat, 13 Feb 2021 03:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=GosurqFqirHdQWyzX6cWeJ6swt8DHy8QXcFDoJi5ZkU=;
        b=OSpgtWiaMP41tltyjBK9m9F26XZGhn3fjci5HPUz+Dh1HmYxE3YJlwn25YBfr80MVo
         w9blByx/FQDPVdXecmairzfHmeqCp2j8tjDBHHePneZYXcZ6qPGFPWZs4WuVPTfgrWMi
         zCVHA2g2TVd+Buc/8SG7QB9mLpq3/LXzJmu6Xzn8p1u32Wrv7bYrZGIRaZenT+0qOayn
         eZldQUnGvhKXd7+TnyMxy0FxqQ2oQ86pQajeAIxVizLxQW1r2JWPPdTKaBi1w+7VyRMg
         MubGOrtVNJxBDtXla/J7ag873GWnFd45sRaupzyhUv0LOLT1USmrrZKHk+kiJTagCeSl
         IeOA==
X-Gm-Message-State: AOAM533T/+wiY0e1JXAhUiT5BF7l0Dtuw/2umlLJr7MUb9G1nTcWC18N
        gbNSv7htTlGsGUtWM3QDng4=
X-Google-Smtp-Source: ABdhPJzkMegmGR3Q1jpC7ira2DsUWneGtFG/3HdAvrJEBdUAnT0Wtr1aUFM0Qwze3n3LrKxXHRY7jw==
X-Received: by 2002:a05:6512:3741:: with SMTP id a1mr3794390lfs.137.1613217505179;
        Sat, 13 Feb 2021 03:58:25 -0800 (PST)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id r6sm1853428lfc.8.2021.02.13.03.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 03:58:24 -0800 (PST)
Date:   Sat, 13 Feb 2021 13:58:17 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [RFC PATCH 0/7] Add managed version of delayed work init
Message-ID: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's not rare that device drivers need delayed work.
It's not rare that this work needs driver's data.

Often this means that driver must ensure the work is not queued when
driver exits. Usually this is done by ensuring new work is not added and
then calling cancel_delayed_work_sync() at remove(). In many cases this
may also require cleanup at probe error path - which is easy to forget.

It might be helpful for (a) few drivers if there was a work init
function which would ensure cancel_delayed_work_sync() is called at
driver exit. So this series implements one on top of devm and replaces
the obvious cases where only thing remove call-back in a driver does is
cancelling the work. There might be other cases where we could switch
more than just work cancellation to use managed version and thus get rid
of remove.

Main reson why this is RFC is that I had hard time deciding where this
function should be introduced. It's not nice to include all device stuff
in workqueue - because many workqueue users are not interested in
devices. In same way, not all of the devices are interested in WQs.
OTOH, adding own file just for this sounds like an overkill.

This time I decided that it is more correct that devices use WQs than
that WQs use devices. Hence the function is introduced in
include/linux/device.h and drivers/base/devres.c

--

Matti Vaittinen (7):
  drivers: base: Add resource managed version of delayed work init
  extconn: Clean-up few drivers by using managed work init
  hwmon: raspberry-pi: Clean-up few drivers by using managed work init
  platform/x86: gpd pocket fan: Clean-up by using managed work init
  power: supply: Clean-up few drivers by using managed work init
  regulator: qcom_spmi-regulator: Clean-up by using managed work init
  watchdog: retu_wdt: Clean-up by using managed work init

 drivers/base/devres.c                        | 33 ++++++++++++++++++++
 drivers/extcon/extcon-gpio.c                 | 14 ++-------
 drivers/extcon/extcon-intel-int3496.c        | 15 ++-------
 drivers/extcon/extcon-palmas.c               | 16 +++-------
 drivers/extcon/extcon-qcom-spmi-misc.c       | 16 +++-------
 drivers/hwmon/raspberrypi-hwmon.c            | 16 +++-------
 drivers/platform/x86/gpd-pocket-fan.c        | 16 +++-------
 drivers/power/supply/axp20x_usb_power.c      | 15 +++------
 drivers/power/supply/bq24735-charger.c       | 17 +++-------
 drivers/power/supply/ltc2941-battery-gauge.c | 19 ++++-------
 drivers/power/supply/sbs-battery.c           | 15 +++------
 drivers/regulator/qcom_spmi-regulator.c      | 33 +++++---------------
 drivers/watchdog/retu_wdt.c                  | 21 +++----------
 include/linux/device.h                       |  5 +++
 14 files changed, 95 insertions(+), 156 deletions(-)


base-commit: 92bf22614b21a2706f4993b278017e437f7785b3
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
