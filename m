Return-Path: <linux-pm+bounces-23023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F3AA46B5F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 20:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D286516B7E1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 19:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A179B2566DE;
	Wed, 26 Feb 2025 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcOE0PsT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7662221B192;
	Wed, 26 Feb 2025 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599357; cv=none; b=aiY0Kb4M5dPgiit2oWqjYD8VhCxpogEtNFNGpP2phaPLWIihZqh4DanG+RHh3jBLXNcmgMtskyg31FSE+am927cPgWmUmruz2DhUal7NaEFErkheFAORHxl2LO/M1fEWWQqAbm9KA4dOI849CZmq15YI2SKC4MkAc5kHhDwrAts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599357; c=relaxed/simple;
	bh=iXo8Zg9Hs5XWNAR7WBc8K+qfaewfdE21wZuoP1F6W/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMZx5LE8ckY9DZsANEFjmZVS+QTkcXw1U/mpxPDYC+LE64gOtsUSfLC1xyy/Mmi1fq8ynki6mRFNvf6FWbngVF3IrHHUz5RClaUyDkVZjyA3u6PiNkhPckGT1HQVqzWIw6t9IEJWzI70aqA7GZ2yQrv043m9zV4rPziUWfrIB2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcOE0PsT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BF5C4CEE9;
	Wed, 26 Feb 2025 19:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740599355;
	bh=iXo8Zg9Hs5XWNAR7WBc8K+qfaewfdE21wZuoP1F6W/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fcOE0PsTnb/Eeyd+RUmyPXo50ettHDcHm4XGjekca9YlB3Xos2Ctlg8fmlo+PkJWj
	 dsDx4sIqH/Wyo0zAXQaVmFQDHnAUHr9JvuTBN0tl1L31/Mv2tU7uV7WAm2zYSGtUnE
	 qORGXwhobcb31HQ2i5jyOTCOXdkrGQWgM32uzskqiNSA+4zpeg8rahLvWZmZ+JAUfF
	 9nhMrgP4t5krJILb0u5D1LUM1tuZQCJpfZFWUkyrsblh459ECVmC6smynnccXAzFFA
	 4xOoCZYTIvsZlWg5hW/IQENGeykcBSaF7mOjJhSEjk2qZBnPVcHYFluOaycXpBKRDl
	 /XB3Qk1QhpsaA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2a01bcd0143so213378fac.2;
        Wed, 26 Feb 2025 11:49:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUrolhFWJWnjIfZsNLv5ZOX3un0WoRGTGe1RhKP+PoXDNh0i9M0jhD1FVbSlnqUr7DIPC0H3LXt4dZ+aSlWkSw=@vger.kernel.org, AJvYcCX5+D901eguA6rn/2yDvuMc3QofVBpT/7SLxX0JBisQ3e/y+zJBzJR5fIw9+xufpxUoS7cIihuXXCI=@vger.kernel.org, AJvYcCXjX2rk997YSQ9OcXL0BTTIp8NR5Tc3u96Qf8xnl6pCHct4GkhsP6PAZWbUfnhE3l/Ch6jUtG16AqR3TnVu@vger.kernel.org
X-Gm-Message-State: AOJu0YwKT76zYd/Gw3wn02CkVzFXrQeZ9N1lsuC141Bg+6OELSZT31bq
	jcFX4uHEYZAt26EW3mTSYnx9ajgSPxXtsBcGpXU2wZo/Jsw5Clbh5CEVOygaMHwC3HNQbpnDgod
	Dn/wWxEOQbpcQlsfoDFCDJ9ezoXU=
X-Google-Smtp-Source: AGHT+IG9KOWipKPuW/avokgsq+B5PMz6gRuNbcoVKz5SzBWwDWsvvpNxpEEubrbWAd/G3WgmYULL2iRkf1h3CuLOA8U=
X-Received: by 2002:a05:6871:582c:b0:29e:4ba5:4ddc with SMTP id
 586e51a60fabf-2c13070e85fmr2741891fac.24.1740599355161; Wed, 26 Feb 2025
 11:49:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222-thermal_kcalloc-v1-1-9f7a747fbed7@ethancedwards.com>
In-Reply-To: <20250222-thermal_kcalloc-v1-1-9f7a747fbed7@ethancedwards.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Feb 2025 20:49:03 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j5Rqc29NsEBVFakq8b4o1Ng-fhviU5BOfn1jxqEnXokQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpIycxwb8ZQ_56Qub8exElXQ_8HMpr2P1Nl6dwLu1XkJjsDEjwb14E6avc
Message-ID: <CAJZ5v0j5Rqc29NsEBVFakq8b4o1Ng-fhviU5BOfn1jxqEnXokQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/debugfs: replace kzalloc() with kcalloc() in thermal_debug_tz_add()
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 9:02=E2=80=AFPM Ethan Carter Edwards
<ethan@ethancedwards.com> wrote:
>
> We are trying to get rid of all multiplications from allocation
> functions to prevent integer overflows[1]. Here the multiplication is
> obviously safe, but using kcalloc() is more appropriate and improves
> readability. This patch has no effect on runtime behavior.
>
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-c=
oded-arithmetic-in-allocator-arguments
>
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
>  drivers/thermal/thermal_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_debugfs.c b/drivers/thermal/thermal_=
debugfs.c
> index c800504c3cfe0ea3b4a51286f348dd5802e1898f..60ee6c366998e26447a0b9851=
12f578ba8757f17 100644
> --- a/drivers/thermal/thermal_debugfs.c
> +++ b/drivers/thermal/thermal_debugfs.c
> @@ -876,7 +876,7 @@ void thermal_debug_tz_add(struct thermal_zone_device =
*tz)
>
>         tz_dbg->tz =3D tz;
>
> -       tz_dbg->trips_crossed =3D kzalloc(sizeof(int) * tz->num_trips, GF=
P_KERNEL);
> +       tz_dbg->trips_crossed =3D kcalloc(tz->num_trips, sizeof(int), GFP=
_KERNEL);
>         if (!tz_dbg->trips_crossed) {
>                 thermal_debugfs_remove_id(thermal_dbg);
>                 return;
>
> ---

Applied as 6.15 material with some edits in the changelog, thanks!

