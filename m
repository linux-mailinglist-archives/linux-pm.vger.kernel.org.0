Return-Path: <linux-pm+bounces-18379-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E979E0D7B
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 22:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69AECB26E52
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 20:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC54B1DED7F;
	Mon,  2 Dec 2024 20:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wqpe08Np"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF2F1DED7B
	for <linux-pm@vger.kernel.org>; Mon,  2 Dec 2024 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733171897; cv=none; b=XUC4obBHLi5dV0w6dMGAsnG5lXWT9OBCLxBV4QrwJzPmoupeIev7pFZ0jJfejWLie8Yk8sXh243T1lVy1bL7zlVxmU0pbKSYWYLoLNn0DBcUsdPn9EMSE++Z3EXdZmDLvKJFa/W/yi47xAZsWLyb/bT0PZSBeMqK5klqOKFdUHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733171897; c=relaxed/simple;
	bh=Fknba/O+ZHWgcmf+uvpRQRxG3dSyqy07apcpBLYjnA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/soWISlPrw1Q/omG/a7iEuE4zeW3nt0VEDWyh9MD7UgTvD20yBPvBe6j9ukvKjLM/mFmhZj5IG0BaY57YBCQNKI9SwtTCa5MGeuOOLGQN7PlYbmd2YeZanHJQgJ5fNsL1HSHqfkCDFJgm+3xMwVGQKfuO3Ph8/GP7jF1mtlHfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wqpe08Np; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385de59c1a0so3351653f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2024 12:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733171894; x=1733776694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0B11LnLO2cf8eL3FiCrq4OBSETxAhB6ivWgjWwx+o3o=;
        b=wqpe08NpeQg2IwUehmCZx0IzJ6NwGAXOmx+PwHJJ3fyFUy+jrVE8YOaNTgqNx6BLgC
         UEBwWhkb1vvzRC8TWXd9HDI2CMENFUEck+tyFJtM2M3kPLSNERRxu8k5GUmD3QjcYxGf
         IT/gUzkGEg3wQmP8xmzBMI6CvrXMkGfXwTHvSgu1jjcZYgYkXT+hJghWA4Xr4kGtZye4
         2mDS51m00UjwEzE6KJOJCMjziE1hj0e1/SVWlyuWMYykFX0ByHx0aeGQLvGpw27gFWpY
         kILze9u2pUDQwdB+LbtL9sX/yx/1njoN9On44ueWJaXWIhr/kJfbwIgfNAmBib/n/Ewv
         LkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733171894; x=1733776694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0B11LnLO2cf8eL3FiCrq4OBSETxAhB6ivWgjWwx+o3o=;
        b=N1OsQYMjvYNIoCSLJFxJuWlzKZxyC0nHsvyXM1lVB0tngK/NCLVA298a7cuaBKck4R
         MN0jZ1uYzGXMinY8SGN03wYUq12u60LKxjagbPH7pZJ4IkXbQ75atc9Qr+XxzQLEZEPj
         ukSAMOSmOuGuXFDNfUXbr3R35LPK8SYQDEkjuRJqpKCmi4hgL5FHH5iFGN3zQ53aY41E
         eKAzpstl2SzyXwFNgULQHJb4PKllXe0H5llJkWbLEtTmWXPWBbr064hKrzJR5WSwbe2e
         1L3+twwBs/CVEukDk2kd/bTx/TjN2phayopMgRgdCt0jZFLx8lLbLr6g2ElXF0HHA0Jh
         XcLg==
X-Forwarded-Encrypted: i=1; AJvYcCWcfTz+O7w8XYGTIBal0dqRXTdC8JueIcjPKgJDor997p05yE8/HTCQJoUlWTNwg5aXkzopnUeonQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwCcrqaT8OZ96fP1zheDvOhs1vALkhyxcaUuxB1+O9EKw3Km3w
	qsE3mKunuF1fBzebIrPlmBZnkELn8aqjhVmCHTZ94ssuqvdZ4WeIGu+7vxOAXnkPkHFNAEW9sAm
	V2xU=
X-Gm-Gg: ASbGncsYiyTMQVlXZ3l+OrfBbLhHKE8WTJLsdv0JfK9WHVOJSuseSxOvp1O4/90EdVj
	0Y8u3R4Ec2OvNaz/74w0Kg/5g2C60NSfMfhr8dFFWLNIKGltJGPHOw3mPc9htHYE0Tvo5KWhOVc
	cEpDGw8w3/Ogj5ZtX/QOx7jHgHua7qZw698DZ+8FkH8tvCZuFj/2tXKsAJtDgKAxHt/DrjYUoHE
	NMTMp91yrQO5rumzTCpJm6OxU5unNI95+X70JV0BF2RueIS2H2CpWM=
X-Google-Smtp-Source: AGHT+IGe28vQDIaFIgCC9RenjZh4P8td2rpt6P0oSCfNhYVmfcSAwCHxdXrQlDqOm7zyHYBCcHYvBg==
X-Received: by 2002:a05:6000:2103:b0:385:ea2b:12cc with SMTP id ffacd0b85a97d-385ea2b14e6mr6583684f8f.13.1733171894207;
        Mon, 02 Dec 2024 12:38:14 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:8b46:9e8f:6651:c738])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e9fda2f6sm6530162f8f.107.2024.12.02.12.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 12:38:13 -0800 (PST)
Date: Mon, 2 Dec 2024 21:38:10 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH v4 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
Message-ID: <ktzz2btcxjlt7l36k7pgv4widhw45p44ol4hr2kjrf6ui62fjk@2yfvkmvdyk73>
References: <20241202151228.32609-1-ansuelsmth@gmail.com>
 <20241202151228.32609-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7dl3rip5k2ligpjw"
Content-Disposition: inline
In-Reply-To: <20241202151228.32609-2-ansuelsmth@gmail.com>


--7dl3rip5k2ligpjw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
MIME-Version: 1.0

hello,

On Mon, Dec 02, 2024 at 04:12:04PM +0100, Christian Marangi wrote:
> +static struct platform_driver airoha_cpufreq_driver = {
> +	.probe = airoha_cpufreq_probe,
> +	.remove_new = airoha_cpufreq_remove,

That doesn't build on top of mainline since commit e70140ba0d2b ("Get rid of 'remove_new' relic from platform driver struct")

Please use .remove.

Best regards
Uwe

--7dl3rip5k2ligpjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdOGrAACgkQj4D7WH0S
/k7a8Af+Jt0Co+uy1yD4dd0JKMWk5nFPZ9EBupH+eH/6sDuFh41r6Ix3P/famD6I
5R6dk2u0GZhSnD1Rw6JODUjRNDMkOZfE/IdYaaEpUKzgTb9BOCmmBksklEibsWjL
2jVeKhcE78owqqoytj0iR1zRFHhkegNsOjVeJ9UwG9urS8vWkX0GtyhziI5HVUAR
+MMhdMAyHT9Kbmi0q3zHbJNtUgb1CIdkkw3b0oBzoDbvvo8yWiwprBTtG+J+yc5v
gY8ZEdXHlPHlWLSH4ca9PgU/tbhAEQRXSMqxQg1Vhz+kYH6oic9UJXMzlSlHVC4T
qWhB5WgLJ1a8G4pireyw1QCOY1X7hg==
=E/Mo
-----END PGP SIGNATURE-----

--7dl3rip5k2ligpjw--

