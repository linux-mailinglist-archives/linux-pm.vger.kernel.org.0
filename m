Return-Path: <linux-pm+bounces-42753-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO98L0t1lGlmEAIAu9opvQ
	(envelope-from <linux-pm+bounces-42753-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 15:03:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A414CF03
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 15:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB648301727E
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 14:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E5E36165D;
	Tue, 17 Feb 2026 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/lGzO4I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FB9265623;
	Tue, 17 Feb 2026 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771337030; cv=none; b=ZYKYVGghzWeKKd9h0ujWQJj09Wyn1A3SSXCtrz1hp7zFwdDX0NhB2EHqfydl6RrlCMOdvM7ex+WcY1dg7q3PvybmjkV0i5/3WulWT0O+BYHizSv1cegUlsgIrSU7RDoz8MrG/CKyVKrJjvz3zBcFJcnqxxKAaUo/YZwjnDkz6FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771337030; c=relaxed/simple;
	bh=9vTU2q8tdyGIZAixkkGRtfDBHS4eZeEcUbCnLrGBGvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXaIB9F8NPqJj9p0sfoUPKO0HX482rqxkv8Vc8IozCgozfPrQl95SGOgzyeVxCSwZzwNsCXfbuRu7k8gIpOYpeJ3rp+ebrZwR8uu2KTMh5/W71lmZD4gN4RxoUctRRaoPp/yRLh54/FxDBKhPWU3nfFmR2I8ZujfFE3sQE406Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/lGzO4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3BBC4CEF7;
	Tue, 17 Feb 2026 14:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771337029;
	bh=9vTU2q8tdyGIZAixkkGRtfDBHS4eZeEcUbCnLrGBGvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U/lGzO4IOCQHe9Y9LfLBXuPUoBGf27wgXMWbhKv8ecXI4JOusGSSBqM3gFkbkNmE6
	 sYPkd/euS0y2ivUpAqXpeR9OC+fZHH2H6T7X4uu6aPvy5E/8Wjoa7JiKGzW7ftnFEh
	 jAkS2FDlthd8DLaaRxYFptoTxtkHTM2a8mJwldxt77CzDw/8DeLbUO5uPNx6NqYCGJ
	 tBVCnkp8AJE0Kc3uI4eGy0OK2jpulQBBOEMSFTlhOHyvZiJkUfmbGDC1ix0N+k/bGq
	 X30ybgfFAk61Mn7Noki5QOY4nYEvNMY4ison2Gd1lwMjaWb2EqIATiWcA7VDlkQUUY
	 4yA4HHkFqLKtg==
Date: Tue, 17 Feb 2026 14:03:44 +0000
From: Conor Dooley <conor@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: embedded-controller: document ASUS
 Transformer EC
Message-ID: <20260217-dig-husked-8a59b6a19aee@spud>
References: <20260214180959.30714-1-clamor95@gmail.com>
 <20260214180959.30714-2-clamor95@gmail.com>
 <20260216-sprung-scallop-de7b64bf528c@spud>
 <CAPVz0n06+uLCSfY_bYS9v7KJ-hXotye7ej-rze6-Q8_JAF7XVA@mail.gmail.com>
 <20260216-plunder-defense-de11cf56dd3d@spud>
 <CAPVz0n0-LbTUZBCaO=oN3PpPLpwAqzNo29r687pKY8NbEE9giA@mail.gmail.com>
 <20260217-vowed-botany-b1c47c7e40b8@spud>
 <55C30023-4175-48F2-BCB0-12EC23C48F01@gmail.com>
 <1519143e-4fc3-490d-ab8d-e65edd2c4eec@kernel.org>
 <81844CC9-5355-4B1D-AEBD-6DD67FB8C81B@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OWPhDIv0946VyWKY"
Content-Disposition: inline
In-Reply-To: <81844CC9-5355-4B1D-AEBD-6DD67FB8C81B@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-42753-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,agorria.com,rere.qmqm.pl,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 691A414CF03
X-Rspamd-Action: no action


--OWPhDIv0946VyWKY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 01:34:01PM +0200, Svyatoslav Ryhel wrote:
>=20
>=20
> 17 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80. 13:32:26 GMT=
+02:00, Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >On 17/02/2026 12:23, Svyatoslav Ryhel wrote:
> >>>> in other words you propose this:
> >>>>
> >>>> properties:
> >>>>   compatible:
> >>>>     oneOf:
> >>>>       - items:
> >>>>           - enum:
> >>>>               - asus,sl101-ec-dock
> >>>>               - asus,tf101-ec-dock
> >>>>               - asus,tf101g-ec-dock
> >>>>               - asus,tf201-ec-dock
> >>>>               - asus,tf300t-ec-dock
> >>>>               - asus,tf300tg-ec-dock
> >>>>               - asus,tf300tl-ec-dock
> >>>>               - asus,tf700t-ec-dock
> >>>>           - const: asus,transformer-ec-dock
> >>>>
> >>>>       - items:
> >>>>           - enum:
> >>>>               - asus,p1801-t-ec-pad
> >>>>               - asus,tf201-ec-pad
> >>>>               - asus,tf300t-ec-pad
> >>>>               - asus,tf300tg-ec-pad
> >>>>               - asus,tf300tl-ec-pad
> >>>>               - asus,tf700t-ec-pad
> >>>>               - asus,tf600t-ec-pad
> >>>>               - asus,tf701t-ec-pad
> >>>>           - const: asus,transformer-ec-pad
> >>>>
> >>>> And in the driver add match to every single entry of enums?
> >>>
> >>> No, I was talking about removing the generic compatibles entirely, si=
nce
> >>> they are not suitably generic to cover all devices at the point of
> >>> addition. So like:
> >>>
> >>=20
> >> Actually, they all can be grouped under asus,transformer-ec fallback i=
f that is needed, both pad and dock EC have the same core functions just di=
fferent set of cells. And then in the driver each compatible will get a ded=
icated matching data. Will this work?
> >
> >Then what does the generic compatible express if it is not used by the S=
W.
> >
> >Wrap your emails to mailing list style.
> >
> >>=20
> >> properties:
> >>   compatible:
> >>       - items:
> >>           - enum:
> >>               - asus,p1801-t-ec-pad
> >>               - asus,sl101-ec-dock
> >>               - asus,tf101-ec-dock
> >>               - asus,tf101g-ec-dock
> >>               - asus,tf201-ec-dock
> >>               - asus,tf201-ec-pad
> >>               - asus,tf300t-ec-dock
> >>               - asus,tf300t-ec-pad
> >>               - asus,tf300tg-ec-dock
> >>               - asus,tf300tg-ec-pad
> >>               - asus,tf300tl-ec-dock
> >>               - asus,tf300tl-ec-pad
> >>               - asus,tf700t-ec-dock
> >>               - asus,tf700t-ec-pad
> >>               - asus,tf600t-ec-pad
> >>               - asus,tf701t-ec-pad
> >>           - const: asus,transformer-ec
> >>=20
> >> And them schema name will match the genetic compatible.
> >
> >Then what does the generic compatible express?
> >
>=20
> Then enum it is


Why would you do that, instead of what I posted earlier in the thread?
If you send a flat enum with all devices listed, I'm gonna just be there
telling you to consolidate into one device-specific fallback compatible
per programming model.

--OWPhDIv0946VyWKY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZR1QAAKCRB4tDGHoIJi
0h41AQCr7TICtaTgXZhrMGB41SPw7tA455LBVAPEpg4w/1drcwEA4Bpg0OkX4VNt
xUz+5xKvuHAme2tqDBVbnoosXvIPjwE=
=C/29
-----END PGP SIGNATURE-----

--OWPhDIv0946VyWKY--

