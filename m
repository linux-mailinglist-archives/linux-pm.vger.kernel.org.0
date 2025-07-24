Return-Path: <linux-pm+bounces-31378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7DBB10A70
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 14:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9FF1CC40A0
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jul 2025 12:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895512D3747;
	Thu, 24 Jul 2025 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACOJM4G5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0222D322E;
	Thu, 24 Jul 2025 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360859; cv=none; b=FhlpUMhGzriniUceIx9xGNG4o2xt8OGcaZz9SINjzc/cvIb7BctEkJxB3MSLuwC6KfTQHXwzGKYgMYdvrdH6nucfO8YomZlugeAQUXe+Q30ik8ls8ymQ0RqnRkHG+1tcDoe3WZfbCI9KPoEWEToEDL3QmAHFgoAbvDaCpSibmxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360859; c=relaxed/simple;
	bh=KGQn/ORkzt+i8h/7gqR/2YaV8Ey5P3ecLS0sgGpOMuA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QQ6qjUcVyLichYfDoRetTlGsrf3HqcXUwQSIdcSYYt8PWfRCO35YSx2Ypsia1fF6FU1QAk8DiLyPZFAghYF0DXyCqnaRnJ15747C/dS5C/oTdmZLEUigThVSO1chtNIFYkQRKRiXdzG7vtA8xU4uE7RNrQc7d8Jfr8M1+c+ijgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACOJM4G5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE409C4CEED;
	Thu, 24 Jul 2025 12:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753360858;
	bh=KGQn/ORkzt+i8h/7gqR/2YaV8Ey5P3ecLS0sgGpOMuA=;
	h=From:Date:Subject:To:Cc:From;
	b=ACOJM4G5/c3f7xAhnAJElHNbRawH/b7tLTiBhKYoMBABu7XS9pAh2NwO7p8nCNIqF
	 WXFCaVY7iWm9eKDqqAXWOi0MdzvD97Ccn2qjFzpIJaedwJNSgZOEg5G1s7lHpBrfGo
	 FljRI2AO8+0hX19+8ftMEwiPNv9jUqxQkCcUuIVDCLWlc10NpPuJa7/qqiBUKprGU7
	 XYP1wWUUAmWwUbPTHn+W/GjwzZ4Q/1gt2dfgu9mF8jNIaAsNySW1CoZqDd4YsVIciT
	 6qsJHES+niCs8BKA8PbWmAVVR49R+nC6Abn2zLj13RXCjnsprqeSzSPoIFcrTRElwU
	 O13gCVGdiZm4g==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-615950642d9so553843eaf.1;
        Thu, 24 Jul 2025 05:40:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWeqxtNs23czzSioh8Wa7haoy/iqA4PuSgkF3n+heDZwBbOo8eedXhG54bFEe9mwciR8P5mro+HseUhJPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiNVE6/tAQQuyAhkMa4wYhDjzlzbDHeBjjwUs+HpP8jmMO4PWh
	4UHWa4v+7qfmVigqQ95ThwiG7OReFqhq49lfESTjCy1xoBlxX6y7pmqxI2Br5kb9xWKmsnOR4VH
	FMAcmmq8BSJ4uaSBjZjxMQ5moE9jwtLQ=
X-Google-Smtp-Source: AGHT+IH5cce5yaNr2soMDUhZN8w6HVywgtWyig31yOOBApw5Rxwl+NOSkdszOip5TYVcQTn8m1/yJRaVDIDoUI3ws2Q=
X-Received: by 2002:a05:6808:1b2c:b0:408:fef8:9c9e with SMTP id
 5614622812f47-426c5f4e9famr4719647b6e.22.1753360858247; Thu, 24 Jul 2025
 05:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Jul 2025 14:40:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gTixsgeM7svDVJnjpGV4PG-hxOmZpUGxhdqTeo4bbU4w@mail.gmail.com>
X-Gm-Features: Ac12FXyeBEfO9sGcgJ1H-kH-OBzvpk1CGd5G63oYqEyppeEcgcvYQ-qLJ0QS9E4
Message-ID: <CAJZ5v0gTixsgeM7svDVJnjpGV4PG-hxOmZpUGxhdqTeo4bbU4w@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

I'm sending this early because I will be mostly offline next week
and I'm not planning to add anything to it.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.17-rc1

with top-most commit 1e94cb6c2ae1c2660ed406669f12b90c7052d2b9

 Merge back earlier thermal control updates for 6.17

on top of commit d7b8f8e20813f0179d8ef519541a3527e7661d3a

 Linux 6.16-rc5

to receive thermal control updates for 6.17-rc1.

These update the thermal control sysfs interface and multiple thermal
control drivers:

 - Convert EAGAIN into ENODATA in temp_show() to prevent user space from
   polling the sysfs file in vain after a failing O_NONBLOCK read under
   the assumption that the read would have blocked (Hsin-Te Yuan)

 - Add Wildcat Lake PCI ID to the int340x Intel processor thermal driver
   (Srinivas Pandruvada)

 - Add debugfs interface to override the temperature set by the firmware
   in the Intel platform temperature control (PTC) interface and add a
   new sysfs control attribute called thermal_tolerance to it (Srinivas
   Pandruvada)

 - Enable the stage 2 shutdown in the qcom-spmi-temp-alarm thermal
   driver and add support for more SPMI variants to it (Anjelique
   Melendez)

 - Constify the thermal_zone_device_ops structure where possible in
   several assorted thermal drivers (Christophe Jaillet)

 - Use the dev_fwnode() helper instead of of_fwnode_handle(), as it is
   more adequate, wherever possible in thermal drivers (Jiri Slaby)

 - Implement and document One-Time Programmable fuse support in the
   Rockchip thermal driver in order to increase the precision of the
   measurements (Nicolas Frattaroli)

 - Change the way the Mediatek LTVS thermal driver stores the
   initialization data sequence to support different sequences
   matching different platforms. Introduce mt7988 support with
   a new initialization sequence (Mason Chang)

 - Document the QCom TSens Milos Temperature Sensor DT bindings (Luca
   Weiss)

 - Add the fallback compatible string for MT7981 and MT8516 DT bindings
   (Aleksander Jan Bajkowski)

 - Add the compatible string for the Tegra210B01 SOC_THERM driver (Aaron
   Kling)

Thanks!


---------------

Aaron Kling (1):
      dt-bindings: thermal: tegra: Document Tegra210B01

Aleksander Jan Bajkowski (1):
      dt-bindings: thermal: mediatek: Add fallback compatible string
for MT7981 and MT8516

Anjelique Melendez (4):
      thermal/drivers/qcom-spmi-temp-alarm: Add temp alarm data struct
based on HW subtype
      thermal/drivers/qcom-spmi-temp-alarm: Prepare to support
additional Temp Alarm subtypes
      thermal/drivers/qcom-spmi-temp-alarm: Add support for GEN2 rev 2
PMIC peripherals
      thermal/drivers/qcom-spmi-temp-alarm: Add support for LITE PMIC
peripherals

Christophe JAILLET (2):
      thermal/drivers/loongson2: Constify struct thermal_zone_device_ops
      thermal: Constify struct thermal_zone_device_ops

David Collins (1):
      thermal/drivers/qcom-spmi-temp-alarm: Enable stage 2 shutdown
when required

Hsin-Te Yuan (1):
      thermal: sysfs: Return ENODATA instead of EAGAIN for reads

Jiri Slaby (SUSE) (1):
      thermal: Use dev_fwnode()

Luca Weiss (1):
      dt-bindings: thermal: qcom-tsens: document the Milos Temperature Sensor

Mason Chang (3):
      thermal/drivers/mediatek/lvts_thermal: Change lvts commands
array to static const
      thermal/drivers/mediatek/lvts_thermal: Add lvts commands and
their sizes to driver data
      thermal/drivers/mediatek/lvts_thermal: Add mt7988 lvts commands

Nicolas Frattaroli (4):
      thermal/drivers/rockchip: Rename rk_tsadcv3_tshut_mode
      dt-bindings: rockchip-thermal: Add RK3576 compatible
      dt-bindings: thermal: rockchip: document otp thermal trim
      thermal/drivers/rockchip: Support reading trim values from OTP

Srinivas Pandruvada (3):
      thermal: intel: int340x: Add throttling control interface to PTC
      thermal: intel: int340x: Allow temperature override
      thermal: int340x: processor_thermal: Add Wildcat Lake PCI ID

Ye Zhang (1):
      thermal/drivers/rockchip: Support RK3576 SoC in the thermal driver

---------------

 .../bindings/thermal/mediatek,thermal.yaml         |  27 +-
 .../bindings/thermal/nvidia,tegra124-soctherm.yaml |   2 +
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
 .../bindings/thermal/rockchip-thermal.yaml         |  62 +++
 Documentation/driver-api/thermal/intel_dptf.rst    |   9 +
 drivers/thermal/armada_thermal.c                   |   2 +-
 drivers/thermal/da9062-thermal.c                   |   2 +-
 drivers/thermal/dove_thermal.c                     |   2 +-
 drivers/thermal/imx_thermal.c                      |   2 +-
 .../intel/int340x_thermal/int3400_thermal.c        |   2 +-
 .../int340x_thermal/platform_temperature_control.c |  72 ++-
 .../int340x_thermal/processor_thermal_device.h     |   1 +
 .../int340x_thermal/processor_thermal_device_pci.c |   4 +
 .../intel/int340x_thermal/processor_thermal_rfim.c |   1 +
 drivers/thermal/kirkwood_thermal.c                 |   2 +-
 drivers/thermal/loongson2_thermal.c                |  15 +-
 drivers/thermal/mediatek/lvts_thermal.c            |  76 ++-
 drivers/thermal/qcom/lmh.c                         |   3 +-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c        | 596 ++++++++++++++++++---
 drivers/thermal/renesas/rcar_thermal.c             |   2 +-
 drivers/thermal/rockchip_thermal.c                 | 251 ++++++++-
 drivers/thermal/spear_thermal.c                    |   2 +-
 drivers/thermal/st/st_thermal.c                    |   2 +-
 drivers/thermal/tegra/soctherm.c                   |  13 +-
 drivers/thermal/testing/zone.c                     |   2 +-
 drivers/thermal/thermal_sysfs.c                    |   9 +-
 26 files changed, 1013 insertions(+), 149 deletions(-)

