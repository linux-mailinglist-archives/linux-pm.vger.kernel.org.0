Return-Path: <linux-pm+bounces-40950-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C10D28638
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 21:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAFB63016DFA
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 20:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB14931ED83;
	Thu, 15 Jan 2026 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnmrF4Hf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CF2218592
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768508547; cv=none; b=utw/9bLw3KzOoUvPW6IKodN5yvTtHtnN12C4HyujTzKcc+45Rd3ai45nXeWkaarHsvynStJDF0fvIXjLmBDiCwRLIpS6jheT1jT7iq3ZjuEkeozzj30urvBOQIicJTqRe3ZsDBHST2jVlaDt1bouOPy3gvlLHN9nBw6kXage2DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768508547; c=relaxed/simple;
	bh=OLsLk73OEyqOOy1b/9Vab4uD+BqNpdyGhNoaxuUd1Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pk9+Uwx0j/F1RhwOpe28w4bRhKoASMJ9/VIwEqLlm5qvigH2DUmK2+uc0Yon/dJWhZCJXC/FtksHrHcNyi/+ZVneUcvnTSsqqUtcAUYaxX70/zcjI87NdiYVE+Gyc+ElX57Nz/9tg33vKBYDToGG2B5WtZnE8is5ZA4nDrmNMx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnmrF4Hf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524F1C16AAE
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 20:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768508547;
	bh=OLsLk73OEyqOOy1b/9Vab4uD+BqNpdyGhNoaxuUd1Os=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tnmrF4HfPnGAn6TMBdx7Ut/ftRKwTKeN10S72fqSfUz1/oHJ9xjujvEVxYzN04hMw
	 RrtOVbEUAvkmUD5CAkJszj/8q30l8RJ7Ju830h3kDlymE/Y5nXN865GE/m4MdWsBRC
	 qVjcChgX1f4UUCJxRlz3FUKVswuQap49xE43aHUjY9ZTzm8LTSBQxvmgCGGzotcgkh
	 7YAKtv4SVcYt+RYTYF0NkxZKDetOv8znJP+A6EGM701NeOL0TazMJsNDdyTFeZu0ih
	 D66ly1/vHmkrPlmXHFakaZYucy48cCdrZwcqKXYkbUyKSJSz8ANiWd7lVVjnpdbn++
	 W4C7fVvFiKpVg==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7cfda7bf36bso329213a34.2
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 12:22:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWvCtWX4oDwqI1xYwFuWC76ypdw5vj2mrdLGdW9juy5spFYQenYymgNDfdc1scOrZZo5iXL8p9R4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAClRwh5dzLUFKV1ah5LVpbE+Wi8DxyvwkCFluK8DLPLnvkr5i
	32ATUTj9Dvc89WKmtVIBENc/qMDRVla78m0akXkMfWMQjLktdyPRvoqJQu83p7JSIv4Du+lWeqv
	a9qDPsXeT9MxVDRJqsJMNOq/d6dorJB0=
X-Received: by 2002:a05:6820:627:b0:65c:f019:ccca with SMTP id
 006d021491bc7-661188f95d8mr232573eaf.21.1768508546439; Thu, 15 Jan 2026
 12:22:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113082130.789891-2-thorsten.blum@linux.dev>
In-Reply-To: <20260113082130.789891-2-thorsten.blum@linux.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Jan 2026 21:22:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iZyTJ8_jugscVtcYM=DE5Kj25uh8AfmC-Gbp8GGgxT0g@mail.gmail.com>
X-Gm-Features: AZwV_Qg0o4g4ykMgrK2-hFOOOWMWsfRCbs-kpaLxBPtjDRQYtW8pfJuO-6XksUo
Message-ID: <CAJZ5v0iZyTJ8_jugscVtcYM=DE5Kj25uh8AfmC-Gbp8GGgxT0g@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: Use sysfs_emit in sysfs show functions
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 9:22=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Replace sprintf() with sysfs_emit() in sysfs show functions.
> sysfs_emit() is preferred to format sysfs output as it provides better
> bounds checking.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/thermal/intel/therm_throt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/=
therm_throt.c
> index debc94e2dc16..44fa4dd15dd1 100644
> --- a/drivers/thermal/intel/therm_throt.c
> +++ b/drivers/thermal/intel/therm_throt.c
> @@ -23,6 +23,7 @@
>  #include <linux/types.h>
>  #include <linux/init.h>
>  #include <linux/smp.h>
> +#include <linux/sysfs.h>
>  #include <linux/cpu.h>
>
>  #include <asm/processor.h>
> @@ -144,8 +145,8 @@ static ssize_t therm_throt_device_show_##event##_##na=
me(            \
>                                                                         \
>         preempt_disable();      /* CPU hotplug */                       \
>         if (cpu_online(cpu)) {                                          \
> -               ret =3D sprintf(buf, "%lu\n",                            =
 \
> -                             per_cpu(thermal_state, cpu).event.name);  \
> +               ret =3D sysfs_emit(buf, "%lu\n",                         =
 \
> +                       per_cpu(thermal_state, cpu).event.name);        \
>         } else                                                          \
>                 ret =3D 0;                                               =
 \
>         preempt_enable();                                               \
> --

Applied as 6.20 material, thanks!

