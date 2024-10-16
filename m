Return-Path: <linux-pm+bounces-15749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2B69A05A1
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 11:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B2081C21D75
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 09:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DE9205E2E;
	Wed, 16 Oct 2024 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vrlCtia3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B28C205E08
	for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2024 09:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071401; cv=none; b=Kx2Ae4Y/d42NVD5CYz9V/doIUqU7vRIkxWJdEAAAtUEUnH/uloUF9Wk2IV6UvEXDExk06Zv64kgNBHnga9bQ8M9IU9ey8jefOqGuEJfAE1PLJcDjpyR6KHkejJsiIFKzZ0ikRguxhcQ4kS3IkHS86UjIclfCf99h/Xs6txpratk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071401; c=relaxed/simple;
	bh=621pHK2wAuSXfDX8JVBqoCKT8fO/ERzqBrXyvGkMm7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxH8F1lhj8g1kd69IOhM7MSWlDgBhX4vY9iybOT42P+PKriG1yT9X/G7BZtAUN5WqJwD7guSa6RVLc4DR4Wk4NN++eY6fLsNe8sR3jlvyRHgji3/i/eNLhCxKWb3b5RWzVa8pz2Qq0LeuvaZqG3r01yEyVquMs+NIHbQlGI+DE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vrlCtia3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4311d972e3eso39287405e9.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2024 02:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729071398; x=1729676198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xg72GJRggzMx0IUcLotHk1H3deITPAX3yCIV5HOhBDs=;
        b=vrlCtia3I8fa+PBjyFfhRtJgBId83mvu52hJAiw0j1y3k+RbbtVhys72f3Ng8anHkl
         x5VzwW7Dc2FvavTuY6dAYKNAaBXdAnrYp6vYzblQlQS4z99XdtVSWCbLm7VRjbVItJHU
         83iqxRevukhT4f6ca25fDg3sj+t+spDgFEYvk23ifnj7Pdj1bQ5t3XNvrUtbUjCBlscP
         z04CtgswzlAb3v0QROZ8KPmeirJG6/6zYj1ufcpJkaqI+XNNsOaWZjwtxk6CU5QDhEJ+
         OxoGplYCYE+LhjWMGr55h0XLs7RE7fbayUBER+wQM0F048l5WtYifmS386fM2qTEKYUI
         cHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729071398; x=1729676198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xg72GJRggzMx0IUcLotHk1H3deITPAX3yCIV5HOhBDs=;
        b=HcmZbDXH/HOFyN0hbVoZoqKeAtl6GdofNF81Xc77Zx09BG4h2RW0RUbP4IzXR2SzyV
         wAISRiCdRojrwrriOXpooovnaQXnjh3EJZI9ZMWTzrfVFvPbN80OU3k735g9k+vhcjYi
         0zENd3UGwJlRzjNIR7Rm2a2NUn4maQ0vTqqME1S7Li/RUAYlqKcAdYhXpRKLMBbOlOCI
         pfFCuWrCO19LsTFeh/9ZfO4bNXPxR0F/QtoVYQa0Dw16EPp8iENP2GHV8vyAtJeK1IiA
         /w2inU6MNLXLTsOtXa3rBH0Uhr3b8aI0K1ybKQZ4pcLC1LDC1MYbBiBrfSDq6MoLp7Jo
         zXpw==
X-Forwarded-Encrypted: i=1; AJvYcCWqMD8v7UofTSZjq4WbMETm2um9XocjT6y3nPZCdXEXAxmHLlHUV/5OaKsJpRiAN5T+t5TjTrIMKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwV5xVxkiGxep+lDuVVzywPOkCVsSiysLMAImjPr7rm72VDf2Yy
	BxKBTxxJuIoeGj44/JXKm8UShbeUBVCsNFZbaTZ5tq10zOo8uc4kUEKlrfkUfLs=
X-Google-Smtp-Source: AGHT+IEghUNeNgADNprsC+ldtJxDcl8vYIVGk1k4io7FkREb9/Xph3UyutiqulubHUF90v5+qDABGg==
X-Received: by 2002:a05:600c:5251:b0:430:5846:7582 with SMTP id 5b1f17b1804b1-431255d53a7mr124063265e9.7.1729071398482;
        Wed, 16 Oct 2024 02:36:38 -0700 (PDT)
Received: from localhost (p200300f65f19e3002f38cf427133ca7b.dip0.t-ipconnect.de. [2003:f6:5f19:e300:2f38:cf42:7133:ca7b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6b31b9sm43932725e9.29.2024.10.16.02.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:36:38 -0700 (PDT)
Date: Wed, 16 Oct 2024 11:36:37 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v2 05/13] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
Message-ID: <4gcjfysohl7qxdfgmxm6j4yd5ps67qpnnwgt776xondsfdwnri@7mde6vfyfiah>
References: <20241010193705.10362-1-mario.limonciello@amd.com>
 <20241010193705.10362-6-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lxvdsuunitj4n5ss"
Content-Disposition: inline
In-Reply-To: <20241010193705.10362-6-mario.limonciello@amd.com>


--lxvdsuunitj4n5ss
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2 05/13] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
MIME-Version: 1.0

Hello,

On Thu, Oct 10, 2024 at 02:36:57PM -0500, Mario Limonciello wrote:
> +static struct platform_driver amd_hfi_driver = {
> +	.driver = {
> +		.name = AMD_HFI_DRIVER,
> +		.owner = THIS_MODULE,
> +		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
> +	},
> +	.probe = amd_hfi_probe,
> +	.remove_new = amd_hfi_remove,
> +};

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers. Please just drop "_new".

Best regards
Uwe

--lxvdsuunitj4n5ss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcPiSIACgkQj4D7WH0S
/k6X/gf/V/UrLO/OKcDi9SQY9t6PkfTJfxHmElu30u+461zOqqnUGGzd9gtF9IYg
SKYlCO9O1IafnD7YbMP944KYjDthfJIPLdbP7Kr42t9W+onfntB1KjZxn/90BQ3r
jlt8sC+5XcbXTbS8O0yYT1TCRafK+7yyEiRur4FQZ78+cVrfiDNOrrppB+KrWN+k
r6Z+LMp5TxMZKP4QPOpKBIUR4eaghRnB2PplF3IqGxMgbogarOSYCp5jNvT4UbP9
Xk9vMTVMpL1PxlNTQyKaT65ARAkOgBFdgFVihgJVFbUCBPfXfiCaSI11CTfv3kR4
MJy8LhI9oSag63jSEMbFVVA7gqR32w==
=oSb2
-----END PGP SIGNATURE-----

--lxvdsuunitj4n5ss--

