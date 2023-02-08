Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10A268E95D
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 08:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjBHH4X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 02:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBHH4W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 02:56:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83565234DA;
        Tue,  7 Feb 2023 23:56:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CB7C6152B;
        Wed,  8 Feb 2023 07:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22839C433EF;
        Wed,  8 Feb 2023 07:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675842980;
        bh=HhIyBnuSmK06Cz5C2I08j/eNJ/pQtEXAaN5WR6rm+G4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZbPlX5+ARolOCyQX6NfGDNLTyfK5W++2xjBgaLHqr7vDgd7SKLapu4YRUmMuUOF2Y
         8r5riCCa0Mv/zZpXU4l8KESJdCpIkn8lq7NinrJSQeuceCdl432q5Zyc3EVCI1vBee
         ODU8WMkkCOUFPK+17VW9kvZ4s1pEHJneb5DjWj8rb/gpxM9xklXHEEhoF8dXlmU7Cl
         LCtnmKJcdGE7pyM3e3isoNW+WYeEcNOrT7c22T8BKtX23Jn81XVlu7mb7tE0o+KaiS
         HmpQA3lid7efQZSHrOPNvz9lk8AppLSePsV8p7Lr9vbQjJbxYOi17q34RJTiqPNz4t
         lVD/I3R8/u3sw==
Date:   Wed, 8 Feb 2023 08:56:17 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers/thermal/rcar_gen3_thermal: Create device
 local ops struct
Message-ID: <Y+NVoZeqiM7cDt5w@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/t6GYb7ZDSOkQpPq"
Content-Disposition: inline
In-Reply-To: <20230207171011.1596127-3-niklas.soderlund+renesas@ragnatech.se>
 <20230207171011.1596127-2-niklas.soderlund+renesas@ragnatech.se>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--/t6GYb7ZDSOkQpPq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2023 at 06:10:10PM +0100, Niklas S=C3=B6derlund wrote:
> The callback operations are modified on a driver global level. If one
> device tree description do not define interrupts, the set_trips()
> operation was disabled globally for all users of the driver.
>=20
> Fix this by creating a device local copy of the operations structure and
> modify the copy depending on what the device can do.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

I like this!

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--/t6GYb7ZDSOkQpPq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmPjVZwACgkQFA3kzBSg
Kba7uxAAiVOoCe/Zr35QPGC6z2fTHD9x4f8bGyXN+ZyzkPkxKNkRNaagzjeNStb1
8aj+Yvx2B97kO5sLI5gaKCo40rRfZkUC/sofzydxLTwoWPYWtFh+SBm4s2lmE7r3
r30FJuFlFNq/Vhg6T63IhAl3pm+frbk+05aXQrJmo6Md0frnoik852OgsbBlX7if
+qXyMb6ccoCONzsuhKfVCqC+mkcvhCFI+hT4piFwxZYvqvtjoh9j/T+Wx20RF99S
7aVz8hdszhcB56J+t0n6YjbEEWEfbF4tgCBUdiys+yCwPA3kpOco+QXG4dN9rZtT
bjEBclZBPj8uBGPEIxuoCebLDriaTUUjHM9uWkb/JO7ZINM1KL38+lUAthY250yP
wTTknJ7xQmZkO3rtNbXt6drq11H8GKo9/6EH6bdWPzNpt2JE1XFtkNBgEwKRvD7F
Rf9DD6TvryqUCTrLLvyKh31hD9jYMoXom4i8yTRzfmFa23+USOZxSFR0bl0QLlI9
vfNXLrUwCBATBb/OeVrYLfIwYFHhRljcdQIH2vvyZnae6rpvoC0p8DYZM29sNJtx
hdrwX9uAbLWMUKG67pbxN9uIvc0oXao5gJaNKhE3WFxe5wKjBUXDVPHRhcHoFlBt
bfjLfzKwjYN5y+8kSBEIndsvDkaS7oHcPjweT7oP+8APAD9RhRQ=
=TSHR
-----END PGP SIGNATURE-----

--/t6GYb7ZDSOkQpPq--
