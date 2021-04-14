Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28FA35EC7D
	for <lists+linux-pm@lfdr.de>; Wed, 14 Apr 2021 07:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347551AbhDNFwC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Apr 2021 01:52:02 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:36557 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbhDNFwB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Apr 2021 01:52:01 -0400
Received: by mail-lj1-f178.google.com with SMTP id o16so22001345ljp.3;
        Tue, 13 Apr 2021 22:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Doyc1lt05VOrNXozHzLk2uu5425SfA2G10eILYcXAXk=;
        b=VZusmvHxw1/zkQh6iPRr1Bqh3lf+Vwkq8LZ6xQq1wqlycrfIyEa5UUK/ZPisb7BbIk
         uEhQ9LmcYSrNv7k5uQm/iJdE2JSWQMiEpYMrmNRSbAboA7/MYXhy6Hnzx+grdRoOib7V
         KvrIuKULxtQGKDtQkgvuOV3f4kaO8jWmRSTM+G9ftdluraiQIDLYuIbYNtmvkF5Ib2RQ
         azfH9f/hCvGW6LpuOjiYTROsU/fj1Fg4pagX374MsQn77iX81hRPub8BkzyaKmLb1ax/
         V5NMWiAPvwIVzBvsbR29Q48LQSYewmWq3e8IMK3eG80AYB1P48Cnmvk6sx0pOnOU+8oL
         OfJQ==
X-Gm-Message-State: AOAM532Rs8A/GhME6FnI100X3tSa0kcsxtz/k8MlTGrddKVtyJCtddGt
        t4VZkfktUiliZuTDGr+9s+c=
X-Google-Smtp-Source: ABdhPJzfX/I5ZRyUwYVgE9b7Rk092eyo5XB/LAegjYBr3KPtOUiOtqFRWsilW18oNTUG/V/mwgZWLQ==
X-Received: by 2002:a2e:b4b4:: with SMTP id q20mr22643835ljm.45.1618379499206;
        Tue, 13 Apr 2021 22:51:39 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::6])
        by smtp.gmail.com with ESMTPSA id i9sm2681286lfu.86.2021.04.13.22.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 22:51:38 -0700 (PDT)
Date:   Wed, 14 Apr 2021 08:51:30 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "agross@kernel.org" <agross@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 0/9] Extend regulator notification support
Message-ID: <cover.1618377272.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Extend regulator notification support

This series extends the regulator notification and error flag support.
Initial discussion on the topic can be found here:
https://lore.kernel.org/lkml/6046836e22b8252983f08d5621c35ececb97820d.camel@fi.rohmeurope.com/

This series is built on top of the BD9576MUF support patch series v9
which is currently in MFD tree at immutable branch ib-mfd-watchdog-5.13
https://lore.kernel.org/lkml/cover.1615219345.git.matti.vaittinen@fi.rohmeurope.com/
(The series should apply without those patches but there is compile time
dependency to definitions brought in at the last patch of the BD9576
series. This should be Ok though as there is a Kconfig dependency in
BD9576 regulator driver)

In a nutshell - the series adds:

1. WARNING level events/error flags. (Patch 3)
  Current regulator 'ERROR' event notifications for over/under
  voltage, over current and over temperature are used to indicate
  condition where monitored entity is so badly "off" that it actually
  indicates a hardware error which can not be recovered. The most
  typical hanling for that is believed to be a (graceful)
  system-shutdown. Here we add set of 'WARNING' level flags to allow
  sending notifications to consumers before things are 'that badly off'
  so that consumer drivers can implement recovery-actions.
2. Device-tree properties for specifying limit values. (Patches 1, 5)
  Add limits for above mentioned 'ERROR' and 'WARNING' levels (which
  send notifications to consumers) and also for a 'PROTECTION' level
  (which will be used to immediately shut-down the regulator(s) W/O
  informing consumer drivers. Typically implemented by hardware).
  Property parsing is implemented in regulator core which then calls
  callback operations for limit setting from the IC drivers. A
  warning is emitted if protection is requested by device tree but the
  underlying IC does not support configuring requested protection.
3. Helpers which can be registered by IC. (Patch 4)
  Target is to avoid implementing IRQ handling and IRQ storm protection
  in each IC driver. (Many of the ICs implementin these IRQs do not allow
  masking or acking the IRQ but keep the IRQ asserted for the whole
  duration of problem keeping the processor in IRQ handling loop).
4. Emergency poweroff function (refactored out of the thermal_core to
  kernel/reboot.c) which is called if IC fires error IRQs but IC reading
  fails and given retry-count is exceeded. (Patches 2, 4)
  Please note that the mutex in the emergency shutdown was replaced by a
  spinlock to allow calls from any context.

The helper was attempted to be done so it could be used to implement
roughly same logic as is used in qcom-labibb regulator. This means
amongst other things a safety shut-down if IC registers are not readable.
Using these shut-down retry counters are optional. The idea is that the
helper could be also used by simpler ICs which do not provide status
register(s) which can be used to check if error is still active.

ICs which do not have such status register can simply omit the 'renable'
callback (and retry-counts etc) - and helper assumes the situation is Ok
and re-enables IRQ after given time period. If problem persists the
handler is ran again and another notification is sent - but at least the
delay allows processor to avoid IRQ loop.

Patch 7 takes this notification support in use at BD9576MUF.
Patch 8 is related to MFD change which is not really related to the RFC
here. It was added to this series in order to avoid potential conflicts.
Patch 9 adds a maintainers entry.

Changelog v7:
  general:
   - rebased on v5.12-rc7
   - new patch for refactoring the hw-failure reboot logic out of
     thermal_core.c for others to use.
  notification helpers:
   - fix regulator error_flags query
   - grammar/typos
   - do not BUG() but attempt to shut-down the system
   - use BITS_PER_TYPE()

Changelog v6:
  Add MAINTAINERS entry
  Changes to IRQ notifiers
   - move devm functions to drivers/regulator/devres.c
   - drop irq validity check
   - use devm_add_action_or_reset()
   - fix styling issues
   - fix kerneldocs

Changelog v5:
   - Fix the badly formatted pr_emerg() call.

Changelog v4:
   - rebased on v5.12-rc6
   - dropped RFC
   - fix external FET DT-binding.
   - improve prints for cases when expecting HW failure.
   - styling and typos

Changelog v3:
  Regulator core:
   - Fix dangling pointer access at regulator_irq_helper()
  stpmic1_regulator:
   - fix function prototype (compile error)
  bd9576-regulator:
   - Update over current limits to what was given in new data-sheet
     (REV00K)
   - Allow over-current monitoring without external FET. Set limits to
     values given in data-sheet (REV00K).

Changelog v2:
  Generic:
  - rebase on v5.12-rc2 + BD9576 series
  - Split devm variant of delayed wq to own series
  Regulator framework:
  - Provide non devm variant of IRQ notification helpers
  - shorten dt-property names as suggested by Rob
  - unconditionally call map_event in IRQ handling and require it to be
    populated
  BD9576 regulators:
  - change the FET resistance property to micro-ohms
  - fix voltage computation in OC limit setting

--

Matti Vaittinen (9):
  dt_bindings: Add protection limit properties
  reboot: thermal: Export hardware protection shutdown
  regulator: add warning flags
  regulator: IRQ based event/error notification helpers
  regulator: add property parsing and callbacks to set protection limits
  dt-bindings: regulator: bd9576 add FET ON-resistance for OCW
  regulator: bd9576: Support error reporting
  regulator: bd9576: Fix the driver name in id table
  MAINTAINERS: Add reviewer for regulator irq_helpers

 .../bindings/regulator/regulator.yaml         |   82 ++
 .../regulator/rohm,bd9576-regulator.yaml      |    6 +
 MAINTAINERS                                   |    4 +
 drivers/regulator/Makefile                    |    2 +-
 drivers/regulator/bd9576-regulator.c          | 1060 +++++++++++++++--
 drivers/regulator/core.c                      |  151 ++-
 drivers/regulator/devres.c                    |   52 +
 drivers/regulator/irq_helpers.c               |  394 ++++++
 drivers/regulator/of_regulator.c              |   58 +
 drivers/regulator/qcom-labibb-regulator.c     |   10 +-
 drivers/regulator/qcom_spmi-regulator.c       |    6 +-
 drivers/regulator/stpmic1_regulator.c         |   20 +-
 drivers/thermal/thermal_core.c                |   63 +-
 include/linux/reboot.h                        |    1 +
 include/linux/regulator/consumer.h            |   14 +
 include/linux/regulator/driver.h              |  176 ++-
 include/linux/regulator/machine.h             |   26 +
 kernel/reboot.c                               |   86 ++
 18 files changed, 2006 insertions(+), 205 deletions(-)
 create mode 100644 drivers/regulator/irq_helpers.c


base-commit: d434405aaab7d0ebc516b68a8fc4100922d7f5ef
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
