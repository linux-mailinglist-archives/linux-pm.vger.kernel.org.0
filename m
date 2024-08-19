Return-Path: <linux-pm+bounces-12496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AAF95778F
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 00:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F18284913
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 22:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B54D1E2110;
	Mon, 19 Aug 2024 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="GkS0QsGb"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984211DF668;
	Mon, 19 Aug 2024 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724106981; cv=pass; b=tL34+KKVwHT/rOCF2UzoEmFp9rJXtXgwP8WfaXcyS/AR9ks2XNThO4rOqZbLM4n+TkDR1/KhsIssv+/jKtcdIYvHIW6c6xPdx+NbhNa3Bcgy6oo6Jc+ECpBWt2De+IPAyTUGPGpRzy/NVt8qx0/WaHWmMjZ9Qx5f4MIS85zi1IU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724106981; c=relaxed/simple;
	bh=vVYRPMUXwoivmYXruiuClAV2tguKLgXsozynlJt1HEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqOEMd0bVjY+F0Znac3oJaGdZVaL2qFJFEGVJ6G8Yejpw4uN1yOcEtI5vA1a2SENKiNjCbDsW/Uox0d/6Y14MMjvha4PKC8e09kdKaN9Xw3cnzszvDVEjC9A0tHi1d0LeccAiYutVo0QpRQ5R7R5YKAIIAPVzBFysQxEb3+hM3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=GkS0QsGb; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724106968; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NlWzJXf1IR7ENfgteAZtiAc4MTwl2PMke+2plZH6lKu9iKJcvLgZt7sfc6V/+EHbOpEl/ZblcFglBg9UXqQ8k82XK0+zx7RZZF9pu+fiW1/ujs2CZtv62gEdAtsy+xEXSVyizNvu3wHpTFLPoTKpSVNMUpuuemXNf9ljHVn33zw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724106968; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=84R4bvv7IZLyjELsDi3Ih0SAs9c0fPyp02siqdBkv0U=; 
	b=R4C/ysIzn+ZhhRDCih+ARRnICUKtPGvr5dxkjB0kF0jnab9vobmbLgqKU6S9IAF6zRrgi50Ccd0ubkdRwn3Ldyv4Aec12ZyfSJGeVKIcjxZNVQvUJ/+ZTIyt5W72eHZK333heHdrwvcrX9xlWS5YwZIQjqC1kczS/s8DKmMTys0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724106968;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=84R4bvv7IZLyjELsDi3Ih0SAs9c0fPyp02siqdBkv0U=;
	b=GkS0QsGbFt2tIfjK7M5BAhnoVRSTqrQen1IkYxiaHeXjUHOeDeFxi2fI/2HiSEHP
	fKbW2RsZT8zhhJGPapL0kMM99agq4LMZCcG64BsJAkAYqa+grGzvYy8ycwlUsiHzJV5
	jyOIEyKqwp8uVxbMjtHSh5oCPZYzKKCVh9xoWkBg=
Received: by mx.zohomail.com with SMTPS id 1724106967349278.4839605441748;
	Mon, 19 Aug 2024 15:36:07 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id 4D966106045A; Tue, 20 Aug 2024 00:36:01 +0200 (CEST)
Date: Tue, 20 Aug 2024 00:36:01 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Chris Lew <quic_clew@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Stephen Boyd <swboyd@chromium.org>, 
	Amit Pundir <amit.pundir@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] soc: qcom: pmic_glink: Fix race during
 initialization
Message-ID: <m7vc5zw2yxswrxnbyqxsq7hj3spz5or26p6ze7x477ggur3vmz@mm24cmj5vran>
References: <20240819-pmic-glink-v6-11-races-v2-0-88fe3ab1f0e2@quicinc.com>
 <20240819-pmic-glink-v6-11-races-v2-1-88fe3ab1f0e2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="knpdcbbcaewcpyeo"
Content-Disposition: inline
In-Reply-To: <20240819-pmic-glink-v6-11-races-v2-1-88fe3ab1f0e2@quicinc.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/224.60.1
X-ZohoMailClient: External


--knpdcbbcaewcpyeo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 19, 2024 at 01:07:45PM GMT, Bjorn Andersson wrote:
> As pointed out by Stephen Boyd it is possible that during initialization
> of the pmic_glink child drivers, the protection-domain notifiers fires,
> and the associated work is scheduled, before the client registration
> returns and as a result the local "client" pointer has been initialized.
>=20
> The outcome of this is a NULL pointer dereference as the "client"
> pointer is blindly dereferenced.
>=20
> Timeline provided by Stephen:
>  CPU0                               CPU1
>  ----                               ----
>  ucsi->client =3D NULL;
>  devm_pmic_glink_register_client()
>   client->pdr_notify(client->priv, pg->client_state)
>    pmic_glink_ucsi_pdr_notify()
>     schedule_work(&ucsi->register_work)
>     <schedule away>
>                                     pmic_glink_ucsi_register()
>                                      ucsi_register()
>                                       pmic_glink_ucsi_read_version()
>                                        pmic_glink_ucsi_read()
>                                         pmic_glink_ucsi_read()
>                                          pmic_glink_send(ucsi->client)
>                                          <client is NULL BAD>
>  ucsi->client =3D client // Too late!
>=20
> This code is identical across the altmode, battery manager and usci
> child drivers.
>=20
> Resolve this by splitting the allocation of the "client" object and the
> registration thereof into two operations.
>=20
> This only happens if the protection domain registry is populated at the
> time of registration, which by the introduction of commit '1ebcde047c54
> ("soc: qcom: add pd-mapper implementation")' became much more likely.
>=20
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Closes: https://lore.kernel.org/all/CAMi1Hd2_a7TjA7J9ShrAbNOd_CoZ3D87twmO=
5t+nZxC9sX18tA@mail.gmail.com/
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/all/ZqiyLvP0gkBnuekL@hovoldconsulting.com/
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Closes: https://lore.kernel.org/all/CAE-0n52JgfCBWiFQyQWPji8cq_rCsviBpW-m=
72YitgNfdaEhQg@mail.gmail.com/
> Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK dr=
iver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

I expect this to go through SOC tree:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/qcom_battmgr.c   | 16 ++++++++++------
>  drivers/soc/qcom/pmic_glink.c         | 28 ++++++++++++++++++----------
>  drivers/soc/qcom/pmic_glink_altmode.c | 17 +++++++++++------
>  drivers/usb/typec/ucsi/ucsi_glink.c   | 16 ++++++++++------
>  include/linux/soc/qcom/pmic_glink.h   | 11 ++++++-----
>  5 files changed, 55 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/q=
com_battmgr.c
> index 49bef4a5ac3f..df90a470c51a 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -1387,12 +1387,16 @@ static int qcom_battmgr_probe(struct auxiliary_de=
vice *adev,
>  					     "failed to register wireless charing power supply\n");
>  	}
> =20
> -	battmgr->client =3D devm_pmic_glink_register_client(dev,
> -							  PMIC_GLINK_OWNER_BATTMGR,
> -							  qcom_battmgr_callback,
> -							  qcom_battmgr_pdr_notify,
> -							  battmgr);
> -	return PTR_ERR_OR_ZERO(battmgr->client);
> +	battmgr->client =3D devm_pmic_glink_new_client(dev, PMIC_GLINK_OWNER_BA=
TTMGR,
> +						     qcom_battmgr_callback,
> +						     qcom_battmgr_pdr_notify,
> +						     battmgr);
> +	if (IS_ERR(battmgr->client))
> +		return PTR_ERR(battmgr->client);
> +
> +	pmic_glink_register_client(battmgr->client);
> +
> +	return 0;
>  }
> =20
>  static const struct auxiliary_device_id qcom_battmgr_id_table[] =3D {
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index 9ebc0ba35947..58ec91767d79 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -66,15 +66,14 @@ static void _devm_pmic_glink_release_client(struct de=
vice *dev, void *res)
>  	spin_unlock_irqrestore(&pg->client_lock, flags);
>  }
> =20
> -struct pmic_glink_client *devm_pmic_glink_register_client(struct device =
*dev,
> -							  unsigned int id,
> -							  void (*cb)(const void *, size_t, void *),
> -							  void (*pdr)(void *, int),
> -							  void *priv)
> +struct pmic_glink_client *devm_pmic_glink_new_client(struct device *dev,
> +						     unsigned int id,
> +						     void (*cb)(const void *, size_t, void *),
> +						     void (*pdr)(void *, int),
> +						     void *priv)
>  {
>  	struct pmic_glink_client *client;
>  	struct pmic_glink *pg =3D dev_get_drvdata(dev->parent);
> -	unsigned long flags;
> =20
>  	client =3D devres_alloc(_devm_pmic_glink_release_client, sizeof(*client=
), GFP_KERNEL);
>  	if (!client)
> @@ -85,6 +84,18 @@ struct pmic_glink_client *devm_pmic_glink_register_cli=
ent(struct device *dev,
>  	client->cb =3D cb;
>  	client->pdr_notify =3D pdr;
>  	client->priv =3D priv;
> +	INIT_LIST_HEAD(&client->node);
> +
> +	devres_add(dev, client);
> +
> +	return client;
> +}
> +EXPORT_SYMBOL_GPL(devm_pmic_glink_new_client);
> +
> +void pmic_glink_register_client(struct pmic_glink_client *client)
> +{
> +	struct pmic_glink *pg =3D client->pg;
> +	unsigned long flags;
> =20
>  	mutex_lock(&pg->state_lock);
>  	spin_lock_irqsave(&pg->client_lock, flags);
> @@ -95,11 +106,8 @@ struct pmic_glink_client *devm_pmic_glink_register_cl=
ient(struct device *dev,
>  	spin_unlock_irqrestore(&pg->client_lock, flags);
>  	mutex_unlock(&pg->state_lock);
> =20
> -	devres_add(dev, client);
> -
> -	return client;
>  }
> -EXPORT_SYMBOL_GPL(devm_pmic_glink_register_client);
> +EXPORT_SYMBOL_GPL(pmic_glink_register_client);
> =20
>  int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t=
 len)
>  {
> diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmi=
c_glink_altmode.c
> index 1e0808b3cb93..e4f5059256e5 100644
> --- a/drivers/soc/qcom/pmic_glink_altmode.c
> +++ b/drivers/soc/qcom/pmic_glink_altmode.c
> @@ -520,12 +520,17 @@ static int pmic_glink_altmode_probe(struct auxiliar=
y_device *adev,
>  			return ret;
>  	}
> =20
> -	altmode->client =3D devm_pmic_glink_register_client(dev,
> -							  altmode->owner_id,
> -							  pmic_glink_altmode_callback,
> -							  pmic_glink_altmode_pdr_notify,
> -							  altmode);
> -	return PTR_ERR_OR_ZERO(altmode->client);
> +	altmode->client =3D devm_pmic_glink_new_client(dev,
> +						     altmode->owner_id,
> +						     pmic_glink_altmode_callback,
> +						     pmic_glink_altmode_pdr_notify,
> +						     altmode);
> +	if (IS_ERR(altmode->client))
> +		return PTR_ERR(altmode->client);
> +
> +	pmic_glink_register_client(altmode->client);
> +
> +	return 0;
>  }
> =20
>  static const struct auxiliary_device_id pmic_glink_altmode_id_table[] =
=3D {
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi=
/ucsi_glink.c
> index 16c328497e0b..ac53a81c2a81 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -367,12 +367,16 @@ static int pmic_glink_ucsi_probe(struct auxiliary_d=
evice *adev,
>  		ucsi->port_orientation[port] =3D desc;
>  	}
> =20
> -	ucsi->client =3D devm_pmic_glink_register_client(dev,
> -						       PMIC_GLINK_OWNER_USBC,
> -						       pmic_glink_ucsi_callback,
> -						       pmic_glink_ucsi_pdr_notify,
> -						       ucsi);
> -	return PTR_ERR_OR_ZERO(ucsi->client);
> +	ucsi->client =3D devm_pmic_glink_new_client(dev, PMIC_GLINK_OWNER_USBC,
> +						  pmic_glink_ucsi_callback,
> +						  pmic_glink_ucsi_pdr_notify,
> +						  ucsi);
> +	if (IS_ERR(ucsi->client))
> +		return PTR_ERR(ucsi->client);
> +
> +	pmic_glink_register_client(ucsi->client);
> +
> +	return 0;
>  }
> =20
>  static void pmic_glink_ucsi_remove(struct auxiliary_device *adev)
> diff --git a/include/linux/soc/qcom/pmic_glink.h b/include/linux/soc/qcom=
/pmic_glink.h
> index fd124aa18c81..aedde76d7e13 100644
> --- a/include/linux/soc/qcom/pmic_glink.h
> +++ b/include/linux/soc/qcom/pmic_glink.h
> @@ -23,10 +23,11 @@ struct pmic_glink_hdr {
> =20
>  int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t=
 len);
> =20
> -struct pmic_glink_client *devm_pmic_glink_register_client(struct device =
*dev,
> -							  unsigned int id,
> -							  void (*cb)(const void *, size_t, void *),
> -							  void (*pdr)(void *, int),
> -							  void *priv);
> +struct pmic_glink_client *devm_pmic_glink_new_client(struct device *dev,
> +						     unsigned int id,
> +						     void (*cb)(const void *, size_t, void *),
> +						     void (*pdr)(void *, int),
> +						     void *priv);
> +void pmic_glink_register_client(struct pmic_glink_client *client);
> =20
>  #endif
>=20
> --=20
> 2.34.1
>=20

--knpdcbbcaewcpyeo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmbDyMkACgkQ2O7X88g7
+pp5Nw//Uv13QigZP+EGQ5BD0t2vMaiDNi3taRY7bU4yE8WKk2k7GmVRi5Rpgm2F
kpR+f4tZnXCD6U+xv8dK4sYQ0qK49m4NN7EoxTmblWsCz9/czyu3SzUbTTJqf7kI
P9ilSWAxEi4K89vZvTOEwrBF8gvCpNpKE1MvNx0W9K+qQlu3heXQpRWjM+22uQyA
IOWVtvA4+RJUc7skpRxYtmA6OwEMhIOvWGklEUXAl8qqxSrHCy5gWYTMoiLq15cB
qrdMMqnVd0evBesZeglYTo5AHt5/wflWtIyUDQ38Md4QNHNlT/N+NoMhPYVOetV4
wBf0Q4dYW1NIhERqow1Ks/ATveZijf0l4d5pBqLo2hfuC3FL8W28U/jGyWRWi1zq
/2YefcGTYwfRZ273pzimgeZR3MiG9UZk4OgRukZ6ETpsm/v+ZgwEGPddoZSDme1V
h3Qs9fLW22+mqIPka3GSvevYf8Y/4dhJTmNhDT6elepNs9leB+jxsluI2b+2Fvni
dKVuNLMRRgJJ+2T5ANBzWAVxYentv1uSpyiqpXbw0A99kNEC6CNZB5Uf+muExHHV
G5nWNOXi76GER2qFcOkk03qEGpqX4+zaFfz+/CeIMFvN7MpWzAG9NhUMT5eduOnj
PZFvHWOHvKjpaHvxpZFkEqS93KrRO46mu6bL+4SpZNRvZ7ZFXeA=
=T2J1
-----END PGP SIGNATURE-----

--knpdcbbcaewcpyeo--

