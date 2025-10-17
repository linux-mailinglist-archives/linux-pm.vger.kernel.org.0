Return-Path: <linux-pm+bounces-36314-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5CFBE5DB2
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 02:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A32724E180A
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 00:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9981758B;
	Fri, 17 Oct 2025 00:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IjgxsJ2m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89601C27
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 00:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760659753; cv=none; b=q2ZUyfxD6kLzn8+rx13IaxMNlzEE4yhrpbAcmM33XwTDvPwCnH4BrxOHGlQWevBbLom2cvwGYph1juA02Q8rhF792tvolDAIU14y3qtdPgBixEfaAG/uBICmqNSW/25mU3iG7aJmhO/5UIs58SzBUXSSZCSZCFBuIGEO9jhqx1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760659753; c=relaxed/simple;
	bh=VSl0JaiEc0HWJb/hlVJi0cWip5mVlh9mlKtsFZaIYWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYuNnB4Hz/0E5QHLIHMPOXgsf6tpKsS6hS1vqLO1YEUp9hyJzG7XeMhCgK2GsvD9yaB8pS9z93ohpJjMpESNm/7aUowPDUHg5RYfQX+4JJrjjtwZQ2BzjrMsOxD6bkgzubAOTK+IvhUV4iREz+hsNkvKT1lFF27axv/2oBv+160=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IjgxsJ2m; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77f5d497692so1777466b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 17:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760659751; x=1761264551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NXnDH8yeXEI7/Kj3lSKr3kIGNlgj2iQ7E3EGf2Rbg74=;
        b=IjgxsJ2mxMKbDwD1GQvxFMAt1aW/jL+ZVYM7ju2WervEYDaeRV5RVlTab5LPIZZ8Tf
         zdf5rhZU/CpAlAsngVAMq4L2OaWWYhBDpi6BVnwpUTLMeRkKugcbEt5RhchwPTadWkXV
         GgPoSSz8g0+bqq8I/y8Fq2fuyChm8tGC+QXyXIR+Qd7LUXBt9RSE2otk0V6UWEY5BYwd
         fvUqwmXoDC3arWDBwIYHmJnn+gxdjNHSSY5sH67/O674yL0zz4uQRRSu1LvS7L87GnZl
         luLYFZLQjBPXbIZn3XwD6oH6/IZBnwiFPWnZToKDch7+HG/ktm+wucOXkiplJSMh/4m/
         wqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760659751; x=1761264551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXnDH8yeXEI7/Kj3lSKr3kIGNlgj2iQ7E3EGf2Rbg74=;
        b=GUJy7Xjmg9HbyFkf/gyUrUWhQ8zsLHQB3RDfIaZ4NCmlaVuU0rtJh8RJ04Otg3hOTw
         +ELTZ6jmCChIs61xLgDOvZyMVcovHmcruVoEH0/G6WZlqUMAadqAVRv85nMKYB/Ml0Ri
         N8miAlu0KvZdhpvdFvJi/MOofC3gkIT3bkQch8XYbY/F65zibDIPP+hLG+VJZAr8lveg
         lR/RL1RdhIY0tZjS1d4LkwGN1/yHpbLzeDf72hKblto3B+/8c8beOG2BT7DRIeYNK1jA
         fyD8ajiMnotr+yBhwNc/Z6e8YFmmW0egJZAz4SrgLWXLxqeUPL3d587sKPALC33cafL7
         ixXg==
X-Forwarded-Encrypted: i=1; AJvYcCWMI/pI9Q92C3L17rUAI1DFmMls20hXQeHqFdu59Ez+4zJrJFEqtYa67FoFmfIqL00prlQ+jA2L9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZ7tG87+U15L+fc9JL0YeXPu08+msjsZUUWkm4clIV74SrGZG
	n7pyrBsUQ2vTwfHwgzp6KA57nFK03E8UmQrGP4bIJXhe5Qxa0HAe+VBOwiriVJss+A==
X-Gm-Gg: ASbGncvTXvgqmGGV9s3oQCN4gMaSqCfDGwl7dv6bSVQePEt7nhrXqdwsTlufWAlPLyY
	Hu7zhdwbCgqFzmVtvY2HcbiywQcXHMcN7pfKpcVSA+iN2yBzhxsy4yiA+ux6j8UZUM3lSl4u22r
	JeX8kzdVGS3zKLF4BOgcTrbRajAO9/CqTbrFhGBElv0xvq9xxnHMdg7Df1XD8DlNkEA7hJl8GQe
	PSw0mNAS+jHTrNAHt2N+UtSKFeuqymWHRgB8vXMiOQFXz+7WEbBAhWaE2/L4+iMDvgyn33tjHot
	KeuI7TkRsAKMTHhgEjTzTcR0SzrUSaejmqn+CrlSpLdXygfGYh4ZTBSh89S1CyUSdqBKJ280ceP
	k2aKeUZS3hdZgsk8eGCi1E/i/bgKyw+U/5ZQ2j8t8weNvo1lNh1oYIa89s+YLElrSIbWV3wwTEP
	75M2LeSP1HGzPTq2k8yJpe9h0c3eFNJW0YMSmAjuMQ/qg=
X-Google-Smtp-Source: AGHT+IGG75zRnExiCUHFLBI4WVBweds66/l9+7yNf2K5kk/4fpgNKkbEvIry2xyN+92Prx/hDFAm7Q==
X-Received: by 2002:a05:6a20:1588:b0:334:a710:14a with SMTP id adf61e73a8af0-334a8630420mr2228597637.42.1760659750743;
        Thu, 16 Oct 2025 17:09:10 -0700 (PDT)
Received: from google.com (232.92.83.34.bc.googleusercontent.com. [34.83.92.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d096527sm23605651b3a.44.2025.10.16.17.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 17:09:09 -0700 (PDT)
Date: Fri, 17 Oct 2025 00:09:06 +0000
From: Benson Leung <bleung@google.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
	bleung@chromium.org, gregkh@linuxfoundation.org,
	akuchynski@chromium.org, abhishekpandit@chromium.org,
	sebastian.reichel@collabora.com, kenny@panix.com,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: typec: ucsi: psy: Add power supply status
Message-ID: <aPGJImOPx4yCWQnv@google.com>
References: <20251016235909.2092917-1-jthies@google.com>
 <20251016235909.2092917-2-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3t8E6xx6LIwij4Qm"
Content-Disposition: inline
In-Reply-To: <20251016235909.2092917-2-jthies@google.com>


--3t8E6xx6LIwij4Qm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 11:59:07PM +0000, Jameson Thies wrote:
> Add support for power supply status. If a port is acting as a sink
> with the sink path enabled, report it is charging. If a port is
> source, report it is discharging. If there is no connection or the
> port hasn't enabled the sink path, report not charging.
>=20
> Signed-off-by: Jameson Thies <jthies@google.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/usb/typec/ucsi/psy.c  | 26 ++++++++++++++++++++++++++
>  drivers/usb/typec/ucsi/ucsi.h |  3 +++
>  2 files changed, 29 insertions(+)
>=20
> diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
> index 62a9d68bb66d..2b0225821502 100644
> --- a/drivers/usb/typec/ucsi/psy.c
> +++ b/drivers/usb/typec/ucsi/psy.c
> @@ -29,6 +29,7 @@ static enum power_supply_property ucsi_psy_props[] =3D {
>  	POWER_SUPPLY_PROP_CURRENT_MAX,
>  	POWER_SUPPLY_PROP_CURRENT_NOW,
>  	POWER_SUPPLY_PROP_SCOPE,
> +	POWER_SUPPLY_PROP_STATUS,
>  };
> =20
>  static int ucsi_psy_get_scope(struct ucsi_connector *con,
> @@ -51,6 +52,29 @@ static int ucsi_psy_get_scope(struct ucsi_connector *c=
on,
>  	return 0;
>  }
> =20
> +static int ucsi_psy_get_status(struct ucsi_connector *con,
> +			       union power_supply_propval *val)
> +{
> +	bool is_sink =3D UCSI_CONSTAT(con, PWR_DIR) =3D=3D TYPEC_SINK;
> +	bool sink_path_enabled =3D true;
> +
> +	val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +
> +	if (con->ucsi->version >=3D UCSI_VERSION_2_0)
> +		sink_path_enabled =3D
> +			UCSI_CONSTAT(con, SINK_PATH_STATUS_V2_0) =3D=3D
> +			UCSI_CONSTAT_SINK_PATH_ENABLED;
> +
> +	if (UCSI_CONSTAT(con, CONNECTED)) {
> +		if (is_sink && sink_path_enabled)
> +			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +		else if (!is_sink)
> +			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ucsi_psy_get_online(struct ucsi_connector *con,
>  			       union power_supply_propval *val)
>  {
> @@ -245,6 +269,8 @@ static int ucsi_psy_get_prop(struct power_supply *psy,
>  		return ucsi_psy_get_current_now(con, val);
>  	case POWER_SUPPLY_PROP_SCOPE:
>  		return ucsi_psy_get_scope(con, val);
> +	case POWER_SUPPLY_PROP_STATUS:
> +		return ucsi_psy_get_status(con, val);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index e301d9012936..cce93af7461b 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -360,6 +360,9 @@ struct ucsi_cable_property {
>  #define   UCSI_CONSTAT_BC_SLOW_CHARGING		2
>  #define   UCSI_CONSTAT_BC_TRICKLE_CHARGING	3
>  #define UCSI_CONSTAT_PD_VERSION_V1_2		UCSI_DECLARE_BITFIELD_V1_2(70, 16)
> +#define UCSI_CONSTAT_SINK_PATH_STATUS_V2_0	UCSI_DECLARE_BITFIELD_V2_0(87=
, 1)
> +#define   UCSI_CONSTAT_SINK_PATH_DISABLED   0
> +#define   UCSI_CONSTAT_SINK_PATH_ENABLED    1
>  #define UCSI_CONSTAT_PWR_READING_READY_V2_1	UCSI_DECLARE_BITFIELD_V2_1(8=
9, 1)
>  #define UCSI_CONSTAT_CURRENT_SCALE_V2_1		UCSI_DECLARE_BITFIELD_V2_1(90, =
3)
>  #define UCSI_CONSTAT_PEAK_CURRENT_V2_1		UCSI_DECLARE_BITFIELD_V2_1(93, 1=
6)
> --=20
> 2.51.0.858.gf9c4a03a3a-goog
>=20

--3t8E6xx6LIwij4Qm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCaPGJIQAKCRBzbaomhzOw
wvV/AP9vZAs9Ieb0KT0LGXMlgmdu4qmENimGJXONN5zpi2P4JAD+IjsmMhhPrOXT
g7OzMTo8KghmmICaK71xlcZP+4zBUA0=
=M9iU
-----END PGP SIGNATURE-----

--3t8E6xx6LIwij4Qm--

