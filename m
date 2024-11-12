Return-Path: <linux-pm+bounces-17398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA68A9C57C7
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 13:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F39BB61B43
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 11:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD5A1FB74A;
	Tue, 12 Nov 2024 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXu2u/OP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D9F1FB745;
	Tue, 12 Nov 2024 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731410911; cv=none; b=r3GapHeZ0WDHRZWBMA2tjfV/PQIdIur4B8QrhYqOyc2tV5AuJLeXGDTaJw5cGH6mv8u0cqb1AAzQQ3QnLpsFGxuSS/RTmIEyheL2L2Zij+kEv8ahNXql1Cg/S9JTidz40g4r8uw9OGCPY+vwBg9SowvtCGZxSovz28gJbELr5As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731410911; c=relaxed/simple;
	bh=+rzAkXFKFxYH+EnmyNDNya6LAZlVy/3NQRETZ1zHyYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npt3/A2QNyOidSdU2eKTyw6WQdpulINju2vL3tHkW0cY0xCHpPb8P9ShZd+8ZMIQPRS1xvc5OwTlrzyoWcslY7XiHF+DtyojA+Y+OdceGTnetSOq6+AQoOIFzc4D4OV872Bqyd9+IkQh2tuF0NpyoT0QmAFTFjPE7O4Gr7GEJX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXu2u/OP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAFFC4CED5;
	Tue, 12 Nov 2024 11:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731410911;
	bh=+rzAkXFKFxYH+EnmyNDNya6LAZlVy/3NQRETZ1zHyYk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fXu2u/OPjK5l0K+49bnnoFRlE737V3V1gZ/h6jU0Yon2lJEv5Patge6noxvncDZCH
	 /X3qC16XU2oIwuCQqMno2qdEtgV7vgEsCNszr2mIPylyQBiiPr1+8l9erAhwzyvdSo
	 tx/xnBHoSHwzBomOGRnoEmkBP0oFjt5ewG0fM8XmbbLnCV2VHbrfgOZmf67lsPOkUH
	 6lya0PRHqXoGNvmoJuaTxKcb50uBe7eB0WBKHbl/o1igs9tczVMTCvquiwNLvyhVJa
	 sZJEpXpDwJHFMHBZdLNJkAanxWrInIHtqzSP36ybp6AdNBUwV0Ve1hEYTcE54jccDS
	 J/uMgsfGnsx1Q==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-288a90e4394so2402584fac.0;
        Tue, 12 Nov 2024 03:28:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW/QU7fOftD/44dpU4c518cFpKDeo01XgdWSrM0vt4tTSRWZqZNXsky/NoKsadTgXM96JytWxsbr6Y=@vger.kernel.org, AJvYcCWE7ZycQ8VzsAqUalQ4ZjgxkTAefuCnhvlT7ieH7If9XwA8M/s3IYB9cuEla9o2cAIPY1ZfzAuufKIm+NI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFK0Z/iZVkaUs1kWN9Pr7FiTqLFw0G5y0WaWVQZnrOUkr8K63u
	G6cb60UrzBaOZ1zdNl3jRX5/HVJ0P+JBL/tTe/SgwEilchYfR89GqXIMXhndkucyi98pmNCPzVQ
	0+jiO3OG+P8XP6m0Z7M/CCSGdpBo=
X-Google-Smtp-Source: AGHT+IFzIl81X9l1J1cMQQc0Xa4o3EgXz++fT9wjADyYD45hT5g2bIGGRbkEQwmly2Ab2PmaOzRgoiGFDBw9vh8W0a4=
X-Received: by 2002:a05:6870:c153:b0:277:caf7:3631 with SMTP id
 586e51a60fabf-295ccf347e7mr2290421fac.5.1731410910755; Tue, 12 Nov 2024
 03:28:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108122909.763663-1-patryk.wlazlyn@linux.intel.com>
 <20241108122909.763663-4-patryk.wlazlyn@linux.intel.com> <b6ab357c-1562-4035-ad3a-2159d2c8c1fa@intel.com>
 <ee9b0a70-6f44-4203-bba9-c07d94444ad6@linux.intel.com>
In-Reply-To: <ee9b0a70-6f44-4203-bba9-c07d94444ad6@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Nov 2024 12:28:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gmg_6OnzR6BNm+3Mx0Wzsf2nPQEZDutYu_-Px-TsvX-w@mail.gmail.com>
Message-ID: <CAJZ5v0gmg_6OnzR6BNm+3Mx0Wzsf2nPQEZDutYu_-Px-TsvX-w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] intel_idle: Provide enter_dead() handler for SRF
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rafael.j.wysocki@intel.com, len.brown@intel.com, 
	artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 12:18=E2=80=AFPM Patryk Wlazlyn
<patryk.wlazlyn@linux.intel.com> wrote:
>
> > This series has said multiple times how the old algorithm is wrong.  Bu=
t
> > it never actually _fixed_ the bad algorithm, only worked around it.
> >
> > Does mwait_play_dead() itself need to get fixed?
>
> I don't think so. The old algorithm gives fairly good heuristic for compu=
ting
> the mwait hint for the deepest cstate. Even though it's not guaranteed to=
 work,
> it does work on most of the platforms that don't early return. I think we=
 should
> leave it, but prefer idle_driver.

IOW, as a fallback mechanism, it is as good as it gets.

As the primary source of information though, not quite.

> >> Define the enter_dead() handler for SRF.
> >
> > This effectively gets the mwait hints from ______ instead of using the
> > calculation in mwait_play_dead().
>
> Ok.
>
> >> +static __cpuidle int intel_idle_enter_dead(struct cpuidle_device *dev=
,
> >> +                       int index)
> >> +{
> >> +    struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
> >> +    struct cpuidle_state *state =3D &drv->states[index];
> >> +    unsigned long eax =3D flg2MWAIT(state->flags);
> >> +
> >> +    /* Retruns only in case of an error. */
> >
> >        ^ returns?
>
> Yup. Will fix.
>
>

