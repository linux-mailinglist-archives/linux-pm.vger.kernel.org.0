Return-Path: <linux-pm+bounces-43872-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMLoKcQsq2n6aQEAu9opvQ
	(envelope-from <linux-pm+bounces-43872-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 20:36:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D65DA2271B1
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 20:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D73D1301D0EE
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 19:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA48374E46;
	Fri,  6 Mar 2026 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKALYIpu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B719352C22;
	Fri,  6 Mar 2026 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825793; cv=none; b=mn25yzQzZRdwjqs7vORH/n0jGgqT4InI2q8io1o+1H2LSo1O0XslCfXoUJh4xfb+ikZ+0wii+y+LwahxK3+Sp2GzDSg5rPp8a11yo5PPdLA6/DtNDxgZdZ4kBG39YzaxPYyLzdFUJY928s057QHnyIqsTlo44Q7FbftcB7IIcaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825793; c=relaxed/simple;
	bh=ewzpiXOFV699/AiIq9n56RjtsRJdWafj7gQulN4FXxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvdxnncB5OtD75qT28yFhy+MQrNNeHlfsCVKvGfy2nrl8Mq5w49rblNZTEmedZVfdW/yoONT07bph0sgv1lxtui0dO7F5/WgSouzRVmesGRq1ykVDfjUngqoM6bcqZV6Nm321NxVJmcI8IU4tRbbAcC4mNDNXofSHHvGCzvdV6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKALYIpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E41C4CEF7;
	Fri,  6 Mar 2026 19:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772825793;
	bh=ewzpiXOFV699/AiIq9n56RjtsRJdWafj7gQulN4FXxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKALYIpunfZf14somh/XkOE/XN40M+STbgk7XD/imKAzy1pNAUjWvc9xesEm3qRJ3
	 Vjo/T2qUGgRY5gKp4GhNCdFoX70E74SG6SNchZM4NjjqVxux79i2++hZ0/eHdrTRwb
	 SPfJx6ISRojGguSwKG6Awi7eJnHPwa95gw+C/acHjIsAIwT0nMBiznkMJu69yqR8dk
	 W4DJnmhHOkCKq/5X0HLpCkWsGqb9dCjGq4zGbZOBto6vKBDQU5qA51NQiHatO4wcBw
	 pBIU8Cy9dXtiBn8DeUVNSgdifSZAm2W2wgbuadTugxuO3E5oLei01QIdCak8G/6Bgg
	 FavdRnDIwOIJQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id BFF441AC52D3; Fri, 06 Mar 2026 19:36:28 +0000 (GMT)
Date: Fri, 6 Mar 2026 19:36:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 04/11] regulator: bq257xx: Make OTG enable GPIO really
 optional
Message-ID: <aassvAsgFTlFnD8M@sirena.co.uk>
References: <20260306-bq25792-v2-0-6595249d6e6f@flipper.net>
 <20260306-bq25792-v2-4-6595249d6e6f@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YGVsl/3Kb/Fedt+6"
Content-Disposition: inline
In-Reply-To: <20260306-bq25792-v2-4-6595249d6e6f@flipper.net>
X-Cookie: Think big.  Pollute the Mississippi.
X-Rspamd-Queue-Id: D65DA2271B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43872-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,hotmail.com,gmail.com,vger.kernel.org,collabora.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sirena.co.uk:mid]
X-Rspamd-Action: no action


--YGVsl/3Kb/Fedt+6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2026 at 06:33:04PM +0400, Alexey Charkov wrote:
> The bindings describe the OTG enable GPIO as optional, but the driver
> gets upset if it's not provided in the device tree.
>=20
> Make the driver accept the absence of the GPIO, and just use register
> writes to handle OTG mode in that case, skipping the error message for
> -ENOENT.

Acked-by: Mark Brown <broonie@kernel.org>

--YGVsl/3Kb/Fedt+6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmrLLsACgkQJNaLcl1U
h9AgBwf/eP3Uy+cd/aIEV4nv6djq35BjM2gDBYO0epVm/ofey5WZb4u4ebhDev+5
KVSf5H3J0DRu+2ODQl+T/eJI28OSZsax3ZlLPIltoj1UWt7ZkPXJvW3LNVOb1Ufr
CrRGwpZ6Gmn9uqLwcFM1eXZv9DeGjeqQ9+nrHFTnIAIOI9fvqFNblls4xJLYQkJe
jOM+AnlkkwAl3sjLBPextS1NJU/4q8lhVIgzHbrFXzB8Qo8Rl1VUtrVydfMJ8beH
9s3osMMLvEtMdVwYYMx4QPkoZHY/8KHKc7Zihm6gTKaLLTxtVMy7jZn64A2vVF35
ItbRhTAAEgV5AhggrqansZE+aXLZ+w==
=i+Kt
-----END PGP SIGNATURE-----

--YGVsl/3Kb/Fedt+6--

