Return-Path: <linux-pm+bounces-41804-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKubIR0tfWmYQgIAu9opvQ
	(envelope-from <linux-pm+bounces-41804-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 23:13:49 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EC6BF0FE
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 23:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92B5A301226F
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 22:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EE4387596;
	Fri, 30 Jan 2026 22:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="OYwB19Fl"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-g123.zoho.com (sender4-pp-g123.zoho.com [136.143.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFC737F738;
	Fri, 30 Jan 2026 22:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769811226; cv=pass; b=lhtWBoa6B5rmAJIPRAetkquAxDJaGYnWtAxu4RphJhhLmiY18xop0lfPrlwU17WDx40k0LydtycjYhiR05Ot/fYj8VuX+S7FBS1IC3XXr7dLoXpksAO7OzgySynP2GCRLCOj70tc8c/0OQcYFFbiWLmwwnaxw4JsIsm+YSwFON0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769811226; c=relaxed/simple;
	bh=0UWf8/vCgMM8cY0jn3W8Sf1V0jhboB0n8p2xSh2EWEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QniAPcFGOgZmE6Gos7TI5zbygvU/GcF8rZl26ayzCZDcekko1b/hamgXehdnvtto97sMhVsdtCyEKmGb8TqNv+h2Owsyxy5JyvLe6ne2/FMtYfuR8LKKGfvzUjQqM1nhi65c/nkPkkvV7lH9ymcxfIB22n1e8Q6q339RUT+jeow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=OYwB19Fl; arc=pass smtp.client-ip=136.143.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1769811212; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EfFvkXi0ReEo8N2W9i08k5bntzx7Uc6JmMP5/Xd2HfZAaUMVbj2vMcGsA0EYE2mHvLE+OrMT/rFz9RpEXl62WMcztJsMGmnNdLNoCtSphoZYHK3Q3dpFo1r2iJVfi3q1iUiOMZgQDlVKSMXw0AxXM9X+cDyawbc2VHylxk4FG0A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769811212; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OXz/6Gfdzu/1ZfkRFXBOdo+eqOyWAJBmkhJU39yARFk=; 
	b=AjEDGxu6awAyCxms2rRc42M/f4rPht/wRV3bowKJRmeqGrwFse/xRVgRE0UXAbyW/UJEc+aOc7/v/1bXSlEVh4lJ5I63kwNUhP+ZfNUOA26K2x8XBUEzFo4LmtVI3yrEsWCivP9ERRa1gh5NmhPns0SIB0MDA/0SCAoo3FtAjYE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769811212;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=OXz/6Gfdzu/1ZfkRFXBOdo+eqOyWAJBmkhJU39yARFk=;
	b=OYwB19FlwPMxAQdR7da84ZZ8UCArc81ZosrNRQaX4zH9u4gG5qLBTRUBW8w3wYpF
	ELuz8w2+vWF5e2+9R4ArxQPOYmK2rthT/53dq88k/RXFoMXMK2L2wwbYSGmfTgXA8Hi
	XtW6mArktYlTHMDI1JHQyxUkA2cdxS7X/Jjqivb0=
Received: by mx.zohomail.com with SMTPS id 1769811210773530.1298129286961;
	Fri, 30 Jan 2026 14:13:30 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 29B7B18050E; Fri, 30 Jan 2026 23:13:25 +0100 (CET)
Date: Fri, 30 Jan 2026 23:13:25 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: dimitri.fedrau@liebherr.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: gpio-charger: add
 support for fast-charge timer
Message-ID: <aX0peTW5KfZDXHRC@venus>
References: <20260109-gpio-charger-timer-v2-0-63fd1ba75830@liebherr.com>
 <20260109-gpio-charger-timer-v2-1-63fd1ba75830@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gb6ocaydawdjlbyl"
Content-Disposition: inline
In-Reply-To: <20260109-gpio-charger-timer-v2-1-63fd1ba75830@liebherr.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.1.1.4.3/269.789.21
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,microchip.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41804-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 05EC6BF0FE
X-Rspamd-Action: no action


--gb6ocaydawdjlbyl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: gpio-charger: add
 support for fast-charge timer
MIME-Version: 1.0

Hi,

On Fri, Jan 09, 2026 at 07:41:19PM +0100, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>=20
> On some devices like TIs BQ24081 battery charger it is possible to activa=
te
> or deactivate a fast-charge timer that provides a backup safety for charge
> termination via GPIO. In case of the BQ24081 it is a fixed 7-hour timer.
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---

With the time being charger specific, this is not a good solution
for the generic gpio-charger compatible. You should add a compatible
for the BQ24081 (using gpio-charger as fallback) and then only allow
'fast-charge-timer-gpios' for the BQ24081.

Greetings,

-- Sebastian

>  Documentation/devicetree/bindings/power/supply/gpio-charger.yaml | 5 +++=
++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.=
yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> index 25826bfc289c1c00c338fd0cee2ae6932529cfc3..0edacc104186497118d4ba41f=
80947009a9aacf6 100644
> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> @@ -62,6 +62,10 @@ properties:
>      description: Default charge current limit. Must be listed in
>        charge-current-limit-mapping.
> =20
> +  fast-charge-timer-gpios:
> +    maxItems: 1
> +    description: GPIO used for enabling/disabling the fast-charge timer
> +
>  required:
>    - compatible
> =20
> @@ -97,4 +101,5 @@ examples:
>                                       <700000 0x01>, // 700 mA =3D> GPIO =
A.12 high
>                                       <0 0x02>; // 0 mA =3D> GPIO A.11 hi=
gh
>        charge-current-limit-default-microamp =3D <700000>;
> +      fast-charge-timer-gpios =3D <&gpioA 13 GPIO_ACTIVE_LOW>;
>      };
>=20
> --=20
> 2.39.5
>=20
>=20

--gb6ocaydawdjlbyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAml9LQEACgkQ2O7X88g7
+po1xQ//ZZYeThKt3VE0cjvZ8SNrx0gp07qDGMVqTbA7uhEQqj0UYpP+RuT8z+41
bq0N/g3O6wrZfEhSXXcdisizFTBtlwPsYLocb7fjxrrNqBn52MapkMCv65Dw3Kib
dcwqjUkceEmxPlTTWa/C2HTpxt1K7X3I2J+3OFtsj5/Sz/lx23DhLIeZazpB48tA
8/xQHx2G/qfdNMDXGplRAZok6JN+7fvq0VgTBOKppVRve6aEGFHxUYAcfIs5r4jO
Mzh2S4p1crALAVlkxdgd9mBJBOX98whJQxbbMrHYMV44vfhbrrfxXn1KUzOR4v7P
1zq/lfPAe88HTjEAHJbJs6JjphqJvPUcMutSF5XkZX9TQgqwNQ/FzqDngD5XrRg5
ejO9SHP6wigxEvvArKSl2GFL0pmQe/cFJFWQxymVQEACnWqqdCfLeKNyFPXvyhm7
PMJG1mQt/NsJDJqY/VVoft+OHORbJK+bRBMqvt5BKa+3V2ULvkJvedO5Mpl7CL9h
YXYdL2cQBnZ4LbfrVjrr6naIzJgWFSuMKRvHELkp1SwHniQcGAitl3iTp/RbE4zy
ZA6XvlV8lzxeHHyAFpNHl9e+ztqrxA9pAawlqwYRsB1NgWIhM/XlVjLqSuF9u2+a
tKoKLsKYjhomdbWdloG5ePSgZ3yYRPuJg64gCbQtZOkQkZdoUQk=
=2Wjr
-----END PGP SIGNATURE-----

--gb6ocaydawdjlbyl--

