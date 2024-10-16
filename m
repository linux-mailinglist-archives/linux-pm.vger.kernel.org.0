Return-Path: <linux-pm+bounces-15748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D94419A0561
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 11:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B03D281129
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 09:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCBE205157;
	Wed, 16 Oct 2024 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bd0G6Qb9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E2618C340
	for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2024 09:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070668; cv=none; b=gzoT3ZEuwG9IYqkDEk+uLONtYSNuqS1j3DonHq3OB0oLdYC0g4FFiRBiYxJqn4c7jAan74+ai1gaG/vQY96GsKugkD+8TJ/+tLeifJNl93PhoI6f4byUCR3wxuMBv2KBpS2a83xYPNCl9bDHkt3keubxOCyxisjH+DvmMbg1zWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070668; c=relaxed/simple;
	bh=ohF3umPyuOauRCXtg+9g0LSx9YYMmt3J70ihGoUN+Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRMtKSM0CgBD0pEIk2gWsTUXCahWfvDa+dqLhI35XPoXV5UV0VccKLc/sclFDalasnQw+uzEoNYmnK3BP/rwjxY/41GGQf7oorYBavZHL12K859KHUsoOjRZpB7dninPlPYUeN1WfMnlNX9Jrg/ts3lx/abwKOOw7Ex+xv2AcVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bd0G6Qb9; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d6756659eso2219801f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2024 02:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729070665; x=1729675465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h3l+KDfnkkj0EjY+IxLRr8g1YXZJZ298Gwmhofoyb7U=;
        b=bd0G6Qb9P7iohy4EfgEloqWTovP6NnVnuDugUXtegvI2CwhfXE05TELvnX8Bi75Mn8
         RGAAdCa5iSXBaGBnJCGt1sufjiw7rdIxH30Y2cvKRALmhyIYlVopWcE4T84uabSirUg+
         P5A2Nvt1N3D6ttPk0s7TusSPRjmEnXXygxIVMRjSWASL80f8uvyUo8sc3VdqEqP7t1wr
         pFVLF0GzWzizbkxglVSHwnmPF4Yprwgol1pNnUsABBRGxxjCgf6kplTRuyB/3t1+4RcP
         /HeOWlXjFQIxO11NGRoWF3BALmMw1MfT1lFK52YhzXTjtHo2FTKagbR30AeG5JZZfezT
         p59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729070665; x=1729675465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3l+KDfnkkj0EjY+IxLRr8g1YXZJZ298Gwmhofoyb7U=;
        b=hsp084SQhDDuluYdyS30nYsFYNBUOVr5CJcuFBvNoLmEOUNO0JfRSCRqatzHo8xP7s
         L3DCDQkOPZWyfuX6IDXqUj3WSvJsfn1eMqJALNmUtgtHqSW2kCVzquFJvI61fdLhG7in
         8OUvsEtD7Aj0cVcLEVKxEbfXHxuhUZnlq6xt7eT6ij/qjNuxlo8KyN0/jgktvBqqjOFp
         5AViXH2ZYX4RMvySpxiTN3aln3gOJVhmuxsJ93bFeMAuNpbR2GLxu9XOq9XNyNQFou+h
         Lc/hgxG6M9il/2VsPRHOH0nB0q2CErxAqKUi6Jc07wkmolXRyRNKL2XXPy1O71NEGTJY
         V5sA==
X-Forwarded-Encrypted: i=1; AJvYcCXk2h9PUuP9GzTevcYxGIvGTcxlvwxqBqdXfoGBoS1FAR9zfESA+6Fi5r8ROrxTxBTXGluUn5klpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIm9Q2Jb1WffHpajVLReElF8aLldqnXggCBak30kHJ91aEq6O7
	sBEQwLJMgn1+VZqVSN0Bn1T1ebIvsgIAbofz4UmCgdjrT8Kkm5KSIJgzU7VHEV4=
X-Google-Smtp-Source: AGHT+IEuAtfaxDWmqtRo9Z3HTKzFQKfb1kZMHoevg8q3GnY0D22B+5RMWQcG66IkM6ULLjRGVt7AJg==
X-Received: by 2002:a5d:680b:0:b0:37d:3185:285f with SMTP id ffacd0b85a97d-37d5ffa58d3mr9177424f8f.54.1729070665098;
        Wed, 16 Oct 2024 02:24:25 -0700 (PDT)
Received: from localhost (p200300f65f19e3002f38cf427133ca7b.dip0.t-ipconnect.de. [2003:f6:5f19:e300:2f38:cf42:7133:ca7b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa87ed1sm3828558f8f.45.2024.10.16.02.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:24:24 -0700 (PDT)
Date: Wed, 16 Oct 2024 11:24:23 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v6 5/7] power: supply: max77705: Add charger driver for
 Maxim 77705
Message-ID: <rt7g7xcwh5eock2le5kmwsbgmwg6lav7imia7qbcmcjtvobx2j@letkpg5ee256>
References: <20241007-starqltechn_integration_upstream-v6-0-0d38b5090c57@gmail.com>
 <20241007-starqltechn_integration_upstream-v6-5-0d38b5090c57@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3rwftlszfssiia67"
Content-Disposition: inline
In-Reply-To: <20241007-starqltechn_integration_upstream-v6-5-0d38b5090c57@gmail.com>


--3rwftlszfssiia67
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v6 5/7] power: supply: max77705: Add charger driver for
 Maxim 77705
MIME-Version: 1.0

Hello,

On Mon, Oct 07, 2024 at 06:55:53PM +0300, Dzmitry Sankouski wrote:
> +static struct platform_driver max77705_charger_driver = {
> +	.driver = {
> +		.name = "max77705-charger",
> +		.of_match_table = max77705_charger_of_match,
> +	},
> +	.probe = max77705_charger_probe,
> +	.remove_new = max77705_charger_remove,
> +};
> +module_platform_driver(max77705_charger_driver);

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers. Please just drop "_new".

Best regards
Uwe

--3rwftlszfssiia67
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcPhkUACgkQj4D7WH0S
/k6XSQf9HYfNHCPs19xcik0QvwtHwfq60p0vK9Zlpg81ZP1YUD6D2EMe66Nc3H3C
McW4rcxRusfO2nVqqDJFtOMnNCMXDbyesJOivUpFimfSVwxDucIyG1cpwz5yJCNq
A5zLw4i3fMAuZIFgzXBQoss4+YV/Avcpa4elpwLQUgG1TGYOMJaqpTwUMcD+x4fO
yCeP6OBBfj5oOrPXRb+dis1eJqsEByUWUT8ZNruObp5o9PJSEMiXms2JSFj6G9aZ
grKExD+U1yMvGuBlhI+KSp+aJ4OBtfo77qv5SJITuGg9QARk/xiRj9pfuTRTFcQ5
90o26qv3GEH9ksysJQEEwQ03MsyuNQ==
=XHAz
-----END PGP SIGNATURE-----

--3rwftlszfssiia67--

