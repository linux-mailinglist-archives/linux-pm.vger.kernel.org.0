Return-Path: <linux-pm+bounces-27018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4432AB2979
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 18:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B31B7A15F0
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 16:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01AC259C9A;
	Sun, 11 May 2025 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wpIIlUHM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C70F2571D6
	for <linux-pm@vger.kernel.org>; Sun, 11 May 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746980013; cv=none; b=LBp2iOdPw//tcjVq0HodgEi/zwsDw4FQfKcwCjfXVFQRMLriqsxhrfRzrdXifZOc3NL/tCs4GLUoU8ebQ/HEhliqomu9KVi4BvMURllYLUTQJLzPqF/wy134q5sqBcMuvzmUr7dtnaKj42szdyTHOQ7kwUCep0L4+yJOfJo9kD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746980013; c=relaxed/simple;
	bh=SHmLkd7sQJiu2Mufd0cQ2iLgnOytU9zZh+hQC2pegbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJB1CLXNCkjgU1d42oHRYuc+P4RGINKAGvkKAUj/0quAvIa4yvfZpZyyjGiL54f6P0D0350FriwzKYKJXwD5jvQq1uqbaEFaxdnJuM8RftvIEKJa2ZTwd0S3Cg6Pq0aXaloxipjCUhu5m4faGucqxEi0IoBBmhi0j9p6WaP3A6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wpIIlUHM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ace94273f0dso714162866b.3
        for <linux-pm@vger.kernel.org>; Sun, 11 May 2025 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746980009; x=1747584809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+HqZjTSS7S3eJwQA/m3U9yuAxHSWy2oxr0SFmWzaxHw=;
        b=wpIIlUHMVfOsxk99JgHa89V0qMPCGT9gY2boZ5R228ky9rXn+M4JYZL/V7GRJzkvfj
         MEJK7dYVlQBA5cC4ZD/cmjpBmq25pwOlPeuY8jGnJul1mk1FEm9Xrx7D7kr0M8oa05Pc
         6QZz4H2xV8oRaUpd5dRDXu3WhzQ6ju5Z62krv9owfEN1tLkYVRzR1fPb9Nmbxz9QfKpW
         eyF3VEShqh4Gkzq5Zj7Q8I9dT4WT4K+TPkgET8SJert0luI3nUrjtCpRiRuen1TIAM7K
         co6rbzfBYbT7gBmFgNXwLj3tBk3xWBlNao5QK+9x5loLDfHIdALM0YgDgcWz95HuHPyE
         2WVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746980009; x=1747584809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HqZjTSS7S3eJwQA/m3U9yuAxHSWy2oxr0SFmWzaxHw=;
        b=NewEI/AppRZ7E2yOemWBG/kAHdd1EJT1f6BCvgU23+VMEBpBzUXuXb+ksrm6EqrK7D
         0ngTMgxCqQEhsAwKQM3xbERgs7gw7D9Fe/wO81y0ikkG8gsuEN4wqwgJ2Z+v96uSajIe
         1NezhbTxbq/MGfiUagMDnq3zKRx9uzDZDDmbf6NiVs5I8wlvmEkcVs/gSzL5Hy4Qj+5Z
         r8hWWnR3M6D4IfevK9QLm+JEAk6jGDbtYUMyyypUgVkbj8mW/J7dmQungknwJUqfrLxk
         U5uHdi6+K9KXP3eoOLGsXHvRCN4T8a+nGgiFoARF3XuaSqWh/NR7kaICIpmEA7qlW/WQ
         GW6g==
X-Forwarded-Encrypted: i=1; AJvYcCWNSiqsTvWc51UEBuYEZuBA3wwYzBIrn+7jSuy94FqmGqYOqhy8dPX0+CawhsBv8vfbsmTA1US8uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRQBOyprFIYkLFrBqMzAGfpWXgawkATIVE0l6TrgyevmKa2OrQ
	KBsMO6bGvVJDZWhqMU4cHkYCCTX0ztdLVlZVmPh4MkU9BfdYrBPXeEiBlmHsMm8=
X-Gm-Gg: ASbGncsKPDhHCU/pHDrL1kfzGNWG3BVmH1K0xfwuA1vUVKTiA8JesOkpQhDcd0NdyF8
	5vGh/kdpjv+jQ3TZMXs1q+cHn7TcoRl8RSuIBcgtaspt8tGPl11UzIf0pY9mdjs69xFpQa5O/My
	oHdwS4DRydyFNqe7SeIVHZmCnDzweRRvEBv+R7K9XFv7WZzpSnFESRL0akDu2GHFBrwugt1031y
	r2aDMqh64AIxDfHYP+r/pRjO7jdvXwmdEvgo7CUf1tPLgaUS7vSGsSgadlspgo35DZNqm18nR6e
	5p/u1kJndyvd6pAut3eXbiHERUyzNaKOvZNqLh/M/Atgyip1B0xjbcZe
X-Google-Smtp-Source: AGHT+IESpcxI/t5gHS0xU/NroD6WTODIzNlVuTkb58fYBGUQEG0LdYHtrtsB21us5W9WMInSh9G3rQ==
X-Received: by 2002:a17:906:c14a:b0:ad2:3b29:4cd7 with SMTP id a640c23a62f3a-ad23b295c6emr525907466b.45.1746980009324;
        Sun, 11 May 2025 09:13:29 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad24121e992sm217138166b.14.2025.05.11.09.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 09:13:28 -0700 (PDT)
Date: Sun, 11 May 2025 18:13:27 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] PM / devfreq: sun8i-a33-mbus: Simplify by using more
 devm functions
Message-ID: <zszg23vtaztszlkrgs3acatiu7rmgypsqdzlpojimg22yaeaya@xfv3a7fsd2sa>
References: <20241111112237.336310-2-u.kleine-koenig@baylibre.com>
 <CAGTfZH1qMMO3ou4cxwaUoah7jS18nu7Y9kgYyraZ9e7jfjrp_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zyq67cjig5hvwfze"
Content-Disposition: inline
In-Reply-To: <CAGTfZH1qMMO3ou4cxwaUoah7jS18nu7Y9kgYyraZ9e7jfjrp_A@mail.gmail.com>


--zyq67cjig5hvwfze
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] PM / devfreq: sun8i-a33-mbus: Simplify by using more
 devm functions
MIME-Version: 1.0

Hello,

On Sun, May 11, 2025 at 09:38:36PM +0900, Chanwoo Choi wrote:
> On Mon, Nov 11, 2024 at 8:25=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > +       ret =3D devm_clk_rate_exclusive_get(priv->clk_mbus);
> > +       if (ret)
> > +               return dev_err_probe(dev, ret, "failed to lock mbus clo=
ck rate\n");

As the build bot noticed, I missed to add dev as first argument to
devm_clk_rate_exclusive_get(). Can you fix that up, or should I send a
proper patch to make the compiler happy.

Sorry
Uwe

--zyq67cjig5hvwfze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmggzKQACgkQj4D7WH0S
/k7s5wgArggczCoL6efrWWMp6Ly0RZN7W/gX6tbjYjbxoY+uesH9jQGYcisDYF3y
6NO63q1frIIYM6sAjsLy0WBi31x3OKEo72nv2EXoOr89KEuAY1a3+Bl6BVurOyy4
wyPtLkpscy7zO42tX8jpdLdvhMgbXRIFFIMx+UC+7FPJR4FhhiCYozBLPqTvU6kI
PXc2NXmqi0uPF8X091vDWBgFHVghg1XIujiv8pssses+com+4y/bz1YWl5N87ItE
VoXZJ2TBPV4TJE4roo8I5pjUAEHnEZ1XzoipmpVZN4QT3VRT9xhrp9awUFT2qzi8
UtTmSw4MI8f/hFjGgksaVG0k27ax4w==
=3sfY
-----END PGP SIGNATURE-----

--zyq67cjig5hvwfze--

