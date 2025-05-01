Return-Path: <linux-pm+bounces-26527-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4117EAA674F
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 01:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8FD17A765E
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 23:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023EE2512DE;
	Thu,  1 May 2025 23:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="JZTtcEPB"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B5221295;
	Thu,  1 May 2025 23:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746141683; cv=pass; b=qvMkshsjFO14SnkEVK+yiSPVqEYoKd1LADl3ZEuipjQTtXzf2mmBRO8Z2W99MvBgnvPgFQZRyyKQ/sg6lXsN+CtS9ryofg7gniIwN8iLhs3EX0IM9j1daQj+xAGEMd2vdo1JjFEFpQttzWZBrr26lPM7wKQdoHoF1AtOncBKV6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746141683; c=relaxed/simple;
	bh=uW+bsOuKdxvM7b8YNXA5qBQmYFbmwZ8+SaFhCS1lotY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afdLPFmhsrJLsUrlJ1QjZ792W+ugYSaObeBFXr7VmSbofWI1i8iATIgcds+cr7x9J+OO2jrUJp1c8U1UmI0gbih19cAupf2RaEVVPK22Lp4h51SuEYsXJSAOqCGYV5J9yiZaSkg2UcFEQQeq7wjS92D5ptQvPa+qs0DWKqsZK1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=JZTtcEPB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1746141658; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O+TVLAodYcBWlQ9HGX3cAV2Zuh9KdXk1PDyLygUHpoS1JNlFOvcReVeY086bZthqVyLI6J3xqIyOWZEFyO1MN/UARE7Bhtsy/V3PPgLiCAyIAi1TqJVUuWTwruhHagA9ptsy5QooyiEShepMnxRRb3eUogph+QKbg9Mqo7BU4hw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746141658; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qnPXZeTJSNYPr9STVQr9IHGeAwSe5nqN3NqW6dQCoqQ=; 
	b=nTZc8qtRAl6REjDocdy/Xt68XylO6gj1Z5ThnDs9Sho3wFRZ81OjHKNsMYkVsOBpSixqi1sSZT+yGQD7+uWiCe79hbU9Ea3iXlxBosz2aNJbSCjsqgRPsD6FPG94j5wJdaQ4uCr0rhv9X1PlWjhphfkNBdLEPmwLIsXCeD3OXjU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746141658;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=qnPXZeTJSNYPr9STVQr9IHGeAwSe5nqN3NqW6dQCoqQ=;
	b=JZTtcEPB1DySe2yvEyTtafIZiWUIcDn862uZW8py1BTy6OXURw57Rh4WF4FnyozW
	Kj3vgxqX2AgHHS745Gr5F4/8J8ACSBSbX3yFEZcRzXXVPLSY7TlhbWYvQ82mTiOOVUP
	aO53cVaa1JsQl8hzlOUrq8YKyH2xYD2WA0+U3y+c=
Received: by mx.zohomail.com with SMTPS id 1746141656431362.86708838265554;
	Thu, 1 May 2025 16:20:56 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 7D923180CEF; Fri, 02 May 2025 01:20:50 +0200 (CEST)
Date: Fri, 2 May 2025 01:20:50 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>, Guenter Roeck <groeck@chromium.org>, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v9 3/7] power: reset: Introduce PSCR Recording Framework
 for Non-Volatile Storage
Message-ID: <bumx6ma3kjanapwaf3oc3mdjnekatvc2cmavt6secfkaapgjpz@kouqjidbl47k>
References: <20250422085717.2605520-1-o.rempel@pengutronix.de>
 <20250422085717.2605520-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vpofsupfti7jzmi7"
Content-Disposition: inline
In-Reply-To: <20250422085717.2605520-4-o.rempel@pengutronix.de>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/246.120.57
X-ZohoMailClient: External


--vpofsupfti7jzmi7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 3/7] power: reset: Introduce PSCR Recording Framework
 for Non-Volatile Storage
MIME-Version: 1.0

Hi,

On Tue, Apr 22, 2025 at 10:57:13AM +0200, Oleksij Rempel wrote:
> This commit introduces the Power State Change Reasons Recording (PSCRR)
> framework. It provides a generic mechanism to store shutdown or reboot
> reasons, such as under-voltage, thermal events, or software-triggered
> actions, into non-volatile storage.
>=20
> PSCRR is primarily intended for systems where software is able to detect
> a power event in time and store the reason=E2=80=94typically when backup =
power
> (e.g., capacitors) allows a short window before shutdown. This enables
> reliable postmortem diagnostics, even on devices where traditional storage
> like eMMC or NAND may not survive abrupt power loss.
>=20
> In its current form, PSCRR focuses on software-reported reasons. However,
> the framework is also designed with future extensibility in mind and could
> serve as a central frontend for exposing hardware-reported reset reasons
> from sources such as PMICs, watchdogs, or SoC-specific registers.
>=20
> This version does not yet integrate such hardware-based reporting.

This adds quite some complex code for a very specific problem while
mostly ignoring the common case of hardware reported reasons. I think
having at least one hardware-reported reasons (e.g. WDOG) is mandatory
to make sure the framework can really handle it.

I also see you extended power_on_reason.h and included it here, but
don't actually use the defined strings at all. Also you create the
new enum, but don't handle the existing reasons and just add the new
codes you need instead of making sure things are properly in-sync :(

> [...]

> +struct pscrr_core {
> +	struct mutex lock;
> +	struct pscrr_backend *backend;
> +	/* Kobject for sysfs */
> +	struct kobject *kobj;
> +	struct notifier_block reboot_nb;
> +} g_pscrr =3D {
> +	.lock =3D __MUTEX_INITIALIZER(g_pscrr.lock),
> +};

Apart from the highlevel problems I have with this:

g_pscrr can be static

-- Sebastian

--vpofsupfti7jzmi7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmgUAcIACgkQ2O7X88g7
+prEFA//cMaV+DNnS+CPOdI+6NkHvEUttYDcm7/2fUHnyTszy+VBdXxi202dw7iU
O2azdHoIeBq3uckvA5cazOXGTK1UeRhbTDseLQFw0MT70Ln+aMpGq0X8gzKiCF+G
DBbeZVlAoGXoq89x2YgwF001rbiP5yx+LMcKTg5ZT0Jq1ct+lEoHWoujA79ZTmZ7
Qc7xWyY+Rh474BEAX/lV2uL78ULzasc0mDA+2EFyvl55fcvTz0L093FuIOkAxTGF
jnHERboAqXPx5VSuXnE3BbrHbF8t2dI0cHcekpIgMyl5jM9T7BNzXpqXKBhUtZLU
7/5sbdoXF70DapT0TeX3LtviZooNLeIM+Qi3a9SYceFdT+dt9BMHLvQmCzLoakRr
172aHFGhnSxG82bWbcfMFXwlVjVjr+ugXNhY7Dck9qX6hGmZy1meLDi/3HYPpIQJ
U3281eeJdcOpqcBtyPuv7hoiLSboX47CCaS4LeF0kYl7V9vjd72RtoHv77ZTxCvM
oLSNx4+Rucb+KjiAiinuB/CN/0ZGkfOUlOoz0F4LM/8WRNUpffYFYZpkzDJ/kKqR
90eIVYkohev+o86oTpqBGCp5U6WsoApsbxS1UpJN13oagHg2x+BnNEVoLPm9pwcJ
sXOVmFq6DF9GW7D53oCuh/ylgfOnncb8V9oEDZz0u7mrpQGAQMY=
=9Wdf
-----END PGP SIGNATURE-----

--vpofsupfti7jzmi7--

