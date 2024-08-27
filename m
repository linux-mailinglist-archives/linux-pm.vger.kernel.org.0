Return-Path: <linux-pm+bounces-12960-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A93E4960945
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 13:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556BA1F240FC
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 11:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40231A01C6;
	Tue, 27 Aug 2024 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvllLxzg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0D5199926;
	Tue, 27 Aug 2024 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759371; cv=none; b=lJVLtC0R4DF4c7r1tOhCcx19E7YKkKVfC8HBRstJ75ClJUPE9/mshqrU2nUSwNzmx8jl081gcfMg2dQ9yOSoBffsSUpDmZJWuDt2nG6MS81NOWCkvxvMLlsYSwms1l8+Y+r5q3jjwyCwkEnNRNT4QqoaAcRX9o7OMnck3IMBe6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759371; c=relaxed/simple;
	bh=q8fat2cHBmCFbst/4767sxbNMOrAnZzY/bgzJE0Z8ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvtyBn9w2rDUws19up/+K3OtREAw6ZA1vi0WPILljqpbGcJHFvXJCsM/YF/xE5SRCHX9Q3LTeMDssHWwvHBCzfLcUC5gq9DZUJ70tSnrAggZinEoO5ZqLISHNmoJCVyftMbxU3ZWJBrljkgZ0Mo92EoAVs4nSpdUhZMaNKNVAPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvllLxzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A0DC4D04D;
	Tue, 27 Aug 2024 11:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724759370;
	bh=q8fat2cHBmCFbst/4767sxbNMOrAnZzY/bgzJE0Z8ZU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SvllLxzg08LQfpUpPIVkUuqR/vUIVc4CzE55y0mTVYTpYMPiXfMNS9F8vE1IPfGbj
	 jSkyal5Tht/D/jNNImeTsXJZk5X/CmLweNHMkdG86WLGmo1atThW48c6h4R+g0YaGN
	 V1hv0qUaQq7So1vomuqFahVLcVuROj3LCtM3yF77NmxCDml5GIODxtWAlyY/WLjdWL
	 TEexoytpzg9AEkA9UzEbMww/qGWDgNfxl4Q9lpf6okFbscX3dwot3hB5kVPnPHDV8r
	 YmEA6R1lANeghi9WLcAmLZb84bBQ4EgB7t/cGlv/HqbNuMS5JerB3oWz5OAdCyvj4G
	 BzaSwHH1q56yA==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-70944d76a04so3816525a34.0;
        Tue, 27 Aug 2024 04:49:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmVsS6fNOLB3ghb5buLhLFNcVbLjz1PJnpeCWEfVAh/dhMVM3PKYLZv9rwmwugV7EKP2ehB189p7OA8gQ=@vger.kernel.org, AJvYcCWEC4y+V7PbPj4c+gAJhbGtOS7rhdtsNFWYBAS+8b2Z3kUtI6WJV4M+dMJQta8oFIAYKtjkhxpLSmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkJCSpwTcsAPTqRa69z8hzyFoi5bg/cxzMu9p656NjT4AKsWAq
	FtPMaSSNMCRDhAwWf90kWUiDrpqAoUkv+Tt0rZOS3/dX5V7Y5mWXJMU7Wu2wBEmJs2gVDZEETwV
	3oWc7b/bt1oYno2l0h2RObvSCHGU=
X-Google-Smtp-Source: AGHT+IE36XhiYJ2H724axgI4XwB6FfmDGnCfm2PQ028NCZUMo3q753Wj2wjuyDMs5VwFtDOxS+I14wbr7vjD1wb700g=
X-Received: by 2002:a05:6830:2112:b0:703:6b11:33a4 with SMTP id
 46e09a7af769-70f47ac60fbmr989902a34.9.1724759370153; Tue, 27 Aug 2024
 04:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4941491.31r3eYUQgx@rjwysocki.net> <3311190.44csPzL39Z@rjwysocki.net>
 <20240826230742.GA7773@ranerica-svr.sc.intel.com>
In-Reply-To: <20240826230742.GA7773@ranerica-svr.sc.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Aug 2024 13:49:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hiNxLsX2ExT8QphkTev4-i++4xo4CuG3rVkLqTZsiBgA@mail.gmail.com>
Message-ID: <CAJZ5v0hiNxLsX2ExT8QphkTev4-i++4xo4CuG3rVkLqTZsiBgA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] cpufreq: intel_pstate: Set asymmetric CPU capacity
 on hybrid systems
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 Maintainers <x86@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 1:00=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Mon, Aug 12, 2024 at 02:44:30PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> [...]
> > @@ -3143,6 +3341,20 @@ static int intel_pstate_register_driver(
> >
> >       global.min_perf_pct =3D min_perf_pct_min();
> >
> > +     /*
> > +      * On hybrid systems, use asym capacity instead of ITMT, but beca=
use
> > +      * the capacity of SMT threads is not deterministic even approxim=
ately,
> > +      * do not do that when SMT is in use.
> > +      */
> > +     if (hwp_is_hybrid && !sched_smt_active() &&
> > +         arch_enable_hybrid_capacity_scale()) {
> > +             sched_clear_itmt_support();
> > +
> > +             hybrid_init_cpu_scaling();
> > +
> > +             arch_rebuild_sched_domains();
>
> sched_clear_itmt_support() also calls arch_rebuild_sched_domains(). The
> latter is also called earlier via sched_set_itmt_support(), totaling 3
> calls, two of which are wasted.

Not necessarily two because arch_enable_hybrid_capacity_scale() may
return "false".

But you have a point.

> Perhaps at minimum hybrid_init_cpu_scaling() can be before
> sched_clear_itmt_support().

It can.

I'll send a new version of the patch with this change.

> The changes made by these two functions will
> be picked up in a single call of arch_rebuild_sched_domains().
>
> Moreover, ITMT can be not enabled at all if so we wish. By the time
> intel_pstate_set_itmt_prio() is called, the value of hwp_is_hybrid is
> already known.

But at that time it is not known whether or not
arch_enable_hybrid_capacity_scale() will succeed.

Thanks!

