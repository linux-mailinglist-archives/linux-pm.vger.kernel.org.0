Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE4E346021
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 14:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhCWNto (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 09:49:44 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:42655 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhCWNtb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 09:49:31 -0400
Received: by mail-lj1-f175.google.com with SMTP id 184so25677965ljf.9;
        Tue, 23 Mar 2021 06:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=mFWNgc1FW5QaVvw/wsJgMcMblBrOgtay4PdG9vIWiv0=;
        b=FvVyVQVsLQoE4k5/J1DM8EN5nXrnEwwGou+LREOttVV++wOuq/w19+yy6kvngoIypl
         b2hwIJqaId0vkehPrAKTy3mmSYFPjdQsLzTD+O3b8SJOKWhz7/ehXJBAduY63o/xCXKF
         ctl9Bt7CHW66JZ2Lk/sFc+8M762u/3aFRA0hhhgWKxAw8WF8gAIZBRawgRKvS0LFKuxO
         jb5oloSGf0EE0N4VpkeO4qYcZEdWrqQQfmN8Kparl2f+w6ZQ6d5xAEBZiwTsTb/onUvW
         O38yvciw4SEqBawanEGzOCOT5KPhBfubQZukp1IvM3p0Pj+mncdXDMIe3P/XHqzJN3f4
         /6Ug==
X-Gm-Message-State: AOAM5321c8uPfPcT0FIM4pKrkY04Hx2jMHvLvmOAjLAm7Dm3ayjPBn+K
        ykfyp6vFGVJLM2rNWf1jg+E=
X-Google-Smtp-Source: ABdhPJzCrYWUnFHopBuwoTQCnEVSaGjYd/0HCeCkwyJiUJo8kLjKK212FjDHsyFBrcl4geyYwMfp3w==
X-Received: by 2002:a2e:9b4a:: with SMTP id o10mr3196706ljj.485.1616507369334;
        Tue, 23 Mar 2021 06:49:29 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::2])
        by smtp.gmail.com with ESMTPSA id i30sm1079430lfj.206.2021.03.23.06.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:49:28 -0700 (PDT)
Date:   Tue, 23 Mar 2021 15:49:21 +0200
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
Subject: [PATCH v3 0/8] Add managed version of delayed work init
Message-ID: <cover.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
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

The series introduces include/linux/devm-helpers.h file which
hopefully works as a place where this kind of helpers can be inlined.

Please see previous discussion here:
RFC v1:
https://lore.kernel.org/lkml/cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com/

Changelog v3:
  - Dropped RFC as advieced by Greg.
  - No functional changes.

Changelog RFC v2 resend:
  - rebased on 5.12-rc4

Changelog RFC v2:
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
