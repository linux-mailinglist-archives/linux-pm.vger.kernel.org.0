Return-Path: <linux-pm+bounces-16215-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0828A9AA0F2
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 13:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD7728356D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 11:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD4E19C54C;
	Tue, 22 Oct 2024 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dDQ9iWCT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D7199FAB
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595695; cv=none; b=sKqM1xibQztYc+CGv7GvpTKkblqg1mSkvwT5i4OLkVcFlTQu8KYm4UmvzjI2bVbxcmCjEZgCWPnCGLTX7eWglsSq/YtOvT+tTVDqcXTagddo/MyBruWZHH+cKHVu8JQiTDt59xTj0d09W719QLU8zqXc4y2XXhMai93/JX0t31k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595695; c=relaxed/simple;
	bh=ZYBOM0Jau2KE+DeEZtdtpLKVsuWrpJoV7dldPsJ+eJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1KlyU/ogkTW6oygYmNxyN/qA6N0Xi4Amen86ZnPhhe0UBqZwOD2DsoPOqlj3ECsBrpcpfUSn7iHEAUYkIxuhlSZBBhNzDx3PHI/r2ufnV0/VWwxW55FFalFFmA04S2tof09IzQfLcoDimg78bLgl1ZO+xAsrDn36zAi8nn/IRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dDQ9iWCT; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e28e4451e0bso4999857276.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 04:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729595692; x=1730200492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GictTW47NVZdcyH3FJJptxbRgTusXnwflsx0uPHCDvU=;
        b=dDQ9iWCTggCSkTc3ZNJ5++FB5Be4o+PRjxjmM9r+ofGaUOe+AolVfKGM+xKjQmjWT/
         lHsHpPCzAMvNPi7wgvfE4SzaP5sj/wVWRGaWXKzkLj8MPYq19m/n3ayIHwY2B5VhvCEq
         V63ri2p8ZBiKgJnFvWxi6pqFD0AuLZIdFu8PdVbFxpf+bcHZBJGF2nhlc43ErKVimQUT
         /7OHg+Ro1L63alwYtFjFYuln5t1+aVI629kf5iPeAF4/rsMGI++kES9MXadTWDC1/c3m
         1E7CLwmn5R5dA/qvbejWveyCgRaMlkwsBlrXtjkc5GKMzE/tHMsyJvYkt5HLoNCT/Wnu
         tlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729595692; x=1730200492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GictTW47NVZdcyH3FJJptxbRgTusXnwflsx0uPHCDvU=;
        b=nrXDw7bGNsyZG4oERD3ZPWnxdkR/lH8oqyZPxH0yiTFHY+XQnPpz9BHuOr29IaT0Tk
         VW9rHCbzcCHHwnoqzDszRyEHg1LdsmEg+2fgK9rjj4C/+3CWZ26JdO8IgmMKyahLJhU+
         j8up6lBmvE6wGL3yMhBSAoEcysWY40PvHI7W0JTdFkBIzZQ1o7Eqkh+wYTqArCpnnovq
         tyEoMs9DVxysp13stSPnMzrjBYFyk5g7DPwWg1uO22YvoS5R/lVCaqF2/YGinCKNrKg6
         4BbA1UAZOoAnRINJBBCPh1T0YLB+1wmY7ncMPeH/YoMu/GeHvAbtiXsYAtgiMWAODOL1
         kNDg==
X-Forwarded-Encrypted: i=1; AJvYcCUw0nmzWYLPQkxP30ojOsczzKZMYqTAC6OYlqY2/9M0+tZb9mq1jcx13t9CT6g9hNr7DwXEYrOQdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUOCHvj2WTYZiverz+GXZbE/VL1w+s1A0JwMcFeJzD23lsxl0H
	UATNWFaX+3OhVarGDsUn7FVSjWBBNcWpMiYgDeJFUl4XN4fDPl1xf1mSQn5J43lm3DK+6ut3STg
	KM3DhRGIz5+ccHND+klO9+hJDcYiIWf2sEwMAQQ==
X-Google-Smtp-Source: AGHT+IH9MD5E5lYj8E/oQc+5K6zST27pAY+/VTNfDX0GfVv9ZMy+u3+C60NydhtrbgFJRydQX/YUX9VDVGRxCtC6cP0=
X-Received: by 2002:a05:6902:1141:b0:e25:cdc2:ed93 with SMTP id
 3f1490d57ef6-e2bb1442cf0mr12189028276.30.1729595692446; Tue, 22 Oct 2024
 04:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022-8250-omap-no-console-suspend-v2-1-cc3d102b8a1e@bootlin.com>
In-Reply-To: <20241022-8250-omap-no-console-suspend-v2-1-cc3d102b8a1e@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 22 Oct 2024 13:14:16 +0200
Message-ID: <CAPDyKFonEKezL2xpTCsW8aH=kvxDX67w+3FNUwukvjp4tKfjcQ@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: ti-sci: set the GENPD_FLAG_ACTIVE_WAKEUP
 flag for all PM domains
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, tony@atomide.com, khilman@kernel.org, u-kumar1@ti.com, 
	gregory.clement@bootlin.com, thomas.petazzoni@bootlin.com, 
	theo.lebrun@bootlin.com, richard.genoud@bootlin.com, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Oct 2024 at 10:23, Thomas Richard <thomas.richard@bootlin.com> w=
rote:
>
> With this flag, if a device is marked on the wakeup path, the correspondi=
ng
> PM domain is kept powered on.
>
> This commit fixes the no_console_suspend support for some TI platforms
> (tested on J7200). In case of no_console_suspend the serial core marks th=
e
> device on the wakeup path, but without this patch the power domain is
> powered off anyway.
>
> Suggested-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> This is the second version of the series to fix no_console_suspend in the
> 8250_omap driver.
> For this second version, the patch 2/2 "serial: 8250_omap: mark the seria=
l
> as on the wakeup path if no_console_suspend" was removed. No need to mark
> the serial as on the wakeup path from the driver, as it is already done b=
y
> the serial core [1].
>
> Regards,
>
> Thomas
>
> [1] https://elixir.bootlin.com/linux/v6.12-rc3/source/drivers/tty/serial/=
serial_core.c#L2407
> ---
> Changes in v2:
> - remove patch 2/2 "serial: 8250_omap: mark the serial as on the wakeup
>   path if no_console_suspend"
> - Link to v1: https://lore.kernel.org/r/20241008-8250-omap-no-console-sus=
pend-v1-0-e7f0365c02f0@bootlin.com
> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/t=
i/ti_sci_pm_domains.c
> index 1510d5ddae3d..38448b4a035a 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -186,6 +186,7 @@ static int ti_sci_pm_domain_probe(struct platform_dev=
ice *pdev)
>
>                                 pd->pd.power_off =3D ti_sci_pd_power_off;
>                                 pd->pd.power_on =3D ti_sci_pd_power_on;
> +                               pd->pd.flags |=3D GENPD_FLAG_ACTIVE_WAKEU=
P;
>                                 pd->idx =3D args.args[0];
>                                 pd->parent =3D pd_provider;
>
>
> ---
> base-commit: eec50dadcc91583e08dcabdf83147f6538831b5f
> change-id: 20240819-8250-omap-no-console-suspend-1073308d3714
>
> Best regards,
> --
> Thomas Richard <thomas.richard@bootlin.com>
>

