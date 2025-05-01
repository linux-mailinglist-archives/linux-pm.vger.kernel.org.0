Return-Path: <linux-pm+bounces-26518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA04AA64F9
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 22:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70CFF3B0853
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 20:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A55A25334B;
	Thu,  1 May 2025 20:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="SvZDX8gz"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800807083A;
	Thu,  1 May 2025 20:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746132986; cv=pass; b=q84Jr4b191sBhC6Vp7o0ZYl1Docrh9v4rm0FB0a/5SovQFQA7T6FLPBnIzl2rtRVVycgU3WDWz/ggB6jbTSiH90EI4nemyolHJAzdbAhyG2cBJRH6IIpk8fOq8roq5o+6lTPs8T6PUKI0IHYXlpHFE+ytA7Rpbu3JCEodIoPjvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746132986; c=relaxed/simple;
	bh=AR2u9y7Zv7hlFqpjIItjRa1RagopaWPRRRrh8lVvNpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guVYYAneETTuNDMi4mxAyiEnLYQybbYGeqZeOqiNhewJT1oMKeYRIlD+WURdcVns3QMmXCcOmbp3UXe47tNqXIuHCzBVSHIe5TP9Z9JiEoCf4cs+CWlCrbaAjGiDlsZboiaOPWlvvFT4y6Dh2ljESnrz+QC6W8sMAzTnxeXDCmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=SvZDX8gz; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1746132968; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XyBwA2cWdi1P70N+md17Q742vFmDU5KMChNzmxKcQ5uGvMeO2r3LqNip1zfGwyqPKVxkczMFjOOqWbROPWJqYyzhuECJYFnPbG/CjaFnCzB8QnIPTDwtUSIpuE6tWVIrI8wJ3hfvBO3TR9nYKT9vioQB5j+pvCM73OjWBkbV15g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746132968; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dem3C+jxF8AzWRWAu3zu7Fy2SHhp8Gs9jIjyJ3leCHA=; 
	b=hzkFncqyJGzfk5w7bi3Flu0fNMfHGOrPTrSKb38CiuZmKWSvkJIZ2PXlD28iJ4I/kPfpVd0gT5JXcN1/c4BKlp7k3tbeN2+/ibUdhxqsd9r8AS3gtN819s1OTk6ymaEoRLTSmXvCDwrDxba3u6alpwe/hoQwBKJMN0qI76Tru2k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746132968;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=dem3C+jxF8AzWRWAu3zu7Fy2SHhp8Gs9jIjyJ3leCHA=;
	b=SvZDX8gz4I7J691UmxZFxCeT4qZJJAaPkS47PzrIdQCqxeavihxI8e0diwYMOa0D
	MfNN8C3Jw+/UV7/yAiq4v3XKEDnHA6TOEjyFinfz1m7f86ZZv3jn0RekfsK5xm13YEC
	yky7xLzQbjYzd3prz8Ee/bTTVpdVBk7rVF/3Kalk=
Received: by mx.zohomail.com with SMTPS id 1746132965654478.26179095762257;
	Thu, 1 May 2025 13:56:05 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id C1253180F5C; Thu, 01 May 2025 22:55:59 +0200 (CEST)
Date: Thu, 1 May 2025 22:55:59 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>, Guenter Roeck <groeck@chromium.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v9 1/7] power: Extend power_on_reason.h for upcoming
 PSCRR framework
Message-ID: <rru5zkm7mp3zk43oobf2opljqts5hhp2lszlci4cjlnijcdb5w@ws2ibs7bi5zm>
References: <20250422085717.2605520-1-o.rempel@pengutronix.de>
 <20250422085717.2605520-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f3qpswvixtgt5nq6"
Content-Disposition: inline
In-Reply-To: <20250422085717.2605520-2-o.rempel@pengutronix.de>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/246.120.57
X-ZohoMailClient: External


--f3qpswvixtgt5nq6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 1/7] power: Extend power_on_reason.h for upcoming
 PSCRR framework
MIME-Version: 1.0

Hi,

On Tue, Apr 22, 2025 at 10:57:11AM +0200, Oleksij Rempel wrote:
> Prepare for the introduction of the Power State Change Reason Recorder
> (PSCRR)  framework by expanding the power_on_reason.h header. This
> extension includes new power-on reasons:
> - POWER_ON_REASON_OVER_CURRENT for over-current conditions.
> - POWER_ON_REASON_REGULATOR_FAILURE for regulator failures.
> - POWER_ON_REASON_OVER_TEMPERATURE for over temperature situations.
> - POWER_ON_REASON_EC_PANIC for EC panics
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> changes v6:
> - add POWER_ON_REASON_EC_PANIC
> - s/POWER_ON_REASON_OVERTEMPERATURE/POWER_ON_REASON_OVER_TEMPERATURE
> ---
>  include/linux/power/power_on_reason.h | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/=
power_on_reason.h
> index 95a1ec0c403c..bf9501792696 100644
> --- a/include/linux/power/power_on_reason.h
> +++ b/include/linux/power/power_on_reason.h
> @@ -15,5 +15,9 @@
>  #define POWER_ON_REASON_XTAL_FAIL "crystal oscillator failure"
>  #define POWER_ON_REASON_BROWN_OUT "brown-out reset"
>  #define POWER_ON_REASON_UNKNOWN "unknown reason"
> +#define POWER_ON_REASON_OVER_CURRENT "over current"
> +#define POWER_ON_REASON_REGULATOR_FAILURE "regulator failure"
> +#define POWER_ON_REASON_OVER_TEMPERATURE "over temperature"
> +#define POWER_ON_REASON_EC_PANIC "EC panic"
> =20
>  #endif /* POWER_ON_REASON_H */
> --=20
> 2.39.5
>=20

--f3qpswvixtgt5nq6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmgT398ACgkQ2O7X88g7
+poODA/+P7FvkFQQd5YQ0EFcybmyfdJYNfvG/Q+i4Zy5OHDoI/L97Qk+DbbO64Ps
Crvia5WKqP3sW2P9B3EgmMJyTd1nQ0NP8R8sL0IVjEmOiGbmfq1onltvBhNuO+66
uoCxL470Ouicmkfkpi1ho5uCEM9hePuwtnTEe+zfegzyC7vYz+n3wL5Z+c3xJpO2
NYj8QVb4CMwtbIYUScHITbcW2LYY9xYFRgJKIgP+Xk7ELAXOiG+vUvmScCshhJQR
AE9uzIek1snK1qPoTllWRA+cGwIU+NPnMrTgTTPctKJyAmM640zm9XPE8pw1m989
LFpOZAsDdSU/lkCESvqoLJ303u+ZuqbyH1nQopyqrJ6kGlmlbY0S+clkq7khMfkJ
sgzlK9ArG2MKsnaNAF5FUeLbUhUW7giRgJ9BHldMfjBClhnuptGjkYPN8ZSV705q
NtaBhTAIbMu9Bv//Y5D8CrDkfx+/ifNgPFbRDt1qUkp/S2Ze3tBPXo5V4lqyk7l+
4x7tNaocMh/WGRhz9TAuNRCVj8c/4sHiWjz5bXvhnCCDY25+Zs9rjh3QmsuMxXV4
MygeatSC78KO7HXy292UgNbumhJiQ8uVI8zwI9WscMugWEobzhjXkLoJ+5VsIHOQ
IXGYzSSpSbN7pInOsScdHgMp6LJ06s09h6Y/0Segk7FMY0/0i5g=
=CFUI
-----END PGP SIGNATURE-----

--f3qpswvixtgt5nq6--

