Return-Path: <linux-pm+bounces-18067-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5419D8830
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4F2DB28B17
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 13:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2391ADFFB;
	Mon, 25 Nov 2024 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhOncQHp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032BC192B7F;
	Mon, 25 Nov 2024 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543004; cv=none; b=igR8op5JgNvjrDetD816IRo3C7CYo+Po5N7cijoy5UjdXzxqyWowaOjRtjx/EDVAzXl6Eook1sDNxTKaxPdiiez2gkWMlj1IkchDvdHDuRenp0z9utx2NY4fMzPlMYEnYKow0fh/RPfmTbMiHAjDdpNpDKIgjew0RYMNOaCskgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543004; c=relaxed/simple;
	bh=aQ3kPKwFN4zEEb7voESayUXG0esLu5zBbBV1BXbivoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l481tnlrFH7RqUZKZasyJcJxYLyI9NcC9G6ivJbt9cfTQFbEiQEKTX3xNdTWPY4NRRQYC1xDKiteSXYiCDXbKgk+sCNZcqmHw8Om5joZosdY7XPG3SsC1hzhxoEbqcNdRg/CYLSZN9WTMK76lzgidMb0jzpJjod8OsLMDwnjMkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhOncQHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA925C4CED7;
	Mon, 25 Nov 2024 13:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543003;
	bh=aQ3kPKwFN4zEEb7voESayUXG0esLu5zBbBV1BXbivoA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AhOncQHpjqYuekVsXhDqt5vj7s7oK68KcAcofJYGfeUnoSeza4YLzN+llCojDa8lp
	 0YFeXteBxQmiSUnd8Ov2bHAYmoSQqoH0eVhX2Alojvt1kWNMe+p5aSOoHG5c35+9d7
	 6kTFEIS9U4vQrBLcDBx9Un2gtWfNUpMFX7PIRtbz4vbFYDL6ivxa/EBOvx4qvkTnlz
	 YPtcxW0R3oqfkg8Gqr75H6qLgYOwsNkjbC436rlKiTJuVxVTd1WgLbTL8Q4K1JRqTN
	 H7FbkrpOOaOb0AXvL5brlLaLY4yM7TDX+ff+S9sY1u2NRVSB420wliwFvdEgCA1WDo
	 t8C4EV0ICgiqg==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-296252514c2so4083199fac.3;
        Mon, 25 Nov 2024 05:56:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDH1OLoJj9v7Nopt0qwR91bZDm9DHvqV8stOSBydW+QgYFfJaQBr4SbeM+E73/i/eYY4Il0VKtXWU=@vger.kernel.org, AJvYcCXvGCbNnbgdxr0lGFv1KVAztdHvUAQQdj7kK5V/K9LMB3Gg6QgJd1wHnc+0O0dEVV3eIHqrxQxWR1k3Zbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2q/xqJlNZvpotKELZp+QFmoVC8UdmX/y22HTV+e1kLh33f5aJ
	mQsTFd59YD4ScA5op9H0Ca0ChpfTNUYoVuzNCLf11OWSJPbDN5ZwsKzcGqikhozRwInnlQmN4um
	yeXY6voVaBKK1yN3WQ4wwe1HH1cU=
X-Google-Smtp-Source: AGHT+IEYsrebkab1644v7n2zrUxAORRQu64zbrtLTkarwN0fejaRuuPD0DP/Thecxic+07PoxYn/mwfshu5J+YPxNA0=
X-Received: by 2002:a05:6870:20b:b0:277:f826:edcc with SMTP id
 586e51a60fabf-29720b1ab8emr11374215fac.5.1732543003095; Mon, 25 Nov 2024
 05:56:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com> <20241125132029.7241-6-patryk.wlazlyn@linux.intel.com>
In-Reply-To: <20241125132029.7241-6-patryk.wlazlyn@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Nov 2024 14:56:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iJ7hca68Pk1g1m=FNX6Psr3Ow-K7fvXZCcRM8PFM7EjQ@mail.gmail.com>
Message-ID: <CAJZ5v0iJ7hca68Pk1g1m=FNX6Psr3Ow-K7fvXZCcRM8PFM7EjQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 5/8] x86/smp native_play_dead: Prefer
 cpuidle_play_dead() over mwait_play_dead()
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com, 
	peterz@infradead.org, tglx@linutronix.de, gautham.shenoy@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 2:21=E2=80=AFPM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> The algorithm based on cpuid leaf 0x5 in the mwait_play_dead(),
> for looking up the mwait hint for the deepest cstate may calculate the
> wrong hint on recent Intel x86 platforms.
>
> Prefer cpuidle_play_dead() over the generic mwait_play_dead() loop and
> only fallback to the later in case of missing appropriate enter_dead()
> handler.
>
> Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
> ---
>  arch/x86/kernel/smpboot.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index d0464c7a0af5..2627b56fb9bc 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1413,9 +1413,10 @@ void native_play_dead(void)
>         play_dead_common();
>         tboot_shutdown(TB_SHUTDOWN_WFS);
>
> +       /* The first successful play_dead() will not return */
> +       cpuidle_play_dead();
>         mwait_play_dead();
> -       if (cpuidle_play_dead())
> -               hlt_play_dead();
> +       hlt_play_dead();
>  }
>
>  #else /* ... !CONFIG_HOTPLUG_CPU */
> --

If you first make intel_idle provide :enter_dead() for all CPUs on all
platforms and implement it by calling mwait_play_dead_with_hint(), you
won't need mwait_play_dead() any more.

