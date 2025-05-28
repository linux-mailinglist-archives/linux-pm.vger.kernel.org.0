Return-Path: <linux-pm+bounces-27732-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F370BAC6928
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 14:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1DB3AC2AD
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 12:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D7C284686;
	Wed, 28 May 2025 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+03zCAX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B02283FE7;
	Wed, 28 May 2025 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748434916; cv=none; b=T+pte0oy8WGkv4VYKIyXOqEZpTmRnQAz665X7iTSDpTI32Sw2fH30bWREViXYTsK2SC4gKRqxgE3yuoA5bU3r5i9rGQvHvFm1tF5RrfbsVfUSgfkTSVh3OE4A8JFanL4CauHRdjOtsDeR/w93E4fpHh2+YrPQBIP5D4Du2mIXnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748434916; c=relaxed/simple;
	bh=qAZ/wOMuI+avVLBxNSSM2GqHvIz8HRO9NLZob65A/yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofKVyeZv32XCvZCamQbFdC5DdLqhOFDIRDnSp0SNGqZvLtADsci3ywplenrntt8bLKBvVzlLnNQXOW5m6POjlWRGJSRLsMznzY6HV20JLPCwbix1wlwFcBPOwN+LUA9cAajLjkXssccBtLyw8m0NZ/0bdZtIajUKC+12+zODHC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+03zCAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC9DC4CEED;
	Wed, 28 May 2025 12:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748434915;
	bh=qAZ/wOMuI+avVLBxNSSM2GqHvIz8HRO9NLZob65A/yg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f+03zCAXtGnDiK4MAx3rfsk42I358GMAK31KywSw1Odp0LvuDR0xuXPiO1GeCub/v
	 KNFEbh03SupHa/kQUOB3Lpshmb3JMBG1YfyquGI91RncqJqwv/umq6RMRuPC7bOBIB
	 RPFowboH9AhAnggOdxcG2DQ/hwTfdM62V05eq4zo1cf4iuUjaowR+1SSc+LZ5uIQKk
	 tZaZqvKUo2zpcXV+Y+P3wbl3tVyRfBiY3MmN47AJYU0+3S+UTG92H8Cpm9dPAZU6r3
	 PCL/bpW2lSubG7f12wfA+PukwwheihABTM5j4CICIBDUtU7KEmpSckZ3SNps+E278z
	 CPWN2Dz+pDc4Q==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2e8ec65078eso220406fac.0;
        Wed, 28 May 2025 05:21:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/6+9Kf0N5QGYidp9ecvRJ0lO1p+mKaNh8xv6enqrD7dIwmJUszDZV3aCGMgKv4Uy/LJAk158aoBPtWiHOraY=@vger.kernel.org, AJvYcCX89RSSR63FeApxNy8xclAdf/Tpds0BKq7ICrEQueGUENjjl0Ztwq4Rf4ATmgPNlyjlBBtfUwR4oA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0q4PvymgbSmAEDnwHa9L1qeWL3BA3Y4ihQEmMAMYv8EYO5mo5
	G7Djt6eHt6+ZP+Vg0Ow5mbjMTHTWOYbTPDo+V1Qr2PjFcWFUZVo1vuHFEJQ5kzccXK5ioGKHjT2
	wtPneciz5P4HS9z/cvIY1IXei9F1cNIw=
X-Google-Smtp-Source: AGHT+IFnVV8MGzXihwUJx1VtzWU8xZ7hAtIwGIeHKkc9MyxZPIRC8Ab/TlNkj8E+qCKbhj3Ije86mid18sWNtBCwuXA=
X-Received: by 2002:a05:6871:113:b0:2d4:d9d6:c8c2 with SMTP id
 586e51a60fabf-2e862100167mr9904999fac.34.1748434914481; Wed, 28 May 2025
 05:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520061944.pl3mqw2clo2roe3s@vireshk-i7> <CAJZ5v0gBRQ87bFk3-MCOudgvGWb29O_ihfz0Lo2kGcVpfSu=nQ@mail.gmail.com>
 <CAJZ5v0iNwBhpmkwuo7Z_dGmLE5KQGONNRrt5kykXXKRoORTShA@mail.gmail.com> <aDb3JzdsrrLAxPlW@google.com>
In-Reply-To: <aDb3JzdsrrLAxPlW@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 May 2025 14:21:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iAU5oGvqvtoHAxOOUH5PkN5Q03bUqXWKR7DCdiLMELZQ@mail.gmail.com>
X-Gm-Features: AX0GCFuLOu07YLrwnGGmnOdJ_4ZnMR7X9ND5khZ5QV_5cbJaH8fcAoH0CbwawmQ
Message-ID: <CAJZ5v0iAU5oGvqvtoHAxOOUH5PkN5Q03bUqXWKR7DCdiLMELZQ@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.16
To: Alice Ryhl <aliceryhl@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Linux PM <linux-pm@vger.kernel.org>, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 1:44=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Wed, May 28, 2025 at 01:35:35PM +0200, Rafael J. Wysocki wrote:
> > Two merge conflicts between this material and the mainline have
> > emerged since v6.15.
> >
> > I've resolved them (they appear to be straightforward to me), but I
> > would appreciate double checking the most recent pm-cpufreq merge into
> > linux-next:
> >
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git=
/commit/?h=3Dlinux-next&id=3D25eb7dda15f182b7355488a5aca47078643633dc
> >
> > and letting me know if it looks good.
> >
> > Thanks!
>
> Usually we keep them sorted:
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 88ab11d74fc7..2c917889d9ba 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -10,8 +10,8 @@
>  #include <linux/blk-mq.h>
>  #include <linux/blk_types.h>
>  #include <linux/blkdev.h>
> -#include <linux/configfs.h>
>  #include <linux/clk.h>
> +#include <linux/configfs.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 6eb61c87b616..3a618f82fb02 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -42,9 +42,9 @@
>  pub mod block;
>  #[doc(hidden)]
>  pub mod build_assert;
> +pub mod clk;
>  #[cfg(CONFIG_CONFIGFS_FS)]
>  pub mod configfs;
> -pub mod clk;
>  pub mod cpu;
>  #[cfg(CONFIG_CPU_FREQ)]
>  pub mod cpufreq;
>
> Otherwise LGTM.

OK, it should be fixed now, thanks!

