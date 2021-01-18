Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8862FA064
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 13:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391635AbhARMvU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 07:51:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391933AbhARMqX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 Jan 2021 07:46:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F855222B3;
        Mon, 18 Jan 2021 12:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610973942;
        bh=LNff0UBizKktpvktRVvs3pjfNMwgUksevEkhf0JcYwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=abJnP8jAPPSr3/4Q485xn7McL6jqFW/7C/W5qSPLFxokl/1c1a2K5By3XkDw0etT8
         K12Z/7Yyu4vrsvwpAsmktLjpopz/JhcVmStVgQASYlcp41i9HN+L1CBUR1H7g1fMc2
         0ldAN/dGZGzHfOPI78CWC2d3MVNN8JGzVYXj25rEkOoJfStPfETspU1qw+gXATl6QO
         MXcOgBA9b9POSx8wMWdgBC3oKDEfmlEo0LdynkWzl3L/YH8RWJJ0KrjSNyU6cfqiVM
         i+BY+3nXUrxSX1nHMCmGzt5kfdqR5RMxWJq9PhgdQYgKICTm9oSbNkVP4FmZPA2njQ
         15teiqit6t1zg==
Date:   Mon, 18 Jan 2021 12:45:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 2/8] regulator: dt-bindings: Document max8997-pmic
 nodes
Message-ID: <20210118124505.GG4455@sirena.org.uk>
References: <20201230205139.1812366-1-timon.baetz@protonmail.com>
 <20210104183821.GA29033@kozik-lap>
 <20210104212449.GJ5645@sirena.org.uk>
 <20210105165529.GB20401@kozik-lap>
 <20210106145931.GE4752@sirena.org.uk>
 <20210108161635.1b9303c8.timon.baetz@protonmail.com>
 <20210108161653.GA4554@sirena.org.uk>
 <20210115071914.0407a928.timon.baetz@protonmail.com>
 <20210115134213.GB4384@sirena.org.uk>
 <20210116090306.7c3d8023.timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V32M1hWVjliPHW+c"
Content-Disposition: inline
In-Reply-To: <20210116090306.7c3d8023.timon.baetz@protonmail.com>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 16, 2021 at 08:03:25AM +0000, Timon Baetz wrote:

> I could use extcon_get_extcon_dev("max8997-muic") and basically hard
> code the extcon device name in the charger driver. Then I only need
> charger-supply in DTS which could be added to the parent device's node.

> Would that be acceptable for everyone?

Sounds reasonable to me.

--V32M1hWVjliPHW+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAFgtAACgkQJNaLcl1U
h9CpQwf/fIRDXKLWQlexshrS3nrpFq9wDSuen/Ofo0KT9QJTAemn2/WJXtmbZK9Z
zZYiaapSLaOCjzqLmc0DgqttqYDjcNMUaOAe79kdHlFq69zSywqbgo2yPrBtDfLr
8r7oiv10U6BS9p79q+ww4Ohnhc1WpRhWLlh+XUZUAhLw60+1nvZPSkX65TcNvGK6
oYgk7/E4NFDc3QWf/6qbOFdqj9u2+TwF98PYOs1QXcF6XbBhesD47iew0ITwWYm3
lIAPmaUpCAryiWDrQap/HvlbA9cvU1v3kHrXj9g96mxZfj/NULTEQPks3LSYqPRZ
QozKbT6eTl+qq11mVKN4jgB3gHYOew==
=xJlP
-----END PGP SIGNATURE-----

--V32M1hWVjliPHW+c--
