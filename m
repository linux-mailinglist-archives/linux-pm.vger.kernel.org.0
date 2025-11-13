Return-Path: <linux-pm+bounces-37957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEB5C57B45
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 14:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1DF3A83B4
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 13:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2778351FD5;
	Thu, 13 Nov 2025 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KE1k7jlP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E202350A1A
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040412; cv=none; b=CrmAD3ODJpig6l+uX5q+cP7hzrat2lPCTnGfocUN49K4eQ7h5HdodRipiai538u0dpGAwtlRh9FWUSZvp8QchVWbIsfJCsEzj/W99DqRdnLbu0TRrx151LHPIqcdn/P7/KAHijQ78GX7ojs0mKoE9rre+3GTtNnCma9dAnXr7yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040412; c=relaxed/simple;
	bh=N6rVmwErvVdIpQNDNvw4j71KK5RNwrquC4TU8Yj6zzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jaz6xirJujJyXNzru5c1oeRXqr/ORFQ9e3VMAm1BIJIOFNCu797GhPalGHBLA921XDR79Qx3Fu7r6yds15kXS+Ucxc6+UraH4+csCFlM4XkNrhw4g4CQC9srdVwW3RC+tGIE99vcWZuZ9aZ1OUBBuz9Zy+aUaVhkOZcz0mzKZ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KE1k7jlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D58C4CEF1
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 13:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763040412;
	bh=N6rVmwErvVdIpQNDNvw4j71KK5RNwrquC4TU8Yj6zzs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KE1k7jlPSOpFpOQKnYI+lja3yNNjNaFJQe3H2Y7Tmr6cH4HHhjs/s4QBdmv+oh3lh
	 kdhK7C+lqXc56owKyfR9VFztiVo9T1Lg8CDnHYJOrxYHjNF//LU5pmjJ2PXNHImXlP
	 Hx6ugAC0TomgIGShfTheFmHaUQk1/1Hp5/YE2Xjxh479OYoExGx+sJ5sYKe3M9/plj
	 mEHYSFbjC9UksviQI7BSpTNgLx7EGUy41nIkyKQo7kuaWY76jS1ZuYeo9sC5aFiFf3
	 y3S0DQz/xefP1yksDHjYhV6Iri3x7Z61UN/iFGXm6pz23bOre9eTQ/JjRDt0EuPqHG
	 +mWVA14s1Ppgg==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4506534149eso317339b6e.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 05:26:52 -0800 (PST)
X-Gm-Message-State: AOJu0Ywv6CdXY/o6uAAi5uCtdDeFV7AhMljgYw5KcpU8BY8+YUocx0X+
	kFak0nsHkVe4ECjzhxwkn1x9Zb/GwORW0guAEvtYrOjcefUCC/qg0bzqwAF25As8wBXt2jbQpAD
	BqKE71KwVy8fKwOdGdo4vvsat02g/5VI=
X-Google-Smtp-Source: AGHT+IHpptsHcS6CKJ5mYtEDDybIMZJ3kpl5I7fAr1CDEkp0cz83cBO2yqJBYWMErR65pI6nKOJTZiCQ9FyoHV5WJPg=
X-Received: by 2002:a05:6808:4495:b0:44f:ef44:9cc4 with SMTP id
 5614622812f47-45086724901mr1739590b6e.32.1763040411260; Thu, 13 Nov 2025
 05:26:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4701737.LvFx2qVVIh@rafael.j.wysocki> <5035693.GXAFRqVoOG@rafael.j.wysocki>
 <1dc4934f-a3ce-4ead-a43c-0a80987364b6@arm.com> <CAJZ5v0h5PkU5t=uPVO2Evq0gNrX4vYkAJFVDPLsqzCGKXnb+_w@mail.gmail.com>
 <CAJZ5v0hzuHd9MjHdovFZZwf=wHAQQsVKKbtkHCNtX5M+vZck3g@mail.gmail.com>
In-Reply-To: <CAJZ5v0hzuHd9MjHdovFZZwf=wHAQQsVKKbtkHCNtX5M+vZck3g@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Nov 2025 14:26:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0giKy-Jm6eXAwvToJhAaWVa1jFU6s_aixCU8BzmPR4+cw@mail.gmail.com>
X-Gm-Features: AWmQ_bmV2GE0jkFfRhqK0R5cvi_iMjzpArgMqNQmxhMZM1N_CWQZyqsk0uehqvY
Message-ID: <CAJZ5v0giKy-Jm6eXAwvToJhAaWVa1jFU6s_aixCU8BzmPR4+cw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] cpuidle: governors: teo: Drop incorrect target
 residency check
To: Christian Loehle <christian.loehle@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Reka Norman <rekanorman@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 12:47=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Thu, Nov 13, 2025 at 12:41=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >
> > On Thu, Nov 13, 2025 at 12:32=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> > >
> > > On 11/12/25 16:22, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > When the target residency of the current candidate idle state is
> > > > greater than the expected time till the closest timer (the sleep
> > > > length), it does not matter whether or not the tick has already
> > > > been stopped or if it is going to be stopped.  The closest timer
> > > > will trigger anyway at its due time, so it does not make sense to
> > > > select an idle state with target residency above the sleep length.
> > > >
> > > > Accordingly, drop the teo_state_ok() check done in that case and
> > > > let the governor use the teo_find_shallower_state() return value
> > > > as the new candidate idle state index.
> > > >
> > > > Fixes: 21d28cd2fa5f ("cpuidle: teo: Do not call tick_nohz_get_sleep=
_length() upfront")
> > > > Cc: All applicable <stable@vger.kernel.org>
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/cpuidle/governors/teo.c |    7 ++-----
> > > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > > >
> > > > --- a/drivers/cpuidle/governors/teo.c
> > > > +++ b/drivers/cpuidle/governors/teo.c
> > > > @@ -458,11 +458,8 @@ static int teo_select(struct cpuidle_dri
> > > >        * If the closest expected timer is before the target residen=
cy of the
> > > >        * candidate state, a shallower one needs to be found.
> > > >        */
> > > > -     if (drv->states[idx].target_residency_ns > duration_ns) {
> > > > -             i =3D teo_find_shallower_state(drv, dev, idx, duratio=
n_ns, false);
> > > > -             if (teo_state_ok(i, drv))
> > > > -                     idx =3D i;
> > > > -     }
> > > > +     if (drv->states[idx].target_residency_ns > duration_ns)
> > > > +             idx =3D teo_find_shallower_state(drv, dev, idx, durat=
ion_ns, false);
> > > >
> > > >       /*
> > > >        * If the selected state's target residency is below the tick=
 length
> > > >
> > > >
> > > >
> > >
> > > AFAICT this check was to not be stuck in a shallow state when tick is=
 already disabled.
> > > There might be a timer armed in t+500us but that might still get canc=
elled, which
> > > is why we didn't think a below TICK_NSEC 'shallow' state is acceptabl=
e?
> >
> > This is all about hrtimers which are not expected to be canceled too
> > often and real energy is wasted here by going too deep if the timer is
> > not canceled.
>
> Overall, both teo and menu assume that the timers reported by
> tick_nohz_get_sleep_length() will trigger.  Otherwise, calling it
> would be kind of pointless ...

Anyway, I've sent a v2 of the $subject patch with a more elaborate changelo=
g:

https://lore.kernel.org/linux-pm/5955081.DvuYhMxLoT@rafael.j.wysocki/

Hopefully, it is more convincing.

