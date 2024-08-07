Return-Path: <linux-pm+bounces-11981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F2494B409
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 02:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6711EB227C7
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 00:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1450310F9;
	Thu,  8 Aug 2024 00:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="kjPPhT2d"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36240645;
	Thu,  8 Aug 2024 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723076191; cv=pass; b=lwZzJkJkhfJYIAd3+HWCeOa/qFQVLlg/wvDB9fNEY1wG1RCSoM/MymqaLdzIvghfYPaOdIylmJYSAWheLD7IXAnNTuU2pIBJ8sDC47e22xukOx+UuPM+nqYmfyN2xMvMld2AQZvKsGtVg6ohrpyMJkwe1dOAP398wh1FUDVjevk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723076191; c=relaxed/simple;
	bh=RkSZy1MjM+suSsqhFQ6KfrtojKuCoqcRqoubAbGWvtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppOLhlLzOD37WTvJ8hwGrY63MvmOxr+L9Pelo63qA2Ca1DhHGDa4jq7SFZY/NMKjkTL3SCLjA+jUgB+A21BftcZMYMrEO3YUCwvGSKh1tlGf1/GaEw8yYLsxFXC1Wv1hjjHewcgei8wXaNlrKm1OeQ39kviQK+epG9dGUyb0JsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=kjPPhT2d; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723076176; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KOkS81jLq2wfH/UzcAMboOJ7K6Cid+c04jcvamC5nOrA8HNWVSIm8uR9N+UVyw949wIpLpgG0wpOwlGvLWq2r5+7W2p9dpPQ8bLklOtxEzZftdcS1xM6SqlyX/76s9fm7nQTrBQmqQcEvXRcaTcw1MKi2u6KWJRQWiDW3nzJ5BI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723076176; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=c5PCpfHM2kRW+oX09FKy+xkypC2N0E4BQQ6s6yctv2g=; 
	b=g1ZWyrUMxgkJGI+DnIl71dLB4QAuR6KVJLlRnmm1F6VFJlK21paAohxVx4+Htws7OUrm3DZ7mR+/JVNzdI4wU7j65tlK4OHr2reL1KMbHFZ2vz4ujfizDe9QNPTqPn6xV9Pvi7JjlUiXKVVCd1GReKVh4evIDuRcSAY/gx4V1tw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723076176;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=c5PCpfHM2kRW+oX09FKy+xkypC2N0E4BQQ6s6yctv2g=;
	b=kjPPhT2d6KhKX+mXfVqkelYwTSr+PnojjTyu2Y6Y7dMmWCgil97jRXLQFUFPKRyD
	5yH+P4WyyCSjKwDnnTxE9mamO3AWP1LqGFcwOVoYx7ibL79gUg83IcUvYg9ac1QzG6q
	M5/EqCFJQgfqJmx04L8wbcBiD/+1Fq4ITlXcS/EQ=
Received: by mx.zohomail.com with SMTPS id 1723076173679636.7365221591805;
	Wed, 7 Aug 2024 17:16:13 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id DB19A106066C; Thu, 08 Aug 2024 01:51:42 +0200 (CEST)
Date: Thu, 8 Aug 2024 01:51:42 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Andres Salomon <dilinger@queued.net>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Armin Wolf <W_Armin@gmx.de>, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, 
	Hans de Goede <hdegoede@redhat.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v2 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
Message-ID: <wxfoa4lbcshdemcgmbodxeefamfmjm3vqfkyaijpnrmkdx3flv@esudt2r4rw2r>
References: <20240725162457.34b480e1@5400>
 <20240725221511.mqb4tlam2r7yheoi@pali>
 <45c7c4c3-2f99-4ca0-9c85-a96a03ccfae8@gmx.de>
 <20240726000409.ejnvqkzco664q3zb@pali>
 <20240726002538.558a4a97@5400>
 <8fde7bae-b4e3-458e-8edc-22199f8bc7e2@gmx.de>
 <5cfe4c42-a003-4668-8c3a-f18fb6b7fba6@gmx.de>
 <20240807172832.09040123@5400>
 <20240807214413.emwpxferfbcp7vlp@pali>
 <20240807180511.436bc1af@5400>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="llehenodjgimsuzd"
Content-Disposition: inline
In-Reply-To: <20240807180511.436bc1af@5400>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/222.972.32
X-ZohoMailClient: External


--llehenodjgimsuzd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 07, 2024 at 06:05:11PM GMT, Andres Salomon wrote:
> > > > [...]
> > >
> > > Do you think it's worth keeping around the sysfs-class-power-dell
> > > file? At this point it's basically just documenting the slight naming
> > > differences:
> > >=20
> > >=20
> > >                 Standard:
> > >                         Fully charge the battery at a moderate rate.
> > >                 Fast:
> > >                         Quickly charge the battery using fast-charge
> > >                         technology. This is harder on the battery than
> > >                         standard charging and may lower its lifespan.
> > >                         The Dell BIOS calls this ExpressCharge=E2=84=
=A2.
> > >                 Trickle:
> > >                         Users who primarily operate the system while
> > >                         plugged into an external power source can ext=
end
> > >                         battery life with this mode. The Dell BIOS ca=
lls
> > >                         this "Primarily AC Use".
> > >                 Adaptive:
> > >                         Automatically optimize battery charge rate ba=
sed
> > >                         on typical usage pattern.
> > >                 Custom:
> > >                         Use the charge_control_* properties to determ=
ine
> > >                         when to start and stop charging. Advanced use=
rs
> > >                         can use this to drastically extend battery li=
fe.
> > >=20
> > >                 Access: Read, Write
> > >                 Valid values:
> > >                               "Standard", "Fast", "Trickle",
> > >                               "Adaptive", "Custom" =20
> >=20
> > Another option could be to extend the description in sysfs-class-power
> > file that "Trickle" covers "Dell's Primarily AC Use" and "Fast" covers
> > "Dell's ExpressCharge".
> >=20
> > So if somebody is going to implement charge_type for some other Laptop
> > vendor then this information can help.
>=20
> How's this?
>=20
> @@ -378,8 +378,10 @@ Date:              July 2009
>  Contact:       linux-pm@vger.kernel.org
>  Description:
>                 Represents the type of charging currently being applied t=
o the
> -               battery. "Trickle", "Fast", and "Standard" all mean diffe=
rent
> -               charging speeds. "Adaptive" means that the charger uses s=
ome
> +               battery. "Fast" and "Standard" mean different charging sp=
eeds.
> +               "Trickle" means a slow charging speed, or (depending on t=
he
> +               hardware) charging optimized for being mostly plugged into
> +               wall power. "Adaptive" means that the charger uses some
>                 algorithm to adjust the charge rate dynamically, without
>                 any user configuration required. "Custom" means that the =
charger

Looks good from my side. OTOH I would also be fine with using your
Dell "specific" documentation as a replacement for the generic
documentation. But then "The Dell BIOS calls this XYZ" should be
replaced with "On Dell machines this mode is called XYZ".

Greetings,

-- Sebastian

--llehenodjgimsuzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAma0CIMACgkQ2O7X88g7
+pr+CxAAnBEMUO3sumOpnXxZ4CWSzmSwHTVTbM8aDZ/geddnbnOwhLwvugS7Esut
U3CETDhwFJVpBx44O5mbLFN9XtRiIHblMQhyEkD9sjXS5Om1m0DHTXm1uhMoPfnV
xZVc+KVsoP5FXq8xgoqp5EWjU17cOSTT1V7xBcpz7Imfnz86ud9zzhaaari/2OVu
YOZvdqBuEJd+RVKgn+wup7psE2yAj7s+MI8kSmXxWmENlrjERHjBj+MJfKfoWK0+
CECyBQqsx8TWAT8Yf0jGlstPKyG4yn7qNVJ0kPhNHfdZJD13Lz+w4wXn2ButFo/M
2niEB+svADncn4bDgyN15QDjEGgwPjQEhaTZFLddhupHNy5KyJMztK9yXTlvPAkG
T5yedXAuEGFXvBYGSQltokwxNO4DQMyg+IhhnNAKPSMGz5OzxVg6MJxPfH3DdE8h
4zOvEsAyBLidGC1BRgABPOUKIhlk/l0kvk2WbYtNBfuZYWB/8wtDBdpTx/7hk1HR
GBl5WTp94riBA2D8YtjCMEy9cIndmaFaKOCXvtd/ioXx4aZL8o6xbeASQN1MGd0k
JOc6e++fqYrNPtEbkd6hu3h37QRnHeoPvXM01UxMwp4KEdhl7eDHYulAWvwDOn6p
n5Rrl64RhViFWbGFlGCSycAa8EtjQNbo7G2vy9rxf68mv5WFYNQ=
=4tV8
-----END PGP SIGNATURE-----

--llehenodjgimsuzd--

