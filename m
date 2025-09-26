Return-Path: <linux-pm+bounces-35498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B968BA509A
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 22:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B083B9064
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 20:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6980283FC3;
	Fri, 26 Sep 2025 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqXBLH7M"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C128222F75C
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758917056; cv=none; b=m5f92f82Eu5Ar+OgYvh6bUsSpL+DWbn0ngXFNYmDOeUbZDK4LbDSLy5DrFPIplh/J8JHdJ9/+EBQawIGvmqfPNb95zN6jFoNA3FAeTOUoGZUlXmVYpxfDHhPYFSrWeQJLiUdcsw5OZIvTyzUPS9zFhj4IB3fpqa1DD6mrpePncQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758917056; c=relaxed/simple;
	bh=u0wXap9HzcbHDc2esJUejmkKTx1774Prm1f8i4eCYL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taoiwyONsy+7/YBpxyNooCILx5LB5WBWcLaws7OYyT894wDAHlUzv7aguiuT3pU8hMulLUFvOKDH0XDYeofw12qgRsdyvD+MFelzALlb1XLnrUBC8dKekZ5qtG/4vogagLCpsszCtqKiFJr1AH5HiJYRRMcsWMbmQZ5JBD2hWaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqXBLH7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D457C4CEF4
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 20:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758917056;
	bh=u0wXap9HzcbHDc2esJUejmkKTx1774Prm1f8i4eCYL0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XqXBLH7MpPs8v5Nfi99rx8dFVs1C4UzddYm4c9w5E2PsvgD7TyjU8lBxOqxL5CjKL
	 TPDWBi0l+mqaLNPBozRlDrkYgBPm5cvW6B/Qtin+63GMc+gDOr9MImAdcR+NUlfWjP
	 gHq6DqF8+bBfdI28XVWocVBnJ0FUNRQ4OAGKtTURhgxL2m5HpKWb3AWSqEKZ4SpEl0
	 XZwkSHu/E1NXflRVVtyJ4rVCKQRuE1uGKmcZXchDhtG1AWdlkeeiXmKiNDN6EKdWgb
	 1tS4bYJdjz8SUsJphQXVFeQbXPDbzcr8z24/YF1bS35uR6/yQZTZaV3WP4hJhGPDHy
	 8T3Hmu15Fj6pg==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-353f965c048so2086524fac.2
        for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 13:04:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEZU1U0ItCQqmCAQXMs7f78X/+WvRB7kTeCNAySbxI5ifyv8IDAVY0dVc4J+KteXt9M+Svw/qbig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVpJ+7BKHd72hnOOWdWQLhhIQioAm+hWOMiIjSYqorog5rAcFa
	YFJDaQL72ojl57v+RUKzgWi1zzHW8/SaV6MbBj+eNAcfkM27igXvH855pPwT7uVX0bR0Sosiz0z
	NzS1oGWvUICbjj94Oi4D3KnBmk6w+NaQ=
X-Google-Smtp-Source: AGHT+IGZF07mr5SO1ZYjdyfGE2jef54MqntMoSpOrobDLjTEYT992teYZDTkICaFnIoXSiM4mqPp/BgEiZIECRbBXWM=
X-Received: by 2002:a05:6870:fb86:b0:31d:7467:e394 with SMTP id
 586e51a60fabf-35ebd6e68e3mr3641805fac.4.1758917055569; Fri, 26 Sep 2025
 13:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4868ed10-af6d-455d-b5cb-f301c1e81de1@linaro.org>
In-Reply-To: <4868ed10-af6d-455d-b5cb-f301c1e81de1@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Sep 2025 22:04:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j-DYV4XPcJMq+MTq6Ywwb=hzMgkYg_p1GzfxLYsavWUg@mail.gmail.com>
X-Gm-Features: AS18NWBHLNcSxnJAJoAaxvcg40CwfaqAQeIY0VO-z1TRAMHRepI3dAtoI35v-Yk
Message-ID: <CAJZ5v0j-DYV4XPcJMq+MTq6Ywwb=hzMgkYg_p1GzfxLYsavWUg@mail.gmail.com>
Subject: Re: [GIT PULL] thermal driver for v6.18-rc1
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Gaurav Kohli <quic_gkohli@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, Sumeet Pawnikar <sumeet4linux@gmail.com>, 
	Svyatoslav Ryhel <clamor95@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Michael Walle <mwalle@kernel.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, 
	John Madieu <john.madieu.xa@bp.renesas.com>, 
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Fri, Sep 26, 2025 at 4:29=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi Rafael,
>
> please consider the following changes since commit
> 8f5ae30d69d7543eee0d70083daf4de8fe15d585:
>
>    Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.18-rc1
>
> for you to fetch changes up to 79428e60897916401c9ed326f6ada4d7c7c997a3:
>
>    dt-bindings: thermal: qcom-tsens: Document the Glymur temperature
> Sensor (2025-09-26 13:27:44 +0200)
>
> ----------------------------------------------------------------
> - Add the QCS615 compatible DT bindings for QCom platforms (Gaurav
>    Kohli)
>
> - Support fallback trimming values when the fuse is empty in the R-Car
>    driver (Marek Vasut)
>
> - Remove unneeded semicolon in the Mediatek LVTS driver (Jiapeng
>    Chong)
>
> - Fix the LMH Kconfig option by selecting QCOM_SCM and take the
>    opportunity to add the COMPILE_TEST option for the QCom's LMH
>    feature (Dmitry Baryshkov)
>
> - Fix the missing includes and incorrect error message in the Qcom's
>    LMH driver (Dmitry Baryshkov)
>
> - Fix comment typo and add the documentation in the Kconfig for the
>    R-Car Gen3 and Gen4 (Marek Vasut)
>
> - Add Tegra114 SOCTHERM support (Svyatoslav Ryhel)
>
> - Rename the functions name in the driver to be consistent and generic
>    with the different R-Car platform variants (Wolfram Sang)
>
> - Register the TI K3 J72xx bandgap sensor as a hwmon sensor too
>    (Michael Walle)
>
> - Add and document the thermal sensor unit reporting the junction
>    temperature of the RZ/G3S SoC (Claudiu Beznea)
>
> - Support the GRF in the Rockchip driver (Sebastian Reichel)
>
> - Add a temperature IIO sensor channel in the generic thermal ADC
>    driver (Svyatoslav Ryhel)
>
> - Document the temperature sensor on the QCOM's Glymur platform (Manaf
>    Meethalavalappu)
>
> - Add and document the thermal sensor unit reporting the junction
>    temperature of the RZ/G3E SoC (John Madieu)
>
> ----------------------------------------------------------------
> Claudiu Beznea (2):
>        dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit
>        thermal/drivers/renesas/rzg3s: Add thermal driver for the Renesas
> RZ/G3S SoC
>
> Dmitry Baryshkov (2):
>        thermal/drivers/qcom: Make LMH select QCOM_SCM
>        thermal/drivers/qcom/lmh: Add missing IRQ includes
>
> Gaurav Kohli (1):
>        dt-bindings: thermal: tsens: Add QCS615 compatible
>
> Jiapeng Chong (1):
>        thermal/drivers/mediatek/lvts_thermal: Remove unneeded semicolon
>
> John Madieu (2):
>        dt-bindings: thermal: r9a09g047-tsu: Document the TSU unit
>        thermal/drivers/renesas/rzg3e: Add thermal driver for the Renesas
> RZ/G3E SoC
>
> Manaf Meethalavalappu Pallikunhi (1):
>        dt-bindings: thermal: qcom-tsens: Document the Glymur temperature
> Sensor
>
> Marek Vasut (4):
>        thermal/drivers/rcar_gen3: Add support for per-SoC default trim
> values
>        thermal/drivers/rcar_gen3: Add support for R-Car V4H default trim
> values
>        thermal/drivers/rcar_gen3: Fix comment typo
>        thermal/drivers/rcar_gen3: Document Gen4 support in Kconfig entry
>
> Michael Walle (1):
>        thermal/drivers/k3_j72xx_bandgap: Register sensors with hwmon
>
> Sebastian Reichel (3):
>        thermal/drivers/rockchip: Unify struct rockchip_tsadc_chip format
>        thermal/drivers/rockchip: Shut up GRF warning
>        dt-bindings: thermal: rockchip: Tighten grf requirements
>
> Sumeet Pawnikar (1):
>        drivers/thermal/qcom/lmh: Fix incorrect error message
>
> Svyatoslav Ryhel (5):
>        dt-bindings: thermal: Document Tegra114 SOCTHERM Thermal
> Management System
>        thermal/drivers/tegra/soctherm-fuse: Prepare calibration for
> Tegra114 support
>        dt-bindings: thermal: add Tegra114 soctherm header
>        thermal/drivers/tegra: Add Tegra114 specific SOCTHERM driver
>        thermal/drivers/thermal-generic-adc: Add temperature sensor channe=
l
>
> Wolfram Sang (1):
>        thermal/drivers/rcar_gen3: Fix mapping SoCs to generic Gen4 entry
>
>   .../bindings/thermal/nvidia,tegra124-soctherm.yaml |   2 +
>   .../devicetree/bindings/thermal/qcom-tsens.yaml    |   2 +
>   .../bindings/thermal/renesas,r9a08g045-tsu.yaml    |  93 +++++++
>   .../bindings/thermal/renesas,r9a09g047-tsu.yaml    |  87 +++++++
>   .../bindings/thermal/rockchip-thermal.yaml         |  15 ++
>   MAINTAINERS                                        |  14 ++
>   drivers/thermal/k3_j72xx_bandgap.c                 |   4 +
>   drivers/thermal/mediatek/lvts_thermal.c            |   2 +-
>   drivers/thermal/qcom/Kconfig                       |   3 +-
>   drivers/thermal/qcom/lmh.c                         |   4 +-
>   drivers/thermal/renesas/Kconfig                    |  21 +-
>   drivers/thermal/renesas/Makefile                   |   3 +
>   drivers/thermal/renesas/rcar_gen3_thermal.c        |  63 +++--
>   drivers/thermal/renesas/rzg3s_thermal.c            | 272
> +++++++++++++++++++++
>   drivers/thermal/rockchip_thermal.c                 |  50 ++--
>   drivers/thermal/tegra/Makefile                     |   1 +
>   drivers/thermal/tegra/soctherm-fuse.c              |  18 +-
>   drivers/thermal/tegra/soctherm.c                   |  13 +
>   drivers/thermal/tegra/soctherm.h                   |  11 +-
>   drivers/thermal/tegra/tegra114-soctherm.c          | 209 ++++++++++++++=
++
>   drivers/thermal/tegra/tegra124-soctherm.c          |   4 +
>   drivers/thermal/tegra/tegra132-soctherm.c          |   4 +
>   drivers/thermal/tegra/tegra210-soctherm.c          |   4 +
>   drivers/thermal/thermal-generic-adc.c              |  55 ++++-
>   include/dt-bindings/thermal/tegra114-soctherm.h    |  19 ++
>   25 files changed, 911 insertions(+), 62 deletions(-)
>   create mode 100644
> Documentation/devicetree/bindings/thermal/renesas,r9a08g045-tsu.yaml
>   create mode 100644
> Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
>   create mode 100644 drivers/thermal/renesas/rzg3s_thermal.c
>   create mode 100644 drivers/thermal/tegra/tegra114-soctherm.c
>   create mode 100644 include/dt-bindings/thermal/tegra114-soctherm.h
>
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!

