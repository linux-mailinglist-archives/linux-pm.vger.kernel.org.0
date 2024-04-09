Return-Path: <linux-pm+bounces-6125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0136889E077
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 18:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE9828E36F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 16:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F41215253A;
	Tue,  9 Apr 2024 16:32:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9531509B4
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680369; cv=none; b=fQoqTcEf3/lyvoJQgObPbrdnlVfGjUijXb06s8YigShDm84zBbPhZdT/ochLP6AqOqXbV9YeNWwL7MSJ60WickGl2QuhBpk0Ki2dtt3TSe3fJUaBvb3WReuBqvZL4eell2OukGziXfdZhxG6ITzWSF+msCdtqaocEv1CyVkbr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680369; c=relaxed/simple;
	bh=kGNiOYgEjXV6OIDTsWw1Tx2jDfOc/VCR7k2qJc3X5js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fG2sy7+Ba7uI4YppH86TrrHAkOxIXxV+49DpPBtXJQ4drbD/GM6amwpz9tG81rwXMD7BWzf9yGdOOVtygM8vDLCWUtLwtEegySw/vOooEuyFSJffX3BWVWx9p5y0WXIcFmJd/1cN+2Y/s3O/PXG0HEa44256R3hovR/tbmaGPd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruEOo-0004dv-Sf; Tue, 09 Apr 2024 18:32:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruEOn-00BKtc-Sb; Tue, 09 Apr 2024 18:32:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruEOn-00H464-2a;
	Tue, 09 Apr 2024 18:32:41 +0200
Date: Tue, 9 Apr 2024 18:32:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle: kirkwood: Convert to platform remove callback
 returning void
Message-ID: <fgmvwuzy34cruggah2z7fau4nnfzopuylsgjs6zzdypp26boya@ekrj5myjef5f>
References: <20230712094014.41787-1-frank.li@vivo.com>
 <20231204115517.zxjgi6ateobjj52d@pengutronix.de>
 <h2sjdrgs7hwmbucr3rxlpusnkpj5tgq2fx27gijtrglr5ffhs6@s63cp4isu4mx>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yudkqucvkn2t7jnw"
Content-Disposition: inline
In-Reply-To: <h2sjdrgs7hwmbucr3rxlpusnkpj5tgq2fx27gijtrglr5ffhs6@s63cp4isu4mx>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org


--yudkqucvkn2t7jnw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Mar 06, 2024 at 10:33:06PM +0100, Uwe Kleine-K=F6nig wrote:
> On Mon, Dec 04, 2023 at 12:55:17PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Wed, Jul 12, 2023 at 05:40:13PM +0800, Yangtao Li wrote:
> > > The .remove() callback for a platform driver returns an int which mak=
es
> > > many driver authors wrongly assume it's possible to do error handling=
 by
> > > returning an error code. However the value returned is (mostly) ignor=
ed
> > > and this typically results in resource leaks. To improve here there i=
s a
> > > quest to make the remove callback return void. In the first step of t=
his
> > > quest all drivers are converted to .remove_new() which already returns
> > > void.
> > >=20
> > > Trivially convert this driver from always returning zero in the remove
> > > callback to the void returning variant.
> > >=20
> > > Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> >=20
> > Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > Can you pick this up?
>=20
> This patch isn't in next yet. Is this still on someone's radar for
> application? Would be great if this patch made it into the mainline
> during the upcomming merge window.

It didn't made it into the merge window leading to 6.9-rc1. What are
the chances to get it into v6.10-rc1?

I just checked, the patch was submitted when Linus's tree was just after
v6.5-rc1. So it already missed four merge windows without any maintainer
feedback :-\

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yudkqucvkn2t7jnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYVbagACgkQj4D7WH0S
/k6KuAf/bT1XmaN2Cba7EVDNiZ//oKiFV0fhRs5/Rr5ue/m8zzAVYdq4vvPluEoT
TxlpEv/dCM2SPexO4qV0WbdGYyiw0LE7eAA1M2I5P0y4GqpUxV935kmzr0Qr47eo
FzpJMCker7SS4DxMH8f9cub97KN79AZycI00s3VmVMkytFy7COBkWbnFOSYfWmdw
KNeEJg6xVc2iblfpjCY25LEAhQn7u+JrnmNZ9DY28OENH+oz4xQjH1O/T+zoLYip
Kul19p3gctyaXhdNYc0HZD7aQX26mEvpD0O7E4pM1Xh8Ps6DI81ppcrsRZFMVgFi
EbiNNMjLiKJWmNsZc3DPZJPma8ydlQ==
=FFjN
-----END PGP SIGNATURE-----

--yudkqucvkn2t7jnw--

