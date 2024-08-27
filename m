Return-Path: <linux-pm+bounces-12939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3260296052B
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 11:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76324B20B60
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 09:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA176199EAB;
	Tue, 27 Aug 2024 09:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+MBzs9U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29293199E98;
	Tue, 27 Aug 2024 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724749854; cv=none; b=jES8CxVm1HRtVsLz6wZohd52sudq7UJFRjDUwLyt3oeZ78FIE8etyQr7KKf++Ee8z4L1kcWU9LKkEWlvhfaZa8Uu32fZQzL5vgCnZpapUwnaK4Dr9YwabkE0TMDsQyYmn5dgvyWnsJjn26YXZtKkI7J7kiV8g0bi4z0EBE5G+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724749854; c=relaxed/simple;
	bh=Ph0NMpctBBMJI2VXAYQA68VEoEvGhK1dxZSD7BVeu5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUzxl0zd+Qqg2zhMwLcVkM7iVfuihJ3bbG3jigct/4G09ryojpLQfIz8PCouObwRIEUiLR84dg7xSrG8siySe6mjREclb6T8Jp8gORUHkTL7/Irc4kR7mZQli5NinMbCEf6JxfnVhp1V9hlbPDOR2JuR+gUbIxD7pWnW+tX2QcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+MBzs9U; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-371b098e699so4172510f8f.2;
        Tue, 27 Aug 2024 02:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724749851; x=1725354651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fUDMwSOVzCwin1tEwK4cDn6YsjG1LnqHU+GKwmkIe50=;
        b=A+MBzs9UkMAwpKzmpnQDtqDMdCmiIua0P5+TO2+uPQj7Me9EbpzXcq+Vm/3I0HP6L5
         x0cEtpblD2eVw7W+lJ6vvnjPO7oGBPq+sKZ31LqBVQMmExhUnAtZJvUmUKRO5pM8UG+V
         PFAnlPZVX5DEdRryN3PJfXf8gbSk60vqvqFlXx57tOAXksJvCJTdlei1/rnYa5T6ogZr
         MxXOTk9ezgbo3jnVppjGwsCVT/swEiOPgrPWO/qVAh32KfzWjkl3hqyWiWQeaEYsdbYJ
         TDgsFOqE0d+AgWYlyalOnw41d+HIbUUKhc7gwy7GqRPJ0OmjK95wdfcxqZiF7KEkhiw2
         w7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724749851; x=1725354651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUDMwSOVzCwin1tEwK4cDn6YsjG1LnqHU+GKwmkIe50=;
        b=t22mZC26QnrXdjMcdLCYvZ/F1dIUFkHqbEKMlu0A5oDVzH4FZeYOVGYuFjt+0larvi
         01gCmRh6LKfSfeBqIhwZswtTS54U4Gonzd5YWbjDEcZMrxE938P0BpqtnqCRBgc9lARU
         Y3DJbi2i2c3SKyoC8slfK/XAijheP4G4B0ybHzv4O73OVPXv+ToSCyLcaJJ0ThpH2SIA
         FGqOmi1EgWkGa8QKBqaAvEjczIQjxYUPm/2Ujkb4UQGI29AqVB9DZiu+Hxo5shUsCJpO
         ejLg64RREaoyv8TMUtsYEWyjSSi5F2R8AvGt/c+e3gB57k+Q5nIIZ/W6eCLvJhWCMXB3
         FyCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpRVTe4zC/tAnjtTyOrzf/yvqGm4268UmSyRWfnJ/fx1AiEbO7+Hm8e4/S6Qk0onmopVtpw+Fd+20AZ6x2XmslOp0=@vger.kernel.org, AJvYcCWJBPeByA8g5Ul2aoUzOiiuhSdT/Kz176tRpDlSjLsdl1TyOFfI1IlkuBda9HfFYIVvSNXu7YW03BKejoQ=@vger.kernel.org, AJvYcCWwWvv78XgI5XlzxwO7IdK+PjTMXiG2aKDyueAV3bRKxbW2zt5q2KB5/WPdgQj9ru0SyNFuEcWDtEw=@vger.kernel.org, AJvYcCXT+Bt1UADzm8bOSBE1K1cZnrHdqD6Ow3VHmcqu9lA3V5ZH/QsonsVXfOjJxN00VMLmqsdSa83bi2vtN2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZpjRLpPt5ZPORneWWhXT4X1M9iYKeasCKjleOaVrs72iI2IAA
	3fVuEeMRkzTx7x6CibfgrRNz3jyfJdryI12Su90cWif7B18nU0ihg5BStqGQ
X-Google-Smtp-Source: AGHT+IGYtoHYOJ2PcFSTafy/B2ZibGnK7dhVczhUYYtN+TBGrut3NSlAXIamQEahFjD3bsCWtNx5fQ==
X-Received: by 2002:adf:ed4a:0:b0:36d:3421:5a23 with SMTP id ffacd0b85a97d-37311862d8amr10260081f8f.26.1724749850865;
        Tue, 27 Aug 2024 02:10:50 -0700 (PDT)
Received: from orome (p200300e41f29d300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:d300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730811001fsm12590489f8f.20.2024.08.27.02.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:10:50 -0700 (PDT)
Date: Tue, 27 Aug 2024 11:10:48 +0200
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
Subject: Re: [PATCH v2 07/13] memory: tegra-mc: simplify with scoped for each
 OF child loop
Message-ID: <lyuvpbh2zx4hhqrcwnc2xearyekttfcyn7jdt2eatkpew5dgwk@jp6sopvdng3c>
References: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
 <20240816-cleanup-h-of-node-put-memory-v2-7-9eed0ee16b78@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="abklfs4xggqotwky"
Content-Disposition: inline
In-Reply-To: <20240816-cleanup-h-of-node-put-memory-v2-7-9eed0ee16b78@linaro.org>


--abklfs4xggqotwky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 12:54:31PM GMT, Krzysztof Kozlowski wrote:
> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/memory/tegra/mc.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--abklfs4xggqotwky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmbNmBgACgkQ3SOs138+
s6HLAhAAi/EQlm5bG5bcOINffasOb6M7H/oNaZ63dq8ZIqrgswqUPp2xC9nGDqM4
Q1OHj25oegvp1694wFJl4yi9qAS2ECKwd1p8Z0fwTos6qnwb/ld2+RQWWN248uXy
/On6/enVLCGowDmeF6246lFqPsw8beIbLc548MwImyHKnOjkoPcmkDhhH0rIcfBN
t/Bhvct5nwgkvl/+7QDMm6b6/hUsLzD7t67S+Ht5gI8ZsdDqqLpNGSwePcKtVwOL
JjZOBAcQni6LV8ksFGjih6SHY9qfXilN65haVGLkgGsscCgeYMBIc3Jd6joKjVGD
YgXTHTYbrqrGJPFntZnT5TX+3x5uUx+qwedKQGtv1mAvZaLqv6HtoAsuXtirs9pT
Ra9v0l9R7P0wdZ2kya2Ddjpq2FAEA4F2jsf4vu/wrYZUIYND8BkzUPu1VjWmrSEi
YS6efssv5Q1A+3lCoFhtPACUe5S7e4SboZr0maW+GR8mCCn41qwfKgmaPZqoVYEm
NIyvB56K6p6ojafQJkj0fro2+t87NWOlfA7hIC1buWyoeIfOxJIhT4pU3ZWux8yM
STj3cF83Rl/dEg0I+/SJCqPDWOTFIunGyLYjVQZBnq5LS4HPsfRXYZkm+okx/6LA
fkBTbYyNPRjUuI5jGJnNlmn9r9nrZDxe1EvaN6EKJRWY8X7CTqI=
=WUPZ
-----END PGP SIGNATURE-----

--abklfs4xggqotwky--

