Return-Path: <linux-pm+bounces-30071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7502BAF7C43
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 17:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED74E3BBA63
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 15:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33746222561;
	Thu,  3 Jul 2025 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8log+Y1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA982DE6F1
	for <linux-pm@vger.kernel.org>; Thu,  3 Jul 2025 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556118; cv=none; b=aPVH1mUDyJ3Q0H/mgAGDrsDze2h4rPry7GUyUUBdHF3pSyHl7WQ3lJ8HAwbu/VmfVYjo0udaBFPxIGfXg4t+wkO/7bvtx2r90GQmshqBUjeMl9Khofs+q5qxmvMcJ4y0doF6RE+9XqXEHS/LsZqjJf0BNW7L1QJzIqTvWIubVaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556118; c=relaxed/simple;
	bh=nL6CkRxpzZw/LDXYUEqcG5tSbv5w438Eia7usDA8PoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0fx13unbiO7S5/mpj+FL1s+BQEIhE0TE9oigxyC9wm1qIZyyN/HHj+M3Fi/H8b2D5gx5s4cbgQhxcv6MyzYt5heBPlkC779JlN1fRc4WFH13Z+0Kay0XxMKhEZEuziJmghj1pLO0Z/C6NBgHHvsE+NC4svWDP95Xkc1wwHTL8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8log+Y1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE831C4CEE3
	for <linux-pm@vger.kernel.org>; Thu,  3 Jul 2025 15:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751556117;
	bh=nL6CkRxpzZw/LDXYUEqcG5tSbv5w438Eia7usDA8PoQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y8log+Y1bzXJncHLNaDK1Y454cF9wfrMDGVC4C6DeKtDnN4HAVybxWLRAzRsrdPfR
	 NilWFWWWgChJBD5rWeNVNvSfiugouZQGR4JJoSUf301pzQY/liA2mGBCI8JEpO1WTf
	 gP/GhvNzOnmIz7V9ewu+6mvg7vBkok4jWCNoxK0ydHQqVxuI6YrBLV3SAU8LsNbg0m
	 fgDyPGA85FLiGA1dF55JneSUufv7GWjJhihEvctuEwgUCcggnuW0Zdw8ugEagmZyjI
	 ZXJgbSAXjzA2aiB1nED0lj3VP4ZLo/D2fIbwVO6DvucL4HpDVfQUfLzA0+K7/PCnTv
	 j03Shc5hw03zQ==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-40b1f402deaso43170b6e.3
        for <linux-pm@vger.kernel.org>; Thu, 03 Jul 2025 08:21:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPktr+VoK+G8lHhdXNeQKn3Rq8bl/tD3PL1VB4YVZlwKA0B0p6fbJzcTVN9dtW/ru2oy0fVabO0g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/7vgSVWH3RCUTrmoFmktfoQqOYlZyO/OGu8GWkHiNiNrfh67r
	6l9Krp/TfcLjf92FO7+5L8rWtPawzwB1QYuMfLicIfyXK00KC1ix9GL7EXXztU9j3syo6zyGj10
	6F3g/YiiaaCajWyRafUSILmTt9iXqFoo=
X-Google-Smtp-Source: AGHT+IF7HxazjWEQv/HT/uu/8RpJJBy4bsuRCtswRAq/xrip9dwcVqNhOsXYQvb6tMqniqStUDaD/93U37VsahYunCA=
X-Received: by 2002:a05:6808:8950:b0:402:862:93ae with SMTP id
 5614622812f47-40c07b47a37mr2859935b6e.16.1751556117184; Thu, 03 Jul 2025
 08:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701221355.96916-1-sivany32@gmail.com>
In-Reply-To: <20250701221355.96916-1-sivany32@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 17:21:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hxXFcwfaYynXAq4YR91PFDX0g6q+F5QvLfCUXKot6pJg@mail.gmail.com>
X-Gm-Features: Ac12FXyG9C7fx2G4B-OWm-CklVV9p3HJWY0faBKPs5CzGuN6ZTGrvHo2h2jVIUE
Message-ID: <CAJZ5v0hxXFcwfaYynXAq4YR91PFDX0g6q+F5QvLfCUXKot6pJg@mail.gmail.com>
Subject: Re: [PATCH v1] powercap: dtpm_cpu: Fix NULL pointer dereference in get_pd_power_uw()
To: Sivan Zohar-Kotzer <sivany32@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, elazarl@gmail.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 12:14=E2=80=AFAM Sivan Zohar-Kotzer <sivany32@gmail.=
com> wrote:
>
> The get_pd_power_uw() function can crash with a NULL pointer dereference
> when em_cpu_get() returns NULL. This occurs when a CPU becomes impossible
> during runtime, causing get_cpu_device() to return NULL, which propagates
> through em_cpu_get() and leads to a crash when em_span_cpus() dereference=
s
> the NULL pointer.
>
> Add a NULL check after em_cpu_get() and return 0 if unavailable,
> matching the existing fallback behavior in __dtpm_cpu_setup().
>
> Fixes: eb82bace8931 ("powercap/drivers/dtpm: Scale the power with the loa=
d")
> Signed-off-by: Sivan Zohar-Kotzer <sivany32@gmail.com>
> ---
>  drivers/powercap/dtpm_cpu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 6b6f51b21550..0f1c19308f46 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -97,6 +97,9 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
>
>         pd =3D em_cpu_get(dtpm_cpu->cpu);
>
> +       if (!pd)
> +               return 0;
> +
>         pd_mask =3D em_span_cpus(pd);
>
>         freq =3D cpufreq_quick_get(dtpm_cpu->cpu);
> --

Applied as 6.17 material, thanks!

