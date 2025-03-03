Return-Path: <linux-pm+bounces-23325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 267CCA4C59B
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 16:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1538F16934D
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 15:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DF5215040;
	Mon,  3 Mar 2025 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8Okx4yX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9137214A6E;
	Mon,  3 Mar 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016927; cv=none; b=a90Ze2HouuaNMg80toiamdFKVPOcx3BymcxkDaF2gXjDflMQuKR/MxBrjCc3AFcC5ACbz2NybGMN7rLo7/LwlFlup+4KGbpbYLkV8er5T1fTcZXOTXhtylMyQcC49CvUcFoyB6g45cROi2C5DFXJAx+WpOdYvuGan2qo3rUfTjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016927; c=relaxed/simple;
	bh=Z9AhKqGlaj4pyk3akePKUpFJwAp3uvRqvZ+OObNIwsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muOG3fMVeg5Bh41DAQ3HXFmr+hQCXERdpDn8EyaushcsxaaJFgh80tcp4yUs/zoQjkZbm8T7OKhsy04x+1QHmh2AdafF9J2r0c33biWakej9UbKaTHdcAJiGc1C8s1gUzCHL33bZzEv10aLLBAOKTBKhaAU2PnRjTcn4y1LGP+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8Okx4yX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso31794825e9.1;
        Mon, 03 Mar 2025 07:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741016924; x=1741621724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jJA7mFLHciSsiy3J/whfYVHjSGbM31OHQ+D6knQWKCc=;
        b=O8Okx4yX9q0q1IpnW+7+GdUdSqIZyDtZPy3hEGSysi80v7vX5OuWZArtPHkWqokjHT
         pG7nruJw8lIGXaILPg+pm8u3rzd9f6izPqGLGEliG3qRkGzaX4Mg6BGf+9v9RH/xfl6h
         jM05XqL26UQyLr3wUVZ9DgtBYYvbZn+NlZnLodPEJY30SSou563Kbki9VVvbTTjKj09+
         D93dfAc6gakoLTXGqe0FTUV4xAXqiDosLiZIfpJdqZQ4nYfP78eMpRWfDxZQ7kA10Snh
         LSZycInS3jQo0B24Zmcw12K1VEFu+2foiF5Q9qk2fvDz69dj0Hx3nVXGau4qFajvTs4g
         Pt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016924; x=1741621724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJA7mFLHciSsiy3J/whfYVHjSGbM31OHQ+D6knQWKCc=;
        b=sm/nunGsgXppUQFpFjj75x0b39vNSNL46mE6vUpLXDsyeX7WI/YW9wqjk9cmuQycdb
         fTwD8i9HuwLW+ewv6qgrdDhivhX9jXPT+8eVkMZx4ocYkKF2Y8yJsncMGJIo7ez4//EU
         rIKuTMgYuxG1bvUtgZNqVrvZw/EmwH5eCZ2tE3yt6vVbgzoGwAkl1iFfN4OMRJaSTJtW
         Oe36ELlzHcdi5WkBOfGw8srfu65aLJT384SiZmoT3AI3bzZl4Wd1yiLAElCuWicLxXmG
         vcZapG/u4xdLYeu4tr8xvBSxK3SmWuldW3bt2E926DW71+a3ClXAdYMNsWAVgSdUiSki
         +HEg==
X-Forwarded-Encrypted: i=1; AJvYcCU+BqiEJZEm4lDf6bR5P19iJfrH4UhARXQOSVRDgRP6onLMXrJ1Pupb7pQ7pMCs0P9VTr/GdA9sBwfPI5A=@vger.kernel.org, AJvYcCV+4qq1O7gmHG7H2/yy5i88m0UF0gqwi9OFHEFbdAZVZJaNTBSvDa9jaIHNotpnKcquLipEQu5BYXg=@vger.kernel.org, AJvYcCXCU11B8EkX5yE0Om0okOO/Heoin6UugY0QmRsrxAnQuODL/bjq5BmCLW2vyzNEKvtCeTlqkpy20MbZidM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFBgWXENqJyFQpMT2CSeDHjthrTSzplW5co51rfAr89Bj6Sq5i
	6VNUT/WJMQfoTLE024Y4Mgy8yL9ouxWyRVf0TwyzUJlEzUPakaLX
X-Gm-Gg: ASbGncs9aG3h7dcFQAZhmLuQJ8p2/W/d7JHXQu7ttsznH5WSQpIphTVRzysdN/iFV9j
	lfct+5g8j9OO0Lj/eyksl5rw2bEcp6ZeapHx/iODypDP8WE/cE2lhKeBKvhKFD9vrwOkHCEnQj3
	0Pi8iRAUkCodmAxe+O/f+PMtjIM46imjVt75ibyxaG8i7zR4E9Rqz+kkAy8SX30p5QDIgYRsJl7
	nvoAo5GTVIL2k8C3w2JzsUOC9yi6qvGsm9ixlZeSBhLbWM+tcPMmJLns8dRzNZ6gI3vZYDrsP/U
	n9hW85vWG7eo+xxhGyIu0fF0qhe8LtM0MfVGHFpX2EnTLSP6nXDKdvsaLvmdq79fppVMZW4rIGw
	JWuBg9saFRH828Xi5p2zFXdab+LNMGBU=
X-Google-Smtp-Source: AGHT+IEOAKi8V3KtBrmPoXsmv8AUZWyNlinWQscFlaKZRCcM4TbG1Z2GnCHAmSbT3m0YGyavIMtd2A==
X-Received: by 2002:a05:600c:1c95:b0:439:9828:c42c with SMTP id 5b1f17b1804b1-43ba67606d9mr106070975e9.23.1741016923755;
        Mon, 03 Mar 2025 07:48:43 -0800 (PST)
Received: from orome (p200300e41f187700f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f18:7700:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5871f4sm199666745e9.39.2025.03.03.07.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:48:42 -0800 (PST)
Date: Mon, 3 Mar 2025 16:48:40 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>, 
	Sumit Gupta <sumitg@nvidia.com>
Cc: Aaron Kling <luceoscutum@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Aaron Kling <webgeek1234@gmail.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: tegra186: Share policy per cluster
Message-ID: <fndrufuwpt4nptgs7hlucio6j7ia5sc4yeyasrherdv4dxs7s5@p4y6wsa7mxin>
References: <20250216160806.391566-1-webgeek1234@gmail.com>
 <20250303100306.rwaosbumr7omcqce@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ocjrlmt7ay7m2hyt"
Content-Disposition: inline
In-Reply-To: <20250303100306.rwaosbumr7omcqce@vireshk-i7>


--ocjrlmt7ay7m2hyt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cpufreq: tegra186: Share policy per cluster
MIME-Version: 1.0

On Mon, Mar 03, 2025 at 03:33:06PM +0530, Viresh Kumar wrote:
> On 16-02-25, 10:08, Aaron Kling wrote:
> > This functionally brings tegra186 in line with tegra210 and tegra194,
> > sharing a cpufreq policy between all cores in a cluster.
> >=20
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  drivers/cpufreq/tegra186-cpufreq.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra=
186-cpufreq.c
> > index c7761eb99f3cc..c832a1270e688 100644
> > --- a/drivers/cpufreq/tegra186-cpufreq.c
> > +++ b/drivers/cpufreq/tegra186-cpufreq.c
> > @@ -73,11 +73,18 @@ static int tegra186_cpufreq_init(struct cpufreq_pol=
icy *policy)
> >  {
> >  	struct tegra186_cpufreq_data *data =3D cpufreq_get_driver_data();
> >  	unsigned int cluster =3D data->cpus[policy->cpu].bpmp_cluster_id;
> > +	u32 cpu;
> > =20
> >  	policy->freq_table =3D data->clusters[cluster].table;
> >  	policy->cpuinfo.transition_latency =3D 300 * 1000;
> >  	policy->driver_data =3D NULL;
> > =20
> > +	/* set same policy for all cpus in a cluster */
> > +	for (cpu =3D 0; cpu < (sizeof(tegra186_cpus)/sizeof(struct tegra186_c=
pufreq_cpu)); cpu++) {
> > +		if (data->cpus[cpu].bpmp_cluster_id =3D=3D cluster)
> > +			cpumask_set_cpu(cpu, policy->cpus);
> > +	}
> > +
> >  	return 0;
> >  }
>=20
> Thierry / Jonathan,
>=20
> Any inputs on this ?

Sumit,

does this look reasonable?

Thanks,
Thierry

--ocjrlmt7ay7m2hyt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfFz1gACgkQ3SOs138+
s6HiyRAAu0PFx16mF5pUayg8dNF6XrNCIoa+SyHGfLxi9Zl+NjUWaqPPXGfmXMXC
OPO0iM9BUBP1t5FdVKS7ZZ6VoNi3Ne+QH2ivjvpI5LnPkT3TUqvT+SN2vgMlCWm6
O2In/ZAKVc38ZrRfYGf2trNnJjud4NzRiNmtk08iSKf99J2EOncMosAEYQM790cb
jdO17LK+B2PL6Y141yX1+qypp95m3uxHVBRq16vId9UuxQAxfB4oE5dtsUVmP7aV
wPHvvBfW7fkFloekALhQcO5isomC8ccjaT91OafTtr2QyF19mDBzG18mglUx+0qM
3KfYYAh1Zg+oX0KmzsGtPQib04k0MlZCwWzH5nws3W2qKmQJFpDkz4+OvqGPyKvF
6gm073Y5SGCPJJYhIQSlJHtbLwjFe50rVK96Zeo34ztNEAH0MMzPffKNSq+ZRzVM
h0LLYJwB0N6wKB7RGdF6WontbltMt6sAhOHRWXDTeF1D21tdt4vm8qbE+t94bJeC
F6P0P+YJQuan7Y3vqJllzOHkvEfafcpbtBijNjwA1NC/kbXdOFxuj1ZwL9Zlgqiy
yYrUpFvuGQ747sZqu1Q2cfQEtYo6kIyxKFtv9OVhsCZW70/oF583oow9M72jqBCf
cu/I++z3usfIRuaLcc5JnY9V3uexlonqklozhk/w9kVU76ocleI=
=MRZ6
-----END PGP SIGNATURE-----

--ocjrlmt7ay7m2hyt--

