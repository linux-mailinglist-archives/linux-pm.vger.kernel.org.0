Return-Path: <linux-pm+bounces-28493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B60EAD5A18
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 17:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA85816C397
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E201B4232;
	Wed, 11 Jun 2025 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU4oHpYE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A581AAE17;
	Wed, 11 Jun 2025 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654840; cv=none; b=UdgcPFt6j85Wuqg0prY9V5IB7/Ek1eMhTQbYuHCI77laE/ZLm2y74G4AVxN4AEF5YjIvetjv+2H8p+G6uyn9nfXkwBSfF4GrBufqfhsHXOeVLdRRw0wg8xeG2uMqtUjD9d5I3VwstMAFJjvWrHlL5SKWhg8gbVw7Fm4JKhu6rTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654840; c=relaxed/simple;
	bh=jM9SIv47uSPzQUgIKVYIjte5g3q2lgRBj97mkI7HfGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMIAtJw3vwD80qSINKsuEcSCglsATvA8qK71QZ+1xOmltT1/uZmyUbXTATMUjr0Lc3Sh4s/kA906oDJ9zrvX31tfFHlCadxS3lVmQhz3ynJvfGhszm92zp8Vr7XVHwNk3ix+bgW66kWxaW/CNOSEdHQ/m0+CvGiI1RptVYyw/8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jU4oHpYE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a5257748e1so4510820f8f.2;
        Wed, 11 Jun 2025 08:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749654837; x=1750259637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eJ6kiseIwpUGWM4WxgWJ+3dmEqkiZU2MHZ6Ixbn90Es=;
        b=jU4oHpYEhXHoLbMsu7wb0l0e7R8pcZsyNjWlxtTdbpVnmjeupf339WZsbwIdi8HNBE
         BiQs5yBUZ8RIc9PfhkUfJay0YbZV06FJcS6N3ywCAynSTE7AKzOA4uo/+imIdXjaqktP
         5K5G60Gu0g2/BNHhwnVSY19jab6FVw9x+BfRCP/CwZ+3k1X637RF00zjIGilIZLXXW3o
         MIhsAzq74WGgKYacDiT1r50SzAnMvZWw5jhNHflA3hTkVGANLGZnIHyA1OMmLOZlGsrV
         XUEQ38xZRF8R/+GQW7ecq4Tkj1BBVWkw5qvhseav3Di4pmwBZy0JZuhXqwFNlvHNM/NV
         6wzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749654837; x=1750259637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJ6kiseIwpUGWM4WxgWJ+3dmEqkiZU2MHZ6Ixbn90Es=;
        b=osK0NShBw5AdSS3m/9oMosK6lS6DnVojwY6mNDOR3pLtLWvQX1tPXGdV4/FLcxXkjo
         KraRI+w1XTDQ8hGgVgJr++1sRFwDsgO1IhDTu9EI7PX0l6HfsHUuqguwrMK4rSLZsUMi
         IlI36uCEiFSAY9LqzjPPouLgEoHZ+08gMoaQTrYNIf3piBo+u7tzppXkH2imiJciEts7
         cZ+SfnItxlqdOFXh3NABO98IaR/jqjbOgcLXG4Dm6a7hx45L26kugOwuiAbnxvIj3di8
         6QkmUdO/ox+cnGh7SVrOpv3xMYT19d+VUen9G0vJTGTnovfgCODAjIOQDuPiZwUZEIRq
         jtWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe5YBvCW1J8iioOZjj/KSTT5piuv5DgR20LBox8BVfw8gT/e7aw1FcRopaCGKjOgIzqh9lSe+ZLwc=@vger.kernel.org, AJvYcCVRmpaoyAjS+A0Eg2RGj2db+jDbX8QL2juKXI2RdPR/IIUzdnA255lXX5sNOKvqCcuzrwAo/FEkC8AwexbN@vger.kernel.org, AJvYcCVe8B6A0HifLFy2D/2UE1LPiJY/VM4+ZWkYi4FIR8ef0iGfraJrn87qHdrgbv9B7+B8KJ8nvV/NUbsM0Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWljuuY/KUE3BULbT5GqNhuxHX9ciEQP2Gqy3hE6LIGD5oOEeZ
	4d51mPhKgJ0jPG6ORC4xQnei4qlpz0nGmKBtuetnsj0WB0eH9qkQhPDJ
X-Gm-Gg: ASbGncsfZaxuDbutHQh1MW9a02ZaZpy7rQGnBswkRQhVipRpU+s5y1/NAXTTGmL5XC6
	NY7pfgI5YP51TmBcgeQL5VBga+cAr1ylilASVPkqx1bHDcf4AsS+ckUtOMUtuE3XkOmvJPTaHvf
	K3LibdTeQQ0d1+RMOnXhtvmoubxOZVR88jx7PURb06ky3T3AJIp7HMrY+UhikNJSx26eAgaVLwU
	D4FZFOjmvYImLABaEcdr105KE9oVEvwCAScHbw5MLIC9NE2N9AI6G3LHzGZd8U0U1owpOFAcH/9
	2uLKQhEpbfFjCyeAMvXoEHnRq71uVKo64a8GqOHWQt7AnRn62Ld4XQN20BdarkyU6Ank496AFRd
	lg7LINhDbVRmS02g4AO+z8xKdt4NMAmv/CbGLV1NN7bafl9GL
X-Google-Smtp-Source: AGHT+IEGpelflXkAhSGolv6mTEYB7BjVwN4miqspdqDRdGhmnX0Z42dVwsOdmIjC2aRr/sZhwbCWTg==
X-Received: by 2002:a05:6000:2407:b0:3a5:3a03:79c1 with SMTP id ffacd0b85a97d-3a558a45e91mr3053746f8f.48.1749654837243;
        Wed, 11 Jun 2025 08:13:57 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323b67ccsm15592582f8f.40.2025.06.11.08.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 08:13:55 -0700 (PDT)
Date: Wed, 11 Jun 2025 17:13:53 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal: Use dev_fwnode()
Message-ID: <afevspocjaijeysxxtlehlge5rillcocnjsaij5qqrlijjghfw@rms6i2jvdgw6>
References: <20250611104348.192092-1-jirislaby@kernel.org>
 <20250611104348.192092-20-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fm3wygecilpics7d"
Content-Disposition: inline
In-Reply-To: <20250611104348.192092-20-jirislaby@kernel.org>


--fm3wygecilpics7d
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] thermal: Use dev_fwnode()
MIME-Version: 1.0

On Wed, Jun 11, 2025 at 12:43:48PM +0200, Jiri Slaby (SUSE) wrote:
> irq_domain_create_simple() takes fwnode as the first argument. It can be
> extracted from the struct device using dev_fwnode() helper instead of
> using of_node with of_fwnode_handle().
>=20
> So use the dev_fwnode() helper.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> ---
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/thermal/qcom/lmh.c       |  3 +--
>  drivers/thermal/tegra/soctherm.c | 13 +++++--------
>  2 files changed, 6 insertions(+), 10 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--fm3wygecilpics7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmhJnTEACgkQ3SOs138+
s6GrQBAAsNm3TKyX297z1PynC4dEqHNjhRi9f6sXy1Naf6bD6ogpKRr++lLGad1h
DVFMn8TF/fW9v/FaVYegtZeMbWKY3vHZtxlp+b1d9pRwhHvcJz+QFx/apmcWqJBv
CQ9CX0Ofs+tRc9rFsgHHlg0VEh3i0IeyX2HaTiyxQNxeYl2nZ/BHYNw1Bl/QKKJI
ySTQaTJu1cuWHmwvSkNembec6Q+8Pw86Nu6eXBDP5/+TaYlJSuTNzh8fDN76/UcL
i4jeqt88pG6bjBhEzUf6sVm/uoI1eoKjKaCPQO3hZSX4+K6FcKGM7jO0S6OsbiMn
hkJXnNUNkNDyoyM7f79GsWbpqjKDM4iBhhKjIZvcsGaa1l3rS2WIx/18C90NbWPq
JvyKK4KkgJ1XuhbHK1iw4s+lsEeAkG3Ft8Xbo9jOvZmgn0a9qzp80rx/ALqdODl3
BoRR89TDqEQ5ZUqQ0YK6R9ZWjFSTbpz2pWBspvqYlxEchK2SeV7IZGzc3OJmF7Ny
drEgx1hfhwlC7iPOshELk2RoEE7++xPDWKfHa6INteFnT33o+YDTrz05IoQIt5Mc
ajuQKylSBh899/RiR5CtPfM0DvtzSrJLDHAPR2FaWTDG0rb0PeaZb05kWpC7K3PZ
QfwJhcOtGiLR6OigH+bLtjNE8PkbDDYeadXxd0lgOJ1JqkDKHQM=
=o3tl
-----END PGP SIGNATURE-----

--fm3wygecilpics7d--

