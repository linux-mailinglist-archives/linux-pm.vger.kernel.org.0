Return-Path: <linux-pm+bounces-16053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D629A54CD
	for <lists+linux-pm@lfdr.de>; Sun, 20 Oct 2024 17:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 558C6B20F34
	for <lists+linux-pm@lfdr.de>; Sun, 20 Oct 2024 15:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E933F193417;
	Sun, 20 Oct 2024 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ySIUH8mR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D421DA21
	for <linux-pm@vger.kernel.org>; Sun, 20 Oct 2024 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729438970; cv=none; b=EB4x4FdHoJpgDG2phpVz7gEQSLesU2s0R0Vn53w8zTC/EIdjx7ap27i/ihahdhT7WtJuzrfaZrDRoXroxSGVtysgeQLEfTcnKBngP5ZXYXLlyXWv6MzW1Y9zGqLCMiU4vezIit1mUrtU4GY3hqE9EjkK5h4zGThCT6vHrS5DQig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729438970; c=relaxed/simple;
	bh=mrrbItg7Fa3vwJSaxoBFSg8BtlpbfwsZ+YE9cz19utc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2jMkk7D380Kx5u63Ufz6iQFBydchFPNNjkahdIjbH9mbDFUZTo8x2dKkAxX4ZRS1/35kLm/Ab4+iisbFle6JaEwpyO3fmWvOK5/WuAYHTDXbDp7+aKNmhjEkYMttV6/40RO0Pg5uEzoQ7F3rfwYvLElOe5tqqq/A9zbuJyxLls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ySIUH8mR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99eb8b607aso372777166b.2
        for <linux-pm@vger.kernel.org>; Sun, 20 Oct 2024 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729438966; x=1730043766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mrrbItg7Fa3vwJSaxoBFSg8BtlpbfwsZ+YE9cz19utc=;
        b=ySIUH8mRjEmYLx4IB8m8HDo5/h8EmRPp5KdVNUkRDwyIsMw/bLJsBqVf2hKLTOKB9z
         ZG7Ew3R4qzPBvNZjctsV9LI5WHFVGG7mLInlocs/NNn0tTpN2GDqs0D/23p5c4IrgiSZ
         dZj9Lw8EjMXRTyMu9u0lJPIt9dwEQM1PccgmdK2Fg6w1ZMKGeATtHyRobBobNup+p2qw
         73Xcs+x24kR51Hnz6nsXpxdv7gMRceJXFNWl4f/Zwfh4pG/4JuWTIH9vy/Y1+IUSUpDg
         44aLVNAX3f9G1YcpaX0slZhR+8DiyFHtfOFD3mfucWCCXbG62vuPTQUZOw0uyei0RrKY
         0Gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729438966; x=1730043766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrrbItg7Fa3vwJSaxoBFSg8BtlpbfwsZ+YE9cz19utc=;
        b=UHQHXK3QoEmh2rPflEBXm0Yh1VZ8YeD0SbcFU1dcQqShY63vmEzert/XCxl6k83yZm
         8VoeV52YTg8k15eBiL/CcbwxCqfUwLe8qCkpYa3d2x9zrE8uN09SaOax0be3nHkGoBzY
         5otNIXjXLZSObP45ESmKA8gLGIFIctduke5qAmPGaoc77JKFbkKUyBQ024A8rJ/2X/2W
         c/VOu3EyrP8udTF8WE1suwk/gykUjDZIbjnPn0V9Z+ThhnNbeIqTSnzMoYHh3FfltpHB
         GeWADLUMGQ7km5AFxf2Agv+UgwnqSKZRuHYm0K27OhKCCCmx4R2X90SCUuvCnleR9Zni
         M2UA==
X-Forwarded-Encrypted: i=1; AJvYcCXPylFLrhOBR0Chq9z+zQNEKdYRMJjkaHkB1iovcz1Y7/fHtxFNMiDuRbnZqc6lpuZ2inBgPXdQHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVtneOH3KXfrMPyHK66iCqwabRr9Dtq1kDXYFMLtu2qXZmaSnK
	HDo1QIBBJR3gShTdOThJVNCpp1abjDIugMBjdj6+ULYTuS4YjQ8eUTI3R4mxHJAx2njaw/8M6go
	D
X-Google-Smtp-Source: AGHT+IF6IJk1T6or/XVP4cIGVd1E3uyM7kluwzpSDn1ZEuSroTV3F89va7ZHyWQyAiJFhlaWtZ0T+A==
X-Received: by 2002:a17:907:7f04:b0:a9a:1585:dd3b with SMTP id a640c23a62f3a-a9a69a680ddmr815339266b.21.1729438965548;
        Sun, 20 Oct 2024 08:42:45 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:2fbe:bcb5:676d:98da])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d623fsm101754266b.9.2024.10.20.08.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 08:42:44 -0700 (PDT)
Date: Sun, 20 Oct 2024 17:42:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal: Switch back to struct platform_driver::remove()
Message-ID: <xrrogvkxtepavpmxnfj7mlggv3lubrgzx4jobdq2rdzyzduczc@kyatfjnrb73j>
References: <20241019163412.304422-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pkxywnfv7d47k4dd"
Content-Disposition: inline
In-Reply-To: <20241019163412.304422-2-u.kleine-koenig@baylibre.com>


--pkxywnfv7d47k4dd
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] thermal: Switch back to struct platform_driver::remove()
MIME-Version: 1.0

Hello,

On Sat, Oct 19, 2024 at 06:34:11PM +0200, Uwe Kleine-K=F6nig wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
>=20
> Convert all platform drivers below drivers/thermalto use .remove(), with

while using this commit log as template for the next patch of this type
I noticed a missing space in the line above. s/thermalto/thermal to/.

Would be great if this could be fixed up when applying, or should I
resend with this fixed?

Best regards
Uwe

--pkxywnfv7d47k4dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcVJOwACgkQj4D7WH0S
/k48VwgAgPgBaGfPB4Sexo8gle54LEQvWIAeSg/nVXKMbePE0FFNyM1Kamz2ze+z
WAGRh2v5Dv34Qs4Oa3Z/UwprHIfqT8tYylWwZtEdo6J6OTq2XkCdf8oNgRLqlNPA
O9oTpofcuUxl1hmQM6bikDuLaL0dpd2ZQHSAVeOSqrAqOiiueaHYra9yBmv35n0L
jT/mLWFepujpsmPSGCWQtfogKr1mEJHK7iTFVbMoTtbyot7q0dK5OkRK82JqQH/B
PPryONeS1bSgg4KWNfBKTNr8AXeDHbYb4bQnOrDSR7QR+CM0mDY8OIXyYeOcWbdy
Axc+ACJoJJBSPa8pYwQkP164G42blA==
=kwDH
-----END PGP SIGNATURE-----

--pkxywnfv7d47k4dd--

