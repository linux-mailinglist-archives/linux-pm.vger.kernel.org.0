Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC86413473
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 22:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfECUit (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 16:38:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfECUit (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 May 2019 16:38:49 -0400
Received: from earth.universe (unknown [185.62.205.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1B89206BB;
        Fri,  3 May 2019 20:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556915928;
        bh=2cFfZAGH7jWOQFIl2RwEvszjulNdiSDlwL0zYZb0C3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xhehueaScZrXhamAhg3qXNToIr0s7PxtUYTIv8Y14eEbLvX0AE7LZZKTDhLpKMCLQ
         mLA3AsQ99MXwxC4VqY4DOhH5ZNXLDqq7A1RmyDLPi9zvsBR/LgqtFMUn9auSnRB9V/
         M3+14aNyhoLcGhQwXMLw/4i0eYjLmwMDmDBu0yPI=
Received: by earth.universe (Postfix, from userid 1000)
        id 6A5623C0DDB; Fri,  3 May 2019 22:38:46 +0200 (CEST)
Date:   Fri, 3 May 2019 22:38:46 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] Driver for UCS1002
Message-ID: <20190503203846.b2zux6cvtkjkrbco@earth.universe>
References: <20190503170042.19334-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u5o4vj3mu6vvwt2c"
Content-Disposition: inline
In-Reply-To: <20190503170042.19334-1-andrew.smirnov@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--u5o4vj3mu6vvwt2c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 03, 2019 at 12:00:39PM -0500, Andrey Smirnov wrote:
> This small series adds a driver for UCS1002 Programmable USB Port
> Power Controller with Charger Emulation. See [page] for product page
> and [datasheet] for device dataseet. Hopefully each individual patch
> is self explanatory.
>=20
> Note that this series is a revival of the upstreaming effort by Enric
> Balletbo Serra last version of which can be found at [original-effort]

Thanks, queued (whole series).

-- Sebastian

--u5o4vj3mu6vvwt2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzMptMACgkQ2O7X88g7
+poQRxAAp9+Y711kaPHlNkdyeJWm2AYbOrE+13EZKJu4y1raee9aAnee4IT+Zunz
i5l3uyL4mmeood3UMwxg/NYM1XAev9ak66glNG/7Ue9z/RIUnfck4/hG9cMLeXk9
3atE1yX5ZT1Cq8LyHyWhu4sUj080A+ynPkqgjWj493tHhBJyc+5MbmDPrcgWoYUf
EGIn3szz/AKe7PwvDZnj7dQv0js87rKExXRwuJOjTLgw2tGdRlP+PjT2a5+Ya+sY
L3/ICu3izAADNo4zRdrdDHzE1CkLs4cCupymDTW7R58DdzzViIGAp5On5RTfb9Cc
rUltoZgyLCqfNkDbSWdtoouuMpJn7wZgnf1sKOTXDopz5L6Sh8YJbTrXTs++bkSg
AnKZHzIQrPxarue/HJoQEnoLvIm2kvaToHUSclmsB0ApYYbrpnprtxcSFXat9nZe
q5Fgwm7Ba0Z0EEQVEL7Q/lcxebmhy+A6CLQgW1ERqNWtP5do9AeTIhKfrSB/a5BL
RFvjZuoRtYb1xcTt4txqHHIc1+zaKFgh417ltuRo6cp8dYXvwasIV8tjstziQLCD
+xCp/JMq5oJ0gUZ9HHiobTvRjY+mlUUhj718CtVzJHrhBON+TBhuQsbSf0e4MKx1
t+hsd+3LxnkYb2wEM1OMwca7MqaWmky+jUfzA/KQyqX8faqcDuk=
=Hklu
-----END PGP SIGNATURE-----

--u5o4vj3mu6vvwt2c--
