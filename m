Return-Path: <linux-pm+bounces-30016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9517AF6FB5
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 12:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE2D3A3B41
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 10:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706402E172C;
	Thu,  3 Jul 2025 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcmLiAVH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EDC242D80;
	Thu,  3 Jul 2025 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751537318; cv=none; b=BBwmoSDGZua/HzmiVueLqJHGaFavtT4jD0ULBvtUD6mZnOonUwGhp46L74ZXzCh0DuGvzpjQ1pZ7cp56tyI6N/5t8AYwgFgEY+2xaWbqdlijwl67eC7qgwZDnznBMOUuADLGP2o2MLDe/aPzV1yswtkZsp+uyx0nEkLGDgvzmnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751537318; c=relaxed/simple;
	bh=AT1CnXLkiA949eHbI3N4NRZADoe17hbbQAYuiZp/Zhw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eJvAtGZVL4Yx7PI1/N+z5Wmf1P6K8HwC31EzUXS/WeDRicnQOejeozBOxrAEA1zV7B5qzkNF/j1WsLxAYHX7byn8Fxs64UWcWjrqPP2NzSH1A2U8UzoVTYbP0e+ZK+bJINchb/aMxOv//Xw0VIStDFDCQR2+a7YLFoR538svl5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcmLiAVH; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a52874d593so4525699f8f.0;
        Thu, 03 Jul 2025 03:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751537315; x=1752142115; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AT1CnXLkiA949eHbI3N4NRZADoe17hbbQAYuiZp/Zhw=;
        b=JcmLiAVHFNTrwYImNpHkMO1suxt3kTDGHfmnh53Xznc9vRLNxZ2AlxxNdAm3Blyuvy
         pw2E4a79U0lVBOuXPByOeN0MR/U82Q54GBJ0xd4cLG9OPJ2cKe0Wb2ysH1qKCXHlwVTQ
         CS8CncqIgXjfm7DWNndFndiew25CI7pDNyUqiguZDtYluIvdoimDy0W3y5DSJ0QHnoEO
         ApVyAeYN5GQvCUhQWAh1d5nNM3c70T1skWp4JfDM+xswne8mc7gQtww2J1RA2IrN1YJg
         xmmg4AQzl3aIpuqu54AGjhCTpDfYLQlG82lkFUPKmqfHsfdKpp5RQ9coozZ9T162iJjV
         e29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751537315; x=1752142115;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AT1CnXLkiA949eHbI3N4NRZADoe17hbbQAYuiZp/Zhw=;
        b=Yj9rH2CGCz1/zUY382gQont4JoxWPQtCz4aXs8Z7xuMsMsnT1RDvUsb3KMKH+DDZxg
         zQ4eqKABNFkMAQv808yQEU1/tpWJpvNvgbuCF7vBcHp5sMErbG50NoDNV9FCP1f+9tZU
         8ijAKNg1o46CFnlT/hpWF39Gv3hPE5i/04f2GmhaCaiRgZUYWNtJPlIfx5DxjTGfEbSd
         SAT7V4pJ7jiBYi6c0PnQzE4bzvbNnko12QGhWp4YIJrmWFf6Cv1vTON1Eyg+4r052jsX
         dzwt+l6ZtLIzvnTSAX/C3f8NefG4gBdl12LpKmeMPqXx99laCS4gLFQzAOs7C5K49cf6
         J3lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqbUS6ANNZXVOgiiYAPnxuVMDObTX1pXiLNLUQkJQsxAIgByYMgtRaKZAX07t36fhpdTnPmHWj1NkeqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg4aXpv+ukp09qDfOnkRw6MA4cIM4Y2uAgfHRXeIYjbO0r+Lx6
	+PKxSZlcwIT6WQxO0XrIV2Aftw3LKWZ9NAhfgo69sRkbDI/SONFBCFg7FIfh+w==
X-Gm-Gg: ASbGncs4CJww06DPKZVUPN+g1h/HRUIro53Qda1EhSfBw7QDhdKIyZuRjiMGJVHvJv7
	Vy2uTpTnGi1RXzq5v0xQtw1809uK7n+a6tU+L2Pi5DrJ0o4ttNYKnLaRqB+7fmYlhIN86p4Ts9X
	aug3qpOyHTAl8Tldey68DQgW0kKuZ1XBl71/mfDnc+hJU0NA3BrreCWgw90IPCJhvI75VZJh4zx
	eHnx6stncQR/KM6veOAYC+bS7R715JYl+C0AtLpgGC4Z1Lih8Wm0M+TrUemhHTZ2IPOQkqoBaep
	mQZu5sgdcxeXoQRuXyfUTXPUPMM94r920cas97pBOf4nMTsXyKi7LRZJW2drLVY/d/WZR8wln+J
	ruv6bUVirNelsCfMn0Jry5lOI7dl4DYWy2ipe6PYTol/r3D8qRbsi9SFDOB4=
X-Google-Smtp-Source: AGHT+IETajEME0XqnHpss2XyhqyS6HlcQReH+pyyCGg3rACxCGSi8imadxWYD1Y3lB2jG1a6lNtKbw==
X-Received: by 2002:a05:6000:43c9:b0:3a5:2599:4178 with SMTP id ffacd0b85a97d-3b32bbd689cmr1357777f8f.19.1751537314773;
        Thu, 03 Jul 2025 03:08:34 -0700 (PDT)
Received: from orome (p200300e41f4e9b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4e:9b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9bac51bsm22609605e9.39.2025.07.03.03.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 03:08:33 -0700 (PDT)
Date: Thu, 3 Jul 2025 12:08:30 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-tegra@vger.kernel.org
Subject: Forcing devices into idle
Message-ID: <rlzpjdsg6cbgxc553j6m25ysb6tyldy4lnxsjjn4hdzv7rszpp@y6rfcrbjfook>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z5seqlr4kwwbvdcx"
Content-Disposition: inline


--z5seqlr4kwwbvdcx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Forcing devices into idle
MIME-Version: 1.0

Hi Rafael, all,

I've been looking at adding support for VPR on Tegra. This is a special
type of protected memory (video protection region) and since it can be
used for potentially large video frames, it can grow fairly large. For
certain devices, this is prohibitively large, so the VPR needs to be
resizable at runtime.

One of the prerequisites for runtime resizing of the VPR is that certain
devices need to go into idle mode. Essentially they need to be suspended
before the VPR resize and resumed after.

Instead of adding some custom API to achieve this, I was hoping I could
use the PM framework for this. I can hook up devices with VPR using DT
properties, and using the reserved memory infrastructure I can get
access to all the necessary struct device:s for the devices that are
impacted by this.

Unfortunately, I can't seem to find a good way to force devices into an
idle mode using the existing APIs. I've had some success by running
pm_runtime_put_sync() and pm_runtime_get_sync() before and after the
resize on these devices, but that feels wrong, since these APIs are more
targeted at being called from the owning drivers themselves.

Any thoughts on how to solve this? Is the pm_runtime_{put,get}_sync()
method acceptable? If not, are there other alternatives to achieve the
same thing that I'm not aware of? Would it be useful to add a new set of
APIs to force devices into an idle state (which could be semantically
different from runtime suspend)? Or is this all too specific for any
kind of generic API?

Thanks,
Thierry

--z5seqlr4kwwbvdcx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmhmVpoACgkQ3SOs138+
s6H8eA/8DKYXM8Q4NfN3Dy4sm+8suSuldzrTG2nzdVrJS7jjhpg6iBam0X/tYTvz
xUfL8LCp6jllqzMZJw9RNyiX+oavicZVGoFoAeg/AcrlFRUzLjbHwEvLllg52R8c
+AjbncteyFTszrmUoEwrpy+dq0JtQuItUOcQPhFV2ULjsVux4NcWMusgRdQEmzjY
b1YJ8MMYo8Rr2iX0zQs0+v12sJuS6IYA6+rn6tmGIzUehAlrsKGHcGLcxk4k8+d6
fhEbDH+DKescqZ05F1mLbQs4qVwQcLVnN/2nuJw2C0P4Nm5f2xgj4FyWs3+VUfRF
bQ7cmXSmx6irZsWe9VJqKWJ6AEcJ/zkAL/acjt4dtFFMls20DDixjP4lJcbsqxfd
sG5J/w21r64fw2oAYE+sWg9agvfKBf3q39VPDw6nK7AneQv63o3Jgnh3OOS65WVy
lqFT4NcsOHayGNeoMlzFOKblkY6yvMqCJ7iAFR3FVYc+jpmKaTyuuESsX6+g2r3a
KKUjyf9nCP5RvEG8/mJiaEFJgZQDMenciUTyfPrYXWY2eQfCgL1jKmMW/Cp3Gs2Q
Jkjv1t7DElIor4KIUFT3NwZy6K5T/CcR6YQRPFhpfDGU3NvZYb4wxy9xBE4kGN51
L06NpjjfQZQSCNSJH/0EKyv3yoA8KXcCPFQgIevMCTh4+/31M0I=
=gwc0
-----END PGP SIGNATURE-----

--z5seqlr4kwwbvdcx--

