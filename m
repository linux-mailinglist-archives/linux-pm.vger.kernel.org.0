Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADFF2D6B92
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 00:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbgLJXJo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 18:09:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733150AbgLJXJd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 18:09:33 -0500
Date:   Thu, 10 Dec 2020 23:16:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607638562;
        bh=InnSGIQoWR6QhFli0iW2GzxPT5iVHTIFBv4lpfQDlT0=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJu2cLgWJ9GVKSxQCsn3Kw05GOCZ44uJCk9Q8kC/DlWIeyUEGAP4ZL1X+D/srj4H6
         ud3qrrkyaV1kCo4aKLI7765NPeQf2njkFWFbAw6aEupNu5U7+NFbyBlKmIk3SM3v2Y
         m2Qtl8C3bUxlIP99OIVqHq6j517eDI7UNByQqe/YG09wgCDxo8/RgHayUX+b+WxbJh
         wcfi7YnyOu4hnZt5zaPC6ozw1T52su5zbCRpxueusqIx8nlHWg+Himxmir2FneKjc3
         YJsOgQlyU6m/GwCTRrpD8I7oqrESdOjacrtum/014Q0qTbUsPtyyvLUN3fxL4891p5
         QSYws4EyxeNLw==
From:   Sebastian Reichel <sre@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [RFC 18/18] power: supply: max17040: Do not enforce (incorrect)
 interrupt trigger type
Message-ID: <20201210221600.anob3tojbawjhehs@earth.universe>
References: <20201210212534.216197-1-krzk@kernel.org>
 <20201210212534.216197-18-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wjfwdwkje3lnes45"
Content-Disposition: inline
In-Reply-To: <20201210212534.216197-18-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--wjfwdwkje3lnes45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(I shortened the Cc)

Hi,

On Thu, Dec 10, 2020 at 10:25:34PM +0100, Krzysztof Kozlowski wrote:
> [...]
> index d956c67d5155..f737de0470de 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -367,7 +367,7 @@ static int max17040_enable_alert_irq(struct max17040_=
chip *chip)
> =20
>  	flags =3D IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
>  	ret =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,
> -					max17040_thread_handler, flags,
> +					max17040_thread_handler, IRQF_ONESHOT,
>  					chip->battery->desc->name, chip);
> =20
>  	return ret;

'flags' is unused after this change.

-- Sebastian

--wjfwdwkje3lnes45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/SnhQACgkQ2O7X88g7
+pr4mA//ThZw9o3bxNVLKIhusIwVAAxXVR/2ZZmiceJJQcbRLwemoYH0y/G9XqbE
P0FTl1qiLS8A5AHvwcTIS8aTnBqDE2edT42qa5RcBczdB/sZYoBYI2BODuJs8BfD
EGqeyPkxATjKIA2Domnc+yzgJ1pSuXWWU7X1cJvEHhcyD02lKHVXcPMy0lzvdqhC
Tv2xHqEoeUqGNQjlivv8Iv6z9TwwBuGd03U2QLBWJChsCrLXf4jOR8Q0hebuDe2J
58Z+9LslQ9FnUmd1aI9To0LLa8TuDQ2Wqxpw+Hd2RgghzFZ/kwiYHoOKV8kwlEnD
j1TtLnchP7G2eR2q8/JFeqq9Z1lIfDr1V9XGgE1LspGrpmjgYkbdzVSQQSn2mNVF
42x8jIs9zpDdzWBDrF9JQXTqC25MiQ/HI5Y2YuB5PbQOK5tBJ/WMpmfG2PHjClO/
wBpGMZNpF+TbhOhRaADWv3etS+ffBJ3YRW38evN9yJFbWBbNA/gE3DRzsODcbhgh
QonCtVtnAAl/NLLleGMBD5HbTdAWaRK37nAK35wK/CHshp1kfEK8RQ3ua5bP7kPx
Aaj5ZLBk/GHBWtOHNaYesHNvBruVkTrVOb0SbnTaPCpMUkfJEFiOBdX4WZsna4Lw
IDKMNFL+Z5a6pew2eVfLynKAenQWZ7gfEZ8yU3z2Dh2lf56QLfU=
=8NRK
-----END PGP SIGNATURE-----

--wjfwdwkje3lnes45--
