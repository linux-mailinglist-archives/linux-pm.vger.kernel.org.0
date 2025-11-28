Return-Path: <linux-pm+bounces-38878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F41C91F11
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 13:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 996554E5636
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 12:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFCE30CD95;
	Fri, 28 Nov 2025 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlzIja29"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464CA30BF62
	for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764331563; cv=none; b=E+QeeMQ7ScMW9SHw/HShaAMm4zNzmcu1pQTBb9MFDnn6seCnWA8mWMapgnKBWpDXJuesv+qiAR9V2acHmCn4hx0pQCiyH5jZkmhtyCo1Q2LP006oINMAz2qX2Ticm6dqXHHVlka2oSqpHC6WVdmFrFJkgp2UWAJ02mhftSM/QE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764331563; c=relaxed/simple;
	bh=7oWurJlrCrne/H/0oPlGiBUmGNe8ZE2w4wilOWHimmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J00zqP6YWV+AfzAjzs18h3Cw3z9c2uL7WE94qNayM5OE6ClX+i708A+SlsyJbAYIvBKBsJVG6NfudRaoAW1K4/yqjp74BFfboVRowsqO15soYdAMJGO0uYNhPAvKIp/bXwGlxgQRJ55clzajTAK0157zcPyS0UKOkH7KzPcv/ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlzIja29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3C9C19422
	for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 12:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764331563;
	bh=7oWurJlrCrne/H/0oPlGiBUmGNe8ZE2w4wilOWHimmA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KlzIja29xCWrgafxrYWp8it8Js846MhCj1NCHT9tC2AmZ+vSjgFJzE5bdV42GAUeA
	 Z4dMcSX008CQfry8AXjB37qGL2q5gKByo5FmzPXD1owMxOLv7f8nWh76xTD1Suhh85
	 BJEZxM/YRptVmPmqm8IHHCRUoJ6MMEQLSoHjD+0k14sH+0BAhf/QOiUbB9HbG759vf
	 UEHCGprp3vZlebSaYFgj+n3Y4R9TSFWXz3RDU+A/h7RLsLozKl/nJ/o0CBpXKBF3he
	 kd2Vs6sifPyednzVPTla3HJeElUavTxl8YDFjCq5k4gOSivYpPmxm/qEoA2fJ2AUeh
	 luco9WHU+ZQ4g==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3ed151e8fc3so906412fac.2
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 04:06:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpDeVesvLhqPdMWyZrrFB1HGBkDl1K9yXyUCBWRSLRwasMoFpuyDsa7hVTCROuohRr17yT+HjbfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzanOd0G0EdiDsyeqmnWSsl51bL/8BfOGlNlkn3rk69cMb9JHMs
	WTEIlrMdVo8dykBFdtV9Y/zOuk6Bc6Zu894mXU4w+jMZERkVQ8VOdFvfokGXmyhr3W0EVqAW45T
	G2n91VXODdPutIxfhEBlTIFaE1f6I/Pw=
X-Google-Smtp-Source: AGHT+IETqATLOm1485jDqq5eMTXHikfkOFyXFBL4DbElQhIXDtAVxsNowFFUvTTUbLliWwvopgBKr27gVGJG0uVXyu8=
X-Received: by 2002:a05:6808:d50:b0:450:c4bb:7550 with SMTP id
 5614622812f47-4514e8343e7mr6013379b6e.62.1764331562412; Fri, 28 Nov 2025
 04:06:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0b771d57-b280-4c54-886e-6b2c4602212b@linaro.org>
In-Reply-To: <0b771d57-b280-4c54-886e-6b2c4602212b@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 28 Nov 2025 13:05:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jjmrSHO-YoU7ThJkYedhd1Y9fyRsdP-YTEr-j1wyAxOw@mail.gmail.com>
X-Gm-Features: AWmQ_bk4ObMzIHFjvsGacnIsuMUXBT7nhD3fVvdIQxhNFei5h_tsq5dkhPJ8xuw
Message-ID: <CAJZ5v0jjmrSHO-YoU7ThJkYedhd1Y9fyRsdP-YTEr-j1wyAxOw@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers update for v6.19-rc1
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Gaurav Kohli <quic_gkohli@quicinc.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Malaya Kumar Rout <mrout@redhat.com>, 
	Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>, marek.vasut+renesas@gmail.com, 
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Pengfei Li <pengfei.li_1@nxp.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Thu, Nov 27, 2025 at 4:50=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi Rafael,
>
> The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8bec=
aa:
>
>    Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.19-rc1
>
> for you to fetch changes up to c411d8bf06992dade7abb88690dc2d467a868cc4:
>
>    thermal/drivers/imx91: Add support for i.MX91 thermal monitoring unit
> (2025-11-26 15:51:28 +0100)
>
> ----------------------------------------------------------------
> - Document the RZ/V2H TSU DT bindings (Ovidiu Panait)
>
> - Document the Kaanapali Temperature Sensor (Manaf Meethalavalappu
>    Pallikunhi)
>
> - Document R-Car Gen4 and RZ/G2 support in driver comment (Marek
> Vasut)
>
> - Convert to DEFINE_SIMPLE_DEV_PM_OPS in the R-Car [Gen3] (Geert
>    Uytterhoeven)
>
> - Fix format string bug in thermal-engine (Malaya Kumar Rout)
>
> - Make ipq5018 tsens standalone compatible (George Moussalem)
>
> - Add the QCS8300 compatible for the QCom Tsens (Gaurav Kohli)
>
> - Add the support for the NXP i.MX91 thermal module, including the DT
>    bindings (Pengfei Li)
>
> ----------------------------------------------------------------
> Gaurav Kohli (1):
>        dt-bindings: thermal: tsens: Add QCS8300 compatible
>
> Geert Uytterhoeven (2):
>        thermal/drivers/rcar: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
>        thermal/drivers/rcar_gen3: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
>
> George Moussalem (1):
>        dt-bindings: thermal: qcom-tsens: make ipq5018 tsens standalone
> compatible
>
> Malaya Kumar Rout (1):
>        tools/thermal/thermal-engine: Fix format string bug in thermal-eng=
ine
>
> Manaf Meethalavalappu Pallikunhi (1):
>        dt-bindings: thermal: qcom-tsens: document the Kaanapali
> Temperature Sensor
>
> Marek Vasut (1):
>        thermal/drivers/rcar_gen3: Document R-Car Gen4 and RZ/G2 support
> in driver comment
>
> Ovidiu Panait (1):
>        dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2H TSU
>
> Pengfei Li (2):
>        dt-bindings: thermal: fsl,imx91-tmu: add bindings for NXP i.MX91
> thermal module
>        thermal/drivers/imx91: Add support for i.MX91 thermal monitoring u=
nit
>
>   .../devicetree/bindings/thermal/fsl,imx91-tmu.yaml |  87 +++++
>   .../devicetree/bindings/thermal/qcom-tsens.yaml    |   9 +-
>   .../bindings/thermal/renesas,r9a09g047-tsu.yaml    |   6 +-
>   drivers/thermal/Kconfig                            |  10 +
>   drivers/thermal/Makefile                           |   1 +
>   drivers/thermal/imx91_thermal.c                    | 384
> +++++++++++++++++++++
>   drivers/thermal/renesas/rcar_gen3_thermal.c        |  10 +-
>   drivers/thermal/renesas/rcar_thermal.c             |   8 +-
>   tools/thermal/thermal-engine/thermal-engine.c      |   2 +-
>   9 files changed, 504 insertions(+), 13 deletions(-)
>   create mode 100644
> Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml
>   create mode 100644 drivers/thermal/imx91_thermal.c

Pulled and added to linux-pm.git/thermal, thanks!

