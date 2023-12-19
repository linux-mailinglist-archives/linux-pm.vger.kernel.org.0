Return-Path: <linux-pm+bounces-1389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A6B8194B6
	for <lists+linux-pm@lfdr.de>; Wed, 20 Dec 2023 00:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601B8286FAB
	for <lists+linux-pm@lfdr.de>; Tue, 19 Dec 2023 23:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A3238DD1;
	Tue, 19 Dec 2023 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0PmikCP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2E542077
	for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2023 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6da45aa5549so3857059a34.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Dec 2023 15:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703029451; x=1703634251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gYqMciX36CxVpm2ksBpecQRitJ1Kok3FgaTicI0aLM4=;
        b=Y0PmikCPnHm7aw+9yJjwiv4EiShjRm9FtiEfmeLXZ/F9jNlD9Bm4UUoiTMkjuSt/ma
         2jQKW1gQX7BN3tvDHxSd9Ff3dZzvawYrXMty885t0NZB14wgbq6JAma8Dv4KqcqxGBfo
         0deqdz1YK4w3X3MSgVx7Wtge07dE7s3QN3kAFQ6V3LvQ4PIWA7h1lfjXECiNUVgPJqt4
         bez8FWzL1CPjXfPyZNPHcawhABtCOVwRvV6zuZPsHmf0PKoek0sJSjK/WUEat+diYnGa
         yC27ekdG0h2AuDRFHbMk+7DBabKoqnSX20X00Xy6aKqmPEAIxUZ11iBEuMWvDarfalnV
         XAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703029451; x=1703634251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYqMciX36CxVpm2ksBpecQRitJ1Kok3FgaTicI0aLM4=;
        b=oQW45osf9DYQ6GcUk6V8qwx8SD8FBe0QDEsBMqCac7UvOTAkPMAwd/HraBGkdxkK40
         beNaK6m2PTZDIC1x5rDJ4DYnKGyvVhOPHCSWPLWFkBjUqWcALEVXnXZRscq0ODSDud0k
         TDuC1gCnIF6BDy5mpBG461acruW6GYR+kGHaIOIIPRpGvbh6wAwssMyJWYJvLRxa1x6S
         LQ+cC1XnbHXUCatQ4ltOM6C91btnta7iphnX1wro1Hw2/mFFAW7B16OyQuBdAqQpMiy4
         l4cNMLb3HTZviWABW5LfbGBIPDLEYgkToJfECJ0J1MCV7E1fRbB7FFUDTOceA7hDvp2d
         uNDA==
X-Gm-Message-State: AOJu0Yyp6rJgtRQGodh70uSBW1snq0nK0SM11aJP667asxHeTnIDdyTL
	grWrbLRpOvKkyzG+gxad1z0=
X-Google-Smtp-Source: AGHT+IH6876p5NH6ZtR3fvMF4hSUCMbzXebWluM6nXeB2j6FtXLI77f5jPpwKXbQ9uKV7blWm45mZQ==
X-Received: by 2002:a05:6830:20cd:b0:6d9:db78:fea1 with SMTP id z13-20020a05683020cd00b006d9db78fea1mr21905545otq.26.1703029451124;
        Tue, 19 Dec 2023 15:44:11 -0800 (PST)
Received: from pek-khao-d3 (unknown-105-121.windriver.com. [147.11.105.121])
        by smtp.gmail.com with ESMTPSA id 6-20020a630806000000b005897bfc2ed3sm3664740pgi.93.2023.12.19.15.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 15:44:10 -0800 (PST)
Date: Wed, 20 Dec 2023 07:44:05 +0800
From: Kevin Hao <haokexin@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] docs: power: Adjust freezing-of-tasks.rst due to the
 freezer logic changes
Message-ID: <ZYIqxbGGfLWIPM1y@pek-khao-d3>
References: <20231212140043.714303-1-haokexin@gmail.com>
 <CAJZ5v0iOjL5sMt9SYT2BS-TyWgNiJgW_ghqaEVR=r0genrSyOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GtquyvaAnItJPD0H"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iOjL5sMt9SYT2BS-TyWgNiJgW_ghqaEVR=r0genrSyOg@mail.gmail.com>


--GtquyvaAnItJPD0H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 09:16:34PM +0100, Rafael J. Wysocki wrote:
> Applied as 6.8 material with some edits in the subject and changelog.
>=20
> I have also edited some new documentation language added by the patch
> for clarity etc.

Thanks Rafael.

Kevin

--GtquyvaAnItJPD0H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmWCKsUACgkQk1jtMN6u
sXHnkAf6AmvMrDIICQn0dtUyM6ESGwy6AWMs8ZfL+yVSfHZsU/9BETRnWzylz5D1
KcJQl4O+LrrOGwyGLlUThPQkH+enjqnUo8/K/W4ZQXxR4N2VUN2076yHlkCkdLXD
Sw8TNCiNKTP3mlGfkyMrCgGnXLxFRXKCSJCql2LlWZ0iO1apYU0mfIFcpu5tkN7T
IXcMEKVGdKdyXZhIBjbVpFAlpKwfkpnfTytokCqRwdiak3PYC5ur9ajzS3xlisec
sETan4ZfP4y/cbsV/UAORwEmyn/Fuhhfi6xsjulyPpzJkg8irQjMhY+W8+jriBJs
pzhw0Ya8eGd/QoUj5jP3utQ2bm5gpA==
=2MRm
-----END PGP SIGNATURE-----

--GtquyvaAnItJPD0H--

