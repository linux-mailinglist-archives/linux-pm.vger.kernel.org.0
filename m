Return-Path: <linux-pm+bounces-38322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA87CC763C4
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 21:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84F0735327D
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 20:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C302D6E72;
	Thu, 20 Nov 2025 20:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQNBg+Og"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5C936D4F7
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 20:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763671898; cv=none; b=Q1qONQpFXPWY9d60FI5DkKjT3boal/WNXyWa3Sv8XNj4rBIYxb+EJUOvCqSd2csjpVupxOfy0Oy178NOIVj8v5Dd+36OZ7spzS+jD4MDtKHH7Ci2uwZMgtFCHBHt6wL+azhZzr4Yo21HRyPSHBmknGbN2rhAiv60sfsniOuZgTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763671898; c=relaxed/simple;
	bh=ZP6oRSjmWgQ+X4Xw0myeqaxufb/t5eva4mTwISwYZAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhvWOjE6lRRUP9ZhiUScY1YqE+eA3JbXr2xBQDssWdoCcLU01DR20yAayu5ZQ83YcTLDR1kf907AxGM4maNrFJB3BR3p8nSJIZxmLO4uvutu2Z+bGKm9neTtepURX5had1chZyQglDDWQMaS+oJ9A6WR0cte4Vz9Udp+liXiA9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQNBg+Og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25C8C4CEF1
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 20:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763671897;
	bh=ZP6oRSjmWgQ+X4Xw0myeqaxufb/t5eva4mTwISwYZAU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SQNBg+OgZZSlO6Y8NSpOz3EbC2ULiVWWblvwr/NR0OgpsLS5YeC456YEqFVntnL81
	 g6zTMsFnWFKlWWL+U9ZXlDeSwXlzFc3XNB7y0fTimPAs0oCNQsKZcKBBoAHCw7f41N
	 Pste9z4K9kTSNkqdPCdASzxyI3hPSPgN6FVigCeJdg/d0DUiv8neujWEq4agFCfBvc
	 N944H7eW+tDKxeqokJwBrSYKqSVT6RedH0CF1J/WMP/lDkBMk/vbtzxcbKx7yYzcTl
	 SvYBnfyASPrnBCeh420QoYfpPFmY87UgDeSZh5Yp5bu62ZP9NISRaD7ef6BMecVZQz
	 kZgJ+TJ2aTqKw==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45066bee74aso258793b6e.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 12:51:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2FijYjZ0kAEMd5exRxSjpYJjLcBRRURIQ9FK/ptb/15EXwzPDY1uJhKHkn+nIsva27I6gDjCvxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFk+qt0E1AUMzGNSSh63Ivfx1FFkCFPVntMuoDO9rjSrlIQs8w
	yK41CTIZ6204wdcuPgApun/glu0ynHGRURH7phhQKiVm1wZ2Gt7ZmMpz2vWwz69cIpPyKFA9OY4
	v0NkRKBrz2uSUApX4nQ3FOjLDU4oAzdQ=
X-Google-Smtp-Source: AGHT+IHgNr6oPg866rDcrXzSN24IXjY0RIrVsutKsVU3IN+RgNm6kkJfPBj4KPGbJru9jaf8AIK9HEtJ5aWs9D+0PCw=
X-Received: by 2002:a05:6808:1796:b0:450:c6a0:3f39 with SMTP id
 5614622812f47-450ff3e8b6amr2399413b6e.58.1763671897118; Thu, 20 Nov 2025
 12:51:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031109.134583-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20251119031109.134583-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Nov 2025 21:51:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j5zFeWtmaVDVkUv9gLUNQX=T_3+=pTmttsRYk8JXsarA@mail.gmail.com>
X-Gm-Features: AWmQ_bkpPX-7pnyhseML1-5hKF3lLTdX3gDxaNtCKwyYC_xTLK1jWmDNjVvWpXA
Message-ID: <CAJZ5v0j5zFeWtmaVDVkUv9gLUNQX=T_3+=pTmttsRYk8JXsarA@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: ACPI: Replace udelay() with usleep_range()
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 4:13=E2=80=AFAM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Replace udelay() with usleep_range() in check_freqs() to allow
> CPU scheduling during frequency polling. This change improves
> system responsiveness and avoides busy-waiting.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
> v2:
> - Tighten sleep range to usleep_range(10, 15) to limit worst-case loop
>   duration to 1.5ms, addressing reviewer concern about increased latency.
> - Cleanup commit message
>
>  drivers/cpufreq/acpi-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index 083d8369a591..e73a66785d69 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -395,7 +395,7 @@ static unsigned int check_freqs(struct cpufreq_policy=
 *policy,
>                 cur_freq =3D extract_freq(policy, get_cur_val(mask, data)=
);
>                 if (cur_freq =3D=3D freq)
>                         return 1;
> -               udelay(10);
> +               usleep_range(10, 15);
>         }
>         return 0;
>  }
> --

Applied as 6.19 material, thanks!

