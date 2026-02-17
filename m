Return-Path: <linux-pm+bounces-42762-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAE/F2mOlGn6FQIAu9opvQ
	(envelope-from <linux-pm+bounces-42762-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 16:51:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4572614DB63
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 16:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADB2B300DEF0
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0FF36CE0E;
	Tue, 17 Feb 2026 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNw6hdMT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69D736C581;
	Tue, 17 Feb 2026 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771343460; cv=none; b=AprBNymwSdDQ9qTeldNRF4bKuV931ZROgI5hZ2+ddC/2F5mYdcgsQCryw7RrW/3D74gnrZMpIjCVkX1kJ6DBOrKn2en6Fm/GCLE6qAyfVkPqnKwTEhH6P9iwt+IOSI8MSRndgEog+C9cfwobJkpx/wzzlUQOFWBtdjDEo3ONJRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771343460; c=relaxed/simple;
	bh=F3tr3dTMqJx3SD92fKDrGHKnROwGZ6bJ78jeAepD7a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ejh9EoALS2prHLwkHifzDq0Q5GNqY5OXTAYrhQbZgQB6zrR42gmwii/IP0AVNj3eKIhbdmz2e0klMFNaq683dmutODDv93BX9urwjimZb0PMiWsFCphtfRXK4TmTDsLumgNgnNLkAO4f4pbW/W1wbpH0LPiGESPZGbdyVuz3OOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNw6hdMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84071C4CEF7;
	Tue, 17 Feb 2026 15:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771343460;
	bh=F3tr3dTMqJx3SD92fKDrGHKnROwGZ6bJ78jeAepD7a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MNw6hdMTPCx7nqnz+wvSOwxVvNZ0I/reKjeODpt36xYllBHz1Rh+MlQhUAz0HzUtA
	 m5rSpqP1FNE1yBLk3SRm1RhvmDF3wHln9KJO3y4YxVgajtf72Ogl+dHANCqKy0VU3R
	 O2h42mALLS/iDwxKS6KYIIt+OncvDeRY0IyK2Lz7ODueiYx6NvsSEoi49UkYo5xggX
	 94Sm+1a79cVVqV+5bRpVdgbfQU6bO0n0b7Jd7YV9vRPLcQTvbKQ0R7xozwS1UsLO4l
	 h0PTRTUhuos5CSJqQVm7MW+lJqvedInn/xifPZAo1qyOjlDpHPZ/sMQ6sbkGxHefpp
	 bmq+P0cIoNCxQ==
Date: Tue, 17 Feb 2026 15:50:55 +0000
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
Message-ID: <20260217-tableful-arbitrate-169030e4fb11@spud>
References: <20260216-sprung-scallop-de7b64bf528c@spud>
 <CAPVz0n06+uLCSfY_bYS9v7KJ-hXotye7ej-rze6-Q8_JAF7XVA@mail.gmail.com>
 <20260216-plunder-defense-de11cf56dd3d@spud>
 <CAPVz0n0-LbTUZBCaO=oN3PpPLpwAqzNo29r687pKY8NbEE9giA@mail.gmail.com>
 <20260217-vowed-botany-b1c47c7e40b8@spud>
 <55C30023-4175-48F2-BCB0-12EC23C48F01@gmail.com>
 <1519143e-4fc3-490d-ab8d-e65edd2c4eec@kernel.org>
 <81844CC9-5355-4B1D-AEBD-6DD67FB8C81B@gmail.com>
 <20260217-dig-husked-8a59b6a19aee@spud>
 <CAPVz0n0u7uhL8_FQFiuB7DrnL++ecbaEKEoV7N2PgTVRBVECkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CFX4Gs6NaZQ9iQTz"
Content-Disposition: inline
In-Reply-To: <CAPVz0n0u7uhL8_FQFiuB7DrnL++ecbaEKEoV7N2PgTVRBVECkw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-42762-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,agorria.com,rere.qmqm.pl,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4572614DB63
X-Rspamd-Action: no action


--CFX4Gs6NaZQ9iQTz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 04:29:59PM +0200, Svyatoslav Ryhel wrote:
> =D0=B2=D1=82, 17 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 16:03 Co=
nor Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > On Tue, Feb 17, 2026 at 01:34:01PM +0200, Svyatoslav Ryhel wrote:
> > > 17 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80. 13:32:26=
 GMT+02:00, Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:

> > > >> properties:
> > > >>   compatible:
> > > >>       - items:
> > > >>           - enum:
> > > >>               - asus,p1801-t-ec-pad
> > > >>               - asus,sl101-ec-dock
> > > >>               - asus,tf101-ec-dock
> > > >>               - asus,tf101g-ec-dock
> > > >>               - asus,tf201-ec-dock
> > > >>               - asus,tf201-ec-pad
> > > >>               - asus,tf300t-ec-dock
> > > >>               - asus,tf300t-ec-pad
> > > >>               - asus,tf300tg-ec-dock
> > > >>               - asus,tf300tg-ec-pad
> > > >>               - asus,tf300tl-ec-dock
> > > >>               - asus,tf300tl-ec-pad
> > > >>               - asus,tf700t-ec-dock
> > > >>               - asus,tf700t-ec-pad
> > > >>               - asus,tf600t-ec-pad
> > > >>               - asus,tf701t-ec-pad
> > > >>           - const: asus,transformer-ec
> > > >>
> > > >> And them schema name will match the genetic compatible.
> > > >
> > > >Then what does the generic compatible express?
> > > >
> > >
> > > Then enum it is
> >
> >
> > Why would you do that, instead of what I posted earlier in the thread?
> > If you send a flat enum with all devices listed, I'm gonna just be there
> > telling you to consolidate into one device-specific fallback compatible
> > per programming model.
>=20
> There is no one device-specific fallback compatible! Schema describes
> HARDWARE not drivers no? I will not use random device compatible from
> the list as a fallback compatible for a different random unrelated
> device, that is plain wrong.

Which is why I am not mentioning drivers at all, and instead talking about
programming models. Fallback compatibles represent similarities in
programming model, even if the laptop that these devices are contained
in are different, so whatever device compatible you pick might be random
(but going chronologically is usually my recommendation) but it won't be
unrelated.

> Discuss this with Krzysztof and come up with something meaningful please.

If you don't consider my reviews to be meaningful, you're welcome to
carry a Nacked-by: Conor Dooley <conor.dooley@microchip.com> with a link
to this discussion instead.

Thanks,
Conor.

--CFX4Gs6NaZQ9iQTz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZSOXwAKCRB4tDGHoIJi
0lKEAQCMn1RQWiz2XuWSwPyIQrFeNcdgS1xJdgNETKYUnIvdvAD/a48ii+2SjLok
p8k8vgDRIULg8VXMLV8Zc8SI2pGg9QA=
=w/4u
-----END PGP SIGNATURE-----

--CFX4Gs6NaZQ9iQTz--

