Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83455611E39
	for <lists+linux-pm@lfdr.de>; Sat, 29 Oct 2022 01:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJ1XnC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Oct 2022 19:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJ1XnB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Oct 2022 19:43:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC6F114DC6
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 16:43:00 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 574396602942;
        Sat, 29 Oct 2022 00:42:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667000579;
        bh=JYCd0OZ4huxkD0mKEGZ6en4V++w8Mw/2eSqNicOtyvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ez0jf3lYWD0CWa4bFrx0Yy/RWDrgDb6lbK+tzOPnt6LRIbD4KzRkawkWYhw7+sVfU
         j749Jrn5BCCxzZW6sCd43GctgKwMKKkSL+FoEFFVPVHClg1TuxZaJtDfW/wQq6d7UW
         XqWd+kRtRUYkznPuRtdIwURuaQZ54myAZoXe9brsE/gSO9QmdZefn9Eyx/0BlJnDj+
         24L8/8B09f2Ih4QWuhvgBINyKqk3EKiS/PqUOu42LXwW9pu5WlbixjmBXIwMtJ/46T
         Br1S/b16gSJaOnGHYh/TqmrzC0Ml5MPB6nsTEB+C14HY5pUqXT2JHjJSw2nOARvojG
         frWi1R3AA9zsg==
Received: by mercury (Postfix, from userid 1000)
        id 672861060757; Sat, 29 Oct 2022 01:42:56 +0200 (CEST)
Date:   Sat, 29 Oct 2022 01:42:56 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v2 1/7] power: supply: bq25890: Document
 POWER_SUPPLY_PROP_CURRENT_NOW
Message-ID: <20221028234256.7f73i2w4yawfnk7i@mercury.elektranox.org>
References: <20221014172427.128512-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2ktrciwj66xurkz6"
Content-Disposition: inline
In-Reply-To: <20221014172427.128512-1-marex@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2ktrciwj66xurkz6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 14, 2022 at 07:24:21PM +0200, Marek Vasut wrote:
> Document that POWER_SUPPLY_PROP_CURRENT_NOW really does refer to ADC-samp=
led
> immediate battery charge current I_BAT , since the meaning is not clear w=
ith
> all the currents which might be measured by charger chips.
>=20
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> To: linux-pm@vger.kernel.org
> ---
> V2: Add RB from Hans
> ---

Thanks, I queued the whole series.

-- Sebastian

--2ktrciwj66xurkz6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNcaPkACgkQ2O7X88g7
+po7iA//Xxij/ZLgfygRG+BZSPGDyy1uWEo0I/FratuPuahGnRmspMuxFbwg9XAd
DzdL4nykmgxXhVxgQUs5StcJsn8hFMLdO8RUERzMQ/m/WelX9SEnp6DyrAsgLI53
anb7vN+VO9NmG07Kv/toGE5vYxDG4d21hJhNP7jHKtlslojw+OXvND6xwzHK+r/s
J/LC2Cg1FGDBxd0QR0RLERsgh/84DH2uk8RHHtNBE5+9ubx/JW3EiOpvCBFW/24Y
Cp9Mp3OLKQg8LgXFu+yVOKz2OR9TQfMmMfcMheNbKIlBFMeSuUSKtrVWIPTTgadl
CB0ixOmNhfgW0S9S2ACHnermztShXGchQYcy2gkugS3A+o5/iMJSZ5iY3HOCSoUX
nfcXPAKRnZ/90LeO8I74F4jmZNmUV4jW0b/2O7RxljkRPeeQ6/AZ+u1cF7hs5l2k
fxnMNFge8gceLQcVZ0ZgZdN14gl1F2cOPybKNuyz0pbFbPxyBfgnjVBapVmoNwxP
d0VR0x6M2xBvB8Q7WMgDsqqJPucneVJBl3L6yoPEwo2v9RIjwqfY8oCe92RJT/tF
UfiOp02S+1JCSGNf4fcapQQd5uwxiHXGhVEIbt4qWNNwIyhIO6ifL3/4ZWKGW1O8
BOIH62bx5WziK8G4BMOvHnrrf8IKS1IWPEX6M0IOjOtpsBxf4dM=
=bW7s
-----END PGP SIGNATURE-----

--2ktrciwj66xurkz6--
