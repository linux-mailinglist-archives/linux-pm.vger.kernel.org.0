Return-Path: <linux-pm+bounces-38037-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5C4C5D532
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 14:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ABA22349C48
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 13:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB58313E04;
	Fri, 14 Nov 2025 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/kVW6YL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA730C625
	for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763126244; cv=none; b=IDYz8IJApJBGHRYwm2LQ3D9ReV+mbjai4jLjJWx2JqQg/YBakgnfGjHWOrtrVwawVj7b6bA9ASWs0gqZO9sjbPy5BExMjKRVGhNf3+eucZQD+DDJz7X7OkdWHxkKAGyvlHa85dHtI9CAgutrHbrekMdVYUQdpEfpvhiICXZfpog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763126244; c=relaxed/simple;
	bh=l14bAdG7sSenVgnTvQe0fC1UGWAoSkEFo21BRNcbNGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHTqRsXLpwMih7SZYwakaveCEsvyeoX5f0GGIoqHKLMQTg4O719ZtRTLVPsyq6M9iwuQ7Rx19oYxKf0kn3E1rijfD9p7epU4kTQrawP93L1pejH4WQnyLVkBKlii0NVPCv/zqtqdTeXPpXscpWPwGvJfGuE2oYrilookBd5tvUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/kVW6YL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4775ae77516so21957275e9.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2025 05:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763126241; x=1763731041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N0TpL/uQKcXjj/1P0tKp0hA2j+bgPUGaGAw/0f/W2wM=;
        b=Y/kVW6YLdkdywKyhIM5phM1gGda9DINj9qS4DXw30LQ5eYeEqHRgChAK8ONNgwR5QF
         JOUz0yZwVm1lm5HJARQotOK1y0f55d/vjXWNuBBzy+tW8bSUoog0PwPejhIaMBNQewQ9
         ygEsmjiKo/RcO++um/7Y1DsF9DuOn/WXzKETFNrPyi+SNFKoHUeP2+BxnG1tNL2U9fT7
         LExRYh9WvHgmd++CD1yIIp6YaHK07phureTHNU7tUxQhj3FjCwtJU7q4ZPSKOL8o9Zt8
         PC94lG1dDPrtL95xWuRgoInTytnsJ7Xvl2qh5yAtYnJkfHzRIZtpLn8p3+lRFCboFRVD
         ShLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763126241; x=1763731041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0TpL/uQKcXjj/1P0tKp0hA2j+bgPUGaGAw/0f/W2wM=;
        b=tkCfkxQljb8eZcenOSoPoMgxw708Acyw7s9YzAjMhZlDVY7X7+u3fiLGYg3xQByr4W
         Zm9aCz4Pe5k8BYay5XUPeyu9LfmAKW8yQalUrfBsIbiGDLVRHHRaCH+6Wvg2uUQ7asB9
         ZyCQRqNCTVeansyk/a0U1QNPvpMWT6XvyympTAf4+spXl/tDcwdgi0yUosd8X7WMxzdq
         fvsKWgygO65AP0W+L+ti/xBD5OlNJ/nwxeJMni/y2bdp4t4+hqep8XIfPv4SSjXjqtha
         Bu3w/3z3MMg1yfsF6RjETZMqhkaBEO3GP15FcjVwCFrujd59dJ7Yxh6p7a77ON1lmWVH
         XdcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4UswH3APVvdzYzyKxFCSPSTc2UCXyE6jxs4xKmE6FDXxkJ9PkdqOatrewXWDQ30AJcbG2ZJ1a2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdCEz6MohCimb4il9Er99/1dADlxS/2X9fm6cobG/1nmRbcvSB
	+ExtNt3gsU+GjLnF8GaDDZ6V1Rf6UsYs+dMKh5pFbTH7AQY8KSnrBe9f
X-Gm-Gg: ASbGncvWwBWbsF0DMbNRuZs9NxVCKz7omOELZMhWFE2P1u2O9abjyR5L4IjW5nHXkeL
	hkVmy17egxoqaokH2jj0Od/pY8eskPhoHKaBWom2+/r8lH5PhCgoNLWyF4nmW2eLU6eGbsdugwF
	tEHkuKYCfapoqMKN0vSQ6icERWraP+NMuPAzck1cIsLHXu6nrzfgGaOM6l5qGLQz0Dwk1shRNnZ
	v2/or2NZ9gxsEYGbrhfHqF9kFV+9U8QXSZBKY0NmpMyMFX3DQSlcuI97PqaIHPP1eu/CVtQ7iWh
	8KLT+hk1MNeJmOKE86QhpSgENpeuNeFEiSKOqaTYaclwPbBoAx0DU7QhLM6GOjJcU1w/tRt/ENW
	W0B99mjDD8BDZnuStXjSrVOk+1rPyLVv5LixNgGYsUbIfWo9IHeIZG8z92Mv81pVsvUUsL+wVer
	OKq5T3WVPvRqKQ1aqFV5T1g0qY+nfxXmzFNl4mxyRB1z6+0AEvOV6FtMr8yUvpvEE=
X-Google-Smtp-Source: AGHT+IE9bBUs5+fK/teaotf1hwhzAkTnpdK+HO3WDqdKR+mWJDdDdywb+mQyN3FtSPr5SthQHUQsmA==
X-Received: by 2002:a05:600c:4695:b0:477:7b9a:bb1b with SMTP id 5b1f17b1804b1-4778fea681fmr33855485e9.32.1763126240242;
        Fri, 14 Nov 2025 05:17:20 -0800 (PST)
Received: from orome (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e43c2fsm141848115e9.6.2025.11.14.05.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 05:17:19 -0800 (PST)
Date: Fri, 14 Nov 2025 14:17:16 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 11/11] soc: tegra: Simplify with
 of_machine_device_match()
Message-ID: <jhrvha3ytpt3wqvyfrlt5zirfnnnijssrufzg6bc4cfah7ahln@wxnnrdv3qbid>
References: <20251112-b4-of-match-matchine-data-v2-0-d46b72003fd6@linaro.org>
 <20251112-b4-of-match-matchine-data-v2-11-d46b72003fd6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3uqy45lsar5fgfon"
Content-Disposition: inline
In-Reply-To: <20251112-b4-of-match-matchine-data-v2-11-d46b72003fd6@linaro.org>


--3uqy45lsar5fgfon
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 11/11] soc: tegra: Simplify with
 of_machine_device_match()
MIME-Version: 1.0

On Wed, Nov 12, 2025 at 11:28:56AM +0100, Krzysztof Kozlowski wrote:
> Replace open-coded getting root OF node and matching against it with
> new of_machine_device_match() helper.
>=20
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>=20
> Depends on the first OF patch.
> ---
>  drivers/soc/tegra/common.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)

I assume that you'd want to take this through the DT (or some other)
tree, so:

Acked-by: Thierry Reding <treding@nvidia.com>

--3uqy45lsar5fgfon
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmkXK9wACgkQ3SOs138+
s6GJEg/+Lvwv/Uc4dUYUzG/6oY2h1PdiGuJvJA9YspnmST4S0yhN92w4uF7VktO8
48OfDwxqJHwx3SDbrqTyuzmBBpk+vUOVyILkxEFHIHHfU3FSie3o3o8xQ1reITF5
xRkKWVj4drW/J3lr7dXETpSnaq8ASU9LbXzjA5V5WEZIjvOwEDTOiUtjycoL+dJN
EZcP60yEeH9WZqPvBNJcDpppUFwZINIUJ41aLebwav40cxSOr9AWGyaIoirg0hAC
4B5FfUrlvpG6uToKYAI+F8onTpuhbY7ucFNx420eOkY1MfcBDx6CxL2rATwe0wso
U9+7SRCF59hiIZLQVvPj76JtLjAVrvmfanOKa5J2/Y/2vUG/3PfSdzCzqXykmv3i
fCsdqHqur0RkWwjayS76p/QSldpOQszoGL4Uio2k7u+RM5SXEA+E1im8qq7ed2+N
0XjgaZjOoGP24Gn+V1UUyD04j/IjPm36o1hHwa27wJnEf33rp932nOQch3/T0fA+
3MERBRP+Px+jXOgg3D3F/gzJa3Ps7rRNp3XRHmv4EwjSMU1Hoq9ePdT38fW1Xl0o
x+gIeNWpWoVeI7D+3OfAoJTthFdmNVUznKco4qxwigLQnoGo1s0Id7hRygTsz1fC
MGSxHO88pn2zCtJqXCByFHjVRYA+y5zQx0zB6IX5ndliVu/HM3k=
=GzNq
-----END PGP SIGNATURE-----

--3uqy45lsar5fgfon--

