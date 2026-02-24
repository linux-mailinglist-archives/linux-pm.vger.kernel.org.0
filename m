Return-Path: <linux-pm+bounces-43160-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPOuC0vcnWmuSQQAu9opvQ
	(envelope-from <linux-pm+bounces-43160-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 18:13:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A9E18A60C
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 18:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF5CF300C0DC
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A1F3A963D;
	Tue, 24 Feb 2026 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTWq6Tyh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCD63A962E;
	Tue, 24 Feb 2026 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953224; cv=none; b=GfjyVTtDdO8tSH/aXIne0m29VsfRVFh6DGEnQb9r1JwVI+5S+QpWhO9wmKp9lbrEhdg9nK5VMNIEhp0HZzVKSK6t0Gx3yVjzzvt0dUQb8xE2NAo36TkB8G9QFNW2vBp/VlmlT3Y1DoexpbdomhFGChwH7RZYNPlIJd93TBb7KmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953224; c=relaxed/simple;
	bh=miD05eK+0103K0nqV0VgvBQv0vF5WAuglrfoXelY66M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1EuFrTf16gb8S6gDTbtdMozITJmvgOtyZUYu3pu5h9QGiXd/b6PRdG0TiIYMtUHlpnF6YVHDVs5h4hhtnE8ojc+4boLLRVCidGDJ+epnuVRYjFrQS6nnVw7hv/6f9UpQy4Bwj6izIdgVL+TWS+CBSrrw2oMVZd27yxltgeES34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTWq6Tyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE31C116D0;
	Tue, 24 Feb 2026 17:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771953223;
	bh=miD05eK+0103K0nqV0VgvBQv0vF5WAuglrfoXelY66M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aTWq6TyhfT8xVGZ9JC9piET/yP5vfFHniNb9mu0CM8jwvVmrW+IOK/yHJJU4MYocG
	 LuKN/56l0sWVn3L3SDAlKQ41JhoJ3P81g4G4FMWPch2FhI/W9EkJts+MSxjln1tPdn
	 tUHcqdwJrdE61Uaj++we57CDoWXyyiJVyudtn432cMQJA18y0WbmmBMlijq6kHxFR2
	 b2RpoUlW0G9CP10SZ8Ti6hRjp5Up1nnlOQz8fuXA+NBz/0sdL9bMI+hENaJzD4f1U/
	 e+3UxUgrX9mbkGtF3kzMWwpoYVNCAys/HSI5rPQVuPZ2IPCvqTCosiOtY6zYoR1RwB
	 35zDU8obSvw+g==
Date: Tue, 24 Feb 2026 17:13:36 +0000
From: Mark Brown <broonie@kernel.org>
To: amitsd@google.com
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v7 4/6] lib/linear_ranges: Add
 linear_range_get_selector_high_array
Message-ID: <57891cf1-a7e2-42ac-98e4-25fd548ee765@sirena.org.uk>
References: <20260218-max77759-charger-v7-0-e8d907ce69c5@google.com>
 <20260218-max77759-charger-v7-4-e8d907ce69c5@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ajqSXpJyr7gIDnad"
Content-Disposition: inline
In-Reply-To: <20260218-max77759-charger-v7-4-e8d907ce69c5@google.com>
X-Cookie: An apple a day makes 365 apples a year.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43160-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,linuxfoundation.org,google.com,linux.intel.com,samsung.com,gmail.com,linux-foundation.org,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4A9E18A60C
X-Rspamd-Action: no action


--ajqSXpJyr7gIDnad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 09:59:12PM +0000, Amit Sunil Dhamne via B4 Relay wr=
ote:
> From: Amit Sunil Dhamne <amitsd@google.com>
>=20
> Add a helper function to find the selector for a given value in a linear
> range array. The selector should be such that the value it represents
> should be higher or equal to the given value.

Acked-by: Mark Brown <broonie@kernel.org>

--ajqSXpJyr7gIDnad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmd3D8ACgkQJNaLcl1U
h9BxqQf8DP6wjyYdfOSBrB5Xn9eXDFFW1jGwmmgn7p3tf87vwRhXtNxKhIkQmKV4
4tQDBl6ZEV8G8obl3pRNVamOHkMoWofw7EG5hpLjz0k/lGLAWvDUg6SeZk6BsUd3
04xpHoM4SxTGD01C8nt6yEjLplF0OkYS03haPQ6ldgh4hc0fW5/qlaDX8WSvvYzH
vetuB1RA8iTews7LT8/YhArFzkJqhWyG12rKXgWXnPz2Joz0k2k279nlGs+lRVLV
g0V5ali3JRtXREfFXSL28UuHCAAmBrYPR4KEF4paAdV7h8Gt3UB9KuU/Gi4HjRkV
chKB8nn1mKHLgOU/N0yXycpQ/fr25w==
=blQU
-----END PGP SIGNATURE-----

--ajqSXpJyr7gIDnad--

