Return-Path: <linux-pm+bounces-39937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DADCDE2D4
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 01:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC89E3004CCF
	for <lists+linux-pm@lfdr.de>; Fri, 26 Dec 2025 00:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AF02AE84;
	Fri, 26 Dec 2025 00:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP10CBCd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E4B3A1E8C
	for <linux-pm@vger.kernel.org>; Fri, 26 Dec 2025 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766708410; cv=none; b=CJzwyKosM1FkGUri0waPFiAgLG0svHXXif5TWHp2X7rUrgdBT856S1rOXGXKkgcdDTutDYCBWi9uBlxAKZ0yY/djfGbaYbZAxn+QErhrOOyrpNE9SRcWZUBTlZtelaMkWA3TPH4BZjX5r32iXpsEcO5Q7oEjk5izeXapmKUq0VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766708410; c=relaxed/simple;
	bh=nGwM+PQuL1rzxPZ5jagDG0kFkA7NFWyXrk61vQ0HbjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtAJywgOc9qGimR3Abm/soInWDYqNFS7+UC4+bri+UbeOP2rU9wEIj/Ewo/1Uply3UB60NzgkznkESCSVJkouUt0MqkAGSDWRBsKvps9gb2V8sg8eowjtYKg8REkh91LpRZ0hGtdjk6Yc44IEwebdREJc85q7lhfVl0WXTYQcL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OP10CBCd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29f1bc40b35so115211815ad.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Dec 2025 16:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766708408; x=1767313208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+DhWhE7XYlLnVX4zCn90QgLygN3HeTxBI4v2gs7tTiQ=;
        b=OP10CBCdAUEacACKVvMPn6XHxS9EbUitLw4z1g+kARcZywxhn2wVI1mo1gRBilHtj5
         KyC3El1KDYxst7dTnafKE2sxfO2E8CVRZx9TXJVQwcQPe+2IAoCrWRFF/UnvnYT99Pl0
         CfujeCadZV4ip/wJw0LkKVp7Z0DfOfy9Mo2yHdKghpkVs/wKD5aMeSJyQktGp6IrUBq3
         yerN7Xm6lv+PZE9LcI+97ltp/2PphRKf+hxzc3eyV3YipGj2hAZfDpCGc/2d+2z92sTa
         hz6TfvIbyIXE9JPZrBAcMuTze73FJyNsgT3Jl42uh5VKr5xke6uf9+KdKG9i2dRun5Gt
         W7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766708408; x=1767313208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DhWhE7XYlLnVX4zCn90QgLygN3HeTxBI4v2gs7tTiQ=;
        b=DVGGg64CH3rnKoGx4bw7VBYXBCCcemfpJ91pg+j98TOhO6dowhzwiS7hOMON3G8+HB
         dR4QztbuZRatSHupAKLLWOPAAzE0XxDsLPem5gD/uwc1T2eYFnAwKZ7pH0sCrS+y+/3h
         F462kxfsqkVELHD5UqR7TLrt48clhK10j4+r4JROqtuRQ1OfaobkcSIjI4ikF8i3yvoY
         Kig/e+CLmXotLU1hPUZl4iHUFOCb2wwWS1hNQ96IIRkDIeeIU4cxHP+yfJVckUUaAB9L
         v4XUiJC7ZeKhC7TAKauFLhHv861htzasPdWg4zoSZMEWM8PkIdd+Oq2aFec0ZTuOvX7e
         Dw1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVX4WcZ1jNVPPIicvp1gH2sfEoowUx2YlLMBARnLcWxI6cN1JaF+nPQ+K6oAtljtJBxEJefPuFeww==@vger.kernel.org
X-Gm-Message-State: AOJu0YwI3AtNdwjenDNjVD98UCVFG8PfD6RINboNoINjj2DtFH1cWb4z
	xrK9Z2C7yp/Mq9eisBIJ2ubkBH8aq68YZP1l1d9pItmmphzYcS+SzyXlvQEqhP6k
X-Gm-Gg: AY/fxX7DqUlF1QdylNTj4LA3kXfOXg1KnD5GYfwhHeqy83qWYEcCL+1WFYpMRyawd5o
	V4Tav2PkVlUtMrLNxB6g2SPz/4N29iql5F7KjgN3QuMDzhD+vsz6SKJr4AVczh4VrpdxiGqGG/Z
	yYOUX3wKyYm1iju4kULC7ZtDGQr2WXd2UNU5lpq7EwJjKbeWjW3bHALJohlEF4LeNhcnO2XPFIi
	5NFB6NZZNKMjWurHBEhKN2NL3oml9t3z8e1MXuExWjbz8RkJStCt5usnjhrSd4KDzuzT97zQOBx
	Q9Yrqx1vx7hYPypFSpC7moZsE8Obfex/nESAOjrphwPslSUd7HnvQO44Lms3+5inTr3YWhO6Etc
	Rk9Y4yGN/ozA/cFWXetOY1TFgPLbd3TfjgAq6Zh1ygIEdLEn/Y7LXtXt1CYOQkoI8QMIGE7vrFb
	eJMw674ar30js=
X-Google-Smtp-Source: AGHT+IGLMBqAzBAWo4yb7tpIYsnetp2fYl5pljocfiHOuE5aX2wPJYCLp8EgyaUT6wEF75bnJiiidQ==
X-Received: by 2002:a17:903:ac4:b0:298:2afa:796d with SMTP id d9443c01a7336-2a2f2a56707mr203430055ad.61.1766708408379;
        Thu, 25 Dec 2025 16:20:08 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d1b8sm191462195ad.68.2025.12.25.16.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 16:20:07 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1E93540A3327; Fri, 26 Dec 2025 07:20:03 +0700 (WIB)
Date: Fri, 26 Dec 2025 07:20:03 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
	corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
	rdunlap@infradead.org, ray.huang@amd.com, gautham.shenoy@amd.com,
	mario.limonciello@amd.com, perry.yuan@amd.com,
	ionela.voinescu@arm.com, zhanjie9@hisilicon.com,
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
	nhartman@nvidia.com, bbasu@nvidia.com
Subject: Re: [PATCH v5 07/11] cpufreq: CPPC: Add sysfs for min/max_perf and
 perf_limited
Message-ID: <aU3Us1NzlpVQcyii@archie.me>
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-8-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t+JMDWcZpMsJclIY"
Content-Disposition: inline
In-Reply-To: <20251223121307.711773-8-sumitg@nvidia.com>


--t+JMDWcZpMsJclIY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 05:43:03PM +0530, Sumit Gupta wrote:
> +		Write the bitmask of bits to clear:
> +		  1 =3D clear bit 0 (desired performance excursion)
> +		  2 =3D clear bit 1 (minimum performance excursion)
> +		  3 =3D clear both bits
> +		The platform sets these bits; OSPM can only clear them.

Sphinx reports htmldocs warning:

Documentation/ABI/testing/sysfs-devices-system-cpu:356: WARNING: Definition=
 list ends without a blank line; unexpected unindent. [docutils]

I have to fix up the bitmask list:

---- >8 ----
diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documenta=
tion/ABI/testing/sysfs-devices-system-cpu
index b022cbf46adcfe..8cda698019922b 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -363,9 +363,11 @@ Description:	Performance Limited
 		requested level. A non-zero value indicates throttling occurred.
=20
 		Write the bitmask of bits to clear:
-		  1 =3D clear bit 0 (desired performance excursion)
-		  2 =3D clear bit 1 (minimum performance excursion)
-		  3 =3D clear both bits
+
+		- 1 =3D clear bit 0 (desired performance excursion)
+		- 2 =3D clear bit 1 (minimum performance excursion)
+		- 3 =3D clear both bits
+
 		The platform sets these bits; OSPM can only clear them.
=20
 		This file is only present if the cppc-cpufreq driver is in use.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--t+JMDWcZpMsJclIY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaU3UrwAKCRD2uYlJVVFO
o4kvAQDTEVNeFeX7ckTchAsnDcqX6/lgn/RtWuqlH3bGU25fFwD/ZEKQGJS37yff
aP5cML3xRpih8KZ3CuP+1ul/2sh1TAI=
=OMhn
-----END PGP SIGNATURE-----

--t+JMDWcZpMsJclIY--

