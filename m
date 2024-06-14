Return-Path: <linux-pm+bounces-9136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170F99080F2
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 03:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A98282C67
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 01:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F9D157A43;
	Fri, 14 Jun 2024 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rsdlC1zC"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF841EEE0;
	Fri, 14 Jun 2024 01:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718329633; cv=none; b=MvCZhyFEHiAfpKxxoZ6aOi9oSTA+68bK+gGOMDtlo7rH1kWEeMD2R2zoytioMC6XIAKIK/tIGa40CDj0KND1+hTFp3rJzj1KRu3cUZenW1idGyqijWJoAhlj+AUi4I8exkAAIJDXMUTWP4omEvuX9ivSiFoNBwM+11OBfsTj60Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718329633; c=relaxed/simple;
	bh=e6x2Udov0z0jRMGzv0LZfs+zVlznnJAxrLeH7tE+OpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcmTXCmGYFMh1uR6i5ArwZZYjSgKt5ArAghsJ88WZ8kM/IMbrIaAGJVE6+nINdJ1m8kvfBUOc2UVZdIwPaBjZ2iwO2qJYEsCDykW6v9rkufUOdl83ro6uhBRgIh3Sg4FXJtEkJZkw8piiweLD1n+C6JPHqNSHiHfXE/J+GwtGJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rsdlC1zC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718329630;
	bh=e6x2Udov0z0jRMGzv0LZfs+zVlznnJAxrLeH7tE+OpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rsdlC1zCDtjj9NNQJqwh10IMZV2lXH+lj0o5X3YUhEcglxqQNXjpeIDcSTIKJ4X6a
	 nW/20ZT2cYSdZ2XRsfnzpSA10Yi+KK8kmmKWL6muFOuuf/w6wGth9aNzuY9CptZqlM
	 8QgUVJreO3LgOlcw9RrvdZDSFEY0udY6WEK0XBOwW0TERpF9jz+FuW3C3qsjINrrIm
	 VJb+5eBW+OfRH2YeneuIPflsMwlZ5s6UlgC/A0KkDdQknsyaMd/iaFkOsKG+qJ2wl6
	 ck6VA796TJuPdWkFRYMI6pXN68NG6mjQsZ8Mjm8XI+pkKj00djb5G/fd9NhIjmaZH5
	 2HWfi5EfYdp5A==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 40313378107D;
	Fri, 14 Jun 2024 01:47:10 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id C9A8710608F7; Fri, 14 Jun 2024 03:47:09 +0200 (CEST)
Date: Fri, 14 Jun 2024 03:47:09 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v6 4/6] power: supply: lenovo_yoga_c630_battery: add
 Lenovo C630 driver
Message-ID: <yrysv4c2xeazfi2w3g35qsyoz6b4k3uunzpgj3cdtbyussufqn@5fnuoeubwjnr>
References: <20240612-yoga-ec-driver-v6-0-8e76ba060439@linaro.org>
 <20240612-yoga-ec-driver-v6-4-8e76ba060439@linaro.org>
 <4fc43c56-f801-909a-9178-166d275a5fee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tqsq4jiejojoj7cg"
Content-Disposition: inline
In-Reply-To: <4fc43c56-f801-909a-9178-166d275a5fee@linux.intel.com>


--tqsq4jiejojoj7cg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 13, 2024 at 10:57:41AM GMT, Ilpo J=E4rvinen wrote:
> > +	adp_cfg.supplied_to =3D (char **)&yoga_c630_psy_bat_psy_desc_mA.name;
>=20
> This is not problem with your patch but I'm wondering why supplied_to=20
> needs to be non-const char *. Are those strings expected to be altered by=
=20
> something, I couldn't find anything to that effect (the pointer itself=20
> does not become const if supplied_to is changed to const char **)?

No, they are not supposed to be modified. It should be fine to make
the struct member const char **, patches are welcome :)

-- Sebastian

--tqsq4jiejojoj7cg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZroRkACgkQ2O7X88g7
+ppBkg/9H0Vh77I1df6YmgtH3Dc3JT3L5qfTx7EDy6jHu7ihZ6qWM7UoWR6UbThB
eM9iqWs+qw9CbO+oiHX4TwHItM8ua6CjwOTJaXN3LRvQ86tZ1S3oYFYQRz3cqHSy
guEdkIELM9rKsTguKre5bJrXNcfQ5T6jjrAJx+60/Y+pJGzJD7SimNGRmBU9erSp
HBMQ548Ct5roKoNqzauPnGRCXslMVSGAk9vmGu3dv4C1VFr30ndPeRnK4YfPLl50
cjEu8x8MenIvkNSA7mpIFZem4NBnmQVWVtfi6sMuvfH230pnKi6SvNKr4daPrYMI
atHouDXhMUMcMg6/p+ARuk/1BcW3kBl3H+2piHY1qj6Riuv+zch4Ah0Wz3SZQmdA
GiKlfLZVk4LPx5e3EIUR8cNXUrNOVwj7GnH8D+OIgnPIoMQNufNPYFvCCFWipqjP
OnrfAXz1ebAFpREjHm9rfLk7PvYmWnTLS2F19cfmTbC+bQqulgvclLOITdOQxr3V
okhD1SjFC6Wm+SkwnNFOsNSf1aEwOnpOJkhvdKS0dRAY5AkCH1H5baTAZal+hGdg
GA3qo6hCZTjGGofYSp302ltyJQ9Nn61PI48gBa79+7ovYMkrZsYmWnHJibxnFcQI
SnHurPxpcCALPl8osrReAKV8CUVAsP4KL6+NbdgcQdyF1UxEH3w=
=xOfT
-----END PGP SIGNATURE-----

--tqsq4jiejojoj7cg--

