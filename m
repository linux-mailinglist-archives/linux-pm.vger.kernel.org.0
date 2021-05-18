Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E7A387769
	for <lists+linux-pm@lfdr.de>; Tue, 18 May 2021 13:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhERL0Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 May 2021 07:26:16 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:45794 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhERL0P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 May 2021 07:26:15 -0400
Received: by mail-lj1-f172.google.com with SMTP id v5so11080384ljg.12;
        Tue, 18 May 2021 04:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8BRXyRfE+/lPf97nYNK6cOdKGSM5fWZ0jFB495vj08U=;
        b=hvxLyoytvnh1vZDahymnghmhqSE4LjQQ+BxEiyPnA2uc9zeStoSEADbngi7a4YOPs1
         BIutMYdnowVAXCDuI3cvZQDZTKDtvZrfYo4/GvQxR21bepoBOktfyR5rcKOB2Uw4tMaT
         xkJpZxNB6nUWPJv7pA3rJL8LusbWOPbhOROBTeffGdRjGFclvGox4pZtUhVGSu1KoBDG
         xZ/oeHkWDs8TVJTJ0dBkXMIFhPjYCksBzgRfHFRU0jeEEvb62O4qzGD5tZib+67zU9wk
         k7yqI9l9FLnWFp6CIPhv+TZOnBJrSOqUGavHaL/UMXc5g/tfISS5Sb4tNpgOKH9HMLiy
         j/4w==
X-Gm-Message-State: AOAM5339UPq/QR4updTWLeeRYLv+NnfDVEKYvjspgoqN6z35S1jaTl9Z
        UZrlLyhRlnaoxPgRLtoHo74=
X-Google-Smtp-Source: ABdhPJzTEJp5UdXTIPwaXgHAm6mHZqBw7Tyea8XoFb6j2CXSb5HSytSsrhqwBJmQrl5HM6tjWxc/ew==
X-Received: by 2002:a2e:a167:: with SMTP id u7mr3629436ljl.495.1621337095294;
        Tue, 18 May 2021 04:24:55 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::1])
        by smtp.gmail.com with ESMTPSA id i20sm2244813lfv.71.2021.05.18.04.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 04:24:54 -0700 (PDT)
Date:   Tue, 18 May 2021 14:24:47 +0300
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
Subject: [PATCH v10 00/11] Extend regulator notification support
Message-ID: <cover.1621333893.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Extend regulator notification support

This series extends the regulator notification and error flag support.
Initial discussion on the topic can be found here:
https://lore.kernel.org/lkml/6046836e22b8252983f08d5621c35ececb97820d.camel=
@fi.rohmeurope.com/

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

Changelog v10:
   - rebased on v5.13-rc2
   - Move rdev_*() print macros to the internal.h and use rdev_dbg()
     from irq_helpers.c
   - Export rdev_get_name() and move it from coupler.h to driver.h for
     others to use. (It was already in coupler.h but not exported -
     usage was limited and coupler.h does not sound like optimal place
     as rdev_name is not only used by coupled regulators)
   - Send all regulator notifications from irq_helpers.c at one OR'd
     event for the sake of simplicity. For BD9576 this does not matter
     as it has own IRQ for each event case. Header defining events says
     they may be OR'd.
   - Change WARN() at protection shutdown to pr_emerg as suggested by
     Petr.
Changelog v9:
   - rebases on v5.13-rc1
   - Update thermal documentation
   - Fix regulator notification event number
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

Matti Vaittinen (11):
  dt_bindings: Add protection limit properties
  reboot: Add hardware protection power-off
  thermal: Use generic HW-protection shutdown API
  regulator: add warning flags
  regulator: move rdev_print helpers to internal.h
  regulator: IRQ based event/error notification helpers
  regulator: add property parsing and callbacks to set protection limits
  dt-bindings: regulator: bd9576 add FET ON-resistance for OCW
  regulator: bd9576: Support error reporting
  regulator: bd9576: Fix the driver name in id table
  MAINTAINERS: Add reviewer for regulator irq_helpers

 .../bindings/regulator/regulator.yaml         |   82 ++
 .../regulator/rohm,bd9576-regulator.yaml      |    6 +
 .../driver-api/thermal/sysfs-api.rst          |   24 +-
 MAINTAINERS                                   |    4 +
 drivers/regulator/Makefile                    |    2 +-
 drivers/regulator/bd9576-regulator.c          | 1054 +++++++++++++++--
 drivers/regulator/core.c                      |  163 ++-
 drivers/regulator/devres.c                    |   52 +
 drivers/regulator/internal.h                  |   11 +
 drivers/regulator/irq_helpers.c               |  397 +++++++
 drivers/regulator/of_regulator.c              |   58 +
 drivers/regulator/qcom-labibb-regulator.c     |   10 +-
 drivers/regulator/qcom_spmi-regulator.c       |    6 +-
 drivers/regulator/stpmic1_regulator.c         |   20 +-
 drivers/thermal/thermal_core.c                |   63 +-
 include/linux/reboot.h                        |    1 +
 include/linux/regulator/consumer.h            |   14 +
 include/linux/regulator/coupler.h             |    5 -
 include/linux/regulator/driver.h              |  186 ++-
 include/linux/regulator/machine.h             |   26 +
 kernel/reboot.c                               |   79 ++
 21 files changed, 2030 insertions(+), 233 deletions(-)
 create mode 100644 drivers/regulator/irq_helpers.c


base-commit: d07f6ca923ea0927a1024dfccafc5b53b61cfecc
--=20
2.25.4


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmCjo/AACgkQeFA3/03a
ocVZDAgAleBW9ZiN6uLa1j337BvbdTonJLEg9vdNBDzmNez6HRG2Smap0OJNhoiM
vvIHMV0xSK6jSWtDOr60rDqT8dKMpJ5j/sqNhsDqS59w0Z5jV3Fhjmvo/mL5jsCw
vgaoA9tQByFOlMWavEyNmadqejsIPX0EdWZPQHe5cVNKvUUMFILKzd3oaxq/S38I
SYl5qMDPtW9aCAOHLtP5GKySHyuZF/bG8eYHkQNELAgUQ70AKyx9WDCEhrzv6/Wl
GQ8gCLkUKg75Ufe/KetGliz9JFmIrN0B2Ciq56Xw8Bjr2IGQKzQ1/G5RAH4whoZj
kA0Hpk9a9hgWq1iztGpoxvOkhejFZg==
=dZB2
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
