Return-Path: <linux-pm+bounces-18074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCB89D87C3
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5491B28CB9E
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 14:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CF01AF0C0;
	Mon, 25 Nov 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxZjpkzi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688181F16B;
	Mon, 25 Nov 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544372; cv=none; b=KJusP/c6DGerRJBq4xdZ5Vq4sPjZsotiXmOSYfuqmMVZBITx6y4OyxGC4RvHaKldPIHjUMZv7OucFbJ0olxYh0Ez7eXqLrwrbkTM+Z6Sr4QDxxlNaYfAumGWmkWIBAVrDelePG3TmqZ3W014tVvpM2d5lwgi4dyCYDbhLzg9qXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544372; c=relaxed/simple;
	bh=uVDmbmX/lOn6vaUu9QQEzPY2m2xU472Sx3+fQq3oSsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9/wOaB44NsYHLrPcHz2veVSq6rMT4wGQeMmrA7fwu4/6OZloHeQ7Xv5pWrPR4eO7OgCGUDMg4kdQBf70/oWubZY4V9QRxGRp9E2P1Cg6ajpkQ6xaqsOFXMpFvefm0luUPigSWombOKy4K3V5lHv1ERjt7rjyt72ahpmQXBeruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxZjpkzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4F5C4CEDA;
	Mon, 25 Nov 2024 14:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732544371;
	bh=uVDmbmX/lOn6vaUu9QQEzPY2m2xU472Sx3+fQq3oSsk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rxZjpkzirh2cCiDN0pyvtX1O/CyWHIVNUKWKYeNEGj8/98sAzkd9A7XUwYalgJBZQ
	 7JY+rxP2WzHXe2CU4eshn6Hq0nfY0IolsZu0iyOLt8mf8RGYenAK7pbcPvzxGE7KUS
	 fmHLD4/YUU2S7/OvWBYK4HFLWnLVpXMEzhT+3CJGt/aOORAnForCZ/sjKRvy90Db+X
	 WSWIT5Bdl/loU204N0WdwRVIUdkdbXkmx+aGPZVl29sFjtNKr6grhUOlJWkX8J8J7m
	 xM9X2ElA/1OhVXoUCrpxg7k/ybAl0MJ6/JOwcgm1ksD2mN1/cRfUlWhjDjHBzNPDTZ
	 8s0bArv7n9smw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-288fa5ce8f0so1952948fac.3;
        Mon, 25 Nov 2024 06:19:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1ReI8dwMZGmXE6/YbsAV7praZSBldKH51iJgKyqfwZu7V1yJbh8e9tzJ93oGk8+Yp6zpJ4I41BU8=@vger.kernel.org, AJvYcCWGYfu5mvCdQnCmkwQvbhs6sr56Nz17BTTT6BjoR2BYtodUNHydVu9lOmdgELVuJtTGzrxFpJcHyScao+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi7MIEh2B/Y1L7xq9VrCztSdxt/ICx35t5nM/kT7nadX/xCafr
	cHhKQ9B/a+P0/N7kMGq2CwQfac8OxuZJAd0wI25fgvOpznIo+8PzlgJBO11zR9sb61mMcB2rgFA
	hSz4bgA+s5b6Nw1uoutlFa66AY3c=
X-Google-Smtp-Source: AGHT+IGVw/NzEg5AyRdD9z0sHs5Iokng6vIT+m7h/CP2/9wgpegaRYEizADg68Die/WsQP75mfIl6PeAD71QYwZRCDM=
X-Received: by 2002:a05:6871:b2c:b0:288:50aa:7714 with SMTP id
 586e51a60fabf-29720c18412mr10390109fac.24.1732544371076; Mon, 25 Nov 2024
 06:19:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
 <20241125132029.7241-7-patryk.wlazlyn@linux.intel.com> <20241125135306.GD38837@noisy.programming.kicks-ass.net>
 <CAJZ5v0gXy5FNsRepBTAyBS++HmhszZbN22KgfO8M=mXRVK9d6Q@mail.gmail.com> <20241125141215.GF38837@noisy.programming.kicks-ass.net>
In-Reply-To: <20241125141215.GF38837@noisy.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Nov 2024 15:19:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g1C7EDoQ7687p9AqiPDEEfPjh+5NuOO+PjaRmGKMcfBw@mail.gmail.com>
Message-ID: <CAJZ5v0g1C7EDoQ7687p9AqiPDEEfPjh+5NuOO+PjaRmGKMcfBw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 6/8] intel_idle: Provide enter_dead() handler for SRF
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com, 
	tglx@linutronix.de, gautham.shenoy@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 3:12=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Nov 25, 2024 at 02:58:50PM +0100, Rafael J. Wysocki wrote:
>
> > > @@ -2143,10 +2143,15 @@ static void __init intel_idle_init_cstates_ic=
pu(struct cpuidle_driver *drv)
> > >                 if (intel_idle_max_cstate_reached(cstate))
> > >                         break;
> > >
> > > -               if (!cpuidle_state_table[cstate].enter &&
> > > -                   !cpuidle_state_table[cstate].enter_s2idle)
> > > +               if (!cpuidle_state_table[cstate].enter)
> > >                         break;
> > >
> > > +               if (!cpuidle_state_table[cstate].enter_dead)
> > > +                       cpuidle_state_table[cstate].enter_dead =3D in=
tel_idle_enter_dead;
> > > +
> > > +               if (!cpuidle_state_table[cstate].enter_s2idle)
> > > +                       cpuidle_state_table[cstate].enter_s2idle =3D =
intel_idle_s2idle;
> > > +
> > >                 /* If marked as unusable, skip this state. */
> > >                 if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_=
UNUSABLE) {
> > >                         pr_debug("state %s is disabled\n",
> >
> > You can do the same thing with :enter() I think?  And it doesn't need
> > to be in one go.
>
> !enter is used as a terminator.

Ah, OK

Something like (!name && !desc) might be used for this purpose though.

> And it's harder to not do everything in one go; regex ftw :-)

Yeah, whatever.

