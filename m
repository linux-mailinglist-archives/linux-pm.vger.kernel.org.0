Return-Path: <linux-pm+bounces-39592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 701D3CBE828
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 16:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9F1B3002E86
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 15:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC0E337BB2;
	Mon, 15 Dec 2025 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgAvIcrK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68562337B8A
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765811209; cv=none; b=cdcrUJIyHiGl/VdUY4wzlrsJp+y1D+HZbfUKcvWG2+ORLfTbnlZYxoQIUZd8I7yoaNpMxsi6w02Cb26UHaLPGoPxBi8EiC7FRQRci1bRYT9XSe1Br1gjMKOOaKM/gHXwfvLtxRHWxqykiuIF/GR6vE8Vf6vdWM2UmuOLXOKvvKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765811209; c=relaxed/simple;
	bh=FDobN7Z8Y+X8tbX1BBeUKpew6JTrowJDtN92pTS3aCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJBAxJY2Pg1wgoxj15qHSebwCq/W2h+3bggRUeN8y4r40hC8jyM4aFBkLE1GkRLjTvst2Yd3qtn27BtF9RmIVDdbU2mwEo+dJavKr3G7WojF7F4Tzk/ireHVEnfbcnqswML4AljLaUYtOXdYoq3yXApa/xMpwuTaRjGSL9JFMRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgAvIcrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13129C2BC87
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 15:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765811209;
	bh=FDobN7Z8Y+X8tbX1BBeUKpew6JTrowJDtN92pTS3aCA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VgAvIcrK4N03oQN/K6dMpTSP0V78veP8E2MDirYJijSCd52XkH3OHBVNW74QYhe3X
	 yCcxqvhZLfFr3le1f1tj8z0NAG3ZJBYoIk7+iUX/HnfT6JIuA8W6vfJ6R10+Mzk99H
	 dmdymNBlgyJJ1Hasd2ki6FxAHr//6OoaLjEp5kmU7elJa6jZHEb1fdE61cYOkPHNZL
	 kMFo0EaKjtlW+DiUdes1Tux5u2uDHh7FfSwfP4WLJ1lWmu/eM7ki2shPMsVj7OYa9i
	 00UjI3hG7IGuxK5nziv1jwkI46Elqh9jvEcWcJLRlcSr0UaOOZZtFe5BmcUMITqgOv
	 4ZJK5FLCyAiRQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-65b2cc63b0bso2045577eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 07:06:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUcjANMq+OCJ/+WaPk+Fz0bmYYuPTaQankrST4kQ8zwmLGRBodJB6Qj8SnzbAnA8DacEW7k02LZPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YysXGv/Y1dqDNHRLYCFDP6Fj00jUxgJrvr2/C/PoRVVyf2+taUd
	0gvm1qKAXoSoWcQHn7+5NOlKXZFN2rgvSkaQNtjvAfGOBb9uKnz42z+cVsV45QS781/oMITJIek
	FckORiSaPFieOM2rgz9iLb5f0cUpYwpA=
X-Google-Smtp-Source: AGHT+IEaMrt9lz0x198Ij3nAB6XXysm1VXszRlYg30bOGzcrHyJjfZX9RcXwwS5a+vUUOshs8u2mH4T3TLuAeM3V35g=
X-Received: by 2002:a05:6820:a0b:b0:654:f691:9da8 with SMTP id
 006d021491bc7-65b4511e8d9mr4607698eaf.7.1765811208285; Mon, 15 Dec 2025
 07:06:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
 <081e0ba7-055c-4243-8b39-e2c0cb9a8c5a@lunn.ch> <4bb1ea43-ef52-47ae-8009-6a2944dbf92b@igalia.com>
 <bb7871f1-3ea7-4bf7-baa9-a306a2371e4b@lunn.ch> <c65961d2-d31b-4ff9-ac1c-b5e3c06a46ba@igalia.com>
 <CAJZ5v0iX39rvdaoha18N-rpKLinGZ1cjTb1rV1Azh0Y7kYdaJQ@mail.gmail.com> <d5b50da2-bc1f-4138-9733-218688bc1838@igalia.com>
In-Reply-To: <d5b50da2-bc1f-4138-9733-218688bc1838@igalia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Dec 2025 16:06:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gpYQwC=1piaX-PNoyeoYJ7uw=DtAGdTVEXAsi4bnSdbA@mail.gmail.com>
X-Gm-Features: AQt7F2qByuegiAKQOPI-mIV1VRdZEAkb5KgCAMPEAmz5qXr2_IJptgNblF0fy2I
Message-ID: <CAJZ5v0gpYQwC=1piaX-PNoyeoYJ7uw=DtAGdTVEXAsi4bnSdbA@mail.gmail.com>
Subject: Re: Concerns with em.yaml YNL spec
To: Changwoo Min <changwoo@igalia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Donald Hunter <donald.hunter@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	sched-ext@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 4:01=E2=80=AFPM Changwoo Min <changwoo@igalia.com> =
wrote:
>
> Thanks, Rafael, for the comments.
>
> On 12/15/25 19:30, Rafael J. Wysocki wrote:
> > On Mon, Dec 15, 2025 at 2:57=E2=80=AFAM Changwoo Min <changwoo@igalia.c=
om> wrote:
> >>
> >> Hi  Andrew,
> >>
> >> On 12/15/25 01:21, Andrew Lunn wrote:
> >>>>> We also need to watch out for other meaning of these letters. In th=
e
> >>>>> context of networking and Power over Ethernet, PD means Powered
> >>>>> Device. We generally don't need to enumerate the PD, we are more
> >>>>> interested in the Power Sourcing Equipment, PSE.
> >>>>>
> >>>>> And a dumb question. What is an energy model? A PSE needs some leve=
l
> >>>>> of energy model, it needs to know how much energy each PD can consu=
me
> >>>>> in order that it is not oversubscribed.Is the energy model generic
> >>>>> enough that it could be used for this? Or should this energy model =
get
> >>>>> a prefix to limit its scope to a performance domain? The suggested
> >>>>> name of this file would then become something like
> >>>>> performance-domain-energy-model.yml?
> >>>>>
> >>>>
> >>>> Lukasz might be the right person for this question. In my view, the
> >>>> energy model essentially provides the performance-versus-power-
> >>>> consumption curve for each performance domain.
> >>>
> >>> The problem here is, you are too narrowly focused. My introduction
> >>> said:
> >>>
> >>>>> In the context of networking and Power over Ethernet, PD means
> >>>>> Powered Device.
> >>>
> >>> You have not given any context. Reading the rest of your email, it
> >>> sounds like you are talking about the energy model/performance domain
> >>> for a collection of CPU cores?
> >>>
> >>> Now think about Linux as a whole, not the little corner you are
> >>> interested in. Are there energy models anywhere else in Linux? What
> >>> about the GPU cores? What about Linux regulators controlling power to
> >>> peripherals? I pointed out the use case of Power over Ethernet needin=
g
> >>> an energy model.
> >>>
> >>>> Conceptually, the energy model covers the system-wide information; a
> >>>> performance domain is information about one domain (e.g., big/medium=
/
> >>>> little CPU blocks), so it is under the energy model; a performance s=
tate
> >>>> is one dot in the performance-versus-power-consumption curve of a
> >>>> performance domain.
> >>>>
> >>>> Since the energy model covers the system-wide information, energy-
> >>>> model.yaml (as Donald suggested) sounds better to me.
> >>>
> >>> By system-wide, do you mean the whole of Linux? I could use it for
> >>> GPUs, regulators, PoE? Is it sufficiently generic? I somehow doubt it
> >>> is. So i think you need some sort of prefix to indicate the domain it
> >>> is applicable to. We can then add GPU energy models, PoE energy
> >>> models, etc by the side without getting into naming issues.
> >>>
> >>
> >> This is really the question for the energy model maintainers. In my
> >> understanding, the energy model can cover any device in the system,
> >> including GPUs.
> >
> > That's correct.
> >
> >> But, in my limited experience, I haven=E2=80=99t seen such cases beyon=
d CPUs.
> >>
> >> @Lukasz =E2=80=94 What do you think? The focus here is on the scope of=
 the
> >> =E2=80=9Cenergy model=E2=80=9D and its proper naming in the NETLINK.
> >
> > I think you need to frame your question more specifically.
> >
>
> Let me provide the context of what has been discussed. Essentially, the
> question is what the proper name of the netlink protocol is and its file
> name for the energy model.
>
> Donald raised concerns that =E2=80=9Cem=E2=80=9D is too cryptic, so it sh=
ould be
> =E2=80=9Cenergy-model=E2=80=9D. The following is Donald=E2=80=99s comment=
:
>
>
>    =E2=80=9C- I think the spec could have been called energy-model.yaml a=
nd the
>     family called "energy-model" instead of "em".=E2=80=9D
>
>
> Andrew=E2=80=99s opinion is that it would be appropriate to limit the sco=
pe of
> =E2=80=9Cenergy-model=E2=80=9D by adding a prefix, for example, =E2=80=9C=
performance-domain-
> energy-model=E2=80=9D. Andrew=E2=80=99s comment is as follows:
>
>    =E2=80=9CAnd a dumb question. What is an energy model? A PSE needs som=
e level
>    of energy model, it needs to know how much energy each PD can consume
>    in order that it is not oversubscribed. Is the energy model generic
>    enough that it could be used for this? Or should this energy model get
>    a prefix to limit its scope to a performance domain? The suggested
>    name of this file would then become something like
>    performance-domain-energy-model.yml?=E2=80=9D
>
> For me, =E2=80=9Cperformance-domain-energy-model=E2=80=9D sounds weird be=
cause the
> performance domain is conceptually under the energy model. If adding a
> prefix to limit the scope, it should be something like =E2=80=9Csystem-en=
ergy-
> model=E2=80=9D, and the =E2=80=9Csystem=E2=80=9D prefix looks redundant t=
o me.
>
> So, the question is what the proper name is for the energy model
> protocol: =E2=80=9Cem=E2=80=9D, =E2=80=9Cenergy-model=E2=80=9D, =E2=80=9C=
performance-domain-energy-model=E2=80=9D, or
> something else?

I personally would be for something like "device-energy-model", where
"device" may mean any kind of device including CPU devices.

