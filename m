Return-Path: <linux-pm+bounces-11914-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFEE947A69
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 13:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E02C1F22001
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 11:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9615E155741;
	Mon,  5 Aug 2024 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxYoN6Ho"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E2D154BFC
	for <linux-pm@vger.kernel.org>; Mon,  5 Aug 2024 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722857718; cv=none; b=nOVJx7SVGjrynJ7VhcfINTU8nff36LsYmlQUSSS9VwTviTw+D0G1gcKialEoH5nQU6O/TCUlyLLRbUYSH7VOr2Iye1ry62rOEVkQtJ99Iz7kXuKvZEvLPZH/BMSPCFkR8zmI56v7454xHtDxOLKrHcbYa09fWcSlkKNbIGThfmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722857718; c=relaxed/simple;
	bh=qnEoHAbLbztYtJlZvfey0ZsPGaJzZstgHfUoEiNAM6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZx0ZNmJQgoxbA216w+eC9aUthZThoNbS6VwOgsI9NQ1ZUiEruqjd2+JP1Kv2n7Glih/Yj7250Nq3Hup2JgUhN7fGbxsTgWIkPBHQcaNDnLZyUkSRQeCdI47TBZGBGCeny11pU+5ecgXD95k+y8Lpj1cn2O2NX2UCcWVRXhinpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jxYoN6Ho; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e0b8a400854so7720351276.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2024 04:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722857716; x=1723462516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TO0MJPO0zx9jBVGkTEuM3whZ8sbaCUqD/Pjnqip+vro=;
        b=jxYoN6HoSn1EcuQkCkKNkTPzUBDnufyWmuviueiA/N6r5GFCE++YYGjiAPyfM3lE9m
         6+w+OV04p5HY/CmlBI+6/ykyTMw5oNGYzeX3+e2nfnOWdZ2xdCfJW38fekWuXU0dqbIT
         RsHS76Rh1G9i70IPm9iOVoGIK4bREljSB88rLPwI7lUW9X+uUix5uCKN4dCIw0ig3GR5
         kIVPNOEsYfJZMXeM0wwFRSJJuRNbYrHozbT1/DFNv1o9vLPfi40UL4096oOjiufWx/lK
         DTRa4uBfb7R1tbc5jXCmWUnUrt8jT4og9WlMjC+2Xwar1n3RIh/TEJfhg1pnj0siheDU
         HhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722857716; x=1723462516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TO0MJPO0zx9jBVGkTEuM3whZ8sbaCUqD/Pjnqip+vro=;
        b=kgJZTKku6mndmxGm1AFLVe0biWlTmTU+yEjSwOJS4Ne9+i+NlGSm6yXRBZzRw6ex86
         kPs9BNJN0PirFi4/5ueDj+vZSOyxOWOLTJhuNZibWYqmC30IRz8CL40cipTEvZwIoFbU
         wwyrEHj4M4nuFtahcbh2MsX8X43skkL9x8QFyRHZ6+1WK2V8QShOV1bEBO4rexfXOmpU
         Wqpj/TcqctRevUNaCKvwBOIr1HsTt90zAH4QD3Gvi8RPSd3u4DGIKXhwRWP7QuDsfeFx
         7EDQT8lO8fyGoKiGJ2rNVoopaTO2ZcjRYmh33KtSdDJ6Jft+XJcdEhwegvfncLHyXZVN
         lEMw==
X-Forwarded-Encrypted: i=1; AJvYcCWVqWJfkuS8dOHn73i5KUnO8+DJzNcr+bEklJOMZidMW/S6fPkeY4cWrONFSqMGGLAg2lKK6xmgeuJLWVfnQI7vJPKlqdPMhP4=
X-Gm-Message-State: AOJu0YyCWIp4qIpnz9RVwlnA0JEPfDyTUduqTBcPj2H+XXXPKOjJqtjI
	46M94uCW/xiZF0CFRom4f/haw7PlPZeMGw8UxTMsq9OdVqc/EtGqFSUtt4+c06iLKUixhBwtAtn
	a3jD31ftVR9WETpz9hEu8mBPmQduUUjNTmVTFsw==
X-Google-Smtp-Source: AGHT+IFbg8tWI5RFE3KRag3rDI4C+uv6ImGTWbvbo77ifO+g1kVWnL3yOQ5zXRyTZnSTnvqDHetlpPcxkjMcvAO70QE=
X-Received: by 2002:a05:6902:72e:b0:e0b:e2df:b422 with SMTP id
 3f1490d57ef6-e0be2dfd3dbmr11385051276.24.1722857715924; Mon, 05 Aug 2024
 04:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717080334.2210988-1-alexander.stein@ew.tq-group.com>
In-Reply-To: <20240717080334.2210988-1-alexander.stein@ew.tq-group.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 Aug 2024 13:34:39 +0200
Message-ID: <CAPDyKFojBzKCoRZ-buDQ3LK4wm2EUrE4uZDv7_f-k3bebNWUew@mail.gmail.com>
Subject: Re: [PATCH 1/1] pmdomain: imx: scu-pd: Remove duplicated clocks
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
	linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 10:03, Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> These clocks are already added to the list. Remove the duplicates ones.
>
> Fixes: a67d780720ff ("genpd: imx: scu-pd: add more PDs")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/imx/scu-pd.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/scu-pd.c b/drivers/pmdomain/imx/scu-pd.c
> index 05841b0bf7f30..01d465d88f60d 100644
> --- a/drivers/pmdomain/imx/scu-pd.c
> +++ b/drivers/pmdomain/imx/scu-pd.c
> @@ -223,11 +223,6 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
>         { "lvds1-pwm", IMX_SC_R_LVDS_1_PWM_0, 1, false, 0 },
>         { "lvds1-lpi2c", IMX_SC_R_LVDS_1_I2C_0, 2, true, 0 },
>
> -       { "mipi1", IMX_SC_R_MIPI_1, 1, 0 },
> -       { "mipi1-pwm0", IMX_SC_R_MIPI_1_PWM_0, 1, 0 },
> -       { "mipi1-i2c", IMX_SC_R_MIPI_1_I2C_0, 2, 1 },
> -       { "lvds1", IMX_SC_R_LVDS_1, 1, 0 },
> -
>         /* DC SS */
>         { "dc0", IMX_SC_R_DC_0, 1, false, 0 },
>         { "dc0-pll", IMX_SC_R_DC_0_PLL_0, 2, true, 0 },
> --
> 2.34.1
>

