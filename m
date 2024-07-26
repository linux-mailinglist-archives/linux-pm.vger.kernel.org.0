Return-Path: <linux-pm+bounces-11462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 353EE93DA30
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 23:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5F51F24366
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2024 21:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BE6143C40;
	Fri, 26 Jul 2024 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3m/ESuQ7"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAF238DEE;
	Fri, 26 Jul 2024 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722029443; cv=none; b=QBxb4p1qoWKASiF8lC0cHOUzikefWxyZKHh/0gyyteCub2a7zG3IsJNCGRh+2R2Gm4MxS7/i495zYPovt02dvGzINhoB8cXaVzkyRMOjrNgXFay44GYu1VqswddrFJNhg4BiBYNMQe6Wgjwq7wFq/s2KzGuOKzq0ZP7XuBiqEbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722029443; c=relaxed/simple;
	bh=P0f+aG8YLTqaJQzziKinOzYx/AvYQ071j9jvqmbzf0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJFpXGt9MaERuGpq4o45LftTaEpx1nZkQJYboEpmhwfDXWrfyHMe8yJM+gCFlNUv+DrgeEZr1oAXqufbRB42dJU1Hppw/DJfOa2igPFcg2h1W9pj7/t1DFcBHtn/YViWrwu9eSmJNniVfwzC8AoQbxVrm1a1KXzylXy0Jhmz92s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3m/ESuQ7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722029440;
	bh=P0f+aG8YLTqaJQzziKinOzYx/AvYQ071j9jvqmbzf0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=3m/ESuQ7CpqiyowL8oOI/ML1V6ite/dxLIaZZpmcnoegbNQ0JVnyLn0Re+SywaqD6
	 XC9ltiELzCFTvhr6YF1vQtPpTznfSUmJ+H4zoBvqTrz7Wnogs1icgzlXowPwTHPB50
	 oEGh4K0UOgk6E3AlAzOnhp8jeSln42FGd+rVoY7OGv+VxHNl3ETPNwOCPHjjnzaqCL
	 8G1IDsiZEz5stqV7wfd8BsCLwcTKGXsyPJnCKP/63GHtWTRI18LGNNPu4cd1smcIKl
	 06eFN2s+RWCrsjq14SqEE65mjKG8CBQ/X2ZkL1H02HazcCyvlUFAAfpLIq1pxsNg4e
	 IaCIhYFqGPreA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3D56537821C0;
	Fri, 26 Jul 2024 21:30:40 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id A1264106097F; Fri, 26 Jul 2024 23:30:37 +0200 (CEST)
Date: Fri, 26 Jul 2024 23:30:37 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jameson Thies <jthies@google.com>, heikki.krogerus@linux.intel.com, 
	linux-usb@vger.kernel.org, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, 
	hdegoede@redhat.com, neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] usb: typec: ucsi: Add status to UCSI power supply
 driver
Message-ID: <up2clptjacrc2n2ibzkpv5od47pky6im3pzzgjuymm4xd7ielu@ulg7lb2u5lih>
References: <20240724201116.2094059-1-jthies@google.com>
 <20240724201116.2094059-2-jthies@google.com>
 <tzljywuym6jsh5q5iuc7rrtq564d3ffl3e4ltuii7xzkd6cf7d@2nmj5qkusbkt>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gxaustdnzg6e6jcp"
Content-Disposition: inline
In-Reply-To: <tzljywuym6jsh5q5iuc7rrtq564d3ffl3e4ltuii7xzkd6cf7d@2nmj5qkusbkt>


--gxaustdnzg6e6jcp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 25, 2024 at 06:31:00AM GMT, Dmitry Baryshkov wrote:
> On Wed, Jul 24, 2024 at 08:11:13PM GMT, Jameson Thies wrote:
> > Add status to UCSI power supply driver properties based on the port's
> > connection and power direction states.
> >=20
> > Signed-off-by: Jameson Thies <jthies@google.com>
>=20
> Please CC Power Supply maintainers for this patchset (added to cc).

Thanks. I guess I should add something like this to MAINTAINERS
considering the power-supply bits are in its own file for UCSI:

UCSI POWER-SUPPLY API
R:	Sebastian Reichel <sre@kernel.org>
L:	linux-pm@vger.kernel.org
F:	drivers/usb/typec/ucsi/psy.c

> At least per the Documentation/ABI/testing/sysfs-class-power, the status
> property applies to batteries, while UCSI psy device is a charger. This
> is logical, as there might be multiple reasons why the battery is not
> being charging even when the supply is online.

Correct. These status bits are not meant for chargers. E.g.
POWER_SUPPLY_STATUS_NOT_CHARGING has a very specific meaning, that a
battery is neither charged nor discharged. Since the device is
running that can only happen when a charger is connected, but not
charging (or the device has two batteries).

For AC the power-supply API has been designed only taking the SINK
role into account. At some point USB was added and some time later
people added reverse mode to their USB chargers for OTG mode. So
far this has been handled by registering a regulator and using that
to switch the mode. This made sense for OTG, but USB-C PD makes
things even more complex.

I am open to ideas how to properly handle the source role in the
power-supply API, but let's not overload the status property for
it. Please make sure to CC me on any follow-up series.

-- Sebastian

>=20
> > ---
> > Changes in V2:
> > - None.
> >=20
> >  drivers/usb/typec/ucsi/psy.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >=20
> > diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
> > index e623d80e177c..d0b52cee41d2 100644
> > --- a/drivers/usb/typec/ucsi/psy.c
> > +++ b/drivers/usb/typec/ucsi/psy.c
> > @@ -29,6 +29,7 @@ static enum power_supply_property ucsi_psy_props[] =
=3D {
> >  	POWER_SUPPLY_PROP_CURRENT_MAX,
> >  	POWER_SUPPLY_PROP_CURRENT_NOW,
> >  	POWER_SUPPLY_PROP_SCOPE,
> > +	POWER_SUPPLY_PROP_STATUS,
> >  };
> > =20
> >  static int ucsi_psy_get_scope(struct ucsi_connector *con,
> > @@ -51,6 +52,20 @@ static int ucsi_psy_get_scope(struct ucsi_connector =
*con,
> >  	return 0;
> >  }
> > =20
> > +static int ucsi_psy_get_status(struct ucsi_connector *con,
> > +			       union power_supply_propval *val)
> > +{
> > +	val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> > +	if (con->status.flags & UCSI_CONSTAT_CONNECTED) {
> > +		if ((con->status.flags & UCSI_CONSTAT_PWR_DIR) =3D=3D TYPEC_SINK)
> > +			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> > +		else
> > +			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int ucsi_psy_get_online(struct ucsi_connector *con,
> >  			       union power_supply_propval *val)
> >  {
> > @@ -249,6 +264,8 @@ static int ucsi_psy_get_prop(struct power_supply *p=
sy,
> >  		return ucsi_psy_get_current_now(con, val);
> >  	case POWER_SUPPLY_PROP_SCOPE:
> >  		return ucsi_psy_get_scope(con, val);
> > +	case POWER_SUPPLY_PROP_STATUS:
> > +		return ucsi_psy_get_status(con, val);
> >  	default:
> >  		return -EINVAL;
> >  	}
> > --=20
> > 2.45.2.1089.g2a221341d9-goog
> >=20
>=20
> --=20
> With best wishes
> Dmitry

--gxaustdnzg6e6jcp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmakFXcACgkQ2O7X88g7
+pr57w/9EBA0L5P8nxUJlgmdL1QGR61UIchbd0Re+ABJCNxJfrMpa/GjOD+trxe+
mqQcT05CvS2PUjadGvzUFOfisoVA93gIb19Y37spHrSyQED4hcEzz24CEmwgSeGi
oEdp7JytIKeI+uUZ+1pKHe+eiJbG1dTK/ol5f9ZhziAplbXFJ3E8aWQouPsodknE
GFPRTj5nroyvVgsIOXdqWIHDyKIMD8m3AfAxWTb5rvKRICmegIlY/hQx8Q+h1+CX
hvmMprU5ZeFBL2dJmmiH1kth04K437g0bW1OM1wfgcXALYFTXk0/3MWiu2xBUHZN
SXLTRCVv2fz1cxJlPBbeNZxq3ZWQ5tkfgwEEOL7uSgZHUgJ7kcS15rd2ty80vV8o
fgITMohtiM1Oclv1HiHgx58TkJyv/LJ0ttz/fzntkCVT5gKff5u97HUhrDm5r1iK
2X9KcL+jkIouP/e7RM7iQdGxlVd/p3dQmoK3ioxZln05MwEEMjl3rNwnsLa3Bh4/
FQKOMsY3kV9S3vbN/TLld5n5P+B6HtQ+UEV9ku6OC3ZV4GkACVja+pT3lEj0TXwE
m4MdQlXjwrd3kIBb8mZzMxXmhjMbmVifkPPZ6ip9jJBg4ZhKtD4hfJM3XzPjWNhd
dMq1QHhJ3GYXoL17xb7p4CZllvjgZ3WIQL9Mb2pAu6fe5ZCqvLA=
=kjxQ
-----END PGP SIGNATURE-----

--gxaustdnzg6e6jcp--

