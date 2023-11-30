Return-Path: <linux-pm+bounces-545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23EB7FEDF3
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 12:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA971C210C3
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8B93EA99;
	Thu, 30 Nov 2023 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PtI5AB0y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7879710F2
	for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2023 03:31:14 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5cd0af4a7d3so9523867b3.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Nov 2023 03:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701343873; x=1701948673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/HclVvX4CFRsOl+VZSwxHOAlC8On+bnCgFx4qFVgaY=;
        b=PtI5AB0ySw7fT/Q3ZOC06OG/RtVCFSMpVJpHRk+3ViHKe4K4J1fsxUbruQyUFTUqIs
         uYUA2YaRe7wqiXP/HkqSpIQiamxMBIUiqwq8B95S+PA8M9HH+JgmuBmFOHZI5g1y3OuT
         3BR4B/nDvkpNuM7SH+8WCOXM0gABIgyEO1x9SZ0kOVADazaHj+nTXvbauC55IezBpMdl
         MlQab81dPErFfeOxWHwPeUM+G5SiYhwz1ClKRH/+Mq85aUgMkCc+tx3N24Uk5ERU6cs2
         tAPe2moWG0t+FTbEfjhcsNlA5YCa60KtZsITNWcJHkmSGrVgEnhI3u1HgN5wFP56deHE
         BiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701343873; x=1701948673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/HclVvX4CFRsOl+VZSwxHOAlC8On+bnCgFx4qFVgaY=;
        b=HZc+erhgysxFW/bkIP0gEe6TudBh3YHG3pXesjYhqHWXWffkr2DPDaaTiNAXlq9dCB
         7xKbnMIQDZ9uZEQhQ+Z+ub6+fexFs8QemfKapu2e4T54LiaU4R8dymPtYr4QWLqFKbAt
         kSwsF+hqZoEfORqitqvtKvB0hOhi7Ih7y0laBBPpCybizG20NqV1n5Z4K8f52u07emw/
         OtMLyl6cqgWDpcrYc5CTWCKkwBFqw3xbki+053nEllbHah+5wy/YrKM1t4KGMjjcKzEj
         O5bks5nhh7TugHU8x4tEGwVFedfOBul89oTljtxQmIxoRkRC85ucz/jmXZewvERNDNlA
         dS9w==
X-Gm-Message-State: AOJu0YzBKEx0SCZJme48dWlsWd7fmAlR3OqIzu9Ouc/dbZjrR2tsEpQL
	/NX874vcw4T1vfgUAzF8xnJvowwlWVgi/3hVF33dmg==
X-Google-Smtp-Source: AGHT+IH1CnGwV597j2be6JXJ7H1sH3FUOqbojh7QGEEjE4QkfLLaWQrU1Lc/ACiw78MzsxK6+qZrL30ouvAAFN/Wn1g=
X-Received: by 2002:a0d:dec2:0:b0:5cd:c7a3:6cb3 with SMTP id
 h185-20020a0ddec2000000b005cdc7a36cb3mr21398845ywe.37.1701343873628; Thu, 30
 Nov 2023 03:31:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124080623.564924-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231124080623.564924-1-u.kleine-koenig@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 30 Nov 2023 12:30:37 +0100
Message-ID: <CAPDyKFqQeUsyHf4RC_FQTpm9G_LMYNAaC6EXtOmb_h_6rhUcfA@mail.gmail.com>
Subject: Re: [PATCH 0/9] pmdomain: Convert to platform remove callback
 returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Pengfei Li <pengfei.li_1@nxp.com>, Rob Herring <robh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Marco Felsch <m.felsch@pengutronix.de>, Peng Fan <peng.fan@nxp.com>, 
	Jindong Yue <jindong.yue@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Marek Vasut <marex@denx.de>, Deepak R Varma <drv@mailo.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Heiko Stuebner <heiko@sntech.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Nov 2023 at 09:10, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> this patch set converts all drivers below drivers/pmdomain to use struct
> platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
> Provide a remove callback that returns no value") for an extended
> explanation and the eventual goal.
>
> While working on drivers/pmdomain/imx/gpc.c I noticed three issues, but
> didn't address them:
>
>  - The driver uses builtin_platform_driver twice. The documentation
>    however mandates that "Each driver may only use this macro once".
>    I don't know if the documentation is wrong and using it twice works
>    as intended.
>
>  - imx_gpc_remove() only removes two PDs, but there might be up to four?!
>
>  - In imx_gpc_remove() if
>    pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_PU].base) fails,
>    removing the ARM PD is skipped. So together with the previous item
>    the driver leaks up to three genpd instances.
>
> Maybe someone caring for this driver will pick these up and prepare
> patches? Ideally pm_genpd_remove() should return void caring for still
> existing providers, parents and devices in generic code. I think that
> erroring out in genpd_remove() before the PM domain is removed from the
> various lists might result in use-after-free errors.
>
> Best regards
> Uwe
>
> Uwe Kleine-K=C3=B6nig (9):
>   pmdomain: imx-pgc: Convert to platform remove callback returning void
>   pmdomain: imx-gpc: Convert to platform remove callback returning void
>   pmdomain: imx-gpcv2: Convert to platform remove callback returning
>     void
>   pmdomain: imx8m-blk-ctrl: Convert to platform remove callback
>     returning void
>   pmdomain: imx8mp-blk-ctrl: Convert to platform remove callback
>     returning void
>   pmdomain: imx93-blk-ctrl: Convert to platform remove callback
>     returning void
>   pmdomain: imx93-pd: Convert to platform remove callback returning void
>   pmdomain: qcom-cpr: Convert to platform remove callback returning void
>   pmdomain: xilinx/zynqmp: Convert to platform remove callback returning
>     void
>
>  drivers/pmdomain/imx/gpc.c                  | 28 +++++++++++----------
>  drivers/pmdomain/imx/gpcv2.c                |  6 ++---
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c       |  6 ++---
>  drivers/pmdomain/imx/imx8mp-blk-ctrl.c      |  6 ++---
>  drivers/pmdomain/imx/imx93-blk-ctrl.c       |  6 ++---
>  drivers/pmdomain/imx/imx93-pd.c             |  6 ++---
>  drivers/pmdomain/qcom/cpr.c                 |  6 ++---
>  drivers/pmdomain/xilinx/zynqmp-pm-domains.c |  6 ++---
>  8 files changed, 29 insertions(+), 41 deletions(-)
>

The series applied for next, thanks!

Kind regards
Uffe

