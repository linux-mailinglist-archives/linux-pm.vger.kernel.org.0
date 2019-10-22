Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32A58E090D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 18:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389501AbfJVQg2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 12:36:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58756 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389416AbfJVQg1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 12:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M16s+hjSDlE6TNgtBa3MKM4TCqAq6AmiEIcWbfZK0/Y=; b=fNUlDze7oxEGXu0bsJvv6CQWR
        sTGIW/95FU2RCYkgoZAholUl+Q+0Ndxbv84tD+w1SfX7zOT42kiyBr1omdpPem6a1I1Ty+hvpKmL6
        rNyBWgZgynitj5VjL3zsJwsd+4Uf8MFzh9t63NFjcpMtMT+uizU711YueP+vFO/PXn9Zs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMx8o-00072B-Aa; Tue, 22 Oct 2019 16:36:14 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id C47D82743259; Tue, 22 Oct 2019 17:36:13 +0100 (BST)
Date:   Tue, 22 Oct 2019 17:36:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 05/46] ARM: pxa: split up mach/hardware.h
Message-ID: <20191022163613.GL5554@sirena.co.uk>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-5-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cy9Nn4fUvYST66Pl"
Content-Disposition: inline
In-Reply-To: <20191018154201.1276638-5-arnd@arndb.de>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--cy9Nn4fUvYST66Pl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2019 at 05:41:20PM +0200, Arnd Bergmann wrote:
> The mach/hardware.h is included in lots of places, and it provides
> three different things on pxa:

Acked-by: Mark Brown <broonie@kernel.org>

--cy9Nn4fUvYST66Pl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vL/wACgkQJNaLcl1U
h9A46Qf/bdiNYPmWVC2CHNC1L2OLkyJ66QpIcTPyD+TqK5kJogwOBaO1gXSF9Zzl
FrZ20C2apP/oPsDhXu0l5d3giQifXBNvev/89QnOX2UBhrtJV9qE4LHll1hjeyKZ
BEGejSMZnKNLyUDKEbrGg/LeAlDx8G1odI34QfZvmSJVBKinRssnwpnH7UNZhU9s
9SvLSPJjxoWD6gDsShV0vYuFkd6XQ68qOna4lj6KknkkAE9jIpQb+fFBVqYNKNgp
Ttp0KkT/l1DAlDx4lMDfWkr/8u3807G0HTJ6xYcjeyd7e40utLqPnFLeQpMS+RGb
96bq1ZoL9nd8PdzO8lOK09fB0kB8Mg==
=tCNh
-----END PGP SIGNATURE-----

--cy9Nn4fUvYST66Pl--
