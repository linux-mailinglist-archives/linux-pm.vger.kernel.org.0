Return-Path: <linux-pm+bounces-31282-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 377E0B0DA21
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 14:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD30918969BF
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 12:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA3C2E9EC6;
	Tue, 22 Jul 2025 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTFFPs2I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00182E9EBB;
	Tue, 22 Jul 2025 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188554; cv=none; b=eOkMk5BfFqUvcJkVgzielRVEQtvZe1FExvl6gPcpYd/pxxfxfn0+HsgSnNWdJBx8z3RpOAJD5pqxkfCz6VaN9e6w+ftlcD3EQXUbVCwI8SgX0TcAEc5Oabt/A38JyuwT930MSunUISCHjzi7ZXbUgRZnkqgHx2732kA1b4btraQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188554; c=relaxed/simple;
	bh=X32HyNSIIPs25XHgNeBg1PK4kGHWYA4rSOuYEWPQxjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFipnfYn4zhA2SPp1roWKqHbKxAjP5kyt/Ggxp0/+bZkSKP0u2kkZbyfS4Cp1h7/YVfOcmM58P3xYP2fwd6sJLtE0rhQBlkUURD5xVJ34E8PbcD+BlWo6T3nQ1MeRdcgiG2uZwfgCcUYQZal7GwyuenTa76gKpH6hNzC+dKelcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTFFPs2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E4DC4CEFD;
	Tue, 22 Jul 2025 12:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753188554;
	bh=X32HyNSIIPs25XHgNeBg1PK4kGHWYA4rSOuYEWPQxjw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YTFFPs2IDFaY+deXiD+U7vb6vg8vCWDC+fnLpLn9C8KtbzMEdgNHWUej67PbHmNNc
	 ZO7/sE086bd7x0RgigT74NRCQQcrJr7IIi2YHoyj+tnrqBJ+cFivqrjWERI+pdu7QL
	 23dEHWF+VZOg6H8buBbAHPw7N+VONU9CBBDN+svZ35szE2ywfNS2vfAhrlSnZ2BQgu
	 Rtni8vViJ/Uw37g5/3FIb0fuIYjbxgz3Cx/euHcdZL2g5L9o7syHUP8Q4Z3645MMFZ
	 uBzQhGGO8hJnQK2od+HJ+1GGxs0WEsXebK0dTwhiSd2WQXMh6Rzgyt7HaI9QnJGlUv
	 atY2qmLmEi+/Q==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-615917848ccso2310095eaf.3;
        Tue, 22 Jul 2025 05:49:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAgRONORJwU9caG5Q3LzfUC5CZbUBkRZdw3t5LA/wO3rqcre1BdqNBjYwFIxy+o2y/6AtUwea4e5k=@vger.kernel.org, AJvYcCUXbhckfQhDtB+Y7b8WCQttKVRYPdhWl8xv81pwvuMyXqTR4+PLvwqMFd3oWKavfRcg/z9ZqYiHiqFVEAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YymsKGbTGKSqUBa8U3fl/X3uwOiWxD8UsIgoDl03/h1NISe91ow
	9aWx3X7it1nxQmcZ4draIxhfjJpC70R7C3NIHNCbnwJUq3yd8/inherOWP8ya3ggQjS5URAo/wg
	Gx2NgAPtmStnSgStgP1R/7sd4Wxh8z8A=
X-Google-Smtp-Source: AGHT+IE3vY5VfRkQZJGE5LH0UPy3NmHppsPUk0J+JSPfl/jIoOHNu1vmE48QmnXhU9QSXT7v4+FQKEaiqfGXFkOlZ64=
X-Received: by 2002:a05:6820:260a:b0:611:e2fb:452 with SMTP id
 006d021491bc7-615a1ed647bmr16740739eaf.1.1753188553341; Tue, 22 Jul 2025
 05:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f8829843-111e-460f-9081-ee46c1f96ebc@linaro.org>
In-Reply-To: <f8829843-111e-460f-9081-ee46c1f96ebc@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 Jul 2025 14:49:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iOD-vb=P2i23QMwymXbHq_EMXdGsunDVk=M_L+gWOWTg@mail.gmail.com>
X-Gm-Features: Ac12FXwb03ky7TcGipqW62ljjtuldbyC7Bw7HY-JNRHeHWgNysEuahwLVZV4MhI
Message-ID: <CAJZ5v0iOD-vb=P2i23QMwymXbHq_EMXdGsunDVk=M_L+gWOWTg@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers for v6.17
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Mason Chang <mason-cw.chang@mediatek.com>, Luca Weiss <luca.weiss@fairphone.com>, 
	David Collins <david.collins@oss.qualcomm.com>, Aleksander Jan Bajkowski <olek2@wp.pl>, 
	Aaron Kling <webgeek1234@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, Jul 22, 2025 at 2:04=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> please consider the following changes since commit
> d7b8f8e20813f0179d8ef519541a3527e7661d3a:
>
>    Linux 6.16-rc5 (2025-07-06 14:10:26 -0700)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.17-rc1
>
> for you to fetch changes up to 1d264d3a198839c7483580acdce17e1015d0ef91:
>
>    dt-bindings: thermal: tegra: Document Tegra210B01 (2025-07-21
> 22:23:39 +0200)
>
> ----------------------------------------------------------------
> - Enable the stage 2 shutdown and support to more SPMI variants
>    (Anjelique Melendez)
>
> - Constify thermal_zone_device_ops structure when possible in the
>    different thermal drivers (Christophe Jaillet)
>
> - Use the dev_fwnode() helper instead of of_fwnode_handle() which is
>    more adequate wherever is possible in the thermal drivers (Jiri
>    Slaby)
>
> - Implement and document One-Time Programmable fuse support for the
>    Rockchip driver in order to increase the precision of the
>    measurements (Nicolas Frattaroli)
>
> - Change the way the Mediatek LTVS driver stores the initialization
>    data sequence to support different sequences regarding the current
>    platform. Introduce the mt7988 support with a new initialization
>    sequence (Mason Chang)
>
> - Document the QCom TSens Milos Temperature Sensor DT bindings (Luca
>    Weiss)
>
> - Add the fallback compatible string for MT7981 and MT8516 DT bindings
>    (Aleksander Jan Bajkowski)
>
> - Add the compatible string for Tegra210B01 SOC_THERM driver (Aaron Kling=
)
>
> ----------------------------------------------------------------
> Aaron Kling (1):
>        dt-bindings: thermal: tegra: Document Tegra210B01
>
> Aleksander Jan Bajkowski (1):
>        dt-bindings: thermal: mediatek: Add fallback compatible string
> for MT7981 and MT8516
>
> Anjelique Melendez (4):
>        thermal/drivers/qcom-spmi-temp-alarm: Add temp alarm data struct
> based on HW subtype
>        thermal/drivers/qcom-spmi-temp-alarm: Prepare to support
> additional Temp Alarm subtypes
>        thermal/drivers/qcom-spmi-temp-alarm: Add support for GEN2 rev 2
> PMIC peripherals
>        thermal/drivers/qcom-spmi-temp-alarm: Add support for LITE PMIC
> peripherals
>
> Christophe JAILLET (2):
>        thermal/drivers/loongson2: Constify struct thermal_zone_device_ops
>        thermal: Constify struct thermal_zone_device_ops
>
> David Collins (1):
>        thermal/drivers/qcom-spmi-temp-alarm: Enable stage 2 shutdown
> when required
>
> Jiri Slaby (SUSE) (1):
>        thermal: Use dev_fwnode()
>
> Luca Weiss (1):
>        dt-bindings: thermal: qcom-tsens: document the Milos Temperature
> Sensor
>
> Mason Chang (3):
>        thermal/drivers/mediatek/lvts_thermal: Change lvts commands array
> to static const
>        thermal/drivers/mediatek/lvts_thermal: Add lvts commands and
> their sizes to driver data
>        thermal/drivers/mediatek/lvts_thermal: Add mt7988 lvts commands
>
> Nicolas Frattaroli (4):
>        thermal/drivers/rockchip: Rename rk_tsadcv3_tshut_mode
>        dt-bindings: rockchip-thermal: Add RK3576 compatible
>        dt-bindings: thermal: rockchip: document otp thermal trim
>        thermal/drivers/rockchip: Support reading trim values from OTP
>
> Ye Zhang (1):
>        thermal/drivers/rockchip: Support RK3576 SoC in the thermal driver
>
>   .../bindings/thermal/mediatek,thermal.yaml         |  27 +-
>   .../bindings/thermal/nvidia,tegra124-soctherm.yaml |   2 +
>   .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
>   .../bindings/thermal/rockchip-thermal.yaml         |  62 +++
>   drivers/thermal/armada_thermal.c                   |   2 +-
>   drivers/thermal/da9062-thermal.c                   |   2 +-
>   drivers/thermal/dove_thermal.c                     |   2 +-
>   drivers/thermal/imx_thermal.c                      |   2 +-
>   .../intel/int340x_thermal/int3400_thermal.c        |   2 +-
>   drivers/thermal/kirkwood_thermal.c                 |   2 +-
>   drivers/thermal/loongson2_thermal.c                |  15 +-
>   drivers/thermal/mediatek/lvts_thermal.c            |  76 ++-
>   drivers/thermal/qcom/lmh.c                         |   3 +-
>   drivers/thermal/qcom/qcom-spmi-temp-alarm.c        | 596
> ++++++++++++++++++---
>   drivers/thermal/renesas/rcar_thermal.c             |   2 +-
>   drivers/thermal/rockchip_thermal.c                 | 251 ++++++++-
>   drivers/thermal/spear_thermal.c                    |   2 +-
>   drivers/thermal/st/st_thermal.c                    |   2 +-
>   drivers/thermal/tegra/soctherm.c                   |  13 +-
>   drivers/thermal/testing/zone.c                     |   2 +-
>   20 files changed, 921 insertions(+), 145 deletions(-)
>
> --

Pulled and added to linux-pm.git/thermal, thanks!

