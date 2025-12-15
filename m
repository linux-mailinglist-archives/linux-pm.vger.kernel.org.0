Return-Path: <linux-pm+bounces-39541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBCFCBD5D8
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 11:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 953123009424
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 10:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1DB28312F;
	Mon, 15 Dec 2025 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzU6N05p"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74152153E7
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765794654; cv=none; b=ImqOADl8yT0NAcguJ5QPSJiV9LEv/NEzTEb/4aI7Uc/s20doj0K+T2L94DWoRgdStWKMOvDntbwpiLPiZfSIXtLQkl9gVJ5GIInm8SpE6wW1j/PYQqcVrp2OSflT1xlXlpcYjH2HmCwxPyJhckdp5lg77XMwCP2xWbEcLUafQ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765794654; c=relaxed/simple;
	bh=lJbEumrw1RnGbVillJylf+DruSz2R9MFbavbJPGtHzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E63uwslX2B2TlwZEVLeMtgbe1b4lb0BbysiCM0TaZEW04Ldmd2ckbR8RFfpm6oMP8SSGTnRI5UNP9+7FggU5JOCnZS53xGqLtejLOlc/c2oquT22NSntMUJisZ4OfiZsSTPei7h9h8+aftmhfzzdCG1DS5JQ6bCtSzJFB4BBFtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzU6N05p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED1DC19425
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 10:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765794654;
	bh=lJbEumrw1RnGbVillJylf+DruSz2R9MFbavbJPGtHzM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uzU6N05pS6b1GdEt7Dy2QiDpafrteyxiaMjfFf3YXNp+psH1WL0idFhGlJ14s3l4s
	 VPlTSq90z7wkqBOtLeH7BcpK213acZHIpwf+PBi23bFvWWWHkH+ykipNDCL5UXLpsV
	 /mimMGSmzYv1cKmGaAZ2+cqdymTW1OGAQIJ8cW0UbE/YKBaRkc4JLitGdWSNpjPs+V
	 ohj5GXYfrDVW5ODJyU9yS6sXYbobju0icB+nHYE8OgtloiuMVeEgKlKwUQo5CSm5X0
	 pzHzHwkOYrUx78Jmxm50ofZVwGPj5rvWCtknqwKLHvwdJjmchmy4cGsGBqYHQlFhjV
	 brixSc/JB9Cng==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3e89d226c3aso2257375fac.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 02:30:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX05PYDz/K2KjVv4zx8Bygpx/VSPh7zuIWsP0m3w2ESFLG3ZKKNQVdhUSbowvqmIK2T9b+dCBGuyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqMU4BGUM+p5kekiBvBUpKyCx6eRzlTk1Xf4Gvoih/6R/ntI0x
	8+kWK/Euz+nzaPH7IV6DUPCOTsPDQ/O0qgiHZ29Pcq3QRSYs84bSu2eq+eOdM6qSf5o1IZMHOo0
	C9B1BN5esnqMaiG7vmyPabpWuipmLjMw=
X-Google-Smtp-Source: AGHT+IEoBpCjoSps8D+YgdCDShE9GQ0VNljBKFeTmfnEM6ZQwgOcZKzgv9BvCfPOUEqlcRH85eHG+nMTVNwYGJwcvSg=
X-Received: by 2002:a05:6820:1b05:b0:659:9a49:8ebf with SMTP id
 006d021491bc7-65b45280c29mr5558461eaf.67.1765794653666; Mon, 15 Dec 2025
 02:30:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
 <081e0ba7-055c-4243-8b39-e2c0cb9a8c5a@lunn.ch> <4bb1ea43-ef52-47ae-8009-6a2944dbf92b@igalia.com>
 <bb7871f1-3ea7-4bf7-baa9-a306a2371e4b@lunn.ch> <c65961d2-d31b-4ff9-ac1c-b5e3c06a46ba@igalia.com>
In-Reply-To: <c65961d2-d31b-4ff9-ac1c-b5e3c06a46ba@igalia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Dec 2025 11:30:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iX39rvdaoha18N-rpKLinGZ1cjTb1rV1Azh0Y7kYdaJQ@mail.gmail.com>
X-Gm-Features: AQt7F2oqYG9Tt0dNzgC-8tRKT4CJtDwCvddIJZFUdGN8qw17Y5dsEOJ6fuuZZGg
Message-ID: <CAJZ5v0iX39rvdaoha18N-rpKLinGZ1cjTb1rV1Azh0Y7kYdaJQ@mail.gmail.com>
Subject: Re: Concerns with em.yaml YNL spec
To: Changwoo Min <changwoo@igalia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, sched-ext@lists.linux.dev, 
	Jakub Kicinski <kuba@kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 2:57=E2=80=AFAM Changwoo Min <changwoo@igalia.com> =
wrote:
>
> Hi  Andrew,
>
> On 12/15/25 01:21, Andrew Lunn wrote:
> >>> We also need to watch out for other meaning of these letters. In the
> >>> context of networking and Power over Ethernet, PD means Powered
> >>> Device. We generally don't need to enumerate the PD, we are more
> >>> interested in the Power Sourcing Equipment, PSE.
> >>>
> >>> And a dumb question. What is an energy model? A PSE needs some level
> >>> of energy model, it needs to know how much energy each PD can consume
> >>> in order that it is not oversubscribed.Is the energy model generic
> >>> enough that it could be used for this? Or should this energy model ge=
t
> >>> a prefix to limit its scope to a performance domain? The suggested
> >>> name of this file would then become something like
> >>> performance-domain-energy-model.yml?
> >>>
> >>
> >> Lukasz might be the right person for this question. In my view, the
> >> energy model essentially provides the performance-versus-power-
> >> consumption curve for each performance domain.
> >
> > The problem here is, you are too narrowly focused. My introduction
> > said:
> >
> >>> In the context of networking and Power over Ethernet, PD means
> >>> Powered Device.
> >
> > You have not given any context. Reading the rest of your email, it
> > sounds like you are talking about the energy model/performance domain
> > for a collection of CPU cores?
> >
> > Now think about Linux as a whole, not the little corner you are
> > interested in. Are there energy models anywhere else in Linux? What
> > about the GPU cores? What about Linux regulators controlling power to
> > peripherals? I pointed out the use case of Power over Ethernet needing
> > an energy model.
> >
> >> Conceptually, the energy model covers the system-wide information; a
> >> performance domain is information about one domain (e.g., big/medium/
> >> little CPU blocks), so it is under the energy model; a performance sta=
te
> >> is one dot in the performance-versus-power-consumption curve of a
> >> performance domain.
> >>
> >> Since the energy model covers the system-wide information, energy-
> >> model.yaml (as Donald suggested) sounds better to me.
> >
> > By system-wide, do you mean the whole of Linux? I could use it for
> > GPUs, regulators, PoE? Is it sufficiently generic? I somehow doubt it
> > is. So i think you need some sort of prefix to indicate the domain it
> > is applicable to. We can then add GPU energy models, PoE energy
> > models, etc by the side without getting into naming issues.
> >
>
> This is really the question for the energy model maintainers. In my
> understanding, the energy model can cover any device in the system,
> including GPUs.

That's correct.

> But, in my limited experience, I haven=E2=80=99t seen such cases beyond C=
PUs.
>
> @Lukasz =E2=80=94 What do you think? The focus here is on the scope of th=
e
> =E2=80=9Cenergy model=E2=80=9D and its proper naming in the NETLINK.

I think you need to frame your question more specifically.

