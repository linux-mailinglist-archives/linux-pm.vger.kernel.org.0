Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600FC453213
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 13:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbhKPM1R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 07:27:17 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:47074 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbhKPM1M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 07:27:12 -0500
Received: by mail-lj1-f172.google.com with SMTP id e11so42792245ljo.13;
        Tue, 16 Nov 2021 04:24:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nwXPLfuXNs4r/4M323hMt8HZvJdI500wmNneRu9EdJs=;
        b=3kfQ0CaOwTOsttqbVu4HxRuDStQgYWbxZ2k+1Bj5FFpx9hSzYoYbT8IgElA6YdI5AD
         wThtyAqqiyTbB3ctQys46RS+HiKnAPEOI4XzVs/Na3ptjqVkuNjA5xqkd2G1NeFEqeFk
         l8JLpuwSweepax/kR+eyFnG+eQaVvBXBOjSPKcrwZ+S6ZOGz6qtVuDR18Nk+/EulR5M8
         Y4xpz/Hh4uuaNziNB7kckAmnKrShweJSmbX9oS9uzbVzMB3VQKpJrVU0rf12X4MrwMBM
         nOYmXncsfDTRcl6GPeTOAAC9ayyg2Kezj6SLtYTeDKOukG7C/xu2mv6/btyKdOY0E0H0
         ruWA==
X-Gm-Message-State: AOAM532xXW3neaZR846bmQEijeBBtXqCKo3si6Y06/Tut5BLwRv5IE29
        Ga22S/Pxn/zRS3sNw0oARJk=
X-Google-Smtp-Source: ABdhPJxeOb8ZhaC7ZWfhkLirFwlmLfcypzLHupToDHjHuAXtZbFv2xGNAzxsogSAOyOeHTXSPitRVQ==
X-Received: by 2002:a05:651c:54d:: with SMTP id q13mr6685924ljp.498.1637065454297;
        Tue, 16 Nov 2021 04:24:14 -0800 (PST)
Received: from fedora (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id o1sm1822192ljg.130.2021.11.16.04.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:24:13 -0800 (PST)
Date:   Tue, 16 Nov 2021 14:24:06 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, rostokus@gmail.com,
        fan.chen@mediatek.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [RFC PATCH v3 0/9] power: supply: Add some fuel-gauge logic
Message-ID: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HOenYRA7r8rtk9BF"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--HOenYRA7r8rtk9BF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

As usual, I picked you as recipients just because I assumed
you could have something to say in here. Again, please let me know
if you wish to be dropped from CC if this gets any further.

power: supply: add simple-gauge for SOC estimation and CC correction

This RFC has received some testing under qemu, with recorded
battery-data and a dummy MFD driver converting the battery-data to
register-values for BD71815 PMIC driver. The testing has not really
covered a lot though. Some tests are also ran on a BeagleBoneBlack
connected to a real PMIC hwrdware - but unfortunately without a real
battery. So - this is still not tested too well.

Regarding the purpose of this RFC:

Patches 1 - 6
I hope that the patches which change the power-supply class for static
battery node information  could be properly reviewed and perhaps even
considered to be merged upstream. It'd be great if someone had the time
to test those in real HW to ensure existing stuff is not borked.
Especially the patches 4 and 6 might be of interest.

The patch 7:
This adds some simple fuel-gauge logic in kernel. I think this is
getting it's shape - but may have few hiccups left - and could benefit
=66rom suggestions how to run the gauge thread. A few downstream setups do
use separate ROHM drivers for BD71815, BD71817, BD71827, BD71828 and
BD71879 which all contain similar fuel-gauge logic to what is implented
in simple-gauge. They poll the PMIC and compute the temperature/capacity
and zero-corrected "state of charge" and report that to the user-space.
Additionally those drivers 'calibrate' the CC based on OCV when battery
is relaxed - or when battery is fully charged. The patch 7 attempts to
make this logic generic and allows IC drivers to fill the IC specific
operations.

It is fair to say that I don't know the user-space software which is
utilizing the existing drivers - or why the SoC computation is
originally placed in-kernel. I can only assume the existing IC users
might have a bit wider smile if the SOC was reported by the kernel also
in the future.

Patches 8 and 9:
The patches 8 and 9 bring in IC level support for ROHM BD71815 and BD71828
PMIC charger IPs. It is also fairly trivial to extend the support to
ND71827 and BD71879 later. The state of these patches is not final yet,
I don't expect them to be thoroughly reviewed yet. They are provided to
give some more context.

Changelog RFC v3:
  - rename sw-gauge to simple-gauge
  batinfo:
     - kerneldoc fixes
     - add batinfo getters usable prior supply registration
     - Add constant battery aging degradation to batinfo
  simple-gauge:
      - use devm_add_action_or_reset
      - Rename to simple_gauge
      - Limit access to power_supply parameters
      - Introduce simple_gauge_drvdata
      - no need to show simple_gauge at config menu. Users should just SELE=
CT it.
      - allow tristate
      - Add blocking 'iteration run' - loop.
      - updated the comment section
      - Fixed clamped SOC which was not updated
      - Small comment improvements
      - Don't allow negative CC after computing capacity corrections
      - Fix gauge looping when last client exits
 ROHM ic-drivers:
      - Updated BD71815 IRQ information
      - adapt to simple_gauge parameter changes
      - Initial BD71815 support
      - Use drvdata properly.
      - Sort includes
      - Prepare to provide dcin_collapse voltage from DT
      - clean unused defines
      - use OCV tables from batinfo if module params not given
      - do not directly call bd71827_voltage_to_capacity from calibration
        but use provided operation.
      - Mask the power-state from relax-condition on BD71815 as is done by
        the ROHM driver. REX state is used to do OCV =3D> SOC conversion
        when battery is relaxed even if REX_CC was not used.
      - Clarify that we require either the module params or DT values for
        battery. Fail probe if parameters are not given.
      - Utilize degrade_cycle_uah aging degradation.
      - Get battery max and min values either as module parameters or from
        static battery node at DT.
      - Allow giving the zero correction threshold as a module param or
        compute it as 10% of "remaining battery voltage" based on max and
        min voltages given via DT.
      - Add proper MODULE_ALIAS
      - Implement VDR table reading from DT
      - Do not require fixed amount of battery parameters
      - Fix Coulomb Counter to uAh conversion
      - Fix endianess related warnings
      - clean-up comment
      - Avoid dividing by zero at VDR computation
      - Use the fwnode API instead of of_* API
      . don't assume 32bit int
      - Fix IC type prints
      - Fix the current sense resistor DT property *-ohm =3D> *-ohms

Changelog RFC v2:
 - lots of logic fixes.
 - rechecked units
 - changed low-voltage correction to capacity correction
 - added first draft of IC driver which could use the swgauge

---

Matti Vaittinen (9):
  dt-bindings: battery: Add temperature-capacity degradation table
  power: supply: add cap2ocv batinfo helper
  power: supply: Support DT originated temperature-capacity tables
  power: supply: Add batinfo getters usable prior supply registration
  power: supply: Add constant battery aging degradation to batinfo
  power: supply: Add batinfo functions for OCV to SOC with 0.1% accuracy
  power: supply: add simple-gauge for SOC estimation and CC correction
  mfd: bd71828, bd71815 prepare for power-supply support
  power: supply: Add bd718(15/27/28/78) charger driver

 .../bindings/power/supply/battery.yaml        |   19 +
 drivers/mfd/rohm-bd71828.c                    |   42 +-
 drivers/power/supply/Kconfig                  |   14 +
 drivers/power/supply/Makefile                 |    2 +
 drivers/power/supply/bd71827-power.c          | 2473 +++++++++++++++++
 drivers/power/supply/power_supply_core.c      |  449 ++-
 drivers/power/supply/simple-gauge.c           | 1303 +++++++++
 include/linux/mfd/rohm-bd71827.h              |  295 ++
 include/linux/mfd/rohm-bd71828.h              |   65 +
 include/linux/mfd/rohm-generic.h              |    2 +
 include/linux/power/simple_gauge.h            |  244 ++
 include/linux/power_supply.h                  |   41 +
 12 files changed, 4843 insertions(+), 106 deletions(-)
 create mode 100644 drivers/power/supply/bd71827-power.c
 create mode 100644 drivers/power/supply/simple-gauge.c
 create mode 100644 include/linux/mfd/rohm-bd71827.h
 create mode 100644 include/linux/power/simple_gauge.h

--=20
2.31.1


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

--HOenYRA7r8rtk9BF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmGTos8ACgkQeFA3/03a
ocXImAgAnxiVYJM0qSBRFNkSeBT3fSVTqeD8jkry5KgUJHj8UXrUyBszpxgkdunW
652pADFgox2nc1z5ZSA4tpYV2KuArQchQOBw2joFmGIfPbS7IKiJrN/V5IPvIzlZ
i/BCGYP6J3RR7M14GZMiOn5SI/sJFXwcwnvF8OkcYTto1AbzknLbMXhaLJ7xRdOK
5n9QXXRa0IZ6dgO30Hp5m12yi9aFmMjivDtt4StE0bEhz7aamsQTZTGUA5nFLpHe
QGHeafqTNLrWBtdQ9e5bwMH6PSU4d09IKkgxsyC11tBeYD6lsXC3S68Ozi5JHtmN
TUMENyxRd8ZaQ6WqTpMNk1eZim2Ikw==
=2+sv
-----END PGP SIGNATURE-----

--HOenYRA7r8rtk9BF--
