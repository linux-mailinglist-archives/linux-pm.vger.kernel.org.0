Return-Path: <linux-pm+bounces-38373-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8723C7947E
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 14:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 748E52DF56
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 13:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1136331237;
	Fri, 21 Nov 2025 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG3IEBU1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC67A3176E1
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763731424; cv=none; b=Sca0Gp/dRQKMYZ8Dw8LgtNouXTahV7E5T0g8StRzP5/2mpXOwHcJWhmzWnf3cF7PnrgSkSua0lrVJOsv7A++PtAstuGSt2iyyk3hOcNRTGoAebI5ocqU4pcFl4ZkmiuVza92J7Jb32ruKVGrOaPG7HhlaeLXw4toPHeri6fZ2Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763731424; c=relaxed/simple;
	bh=ECEcTZSNracREyRBoHBY0EQNPthTpIWDuJV7GHm79Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fj5rGj7Y5JHp+HUq7+eSnxqfRAVeYccgKywhGGa5tPI4bv9eAwjPFaKMKRk1Bv6AM191bJoasxwhQUrNA94u79bVJXQd+FF0M65m1hCxj2Z+9rX5/5pqsZaxLAwkftPBCBrvyA5GGamAvbn124GGC93JhAh2aJP5CaBihDB/qdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG3IEBU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECB8C19423
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 13:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763731424;
	bh=ECEcTZSNracREyRBoHBY0EQNPthTpIWDuJV7GHm79Ug=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nG3IEBU1k9MufuwLMiuLVKZHavGOX5qH8JNk2SxUWFchiruvinJ2lvg3vnId/fhR9
	 +gwiS0ClKy/mrd+Ph9ljzddjMrvqgrPngTvdyn5IbvYkOWKf4xiZp/byz7vPD+ZeUj
	 peVPECgoivANQ2YWt69lFoI68Qxz/d9mEwdV2RvEbpyd3KIn95UPesTYRcbReZHqul
	 hG9RsTV/iog3GjjDm2OQc8/QLbG/35DPXmvf34qCKz7Utm7waTql2gHdbFW0Ddi6k6
	 SwB78YaLhf6Tk+FKMpgmdChbIGJIJRddeCMBOpyc5+dSzIg7kioTlA+52UaOFahpBI
	 Yawy/dohFPcbQ==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-65791c35134so279714eaf.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 05:23:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1Bh87SalXd86oPpjNcx/jhLzA7+rVZEv88LoBBSOO3C6Ef3e4Jd0Hi8iNFtNjiwEbTGiuTwq8Pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzLRz3kOKBdiSc8M47E7Uu9naAAh+9ZPyNBkuCb4shvGemeNAR
	4KXIqjBpPwrkNgwKRV2n0BDRmbmWAqzpK0qPbhHShVw7HHKpSodhKJ7+FAH8WkvLrlm53NMhu4L
	4bhv0TVneeuYYEEmKxDDkPwUr6RhA1CQ=
X-Google-Smtp-Source: AGHT+IFhp0YVKTtgS3L8OPuDSBkiyOLNkIUJXxKQSshiG2x2l23LJvripY/gCRFK9MFfhVgywKlcZjUCU7fKQ5VhEaA=
X-Received: by 2002:a05:6820:810c:b0:656:b1fb:a8fd with SMTP id
 006d021491bc7-65790a01bcamr707581eaf.1.1763731423664; Fri, 21 Nov 2025
 05:23:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121010756.6687-1-val@packett.cool> <efe52356123168be06811abd08a99f65d6980baa.camel@linux.intel.com>
In-Reply-To: <efe52356123168be06811abd08a99f65d6980baa.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Nov 2025 14:23:32 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h2u_Y8H-mCzeX+gxT4Aipa_MK6egMaA2fGuGkJBGXq7Q@mail.gmail.com>
X-Gm-Features: AWmQ_bk47UcrAbnlYbzZbn257NFsWpeFAQcdakF9SM7SuiCPFKaw52f_xwxzm34
Message-ID: <CAJZ5v0h2u_Y8H-mCzeX+gxT4Aipa_MK6egMaA2fGuGkJBGXq7Q@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: warn and fixup on sanity check instead of
 rejecting the driver
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: Val Packett <val@packett.cool>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Christian Loehle <christian.loehle@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 2:16=E2=80=AFPM Artem Bityutskiy
<artem.bityutskiy@linux.intel.com> wrote:
>
> On Thu, 2025-11-20 at 22:06 -0300, Val Packett wrote:
> > On Device Tree platforms, the latency and target residency values come
> > directly from device trees, which are numerous and weren't all written
> > with cpuidle invariants in mind. For example, qcom/hamoa.dtsi currently
> > trips this check: exit latency 680000 > residency 600000.
> >
> > Instead of harshly rejecting the entire cpuidle driver with a mysteriou=
s
> > error message, print a warning and set the target residency value to be
> > equal to the exit latency.
> >
> > Fixes: 76934e495cdc ("cpuidle: Add sanity check for exit latency and ta=
rget residency")
> > Signed-off-by: Val Packett <val@packett.cool>
> > ---
> >  drivers/cpuidle/driver.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> > index 1c295a93d582..06aeb59c1017 100644
> > --- a/drivers/cpuidle/driver.c
> > +++ b/drivers/cpuidle/driver.c
> > @@ -199,8 +199,11 @@ static int __cpuidle_driver_init(struct cpuidle_dr=
iver *drv)
> >                * exceed its target residency which is assumed in cpuidl=
e in
> >                * multiple places.
> >                */
> > -             if (s->exit_latency_ns > s->target_residency_ns)
> > -                     return -EINVAL;
> > +             if (s->exit_latency_ns > s->target_residency_ns) {
> > +                     pr_warn("cpuidle: state %d: exit latency %lld > r=
esidency %lld (fixing)\n",
> > +                             i, s->exit_latency_ns, s->target_residenc=
y_ns);
> > +                     s->target_residency_ns =3D s->exit_latency_ns;
> > +             }
> >       }
>
> Ideally, in a perfect world, driver.c should verify input data and
> reject bad input, rather than correct bad input.
>
> So ideally, if there is an idle driver between DT and driver.c (like
> intel_idle.c in case of Intel), that would be its job to correct DT
> data.
>
> But I'm not familiar with DT platforms, so I don't know if there is a
> driver/piece of SW between DT parsing and driver.c that could handle
> this correction at an earlier stage.
>
> The reason I think this patch is not ideal is because it changes the
> input data at the core framework level, and in theory the change may be
> surprising to users. In general, sometimes rejecting bluntly is better
> than correcting in a possibly unexpected way.

Unless rejecting it causes the functionality to be missing entirely
and users have no straightforward way to fix it up.

As I said in my reply, what can be done in this situation is to print
a warning when assumptions are not met.

