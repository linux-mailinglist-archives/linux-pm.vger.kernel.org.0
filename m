Return-Path: <linux-pm+bounces-40945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3132D284FB
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 21:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E666F300BA2E
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 20:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8E631ED6F;
	Thu, 15 Jan 2026 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDXl9PfI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A96F2E7180
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768507633; cv=none; b=C0l0+C19V77+mhOPFjKV3eMeXK2gOOk8J0fYUJXw5E2bJytyEbJnfWoFyLWJtUcffz1rUBE/S2oqhXabOSEHThsOTbL9jqh0d+d/55/B+OFgxGeSpSGtZ2hsAwsv87pchpH57R2eUR1StkJt5bw4tUlnw8XxaLilF8Wz3aIJhDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768507633; c=relaxed/simple;
	bh=d5YFgMzWUQWdQCicq1abmNOPEHcmyaGBZoFHGk98gSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LY+1bMKpa4H44Ye11N8mVAUaQmyuzoojqdUFUARbjUj28lw6kAwrW0zvhcjSRxwiYVo61JtoN3m7EXsZGIgYhsAY+4+IuZfHuECeooqWnBbNXnc5PCWWGQzqjKVASIm2MibZGAVllKqfkXvuPNLftxkxNswahwwi43hqRKjcBbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDXl9PfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483F2C19422
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 20:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768507633;
	bh=d5YFgMzWUQWdQCicq1abmNOPEHcmyaGBZoFHGk98gSo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JDXl9PfIyJEoKGAtoZgGN3QO22lBkdGqF4tkkDHoGGBQ1nHzuc+Q32oYdOQKIDknQ
	 zrs6Ue52b0PHdSohW0WNj9fjX4/OdU6YozIU/cgTt/7p/gHIK91nxNjTfgXE04Nfla
	 Fc4oZz4dy2dn0rBzYlzIBTIcMv+razfR7JPqNfm1Fm/RX5DX+7NSWo8ZKyXBRh/DXL
	 eop1Fux7/hmj1xI/Mxq999V/mj8HWMdYUnFd/gtWYnHmNvb+4YD4z07oB9IgcZKVd/
	 v2zOeHekfiSxc6XufVbx2c+8qrKV5CivOSWf5JbtFhorpK5kQzsSdL/batxm1DzIFY
	 WHtJSVu72EdSA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40418578e28so547097fac.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 12:07:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPsmOw87uJ9TQWqavSNmnmVO+cadBNHneCBIfRY3RTYEuedwyxtnKN+1sVvJSKY7/voSnwko9xCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAHkP+kvEomw9fpW1KRlFCVPhXeWKeKm9ZE8x08Z1WoE+O5pHO
	KmZzFqZymm9fwANd3kHlTvqF8orhjc7gbdCRw2yXXVcD0YMU0HEFoQxY8rev7GHp1BV3qyPXG63
	Dcs1hFqA0aa1kpNaLZrm8cy4E1Ay8iEg=
X-Received: by 2002:a4a:e917:0:b0:659:9a49:8e4d with SMTP id
 006d021491bc7-661188bb31fmr181746eaf.29.1768507632397; Thu, 15 Jan 2026
 12:07:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110183912.372215-1-sumeet4linux@gmail.com>
In-Reply-To: <20260110183912.372215-1-sumeet4linux@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Jan 2026 21:07:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i4fyfYFXWKcNXnT7m67wfgpbjHdxCY0BjBoRPUorvEBw@mail.gmail.com>
X-Gm-Features: AZwV_QiSC-HO_FIs3Pm8SFQGv2gZiavVPh6SL_MhJJ30TmKFD-lnZWYSICOG42A
Message-ID: <CAJZ5v0i4fyfYFXWKcNXnT7m67wfgpbjHdxCY0BjBoRPUorvEBw@mail.gmail.com>
Subject: Re: [PATCH] thermal: debugfs: Use seq_puts() for constant string output
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: daniel.lezcano@kernel.org, rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 7:39=E2=80=AFPM Sumeet Pawnikar <sumeet4linux@gmail=
.com> wrote:
>
> Replace seq_printf() with seq_puts() when outputting a constant string
> without format specifiers in the thermal mitigation debugfs interface.
> seq_puts() is more appropriate and efficient as it avoids unnecessary
> format string parsing overhead.
>
> No functional change.
>
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
>  drivers/thermal/thermal_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_=
debugfs.c
> index 11d34f2a3d9f..11668f5b3c28 100644
> --- a/drivers/thermal/thermal_debugfs.c
> +++ b/drivers/thermal/thermal_debugfs.c
> @@ -807,7 +807,7 @@ static int tze_seq_show(struct seq_file *s, void *v)
>         seq_printf(s, ",-Mitigation at %llums, duration%c%llums, max. tem=
p=3D%dm=C2=B0C\n",
>                    ktime_to_ms(tze->timestamp), c, duration_ms, tze->max_=
temp);
>
> -       seq_printf(s, "| trip |     type | temp(m=C2=B0C) | hyst(m=C2=B0C=
) | duration(ms) |  avg(m=C2=B0C) |  min(m=C2=B0C) |\n");
> +       seq_puts(s, "| trip |     type | temp(m=C2=B0C) | hyst(m=C2=B0C) =
| duration(ms) |  avg(m=C2=B0C) |  min(m=C2=B0C) |\n");
>
>         for_each_trip_desc(tz, td) {
>                 const struct thermal_trip *trip =3D &td->trip;
> --

Applied as 6.20 material, thanks!

