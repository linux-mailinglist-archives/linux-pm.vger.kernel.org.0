Return-Path: <linux-pm+bounces-13143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961C3963F4F
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 10:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF0D2847AC
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 08:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7258718C926;
	Thu, 29 Aug 2024 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F85IMiYW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF731598EC;
	Thu, 29 Aug 2024 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921973; cv=none; b=KnTy8XXOa44toQbI+QcA3OmEs45sjjOXsf6ttE0A6xDUNlf4CqmI1wiWI0ym5M7LVYU8NI9Q5UllXiH2838K9GMP15aN7//4i7YaBXLpYRkMRqKQ1w7DZEKjiJ0FyvWleq7HQI3r2UzIjesS/fv6CDx+F3QMGEe/Gv3d5SNkv3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921973; c=relaxed/simple;
	bh=HiFJRMLEOLaJ/ISVWB5bBJ6f8o08CYKL4cJqx3/c2AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kn8VFjFLwKpCVees/vU1rtRwAhqRItIdpu703a28ZwivLickYtDPSWMNw6o9Dj2SSP0vI4YDIYIQV6/DXOIfPAKt6t0B6hWO85ST13EbvW9HNRs4ELJlOQVpTshHfnni1tMmgjHHGgFV7/n7OV1e17ax65r6nwN7JU1qwCv/LgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F85IMiYW; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a83562f9be9so30540866b.0;
        Thu, 29 Aug 2024 01:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724921970; x=1725526770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L6PI0kxazoYvMEvipE5JZuGWwfX9pSjfbWTsIhMOBvU=;
        b=F85IMiYWxCrGcwsSyKL569U3JANBeoOQzPABi2GRhEH8C7Wr7p5HeS0RhOSwj17ftn
         SPVAN8ParqV+TP+va6WCxUQxau0sSLchsrFibQWgY8M9ylky2QW69n+Exqn9hY8hSI+5
         NMPi2ZdEVoYzQkaPYucUQm4XJur547urrX651IRyBjQpnTBaSS6tHKDlPvH9pz+2xP1R
         akLxggqwRBZZrCppeIcsooe4MrXrffw50ILOdjd5jh7x65G2qQEhnSkIdN9AIyqlu2Tg
         lPhNZqPyaVoIXPMSXwnTQxqQp2Um+h4GLrrI0QE5/98dYTIP+2PJTRkeLcKQoPLYC90b
         kL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724921970; x=1725526770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6PI0kxazoYvMEvipE5JZuGWwfX9pSjfbWTsIhMOBvU=;
        b=h9adQ/icRbyT7Q95v9BQSjmMDi8IH4bO+CDSNjCiIlBgJavVJ26I80G25jQaevr/di
         naot/FH5fKtIQ+29D+myFnEcT7UJlXns7JMM3FyJxVibd5MCVyMgvKzO0wMwwsx3RhWc
         Q6p4Q8kHwd/CGcnnAC8w76SceTbUi1E0BO4bGv8TZdyw6MWzUVON8urMTvX8vjaE2f0F
         YKUrY4iwdDEaNP7Xbp6P61DlHk7uvpJd+X2r6NLxfDYhDQD8S57vLisN/eulAvuMFEha
         IZ4rdbvXfuVVWPL6/Jzbt5Rx+QHVs8FRu/AAvcKbAqJPeC7n9XOBPTxLqrKGNXbGoFo0
         9yRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmgwc1nsC3yCawC3aSVrFf7uTX9nP8gLhlv0u2+k6DC1byhx0IY6lBdINV3omH6CKl7FBqGiGtmwEKQYU=@vger.kernel.org, AJvYcCV/0cSXT4VFAmwS6Hw6KrZPASNU/7Om8ngYZY3pnc+dYDl18AnC1goV0Ldu84uzlxCWzaMDfR09zDs=@vger.kernel.org, AJvYcCVcfnNPRO9lFf/Eam/b4fcxfXdvqGfjVIpdY4njbUnjr/eMmYoRSmKoDd0qE+BCYibZ8BSiwzSHWENwvAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsQTDFO5pcgwPRVC4KxSTon1x+smkwSqJZpTkvDW+peoo3+WGU
	ilLjiCMAp45Fa6X+xXqgbQUnHa/1wjfjNUPPBRchmyVZ3O7CqFBY
X-Google-Smtp-Source: AGHT+IGA+xSc4gOYa291tfiNRKlp4DGRPrBqM2Xy44MLdhpGqleWR77etW1w7LBDLk1s7sYiod2NXQ==
X-Received: by 2002:a17:907:1b0d:b0:a86:808c:59b with SMTP id a640c23a62f3a-a897fad76a2mr154374066b.69.1724921969366;
        Thu, 29 Aug 2024 01:59:29 -0700 (PDT)
Received: from orome (p200300e41f29d300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f29:d300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988ff289fsm51379766b.2.2024.08.29.01.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 01:59:28 -0700 (PDT)
Date: Thu, 29 Aug 2024 10:59:27 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/4] drm/tegra: gr3d: Convert into
 dev_pm_domain_attach|detach_list()
Message-ID: <ztizdqpyd7uyp32dn3t4kv4j2s3s43woeqfnekuqxvurngac7u@kycydobqnacz>
References: <20240723144610.564273-1-ulf.hansson@linaro.org>
 <20240723144610.564273-2-ulf.hansson@linaro.org>
 <4455ntyh3v5kk6p2hlprcdc3twy5lgwcihl6fg7akxxlxixr6f@vrpesypllh3o>
 <CAPDyKFosYtG=6KtDFeNq-XJ9DO0fbFK-bcpR7G8cVH2Zn2az3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ibwrqajl24chkuz2"
Content-Disposition: inline
In-Reply-To: <CAPDyKFosYtG=6KtDFeNq-XJ9DO0fbFK-bcpR7G8cVH2Zn2az3A@mail.gmail.com>


--ibwrqajl24chkuz2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 05:26:40PM GMT, Ulf Hansson wrote:
> On Wed, 28 Aug 2024 at 17:06, Thierry Reding <thierry.reding@gmail.com> w=
rote:
> >
> > On Tue, Jul 23, 2024 at 04:46:07PM GMT, Ulf Hansson wrote:
> > > Rather than hooking up the PM domains through devm_pm_opp_attach_genp=
d()
> > > and manage the device-link, let's avoid the boilerplate-code by conve=
rting
> > > into dev_pm_domain_attach|detach_list.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/gpu/drm/tegra/gr3d.c | 46 ++++++++++------------------------=
--
> > >  1 file changed, 13 insertions(+), 33 deletions(-)
> >
> > Applied to drm-misc-next, thanks.
>=20
> Please drop this from your tree. I already have a patch [1] that you
> have acked, which is a newer version of $subject patch.
>=20
> Sorry if this was unclear.

Ugh... indeed. Sorry, I was confusing these. Unfortunately I had pushed
to drm-misc-next already, so I can't drop, but I can revert.

Thierry

--ibwrqajl24chkuz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmbQOG8ACgkQ3SOs138+
s6HvFBAAhZckjGsjgRiVBP+auG6ca3V5rM1e+ILa1kfqoYUIC6YMarx0II2oqHLw
7+V2yQo6jViop3GggvSGI9+z9b8+HmnLgsLfWqYpem+oCRChoipAWyX/eRoxatgD
TW8F1BbE7mZVT6ZaoNuNpv/E8oYQj/AmTp7Nu1QpiTh1z5kaC2OruqEdQqqMTyPB
jX4qhifFDokbT7LNkIVn5nPRZjXgJSgz2gq68bSalTBb3D4r0WwlClBKDSWhFW2E
4Uv3Qr4KXnyp3NLJQaDaoIW//RuY3rqnI/+s6pHKmfJXb8VkXK5r0BpXs+hBEOnw
nVksiZ07gL5KSkCYdeVhuoCB8CVpuvSAkNqJ38C+nE7Q+SK7s0Lsi/7VE4OP2PWJ
J2JNY6mxkFL/muUEEjMM91sFjK6wLoeMBlfHqclA7iu43WGp8TbsxC+NI188WZl6
o8GyQWcmcMTs+TB5iytma2jjQW1WKYubdiyyoCHREXsz197fUH2xDCXX3g2vSIdf
ezAsnaAOJpZ9fHJXP3Z3RyZBZDVzBcZUrKkcg/RW3d3kCKUj9N8yMK+wFG8KbgwJ
QDjZy1mQPKnI13em60gu3Fk1sI5tDgxra1Lzl2tfIbrUDrkSKIQaC1YzYWV3GYwp
BEjnsexeJLhmghBq5GA9RBNWwXA2ZZUoR1xwPOK1PvkDekgp0Qo=
=KvWf
-----END PGP SIGNATURE-----

--ibwrqajl24chkuz2--

