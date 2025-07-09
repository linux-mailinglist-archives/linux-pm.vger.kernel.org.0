Return-Path: <linux-pm+bounces-30488-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8B0AFED36
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 17:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B41EF7B766F
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 15:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6FD2E5B09;
	Wed,  9 Jul 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWDilB6I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D72F28D8EF;
	Wed,  9 Jul 2025 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073808; cv=none; b=Ulg61Dvgwbux1ZrJ8R1Stp1NYbrHMJ9FN8Orh7gOGJkBi4482medeO2LGpCmsSRDFiGWEJy9LiOOfYwcus/An6HZo3yP/hFs5p52P31oNM0QEWtJKyNQnXfEKDte7XyZSteDox030wjzQmEj84A5WphdyZFIfRqLryB3V5DKybM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073808; c=relaxed/simple;
	bh=yKG/nnY2WnyjUIASFqiowuZ9/aWHqNRR6qTW0XFu1wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXoktTFN1AIm3w1X23Jrnbp1ibm0fyx6DO2Kdui2ozmAYW6u5qszTQRDxjM6jY+Hvrlfxd7/PIimJ86nCBNnmr/jRBy6qGb1OcTlgGrFvaK0iH4cMMFxrX3wvY5IJFzURYppXr/E4pSzmLD8gYQTzKk7dC9NHN0rYd5Eeyyn4tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWDilB6I; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451d3f72391so58876095e9.3;
        Wed, 09 Jul 2025 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752073803; x=1752678603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e6XI6lEJsP+gVFIc/qsO9HaCG0IVBwc4p2KoW83c4fA=;
        b=RWDilB6I3BqmMqGqFJ5CdlzXK2r1oMtD5x7VXYzeOQ5uo40A9tc8908ZweIerzh54J
         5LUK3CETXU4QYi9AOY90sK+Tjw5zPMbfcXVeagEYLgEt4I1jNW1Y08Gh/RqvtxLS5Qwy
         QdmSCmmjErWAETuIAtYJLiCrjRU7pDyr636oPRrOM7ldgyjuTmqxZJN6AYIhNLfc6LBo
         ucJpAmRa5xkG8hInq6gYI8PlI2eGXhYrdG1/4rA4UBMIIH11LpKwM2vXMptUaV1w70Iz
         SC6P5DMo21aLEE89vI33IjNoPF2GCxmTMD86/IyLFq7ujY/deuVg/Ek4L34OTfKl5Luc
         zJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752073803; x=1752678603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6XI6lEJsP+gVFIc/qsO9HaCG0IVBwc4p2KoW83c4fA=;
        b=vTtoAinFVoOv9mAd+I562pV5EKHhxAwWFNvR9jx7J5/u5djG7OJ2pd/U0s2oWo6StC
         xg1uSNdEYxG461mtHBRTg2n1/nFEKqEY3+WMUc7kLkvD01WTdAQXoWMkZs2C9Dx8cQD5
         1wPCevx0xklsIaUKSP3sWDpl0foDQSDlLMaJY1+83/cqX5IliL5apuAf99lMY52T1u90
         wQUOOlIU0t5eMadCu1icXCdaBTOiEk/oOPyCZ13GWpeNS4Ph0PZQF22Mk3AGOkKQsZ56
         xx6Ndh9vW43KatD+gO1kynqsaflrLSFJEJZbWdjPenrbcHG9Q5VmAB0Ka5EupF+AEoGt
         8Mxw==
X-Forwarded-Encrypted: i=1; AJvYcCU0+EXF/n2gZ7N7skb8mUfdkx7Fv+jKumi4utc59EdHQI5FbduyE5BVbgirLMX8Mu/wrUtbyyAQ3KA=@vger.kernel.org, AJvYcCUxiKxB5qVtRTG2cg/VMjZu7hFnqdFfCIqN9+EjkcraPird6e2qDnpQnZJT+Ur6LCOAoh0m16i9J+A=@vger.kernel.org, AJvYcCXQbeZL1D4akrXxvm1WP4OdfYpI/aQ6GUS+1TsLVCJi6DPqYWWOTc1gSRo+LLP19iVD4vG6LP9yznh9tNrI@vger.kernel.org, AJvYcCXRzANFMazuYlW/yB6PT9o68fLZeQmp7oYo0uFg7v7x92I3HKIg92zIyurnbFRcgDj7fuLHt2QChElynog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuE9Q+THUpvtNSkCq25nlQKEO2uUIm27btvgWwS7bfFrFRra/b
	Jff2ydEvbZTQA15br0tGOSR8iNi0PCIqLHeb/DxcBAjCMoRgjOAtQJKk
X-Gm-Gg: ASbGnct8C107jen7qUueRm+Q/JkC2Bg+saFNUm+qouuHfZ8MjbZMLfnovcdnTdEI/Uc
	TZOs184NrgcvVTsAKZ3IcZrq4i2LpZAkk0GJYW+qd93unZrCpBVRyqhIv0BGb6WpVwnA69wFSb8
	fr4Ry1S26KV9OYBTVKTx/YfE5Dhc6x9OrL1Vlg4nHVnztaLNvcMG5Xo7dIG96h7SgxOrKPSJmqw
	kWMc1el8faE3j+1tJeWIk0iWWqtY/psSSaWMyBJodIBDu9lfGzj3jPkBkiEXiArO7lRd6Bmei5M
	cryW3IsLAt+W/NaRwjDZ8XAInGvR8OK0W36w8Q3p5ck+6/l9Mtl7hKX3bDeay//R6AS/WLONTaE
	erlEUb9jerVvatZfVYJPSQJ2vzBeUf3ML+NzCNd0oElM2iByN
X-Google-Smtp-Source: AGHT+IE997K+2s8FZooKcpsspW56Ksu6KSWd7Tg55RVgboFUo07wUy6P0U0dFCLDBqevY/CBbGewmw==
X-Received: by 2002:a05:600c:3b12:b0:454:afb1:3bcb with SMTP id 5b1f17b1804b1-454d538b8d0mr28808985e9.25.1752073803141;
        Wed, 09 Jul 2025 08:10:03 -0700 (PDT)
Received: from orome (p200300e41f4e9b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4e:9b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b97376sm16425032f8f.61.2025.07.09.08.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:10:01 -0700 (PDT)
Date: Wed, 9 Jul 2025 17:10:00 +0200
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
Message-ID: <hmyn24xd7ov752c5gyrdsocdp22feyole4cnerotnknygv7ujj@oowsdx3z4tmt>
References: <20250321095556.91425-1-clamor95@gmail.com>
 <20250321095556.91425-3-clamor95@gmail.com>
 <aef4574b-8167-4af3-a29c-8c962b396496@kernel.org>
 <g7kegtso3opafpwocvibhm3rym35oikxoyq2wmphqy3wjenzpa@m7extntwahau>
 <ea77c51d-6fad-4bd1-a608-987642f77aba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c4aeyb5sspca7m64"
Content-Disposition: inline
In-Reply-To: <ea77c51d-6fad-4bd1-a608-987642f77aba@kernel.org>


--c4aeyb5sspca7m64
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/3] drivers: clk: tegra: add DFLL support for Tegra 4
MIME-Version: 1.0

On Wed, Jun 18, 2025 at 11:13:37AM +0200, Krzysztof Kozlowski wrote:
> On 10/06/2025 13:07, Thierry Reding wrote:
> >>
> >>> @@ -0,0 +1,13 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> >>> +/*
> >>> + * This header provides Tegra114-specific constants for binding
> >>> + * nvidia,tegra114-car.
> >>> + */
> >>> +
> >>> +#ifndef _DT_BINDINGS_RESET_TEGRA114_CAR_H
> >>> +#define _DT_BINDINGS_RESET_TEGRA114_CAR_H
> >>> +
> >>> +#define TEGRA114_RESET(x)		(5 * 32 + (x))
> >>
> >>
> >> Does not look like a binding, but some sort of register. Binding IDs
> >> start from 0 (or 1) and are incremented by 1.
> >=20
> > I'll try and clear up some of the confusion around this. The way that
> > resets are handled on these Tegra devices is that there is a set of
> > peripheral clocks & resets which are paired up. This is because they
> > are laid out in banks within the CAR (clock and reset) controller. In
> > most cases we're referring to those resets, so you'll often see a clock
> > ID used in conjection with the same reset ID for a given IP block.
> >=20
> > In addition to those peripheral resets, there are a number of extra
> > resets that don't have a corresponding clock and which are exposed in
> > registers outside of the peripheral banks, but still part of the CAR.
> > To support those "special" registers, the TEGRA*_RESET() is used to
> > denote resets outside of the regular peripheral resets. Essentially it
> > defines the offset within the CAR at which special resets start. In the
> > above case, Tegra114 has 5 banks with 32 peripheral resets each. The
> > first special reset, TEGRA114_RESET(0), therefore gets ID 5 * 32 + 0.
> >=20
> > So to summarize: We cannot start enumerating these at 0 because that
> > would fall into the range of peripheral reset IDs.
>=20
> So these are hardware values, not bindings. Drop the header or move it
> outside of bindings like other headers for hardware constants.

5 banks and 32 peripheral resets per bank are properties of the
hardware, yes. However, the notion of starting the enumeration of the
extra resets after those 160 resets is a binding. There's no concept
in the chip that would tie the DFLL reset to index 160.

Dropping the header altogether would mean that we need to hardcode
the value, which makes its meaning completely opaque. Besides, there are
a bunch of header files in include/dt-bindings that define symbolic
names for hardware values, and I'm not sure why you think these here
would be different.

Thierry

--c4aeyb5sspca7m64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmhuhkQACgkQ3SOs138+
s6GEDg//ZM7tv/7+CIYmiMFpfhKO1wfHNp7FXvaSFzPgf+s5DOE6y/q/v6qyys07
rC7loHmifF7Lkfrp1nkJxxyV8cSzgkHZfVp/jxA4vUGP1zz5aUWG5T2p6StH8iqN
8vMrDvHMlSCzte/+fmOMFrOVuFLwpGefPkRmiVsqxcW6+vWvWbCouwmhSHlarSVO
njey0uI7lhvIA5/pA7MsHJhQa3U9LDe/EfNAnIwqZy6OexHc8i5F9RKVFAyOX3I9
Ux0eT2nsJD5oPUlolH6ebuqtcGSFLeukTY3EEyPP70VJ2m+gT8Ga2tZukOXlGzqJ
REgWhMdmeeE6lZiByEBHKzEQOsigKfrqoCSfWKX5HYc5Xk8rMGzyFXs4ZZBOqJGX
9fb4rsiwcD+c429AXvoJ2Pvporja+HdaVC1iAktTjs/6AkgUU2okoKWKoCgL1H7z
DAr42CvSDEHEvvaVcoMws9yEm5/wFWlw8yLThtml72QiWe0hN9lu+3ThBoR1E2Xt
Z3jKPBCyuID6PEezswWo8sJeia6Deq1ebTRzDJnYmAesHerZI7y34qPEb8SjWi8L
21nPtwWb810flxkE0niTX54dkXjDgXoavZOtlg+Ec4iMpj2A6G18CWOj4u7JXCdN
cBKpq+P07mTB6lcLkVVLqGAvPTCfz6H04Gcn/qb0dy3PdAhgIdw=
=txg1
-----END PGP SIGNATURE-----

--c4aeyb5sspca7m64--

