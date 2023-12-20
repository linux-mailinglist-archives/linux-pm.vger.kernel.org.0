Return-Path: <linux-pm+bounces-1390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FDB81958F
	for <lists+linux-pm@lfdr.de>; Wed, 20 Dec 2023 01:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61F828C499
	for <lists+linux-pm@lfdr.de>; Wed, 20 Dec 2023 00:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DAA7E1;
	Wed, 20 Dec 2023 00:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzkyTe0K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519A0747E
	for <linux-pm@vger.kernel.org>; Wed, 20 Dec 2023 00:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-77f957a5ac5so254431185a.3
        for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2023 16:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703032317; x=1703637117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+/3ZIZUdEWDNXKiZlsadz8LRBAornnI0gdhwkx/gIg=;
        b=KzkyTe0KzJu74j6v1WFNxWor/siH+no3GtbO0f1CUmvjb6nIUdkool+mRk3Gz/YMnw
         /2AdXAK3HYoImWzd9n3CpeCINm671QXILY1lLxL5W4Z059YgZJQ2Hqyswq0nWFzHQTyt
         bRShUN2Fb3BksY6rDVRrW6eQkEe1tXUtX2X+Nwz4Y0In/N95d9E54iydUAbcvZqrZrqQ
         y3zf5t5VESuM0kn7WwWfFidiQQbrhaeNcAglRYjC98WiShgK8gcIj+o36juJXq+jIRME
         RgZ65O6YBetb21aVxz7VMKM9L/aQCdi170CfHHIbmR8ukqfK5KhfZMtlI7slBZwhWvf4
         4WHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703032317; x=1703637117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+/3ZIZUdEWDNXKiZlsadz8LRBAornnI0gdhwkx/gIg=;
        b=hl7DNMjib6XLWT1Le94TVhGd+CtPc/B5etIDBV5NvsDY8fD/aQRi3y6odVTSCCjwc3
         buvHDI5SsMyn/aWzgUPe73Zzz7oeGiyQD4Svx3U378ixk+dswqH+De+Yokyx9s83lAGy
         K3ylXFQNQzUMn+F2vMIr3f/WgnPvi5ofhOJnsZ7MuBhQbr50ih7toUtqbKmsTQQV9JLk
         DqJ6yoGO9xfgPpS3FonggSj42SGJKSPFIcPPiZCPJl7j3dnGB1L0vv5tm6BzOCzGOJ7+
         w0ecNk91CaiL5PHViRaRYcPbwCpRM/wziwLqua28JnICiJZWtV6hEVWAchIKcQM+gS2q
         8H8A==
X-Gm-Message-State: AOJu0Yxxwp7XeN9T2Wdx3B4ELXpNp9Z1uGKOPCaWQxVqS0WUUBP9OU0E
	rgd7EjYp9vd09kBUxJhGFac=
X-Google-Smtp-Source: AGHT+IEPRgl1hOWG27teS+HPCAl2u8jrYuT1GG/8axsV9BfRBYMPQhNIFHgwmWmAo+mcjkSP/Bx29Q==
X-Received: by 2002:a05:620a:cc9:b0:77f:181:c5f4 with SMTP id b9-20020a05620a0cc900b0077f0181c5f4mr14708720qkj.97.1703032317061;
        Tue, 19 Dec 2023 16:31:57 -0800 (PST)
Received: from pek-khao-d3 (unknown-105-121.windriver.com. [147.11.105.121])
        by smtp.gmail.com with ESMTPSA id or8-20020a05620a618800b0077fafe70b34sm3817951qkn.113.2023.12.19.16.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 16:31:56 -0800 (PST)
Date: Wed, 20 Dec 2023 08:31:51 +0800
From: Kevin Hao <haokexin@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM: Remove the mention of freezer_count() in comment
Message-ID: <ZYI196g6LD9mNjQz@pek-khao-d3>
References: <20231216115717.2285930-1-haokexin@gmail.com>
 <CAJZ5v0gdq22bum86-QGLKdbz+YVWfomoHsMADeiWKxCHj55=pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S9ILLnSQviWmmfZE"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gdq22bum86-QGLKdbz+YVWfomoHsMADeiWKxCHj55=pQ@mail.gmail.com>


--S9ILLnSQviWmmfZE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 09:21:26PM +0100, Rafael J. Wysocki wrote:
> On Sat, Dec 16, 2023 at 12:57=E2=80=AFPM Kevin Hao <haokexin@gmail.com> w=
rote:
> >
> > The freezer_count() has been removed by commit f5d39b020809
> > ("freezer,sched: Rewrite core freezer logic").
> >
> > Signed-off-by: Kevin Hao <haokexin@gmail.com>
> > ---
> >  kernel/power/main.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/kernel/power/main.c b/kernel/power/main.c
> > index f6425ae3e8b0..768c07155d53 100644
> > --- a/kernel/power/main.c
> > +++ b/kernel/power/main.c
> > @@ -61,8 +61,7 @@ EXPORT_SYMBOL_GPL(lock_system_sleep);
> >  void unlock_system_sleep(unsigned int flags)
> >  {
> >         /*
> > -        * Don't use freezer_count() because we don't want the call to
> > -        * try_to_freeze() here.
> > +        * Don't call try_to_freeze() here.
> >          *
> >          * Reason:
> >          * Fundamentally, we just don't need it, because freezing condi=
tion
>=20
> IMV, it would be better to remove the entire comment from
> unlock_system_sleep(), because there is no particular purpose for
> having it after the freezer changes.

Sure. V2 is coming.

Thanks,
Kevin

--S9ILLnSQviWmmfZE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmWCNfcACgkQk1jtMN6u
sXHCwQf+LJD8gRxYxRssp+1OZLbp0+lE8lemEhWiPHdVZ4YHYqDIyd5taJrioZkK
fgSVdBQTVyHS1MO7VRUjp30Qcoi9iztzy/ZuapPR9Xm9KWrnD1CiviadiUqIgdSX
T5LuGghKM/SA+KAVnBe2mVvdKLU/Z6B6kjBlQQTaGcJq0Ntwq4QySB0/pCkTi42S
qyBes3BdtCApReaJ9qbFvWReIUGKvHXte3Upkl9ai9AunN9CwjGCeClaShjLVrei
dcF3pPHudp8YYqGR7c4wSrtSRnoo//RKFecW272/T7t6wl+ZvCrLX4uZ4dICBkWF
b9IxqpCqYsSXthnpjKZ5RXsyPIhS2w==
=mauC
-----END PGP SIGNATURE-----

--S9ILLnSQviWmmfZE--

