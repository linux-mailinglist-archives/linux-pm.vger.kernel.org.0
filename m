Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB41E399A13
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 07:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhFCFmB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 01:42:01 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:35414 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhFCFmA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 01:42:00 -0400
Received: by mail-lf1-f43.google.com with SMTP id i10so7033929lfj.2;
        Wed, 02 Jun 2021 22:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=kAmYDA9B8u4qXmIFEnv8TZqko/i/6FI+mhj+YOHtFuY=;
        b=etABsJ1nXqV5x0B3hDqbsqokGKs9nibwtmyy7ntcUhQ9epA1VTCaeULppGxr3ISLi0
         b9elsA+gooSIJMKEhfhxg1C7D2mCuqOwHNOPC2W8LRAlEFSNeD661n7+AQE27sbjv4S2
         lhQ6qczFll5uLIk/9OfDyOa8SoSTt5UENIm1lHfuLvet8pcNTyhrhrMWfNLoaCZ5XeZE
         VdpZpQ7Etas7YXtCb9Oj34aJq7E1vwi2L4tVEF2lHTlSjprweEsEDuBG2fHNC644odlg
         zuolmIp0FKTrv5cAlktvD4rmxm3XnL9CGgHSvZZC3JerEJmrxwnGmbFn91rCiYwOnUBy
         M3Pg==
X-Gm-Message-State: AOAM531oHEgvNOEk6tFA0kZd5qlYmb5wJzCqI0jCNGYuoIwhBpl6YVY5
        2QnbqerHty5E8o4lKhekJDNRj6lwtFQ=
X-Google-Smtp-Source: ABdhPJwQA6WrayRbpewqWYwVujVgqYbwqwhJ5kVcLBaERrtC2E5bbWGIUPW337S8wPpwcFroA7Ze7g==
X-Received: by 2002:a05:6512:ba7:: with SMTP id b39mr2539006lfv.424.1622698814865;
        Wed, 02 Jun 2021 22:40:14 -0700 (PDT)
Received: from localhost.localdomain (dc7vkhyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16e2:8300::4])
        by smtp.gmail.com with ESMTPSA id w21sm237292ljo.41.2021.06.02.22.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 22:40:14 -0700 (PDT)
Date:   Thu, 3 Jun 2021 08:40:07 +0300
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
Subject: [PATCH RESEND v10 00/11] Extend regulator notification support
Message-ID: <cover.1622628333.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--PNTmBPCT7hxwcZjr
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

Changelog v10-RESEND:
   - rebased on v5.13-rc4
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


base-commit: 8124c8a6b35386f73523d27eacb71b5364a68c4c
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

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmC4ay0ACgkQeFA3/03a
ocXytQgAnZt7tJPjcieQAqsZD2bmAYFW+i1585kA000I7CT4opj93BNKVYTGnFKB
U6kofFHwY/sXcbbiyyivy7L3YMM6NCfCWehxnVDoUWaOIvmEPvKnt5p6oNyramFE
PUVvtentZEC4dhWVMH32C6JbrREtGemWzvcOxKgyavNbmMfZ2pXa6ENGX30tWWhg
162zXC3G782e8NEep2ErXT31aJ9zbprnDdmLljoaV15lmF8BEhsyglG1ORK2YdXq
wQ+/p5syL8nY841CuCFjHARxWkRHk6kKDZyKdma6GwK5R1GrtjIKcB0m3QG85cHt
CuEaDt3KdcbrUGRvb1lbfmo3ZnPPJg==
=g2sS
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
