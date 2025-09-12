Return-Path: <linux-pm+bounces-34541-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 308EFB549C3
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 12:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5D1567486
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 10:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA6B2E2DEF;
	Fri, 12 Sep 2025 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE/4tV7Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9017E2E03FF
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672823; cv=none; b=vGpu7RU7OMCg8AWSdI/QxczfIDTGzWXIg+K+1mhrs2CllfDKGS2dF77LZ294OPczaQIblKdCPUVZQR+fjcpWoneicwrHNrzmJ3Vb8hcFxJsFC3kfdpHtD9o4p9RM6ZgYqA91yUwTt28fAy/fu2dFAzOmYYOOj33bHZMucRAbrf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672823; c=relaxed/simple;
	bh=a/aXEMGb2BQDbPqE+kiC0jbKGYkUHUoAmyib1xRnP7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUfq/BzylSJqeMix9/a4XSjmm3N1WtAdgLmhgPs/dFT+tJ5T8gP89SU2Ot76r9Vfg3CbzCNds7NZSw9ke94IMJSoCUFtpjaupwXsO0LTh4vGX109bAJnZeoRBCiv30rC8M91AugPSC3ENBnQG3IfpXOC8rj9/YFAfftobXBimPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RE/4tV7Y; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso12249605e9.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 03:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757672820; x=1758277620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VEszHJ67kocets8ry4iAcIkKEULLubcUd+fSnC0UnKU=;
        b=RE/4tV7Y4LN1WirJdE64Tp/ROSNGu6T/IPF8AWszaNqFeUgZ4g9RRu3L7R0vMVrSLC
         b7STZLa6vCwgdwWH+PHLS43tYUH2ZDlw8aGtXfrIytZqmSZtVQLO6kzKs8wGfaKm0H8M
         PelDnxWJMlXosRGSXMStlKlYViy8YK/aTQxQr6iioGid3HseYrmuQfNGXjISFeriBXwq
         p1m8ciQPoGUfeDJElUI7TbEbQ/pTyu+ICiWk29phNLUfr9ErSc664eoZAtGjdxrZgQex
         xWAnr0E3ExmtnGeVo5exREB6d1uQLFxlv9KgrwrWcNqgH1iUDapR25WsZESydkT9uQma
         e7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672820; x=1758277620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEszHJ67kocets8ry4iAcIkKEULLubcUd+fSnC0UnKU=;
        b=mQasyRq0F9Om4q5WJOVGOMZCkRzws2cy5znIM3R2wLAdomOeXQXMEi/wOE+WOZzw01
         wEIJPel9TnsttAPfgnO7IocE+AlXzNx259s+Tdc56hSYpDQIDVtxaMWxi+ZfCSD0z955
         YVtaxx+A2v2wE0A8CyGKY27EPBDiVzikhgoB502n62ADAksq/no6PvzZv+XKAa7RoE4L
         0bYT/jp1XkspP1PvN81EAC0cWWilfnOO3apC2CvEwqfQfahRk4j5x30qyOQsS45sP6u/
         BhtkhkC0PkCRU5dbjnC4U1oUA3ocTAhhYJwxeitUB3/uHDmN2AqZbdzi2kI6NNN8V/XI
         VrRg==
X-Forwarded-Encrypted: i=1; AJvYcCVo//9ceaRo86Bub1g7YZicwt7d8rNChJSy3oT7qXpOqEIu8BLb5l0+cKuy3d1bGUpPEYg0XxPQ8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQYGOWW+0He7JsyDZQKmCx3fRW4yZFk9FeSkvHGJ+VsflnIqfJ
	ZpTSB/E21h8mIqN1LPPTnWht9sh/WkDcu0KxDW69d7VChxieDA/5K/+r
X-Gm-Gg: ASbGncso+MK6GFHfoTOwFHWPmh4BzCXAAHzYVxG3xXYDm8TfsFhGRowMYryIFOQgJQN
	i+oOiII8oKUqhEXd8ohzaxJgvK4w5K9QtXLT+GG9eJucJezoihLCfBkr/mAzeQhSD8X4rXFtWhe
	H0fEwomE7zmb/Z60KQeIt31WrivtDD7zcnztoU4aXaDlSus0TIUkrHXQcecs6ZFr9wn/6VJk2HT
	+1vgvy/bQE94acw4go1MZjuI/B6YCimH8GDoAJIDPQdiFs4itUkWdM3ANzRQliM0mdi7f6Rz8Yu
	DuAsDe+1u8YrvGMDSHyZmDNaPzaBtOEjByEJXi225xsBwLF0uw2TMXgV9IiRfHkFhOmZlkaT6GN
	ICwVQXQgAifOYly1XtNVRyaaT6MyLPwg5FSjQuywreHSuYMZRIstP5LE4z6dDdfzXpQON9fNhBW
	zcVmxMjAwgstXmjBRbCAQ=
X-Google-Smtp-Source: AGHT+IEbyHndbn+wwznPnv5dSbk1PDx0bdvxUnNmyX0t9tVPgFtH6+RjNOs4QbIfK49oM38shQc3wQ==
X-Received: by 2002:a05:600c:354e:b0:45d:dbf4:8882 with SMTP id 5b1f17b1804b1-45f215641afmr19183295e9.28.1757672819578;
        Fri, 12 Sep 2025 03:26:59 -0700 (PDT)
Received: from orome (p200300e41f1c4d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:4d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd415sm6002552f8f.30.2025.09.12.03.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:26:58 -0700 (PDT)
Date: Fri, 12 Sep 2025 12:26:56 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <treding@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/6] thermal: tegra: add SOCTHERM support for Tegra114
Message-ID: <amc5e3sffmwqguivwch6b5vtmlgu5dlwxm7bsrn6nd3rllbvxg@koqmavn6uuy5>
References: <20250828055104.8073-1-clamor95@gmail.com>
 <tdknls7jieu4ple3qhmdqntllmctks2auxhxzynwjjmgl3hnx2@nubqlzpgohwf>
 <da8aa4c5-4aa0-42f6-acb6-55d37cc29774@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="77pu5semdcfvsxfi"
Content-Disposition: inline
In-Reply-To: <da8aa4c5-4aa0-42f6-acb6-55d37cc29774@linaro.org>


--77pu5semdcfvsxfi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 0/6] thermal: tegra: add SOCTHERM support for Tegra114
MIME-Version: 1.0

On Thu, Sep 11, 2025 at 08:56:12PM +0200, Daniel Lezcano wrote:
> On 11/09/2025 18:27, Thierry Reding wrote:
> > On Thu, Aug 28, 2025 at 08:50:58AM +0300, Svyatoslav Ryhel wrote:
> > > SOCTHERM is thermal sensor and thermal throttling controller found in=
 Tegra
> > > SoC starting from Tegra114. Existing Tegra124 setup is mostly compati=
ble
> > > with Tegra114 and needs only a few slight adjustmets of fuse calibrat=
ion
> > > process.
> > >=20
> > > ---
> > > Changes in v2:
> > > - no changes, resend.
> > >=20
> > > Changes in v3:
> > > - expanded desciption of "thermal: tegra: soctherm-fuse: parametrize
> > >    configuration further" commit
> > > - changes title of "thermal: tegra: soctherm-fuse: parametrize
> > >    configuration further" to "thermal: tegra: soctherm-fuse: prepare
> > >    calibration for Tegra114 support"
> > > - Tegra11x > Tegra114 and Tegra12x > Tegra124
> > > - ft and cp shift bits dropped
> > > - clarified tegra114 precision
> > > - lower_precision > use_lower_precision
> > > - nominal calibration ft and cp hardcoded into SoC specific structures
> > > - added tegra114-soctherm header into dt-bindings
> > >=20
> > > Changes in v4:
> > > - fixed Tegra124/132/210 cp mask
> > > - dropped TEGRA114_SOCTHERM_SENSOR_NUM from header
> > > - TEGRA_SOCTHERM_THROT_LEVEL_ made SoC specific
> > > - adjusted soctherm node and inclusions in tegra114.dtsi
> > > - dropped use_lower_presision and nominal_calib_cp options
> > >=20
> > > Changes in v5:
> > > - fixed CPU and GPU hotspot offset values
> > > - added static_assert()s to assert the TEGRA114_* and TEGRA124_*
> > >    counterparts are equal
> > > ---
> > >=20
> > > Svyatoslav Ryhel (6):
> > >    soc: tegra: fuse: add Tegra114 nvmem cells and fuse lookups
> > >    dt-bindings: thermal: Document Tegra114 SOCTHERM Thermal Management
> > >      System
> > >    thermal: tegra: soctherm-fuse: prepare calibration for Tegra114
> > >      support
> > >    dt-bindings: thermal: add Tegra114 soctherm header
> > >    thermal: tegra: add Tegra114 specific SOCTHERM driver
> > >    ARM: tegra: Add SOCTHERM support on Tegra114
> >=20
> > Hi Daniel,
> >=20
> > there's a build-time dependency on patch 4 in both patches 5 and 6. Do
> > you want to pick up patches 2-5 from this series and I pick up patch 1
> > and hold off on applying patch 6 until after the merge window? We could
> > also do a shared branch, but it may not be worth the extra hassle.
>=20
> I can take the patches 2-5. Regarding a shared branch or wait for the next
> version, I would prefer the latter

Alright, let's do it that way. I've picked up patch 1. If you take
patches 2-5 now I'll pick up patch 6 once v6.18-rc1 has released.

Thanks,
Thierry

--77pu5semdcfvsxfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmjD9XAACgkQ3SOs138+
s6Gb2w/9FzFuO93dIq8o6wF8l7bzhiJ1Xadi6emh4ye9NQ/Xzu9S1KPszf+WaJYl
WQPyLCxBFvFb3BuARreuZbgnbM37jEW2N+JZbpbOE7Mq8cfXUPJ0xcR3hO7a6YiY
R9xDYSVAvFpAAxPlUU07wYRswWpQHRUk2kiFO8goc0m17/kd2nbiwhdYVzRg3wrJ
YC2ZX9m/3l7TmsVd29NfEdKV4nW5FRH2v3aSi+IScXwjObd0oHo4ygrruccMbCPk
RSRSXCqvEpol7cpx7kY+jCJTQ5h7lLrewycb1P8Dwxvz89ER9mtk+F5kwJiACGgN
G3OeAaN9H9z/yuidIrgczHu1k1NezHBE3e9pytu7XHBlvC44Is/hOeGn3Wr+KBux
as8CB/cfKSAnIn6SaXCbgxfHqQrBlO+FvTWWpN/6HYz+KRQQD42pz7AdhOMeAuCG
Q+9sExxgd5M8BHZIdLpHvTalHbseuZm3kQdMJgfqCQdwGXgM6rCBaq2XN9loILdk
6F/JNKe5ktkTT6DGtmDjXGfHKWrVa6oQ0F5MXo63EDHUwdPZVPBj3BQfAtRBbMjo
mJQmDcOwACPS7wnW9wuDyJdPdllXRajiRIwt1j4nrYms7kVnOoikJf81msUwRucc
ze5Fz4UK2uARv4qMX0qNDms6am7uL9DG+kWRaIFWUeERiSOmbDo=
=ilf2
-----END PGP SIGNATURE-----

--77pu5semdcfvsxfi--

