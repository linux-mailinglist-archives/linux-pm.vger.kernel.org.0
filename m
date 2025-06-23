Return-Path: <linux-pm+bounces-29364-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6207AE48CE
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 17:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31E644527A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6404A277029;
	Mon, 23 Jun 2025 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sz/7GcPR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AD0276025
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692780; cv=none; b=pZ4jCG91OvDfBPn2rPoYtbmw7l23TtJXEtWAQj/k+NBXFkwDwJRgVYKAmwn0iIlbRpPffYRetiTo7Vd6bTLQwL5c0/v/AXJsqDUEzNsNo2yVQbptAGEbiS173YjkfWLC0A7CzeTYspgjAcRS2jOVbanvBI9l+d/fvthr0EhDwuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692780; c=relaxed/simple;
	bh=K7nJQgtBbSh9bg4c43k2d/lR0pxtXBYTwkLYTeoGBZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPsclm8PE2ll/q1uMKrsEFX62w0nYA6ZK3Y6ll7TcwWKEag6RSq/9NPCsraJUAAcS6QnEJmA29Ws+MyqqGOF5yHOXM4fpugCCodCI9S7X4c5Y/bVnpyeFLGfOW+MfbSbbWbyZ6eQnfhYKkSijjPlBag8B4NMTIXHlNAjiYnKIMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sz/7GcPR; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b31e076f714so3571947a12.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750692778; x=1751297578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1KRVwjnf5Gu74AF6Zl0ciz1iQ0kZ7/1mY4qiKdYpBHw=;
        b=Sz/7GcPRzGtRWzkw6jaJTglWqDbL3fett95gP0SRFVHbyZwdkqOIpE59YJP7pYPOQl
         WMqoIrOpLYnvKy85aGOncZMDb+cQ7PG4niWqtG8ZOLi5TJpHaoh0iZXdBv1JDsIDeQwn
         hV9KnSjS4N/4T9ME5WB44xEdt+PRvA86O8qBYHKmWTg3i6nPQWFVCeQtZGkfzVqNw/4V
         YhcSKrOOguwi/DO/aZ58zB3T3sq57FCZ3pyb02sJvJgLBV9reQop9nhR3r2Bht/0vGfJ
         qltMvcpUbin93ibHPG8EyjqO4b8nQElvO8jygX4he2fISU1xXRbOT3A3AzqNr7BbkRZs
         F+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750692778; x=1751297578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KRVwjnf5Gu74AF6Zl0ciz1iQ0kZ7/1mY4qiKdYpBHw=;
        b=Z0WjJRhEAXoilHFVRFFA75Ulwkoc5R90HsvQB6Xbp+7pKED1PPgVjeC5hREd5GqMno
         crwsQPE0vdSEFrN6qOeOVwUMLE4Tg7fph0pbt48r6vMOMbbWFwqwzvplvgJvaaKRys0v
         U4Cw9ITGAkadvq1VrS6PBM3FRSMV90twN1R4NtXzZo5k9LwrE8qAmAI3wTaQUoCi6SVm
         JQM6JGlqYfTXo+jjc+NPPxEfmcRi7UaKJt6J/EqiuSVRmAofdAyc7P9rUBQyhkjzVGg3
         mh4yJAqHTjYA/OV7k1clouJevVdEqUE4B8NFAyfRHue9H24mP2OHcCN/KwIDfOLuzx4e
         LKVA==
X-Forwarded-Encrypted: i=1; AJvYcCVn9xa5kd5/hbWvKzAmhP7sg7ybcjDvSjxgvVLBQlRNnJ4J5zWAn90J478QNa3qSJsYG7OKTpwCOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyffHIrHaWlJHz9hVPbTegLLUMBZq6qK4dkJXSgcDGqu2PVQqj1
	AiY38QRcAdlI9AIJnIqTQmK38t667o2oMe5xUZXm2r3Oun9FHEeF2iixeVnr9y3tnvc=
X-Gm-Gg: ASbGncvJT1Dojo9ITZ5WOuS49XtmWMhWWOERSDtceer5rF42nGMPBEUixPGVug/ZRI9
	hcnVPaRp/CSBDHYBlcyENPXAaVz7kXg6hcVo4LDZU6WUPWQ2W9F2PraC1zTUWypX5FKFQZ95yrA
	s7zUDbkkpLONUfKinCpOyW+7JgOS7r6WFwQRsiTjWvnlfLjJp3DU6QeoEFRQyQ8e/J3Tr9tAfel
	a4DB/2AFxKba4ai9nO3ZAOjUuI/CtyhBMqKmOxDxdJNNx9JjpEW1zeafCWypKCcrKlsmlxswTtD
	2+hXyE/HwcjtcKqMQjkmpiIiL5DqTpZp+tY5pVnuo4k5Hv6ebfYusCtXfsNN2+7o
X-Google-Smtp-Source: AGHT+IGNVVPK2gkJtWTZs/pQbffW/A6+VZyFx1ATrRb4chkU190AUhzC35954VZWOOfCqbAJDEPO/A==
X-Received: by 2002:a17:90b:2e04:b0:30c:4bac:1da1 with SMTP id 98e67ed59e1d1-3159f52d0fbmr19149295a91.17.1750692777852;
        Mon, 23 Jun 2025 08:32:57 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:d145:b99:ea4b:a65f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a226f6fsm11220540a91.6.2025.06.23.08.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:32:57 -0700 (PDT)
Date: Mon, 23 Jun 2025 09:32:54 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@oss.nxp.com>, daniel.baluta@nxp.com,
	iuliana.prodan@oss.nxp.com,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 0/3] remoteproc: imx_rproc: allow attaching to running
 core kicked by the bootloader
Message-ID: <aFlzpnT1yNGdWWkH@p14s>
References: <20250617193450.183889-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617193450.183889-1-hiagofranco@gmail.com>

On Tue, Jun 17, 2025 at 04:34:47PM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> This patch series depends on Ulf's patches that are currently under
> review, "pmdomain: Add generic ->sync_state() support to genpd" [1].
> Without them, this series is not going to work.

Please resend this patchset when [1] and the work in patch 1/3 have been merged.

Thanks,
Mathieu

> 
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
> v5:
> - pm_runtime_get_sync() removed in favor of pm_runtime_resume_and_get(),
>   checking the return value of it.
> - Added pm_runtime_disable() and pm_runtime_put() to imx_rproc_remove().
> - Fixed missing "()" in dev_pm_genpd_is_on description.
> - Updated dev_pm_genpd_is_on() function description to be explicit the
>   function reflects the current power status of the device and that this
>   might change after the function returns, especially if the genpd is
>   shared.
> 
> v4:
> - https://lore.kernel.org/lkml/20250602131906.25751-1-hiagofranco@gmail.com/
> 
> v3:
> - https://lore.kernel.org/all/20250519171514.61974-1-hiagofranco@gmail.com/
> 
> v2:
> - https://lore.kernel.org/lkml/20250507160056.11876-1-hiagofranco@gmail.com/
> 
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

