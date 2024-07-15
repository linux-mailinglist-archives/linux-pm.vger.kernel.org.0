Return-Path: <linux-pm+bounces-11115-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA4D931754
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 17:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C5FEB223DB
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 15:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8679118EFE8;
	Mon, 15 Jul 2024 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdiz067F"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A7918EA90
	for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2024 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721055873; cv=none; b=ia316vcrKD+aJzCGcvzBPabiFp1e9DZ0FSUv609gvyz8qnWpg5hqyJkg5xjhB1GORQ3BPc6yiSja5DN4SZawWW66vGUXDoOtDJe2oG44A/11qxtSiMOsaBxn+6p7oaKAbtdmN/V+0ovzLQ/v5Z82sE3YwgKdNSxIrZpDhz+yIXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721055873; c=relaxed/simple;
	bh=YSXW6oX644VW18/vDfVaQq3H2bN2Qt0lTXH6hB6a10o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKZbA7DFgZl8pqivGdfhW0uzoA0F9QohX0yhRv2/pc5Ntakg/vCUc8G9ZkpYkZoSVe0Udr78pAN7IHUYGifUV7ScCbgfh+sjJhmFAp4f8tnt+Ti9MHiZdWVn32/z7LN+pV2eMSkFBlAHuToe2faOebinBbkR5Zu2HnBPydgmACI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdiz067F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7835C4AF0E
	for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2024 15:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721055872;
	bh=YSXW6oX644VW18/vDfVaQq3H2bN2Qt0lTXH6hB6a10o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pdiz067F7hFejStHd2xU3D4E/oAWb6EHGYeCQKRmg5E+I2r5OSSaULVvPh7IP8LfP
	 1nsH8SpY/OsLUy2QdOtyLhYKUrdoDPxeYR5kmvDfH94+qEXPutlbgS8P+/QUPOrMO0
	 UZb3/owKUbi9dXBPkrkyounnopY4hnoFzk5+PmbMPPKpc+6LTdT5fLENs6stLthKhZ
	 qFCwWoI9Z+aBMN8N4PmXhttPLMOtLzPaeHmrEuxAfePsJc6cNVdi9IBOn+dXr2Kwfp
	 6ImuF2z4ucph/mdR5JTU6/kjI0Nhg6SZJZISBHNvq+4YAiStF4pHCkN77s3DbjruzO
	 6nuRxZo8zxN4w==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-25e3d71030cso503076fac.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2024 08:04:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUN2jomQaFXd5/alQQn7as4Zc3KTEEG1AlMlaoTAqmhL2MeGsMKgLV0NCIBfauVOkk9o76ZoBK/AwZ3+lv8o0PsGU/30aP9uiM=
X-Gm-Message-State: AOJu0YwagSyQ1RLfS8HsA8tpU9HLm0jdour5NPRLpI79/4KLy4DFidss
	wqKpPoz/nkScnjswMvH9qMhGM02ROzmH8nxpxMS4OzdviiYTWoSmLgr22HK26CtTbBhVqQGwYbM
	wdgWuCr8rWTf6vyYhNXQbyMRxb7s=
X-Google-Smtp-Source: AGHT+IGo8Nbn5ffu4gbzlc9FapMl+awFMwiLcExhUR5FCbuhiM1Vx98BlsuWOWZjfqRL6wamckn7nEdjmtgKkH3Yk+I=
X-Received: by 2002:a05:6870:89a5:b0:25f:74a0:ec13 with SMTP id
 586e51a60fabf-2603ab4716fmr11513620fac.5.1721055872147; Mon, 15 Jul 2024
 08:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f808c0b-2cc4-4372-9296-07817f5b901a@linaro.org>
In-Reply-To: <1f808c0b-2cc4-4372-9296-07817f5b901a@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Jul 2024 17:04:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jBO4MZOn34n7oO_ym7egL6NvKKba9K+X3qQU+5unFzbQ@mail.gmail.com>
Message-ID: <CAJZ5v0jBO4MZOn34n7oO_ym7egL6NvKKba9K+X3qQU+5unFzbQ@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers for v6.11-rc1
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	theo.lebrun@bootlin.com, Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>, 
	Abel Vesa <abel.vesa@nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>, 
	Rob Herring <robh+dt@kernel.org>, Raphael Gallais-Pou <rgallaispou@gmail.com>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Mon, Jul 15, 2024 at 4:48=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> please consider the following changes for the thermal drivers.
>
> Thanks in advance
>
>    -- Daniel
>
> The following changes since commit 462be1c353400fa0bdd34c19897cf001ba6a5f=
60:
>
>    Merge back thermal control material for 6.11. (2024-07-10 13:01:38 +02=
00)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.11-rc1
>
> for you to fetch changes up to e61cc85edbbeb71e53fbf049dc9ec763bc274479:
>
>    thermal/drivers/sti: Cleanup code related to stih416 (2024-07-15
> 13:31:41 +0200)
>
> ----------------------------------------------------------------
> - Group all Renesas drivers inside a dedicated sub directory and add
>    the missing dependency to OF (Niklas S=C3=B6derlund)
>
> - Add suspend/resume support on k3_j72xx_bandgap and take the
>    opportunity to remove a unneeded delay in the init time code path
>    (Th=C3=A9o Lebrun)
>
> - Fix thermal zone definition for MT8186 and MT8188 (Julien Panis)
>
> - Convert hisilicon-thermal.txt to dt-schema (Abdulrasaq Lawani)
>
> - Add the DT bindings for the X1E80100 temperature sensor (Abel Vesa)
>
> - Fix the thermal zone node name regular expression in the DT schema
>    (Krzysztof Kozlowski)
>
> - Take into account some production platforms may not have calibration
>    data. Deal with it with a default value instead of failing the
>    initialization (Chen-Yu Tsai)
>
> - Fix the sensor cell size on the Exynos platform (Krzysztof Kozlowski)
>
> - Bring the common definition of '#thermal-sensor-cells' property in
>    order to simplify the bindings on all the platforms where this
>    change makes sense and do some minor cleanups (Krzysztof Kozlowski)
>
> - Fix a race between removal and clock disable on the broadcom driver
>    (Krzysztof Kozlowski)
>
> - Drop 'trips' node as required from the thermal zone bindings in
>    order to fix the remaining warnings appearing with thermal zone
>    whithout trip points defined (Rob Herring)
>
> - Simplify all the drivers where dev_err_probe() can apply (Krzysztof
>    Kozlowski)
>
> - Cleanup code related to stih416 as this platform is not described
>    anywhere (Raphael Gallais-Pou)
>
> ----------------------------------------------------------------
> Abdulrasaq Lawani (1):
>        dt-bindings: thermal: convert hisilicon-thermal.txt to dt-schema
>
> Abel Vesa (1):
>        dt-bindings: thermal: qcom-tsens: Document the X1E80100
> Temperature Sensor
>
> Chen-Yu Tsai (1):
>        thermal/drivers/mediatek/lvts_thermal: Provide default
> calibration data
>
> Julien Panis (2):
>        dt-bindings: thermal: mediatek: Fix thermal zone definition for
> MT8186
>        dt-bindings: thermal: mediatek: Fix thermal zone definitions for
> MT8188
>
> Krzysztof Kozlowski (35):
>        dt-bindings: thermal: correct thermal zone node name limit
>        dt-bindings: thermal: samsung,exynos: specify cells
>        dt-bindings: thermal: amlogic: reference thermal-sensor schema
>        dt-bindings: thermal: allwinner,sun8i-a83t-ths: reference
> thermal-sensor schema
>        dt-bindings: thermal: brcm,avs-ro: reference thermal-sensor schema
>        dt-bindings: thermal: generic-adc: reference thermal-sensor schema
>        dt-bindings: thermal: imx8mm: reference thermal-sensor schema
>        dt-bindings: thermal: nvidia,tegra186-bpmp: reference
> thermal-sensor schema
>        dt-bindings: thermal: nvidia,tegra30-tsensor: reference
> thermal-sensor schema
>        dt-bindings: thermal: qcom-spmi-adc-tm-hc: reference
> thermal-sensor schema
>        dt-bindings: thermal: qcom-spmi-adc-tm5: reference thermal-sensor
> schema
>        dt-bindings: thermal: qcom-tsens: reference thermal-sensor schema
>        dt-bindings: thermal: rcar-gen3: reference thermal-sensor schema
>        dt-bindings: thermal: rockchip: reference thermal-sensor schema
>        dt-bindings: thermal: rzg2l: reference thermal-sensor schema
>        dt-bindings: thermal: socionext,uniphier: reference
> thermal-sensor schema
>        dt-bindings: thermal: sprd: reference thermal-sensor schema
>        dt-bindings: thermal: st,stm32: reference thermal-sensor schema
>        dt-bindings: thermal: ti,am654: reference thermal-sensor schema
>        dt-bindings: thermal: ti,j72xx: reference thermal-sensor schema
>        dt-bindings: thermal: simplify few bindings
>        dt-bindings: thermal: cleanup examples indentation
>        dt-bindings: thermal: qoriq: reference thermal-sensor schema
>        thermal/drivers/broadcom: Fix race between removal and clock disab=
le
>        thermal/drivers/broadcom: Simplify probe() with local dev variable
>        thermal/drivers/broadcom: Simplify with dev_err_probe()
>        thermal/drivers/exynos: Simplify probe() with local dev variable
>        thermal/drivers/exynos: Simplify with dev_err_probe()
>        thermal/drivers/hisi: Simplify with dev_err_probe()
>        thermal/drivers/imx: Simplify probe() with local dev variable
>        thermal/drivers/imx: Simplify with dev_err_probe()
>        thermal/drivers/qcom-spmi-adc-tm5: Simplify with dev_err_probe()
>        thermal/drivers/qcom-tsens: Simplify with dev_err_probe()
>        thermal/drivers/generic-adc: Simplify probe() with local dev varia=
ble
>        thermal/drivers/generic-adc: Simplify with dev_err_probe()
>
> Niklas S=C3=B6derlund (2):
>        thermal/drivers/renesas: Group all renesas thermal drivers togethe=
r
>        thermal/drivers/renesas/rcar: Add dependency on OF
>
> Raphael Gallais-Pou (1):
>        thermal/drivers/sti: Cleanup code related to stih416
>
> Rob Herring (Arm) (1):
>        dt-bindings: thermal: Drop 'trips' node as required
>
> Th=C3=A9o Lebrun (1):
>        thermal/drivers/k3_j72xx_bandgap: Implement suspend/resume support
>
>   .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml |   6 +-
>   .../bindings/thermal/amlogic,thermal.yaml          |  22 ++--
>   .../bindings/thermal/brcm,avs-ro-thermal.yaml      |  24 ++---
>   .../devicetree/bindings/thermal/brcm,avs-tmon.yaml |  17 ++--
>   .../bindings/thermal/brcm,bcm2835-thermal.yaml     |   1 -
>   .../bindings/thermal/fsl,scu-thermal.yaml          |   1 -
>   .../bindings/thermal/generic-adc-thermal.yaml      |   5 +-
>   .../bindings/thermal/hisilicon,tsensor.yaml        |  57 +++++++++++
>   .../bindings/thermal/hisilicon-thermal.txt         |  32 ------
>   .../bindings/thermal/imx8mm-thermal.yaml           |   5 +-
>   .../bindings/thermal/loongson,ls2k-thermal.yaml    |   1 -
>   .../bindings/thermal/mediatek,lvts-thermal.yaml    |   1 -
>   .../bindings/thermal/nvidia,tegra124-soctherm.yaml |   1 -
>   .../thermal/nvidia,tegra186-bpmp-thermal.yaml      |  12 +--
>   .../bindings/thermal/nvidia,tegra30-tsensor.yaml   |   9 +-
>   .../bindings/thermal/qcom,spmi-temp-alarm.yaml     |   1 -
>   .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml      |   8 +-
>   .../bindings/thermal/qcom-spmi-adc-tm5.yaml        |   8 +-
>   .../devicetree/bindings/thermal/qcom-tsens.yaml    |  97
> +++++++++---------
>   .../devicetree/bindings/thermal/qoriq-thermal.yaml |   5 +-
>   .../bindings/thermal/rcar-gen3-thermal.yaml        |  71 ++++++-------
>   .../devicetree/bindings/thermal/rcar-thermal.yaml  |  64 ++++++------
>   .../bindings/thermal/rockchip-thermal.yaml         |   5 +-
>   .../devicetree/bindings/thermal/rzg2l-thermal.yaml |  43 ++++----
>   .../bindings/thermal/samsung,exynos-thermal.yaml   |   3 +-
>   .../thermal/socionext,uniphier-thermal.yaml        |   5 +-
>   .../devicetree/bindings/thermal/sprd-thermal.yaml  |  49 ++++-----
>   .../bindings/thermal/st,stm32-thermal.yaml         |   5 +-
>   .../devicetree/bindings/thermal/thermal-zones.yaml |   6 +-
>   .../bindings/thermal/ti,am654-thermal.yaml         |  15 +--
>   .../bindings/thermal/ti,j72xx-thermal.yaml         |   5 +-
>   MAINTAINERS                                        |   4 +-
>   drivers/thermal/Kconfig                            |  28 +-----
>   drivers/thermal/Makefile                           |   4 +-
>   drivers/thermal/broadcom/bcm2835_thermal.c         |  49 +++------
>   drivers/thermal/hisi_thermal.c                     |   9 +-
>   drivers/thermal/imx_thermal.c                      |  42 ++++----
>   drivers/thermal/k3_j72xx_bandgap.c                 | 111
> +++++++++++++++------
>   drivers/thermal/mediatek/lvts_thermal.c            |  46 ++++++---
>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   9 +-
>   drivers/thermal/qcom/tsens.c                       |   8 +-
>   drivers/thermal/renesas/Kconfig                    |  28 ++++++
>   drivers/thermal/renesas/Makefile                   |   5 +
>   drivers/thermal/{ =3D> renesas}/rcar_gen3_thermal.c  |   2 +-
>   drivers/thermal/{ =3D> renesas}/rcar_thermal.c       |   2 +-
>   drivers/thermal/{ =3D> renesas}/rzg2l_thermal.c      |   2 +-
>   drivers/thermal/samsung/exynos_tmu.c               |  54 +++++-----
>   drivers/thermal/st/st_thermal_memmap.c             |  10 --
>   drivers/thermal/thermal-generic-adc.c              |  27 +++--
>   .../dt-bindings/thermal/mediatek,lvts-thermal.h    |  12 +--
>   50 files changed, 531 insertions(+), 505 deletions(-)
>   create mode 100644
> Documentation/devicetree/bindings/thermal/hisilicon,tsensor.yaml
>   delete mode 100644
> Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
>   create mode 100644 drivers/thermal/renesas/Kconfig
>   create mode 100644 drivers/thermal/renesas/Makefile
>   rename drivers/thermal/{ =3D> renesas}/rcar_gen3_thermal.c (99%)
>   rename drivers/thermal/{ =3D> renesas}/rcar_thermal.c (99%)
>   rename drivers/thermal/{ =3D> renesas}/rzg2l_thermal.c (99%)
>
>
> --

Pulled and merged into linux-pm.git/thermal, thanks!

