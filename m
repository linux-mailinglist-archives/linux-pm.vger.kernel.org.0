Return-Path: <linux-pm+bounces-13926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0422972CC9
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 11:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C65A2894AB
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 09:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456C9187FE8;
	Tue, 10 Sep 2024 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krsIAYSh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E4418784B
	for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958963; cv=none; b=MnyDL9UhO/nj/WnWsytz1orp49yVJ/zRhDirfiq6U9JjzrVwdxaoP/hNCrlv8fcPsnyE+vhqaZz3icZa10i70ZAGlznDoPen3PgXDH1qtdUzx4TYqlNkEhDlkOxkVdGKIoglnXtEpCsq9OxIenbiWQqQaOcrK3KMzkJDsIgPYnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958963; c=relaxed/simple;
	bh=X4DbS8J4R5xEljdhS8EidOfHXKoAzLYcu5FjoBl4HSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPkK0CYtg4aYnaB7d3CUMT5VWTwe4BncVFPEhIpL3xcvfCipQqH8YUPzVr8g6rw5hbU/DqvxavnxAV6eZj5PJeF7Zt16F0rjtJjgBW9jC3ERu06Hu7Q2m2DBFk/4BJr2rJ/SIkJ1Vl0sktxSvEb2rY8Rs46kLaokAk8FfIAs3+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krsIAYSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0240C4CECC
	for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 09:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725958962;
	bh=X4DbS8J4R5xEljdhS8EidOfHXKoAzLYcu5FjoBl4HSQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=krsIAYShVNJWXauls5mjWXOfgISYBTGZqEz4aDC20Xrg837Hdo+DusowkOW8pt9h5
	 eZCWz3ILt1zgaOM3ADRJ9R8Q41tST20nUTig/GDappnENhPCjyLiRo+byI33im6ucD
	 dWssIK9MmYh5sJmCuqzlV9V367dH4ekj6YQhfb1MCB6ZzmP0fXdhTTffONXwzr4w5N
	 qJ7ARDa9wQCQhg0s1v529HRMz81f4zLlGrbk2oDkznPbPaSubXEkcwNUSbrrgP9ky6
	 RTI4hUxRVe9tAe8pOjqzoGhE7M9P8VwyfCfXlQi51jsoDysmub92tSU1ryacLHDlGx
	 R3oIg4iHCEanA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5e1baf0f764so1298796eaf.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 02:02:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNDy+5pSFOKUVnPIi3mqce7BUk0Vi3dteAa69ipxaJlaWDMTgQ/ocrXIE9NFdqtsYkl8py0F39uA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrRj1YRFhdcVACtUbBt2vug+SPqWEF0648vbAquV6+A0f5ONk3
	j4sO6J78GXXjqRRHFiXOCo35SFyo4j/fo073j3mekZv3HWKP1IntyiIW0SjD9MxMCn4UDXA9eGC
	MCRM1nUP+bQCAMwiZYPsAMLH+4vI=
X-Google-Smtp-Source: AGHT+IG9B4hjIRNCUNrcpojj+QaVbDnExpUxje+py3AH831RSWHjPUm8xJIVyquC8O2p9TKFKf6mVAYdm7FXQg4hMO0=
X-Received: by 2002:a05:6820:623:b0:5e1:dcd2:aa4c with SMTP id
 006d021491bc7-5e1dcd2aea0mr3330641eaf.8.1725958961970; Tue, 10 Sep 2024
 02:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3a7fa69f-9cee-48f0-a932-7362f600b6a6@linaro.org>
In-Reply-To: <3a7fa69f-9cee-48f0-a932-7362f600b6a6@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Sep 2024 11:02:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iGCucf4rH8M8=LucjNFFKT2Ov0OqyQJtE2oGsW-R4Nsw@mail.gmail.com>
Message-ID: <CAJZ5v0iGCucf4rH8M8=LucjNFFKT2Ov0OqyQJtE2oGsW-R4Nsw@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers changes for v6.12-rc1
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Raphael Gallais-Pou <rgallaispou@gmail.com>, 
	George Stark <gnstark@salutedevices.com>, Yan Zhen <yanzhen@vivo.com>, 
	Fabio Estevam <festevam@denx.de>, Zhang Zekun <zhangzekun11@huawei.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Lukasz Luba <Lukasz.Luba@arm.com>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Fri, Sep 6, 2024 at 1:24=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
>
> Hi Rafael,
>
> please consider pulling the following changes. This cycle has been quite
> quiescent and the changes are mostly related to code cleanups and DT
> bindings.
>
> Thanks
>
>
> The following changes since commit f5c05974349c8e3d80e125b71bd80695807d85=
28:
>
>    Merge branch 'thermal-core' (2024-08-29 11:45:08 +0200)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.12-rc1
>
> for you to fetch changes up to 7d8abc5f3b5ce0f53d499279d8defc0f72bf7557:
>
>    thermal/drivers/imx_sc_thermal: Use dev_err_probe (2024-09-04
> 15:31:29 +0200)
>
> ----------------------------------------------------------------
> - Add power domain DT bindings for new Amlogic SoCs (Georges Stark)
>
> - Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() in the ST
>    driver and add a Kconfig dependency on THERMAL_OF subsystem for the
>    STi driver (Raphael Gallais-Pou)
>
> - Simplify with dev_err_probe() the error code path in the probe
>    functions for the brcmstb driver (Yan Zhen)
>
> - Remove trailing space after \n newline in the Renesas driver (Colin
>    Ian King)
>
> - Add DT binding compatible string for the SA8255p with the tsens
>    driver (Nikunj Kela)
>
> - Use the devm_clk_get_enabled() helpers to simplify the init routine
>    in the sprd driver (Huan Yang)
>
> - Remove __maybe_unused notations for the functions by using the new
>    RUNTIME_PM_OPS() and SYSTEM_SLEEP_PM_OPS() macros on the IMx and
>    Qoriq drivers (Fabio Estevam)
>
> - Remove unused declarations in the header file as the functions were
>    removed in a previous change on the ti-soc-thermal driver (Zhang
>    Zekun)
>
> - Simplify with dev_err_probe() the error code path in the probe
>    functions for the imx_sc_thermal driver (Alexander Stein)
>
> ----------------------------------------------------------------
> Alexander Stein (1):
>        thermal/drivers/imx_sc_thermal: Use dev_err_probe
>
> Colin Ian King (1):
>        thermal/drivers/renesas: Remove trailing space after \n newline
>
> Fabio Estevam (2):
>        thermal/drivers/qoriq: Remove __maybe_unused notations
>        thermal/drivers/imx: Remove __maybe_unused notations
>
> George Stark (1):
>        dt-bindings: thermal: amlogic,thermal: add optional power-domains
>
> Huan Yang (1):
>        thermal/drivers/sprd: Use devm_clk_get_enabled() helpers
>
> Nikunj Kela (1):
>        dt-bindings: thermal: tsens: document support on SA8255p
>
> Raphael Gallais-Pou (2):
>        thermal/drivers/st: Switch from CONFIG_PM_SLEEP guards to
> pm_sleep_ptr()
>        thermal/drivers/sti: Depend on THERMAL_OF subsystem
>
> Yan Zhen (1):
>        thermal/drivers/brcmstb_thermal: Simplify with dev_err_probe()
>
> Zhang Zekun (1):
>        thermal/drivers/ti-soc-thermal: Remove unused declarations
>
>   .../bindings/thermal/amlogic,thermal.yaml          |  3 ++
>   .../devicetree/bindings/thermal/qcom-tsens.yaml    |  1 +
>   drivers/thermal/Kconfig                            |  2 +-
>   drivers/thermal/broadcom/brcmstb_thermal.c         | 15 ++++------
>   drivers/thermal/imx_sc_thermal.c                   |  3 +-
>   drivers/thermal/imx_thermal.c                      | 16 +++++------
>   drivers/thermal/qoriq_thermal.c                    | 10 +++----
>   drivers/thermal/renesas/rcar_thermal.c             |  2 +-
>   drivers/thermal/sprd_thermal.c                     | 14 ++--------
>   drivers/thermal/st/st_thermal.c                    | 32
> ++++++++--------------
>   drivers/thermal/st/st_thermal_memmap.c             |  2 +-
>   drivers/thermal/st/stm_thermal.c                   |  8 ++----
>   drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  4 ---
>   13 files changed, 45 insertions(+), 67 deletions(-)
>
> --

Pulled and added to the linux-next branch in linux-pm.git, thanks!

