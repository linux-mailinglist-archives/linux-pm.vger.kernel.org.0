Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DC93EB9A1
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 17:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbhHMP7q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 11:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241089AbhHMP7q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 13 Aug 2021 11:59:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A75261038;
        Fri, 13 Aug 2021 15:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628870359;
        bh=mmIVKecooge/8bcS9f0J7os6PhKUAnx5VYDKl8xDsBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h0UeKtiuCmF7ZbGSAr0SIZuSsu5fpSiZqBAlXQ+aTihpG1KFZdVf83yzaeFv7bEg1
         1K+YglebukLQDc8ijvvaAipKKtcAaAQkWqvMJD08xNSRkYQ+xlqtK6AMxkm3DKEWql
         3RlkZFQQgZPHT0A4e2QSBWpGsh16HWG2wKCXu6FCEPvgMSkN9f+a5mewQGj0jJcJkA
         U/4A/q3lwab0e0RTjibr4JmKgEnBLj7YTSu5S5IcVk3CVDJUyJkAS15RtTHNexrWnn
         lNs71tHa7orNoez4ewAEK04xCTs6CMKGyY9r+/+ELDMSrWAUCgb1HN2b5WcyLBvSXb
         +oOhXJntx8Itg==
Date:   Fri, 13 Aug 2021 16:58:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Gene Chen <gene.chen.richtek@gmail.com>, matthias.bgg@gmail.com,
        matti.vaittinen@fi.rohmeurope.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, gene_chen@richtek.com,
        Wilma.Wu@mediatek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH resend v6 0/3] power: supply: mt6360_charger: add MT6360
 charger support
Message-ID: <20210813155858.GD5209@sirena.org.uk>
References: <20210719033914.16990-1-gene.chen.richtek@gmail.com>
 <20210813155438.4ssph6deqksob2uv@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline
In-Reply-To: <20210813155438.4ssph6deqksob2uv@earth.universe>
X-Cookie: E Pluribus Unix
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 13, 2021 at 05:54:38PM +0200, Sebastian Reichel wrote:
> On Mon, Jul 19, 2021 at 11:39:11AM +0800, Gene Chen wrote:
> > This patch series add MT6360 Charger support contains driver and binding
> > document

> Thanks, queued.

We're still waiting for review from Matti on the linear ranges bit -
normally that goes through the regulator tree, do you have a tag to pull
in case of merge conflicts?

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEWlsIACgkQJNaLcl1U
h9AoZwf9HFxqK2eAq4AklZVlMqvPXdEMOIAyrwH6KkySTkl5AajtCofzW9m+02vr
rZ0r+Hbp5wngiO1gS2xHi9IiOupIZ/T0FfUSNKYavSX7+tocv+KlAkDRFd+ktpCo
7rtr9aBOqcljkdX5n2OYZKvwZdJBj6uPEh7qxNivFxpEbCmx8ymL1YWL1pEYlblR
r3sgWu/fZ1sbp1sFwCvf8GqjmP7Qexqaps6Pg+URJFRoKMlctTDp58ONiE71g8t/
Mw0vlKqG4564sYxo1Pp+cxL+lsv5GvUMvWxEwvi+2nlmc2TD0sZ0KKgkGKtQyzJd
kSrVVJ83AhIEe86ozgS7kgsj3tTR3g==
=bg/U
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
