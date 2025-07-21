Return-Path: <linux-pm+bounces-31219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B719B0C828
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 17:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF8F1C20836
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4942E0B5C;
	Mon, 21 Jul 2025 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0JZRiVz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD172E040C;
	Mon, 21 Jul 2025 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113132; cv=none; b=IQXZ6UyCM3upI4RmRfg2j9OMQXVbmgLUm3eFbcyp+o+9MjIpfIxLhmjmkiZOiey9jPqWS+kIt1Tl+9AqKdch3xmUdgKCiOgndgusR04qo3obHJplF/jNWo3WuApGFPmIIjq+0mahjyVLf8+t+c4ZdX146xM1zoAm0SMk4XtqP3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113132; c=relaxed/simple;
	bh=hMYmkfU7Vhsh1L/r4VCOGbgckysxXtlssqFi82htU/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOVYLoihjLRzyn2X93gKXCsPvJ3jaft2+geEk1VG3zisX2pIYC37ljXAKf1jc0+nOzAvREflO8D0ve29CgeN1HI4Ts66F9h+avOKo20kaePSixcAPIfUsoCI7QOxvTRmvraSs89lxCd3vKV86RciTijZ9eHWrroFOTIuJCbp/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0JZRiVz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B105EC4CEF6;
	Mon, 21 Jul 2025 15:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753113131;
	bh=hMYmkfU7Vhsh1L/r4VCOGbgckysxXtlssqFi82htU/A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e0JZRiVzuAyTpdR18nz0f+48bfKgo5hzaW9UNqT7Mva/wEPMP+C8Mx18/ecXzt9hF
	 plq5dVsjAv3rx2uwGGNEAQm1B54fyS4/FgGCF2WMcoiyU80K2pEGUEb08fyGdmMbxc
	 nbWKjbPkqPcYU9gEvTyrCc48ZT2MxIfBialUhRvlHoaYzhPU6JIh9io8FfRUmOWMkC
	 HdBzRHSCAcgBI1SEFpFGiQETYPcG554Gze6QdJz3i9N8eoP9mE2eyKNwox6kKzA2UZ
	 25+yVQsyB77eSTWjaRPXVZxLJLnyyFJdeZoqi1hFiyeJkiNgjCZKl6VL97lxalPwCp
	 rZ7Z9atxgGzbQ==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-615da180061so675181eaf.2;
        Mon, 21 Jul 2025 08:52:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwHipRtnNBckS1AaheGaa1WhOqNt+mpdFM205oQHgbZ1TrSoLpyH7tRp+BXaF11V+EJ7YFtSUNHWY=@vger.kernel.org, AJvYcCXRj86EiZqcWorNPFrItmS9MfIfWxNSzIL7/p4w3EFO1GdfMb26XiSjjt3tYr75HwLTWDrGPDzZvwSVTrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2WmZWhIDqINOk4V6nQmH3mG8Z8pnC3TofvQEG/Dy5jDIHOgrg
	5vIIVfC4B9oPG2FwrwhuDbmCKI2aH7Y1xLvTweNeqApzKr5C6kTZyNWGrTwwRaP7XriYUzi0Htf
	ZaLf4+yFHOJJ3KGggLjCK2aqCPWGBYbg=
X-Google-Smtp-Source: AGHT+IFX927lVi11pCtP3aWnICcu5hAEHo2XF/aX27MiUBWFydNrRDkrh+CRzUXyFgtEprmyhEdpnIrQ2Gj2NyrX8Uo=
X-Received: by 2002:a4a:e915:0:b0:615:eb85:19aa with SMTP id
 006d021491bc7-615eb851d46mr1048853eaf.4.1753113130910; Mon, 21 Jul 2025
 08:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721153656.5103-1-zzhwaxy.kernel@gmail.com>
In-Reply-To: <20250721153656.5103-1-zzhwaxy.kernel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Jul 2025 17:51:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iyAWdh=_2jcc7P5umR4T4yoatiK8cE+yT2vTiY87mxxw@mail.gmail.com>
X-Gm-Features: Ac12FXyznHB76IYfD718dz-max0DAPtJcgBWJ1nEkgyLPLUn6Sy_Yv2C46vVgos
Message-ID: <CAJZ5v0iyAWdh=_2jcc7P5umR4T4yoatiK8cE+yT2vTiY87mxxw@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: Avoid creating sysfs link for offline CPUs
To: Zihuan Zhang <zzhwaxy.kernel@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 5:37=E2=80=AFPM Zihuan Zhang <zzhwaxy.kernel@gmail.=
com> wrote:
>
> Currently, cpufreq_add_dev() attempts to create a sysfs link
> even when the target CPU is offline. Although guarded by a NULL
> check on cpufreq_policy, this behavior is not strictly correct,
> since offline CPUs shouldn't have their sysfs interface created.

Why?

> This patch cleans up the logic to only add the sysfs link
> when the CPU is online and cpufreq policy is properly initialized.

I don't really think that this change is necessary.  Thanks!

> Signed-off-by: Zihuan Zhang <zzhwaxy.kernel@gmail.com>
> ---
>  drivers/cpufreq/cpufreq.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d7426e1d8bdd..0a77892d366c 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1660,12 +1660,12 @@ static int cpufreq_add_dev(struct device *dev, st=
ruct subsys_interface *sif)
>                 ret =3D cpufreq_online(cpu);
>                 if (ret)
>                         return ret;
> -       }
>
> -       /* Create sysfs link on CPU registration */
> -       policy =3D per_cpu(cpufreq_cpu_data, cpu);
> -       if (policy)
> -               add_cpu_dev_symlink(policy, cpu, dev);
> +               /* Create sysfs link on CPU registration */
> +               policy =3D per_cpu(cpufreq_cpu_data, cpu);
> +               if (policy)
> +                       add_cpu_dev_symlink(policy, cpu, dev);
> +       }
>
>         return 0;
>  }
> --

