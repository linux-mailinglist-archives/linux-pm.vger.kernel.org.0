Return-Path: <linux-pm+bounces-39242-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B945CA7E1A
	for <lists+linux-pm@lfdr.de>; Fri, 05 Dec 2025 15:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D2913060F10
	for <lists+linux-pm@lfdr.de>; Fri,  5 Dec 2025 14:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A88231960B;
	Fri,  5 Dec 2025 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ex5zCZkT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3793A30FC1C
	for <linux-pm@vger.kernel.org>; Fri,  5 Dec 2025 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764943310; cv=none; b=N6SWTb/f1N06TE0BmNcF/iGiwGYrUpBRE3Yz2QMQaQk94cFQ87qqLJYOpvUdx/i30SFoXyzGyPbpmKuVE/B1BdVGlNRdZVAviRlrrN0VwL+HeWPvLLNrfAB11gh2B6jjnrlxYtJ7oPofurDPZfVZHaX8cslJlBbflqSID8xcqbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764943310; c=relaxed/simple;
	bh=QRUfVYERmGveEebJq4l8DBoig0ToV3UZrYsdFvYWPX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1cH5oD7G4OYDrZSAYfpLCgSicLXyCnckpCUwTpkgbCVFlX/DrrRfgJSX1IYz34RaWbUQgnyQzi0xTaAb+c7LdauMEAciM6HqQ6p3mnl3UnfXeA3XBCDR7IeAfCyGhNVwzTgHwgk+1s0PCmX477qYDXTW6wrxsbzTezux7fYE8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ex5zCZkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFC0C4CEF1
	for <linux-pm@vger.kernel.org>; Fri,  5 Dec 2025 14:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764943307;
	bh=QRUfVYERmGveEebJq4l8DBoig0ToV3UZrYsdFvYWPX4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ex5zCZkT7HU5m6n9Kh8FZde1EFNDCeVoFuJEHcJfvcNuUkfjIjUycvdHr8bnMzuvn
	 Sg+6ZXYV5mbgo9jfzPhYOhWsVhIBeRV5DPqsoLkBYMpBfURd8vpsJW5QF/hUUGSJL7
	 iDgY8hpCM+cbVCVIxdIUm3A4XmHVzTmCCDaguQ13iffh1dZGEnzHB0xhySsmm9Xfq9
	 LTjO0fBXTjS8+culOzzn7wODEj2KcQ0era2/Fr4rfJQGRp8aasatgNunbUhez4HrY6
	 mSvOgkB2YOzX9HywjgxPYM/zwKgx7f4HMXcnD/SglwD6iWaaw+dd5dSOwoVS/aff9+
	 TVHUzQIXe9Erw==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4511fa1e3efso740753b6e.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Dec 2025 06:01:47 -0800 (PST)
X-Gm-Message-State: AOJu0Yzg3lHtLpt3A42lzAQy0DzFZw50nHPq67bYP5FIJsPQyEbThKMs
	HWb23rxTpA+c1q2RoCEzsllRvl3ZA9iOsrhXNeCDOkrBQgmc7dDBX2RhpFDD2EqZbGD6USEFgxE
	z/p9pZiuCHy7b63cOHUKgzQeQaSY+TTs=
X-Google-Smtp-Source: AGHT+IGT+hBffcL0/w+SbePmIBoLKGNP1FFeDv69uF4yulDR4WV17lSgw6Jidxv/K7asxuYy/WFutSUt795l9BR5QrU=
X-Received: by 2002:a05:6808:2213:b0:450:7169:80e5 with SMTP id
 5614622812f47-4536e435c96mr4897889b6e.27.1764943307028; Fri, 05 Dec 2025
 06:01:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201031811.1362803-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20251201031811.1362803-1-kaushlendra.kumar@intel.com>
From: Len Brown <lenb@kernel.org>
Date: Fri, 5 Dec 2025 09:01:33 -0500
X-Gmail-Original-Message-ID: <CAJvTdKkYz7JxW0eW0-2hcxg-1ThS4=2HnHZUdhp_=c-VPAVP3A@mail.gmail.com>
X-Gm-Features: AQt7F2rSwSNskoPr1QBuVvkaTGiOIHqebMISIMvYJSK6C9z3aEOJOHYyzVB3hBI
Message-ID: <CAJvTdKkYz7JxW0eW0-2hcxg-1ThS4=2HnHZUdhp_=c-VPAVP3A@mail.gmail.com>
Subject: Re: [PATCH] tools/power turbostat: Refine iteration parsing
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, 
	"Bityutskiy, Artem" <artem.bityutskiy@intel.com>, Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks like the code tweaked in this patch and the next was a result of
copy/paste of correct code use of strtod().

But here the result is simply an unsigned long counter, so we should
probably be just using strtoul() and checking errno.
In the unlikely event somebody sends a negative value through,
they'll get a big positive number -- fine.

thanks,
-Len

On Sun, Nov 30, 2025 at 10:20=E2=80=AFPM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> Validate the `-n/-N` arguments as signed ints before casting to
> unsigned,so the user sees the correct value in error paths and
> negative input is rejected cleanly.
>
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index f2512d78bcbd..807b2d7f1809 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -11123,20 +11123,22 @@ void cmdline(int argc, char **argv)
>                         /* Parsed earlier */
>                         break;
>                 case 'n':
> -                       num_iterations =3D strtod(optarg, NULL);
> +                       int iterations =3D strtod(optarg, NULL);
>
> -                       if (num_iterations <=3D 0) {
> -                               fprintf(outf, "iterations %d should be po=
sitive number\n", num_iterations);
> +                       if (iterations <=3D 0) {
> +                               fprintf(outf, "iterations %d should be po=
sitive number\n", iterations);
>                                 exit(2);
>                         }
> +                       num_iterations =3D (unsigned int)iterations;
>                         break;
>                 case 'N':
> -                       header_iterations =3D strtod(optarg, NULL);
> +                       int h_iterations =3D strtod(optarg, NULL);
>
> -                       if (header_iterations <=3D 0) {
> -                               fprintf(outf, "iterations %d should be po=
sitive number\n", header_iterations);
> +                       if (h_iterations <=3D 0) {
> +                               fprintf(outf, "iterations %d should be po=
sitive number\n", h_iterations);
>                                 exit(2);
>                         }
> +                       header_iterations =3D (unsigned int)h_iterations;
>                         break;
>                 case 's':
>                         /*
> --
> 2.34.1
>


--=20
Len Brown, Intel Open Source Technology Center

