Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9612F4436D0
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 20:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhKBT5k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 2 Nov 2021 15:57:40 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:43701 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhKBT5k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Nov 2021 15:57:40 -0400
Received: by mail-ot1-f47.google.com with SMTP id n13-20020a9d710d000000b005558709b70fso398152otj.10;
        Tue, 02 Nov 2021 12:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ojYC7+8pGFnZez1RENadAM+0s5So3cR5+id4A+VoJoc=;
        b=pFhnvWQlUdTvLvzcDVQ4aMHgaccBOIpef7APqXmp9BO5rL2anFDnhcmufuWPTIFyy3
         M0BNKlxUmfAcbFwDRntyW2zUBi8Jhkl5ZLFS7arqrFiCBIT+3p6gZEeSO+0tDi4lDkuH
         xTaG1S+OZZDpDQi0PqdrsWyBKzT4RqikyMUVRhaU2n/3ujzYDOQph1xYjSJP24tnNFfL
         O24MblaKa9iNzjinFzifcuwJWy4Ike68fuSl2zvU4SlXcmeqoL7riDiJJOwYwPSthIPV
         kejKg7IIT2HPvYKH9hrEcW/TiVSEEIaUug6bSTo8BHy5KoIGr0XnFt6plOT1UQyFIbF0
         ebKA==
X-Gm-Message-State: AOAM533J4Diys3uBbFpdfxro+cE20ZgaEIGu+c6iYFOVRkHn/b/1Q5Dh
        JqIYdFJPjQhb1E83S/nYxbjVk+m3oQX9v/yfOV0=
X-Google-Smtp-Source: ABdhPJxC8mUQcbN0cZIfkBuCiruN+G2E1uSf46kVS2G6wx/9mvo1rXtuSTkxn2gQ76xQom0dd8CM/lhlQI+Eu0u28pk=
X-Received: by 2002:a05:6830:1af0:: with SMTP id c16mr27297046otd.16.1635882904555;
 Tue, 02 Nov 2021 12:55:04 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Nov 2021 20:54:53 +0100
Message-ID: <CAJZ5v0hnj0zCXsZy0=Ukud3U_cn054GULmHmpz7Qrpg_TkLLqA@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v5.16-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-5.16-rc1

with top-most commit 46e9f92f31e67385fab8b49c030635415f36b362

 Merge branches 'thermal-int340x', 'thermal-powerclamp' and 'thermal-docs'

on top of commit 3906fe9bb7f1a2c8667ae54e967dc8690824f4ea

 Linux 5.15-rc7

to receive thermal control updates for 5.16-rc1.

These extend the thermal trip point crossing notifications sent via
netlink to contain the temperature causing the trip point to be
crossed, deprecate the user space thermal governor, add new DT
bindings to drivers, move ABI documentation to Documentation/ABI,
fix assorted issues and clean up code.

Specifics:

 - Constify a variable in thermal MMIO driver (Rikard Falkeborn).

 - Add the current temperature in the netlink message when crossing a
   trip point in order to prevent useless back and forth reading from
   userspace (Daniel Lezcano).

 - Add support for the 'HC' variant on PM8998 PMIC in order to support
   VADC channels on recent QCom boards (Bjorn Andersson).

 - Add support for calibration values from hardware when they are
   fused (Niklas Söderlund).

 - Fix NULL pointer dereference in the thermal_release callback when
   an error occurs in the thermal_zone_device_register() (Yuanzheng
   Song).

 - Fix use-after-free in __thermal_cooling_device_register() in the
   error path (Ziyang Xuan).

 - Fix compilation of the LMh driver when CONFIG_QCOM_SCM is not set
   (Jackie Liu).

 - Add timeout when reading a register that can block forever in
   certain circumstances in the tsens driver (Ansuel Smith).

 - Add DT binding for the reset lines and use them in the rockchip
   sensor driver (Johan Jonker).

 - Add new uniphier NX1 SoC temperature sensor (Kunihiko Hayashi).

 - Save and restore the TCC value in the int340x driver (Antoine
   Tenart).

 - Deprecate the writability of the cooling device state sysfs file
   and the user space governor (Daniel Lezcano).

 - Delete bogus length check in int340x (Dan Carpenter).

 - Use bitmap_zalloc/bitmap_free when applicable in intel_powerclamp
   (Christophe JAILLET).

 - Move thermal ABI documentation to Documentation/ABI (Mauro Carvalho
   Chehab).

Thanks!


---------------

Ansuel Smith (1):
      thermal/drivers/tsens: Add timeout to get_temp_tsens_valid

Antoine Tenart (1):
      thermal/drivers/int340x: Improve the tcc offset saving for suspend/resume

Bjorn Andersson (2):
      dt-bindings: thermal: qcom: add HC variant of adc-thermal monitor bindings
      thermal/drivers/qcom/spmi-adc-tm5: Add support for HC variant

Christophe JAILLET (1):
      thermal: intel_powerclamp: Use bitmap_zalloc/bitmap_free when applicable

Dan Carpenter (1):
      thermal: int340x: delete bogus length check

Daniel Lezcano (3):
      thermal/drivers/netlink: Add the temperature when crossing a trip point
      thermal/core: Make the userspace governor deprecated
      thermal/core: Deprecate changing cooling device state from userspace

Jackie Liu (1):
      thermal/drivers/qcom/lmh: make QCOM_LMH depends on QCOM_SCM

Johan Jonker (3):
      dt-bindings: thermal: allow more resets for tsadc node in
rockchip-thermal.yaml
      dt-bindings: thermal: remove redundant comments from rockchip-thermal.yaml
      thermal/drivers/rockchip_thermal: Allow more resets for tsadc node

Kunihiko Hayashi (2):
      dt-bindings: thermal: uniphier: Add binding for NX1 SoC
      thermal/drivers/uniphier: Add compatible string for NX1 SoC

Mauro Carvalho Chehab (1):
      thermal: Move ABI documentation to Documentation/ABI

Niklas Söderlund (2):
      thermal: rcar_gen3_thermal: Store thcode and ptat in priv data
      thermal: rcar_gen3_thermal: Read calibration from hardware

Rikard Falkeborn (1):
      thermal/drivers/thermal_mmio: Constify static struct thermal_mmio_ops

Yuanzheng Song (1):
      thermal/core: Fix null pointer dereference in thermal_release()

Ziyang Xuan (1):
      thermal/core: fix a UAF bug in __thermal_cooling_device_register()

---------------

 Documentation/ABI/testing/sysfs-class-thermal      | 259 +++++++++++++++++++++
 .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml      | 149 ++++++++++++
 .../bindings/thermal/rockchip-thermal.yaml         |  23 +-
 .../thermal/socionext,uniphier-thermal.yaml        |   1 +
 Documentation/driver-api/thermal/sysfs-api.rst     | 225 +-----------------
 MAINTAINERS                                        |   2 +
 drivers/thermal/gov_user_space.c                   |   9 +
 .../intel/int340x_thermal/int3400_thermal.c        |   9 +-
 .../intel/int340x_thermal/int3401_thermal.c        |   8 +-
 .../int340x_thermal/processor_thermal_device.c     |  36 ++-
 .../int340x_thermal/processor_thermal_device.h     |   1 +
 .../int340x_thermal/processor_thermal_device_pci.c |  18 +-
 .../processor_thermal_device_pci_legacy.c          |   8 +-
 drivers/thermal/intel/intel_powerclamp.c           |   8 +-
 drivers/thermal/qcom/Kconfig                       |   2 +-
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |  41 +++-
 drivers/thermal/qcom/tsens.c                       |  29 ++-
 drivers/thermal/rcar_gen3_thermal.c                | 113 ++++++---
 drivers/thermal/rockchip_thermal.c                 |   2 +-
 drivers/thermal/thermal_core.c                     |  22 +-
 drivers/thermal/thermal_mmio.c                     |   2 +-
 drivers/thermal/thermal_netlink.c                  |  11 +-
 drivers/thermal/thermal_netlink.h                  |   8 +-
 drivers/thermal/thermal_sysfs.c                    |   3 +
 drivers/thermal/uniphier_thermal.c                 |   4 +
 25 files changed, 679 insertions(+), 314 deletions(-)
