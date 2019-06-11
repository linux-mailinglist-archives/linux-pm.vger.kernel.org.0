Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1BB63D75E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 22:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406186AbfFKUAz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jun 2019 16:00:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405168AbfFKUAz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Jun 2019 16:00:55 -0400
Received: from earth.universe (unknown [185.62.205.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 130F120883;
        Tue, 11 Jun 2019 20:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560283254;
        bh=s/Ht5+9CPxynHvmNGgca4LVS0zf0kgpTAEg3mLddkn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1UAFM7E6z32INie2ywpw1WxlvWw6gwAH+2ireN9vwA81UQSpOFkLHMVPrEzMmFQw2
         UHWF+yTW2DbFptWnYRH5PbiVRaTx9FQ1l9HYpmzrVt3+fq0mqOTVo1ylBdok4j3RJR
         0TsIk179NCnIeR/FUlhchmcMm98+HagiQBI57/Ko=
Received: by earth.universe (Postfix, from userid 1000)
        id C5AC53C0C77; Tue, 11 Jun 2019 22:00:43 +0200 (CEST)
Date:   Tue, 11 Jun 2019 22:00:43 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     mazziesaccount@gmail.com, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v15 0/7] support ROHM BD70528 PMIC
Message-ID: <20190611200043.eib3g3acc7ilawsx@earth.universe>
References: <cover.1559546139.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qfajaxb2wnhwswu6"
Content-Disposition: inline
In-Reply-To: <cover.1559546139.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qfajaxb2wnhwswu6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Jun 03, 2019 at 10:23:37AM +0300, Matti Vaittinen wrote:
> Patch series introducing support for ROHM BD70528 PMIC
> [...]

I think all patches have been reviewed by the respective subsystem
maintainers. Lee, can you provide an immutable branch with the MFD
patches (1, 2, 4)? Looks like the other patches only depend on those
and can go through their respective subsystems.

-- Sebastian

--qfajaxb2wnhwswu6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl0ACGsACgkQ2O7X88g7
+pqpvxAAiZzNy6zuuXZ4vjjMA7V17elDn9CTdWUe1RZBcvYxmFmOUWxTEPtRsmoC
DSstvCVI3H0sOGanHoZ6WFe1R5cyV3jG4J9Xam7XQSQmVpWJPaQXSgQpSy4O6aMX
3Hrs2E8Nv+zUuflVsm4yIOnX7avFBDxBdJlZzKNRzA2b3KOzmNvNr3Y/CbvS9IO4
dTHBXDzcoo+XfrbOKD7Z/0LD6kPsVVkjI8qDiGMN0LCxVkkXV2IFFvMluaWzJHQl
hDUheJRJkD1TXC6z1bCxHSzT4/DCDbWHXN191CnZSIeORMLeZxFFldSmKbYIvOV1
DTJemYQUksIOl2usnvNvSl0GnxjrzZpw7PKbh3rXVlWaa52FEvRJJX++voIP3fNW
zTHSYUTZrBqyLzC4Rp9AWeCy19ebFTrPjV3g3LZDIx0D37C3BeS71gNotRa9o91w
aGBN/Um6Zm3PASbxAPk5TB9RIatlGSELFcVg4qa4of1Y7fY5+O/J5Civ/R1vQJkG
iKE+ujAxYfKJkoUebhETYoHhonRh+naZuEgVC4yl9TsP2hGhz4rArD76kKTUnwNY
g5rSpqb8LptHOkHdkP6ueQYIHavaNGfE6wJBfLqjG3uLU/8RU7YaOqZubQOH/WNT
f2hxCJ76WfvTO5avZpYkykwOS0LwdP8MUoVz2tVnYLYm/q7DhB4=
=2BRP
-----END PGP SIGNATURE-----

--qfajaxb2wnhwswu6--
