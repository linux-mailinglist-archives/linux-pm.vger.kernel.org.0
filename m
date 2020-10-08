Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169EF287E83
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 00:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgJHWFN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 18:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgJHWFN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 18:05:13 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B725F22241;
        Thu,  8 Oct 2020 22:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602194712;
        bh=Ub0FJIlAo5i4CLixH/BsEDOdlU+yS2Vzjj9uJnIkiGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kw1xhyLBPmsbeaP72r1zdtnUGMcGY9H7m5jtCaQ3R6wy1zhiSYwVuz+uQhsF7tBlP
         UMa2RsZOSwPmtcV9vh0U3MS7IKEmeTJGq5V/z5N3PpVKc7GWbY9UeVq8h9vIfihfiU
         r8/Y9QdIUP/kkR8jay4+BoFwZcmsZDO+I+7Y2ri0=
Received: by earth.universe (Postfix, from userid 1000)
        id 641EF3C0C87; Fri,  9 Oct 2020 00:05:10 +0200 (CEST)
Date:   Fri, 9 Oct 2020 00:05:10 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] power: Add reset support for Microchip Sparx5 SoC
Message-ID: <20201008220510.vhxmduowdnxtswrh@earth.universe>
References: <20201006200316.2261245-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rzpdf624ixjvlnac"
Content-Disposition: inline
In-Reply-To: <20201006200316.2261245-1-lars.povlsen@microchip.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rzpdf624ixjvlnac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 06, 2020 at 10:03:13PM +0200, Lars Povlsen wrote:
> This adds reset support for the Sparx5 SoC, using the ocelot reset
> driver.
>=20
> Changes in v2:
> - Dropped the parts for resetting the switch core upon load time -
>   controlled by the 'microchip,reset-switch-core' DT property.
>=20
> Lars Povlsen (3):
>   dt-bindings: reset: ocelot: Add Sparx5 support
>   power: reset: ocelot: Add support for Sparx5
>   arm64: dts: sparx5: Add reset support
>=20
>  .../bindings/power/reset/ocelot-reset.txt     |  7 ++-
>  MAINTAINERS                                   |  1 +
>  arch/arm64/boot/dts/microchip/sparx5.dtsi     | 10 ++++
>  drivers/power/reset/Kconfig                   |  3 +-
>  drivers/power/reset/ocelot-reset.c            | 55 +++++++++++++++----
>  5 files changed, 60 insertions(+), 16 deletions(-)

Thanks, I queued the first two patches.

-- Sebastian

--rzpdf624ixjvlnac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9/jRYACgkQ2O7X88g7
+pozfQ//bStTlNdFsYlO8C/KeUrAiSn+0v67w9SdW5uqw0EqTd7TNVFC0DTON9W2
h2aSfoQnpBhG4z0OL6daLnpV++e2ys06q89Udt6Y6kC1HJgqmdc93MljR6ah11AY
nvthpSJrBYqWchU28nAL7eDl4Kxz6erFrzuisa8fldyaHr6+/DB00i+bPEzBTZde
YcbJol7Zk0apTv15xHKlu24XZCKg0//EsKTZSW2qWH+t8daiJuEP+gj6VGRCgMay
m10XxGgkbJjMsW9Ye4VWxHAY6HWZa89WP7a6slOIAwlAdEKJz2E0FxTqXOW6S441
XadQ8F7DcE0D+gh+MiQiMUQr/Ujnm1XWH+xXTm1gEefTNsZc23gqL6AFo8ZlhtG9
SaeSAyPQesm5gHNAwN2m10ovNpiAMOyN2TyLx3NMFyQ9jK2z9n+eM431EApCAhV8
jLPnvjCiLdLFsiUZ0RZkynH3g+LRKwJmgJdip279HbzDVbFNq120yavsXXUyOo1L
DSBTtXgBpZe1zu3Nz528XcqDKa0WhQ9809iFGoJLc2CSEgT1eju+OtL4emHNwcl/
r0QEVHl48qJbSZ5SZB54cuusFSDLB5Qj1yIiVmA8gAMQXuGM5F9CNquN1pGaZga/
w5xGzjjYzQBAT5ckojJkn2aC6uw3l/RtZ+mjAXf/xyu8xfDJK+I=
=5WTZ
-----END PGP SIGNATURE-----

--rzpdf624ixjvlnac--
