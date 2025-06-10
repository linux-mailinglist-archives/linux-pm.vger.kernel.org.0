Return-Path: <linux-pm+bounces-28357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5F4AD348A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 13:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608703B4655
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 11:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA91828DF1F;
	Tue, 10 Jun 2025 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dre9Zpx8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015DC28DF0E;
	Tue, 10 Jun 2025 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749553661; cv=none; b=qjmN0b2eDOc0b5kFkYcVIsslJIdl93le3wdZSiP0R6O0kUR/YIqxcmYAGdD+HVclQSlL9lJYeeG/77XqaPL9x8Nz6Vf5tdsCV+WRB3b38iW4D1mvM73PraXkmctqq8ZfXdx2/C7RApMVMChj0lhxJ4qHRI/mfVmLNK2bFfAqEDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749553661; c=relaxed/simple;
	bh=5WyJDjOsacc1tyrhglR5f00AB2huMpl9kWaITwLH2gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOa9DNu7g9yS7nRYN91fzLbFj69mR919Ok/mEhQ3fKI5sigeKY82ixczBXM0yudi+tHJ/+4f5K3E+yGUJFkpgkSHZsDZONj2QXtZaNHyvmKicwyJZeqqiCp9yJuTd2yWSdoyBh1qxwUsRmD5EwELesfr1xFmSxLwVibkaIc7iWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dre9Zpx8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cfb6a794so34332035e9.1;
        Tue, 10 Jun 2025 04:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749553658; x=1750158458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lSDkUNg7pCMVGDi1JhrPkWKMxNcgCg8HawFBRzXOTrI=;
        b=dre9Zpx8/rNdCYA1RW70X6SMxRNeaA8IaQWu7NUnG5CVbaW2fUGuWmxHyEPI3ExH+H
         PX2GZuNcHtUp7dwRWUbY/Wp3dTLQWtMwZEQf+CX5qI+ZQxOMKHG1yMLB6GwI3lPOJoFg
         KsNJp7KI29a3LtAKhm4u/l7jsFQ9nstNQygzEuSh7avf6KE2OM7S8GvFXYaF/MNa1Kh6
         c2eqx8m/Xxb43fa2DwJK1sFOUMlxKOuZpzgFlBLCamDbhC+LassZxE6SAJfxJKEe94dC
         Hi8qWn/Ej00lCQspDuH8fVZvk/zSfIAgMD9UnFtwEWUt9yK8yhvfyHpovXNbgXZ0oDmR
         pbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749553658; x=1750158458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSDkUNg7pCMVGDi1JhrPkWKMxNcgCg8HawFBRzXOTrI=;
        b=D2x2GnJylpydS9RBnKc+5YA5d7R7Yb+ElpiSpyyTvAkLi3qNrUA10iiRbRxcG4dxFp
         LAVOsuSwlNjw5F1m/nOI/HZ9DAItaJcuBjXkC7V1S2QFEjzNQ6SQxDBwFiXJTZHXy43q
         kkhCL9Is4xbIthTdkFQP7pHpDqKQsu47Ne/gDn6BvChMRtkUx6UsNXgudPB+kz/MC7bt
         FYZdsmqcirBonaNiWITGFaX3INImZOly4TAEPhPLMv13nPbw/b8FYE40iryPOFhka/2N
         CMAgxubuqGcFKjPAxBsrMRET9eq41m+VvAlFci1wlU89PDMWFwtuOZzwA5xtgwY9zjS9
         RLgg==
X-Forwarded-Encrypted: i=1; AJvYcCUG1IRFzTVIUPfcM+VTMckrwRSrUmn+6VYFlfI4gLCXmSpbBEgAJuSURBYy8AuDmblrNsGFcsXOO+2Vlzur@vger.kernel.org, AJvYcCWUGdXsdDBFRUX1sAVT68nrnmGGv5Ff/iGvw6VqLIjnFGD/KFNAWwpuZZlWoVHdngLopdAUEypPdJE=@vger.kernel.org, AJvYcCWetYkFf3WaVr8ByMEh5RCxEXPaejVqjmgxmrPCqTyJ5EpNLBfUtELYebHLxtVASebfVFFo7LboO3gMqUc=@vger.kernel.org, AJvYcCXzyebREo2T2ZodbTO0xKITytIzGxymsw/uP/PPA9oFTgXGlq0mtwwo/t9r1Nq3dLwMlZ8P6MnlHxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbOWCHolJJBi9v3OYReN59nZ/tRyX7ZBAoMbnbpqdgwte6nhQ1
	dPasEyBjWj1LDdegwB3HP2nCF82yrPLl128y02Zen8COc8OWJxsAXPsS
X-Gm-Gg: ASbGncs31PX2xwYsd2DCC0Y3TPuXXUdmT6njfLPoWKbAaZnp/L/+qS6Zs1pVtMI1N46
	jnygpqia9f7Wj82iELVy3kqQThr3evpcyuEmsSYhMlFIUl32sLXCTebvtA8JJ96KzXzMDdG2rC8
	m1pwNhrrQI3ZENA8bdlhcA78MplZ/dla1TDSqByewC+GXxOHCvmUSxivV5d+B26BrPEoOI2eaPW
	SKpqD37g+q/aqR6t2QyfZ/7716UnG2TZQrugcly2WtLgAMYcnvwc53ym/Sxs+yEE0oWSR9WhOYN
	U9webGFseRrc1yPn/BU3WuioJtXVbIIi6GFnvQnI/hPy4fLi8tDGTu7paLqpFxRNdegZWxwON8t
	jIRx6u0G1Ut53BxEoCbWbA0rBPgV71Ban+DkSw5YFCU+JBSSo
X-Google-Smtp-Source: AGHT+IGJLn68qlQRgM1RWjGLvgYWa/yZA0vynepgw1pm/prSBNurVotzXJWhrmwMI0/EhEopshwdMw==
X-Received: by 2002:a05:600c:8b72:b0:43d:94:2d1e with SMTP id 5b1f17b1804b1-4531de00a15mr22080545e9.13.1749553658041;
        Tue, 10 Jun 2025 04:07:38 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45307b4788fsm88637525e9.21.2025.06.10.04.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 04:07:36 -0700 (PDT)
Date: Tue, 10 Jun 2025 13:07:34 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, 
	Prashant Gaikwad <pgaikwad@nvidia.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 2/3] drivers: clk: tegra: add DFLL support for Tegra 4
Message-ID: <g7kegtso3opafpwocvibhm3rym35oikxoyq2wmphqy3wjenzpa@m7extntwahau>
References: <20250321095556.91425-1-clamor95@gmail.com>
 <20250321095556.91425-3-clamor95@gmail.com>
 <aef4574b-8167-4af3-a29c-8c962b396496@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mdr3yu4j4s5eicl5"
Content-Disposition: inline
In-Reply-To: <aef4574b-8167-4af3-a29c-8c962b396496@kernel.org>


--mdr3yu4j4s5eicl5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/3] drivers: clk: tegra: add DFLL support for Tegra 4
MIME-Version: 1.0

On Fri, Mar 21, 2025 at 09:50:09PM +0100, Krzysztof Kozlowski wrote:
> On 21/03/2025 10:55, Svyatoslav Ryhel wrote:
> > Extend the Tegra124 driver to include DFLL configuration settings requi=
red
> > for Tegra114 compatibility.
> >=20
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>=20
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC (and consider --no-git-fallback argument, so you will
> not CC people just because they made one commit years ago). It might
> happen, that command when run on an older kernel, gives you outdated
> entries. Therefore please be sure you base your patches on recent Linux
> kernel.
>=20
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
> </form letter>
>=20
>=20
>=20
> > +++ b/include/dt-bindings/reset/tegra114-car.h
>=20
> Filename based on compatible.
>=20
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> > +/*
> > + * This header provides Tegra114-specific constants for binding
> > + * nvidia,tegra114-car.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_RESET_TEGRA114_CAR_H
> > +#define _DT_BINDINGS_RESET_TEGRA114_CAR_H
> > +
> > +#define TEGRA114_RESET(x)		(5 * 32 + (x))
>=20
>=20
> Does not look like a binding, but some sort of register. Binding IDs
> start from 0 (or 1) and are incremented by 1.

I'll try and clear up some of the confusion around this. The way that
resets are handled on these Tegra devices is that there is a set of
peripheral clocks & resets which are paired up. This is because they
are laid out in banks within the CAR (clock and reset) controller. In
most cases we're referring to those resets, so you'll often see a clock
ID used in conjection with the same reset ID for a given IP block.

In addition to those peripheral resets, there are a number of extra
resets that don't have a corresponding clock and which are exposed in
registers outside of the peripheral banks, but still part of the CAR.
To support those "special" registers, the TEGRA*_RESET() is used to
denote resets outside of the regular peripheral resets. Essentially it
defines the offset within the CAR at which special resets start. In the
above case, Tegra114 has 5 banks with 32 peripheral resets each. The
first special reset, TEGRA114_RESET(0), therefore gets ID 5 * 32 + 0.

So to summarize: We cannot start enumerating these at 0 because that
would fall into the range of peripheral reset IDs.

Thierry

--mdr3yu4j4s5eicl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmhIEfMACgkQ3SOs138+
s6GhaRAAmd49Bi91xyPfMgzNKI861C3Y5GeN/U4iPxCnbuxP6d/aG+FGMZgfL6rt
1oEh6iocRWI6eF3ydldX6NAQec3h8kbQUT2wxfybcfjpUVH4vwqfHnV4BcWdNmKO
kDxZIxDWCzZxUAT9DsqKT0p4GKdWreJO5JEdsZBw/tc0szmMB2+5yQxA3eKgOLjG
kvRAxBvt8dfb6Y+MiDFESKX3SwUVKzfSZYofLxZDo0HS74fJlNlP0MtTu47QN4H/
C3HdExss0D9Z6T2FuFXeKXiTlDO2x4q6ZBuSyVsrYAlUGtWAoeQD5s59zL26Vfuu
xQYo5a8iPSaE3LNyyiEavk5NPkaNo+2Y4f9JMls09n69uEeQIL6+bAGJ0fKKhZ/Z
5DuTugrGpHFs6r8wKC4rGsKq40aprc7Q0eOZFL1bBQyh08yPsi72QgQM5edVYxcC
xjsNPjAm3PhGsUE+5MMBMV8uArxQGrPJLghz9MzsVGimjePZg6KE35xNkOeYUhn9
1UHksmOY0TYJEuxu3+o0IxuFwzHAqcO+v6B+gusqAxeHhPn5kaPSMK4wYeCwnhAk
EOuvs1Wnqw3FPrSnahnuoodY8Muz7fSuXG9sGmxRJZtekSzRiZ4qvTBQZCgcUrUp
WFNWYoNNf1N72sSPVZAfeOne9c+U37vTi83ieJGI6qQoXePP4Eg=
=N9Uu
-----END PGP SIGNATURE-----

--mdr3yu4j4s5eicl5--

