Return-Path: <linux-pm+bounces-37951-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AC1C57444
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 12:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5200D34DE2D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 11:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C6F348893;
	Thu, 13 Nov 2025 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Atqcd+5B"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B5733F392
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034462; cv=none; b=LalNpmw8SN8JrIAVwNUQGIaYm8JvDO41jPenkP80P6IyV87zzDHfGYFn7CFIubviHfwPHwtnyJY02CZuYnLyCAjgK3ee0AIm94U7WZQUZ7GIX6C5l067czsVOqDc+rYzzQTwWIqodtkd608+jnp68O1K9/mOlsMu1CASYfAEEUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034462; c=relaxed/simple;
	bh=jWdw2jw+YdbW8fogfag9Ht6LK4xid0MJKYX68Mbjwa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHoQq53TiOvRmtXAawQEtEdC90Xp9bWRcSlHmSRpZ8JjT1PpBDTYAS4wa8gqRKh2piidddVs2tdQiumeZMzNi+JjClFntrGkXsHHftGxN9TSnefvEDTH7EHqJbEu0/MOVeOG/DtOAuTyFNIcumyJ+x3SSFQLnsPC2m4lAXr9IdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Atqcd+5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A4AC4CEF8
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 11:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763034462;
	bh=jWdw2jw+YdbW8fogfag9Ht6LK4xid0MJKYX68Mbjwa0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Atqcd+5BHBlvuMyW8Yvumuhl7rq35Y7gTZBEM7/co/p57AHZkrFLFx+aZ5hldE74/
	 WbyMvr8Y30YLVV9Z7XalcK3KCz6BO567/8WTH36WtwxqX8+A8vNz7ultkMaLuwgXMp
	 gb7/mkey9oaYxwkAxWwlhMUPI4jmgrO662bXvPc0kVUfHvt11Gu2KjVF/vv6t619BA
	 VTGMdp42IdwD33p1cnL8vinJPm1E49I30ORuDclo2jVgRNZiS1RLCTZ2+4JiKB+fu4
	 0g2IRZFLoWl4myGGG9tm6y17astLU9y+lBVMKLEEKBSHMcuo4kam9aItkjy2FjosAM
	 I3XjtzX8zKNTA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3e3dac349easo415132fac.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 03:47:42 -0800 (PST)
X-Gm-Message-State: AOJu0Yztw8KbeMGDpoZlOgNTW9KXvor+iA5FPZ+BqCIujKs445Psu22t
	c9BchUxl3go1b+nxCKAFncFYW5HY46rfH/Kb/sK6t3gArJ/CSNEWwbukZA4v5dKh2tgK/GA2aHS
	JWmZAdW02lzGF2iH0kHA8AwsjdStpl6o=
X-Google-Smtp-Source: AGHT+IE1jT37yPCikk7CGeRljlH5vykSFzfBTxhFGW1iRGEIDXVbww7rnP264ByNmXZI4SisUxoquXhhHNixGdBS8MQ=
X-Received: by 2002:a05:6870:bace:b0:3e8:3176:a342 with SMTP id
 586e51a60fabf-3e8340db2bfmr3645270fac.22.1763034461626; Thu, 13 Nov 2025
 03:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4701737.LvFx2qVVIh@rafael.j.wysocki> <5035693.GXAFRqVoOG@rafael.j.wysocki>
 <1dc4934f-a3ce-4ead-a43c-0a80987364b6@arm.com> <CAJZ5v0h5PkU5t=uPVO2Evq0gNrX4vYkAJFVDPLsqzCGKXnb+_w@mail.gmail.com>
In-Reply-To: <CAJZ5v0h5PkU5t=uPVO2Evq0gNrX4vYkAJFVDPLsqzCGKXnb+_w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Nov 2025 12:47:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hzuHd9MjHdovFZZwf=wHAQQsVKKbtkHCNtX5M+vZck3g@mail.gmail.com>
X-Gm-Features: AWmQ_blcVsJ_8dHve9meuhNyDhWDWc2trFhDIDQryHulF1JX1m1oeATbnECYxUs
Message-ID: <CAJZ5v0hzuHd9MjHdovFZZwf=wHAQQsVKKbtkHCNtX5M+vZck3g@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] cpuidle: governors: teo: Drop incorrect target
 residency check
To: Christian Loehle <christian.loehle@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Reka Norman <rekanorman@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 12:41=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Thu, Nov 13, 2025 at 12:32=E2=80=AFPM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > On 11/12/25 16:22, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > When the target residency of the current candidate idle state is
> > > greater than the expected time till the closest timer (the sleep
> > > length), it does not matter whether or not the tick has already
> > > been stopped or if it is going to be stopped.  The closest timer
> > > will trigger anyway at its due time, so it does not make sense to
> > > select an idle state with target residency above the sleep length.
> > >
> > > Accordingly, drop the teo_state_ok() check done in that case and
> > > let the governor use the teo_find_shallower_state() return value
> > > as the new candidate idle state index.
> > >
> > > Fixes: 21d28cd2fa5f ("cpuidle: teo: Do not call tick_nohz_get_sleep_l=
ength() upfront")
> > > Cc: All applicable <stable@vger.kernel.org>
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/cpuidle/governors/teo.c |    7 ++-----
> > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > >
> > > --- a/drivers/cpuidle/governors/teo.c
> > > +++ b/drivers/cpuidle/governors/teo.c
> > > @@ -458,11 +458,8 @@ static int teo_select(struct cpuidle_dri
> > >        * If the closest expected timer is before the target residency=
 of the
> > >        * candidate state, a shallower one needs to be found.
> > >        */
> > > -     if (drv->states[idx].target_residency_ns > duration_ns) {
> > > -             i =3D teo_find_shallower_state(drv, dev, idx, duration_=
ns, false);
> > > -             if (teo_state_ok(i, drv))
> > > -                     idx =3D i;
> > > -     }
> > > +     if (drv->states[idx].target_residency_ns > duration_ns)
> > > +             idx =3D teo_find_shallower_state(drv, dev, idx, duratio=
n_ns, false);
> > >
> > >       /*
> > >        * If the selected state's target residency is below the tick l=
ength
> > >
> > >
> > >
> >
> > AFAICT this check was to not be stuck in a shallow state when tick is a=
lready disabled.
> > There might be a timer armed in t+500us but that might still get cancel=
led, which
> > is why we didn't think a below TICK_NSEC 'shallow' state is acceptable?
>
> This is all about hrtimers which are not expected to be canceled too
> often and real energy is wasted here by going too deep if the timer is
> not canceled.

Overall, both teo and menu assume that the timers reported by
tick_nohz_get_sleep_length() will trigger.  Otherwise, calling it
would be kind of pointless ...

