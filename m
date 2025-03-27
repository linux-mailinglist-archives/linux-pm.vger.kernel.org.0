Return-Path: <linux-pm+bounces-24559-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AAEA73217
	for <lists+linux-pm@lfdr.de>; Thu, 27 Mar 2025 13:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810383B6395
	for <lists+linux-pm@lfdr.de>; Thu, 27 Mar 2025 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1AD2139A6;
	Thu, 27 Mar 2025 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QujFDcW7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D452135CF;
	Thu, 27 Mar 2025 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743077462; cv=none; b=rFnJ58yc84jrhbQfILPasXHjigJrVDoPjTbl+di7ynp5GtwDJabmRJhsGCZ2MGPaQENGywtRLjHzbcOH9M4B0V3jNYbMy+pda5bsxEmfeIzDoWoFnqNepxg30Hi+VuLDmysQxHDTPpBvx0KpFuK/opHRQ+BxsXqeToY8h9rszT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743077462; c=relaxed/simple;
	bh=XIQRRWYMx8OUilfOqaktKesn+Pc1d0qsEjlpzRTvU6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SnSX6LsB//5VRc88qFWNga8kIPI0rv+TqZxWMESFEjpjlqWnp3uiLGk4CYZMjWBpIfzCoorphmkey0qSL/65YE1VrM1mpQyyVPw1ql3SYOUjd9uJkBjU51H1VNb1HaawvtE0E+NaeXB84v5MZ0KAtOFXTmirOmes8Wlkk+vJQLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QujFDcW7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84058C4CEEB;
	Thu, 27 Mar 2025 12:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743077461;
	bh=XIQRRWYMx8OUilfOqaktKesn+Pc1d0qsEjlpzRTvU6k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QujFDcW7ijZeyQYROSt11kChWHb5W3TEmmD9DyXZXqHxh4XxCsWcxZG0C7E88NRIT
	 mj8vthsH8tj8nnc1ZEznzP8cPx+yey4tY8dv1/St4eqFJ4gLcUtSgQ3Ni6p/XOA6ds
	 xW/TMFGZJacfivH98/7f0Xfjrx8t9Ewz4Yn903UJoaVpRNmGc66bRbX6auxIQSnmTu
	 enaRswrt0YjSka5QYZ4x4obHcOf5vJkzHhpRKjlDJeUSUIh0rjVpFmXJVR1PmmyWfD
	 V5lgP7M8Q4NED6HbL0B+UBVNe/J8vtkz3dvVQymo9jxkbwI3NgCaI9gTw4q1/ATrQp
	 s12F/8KuvcOYQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c82007eaadso251989fac.1;
        Thu, 27 Mar 2025 05:11:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUG90ZMutYT6OzunYTBPDgDJEfT+SLMsl3e+ukOkvevilKj3tzj3mr//5bW/vdiF+ewTOvWLOIhJ/b191E=@vger.kernel.org, AJvYcCUXy0kJbcoUaBPbiFa/+4OgoEVHYO2vt+VcmJAtlGRH+N0ebA4Bmb+PxsGC4zo0C+EHF1qEBkk/pvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzim0yphgfSfjRJVWN+okyCbK8jc6ROrgys/i7muw+qh+To6qae
	mkYXX6u7yrUjFTSn5T7Q4GYbIiBi1PlB8qtv2lwdE6XH5B1d06yZfPlgexPQID2R4CzQffwMKJX
	UjjizhiVJfxeApSvdA5K9xuj7ZuI=
X-Google-Smtp-Source: AGHT+IH94i18GNi0ewMyRgAen5oFNRpGOOytQSPBADrrs79aAKkSzJRYD687On20AXIZq4UGdd0Q7B9u6nWEQSIbcgI=
X-Received: by 2002:a05:6870:392b:b0:29e:67cd:1a8f with SMTP id
 586e51a60fabf-2c84823bf35mr1571408fac.37.1743077460721; Thu, 27 Mar 2025
 05:11:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8a52679e-830d-4a7f-8eb7-c6ea90c735d7@linaro.org>
In-Reply-To: <8a52679e-830d-4a7f-8eb7-c6ea90c735d7@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Mar 2025 13:10:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jnNiZB8oFAf576=OENdobewQWf8qJuzJEE7WRFOYfhcg@mail.gmail.com>
X-Gm-Features: AQ5f1Jri100uY094lSBQPKVK5x01_nidRnB9bVeQygObdAVaZ-LW8JORWV4bieY
Message-ID: <CAJZ5v0jnNiZB8oFAf576=OENdobewQWf8qJuzJEE7WRFOYfhcg@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers for v6.15-rc1
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Frank Li <Frank.Li@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
	Praveenkumar I <quic_ipkumar@quicinc.com>, Trevor Woerner <twoerner@gmail.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	Johan Hovold <johan@kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, Mar 26, 2025 at 9:43=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> please consider the following changes since commit
> c3b659b74541f4564f9f5a39f65e625c47e77e21:
>
>    Merge branches 'thermal-core' and 'thermal-misc' (2025-03-24 14:09:38
> +0100)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.15-rc1
>
> for you to fetch changes up to 1b4ef46fd6660712afcfdd841eadd928193e850f:
>
>    thermal/drivers/qcom-spmi-temp-alarm: Drop unused driver data
> (2025-03-25 20:52:04 +0100)
>
> ----------------------------------------------------------------
> - Used dev_err_probe() helpers to simplify the init code in the Qoriq
>    driver (Frank Li)
>
> - Powered down the Qoriq's TMU at suspend time (Alice Guo)
>
> - Added ipq5332, ipq5424 compatible for the QCom's tsens driver and
>    TSENS enable / calibration support for V2 (Praveenkumar I)
>
> - Added missing rk3328 mapping entry (Trevor Woerner)
>
> - Removed duplicate struct declaration in the thermal core header
>    (Xueqin Luo)
>
> - Disabled the monitoring mode during suspend for the LVTS Mediatek
>    driver to prevent temperature acquisition glitches (N=C3=ADcolas
>    F. R. A. Prado)
>
> - Disabled Stage 3 thermal threshold on the LVTS Mediatek driver
>    because it disables the suspend ability and does have an not
>    interrupt handler (N=C3=ADcolas F. R. A. Prado)
>
> - Fixed low temperature offset interrupt on the LVTS Mediatek driver
>    to prevent multiple interrupts when the system is at its normal
>    functionning temperature (N=C3=ADcolas F. R. A. Prado)
>
> - Enable the interrupts on the LVTS Mediatek driver only on used
>    sensors (N=C3=ADcolas F. R. A. Prado)
>
> - Added the BCM74110 compatible DT binding and the corresponding code
>    to support the chip with a different process (Florian Fainelli)
>
> - Corrected indentation and style in DTS example (Krzysztof Kozlowski)
>
> - Unified hexadecimal annotatation in the rcar_gen3 driver (Niklas
>    S=C3=B6derlund)
>
> - Factored out the code logic to read the fuse on the on Gen3 and Gen4
>    drivers (Niklas S=C3=B6derlund)
>
> - Dropped unused driver data on the QCom's spmi temperature alarm
>    driver (Johan Hovold)
>
> ----------------------------------------------------------------
> Alice Guo (1):
>        thermal/drivers/qoriq: Power down TMU on system suspend
>
> Florian Fainelli (2):
>        dt-bindings: thermal: Update for BCM74110
>        thermal/drivers/brcmstb_thermal: Add support for BCM74110
>
> Frank Li (1):
>        thermal/drivers/qoriq: Use dev_err_probe() simplify the code
>
> Johan Hovold (1):
>        thermal/drivers/qcom-spmi-temp-alarm: Drop unused driver data
>
> Krzysztof Kozlowski (1):
>        dt-bindings: thermal: Correct indentation and style in DTS example
>
> Niklas S=C3=B6derlund (2):
>        thermal: rcar_gen3: Use lowercase hex constants
>        thermal: rcar_gen3: Reuse logic to read fuses on Gen3 and Gen4
>
> N=C3=ADcolas F. R. A. Prado (5):
>        thermal/drivers/mediatek/lvts: Disable monitor mode during suspend
>        thermal/drivers/mediatek/lvts: Disable Stage 3 thermal threshold
>        thermal/drivers/mediatek/lvts: Disable low offset IRQ for minimum
> threshold
>        thermal/drivers/mediatek/lvts: Start sensor interrupts disabled
>        thermal/drivers/mediatek/lvts: Only update IRQ enable for valid
> sensors
>
> Praveenkumar I (2):
>        dt-bindings: thermal: tsens: Add ipq5332, ipq5424 compatible
>        thermal/drivers/tsens: Add TSENS enable and calibration support
> for V2
>
> Trevor Woerner (1):
>        thermal/drivers/rockchip: Add missing rk3328 mapping entry
>
> xueqin Luo (1):
>        thermal: core: Remove duplicate struct declaration
>
>   .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml |  48 +++---
>   .../devicetree/bindings/thermal/brcm,avs-tmon.yaml |   1 +
>   .../devicetree/bindings/thermal/imx-thermal.yaml   |  40 ++---
>   .../bindings/thermal/imx8mm-thermal.yaml           |   8 +-
>   .../devicetree/bindings/thermal/qcom-tsens.yaml    |  18 +++
>   drivers/thermal/broadcom/brcmstb_thermal.c         |  11 +-
>   drivers/thermal/mediatek/lvts_thermal.c            | 103 ++++++++----
>   drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   1 -
>   drivers/thermal/qcom/tsens-v2.c                    | 178
> +++++++++++++++++++++
>   drivers/thermal/qcom/tsens.c                       |   8 +-
>   drivers/thermal/qcom/tsens.h                       |   3 +
>   drivers/thermal/qoriq_thermal.c                    |  47 +++---
>   drivers/thermal/renesas/rcar_gen3_thermal.c        | 107 ++++++-------
>   drivers/thermal/rockchip_thermal.c                 |   1 +
>   include/linux/thermal.h                            |   2 -
>   15 files changed, 409 insertions(+), 167 deletions(-)
>
>
> --

Pulled and added to linux-pm.git/thermal, thanks!

