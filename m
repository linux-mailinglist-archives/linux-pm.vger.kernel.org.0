Return-Path: <linux-pm+bounces-37265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F277C29979
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 00:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62201188D27D
	for <lists+linux-pm@lfdr.de>; Sun,  2 Nov 2025 23:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229F3223DDF;
	Sun,  2 Nov 2025 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="H56NZ9kx"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF14148850;
	Sun,  2 Nov 2025 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762125147; cv=pass; b=o446el9PdWtK4ejtE5JRxKeYsQ4yNqrc0CYlxCiX1icz+iX8Nd6IvmjjjRtWKBbzey5eqgJFZPBAL8c1qF6tPxvGYOt0xcLuqnHpFBUMMp95c/Jp74zWWAsRgHdzbpRTXduCLhAMLAGCF+GS5jXur4/VKdI1s67Z6lAaoxDfw+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762125147; c=relaxed/simple;
	bh=/I7IzlSpR4PhZPVQQEaWMofel6wmantN5OvKHYzkmvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biRAER8TIssf71OXqmqilwyaNXSv1C9LJ5wUAVlsoObdAro2u5czOdzqcTW982tEYB9mN7zXNI7nmO3t5rwU8rkuqGJVOFwFo31t8Q/kIlLvC5rVip8CxJMITOexZEksRL+Lp8XYPNgPE+J4LDH+U12xxNr/y1cS+I6zRlwtVtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=H56NZ9kx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1762125132; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ayHSoO8mmqJf6BpyOjVPFOjzRHu1WL3LnRrZaK8Pxss8qw9RqmiwBJUjwAmlIDsMeQnQqsCdodhkM+118cH86lu2c6ugvpYdWhiKVqy7vEj3258SwG8eDdqgt62QeRCVGcsg4wZGR0IkKE7/AeWH/1nZyxRdOaijcNYzCMEvPG0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762125132; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZQyV7+HH5+eyEXPG+O2c+IhWlprTdduqC8iGfXHsZNk=; 
	b=clccRMONHLMHPkLA5tA5Rftdar2TecDMeXdnud831QIBjDB//IlPDNMKnOIgLtz+ntjnRZFEuTtn3lSQqhdHen1ckE0GLxw/ScztgDH55oBuJdzqIZ4o4QrRZLMuzgV/B3KMHaJW9Cb/r2rNCIoFKvh0/+pZkq64vGU1/Kk84Ns=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762125132;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=ZQyV7+HH5+eyEXPG+O2c+IhWlprTdduqC8iGfXHsZNk=;
	b=H56NZ9kxWSHWpyt0trC8Z8jveyB6zse0BEvnPj9CQLsSQVd31Yrs1H7bSFSQCI08
	R772ZTJ0lHvKTF2poe32NVwN88wYaKhxNkNk6HhLiTJ/kItNzS7gd8B78vX0z/+70P1
	q/mLphXYH1Yw8Rw5WEd+5HUBCdZ2J3abRyClJBvs=
Received: by mx.zohomail.com with SMTPS id 1762125130375852.2930709562752;
	Sun, 2 Nov 2025 15:12:10 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id DD16D180CDA; Mon, 03 Nov 2025 00:11:54 +0100 (CET)
Date: Mon, 3 Nov 2025 00:11:54 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org, 
	gregkh@linuxfoundation.org, akuchynski@chromium.org, abhishekpandit@chromium.org, 
	kenny@panix.com, linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: psy: Set max current to zero when
 disconnected
Message-ID: <ew2yygmisdxp5jlefbg64abxzjp5wpxvwnmlhcwedgnzzr2qzs@huem73pm7sr5>
References: <20251017223053.2415243-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rdmgxygmaxf4b76y"
Content-Disposition: inline
In-Reply-To: <20251017223053.2415243-1-jthies@google.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/262.86.93
X-ZohoMailClient: External


--rdmgxygmaxf4b76y
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] usb: typec: ucsi: psy: Set max current to zero when
 disconnected
MIME-Version: 1.0

Hi,

On Fri, Oct 17, 2025 at 10:30:53PM +0000, Jameson Thies wrote:
> The ucsi_psy_get_current_max function defaults to 0.1A when it is not
> clear how much current the partner device can support. But this does
> not check the port is connected, and will report 0.1A max current when
> nothing is connected. Update ucsi_psy_get_current_max to report 0A when
> there is no connection.
>=20
> v2 changes:
> - added cc stable tag to commit message
>=20
> Fixes: af833e7f7db3 ("usb: typec: ucsi: psy: Set current max to 100mA for=
 BC 1.2 and Default")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jameson Thies <jthies@google.com>
> Reviewed-by: Benson Leung <bleung@chromium.org>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Tested-by: Kenneth R. Crudup <kenny@panix.com>
> ---

With the changelog moved under ---:

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  drivers/usb/typec/ucsi/psy.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
> index 62a9d68bb66d..8ae900c8c132 100644
> --- a/drivers/usb/typec/ucsi/psy.c
> +++ b/drivers/usb/typec/ucsi/psy.c
> @@ -145,6 +145,11 @@ static int ucsi_psy_get_current_max(struct ucsi_conn=
ector *con,
>  {
>  	u32 pdo;
> =20
> +	if (!UCSI_CONSTAT(con, CONNECTED)) {
> +		val->intval =3D 0;
> +		return 0;
> +	}
> +
>  	switch (UCSI_CONSTAT(con, PWR_OPMODE)) {
>  	case UCSI_CONSTAT_PWR_OPMODE_PD:
>  		if (con->num_pdos > 0) {
>=20
> base-commit: e40b984b6c4ce3f80814f39f86f87b2a48f2e662
> --=20
> 2.51.0.858.gf9c4a03a3a-goog
>=20
>=20

--rdmgxygmaxf4b76y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmkH5TMACgkQ2O7X88g7
+pqi+Q/+Pltm/IIiUpzgPlhsQz6XHkNwE/kGgNAA1AUNm1BibTCQMpPd7D7t4g/e
b67zrwhpZDeEAZpBHB/fzihFNZhlBLSivKAESxC+zPgvAFXPdZbLJxImRpKj622x
qbOpyGCljdTsL/Sc8/dK6KE3QSvSwmiijezde6e7QCd2Oxw7gro/ZLBrLEcEDagG
BgyyP3NbEAHhBPK8tThJZnnxWyqEuw5kCn1ZHuErfis7rBC8zapH6OvRD+pPajlg
mj7g6MIZl7mr2mun/TDeU0FK3iPj/jrGdH9hHk9/ZVWGhY0B+OgPE1ERnMaPXwUd
Sut2arlKZZojRiUcW9j+Hk8EsPGyVXxSG+5aezWJvNCNSo5/PVgEnLfb5uWeO64v
0RIHEad95tG3/qqiJWkm+yE2xX6gMUcKXzLeG2keG0Nm1MOQg/wnM/2ZU9XLlR5q
lhACnE7PYGUwYmGqCDrqnjrhWIDGTYNit4Vw8wj935r+UFnvdl5bqSG2l6byZhb9
1I8nhht0gW/sABKJXuQ/kOo99GSWy3b7XIG8yqtN3yLDfcgUVl190jsA/dtHYRlm
WuijbVSz83exJI769xt/BU3PMOz9rslEKRWDLLhge+7irftCgPpP0S+wZq6pJIcg
xHT6zH4l7nfVvRISQ4d3y6b+/+P5lAlaeO2vdSDIysJ19phznMk=
=XP49
-----END PGP SIGNATURE-----

--rdmgxygmaxf4b76y--

