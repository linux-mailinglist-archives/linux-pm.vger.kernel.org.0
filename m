Return-Path: <linux-pm+bounces-43572-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADFlFEcWqGlTnwAAu9opvQ
	(envelope-from <linux-pm+bounces-43572-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 12:23:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A887D1FEEA7
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 12:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05F283023DCD
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 11:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A663A874A;
	Wed,  4 Mar 2026 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWQyvxcV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8873D372693;
	Wed,  4 Mar 2026 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772623421; cv=none; b=PJ7W3y9IIg45RWPfHCr5Cn7vpZO+cQRYla12sjYvjSjwgyWVpVbRORL3+a+HWol8jnWp2J2T7SjtwpscMIMb4/ixJB+M6T0906c0dfWQY0o1zJD3RPkwxWqEgFXb2UirKv97oob80f2cx98b7p3MsntE1f9eKOeYZNDbvJpVaOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772623421; c=relaxed/simple;
	bh=h9cK7pBF4PrYZeuQA4C5C9xLaF0GsLQIP8AyKutBfBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCbs+7kp59bB69Sap995w5uIiRgXr7SvnbF+KHSmJEeRTIXP7MaBL22CusSrRifuR4vF1wS2eKduBkS+NGqPiAnUl4eWKmLt4yxgf5AcJM8wAjVnQVqJi0JLxHsGhzvtsySTsnlRiDxb5/0nGabl0hCQQvKLQXmOg6dnhi3PbAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWQyvxcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458E1C19423;
	Wed,  4 Mar 2026 11:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772623421;
	bh=h9cK7pBF4PrYZeuQA4C5C9xLaF0GsLQIP8AyKutBfBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWQyvxcVOI9I/fIn34XDL82Wiv/j9A/0CO+HIzbod1hKepstSs1YL1ATVeJEuknoO
	 G1E4RF2B/MFABg8S/0HhAy7IvbBvPtrGcibTxXxqkZQ7xBDxvBJC+yaoeOlcsC6Ee+
	 ndfD62jjuB1WSwU9SVxtgMsERFivVEvg8KyfWfUpQ6HpK0FeTcVeHuK+vhjHF+mHdR
	 7iIAPaFKpFinAHvRkXItep1op8e6chjhnFmk+4fHsAdkX3yQkRo/ZVscYgN2TuR0Cp
	 cg3k1KseLgnQfcRh46WMlVr7dOefgQP+hRWN1QSYHzDduu6zyCnUwr/opYJn6h1XZx
	 PclxjlJCDXevA==
Date: Wed, 4 Mar 2026 11:23:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexey Brodkin <abrodkin@synopsys.com>,
	Vineet Gupta <vgupta@kernel.org>, Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-leds@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 05/14] regulator: drop unneeded dependencies on OF_GPIO
Message-ID: <31c9910c-8157-40bb-9128-9db34704d637@sirena.org.uk>
References: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
 <20260304-gpio-of-kconfig-v1-5-d597916e79e7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zVeDWCP0gn6RDW1P"
Content-Disposition: inline
In-Reply-To: <20260304-gpio-of-kconfig-v1-5-d597916e79e7@oss.qualcomm.com>
X-Cookie: Take it easy, we're in a hurry.
X-Rspamd-Queue-Id: A887D1FEEA7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43572-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,synopsys.com,buserror.net,linux.ibm.com,ellerman.id.au,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,baylibre.com,googlemail.com,tibbo.com,roeck-us.net,linux-watchdog.org,linuxfoundation.org,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[46];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sirena.org.uk:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


--zVeDWCP0gn6RDW1P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 04, 2026 at 10:02:26AM +0100, Bartosz Golaszewski wrote:
> OF_GPIO is selected automatically on all OF systems. Any symbols it
> controls also provide stubs so there's really no reason to select it
> explicitly.

> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index d10b6f9243d51574a9ac662b93d4678cd7d94a4f..10e64e3ffb1f5f60e0b62b16ab513f002a42fa1f 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -1232,7 +1232,6 @@ config REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY
>  	depends on ARM || ARM64 || COMPILE_TEST
>  	depends on BACKLIGHT_CLASS_DEVICE
>  	depends on I2C
> -	depends on OF_GPIO
>  	select REGMAP_I2C
>  	help
>  	  This driver supports ATTINY regulator on the Raspberry Pi 7-inch

This is a depends rather than a select, though it's fairly redundant
with the arch:

Acked-by: Mark Brown <broonie@kernel.org>

--zVeDWCP0gn6RDW1P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmoFjAACgkQJNaLcl1U
h9CHUQf+OxkRqulw7IQRBWvsy5b7fUXsBVsAfKiGM5xDUpiNuKd4S1A6tLOnAn45
3I8XeQGoX3PGjjNCIQsc3+Tsta1x1lKnTINxC1oxhPg4vuQF8O96ExfK5rw2SbNu
wIgQOz00KrJnhI/QkBNPEUhw2mWXzQuqkwd4ljTlDlUXJCwgc0bWAcR6W7LWq9bW
YeqQrGM7BM83jHyDJAFQsnVLeA6gQM+fV/LkZSTwcNYN3SMz3Csdy3wlcHOEpkbE
Tl7qsVyLstyKIr9F6wUeYRPOH2hl9/Oi9cTvCYBRu1CK/zLsDPyczcWKF0yhfMaO
Q+nIB9oU+/dYWlYxHma+RHEckx9A8A==
=6Y+O
-----END PGP SIGNATURE-----

--zVeDWCP0gn6RDW1P--

