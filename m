Return-Path: <linux-pm+bounces-17351-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B399C48C6
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 23:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B3628908D
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 22:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C33166F32;
	Mon, 11 Nov 2024 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="imyVC+Kf"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C087F477;
	Mon, 11 Nov 2024 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362845; cv=pass; b=gyqeH6OANHtJf38w02A4cTaAbYGrdOX8LSkkRA71aOdFmv8T79OIRhCVdOsYJXjepUje08BvE16bsh5IjSk826CkTWZQ4HYxWmn+eyW5ShYnAena1jEWJ8/KNmazjIs0i11ypI9bEActhlXNbkJxzEJZmkao3m6AVfWo2gWIOYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362845; c=relaxed/simple;
	bh=e9q42B/7N4WlAuyztwSZ9VdcviFPUtwEoO/lcrc5lyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oonfllfl0UiIfc0TxyALGr8kq0tKY/0mb6jq2XrvDj1gcvVh1LkDBKsA/uZvsCfBFSNDcPukdsMe4afJQfZzwuQ2n8Eyi/NBU0IS8LfwSHWBJfMoZRFrGRB6tKGRETqrXCLPf+eG606HEzYCvtTIetKmyiHkUv2b3SYwfvO5frE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=imyVC+Kf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1731362836; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hFZehPDvm58jjuS1AU8JWoBz5FxXrL7A69N7520+tRBgFYZQZvNyLq8EyHrTiCIY/WWK0gXaoFuJSRkIny0P2c09FPbg5r2LFmhX+C5A8eZeU1Kvzk2woCOJrnvsNU04dR3LM5wlbfpvE3r09/u7GgHb3YhpwGjy47LSWrGUv1E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731362836; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hzLbd03HG2BFfh20ycJHkdjB0SaLheHeQWEBrY8n7kg=; 
	b=LXZwlHJnsW9gfYOHYqF1+Ms4L3z5Rbx8LS4L6OMoK1rnolGQbzk+eshrLm/RdT4HdnDkmx201kZWry69R14y7qWEfkE5gqz7PrX+htjjveuan0OhaRvh+13ahjnwl5ToMC7SGD+kObQY2qYUQleQTP6Nt2wGYrpHRW4kX6lTPSk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731362836;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=hzLbd03HG2BFfh20ycJHkdjB0SaLheHeQWEBrY8n7kg=;
	b=imyVC+KfjdILBJVY8chRNSocuiTVSVO5MBuYVzCgmQB77YoDlEc034A4uMGRSb/I
	CXDVS9H9Qw4+Ah7jXaE9gJUdMVThuszFZ5X2HRLJ9sRxZQvoblxmVvojgBYHppEDKaM
	mOVc7XPUsFhFMaqDdIH5Z62IhQMTMuhmtRgYeJeI=
Received: by mx.zohomail.com with SMTPS id 1731362835355973.3650981655287;
	Mon, 11 Nov 2024 14:07:15 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id E804A1060457; Mon, 11 Nov 2024 23:07:11 +0100 (CET)
Date: Mon, 11 Nov 2024 23:07:11 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jennifer Berringer <jberring@redhat.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/3] power: reset: nvmem-reboot-mode: fix write for
 small cells
Message-ID: <x2iuidzuodgo35iy5rvtmowz3o4s6nurrpunyhvvqniujmgpg5@hwrup7rr5pmc>
References: <20241104152312.3813601-1-jberring@redhat.com>
 <20241104152312.3813601-4-jberring@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2uq3qzykfhdkdn5j"
Content-Disposition: inline
In-Reply-To: <20241104152312.3813601-4-jberring@redhat.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/231.261.35
X-ZohoMailClient: External


--2uq3qzykfhdkdn5j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 3/3] power: reset: nvmem-reboot-mode: fix write for
 small cells
MIME-Version: 1.0

Hi,

On Mon, Nov 04, 2024 at 10:23:12AM -0500, Jennifer Berringer wrote:
> Some devices, such as Qualcomm sa8775p, have an nvmem reboot mode cell
> that is smaller than 32 bits, which resulted in
> nvmem_reboot_mode_write() failing. Using nvmem_cell_write_variable_u32()
> fixes this by writing only the least-significant byte of the magic value
> when the size specified in device tree is only one byte.
>=20
> Signed-off-by: Jennifer Berringer <jberring@redhat.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/reset/nvmem-reboot-mode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/rese=
t/nvmem-reboot-mode.c
> index 41530b70cfc4..b52eb879d1c1 100644
> --- a/drivers/power/reset/nvmem-reboot-mode.c
> +++ b/drivers/power/reset/nvmem-reboot-mode.c
> @@ -24,7 +24,7 @@ static int nvmem_reboot_mode_write(struct reboot_mode_d=
river *reboot,
> =20
>  	nvmem_rbm =3D container_of(reboot, struct nvmem_reboot_mode, reboot);
> =20
> -	ret =3D nvmem_cell_write(nvmem_rbm->cell, &magic, sizeof(magic));
> +	ret =3D nvmem_cell_write_variable_u32(nvmem_rbm->cell, magic);
>  	if (ret < 0)
>  		dev_err(reboot->dev, "update reboot mode bits failed\n");
> =20
> --=20
> 2.46.2
>=20
>=20

--2uq3qzykfhdkdn5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmcygA8ACgkQ2O7X88g7
+pp0tw//SayViUspcDf8LsO+rs4zeH5MyQ//lWRTjD+nPERPrniUJC6RxRRAoNx6
QqQ2rCvAdB/P+tPfF3LKimtJnmko5zgUQ1Avg8EFzABoL5sgkDdz6V71mRar5bJA
ojBRsys49TGdUG5GmRMUAmRPMh+pq/rxyfF2HbiMMe//TjVIVW45VHji1mNhJPYf
aLvswDLJpjCuEG/sjWmp0hv5juZwry7ea3OS/wsdBVqi5XrtdclkNSUgKC/Qa0yi
wLWxqHZEOifYTp+Kp6PZtV21QcGQ+wUPP0IDKK0gOOLpWE8V6arTvpwBRZZxDHDF
3GqtRefrsKTKiL+4/1i1/4DuuJdsylPWmdl5uxAluCIn9BHHGFSsy5BdR1dfwpcr
aA5EcuYJg/yDY8xhSdEeU3A1Jcp/kAO/+BjoTq/kXPneAk+8hcAVM3uptkwNoEn1
KS7aiZ4wULK4jIRdTV5Xpm4s60uXhwc6Uhc+eHiwLTPndh6kSt2bkb/v2XKrXA6O
6G/YGsmrKiYaJ0Np9yKa2BPjjOIbXgDERNYfsyHh5HkmpVcuh2X1XBIXkup4G5/n
H6JtoOQqM3PYPewf6frAsqKvcVoVea6e3hWZWJsvPw1gOMWH6R59Fr1WXruV2sDP
e6EcUmwz//7EJvX35mEQm7Zi/Ivf25KgNTUEOavN+gvRLms98Wk=
=rvxO
-----END PGP SIGNATURE-----

--2uq3qzykfhdkdn5j--

