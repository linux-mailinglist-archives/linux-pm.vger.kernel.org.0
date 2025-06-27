Return-Path: <linux-pm+bounces-29668-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35270AEB9E3
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 16:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69EA917EBF0
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1141B17A309;
	Fri, 27 Jun 2025 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X15TK5B2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330B63FC2
	for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751034695; cv=none; b=e3A0ZUQdwMDfTyWzLqQns5ZwQfz8k2VC+K4ChDXPQEvWqSjPKq4pcqfzE0UP49eLR9DLjVQDMWfb++NZlcWHimz0j+57Z5FmoFdw4C+G5d8dril3oRG7WZ0lL5d6FQJmCh4sJOMc+FE5LpRrsHnXL2ZUW1TuxO5+iRqm5OLBrDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751034695; c=relaxed/simple;
	bh=B1BdE0J+jY6ME5BrRSZux1zOeKpTZZ4DlpXlyhs8zxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPEYIjZw7kuxPVCupS+1pNHwn++OwBYI/LW7EBrge6Lpm8+3cjsoD1Neyih5dXOGCvgtUb8tk4xrLRmWrtPzocHXSNNfkPll67a8yzV3vYU5gf/QTKtsTbLjeBiCJuFuAlopmZyepYtOCiLYH0ZdMSyc6IlGqozQ9GEvM4x7FnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X15TK5B2; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c79bedc19so2762184a12.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 07:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751034691; x=1751639491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8o5xo7GeehPDbRd+X/7D8FpirwN/TZkXVzx9zL2sssc=;
        b=X15TK5B2V1rLeKkJ9wU5Xr0orKYbmRRqGr9S0RVf2ulX2MghILw3tjttiglnpKsyIN
         CRXcaUxMqgmZwfdT5inUh5hTtd8LF8YFhWlnE9wYyP2T4iDAVSVs8ytbigF9VK/llu9P
         iD4hW8Jb0DiLH6OXbJxkMEVL5C5qNUxoKevMQZ4IEsHENA4/RThtxOJakLgX7+Nm32HZ
         e3eXwXlKIoczXAhAGo3cAsKZvWZBGmemfQO6alAIaKrLREmmd1/rs+1+xug+waFxotd3
         WTUMATMEZB5etKoIISu5G6GiTiIYzaGWAx/glxIY858o9BTWoKCkZO4cI30p8SOJzBDs
         UKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751034691; x=1751639491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8o5xo7GeehPDbRd+X/7D8FpirwN/TZkXVzx9zL2sssc=;
        b=eO6MA7qyLxw7/H/YBBVAqPOQRlIh3ZpQCz0A/v7z2XgD20IgReVQVe0saVnGcWF7f0
         81VthSFyVA7VvfTyYDovGGNuS1Z79ENLkWpAvL/CbVTu9uQ7Yr7pnEwfftKiML5D72Ae
         WBWCdIbiDf1oKOHHPlTzyRBz8+aodQCek2DWwKAWtt0HwIvzYWWCPHy/BMddCwLZMa2t
         Ugb8TEVx9Ze0yYjMyaCRbszC/MJzi7u9Tj2xB0NqXNxJIk/ODvo+LyKrmpuo28G2s9Zu
         MZZlqXenkHMirqgy0g1FsSEO4pH1hh01V2r3raQBP3Y/dLQnLSCdcliuhzWp2zXBj1TC
         m2iA==
X-Forwarded-Encrypted: i=1; AJvYcCW/KIrZBs28uSGTtVXAhKvRRmBvMtb7nQI5S1VVllw4EB2ebT6MXBzDhj83Os3faZ5hSkpgY819wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVR/9CRW8wYDd8PfIuGZZYiipLbW8iMguHCwk6uC0o7rk0sW3O
	E6gjr8djEyjZP9uW2auxHslZpkeLv4jdVdl8rDQ6N0OcMS2iQD5/dhMWAPwXtp0bc9iiMZ3k99r
	R93/dKLL/a9vrVkJwxlYzOBSn99U5OcLgNEy2VfBFpA==
X-Gm-Gg: ASbGncsiWKJ/Mcxmguw65jsz3dzER16l2vtY1D6RdddorX1p9XK388ZUnjWF2Brzuep
	gCPIWbff/VU1HEKmAioz8LNOiadySnrNWKcp7rzDgLbKb9/2okhmQ7jbcNskoXx4oejo7EYW4uM
	3Dnm06vP/k+cU/DvOyySZdCChzv3RCaEh1zNUC3AlRUmod4USnSAs1/SzsFXm+D9+/jJbBgSdpZ
	UjcLw==
X-Google-Smtp-Source: AGHT+IEL785XIeur6WCbc2OIj5nk/sVLVVNkV3GZ+ObEePJ/qNpPBLIGoWwmBJBgA18YqNdBbv+6Y6RgOuBSpzWsw/4=
X-Received: by 2002:a05:6402:5bc4:b0:607:eeb1:b18b with SMTP id
 4fb4d7f45d1cf-60c88d9c37dmr2283943a12.8.1751034691378; Fri, 27 Jun 2025
 07:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626215911.5992-1-hiagofranco@gmail.com>
In-Reply-To: <20250626215911.5992-1-hiagofranco@gmail.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Fri, 27 Jun 2025 08:31:20 -0600
X-Gm-Features: Ac12FXyLrcISUGMKifq1LXY0djWn87ywvC4vhLqatRfOsnXR-16wTizuirmCxWY
Message-ID: <CANLsYkzo32BHkxRzSLY1U_PcidMPOaz7xZjDs8HKtTCQ0ZpF=g@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] remoteproc: imx_rproc: allow attaching to running
 core kicked by the bootloader
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@oss.nxp.com>, daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Jun 2025 at 15:59, Hiago De Franco <hiagofranco@gmail.com> wrote:
>
> From: Hiago De Franco <hiago.franco@toradex.com>
>
> This patch series depends on Ulf's patches that are currently under
> review, "pmdomain: Add generic ->sync_state() support to genpd" [1].
> Without them, this series is not going to work.
>

I thought we agreed to repost when the feature referred to above and
the work in drivers/pmdomain/core.c will be merge.  I'm not sure what
to do with this patchset.

> For the i.MX8X and i.MX8 family SoCs, currently when the remotecore is
> started by the bootloader and the M core and A core are in the same
> partition, the driver is not capable to detect the remote core and
> report the correct state of it.
>
> This patch series implement a new function, dev_pm_genpd_is_on(), which
> returns the power status of a given power domain (M core power domains
> IMX_SC_R_M4_0_PID0 and IMX_SC_R_M4_0_MU_1A in this case). If it is
> already powered on, the driver will attach to it.
>
> Finally, the imx_rproc_clk_enable() function was also changed to make it
> return before dev_clk_get() is called, as it currently generates an SCU
> fault reset if the remote core is already running and the kernel tries
> to enable the clock again. These changes are a follow up from a v1 sent
> to imx_rproc [2] and from a reported regression [3].
>
> [1] https://lore.kernel.org/all/20250523134025.75130-1-ulf.hansson@linaro.org/
> [2] https://lore.kernel.org/lkml/20250423155131.101473-1-hiagofranco@gmail.com/
> [3] https://lore.kernel.org/lkml/20250404141713.ac2ntcsjsf7epdfa@hiago-nb/
>
> v6:
> - Added "reviewed by" from Ulf and Bjorn.
> - Fixed and improved commit descriptions of patches 2 and 3.
> - Improved the comment inside imx_rproc.c file.
> v5:
> - https://lore.kernel.org/all/20250617193450.183889-1-hiagofranco@gmail.com/
> v4:
> - https://lore.kernel.org/lkml/20250602131906.25751-1-hiagofranco@gmail.com/
> v3:
> - https://lore.kernel.org/all/20250519171514.61974-1-hiagofranco@gmail.com/
> v2:
> - https://lore.kernel.org/lkml/20250507160056.11876-1-hiagofranco@gmail.com/
> v1:
> - https://lore.kernel.org/lkml/20250505154849.64889-1-hiagofranco@gmail.com/
>
> Hiago De Franco (3):
>   pmdomain: core: introduce dev_pm_genpd_is_on()
>   remoteproc: imx_rproc: skip clock enable when M-core is managed by the
>     SCU
>   remoteproc: imx_rproc: detect and attach to pre-booted remote cores
>
>  drivers/pmdomain/core.c        | 33 +++++++++++++++++++++++++++
>  drivers/remoteproc/imx_rproc.c | 41 ++++++++++++++++++++++++++++------
>  include/linux/pm_domain.h      |  6 +++++
>  3 files changed, 73 insertions(+), 7 deletions(-)
>
> --
> 2.39.5
>

