Return-Path: <linux-pm+bounces-34495-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB82B5393A
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 18:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1B85A595A
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 16:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6115935AACC;
	Thu, 11 Sep 2025 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kASjJZEd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3373235A28D
	for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608062; cv=none; b=d0C3BkCoqYyAtOhVmfBc8NnioM7164wP6bPg47EcGQOlMEKanwLGTk9SqJKXV8vPXvmMBAUWR9jZFRyZ1vADb9H+7q/SX0ArWXwEJsKrt25s8h3HfXUIixPFIdHKHNi+V7CcJu9LVQd4SvmM4yaLcUB9dobw1fgLHmkA1Ug9QZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608062; c=relaxed/simple;
	bh=F2DS23IYCKCbmxYGqz7wOiytR/HeVWVXloi3B1Ce1Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0FGcp7M0yYu3OUJqbwL2uvjuuCYZFOzTzkrrxaS3MXNHfNTndd1PxNKaZ90s3XhG0xupvsSBiwl1CBwEpXupys7z1SQacWgokfPM3l3v+4QQxHaO6/8UrNpydDibiIaS/5cw2KFTzr6QKQ3deTVqdOJu8PO8hFHwfsjP57P4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kASjJZEd; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3e751508f21so729479f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Sep 2025 09:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757608058; x=1758212858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uulERqXtmIIqPZaJPSJ878rKAqm1x84Yk9KDro0jsvU=;
        b=kASjJZEdP0cbIDzYcLg9sGvkF4FaGGpolCqBBbF9AitTsFR+UWL7BF6wq1fAYTlSnI
         PBUa202MgLrfKnxGE42F9NLSItdx3jr63W08GJ8g7cF0XWmsbu4ZxjPOQqfKnqfIExf9
         hyOguAGPrQvLoo02tNOkLYK/RGGh5bhIewI/GRggzhrc762NzxhBUfcv0M0Ih+4ieMJZ
         5/dDJFeFO6a93VR90KJMJLjVqNyD/xRaALTKwRA1wN6Ar1xb/YgdJ6AxBs+205lnJTZz
         5KImcKPRAHpnQ5EJenCZIsv0DdEePlLRNSlcLcnWzTEgiEFMxafky+gX3sZ3U1L/tUg7
         +bBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757608058; x=1758212858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uulERqXtmIIqPZaJPSJ878rKAqm1x84Yk9KDro0jsvU=;
        b=twj3R7YQ1PklWTrnREtIsY1Yveqypn4JPsRcu/hfczOJyPV72Nj4b2fA4Sj0nOR4KY
         ipbdgTLwRJywbbe9LzHGHuKWEXq4XMfxq2G7Cnsn6uYaYZiuWOYlmeCEJkxjijACzLyh
         iHVIRrDPDzytHXOJ0U+o9muVr/z/D7130H/iyevs9SIorILtcowZUuS0OD25oBTQBvcp
         qH74Rj/La7JIlUdTZA4FR5k5fCScWfmAaa7lpzena2RhgCFSDZysc1Rg9nrIDNxPVo1y
         WCcfYno5EWcddK9iYiuq/YGl38InRHD3Weu12J/b03TjdVEDZQv6JympDqcq9qGcvR2i
         wrag==
X-Forwarded-Encrypted: i=1; AJvYcCXFpYdFQ03GLWR7a9T/aCAxqwqUHt3mAQOwRbRf15DnsUqHnYHEIgtfnpJceSR3GLeUgHTU7XWFQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlueB8cW4F1x/WSlvmHtNKj83iSKCCUkRQZzkkZX937sMknQ7W
	XBqN13yGQY54ElyWom+Y4hAj2U8qaki9bM8DZGUwtE4f6ecW1BQxez0r
X-Gm-Gg: ASbGncs493yWR4SiQZvnHT54bc4jH006OJ/QDXM9ubRiaV3hB2ciwL6LWd0ZYjvrOJc
	ZCNvSZd+UQB+2o4TTAH5lT0fHpVo/5cvBjs7A1iZvD3quLCXoQ5DLKnK5oXQ/0aicehZGvMuBQf
	ScEQi08vsEBc1ECMHxT5ovm7//ezakawyhqy1e+R5dj12MzteiNyeCG3FtX07Dma7qYnOg0CjNa
	XQoqdxjxH26ukSXb1gNlRGR90+ck38Zzm9+VLKbUE2I1nKkpdrOq5RI3hlzHpwPA9Afh+qJm9ce
	mF4E3DF4n2GvEnSeMxbNmrCr93YbEj4YhCokiC0enpwgwXvEzLA0ak8hu3zntTCpnjaULvq3pEX
	ZM/oTmDaY7fO0tnRkJd3WGbeV9F6Z9sZoSrNvgaGClgUdCjq5PMdhVnz/+Lme0jZrxDmVz97jAq
	zdj5AEts1/oaL4DyvAzFE=
X-Google-Smtp-Source: AGHT+IFFi32QxzOdl2cjeDTiavFcpcxdyTuhwR2Hej9Pf5mnYeNRpH6Xd3E7OQUxqcTWFSZ1jF/clA==
X-Received: by 2002:a05:6000:24c5:b0:3e7:615a:17de with SMTP id ffacd0b85a97d-3e7615a1b81mr2212313f8f.47.1757608058345;
        Thu, 11 Sep 2025 09:27:38 -0700 (PDT)
Received: from orome (p200300e41f1c4d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:4d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e03718c64sm28987815e9.3.2025.09.11.09.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 09:27:37 -0700 (PDT)
Date: Thu, 11 Sep 2025 18:27:35 +0200
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
Message-ID: <tdknls7jieu4ple3qhmdqntllmctks2auxhxzynwjjmgl3hnx2@nubqlzpgohwf>
References: <20250828055104.8073-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qlavv32ljfhhfudc"
Content-Disposition: inline
In-Reply-To: <20250828055104.8073-1-clamor95@gmail.com>


--qlavv32ljfhhfudc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 0/6] thermal: tegra: add SOCTHERM support for Tegra114
MIME-Version: 1.0

On Thu, Aug 28, 2025 at 08:50:58AM +0300, Svyatoslav Ryhel wrote:
> SOCTHERM is thermal sensor and thermal throttling controller found in Teg=
ra
> SoC starting from Tegra114. Existing Tegra124 setup is mostly compatible
> with Tegra114 and needs only a few slight adjustmets of fuse calibration
> process.
>=20
> ---
> Changes in v2:
> - no changes, resend.
>=20
> Changes in v3:
> - expanded desciption of "thermal: tegra: soctherm-fuse: parametrize
>   configuration further" commit
> - changes title of "thermal: tegra: soctherm-fuse: parametrize
>   configuration further" to "thermal: tegra: soctherm-fuse: prepare
>   calibration for Tegra114 support"
> - Tegra11x > Tegra114 and Tegra12x > Tegra124
> - ft and cp shift bits dropped
> - clarified tegra114 precision
> - lower_precision > use_lower_precision
> - nominal calibration ft and cp hardcoded into SoC specific structures
> - added tegra114-soctherm header into dt-bindings
>=20
> Changes in v4:
> - fixed Tegra124/132/210 cp mask
> - dropped TEGRA114_SOCTHERM_SENSOR_NUM from header
> - TEGRA_SOCTHERM_THROT_LEVEL_ made SoC specific
> - adjusted soctherm node and inclusions in tegra114.dtsi
> - dropped use_lower_presision and nominal_calib_cp options
>=20
> Changes in v5:
> - fixed CPU and GPU hotspot offset values
> - added static_assert()s to assert the TEGRA114_* and TEGRA124_*
>   counterparts are equal
> ---
>=20
> Svyatoslav Ryhel (6):
>   soc: tegra: fuse: add Tegra114 nvmem cells and fuse lookups
>   dt-bindings: thermal: Document Tegra114 SOCTHERM Thermal Management
>     System
>   thermal: tegra: soctherm-fuse: prepare calibration for Tegra114
>     support
>   dt-bindings: thermal: add Tegra114 soctherm header
>   thermal: tegra: add Tegra114 specific SOCTHERM driver
>   ARM: tegra: Add SOCTHERM support on Tegra114

Hi Daniel,

there's a build-time dependency on patch 4 in both patches 5 and 6. Do
you want to pick up patches 2-5 from this series and I pick up patch 1
and hold off on applying patch 6 until after the merge window? We could
also do a shared branch, but it may not be worth the extra hassle.

Thanks,
Thierry

--qlavv32ljfhhfudc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmjC+HMACgkQ3SOs138+
s6FmAQ//Xha5LNouKuDOjR1aWxRbsRfL60ImU88sqfgV4EX+BNrWtnWif8KYz0Pp
vZJ41PUNxz6Hw62m8AhnxrjQEkmMKpXD8ditYLTwTsYrxD5CO70SYBc4mWt54lg4
bcfULRDLSbCdDa5tGnovhPXnGUCM1JM19YbOVlBUXu2YhSVR3BBzXzKW/PsLUx9F
ccT90oxtd8m4eTFFiKBXkzgK0UsV0cB0MicKygDwGCQbtEl1SrN9rhYzBJF0XldI
7vS4j8CuMSx/Ia6C3mZQKh4a9Tjp7NCfmEb9HiwTzclvJFDt9BcbgbnumZKzrfUh
DIfPF245ye3Xea9+tDLOmdtzhrGx3kwQ9D6yRtrFHFSroJd+d0ScSoj3SsIbHz4e
krFuYnm/9lM1IekTTCYWGgUOmrE2UNk3qlwInDpl1oUJh7S0if62YxsCBunypIKI
NFw6D7JrEFkUm+fnTSYPKZ9tUl9WsdadpxJN0EMezLEcf9Nti9WeWwvPgTSbZlTW
M0IbTWH17CWaIo//mK00xa8m96cZVC5qjGmUFIBSCd1J0yJwLw+S4lqYXckufdsg
xi2uqkA1RQ6Vmt+t0xceanoZsLPnOo7xPuR1bSf+KhyYsWf4g3LKi9HWOWSSn6nx
0jPMGnKTwXzxUj1LEV1B2teXeefp3iFh8vINM890oVlPIhUPWts=
=QXXu
-----END PGP SIGNATURE-----

--qlavv32ljfhhfudc--

