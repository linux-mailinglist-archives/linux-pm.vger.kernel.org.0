Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B718B545558
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jun 2022 22:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiFIUMe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jun 2022 16:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiFIUMd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2022 16:12:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D486572
        for <linux-pm@vger.kernel.org>; Thu,  9 Jun 2022 13:12:29 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 39FBB66016B2;
        Thu,  9 Jun 2022 21:12:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654805548;
        bh=NEfH3aslWx+vIaNWqQUxPJWpn9fGaHRKGUX+5i8F894=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CHb/iXAh2g1hETG+qehQZp0R1d4xNvei1XBe9q+C5utzNF3I60V1nE52ZVOnOZfUY
         BSQLim2LmxrWtF4hYpPApDQNZoQTHhzSO0U1W1Wft6rSvlYe9W3+xvGGQ7R25A+JWR
         zYnkPBAYQjboV+T56vWVPbqSMc4LuUSbT3auUzIiKEyUW3X+r+3oDogystobqIV12b
         3UGeXO3a3Z6r2PFpKTNUhxGV1T6K+BfB/hFOfnFXI319blaoOidq5mqnV4gj7zpuj7
         jrXXEScBQrqli5/y7ltAcoCCs3v8r6mElSHiLsXv63m20trog5hRfOj/jyRlD4rUQR
         IfxBcKA8hhWwA==
Received: by mercury (Postfix, from userid 1000)
        id DAB7D10605B9; Thu,  9 Jun 2022 22:12:25 +0200 (CEST)
Date:   Thu, 9 Jun 2022 22:12:25 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH 1/2] power: supply: ab8500: Respect
 charge_restart_voltage_uv
Message-ID: <20220609201225.n5j3blaripvil7gh@mercury.elektranox.org>
References: <20220415203638.361074-1-linus.walleij@linaro.org>
 <CACRpkdayC3ptQJnAKHGhCtGonYr7M_UythAKRYQsZibrZ9kmNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2ln6tw6dm42ln5aq"
Content-Disposition: inline
In-Reply-To: <CACRpkdayC3ptQJnAKHGhCtGonYr7M_UythAKRYQsZibrZ9kmNw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2ln6tw6dm42ln5aq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 20, 2022 at 11:36:29PM +0200, Linus Walleij wrote:
> On Fri, Apr 15, 2022 at 10:38 PM Linus Walleij <linus.walleij@linaro.org>=
 wrote:
>=20
> > The battery info contains a voltage indicating when the voltage
> > is so low that it is time to restart the CC/CV charging.
> > Make the AB8500 respect and prioritize this setting over the
> > hardcoded 95% threshold.
> >
> > Break out the check into its own function and add some safeguards
> > so we do not run into unpredictable side effects.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Sebastian could you merge this patch (and patch 2/2) now that I
> convinced Matti it's safe?

Yes, I queued both patches to power-supply's for-next branch now.

-- Sebastian

--2ln6tw6dm42ln5aq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiVCkACgkQ2O7X88g7
+pp9fg/+JXcG6Qxyk0apkJrgMzg6Xm+gKwhmc69fAvT9NhbH7e6aEKvsZpXI6/n5
Kl4Vlzzdxc4mWMQ8PhKjUY3dZy9nwhwNrvSOOdYeh0ofEv962a0HbJamHkpsIE6V
SOtKZPnqXIr6p4QiAiVjCerAQvwbZwTVz7CoacUDPXvmjTditqVVkGumD3Xjz4fL
HzKLpp0wS+/XLJv9jUEjgIRJPubFMqdXXLXSnFJY+nD/9TRf6g3NSFg2kzEszpP2
IP+BEa7zT2eq1nUBJ5hPm9mgx08Q0KNQOB2J+X2iyxm3A5e44Q0626h+unyzPKHE
qkZpLY680wxeGw4fw/hAf/+nwRlKYggm4wFXW9Srb18reVoC53Kp5CttNOMcMoSH
f6gXqfMZ7bxym25CJ52IzZW+MSPc80Bm9obbgkkjBWL2GpZeO0BwLFHge18wLBKf
CbdHQbKYUVu/7zssaihjQaHERP+IhKgTSBIwYMESqbcZh5wYIZfXWD6my2fvDy9H
ZxejpAmsr6RbuSENRc0KczE4PmxN2n9NYXsvvwdnvj7kLWsMjyvEHse1tGoo5FCz
U8iP+JG7zs2YAkoWJMPP6HnuENrxpNHTEWOiiL7BHCHyAGrdX3kGlHlo34Mx8rw0
9jEKJJmX9rDrXxYECFEUXAKFa+cO1y2qrxfcu+J/UnYfKEC5Kj8=
=FLeG
-----END PGP SIGNATURE-----

--2ln6tw6dm42ln5aq--
