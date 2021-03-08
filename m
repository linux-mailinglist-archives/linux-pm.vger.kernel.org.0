Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9428330938
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 09:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhCHIOh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 03:14:37 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:44712 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhCHIOR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 03:14:17 -0500
Received: by mail-lf1-f54.google.com with SMTP id p21so19562132lfu.11;
        Mon, 08 Mar 2021 00:14:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RL8kpShXTflR5U23zepyqK1mLDGqgE+CRyZzfRgboL8=;
        b=J3WaROHhaqAzD0WwbqxFi+rO+WhxkV9hU29n4aJhKpR6tvsPOVFKOLCdkDCSUKNKX4
         jrEo8b3fcfO0Axuyar07fG6ZzykN5Mnh9Ei5/8mGgka1GeDG/7H5mYcSrM8V9U/djOYA
         U2K0IzSAEyH34bopFO9YIZuR2bB0NNGpPDxHf7ECfs4ZSiK+KoChLJ0pDgWc4apTI4Ml
         EuvZ7VD8SwdCKgkZZ/49qdTH8snrDuLHg5I0usC60saxUJ8qGu6B8KPKaVGmKP2jqOFt
         r0Q8yImAPjmU42q+hx758anzRRzFLP/jmENmNGEdAFsfuF22DxnuTsdYb19+WlHAArpM
         p50g==
X-Gm-Message-State: AOAM532CS0WOF6+ODdihJsGJsBFK84P2lrrCWqLMkVfx+h8bvwWcJkVU
        n8miOVvmDKGqtZC0TXQTGoA=
X-Google-Smtp-Source: ABdhPJy4LBhGHzpYjfCk4DPU0GQ7j+ILUZTNTy8ae7YAwRYHU+EtBNIniFrEhhdbuSeUW+Ms7a2PBw==
X-Received: by 2002:a05:6512:3092:: with SMTP id z18mr13309397lfd.249.1615191255329;
        Mon, 08 Mar 2021 00:14:15 -0800 (PST)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id 14sm1269292lfl.301.2021.03.08.00.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 00:14:14 -0800 (PST)
Date:   Mon, 8 Mar 2021 10:14:08 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
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
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: [RFC PATCH v2 0/8] Add managed version of delayed work init
Message-ID: <cover.1615187284.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's not rare that device drivers need delayed work.
It's not rare that this work needs driver's data.

Often this means that driver must ensure the work is not queued when
driver is detached. Often it is done by ensuring new work is not added and
then calling cancel_delayed_work_sync() at remove(). In many cases this
may also require cleanup at probe error path - which is easy to forget.

Also the "by ensuring new work is not added" has a gotcha.

It is not strange to see devm managed IRQs scheduling (delayed) work.
Mixing this with manua wq clean-up is hard to do correctly because the
devm is likely to free the IRQ only after the remove() is ran. So manual
wq cancellation and devm-based IRQ management do not mix well - there is
a short(?) time-window after the wq clean-up when IRQs are still not
freed and may schedule new work.

When both WQs and IRQs are managed by devm things are likely to just
work. WQs should be initialized before IRQs (when IRQs need to schedule
work) and devm unwinds things in "FILO" order.

This series implements delayed wq cancellation on top of devm and replaces
the obvious cases where only thing remove call-back in a driver does is
cancelling the work. There might be other cases where we could switch
more than just work cancellation to use managed version and thus get rid
of remove or mixed (manual and devm) resource management.

This RFC does also introduce include/linux/devm-helpers.h file which
hopefully works as a place where this kind of helpers can be inlined.

Please see previous discussion here:
RFC v1:
https://lore.kernel.org/lkml/cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com/

Changelog v2:
  - used correct terminology ("driver detach" instead of "exit, ...")
  - inlined the devm_delayed_work_autocancel() in a header
  - added Hans as a maintainer for the new header + myself as a reviewer
  - used devm_add_action() instead of using plain devres_add()

---

Matti Vaittinen (8):
  workqueue: Add resource managed version of delayed work init
  MAINTAINERS: Add entry for devm helpers
  extconn: Clean-up few drivers by using managed work init
  hwmon: raspberry-pi: Clean-up few drivers by using managed work init
  platform/x86: gpd pocket fan: Clean-up by using managed work init
  power: supply: Clean-up few drivers by using managed work init
  regulator: qcom_spmi-regulator: Clean-up by using managed work init
  watchdog: retu_wdt: Clean-up by using managed work init

 MAINTAINERS                                  |  6 +++
 drivers/extcon/extcon-gpio.c                 | 15 ++----
 drivers/extcon/extcon-intel-int3496.c        | 16 ++----
 drivers/extcon/extcon-palmas.c               | 17 +++----
 drivers/extcon/extcon-qcom-spmi-misc.c       | 17 +++----
 drivers/hwmon/raspberrypi-hwmon.c            | 17 +++----
 drivers/platform/x86/gpd-pocket-fan.c        | 17 +++----
 drivers/power/supply/axp20x_usb_power.c      | 15 ++----
 drivers/power/supply/bq24735-charger.c       | 18 +++----
 drivers/power/supply/ltc2941-battery-gauge.c | 20 +++-----
 drivers/power/supply/sbs-battery.c           | 16 ++----
 drivers/regulator/qcom_spmi-regulator.c      | 34 +++----------
 drivers/watchdog/retu_wdt.c                  | 22 +++-----
 include/linux/devm-helpers.h                 | 53 ++++++++++++++++++++
 14 files changed, 128 insertions(+), 155 deletions(-)
 create mode 100644 include/linux/devm-helpers.h


base-commit: a38fd8748464831584a19438cbb3082b5a2dab15
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
