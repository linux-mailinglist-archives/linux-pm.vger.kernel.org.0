Return-Path: <linux-pm+bounces-34866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D372B7E805
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F9D467E62
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 12:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA3D323403;
	Wed, 17 Sep 2025 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xSwN91kr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943B2285073
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113251; cv=none; b=HNL5JBBaxD0ecq/4cwcP7fLPe3xFW7gWr+BWwsnwmqgp8AawRLHOu0EPBiUj/kfI990nqHT3AlypXduWdgtb8EYZ+4jQcAe4SRdUmHhTNBz9SqCAUoTUGPkD1qriPmlYKABYjfSpqllKJFgt+t3a7uLLQZ+UA9S2QCEYq0zJNrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113251; c=relaxed/simple;
	bh=OpFjrz8zqyAOuDDEavL83RJ8Trpvvw84g1TSZSRsq/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K28jvXqpd5R58ugRQcv+MNhZdWraaT1ZgVUf45ES5tYnstzyhg0M13wowPvkxdOFHGaHi/QSv3mAI4LZJt0ouLDU/fsBHiFuYWY1P9yx0XBa+7m2n9c1O2NUz7oDA8093szTxR796spNZ07/Iwa9sww3L4Ghv3DfLOpDH1BQlbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xSwN91kr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0787fc3008so937265666b.3
        for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 05:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758113247; x=1758718047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OpFjrz8zqyAOuDDEavL83RJ8Trpvvw84g1TSZSRsq/o=;
        b=xSwN91krrz9txdVVg7MgcrhHPpuc6B06E1oLKYBvGx7VMVFzPSXVNlAMmyfQSMJFOF
         kWHYaMPaoX/yvZxIOb6Fr5fP5Kf7aCNQxM3Gxr0aTgArRpnjCmZs2eLbLNPyLW/nldmP
         kXo0Y2zER79ugqeg6MAczC4iH9cMZ5pvtg3VhoUs987wQgeXATyLJkrPTG3q1/61kmVY
         J8RzPr4vsh0Yb4JHqW1ZXKCBZyfUuTLgx8hbE2ecqs4ANO96dvQtcGOhc+l2IdxmhU/9
         4sokEbU+LznmYLo4yaazub6VQp0UEjQGV6ejPDSDLqrbjiUOsIau39EDBz+0u/6Gjeit
         /Ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758113247; x=1758718047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpFjrz8zqyAOuDDEavL83RJ8Trpvvw84g1TSZSRsq/o=;
        b=uk+EnXM3iLyeMmy3qJYwxND0OjMN7Zj4H8k8/AcE9UDgJl2TaBTfvApiW+1g++d8vI
         6Da0AH+gkzw+w+vlyiWvW0UxB5E5D0J/QmD6pOlgWrwjV2xIVX7HojbhK7QKs9vckoZE
         FHvjK5Zu2vrLb32h0Y+MGiREr4OmSJEV6tH1FhA8/KlG0fy4l0+ZHMhB+i8Qr2gNFcSW
         T/QURXgtM/ERPWVwtf3yVhTjRN3L4dYcfNgsqgJDqQEEnlZuDS+FadcEPoz6WBoMEUm1
         LMO9XkCWs7VCOZ7WE/xfW7xuS+kAA4qG61IhQJYp4r0WMu/bIzP9qzk7cRo0KP7IbMcr
         etyg==
X-Forwarded-Encrypted: i=1; AJvYcCVG4W+RatHJQKEwxJOugwZjJ3/CM/4W3qB4f1AY+1EsG7gsvyzfAFA7I4p1gq8EodyJELYBA6+BNg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ROOp2fawwnVxlBwKo8FoOU7e64g4a9eiHiaIhT8ZR7pHdE/m
	+yrYLjoDR4qk3+Fpdb+WgsriN9wNGZBWN0MlW7GI/bA2r7jjAQzvfVWNwZUYMbmzwPk=
X-Gm-Gg: ASbGnctFS9uyrGmjElWcXaGY4VTIeEeDQpRjVMlNTpiOLNy+FH8ZruNeJkfYCswUfjH
	QYrYMc6sgGwmbwZcBUnRQAcZfWDVAjTfatESpHRaWvImvNqKlypBJI0Qy1PWnN4dVw0jMGGUW/p
	bmyFjFZIkah0pyguZ0X8IewrOqHmAVmCcPAD4WbWtVHrTyc1hQNXDmod1M8LjW4OwhiptePsC/7
	zyOP1G7cDqUfs165i02yAJYUbNpcJ6z7dIDLhSh5Bg05l5Q4ydNjEfkQTLML6CC/j38S024tmU6
	t16LDyfSCFSGGN9TBnqRphYwyRHR9i3DIYzDHgr8pGCNf60mte3ewMY6z2rzuyPrO0OEW64HLIK
	wNJnSaDke7Ma6AYOHBbxrI0Q9aSQ=
X-Google-Smtp-Source: AGHT+IHgG+feaLFS5lYK61xigE0As4f8SIEZukBQyUiZyyvMqVLGwJC7y1Bl5VWs3fMe9SZIDZZJTw==
X-Received: by 2002:a17:906:f591:b0:b07:c905:af33 with SMTP id a640c23a62f3a-b1bc02f669dmr228527266b.65.1758113246285;
        Wed, 17 Sep 2025 05:47:26 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b30da289sm1339567666b.17.2025.09.17.05.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:47:25 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:47:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, 
	srini@kernel.org, vkoul@kernel.org, kishon@kernel.org, sre@kernel.org, 
	krzysztof.kozlowski@linaro.org, linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	kernel@collabora.com, wenst@chromium.org, casey.connolly@linaro.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <er7dkmzutsu3ooegeihjzngi6l3hol5iaohecr3n5bolfse3tj@xeedlx2utwym>
References: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
 <20250916084445.96621-3-angelogioacchino.delregno@collabora.com>
 <t3uk3k4h3l53yajoe3xog2njmdn3jhkmdphv3c4wnpvcqniz4n@opgigzazycot>
 <aMlnp4x-1MUoModr@smile.fi.intel.com>
 <mknxgesog6aghc6cjzm63g63zqbqvysxf6ktmnbrbtafervveg@uoiohk3yclso>
 <CAHp75Vf7KrsN7Ec9zOvJoRuKvkbrJ5sMv7pVv6+88tPX-j_9ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ah6qgcyytq6i6rrs"
Content-Disposition: inline
In-Reply-To: <CAHp75Vf7KrsN7Ec9zOvJoRuKvkbrJ5sMv7pVv6+88tPX-j_9ZA@mail.gmail.com>


--ah6qgcyytq6i6rrs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
MIME-Version: 1.0

Hello Andy,

On Tue, Sep 16, 2025 at 07:20:20PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 16, 2025 at 6:11=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > On Tue, Sep 16, 2025 at 04:35:35PM +0300, Andy Shevchenko wrote:
> > > On Tue, Sep 16, 2025 at 03:24:56PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > > On Tue, Sep 16, 2025 at 10:44:40AM +0200, AngeloGioacchino Del Regn=
o wrote:
>=20
> ...
>=20
> > > > > +MODULE_IMPORT_NS("SPMI");
> > > >
> > > > If it's exactly the files that #include <linux/spmi.h> should have =
that
> > > > namespace import, you can put the MODULE_IMPORT_NS into that header.
> > >
> > > Which makes anyone to import namespace even if they just want to use =
some types
> > > out of the header.
> >
> > Notice that I carefully formulated my suggestion to cope for this case.
>=20
> And I carefully answered.

I tend to disagree. If that anyone only wants some type from the header
but not the namespace, the if part of my statement isn't given any more.
Still your reply felt like objection while logically it's not.

> Your proposal won't prevent _other_ files to
> use the same header in the future without needing a namespace to be
> imported.

Oh yes. But that's true for every change: If you change it further you
have to cope for what is already there.

> > > This is not good solution generally speaking. Also this will
> > > diminish one of the purposes of _NS variants of MODULE*/EXPORT*, i.e.=
 make it
> > > invisible that some of the code may become an abuser of the API just =
by someone
> > > include the header (for a reason or by a mistake).
> >
> > Yeah, opinions differ. In my eyes it's quite elegant.
>=20
> It's not a pure opinion,

That's your opinion :-)

> it has a technical background that I
> explained. The explicit usage of MODULE_IMPORT_NS() is better than
> some header somewhere that might even be included by another and be
> proxied to the code that doesn't need / want to have this namespace to
> be present. Puting MODULE_IMPORT_NS() into a _header_ is a minefield
> for the future.

Well, for a deliberate abuser the hurdle to have to add the explicit
MODULE_IMPORT_NS() isn't that big. And a mistaken abuser won't explode,
just generate a few bytes overhead that can be fixed when noticed.

In my opinion that is an ok cost for the added elegance.

Best regards
Uwe

--ah6qgcyytq6i6rrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjKrdcACgkQj4D7WH0S
/k5EEgf8CdFx6+6iEV1AE4GeSJAKaBL6T9A2o7N08nLq8lg9b0873yxBoHXcU5fC
aJjF55sEwR98xGntE7kk39pH49RCG8ugwvBfJUnq75LJiKU4gyhg9P3OPFnLShiJ
I6m5bqGNDlAwq3dSuYSiDSr/4wi/Rq4mPKqRZoCT0WHQz9CWes6CdQPuRMSKYeJF
5VvswQqZGx5s73s0oi9UinWZ1/t/tX8KTjVeEgkmosNDtXb8rSwQbmfIUqnuCv0m
ZjvuFwKtei8Q90Ro1LSW+QP0R1bN1ydWluw6cGH65qE7Yqpb/P49Yupan3C0YEsr
nJJjRh4HIIADYdzeEZWvvrOcN8LC8Q==
=NvWc
-----END PGP SIGNATURE-----

--ah6qgcyytq6i6rrs--

