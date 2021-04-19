Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA96D3640C9
	for <lists+linux-pm@lfdr.de>; Mon, 19 Apr 2021 13:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238757AbhDSLq4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 07:46:56 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:35762 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbhDSLqz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 07:46:55 -0400
Received: by mail-lf1-f41.google.com with SMTP id x19so25031242lfa.2;
        Mon, 19 Apr 2021 04:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=csinPoTaCo7rcZR2SWzaW1hy6+ig+dzxAWVbcMRVY70=;
        b=QfDez/UM/Erf14l+pzGDZ1S3Nk7evslDSKQOmU8jP4Ne/b2KzVjKGcBtS74bkCeXGM
         8plrXTNq9eO2YWwZ0lPbCqPj4WqA1nBbsLG48PSivXxmESoqo3kjrK7HglBrxnAirD43
         eutUNCiyvTSxqAzEzKrXKJVxcNz3vO3EEW19aprSHIpp++bMfybMcGowXiyG31znfVQp
         nKSIScGcEinsArgqRneY38HJboshfkA/zeu/NJ+AutXlxAoA6PIYrJDQ2xiPaDb1Et0n
         Qi9hpq4ajiiNLs0h+nEPPnXbZgFvTVAffgGaNnbY2eNQ8QhCaSu/pOsPrbwQI3t64xbi
         lXtw==
X-Gm-Message-State: AOAM532/8DeOZydiWz03fL6/9bkyWGIILioWAPs+F4vPpHVxOPpfwc4F
        0zoRfojluwjpHmpbxywRPmI=
X-Google-Smtp-Source: ABdhPJz0k1Io7JGCc9o9ZhxTQn2jxxu2zFe2Fb9aPz78WPzG18BWbcx/WqZDPVL2tO4SV4pl02Bo+A==
X-Received: by 2002:a05:6512:358b:: with SMTP id m11mr7695146lfr.179.1618832783166;
        Mon, 19 Apr 2021 04:46:23 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::6])
        by smtp.gmail.com with ESMTPSA id n2sm1806249lfu.24.2021.04.19.04.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 04:46:22 -0700 (PDT)
Date:   Mon, 19 Apr 2021 14:46:14 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
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
Subject: [PATCH v8 00/10] Extend regulator notification support
Message-ID: <cover.1618832466.git.matti.vaittinen@fi.rohmeurope.com>
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
  simple atomic in order to allow call from any context.

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

Changelog v8:
   - split shutdown API adding and thermal core taking it in use to
     own patches.
   - replace the spinlock with atomic when ensuring the emergency
     shutdown is only called once.
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

Matti Vaittinen (10):
  dt_bindings: Add protection limit properties
  reboot: Add hardware protection power-off
  thermal: Use generic HW-protection shutdown API
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
 kernel/reboot.c                               |   80 ++
 18 files changed, 2000 insertions(+), 205 deletions(-)
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
