Return-Path: <linux-pm+bounces-17792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA35C9D2FC2
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 21:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B0F1B23188
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 20:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2FE1D12FE;
	Tue, 19 Nov 2024 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOPodTh3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344E2149C7A;
	Tue, 19 Nov 2024 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732049424; cv=none; b=poaZ4WR6PId1X4Wm3rRtGvNoy/+43vBL4pm8JJymVAK2wcWm1BCYFw5txUxIWFLCSxuXt7URvLPmoUZkmY4fh3mZdoaJzIL0RrJXEAw4f3YsMJ8g/6sogTJE5MQeknGKEqJYgygwmr+9RdylVIC1wVaCNSt6b7FfMSvggY6CGcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732049424; c=relaxed/simple;
	bh=YC7FPxvqloNvgTHSRWA6CecG4gh3mAbn1f5UfQvl2QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVZ8spGFSzYsOOTuRLP5m+DUifb/xwkfi17NIv5TvEe3QZ1jv65PVa4z59jUPSLD/XhqTkOeAtt5ksiWwhhr/m3bWVKu//1Vmi8+ewcPhAdE/HSSVkhljPcxzXHf0cptsFXKCwRzxP+K8Gfa99hBX58CPi6C+C8S4W8pge7wEPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOPodTh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A26C4CED6;
	Tue, 19 Nov 2024 20:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732049423;
	bh=YC7FPxvqloNvgTHSRWA6CecG4gh3mAbn1f5UfQvl2QI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JOPodTh3d3nZTZW88H8EUnKZCV2D1lfVYRPJjzKNgMPR6cL46qoLPNMTDK3YiRi/Y
	 /kj5ocjLqDc1MWQZmgpT84vFdCqxFeQ1d71X5f7RcpD+HHGoSKnxgHHvMbgP0fmUoi
	 AYFkYEBj/i03JTIGLtQBDViJ2xIKmVtaUtZy00qb3g/7jCXYQm2An1F6+ONVm+r98F
	 4hRATlZfQWpwIebpR7Q1tN/GGXUW+Osk4LVMY6vgUK9STcigh53txpECoAq1TtG2IN
	 /97FMzkTBnVczvnjKbym2/U1Ve4+UcW35CgpnqZkt/tPFWSOoI9Iav8wBpJs+Vb8x/
	 gyMqGHCuIwREg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2689e7a941fso2652413fac.3;
        Tue, 19 Nov 2024 12:50:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrWQWHBOkdIHs4C43j/VZT1ZZQrzR4w5qE5Du4fJ+rzZ3x8F2brsdTyKp6aOyVPIEbjpvfHq18+so=@vger.kernel.org, AJvYcCXX1h282y0kLoWM5i3MCRmjvwH++luHK1E46xdk3E6iOq21XoDhu+LwPn+N9McY6cqo0/inJYebeEOucrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcjffZAlChCsskX9e0SEsa1p/Tb93p6zsHqcPxoTp+EyXy4s9z
	l9esvX+/0icEAEijo7yebq2ZMTnkj3U1rfO+raD/zh/iTPhzdno2X5CHZlg2vfVAA1luW0QhRNP
	G/umzr8f5oJOOjEmlZ4hBUlorDZQ=
X-Google-Smtp-Source: AGHT+IFmnD6S0h2LuEneHulsEtTDMn80TvgwIqntritFzKRRXZeaSL02qoZLaLax4SwuN7mFBnrlFXGzeG/WU+H/rhQ=
X-Received: by 2002:a05:6870:d148:b0:295:9cb2:71ea with SMTP id
 586e51a60fabf-296d9e465e8mr310368fac.39.1732049422990; Tue, 19 Nov 2024
 12:50:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2e8771be-3a0d-43d4-8787-41bc69d5287d@linaro.org>
In-Reply-To: <2e8771be-3a0d-43d4-8787-41bc69d5287d@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Nov 2024 21:50:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g0RaQSYmG6dk3nusBDLnuNHpE_+kXLe7fs-EKSGkUmWA@mail.gmail.com>
Message-ID: <CAJZ5v0g0RaQSYmG6dk3nusBDLnuNHpE_+kXLe7fs-EKSGkUmWA@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers for v6.13-rc1
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Colin Ian King <colin.i.king@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	=?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>, 
	zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, Rex Nie <rex.nie@jaguarmicro.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Mon, Nov 18, 2024 at 12:11=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi Rafael,
>
> please consider the following changes since commit
> c285b11e289dbe8973735ab8dc84210bde417673:
>
>    Merge back thermal control material for 6.13 (2024-11-11 15:20:44 +010=
0)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.13-rc1
>
> for you to fetch changes up to d303e3dd8d4648f2a1bb19944d4fb1c4a5030354:
>
>    tools/thermal: Fix common realloc mistake (2024-11-15 14:29:03 +0100)
>
> ----------------------------------------------------------------
> - Add the SAR2130P compatible in the DT bindings for the QCom Tsens
>    driver (Dmitry Baryshkov)
>
> - Add the static annotation to the arrays describing the platform
>    sensors on the LVTS Mediatek driver (Colin Ian King)
>
> - Switch back to the struct platform_driver::remove() from the
>    previous callbacks prototype rework (Uwe Kleine-K=C3=B6nig)
>
> - Add the MSM8937 compatible in the DT bindings and its support in the
>    QCom Tsens driver (Barnab=C3=A1s Cz=C3=A9m=C3=A1n)
>
> - Remove a pointless sign test on an unsigned value in
>    k3_bgp_read_temp() function on the k3_j72xx_bandgap driver (Rex Nie)
>
> - Fix a pointer reference lost when the call to realloc() fails in the
>    thermal library (Zhang Jiao)
>
> ----------------------------------------------------------------
> Barnab=C3=A1s Cz=C3=A9m=C3=A1n (2):
>        dt-bindings: thermal: tsens: Add MSM8937
>        thermal/drivers/qcom/tsens-v1: Add support for MSM8937 tsens
>
> Colin Ian King (1):
>        thermal/drivers/mediatek/lvts_thermal: Make read-only arrays
> static const
>
> Dmitry Baryshkov (1):
>        dt-bindings: thermal: qcom-tsens: Add SAR2130P compatible
>
> Rex Nie (1):
>        thermal/drivers/k3_j72xx_bandgap: Simplify code in k3_bgp_read_tem=
p()
>
> Uwe Kleine-K=C3=B6nig (1):
>        thermal: Switch back to struct platform_driver::remove()
>
> zhang jiao (1):
>        tools/thermal: Fix common realloc mistake
>
>   .../devicetree/bindings/thermal/qcom-tsens.yaml     |  2 ++
>   drivers/thermal/amlogic_thermal.c                   |  2 +-
>   drivers/thermal/armada_thermal.c                    |  2 +-
>   drivers/thermal/broadcom/bcm2835_thermal.c          |  2 +-
>   drivers/thermal/broadcom/ns-thermal.c               |  2 +-
>   drivers/thermal/da9062-thermal.c                    |  6 +++---
>   drivers/thermal/dove_thermal.c                      |  2 +-
>   drivers/thermal/hisi_thermal.c                      |  4 ++--
>   drivers/thermal/imx8mm_thermal.c                    |  2 +-
>   drivers/thermal/imx_thermal.c                       |  2 +-
>   .../thermal/intel/int340x_thermal/int3400_thermal.c |  2 +-
>   .../thermal/intel/int340x_thermal/int3401_thermal.c |  2 +-
>   .../thermal/intel/int340x_thermal/int3402_thermal.c |  2 +-
>   .../thermal/intel/int340x_thermal/int3403_thermal.c |  2 +-
>   .../thermal/intel/int340x_thermal/int3406_thermal.c |  2 +-
>   drivers/thermal/k3_bandgap.c                        |  2 +-
>   drivers/thermal/k3_j72xx_bandgap.c                  |  4 ++--
>   drivers/thermal/kirkwood_thermal.c                  |  2 +-
>   drivers/thermal/mediatek/lvts_thermal.c             |  6 +++---
>   drivers/thermal/qcom/tsens-v1.c                     | 21
> ++++++++++++++-------
>   drivers/thermal/qcom/tsens.c                        |  5 ++++-
>   drivers/thermal/qcom/tsens.h                        |  2 +-
>   drivers/thermal/renesas/rcar_gen3_thermal.c         |  2 +-
>   drivers/thermal/renesas/rcar_thermal.c              |  2 +-
>   drivers/thermal/renesas/rzg2l_thermal.c             |  2 +-
>   drivers/thermal/rockchip_thermal.c                  |  2 +-
>   drivers/thermal/samsung/exynos_tmu.c                |  2 +-
>   drivers/thermal/spear_thermal.c                     |  2 +-
>   drivers/thermal/sprd_thermal.c                      |  2 +-
>   drivers/thermal/st/st_thermal_memmap.c              |  2 +-
>   drivers/thermal/st/stm_thermal.c                    |  2 +-
>   drivers/thermal/tegra/soctherm.c                    |  2 +-
>   drivers/thermal/tegra/tegra-bpmp-thermal.c          |  2 +-
>   drivers/thermal/ti-soc-thermal/ti-bandgap.c         |  2 +-
>   drivers/thermal/uniphier_thermal.c                  |  2 +-
>   tools/thermal/thermometer/thermometer.c             |  7 ++++---
>   36 files changed, 62 insertions(+), 49 deletions(-)

Pulled and added to linux-pm.git/thermal and linux-pm.git/linux-next, thank=
s!

