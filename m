Return-Path: <linux-pm+bounces-26969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E02AB1ADA
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 18:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12339A0846A
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 16:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520E222DF82;
	Fri,  9 May 2025 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StvVQEfL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A4A1E3DFE;
	Fri,  9 May 2025 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746809306; cv=none; b=uFLdiL6t2IdDOrVaYTaaIZUEcgdtXEgsGnAsUyYnWHKNveOOC3oAv1RkQwViZLgrRipPKKneQo9g2bqZsxJGO3yv9kKCWTbFfIFX2jBt/0LK9QssilwwY05aNUu/b+NGmI69K90UrQuFphmTAbGt1zWdFXcfrnVIm4iFMJ2q7vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746809306; c=relaxed/simple;
	bh=W4BlwOAOpXDcFWOiA5llJxsijavgFUfqMaykU1dFutw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZfeOChBqImv7w+L4MdkcqWxhUmwAQ5GRKSu4RUiLu/vkGYROfZffegrZFheE23yUn1ZtsFHE8RILqqB6svqheRTIzj6uHScrvBD3q7ti/zuWO4B4wP4vWze+2G0hvDeg+mEv/f5w3QwBDXTq6a7Ngj1o8LBldnCKtfsigW5EEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StvVQEfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91405C4CEEF;
	Fri,  9 May 2025 16:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746809305;
	bh=W4BlwOAOpXDcFWOiA5llJxsijavgFUfqMaykU1dFutw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=StvVQEfLGL+CesSpOwv6IY03BX+s/d1aeDvmYmeIyD1gIujd4ph3ZXq4WAdT0l8Bp
	 axdJhaHCG1Ko4MxrQB6mLBtUpvK5EnbduUfsaOL4rOGi7SGag6DJdN0zsToRPjep5G
	 vO/17AZRWW/6EwBKpHW+RSs02AyaRhUblERKNfixMVJ7oDqSdquwHGDFx0suNPDLnM
	 I6EHyLlFJTRhrb3bsA2Bupf4E1Nz4qON7CmgQ38xbcBYsrFpBcg7D0jpm+S0l4f+HN
	 BQ94ajEuBmtcdzMxFE6KQLZwWF2fE4lXzVxYyh86O6EZQsL2i8LMsmtiIROhSxx6i1
	 tEyX0IbCuVg4w==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72c14235af3so1456496a34.3;
        Fri, 09 May 2025 09:48:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWYZCS0FI0C6iOOC6fv7RMKpD130onhL1AKSJ4TeGq6wKiZE8Kfeu+oK3Ui2A8jKUrNaBc7xJJs6iQ=@vger.kernel.org, AJvYcCXzlHhp5b7hECBeMdKObLCviwF6hyg35LkSFAEpl0dGeTVDjWUIFcznuKtHi3I4/heVYT+pyKWmQQ+Jaqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0zgrUV1M0BDtEEvLPtKuVTSrlqZx/D0RPreC5P4whrxAlY8iN
	lJEBl40r5Uq/noo9fKpNronbFG8PanFROHBM1l3SEtGhZbHy+UTPqPSS+Ms8pTrZ4HQU9xcAugI
	O934L7ZMTLXRF4HN1mdCwhSaHN/Y=
X-Google-Smtp-Source: AGHT+IG90A80wdNdQxgSBxQGx+GthEA8aaHFTNRSqgeCLm4FKsdL68Vw3eHLZzDe3gNqpFA7hH8Ja17yFeaPZfZNqFc=
X-Received: by 2002:a05:6870:8895:b0:2d8:5015:1a90 with SMTP id
 586e51a60fabf-2dba41f6c92mr2875266fac.2.1746809304850; Fri, 09 May 2025
 09:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506155659.95212-1-pmenzel@molgen.mpg.de>
In-Reply-To: <20250506155659.95212-1-pmenzel@molgen.mpg.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 18:48:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h0tc=5oJ5KsqyvXT6w64tztL8cy-iNF+=8xa2ncAwQ6w@mail.gmail.com>
X-Gm-Features: ATxdqUEApZMpWO-oVpwTqpqItmiXtaXQEGlvyCAPfFbXec14qQ0utxbpQ0phg3s
Message-ID: <CAJZ5v0h0tc=5oJ5KsqyvXT6w64tztL8cy-iNF+=8xa2ncAwQ6w@mail.gmail.com>
Subject: Re: [PATCH] PM: thaw_processes: Rewrite restarting tasks log to
 remove stray *done.*
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 5:57=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de> =
wrote:
>
> `pr_cont()` unfortunately does not work here, as other parts of the
> Linux kernel log between the two log lines:
>
>     [18445.295056] r8152-cfgselector 4-1.1.3: USB disconnect, device numb=
er 5
>     [18445.295112] OOM killer enabled.
>     [18445.295115] Restarting tasks ...
>     [18445.295185] usb 3-1: USB disconnect, device number 2
>     [18445.295193] usb 3-1.1: USB disconnect, device number 3
>     [18445.296262] usb 3-1.5: USB disconnect, device number 4
>     [18445.297017] done.
>     [18445.297029] random: crng reseeded on system resumption
>
> `pr_cont()` also uses the default log level, normally warning, if the
> corresponding log line is interrupted.
>
> Therefore, replace the `pr_cont()`, and explicitly log it as a separate
> line with log level info:
>
>     Restarting tasks ...
>     [=E2=80=A6]
>     Done restarting tasks.
>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  kernel/power/process.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 66ac067d9ae6..92daf1dce8c3 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -189,7 +189,7 @@ void thaw_processes(void)
>
>         oom_killer_enable();
>
> -       pr_info("Restarting tasks ... ");
> +       pr_info("Restarting tasks ...\n");

I would prefer something like

pr_info("Restarting tasks: Starting\n");

>
>         __usermodehelper_set_disable_depth(UMH_FREEZING);
>         thaw_workqueues();
> @@ -208,7 +208,7 @@ void thaw_processes(void)
>         usermodehelper_enable();
>
>         schedule();
> -       pr_cont("done.\n");
> +       pr_info("Done restarting tasks.\n");

And

pr_info("Restarting tasks: Done\n");

here so the messages are more visually similar.

Otherwise this change is fine by me.

Thanks!

>         trace_suspend_resume(TPS("thaw_processes"), 0, false);
>  }
>
> --
> 2.49.0
>

