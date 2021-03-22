Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B75343AD4
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 08:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCVHlx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 03:41:53 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:33504 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhCVHlW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 03:41:22 -0400
Received: by mail-lf1-f41.google.com with SMTP id o126so10183250lfa.0;
        Mon, 22 Mar 2021 00:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9OvoXTfYE4NotW19A5lNKAEwdwJKknjVSZLpfYohfiw=;
        b=VzC4FcgfWmpRvAY1ZjHnkHhhR8pff7riEIOnn1jcmr1/jknLwznzqfD5EvK9rTzPmz
         r5lRU3/ht0h/yFd/8CklvGrYUFFWmL96EJ06jQEueph3puBRPRI2bKDvIS8l1fDm9ayW
         FGUDlj+3m8e8Nf4KpR/D363tYrcuJVQJe7DmMJ5hvjB4No4GtqkN/4fQIGnt1nDvT2pd
         +jtBZy7FEPhbDKiA5J7JpQhJuIgdToSoV5PkUlT9dPzGqwSVfNEtYNFwAWwCGVEBQADa
         ulCEJXHxauGfA4o8vazsS0J1csuLPfyK68+MVK34LKvGTpOzxfnbQkTl7zM66zhcfhDG
         g2Iw==
X-Gm-Message-State: AOAM530jBzBA1RB7NXgnpIxqR2eB6/u71YdWGjDJtjtIHjVEtDyVNFYF
        eGNrXxJDp2rp1zUIiJ2IOEA=
X-Google-Smtp-Source: ABdhPJzjl/BCA7ObW6HNjx3diUaqpRbdVbzl+Zwdos1ACNDo5uSXH9iWMVBGSZK7KTlvXmN4GMDRew==
X-Received: by 2002:ac2:5519:: with SMTP id j25mr8615753lfk.220.1616398879758;
        Mon, 22 Mar 2021 00:41:19 -0700 (PDT)
Received: from localhost.localdomain (mobile-access-5673b7-246.dhcp.inet.fi. [86.115.183.246])
        by smtp.gmail.com with ESMTPSA id y4sm1472866lfj.254.2021.03.22.00.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 00:41:19 -0700 (PDT)
Date:   Mon, 22 Mar 2021 09:41:13 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
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
Subject: [RFC RESEND PATCH v2 0/8] Add managed version of delayed work init
Message-ID: <cover.1616395565.git.matti.vaittinen@fi.rohmeurope.com>
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

Changelog v2 resend:
  - rebased on 5.12-rc4

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


base-commit: 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b
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
