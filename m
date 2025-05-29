Return-Path: <linux-pm+bounces-27809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 812C8AC7EA7
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 15:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87A3500ABA
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 13:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEE4225A4F;
	Thu, 29 May 2025 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pn0p1FlW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54D91DC997;
	Thu, 29 May 2025 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748525035; cv=none; b=uq69opaoLogm/QYArJ0ROGRt5KKZwse6z/wWt7PyPlKwdSnkXKROR+H4ZBDtmQdx2PmSH0cEP/Nlpd0QNL4e9vuZ+3PhOJEgPWUI67aU3sfbSHElbqs8HS14Eg0nqTOJvAOywcUYFC+gnO3YJulIjLj0+TMTDCBhuUEGDX1mhcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748525035; c=relaxed/simple;
	bh=iPhBdE/tZhg6QxWqTyuAWCZ+5+zJ35pVWAcFE/CH26A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RE5UMcDv6m4FzGzT24H0f8qTKF1pP7Zyem55EoFWv5Qt6mm3f46V3IEwqw05+YU/eAyZKLOfTm4ojLgkFzzPxE7RsRaoQTMfrNXuHmdHCv8HNnjv6LC3DZhjUWySfxDufqE7QkXoOybIIqa3RrXTyAKFXGUMpaonbFYcptRgPrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pn0p1FlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325C7C4AF0B;
	Thu, 29 May 2025 13:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748525035;
	bh=iPhBdE/tZhg6QxWqTyuAWCZ+5+zJ35pVWAcFE/CH26A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pn0p1FlWBLnCDhYfKsIN+PHT2N3XR7sGTjhZePQ7MoIyHiRXLmiij3MRdbHHPG+c3
	 4O1x1i8wqrtHcGWK3i8c1Oq5lbyL+kzBQtLuG4Ob6FlaZd1R5kgCipNq2Md7oRmqf3
	 VzgEesZK7EMnUbB3uHxjfuZymDQt+6P1tJkFYBmLvzei3y1sfzoZwai/qD1PKf5m37
	 cjO3eDlk4WAXGfIOFURcLI5sUiDc8si7abE8PeXSbLwdFv21cTBhGB6Luf7+b1t9dy
	 O4kkE3vF2wVVXJqNQWqep4uW65psHv+RnTRxB0sjVkjdc7fE+fSUnnAmVyoCaaUaTM
	 Y06tKza9/HeYg==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-60634f82d1aso250680eaf.3;
        Thu, 29 May 2025 06:23:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVdOxKTIYwcW4MpLfq+5cs8GWyh0bkyQnqQfqvWMe8KVK//gBO0QrI61laxiHM+TUyh8mYSIXF7CsKCTY=@vger.kernel.org, AJvYcCWNe8ZE76aLEjXUXR6IsNcjSX3O1YCan/3KKIA9HqLJ3U1gFVoSD5TIyaggtKyuNmvKIhlNqL6Faw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKyZQHATc7q0vMI2FIOvOfI2tu7DvEEO93aElRrHXI7qSt7wN8
	Ss+HxEdnkcXvj3nAzzonjYrAm0PnJbP46WoCZMCDYurtd++dpJnM0STkp1Zo0LZWzZI6fH5hmhn
	S20L0ire/rlZUTdw7J3VvFT43dqFHVlg=
X-Google-Smtp-Source: AGHT+IEY6jTOLee1Y7y3UrQGPfDW6z03FXJShLfN7yd223mbTlb/bw2LB14+S4L7LK5xEFbyl7YBTRRqf/5Evmu8mcs=
X-Received: by 2002:a05:6820:a05:b0:60b:a4cd:c368 with SMTP id
 006d021491bc7-60be8ec81d9mr919626eaf.6.1748525034505; Thu, 29 May 2025
 06:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529085143.709-1-gautham.shenoy@amd.com>
In-Reply-To: <20250529085143.709-1-gautham.shenoy@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 May 2025 15:23:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h27Re4UwoyCrauNfQupojpfwKSOzSppC9mwR-ATWD3Vg@mail.gmail.com>
X-Gm-Features: AX0GCFuRoIkmbB83JxdjUmlpwoUD6U38Lff5covVl7m41Qt4OgEzJduE7dFPOcQ
Message-ID: <CAJZ5v0h27Re4UwoyCrauNfQupojpfwKSOzSppC9mwR-ATWD3Vg@mail.gmail.com>
Subject: Re: [PATCH] acpi-cpufreq: Fix nominal_freq units to KHz in get_max_boost_ratio()
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, Manu Bretelle <chantr4@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 10:52=E2=80=AFAM Gautham R. Shenoy
<gautham.shenoy@amd.com> wrote:
>
> commit 083466754596 ("cpufreq: ACPI: Fix max-frequency computation")
> modified get_max_boost_ratio() to return the nominal_freq advertised
> in the _CPC object. This was for the purposes of computing the maximum
> frequency. The frequencies advertised in _CPC objects are in
> MHz. However, cpufreq expects the frequency to be in KHz. Since the
> nominal_freq returned by get_max_boost_ratio() was not in KHz but
> instead in MHz,the cpuinfo_max_frequency that was computed using this
> nominal_freq was incorrect and an invalid value which resulted in
> cpufreq reporting the P0 frequency as the cpuinfo_max_freq.
>
> Fix this by converting the nominal_freq to KHz before returning the
> same from get_max_boost_ratio().
>
> Reported-by: Manu Bretelle <chantr4@gmail.com>
> Closes: https://lore.kernel.org/lkml/aDaB63tDvbdcV0cg@HQ-GR2X1W2P57/
> Fixes: 083466754596 ("cpufreq: ACPI: Fix max-frequency computation")
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index d26b610e4f24..76768fe213a9 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -660,7 +660,7 @@ static u64 get_max_boost_ratio(unsigned int cpu, u64 =
*nominal_freq)
>         nominal_perf =3D perf_caps.nominal_perf;
>
>         if (nominal_freq)
> -               *nominal_freq =3D perf_caps.nominal_freq;
> +               *nominal_freq =3D perf_caps.nominal_freq * 1000;
>
>         if (!highest_perf || !nominal_perf) {
>                 pr_debug("CPU%d: highest or nominal performance missing\n=
", cpu);
> --

Applied, thanks!

