Return-Path: <linux-pm+bounces-12941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D9B960534
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 11:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C68D1C22321
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2024 09:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0A9199E84;
	Tue, 27 Aug 2024 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKO3Ulbd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EBF1991D0;
	Tue, 27 Aug 2024 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724749893; cv=none; b=QUWxG3a2wkO3S31RFDtnzebWwRbi15xm8HQxNa5jBcwofiRNikXwrQ0TjuUseKw4loyqiM2t5MOpsxvguGFNTu69csVQvbgWn69ptlwiwtSNfQEs29oAhSlTVHrWt0JvsLCEs2xeyPQeBV17astJvNr+MVfHJ2p6DnLBPbw7zuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724749893; c=relaxed/simple;
	bh=DODqLfs6RwS0Jfh5tSG/ipEgeemRdlX+cLwvxZ5tcQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkZTrIJQKZXU3zjXvC7cPz9lsH6smb0OEHfPzoR9isS5TTHnppCfJT2ODZyWKuebrVBdyVmtkEE50QYH+/NswJrXBwtfbJg/QuFcCfg3UJ5y2qv751ge+Akre37AXs0ZUFdcuej0k0klJZ0tH8IEqs/vnzl0EeFd2MPCHiKumCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKO3Ulbd; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3718cd91185so2771156f8f.2;
        Tue, 27 Aug 2024 02:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724749890; x=1725354690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oLL/OWzUKjTOsW0yhZt6S0dbj8tspxhqWujNdTE7Pg8=;
        b=FKO3UlbdO0IT6TUv+AbNQckuSrls7Dk3oz0QMTElsxlim7SHl+vzxU70jpwyf5Mdmz
         nQUtVNVtz2m24qmA0UCYd/kEE7q0+c9V3vO8h2HFLlYgdicMYHPsSc+woHvv5cbbuTnm
         IUWHieU1Ig3y6eFV8uCSHZm6a13s/tlFUtiHxF4oak0FPOzJjLZth2atmqGJHqqu2rrg
         Lcic7jXLwP75mOsFoGsQp9aOYhsntgQB2CddgQNYCC1b+yr7Ofz9gwIopUABryHo17h3
         zHnGp9ncXIOVYXwC0ycJdE4J3qTalwEDfigAE8hdhqwVXEyZarRLe9CUZz6oHUG6GHI2
         oA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724749890; x=1725354690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLL/OWzUKjTOsW0yhZt6S0dbj8tspxhqWujNdTE7Pg8=;
        b=el3nIYuw6YKYqkn7XsEyDxU/Q/sINdVIXkYckjLWIcCyTsc8PFht43b7QayEhjwO1A
         4QFMXIHtoKIFauVlYtNDab8i3ZQ05UKF2tRCCT/RXqyE00GSW5uCbI6C7zB4n8LZxi8Z
         nZcZ6cDe0E2mfUlTMOs2UcL8o2JYt1QN7RFoiLumxLoG0FoAOEQGnQ/aDWYChZ/zyzB+
         n5vqZdbRQO+MNsm2lDgtS4rOqUZNAnZMjlw9u8eyV4WFmp1xhBUk2/23Qem250vDGmtJ
         qtD76JDbjkcrSNXtDYMNWG8NZpAlQWYyRSBsxvXMKhRpJWwt2ZgHSfUH4LFlY1ShMJXE
         g/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVNQY8t5J6Ke1sXPBYnJDlChH4215AwBS770kuxj89/6KBigk7Fhv+eJR5/t0Jl55ey/qEd6kZpaVM=@vger.kernel.org, AJvYcCWoC+QsJLKtSz4jE5xxdZe3032UDxDvxY/25sn3yUGOmNhUU4CUUzobrNLs96SMW3CYiTxVincGJx6QO0Q=@vger.kernel.org, AJvYcCXfRDRgckravbAbqF3VAovShuEYBMsc9eCmZYboAF419zFuT9jT0QFxbTvzepCB8LjupkiyB5nFjuafaVaQRSj1W8M=@vger.kernel.org, AJvYcCXk+FnJ77Iz8C4Gbl6MddIheBk4BUM5Tp8reJ/Gti1LcPuJ92XC1j0TpNGW4NaUqP8teCA3aZSKuJL/kfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpdM941xadUSNTfwawbifkGu47oxXrAd56b8pPBcPOT4n9eOnQ
	dg50Av7d8fI1T2q2J7YY5prqJFOQx6jHFBMghRlB5+H/Q1eaonVA
X-Google-Smtp-Source: AGHT+IFi85nyAehGj3iKq2A4If1iHsiwwJ1u4RTXxZEFEGwFqgGILvEaSLhsizpjLBZYAYs/BwQFkA==
X-Received: by 2002:adf:8b94:0:b0:368:3b83:65be with SMTP id ffacd0b85a97d-3748c7d4cddmr1676803f8f.26.1724749889341;
        Tue, 27 Aug 2024 02:11:29 -0700 (PDT)
Received: from orome (p200300e41f29d300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:d300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff625sm12709306f8f.70.2024.08.27.02.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:11:28 -0700 (PDT)
Date: Tue, 27 Aug 2024 11:11:27 +0200
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
Subject: Re: [PATCH v2 09/13] memory: tegra20-emc: simplify with scoped for
 each OF child loop
Message-ID: <42yb4atovunowsvkoamtazfoojhwpkyc6vwkrnfsgqcv67mafw@w4fdgm5svikk>
References: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
 <20240816-cleanup-h-of-node-put-memory-v2-9-9eed0ee16b78@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bgt25yvt622okheh"
Content-Disposition: inline
In-Reply-To: <20240816-cleanup-h-of-node-put-memory-v2-9-9eed0ee16b78@linaro.org>


--bgt25yvt622okheh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 12:54:33PM GMT, Krzysztof Kozlowski wrote:
> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/memory/tegra/tegra20-emc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--bgt25yvt622okheh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmbNmD8ACgkQ3SOs138+
s6EGGA/8CWaIIk0lQnkbDNlIU2D3Joik1HrBL/neYEtOa/brN+ATKxrFDTjKKzBk
wgjiFgo/omL+sQs2WKFPvWSlddttRCU2CnxJ6h0U5cnBc8lOWVe0n1Izp1XMxt5B
dPvYjVeWOmS37pouCUBw7GvMkjz79xNsH64PWmz7iwzbMwTCzejly3YlbapFMXCR
mqNOpPNOAY6jwWJK6I7Gz0mEE4MRMeUKsY/v1+vVpDn8bkMMG2e4xmpli93UAosk
gxa/Uf/T7jqpbtistI8d+zY8tLX4tOmzpIua7TeZauTMbwE+QI3bSEd9C0CRmITx
1RwI3bZTfWyqSQrJNp59x7VON2mA8mBe1kGpjxuLjnoTuLzZKu0eUGWGLbU+vJdM
TXjrJDuH98gdTLbHQtuy50Gnlwg44MuGccxy/sGd/6ozUjPy/Ya++yXsIwr2MPJe
2srxI+yWU8XtbXBH86XVlTa0Ao8XKoIEeQsYAaGQSlaQphHjfkEi8oS79Hp9W3fZ
91++lqyXleLXOBdT2KXP0VWTBObEz9DofoyKNsvdwz+vRXrZREHYavhr3uwUm6Sz
cmZ4IxbL2BD15ixS/YpP2hA2Au2nL2OfdFBnC4JbXXA0dQVgYJRvrzLIJSMHTXVk
WQNWu4Tzu91OvNjsPO5RYC2lDRHCm2jwEhfiwwZmjpTn0HizrIs=
=zKjD
-----END PGP SIGNATURE-----

--bgt25yvt622okheh--

