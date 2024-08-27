Return-Path: <linux-pm+bounces-12940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2735896052F
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 11:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34A51F224A5
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 09:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FACF199E84;
	Tue, 27 Aug 2024 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eodajGR8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D50194C62;
	Tue, 27 Aug 2024 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724749877; cv=none; b=lFaZw98W2M1uvjTWOOBsbqWTUI8zcr7ymHJkjity/Rw3ePnz+vAmL4Vu0IeZxJwsEa1gUOhO389iFIDJLCLdzP4Mj5dIODKWpUvzXgXzrffyfBGOosE08ZhmD1VIpns/XJpusGiWgpJaHJap1rWatuTdrNgoOAeMy7xhhC7J5ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724749877; c=relaxed/simple;
	bh=46E6MxApCgonw1+z2d3sF9kGIQDJxrNgSDJyukj74e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FA8Pa4v/v56QC3Nqi9ZBOTIoes+b5skO2dLtsgg+fZWrr9u3JHVbUqqKvnMUThjn1CrMB8rgHRMewTcGEyGoQzi+yaeaOXY/7pl1RHaFo9Mk+QpVJ3adgWncox/geWBRbSlGiEHTqO6DHYW53MOFb13KFpy0g7lmTkHz/xkHvN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eodajGR8; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-371a92d8c90so2738827f8f.3;
        Tue, 27 Aug 2024 02:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724749874; x=1725354674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0I/JpqJzipAkXM6wL+TWfoJdVWaz6dbadmPUfGMsRt4=;
        b=eodajGR8+2GG5NlMvPL2GXaTZvbzLWAgWC9ehPyYMybtoSm3KNJByyLr48oDbFthsF
         klrAIC/OAYi7P3+5hcpe5XIvgEoXYkoOZppKE6RfIJEKrjDYp5fyr1DtelXfxQEBsVix
         D6yBV4FI7Ei/ckgr/PexSSuvDTNZOWLLIptVPjhHSqVTIGwgUh/EZ9a8X+pfMPejpk4x
         MYDvvY7U9Au7JHcBq9mk0IhxVjtB0c/A74brfGi07tpyat2N6JZGFw+APGZ0h9xAC/T8
         SV/TobnFqapQ+38rVrju8DDDH/ZU+AeK029idE7LIc0z3GDZEif3g7mkmnjSXknoo2tC
         n0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724749874; x=1725354674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0I/JpqJzipAkXM6wL+TWfoJdVWaz6dbadmPUfGMsRt4=;
        b=v0zdr/bnbqQP2dYYZR+GEThwMMPToaKvB0bhblDF3t1fXghtO98GwUfNy1N9eN/QG2
         AuMRg/r8Iq0Jh8OmdGzRyb0ht7SI/ogWOrBWHEX7z6hyWNUP8wS+ko+CnY9F9n3UP42r
         p5BcRo2/557WphFe98eGb7785toLH0paWKMn8T6v7gBkefYcPwUzTTYSgPO9YbG7c9kg
         lB4n2mjpL8aBVQbb3wakmQCyu8MscWZh9iLfX0YB13NeYZ2IWoBzPDobFVhr3DH74Ax1
         DMKls8tyKpj8W5E1RTC/RUskKQVtcyIwmnCbAKQQzAyoSBqwF3khIhfhEMgRMJubkE8/
         +xCA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ8mytA3Z0ZTKy5jCewUcKAy2UbUgx/kPVig+yMSpe9cKehzZaZKDOtLnq3PVAF7p+wdolfEXQrzvTmxk=@vger.kernel.org, AJvYcCVeDu1tNNs2FJS64LcU/MB/LTzD+uXitegjFxBJpOGdJPxJ/9sxJqCjiZz1wsulWHVaCUV0ZGGU0z/oovo=@vger.kernel.org, AJvYcCVpohjFj4U17es/BzpnACTJn2/eVgyL6uGQUYXPVkLGJtfD4//9dodm0aP/DTaAYKxEMC08pDMjosI=@vger.kernel.org, AJvYcCXyf1mOZH4Ls9IbvG9RYYkwHhmd2vpsBcJGCqdpPQNIzCLGTXjnGs4mgwamrb5qT4ge9VjXIV2bfripMIld42NGGsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFxDw/QypHmC/8EF82+Ga2EXuRhXNvOtqGInTsiitZd6P9PKZQ
	BFRGQW/7XcDgMwcyYLjkVmWRFCneyYE7UQkvR1HXR9cR6QJ5o0aO
X-Google-Smtp-Source: AGHT+IHOiX4Tzf1QO9DjykBfyZbDvLfL/SobHET/spkyu7r14E9kiKLxT5XWL3vDXYgDgUX6AnUsGA==
X-Received: by 2002:a5d:6885:0:b0:371:8bc9:1682 with SMTP id ffacd0b85a97d-3748c7dcc10mr1403639f8f.33.1724749873613;
        Tue, 27 Aug 2024 02:11:13 -0700 (PDT)
Received: from orome (p200300e41f29d300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:d300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee86df3sm216660775e9.14.2024.08.27.02.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:11:13 -0700 (PDT)
Date: Tue, 27 Aug 2024 11:11:11 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Lukasz Luba <lukasz.luba@arm.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Santosh Shilimkar <ssantosh@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 08/13] memory: tegra124-emc: simplify with scoped for
 each OF child loop
Message-ID: <jrj5ymf6vc3my2dhjsl6g3jaseandjxrikzrjsqzcd4ajgw4zx@fh5habb3q3fr>
References: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
 <20240816-cleanup-h-of-node-put-memory-v2-8-9eed0ee16b78@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bumvdn2lofdrx2cq"
Content-Disposition: inline
In-Reply-To: <20240816-cleanup-h-of-node-put-memory-v2-8-9eed0ee16b78@linaro.org>


--bumvdn2lofdrx2cq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 12:54:32PM GMT, Krzysztof Kozlowski wrote:
> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/memory/tegra/tegra124-emc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--bumvdn2lofdrx2cq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmbNmC8ACgkQ3SOs138+
s6F5dg/9HZ95wNQyti4jz540muOA32uILZ+MyqPBkamtGTM/oa4DJwzf8P+LuwFW
9HM+43nKflFfKLrEK9OCf/0vqBOuFWcP3wTIXGvXXK9gH6Id/IUc3fzkDmVTRW3E
aoQ+3eu98h8XjDuerN7Q58l7vUmabCpsNohrs0S+wvUj072jqZnLStIVJITVV3p9
DQK1jt1AnA/iveWm2YaFNJXpVaw6hsHKeLH5Ge5hJR/mRJ23PxiTyVo/ThC5ztA+
z0joYHmoR5+voCZrFWquBjYcD77fe9k+jrzAq2HNesgp7aPAsdTPo0kl4mMyHS4t
tHsl7Ubzmq3AebiVgujulJusn4RYQiKKLlydDZci+1v4qq3+77WETU04ZscR8t+1
NALeYcc+2ULOsOgjPQjhrXCKTqWvuRi5xaFBvHvshuN9MZAOpe5W2ZG70rf1b2wi
yUh1U8LvcGGXX/D/GKfzzEiZn6m0TbKFFFA/R2XIQkM/34ibUCU4jJJCNXjBMSVG
9CBh9lurYwkPHvoI2aE+Xr5B8D57UezTJKKUOBA5VnfjmltMwDBrSdXxV1cs2PGf
A+R1lT7Pz1kz3WGVzgL9M84MmUAF2iRLcCk7mVXN6INzJROkGiI8T3/WnTdmJ18I
e1N0hilhIhW65jF03zOcpGSiSEe8lnmSpE3OO4IqrIxYx+8iCAs=
=1QP7
-----END PGP SIGNATURE-----

--bumvdn2lofdrx2cq--

