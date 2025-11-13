Return-Path: <linux-pm+bounces-37949-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9EEC57408
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 12:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F9E13435ED
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 11:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E21234678C;
	Thu, 13 Nov 2025 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlS33/NY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC2327B34E
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034129; cv=none; b=VGpPSHfBa8Dyq2bg4vUyajgvGAlslz1SF8TLJ6fqcxRvfBtyUvrsmP+sQwe2ou94putyqCkLDB16EXbabrQ985snH4bLuQeMPe5dPQ4pcbXtPOlPYlwlUIAKFMYqwZ0ePa9062FU/d9Rlu6OC9/Hs6kPFDZJwDmNJRF5VBB6WDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034129; c=relaxed/simple;
	bh=ddFwqLnQJlKV3aOxJU2DS52t8kckbgVgSE8PJIhlAmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vv3KXU+21qzCUfuVpu60EGS0OQNNX2+ocKBueqUEbqRl0898jmc0GZrjH+vF266DymoSR+Ue9pkNaXoKkgJ8k2f9Dw0m5wBkSEXqJVcn6engu1YP1R5tUI65gSxaqGe0FT9N1VZYJlcddjr7kWJehjoKYPoWMTRiQvgGp9fLWFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlS33/NY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A43FC16AAE
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 11:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763034129;
	bh=ddFwqLnQJlKV3aOxJU2DS52t8kckbgVgSE8PJIhlAmY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VlS33/NYvJE5FmjZRU4a9RbWKovXYCmzVjOPWSraNYO8ndic/RBw5ezb29ixz9UXf
	 /fazub0lR4uO+wVeY53BwLRvXzUpFIrTBsZsI9xHNYzP3OqNfGqVf3s7Lqcg0fWK7m
	 Un2uf8drgiSXtSP1UV9aADX9usVzqngVbsqSNsqkfxq7G/dAIF2+0Zc38xRoXbEeZd
	 3zl7ACQp+ZCgHcxC4x53rAAPwnDl6ST9cXjzaGeSDyLK7FnsfpQ8/N1luEoOWsfMHk
	 kkjJ9FlaH2fFe/5E+rsfWtv5yXRrIfnkRkGyVTdLS35jqPPZ+CeS91OacWx1l6A4Yt
	 jLKXP/+FsBqJA==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c707e11e01so771852a34.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 03:42:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8dgwThE1S+rtS61JtoLY0Rk8nyyrnS2MZBjFvpqw7ZGuFgky2GsTQKxvOMHegi8GaEX6La+IkMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YygsX2jMlPLiN7/t+0bG6vRuXv9HOkav0RsNf4cGKVRONtoShgG
	Ft9H1gNvNwGs5WSwH+g455bOQzQRtXbHv2flD1Sl5tC8Jk/ZAxdi3HCRylUmJns8pqrO0fyefOI
	gcYmFbRHaxdS4sNzZi9/bevw8TvdoLec=
X-Google-Smtp-Source: AGHT+IESNkcR7HTwZDRoj+plg6dX4TDWbHCNXpBwc/CKdqVBd4FzVs9eQXYkQ7kuonE1Yp2vuJV4fA72SXxhVW9NAb8=
X-Received: by 2002:a05:6808:4481:b0:442:82:3efd with SMTP id
 5614622812f47-450744e1414mr3140366b6e.18.1763034128819; Thu, 13 Nov 2025
 03:42:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4701737.LvFx2qVVIh@rafael.j.wysocki> <5035693.GXAFRqVoOG@rafael.j.wysocki>
 <1dc4934f-a3ce-4ead-a43c-0a80987364b6@arm.com>
In-Reply-To: <1dc4934f-a3ce-4ead-a43c-0a80987364b6@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Nov 2025 12:41:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h5PkU5t=uPVO2Evq0gNrX4vYkAJFVDPLsqzCGKXnb+_w@mail.gmail.com>
X-Gm-Features: AWmQ_bk3qqAr61IFZ-TOHGdFwUClDO8RGDccAN0g-Z-NomYKD1ZDa4V8jMM6X6M
Message-ID: <CAJZ5v0h5PkU5t=uPVO2Evq0gNrX4vYkAJFVDPLsqzCGKXnb+_w@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] cpuidle: governors: teo: Drop incorrect target
 residency check
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Reka Norman <rekanorman@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 12:32=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/12/25 16:22, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > When the target residency of the current candidate idle state is
> > greater than the expected time till the closest timer (the sleep
> > length), it does not matter whether or not the tick has already
> > been stopped or if it is going to be stopped.  The closest timer
> > will trigger anyway at its due time, so it does not make sense to
> > select an idle state with target residency above the sleep length.
> >
> > Accordingly, drop the teo_state_ok() check done in that case and
> > let the governor use the teo_find_shallower_state() return value
> > as the new candidate idle state index.
> >
> > Fixes: 21d28cd2fa5f ("cpuidle: teo: Do not call tick_nohz_get_sleep_len=
gth() upfront")
> > Cc: All applicable <stable@vger.kernel.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/teo.c |    7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -458,11 +458,8 @@ static int teo_select(struct cpuidle_dri
> >        * If the closest expected timer is before the target residency o=
f the
> >        * candidate state, a shallower one needs to be found.
> >        */
> > -     if (drv->states[idx].target_residency_ns > duration_ns) {
> > -             i =3D teo_find_shallower_state(drv, dev, idx, duration_ns=
, false);
> > -             if (teo_state_ok(i, drv))
> > -                     idx =3D i;
> > -     }
> > +     if (drv->states[idx].target_residency_ns > duration_ns)
> > +             idx =3D teo_find_shallower_state(drv, dev, idx, duration_=
ns, false);
> >
> >       /*
> >        * If the selected state's target residency is below the tick len=
gth
> >
> >
> >
>
> AFAICT this check was to not be stuck in a shallow state when tick is alr=
eady disabled.
> There might be a timer armed in t+500us but that might still get cancelle=
d, which
> is why we didn't think a below TICK_NSEC 'shallow' state is acceptable?

This is all about hrtimers which are not expected to be canceled too
often and real energy is wasted here by going too deep if the timer is
not canceled.

