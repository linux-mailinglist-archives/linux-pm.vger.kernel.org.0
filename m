Return-Path: <linux-pm+bounces-26517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D4AAA64F3
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 22:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771097AC5DF
	for <lists+linux-pm@lfdr.de>; Thu,  1 May 2025 20:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3C425179E;
	Thu,  1 May 2025 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9vFCXZf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA717083A;
	Thu,  1 May 2025 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746132912; cv=none; b=JU1XKe+m0JFBGvT1ATcZ+v7rnrr9xvqrHW3BAP+xg9DdJ+kMXmbpc9gJhnH4U5M2g4kjImZkjy+NPHiH4ibaHWnA0G6LSPCDcarPZv1+0JqPi3skgH+dwwqCw4CgqWShrcNmj+m/hKQqpXvpBoXDOiRXrnyzdutTN1UYAAEdrl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746132912; c=relaxed/simple;
	bh=FriBKFsOeEfghRvWGcXxtLwZP0e0ITdbyjcC+Dlh9FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pevQuXzVQabQIlhsoYieP6e9eGDJMSWhYYz91RDPcQFhbM7KQ+CuFy466hqHXzqKPIerGFxKbPqnYwC7r/xI212AbPbEY6Ru1r5A57FbBaDHA6HkUeOQfN6gpHKB3bnrnRXKqGi+x4vSLX1xpuk9WVryuv33DheOxsW0y23dfPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9vFCXZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1E5C4CEE3;
	Thu,  1 May 2025 20:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746132912;
	bh=FriBKFsOeEfghRvWGcXxtLwZP0e0ITdbyjcC+Dlh9FU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S9vFCXZfdwKftvAhivyDTdP19qtVtg1WQPfi7Kcjn/9bxydDRSO+q01BwKgeS6d0M
	 1xwEJIojwNwYqS0dTbCy9Za3oUXK943fFuLHQpONkzCz57KjCGovmfu6yw878upo1o
	 Gae5kvk5fmq+SdaehMbJMXAlv3GXSNXFWjaArdvySwulREpWE4CSGzHSJG5D7tB+0u
	 6nujjphusgmbPeEix5vXxJn3IVk0ju/7UO/4J4Iq2t4uCy6/ppk+3Mm+QwVB1bVAow
	 M7Lwd5Y/6F4bupa6Sqb/DtTSsLCaD881oAlCkX3GXDM3SpCzu9GTgris6HQ2RKF5Ps
	 2vq9LKAgSXM1w==
Received: by venus (Postfix, from userid 1000)
	id A871A180F5C; Thu, 01 May 2025 22:55:09 +0200 (CEST)
Date: Thu, 1 May 2025 22:55:09 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>, Guenter Roeck <groeck@chromium.org>, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v9 2/7] reboot: hw_protection_trigger: use standardized
 numeric shutdown/reboot reasons instead of strings
Message-ID: <pnvzk66ota2ebjnhjcfqhqsqepevl3f5khllqg7jd77zq562on@cm2rh72mvbzz>
References: <20250422085717.2605520-1-o.rempel@pengutronix.de>
 <20250422085717.2605520-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="naw5frhrqjonpf3i"
Content-Disposition: inline
In-Reply-To: <20250422085717.2605520-3-o.rempel@pengutronix.de>


--naw5frhrqjonpf3i
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 2/7] reboot: hw_protection_trigger: use standardized
 numeric shutdown/reboot reasons instead of strings
MIME-Version: 1.0

Hi,

On Tue, Apr 22, 2025 at 10:57:12AM +0200, Oleksij Rempel wrote:
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 90629a756693..84448a4c7fd4 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -5263,26 +5263,23 @@ EXPORT_SYMBOL_GPL(regulator_bulk_free);
>  static void regulator_handle_critical(struct regulator_dev *rdev,
>  				      unsigned long event)
>  {
> -	const char *reason =3D NULL;
> +	enum psc_reason pscr;

enum psc_reason pscr =3D PSCR_UNKNOWN;

(or add a default clause to the switch)

>  	if (!rdev->constraints->system_critical)
>  		return;
> =20
>  	switch (event) {
>  	case REGULATOR_EVENT_UNDER_VOLTAGE:
> -		reason =3D "System critical regulator: voltage drop detected";
> +		pscr =3D PSCR_UNDER_VOLTAGE;
>  		break;
>  	case REGULATOR_EVENT_OVER_CURRENT:
> -		reason =3D "System critical regulator: over-current detected";
> +		pscr =3D PSCR_OVER_CURRENT;
>  		break;
>  	case REGULATOR_EVENT_FAIL:
> -		reason =3D "System critical regulator: unknown error";
> +		pscr =3D PSCR_REGULATOR_FAILURE;
>  	}
> =20
> -	if (!reason)
> -		return;
> -
> -	hw_protection_trigger(reason,
> +	hw_protection_trigger(pscr,
>  			      rdev->constraints->uv_less_critical_window_ms);
>  }

Greetings,

-- Sebastian

--naw5frhrqjonpf3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmgT36kACgkQ2O7X88g7
+prmIQ/+JKEXxXwdYHIW0jX1zJvf2PrCfXVs7awROca4BZAa0Xv/XWmtg7cV2yd9
KdD39SMULbTuwj8F1I1+9xHMCLqsZApbAJQyfT1PzVaRDw6vl4Egxid0GJWUPngI
TWCxUoAOfuOXXJGmgCM9Il4Xyd2DkSYeSh6EOcQ5PsyzEk+bJARJxVRkXXvgNH35
2kIlspI8GhBAWVZrWCuPDBQTH7NL6l4T+39BClBSq/fS4JSQwtzznYKnriKCnbMP
FkrkhcyqpyfZIpcbq/kL3eXecnXXwM+Dde+pvqmsRqD/2H8WVm99n0w27KnY+EJJ
1svCP9evz2s/EPSnBAneg1/5V+0T3pRmh73aLLfa0NnWT6jPAMddJwjaZni06sB/
4bdthL86t3sE5OOD1ZSOReafP7IT1JPC6RjduncF6p/Qx7bCXKeqPiGT/2roCx+1
5zPvUNfRD7AKc7RYRrjMH4qqFcJe8b1KbdwhtXVxDC6DcTIQjTk8UannY+YARNS+
0GOqgHgfUq8+oBMCDdhxzlXAyUlbqW8+lY1kY0TBWW/QhZlK1zpoMxq7Iw9ZP82w
X5N+vwpU7OP6D5iMpPmRUnja6Xb9/F6Mx/VDZew+/NXsreGAo3zx+kUjKODppzXw
W2J9MqnmiPu7jtxgOHNxkJXwtdj3N4idB9mcH8cResNlhoPY2Qs=
=LA1C
-----END PGP SIGNATURE-----

--naw5frhrqjonpf3i--

