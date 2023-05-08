Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC546FB53F
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 18:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbjEHQhj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 12:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjEHQhh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 12:37:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34476E85
        for <linux-pm@vger.kernel.org>; Mon,  8 May 2023 09:37:34 -0700 (PDT)
Received: from mercury (195-23-45-170.net.novis.pt [195.23.45.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5325A66032BE;
        Mon,  8 May 2023 17:37:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683563852;
        bh=0vrRbihnab//OLjwQ7oGjZlUOmbpiqDyRB++TNkiJ08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HltATaaCJKgE8OesBxOEFvC0bqa9ViNBulqwy3gctZU+QSxDJXGKAzeqZPGW0M4e+
         64KigsLstygTRMqMmrSIhvSJ5ur4NQS+QWm9qhWK1uoRWsmy9p7FqVTi/7c4gbKoHu
         Atqr/GUAZtdrkn5KX5kF2URcix0qi5ciXYtw5Re+NxwGSXjJSVJTgTAVlYc1ks+XXp
         AjjPietGC1891NW6+LkxyOR7JxAibI4Q8eVVafExOH9oPiThx4umCb8mSPugZO3A+4
         EvVLfEu44dEKIbda7zZR302+VUBcqoQyTprwbJ/9kYhWo/oNFGzDSpQC0G5tt0EDkT
         Nru425ICfW/7g==
Received: by mercury (Postfix, from userid 1000)
        id 47ADF1067082; Mon,  8 May 2023 15:30:43 +0200 (CEST)
Date:   Mon, 8 May 2023 15:30:43 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Marek Vasut <marex@denx.de>,
        laji Xiao <3252204392abc@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 00/10] power: supply: bq27xxx/bq25890 status update
 fixes
Message-ID: <20230508133043.rvxap5phhftnaud7@mercury.elektranox.org>
References: <20230415182341.86916-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="izz2xj4awwtrhj7x"
Content-Disposition: inline
In-Reply-To: <20230415182341.86916-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--izz2xj4awwtrhj7x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 15, 2023 at 08:23:31PM +0200, Hans de Goede wrote:
> Hi all,
>=20
> Here is v2 if my bq* status update fixes series
>=20
> Changes in v2:
> - Do not use bq->charger in bq25890_external_power_changed(),
>   because it may not be set yet (avoid NULL ptr deref on race)
> - Add "power: supply: bq24190: Call power_supply_changed()
>   after updating input current" to the series
>=20
> The main goal of this series is to fix userspace sometimes not
> getting notified in a timely manner of charging <-> discharging
> status changes, causing e.g. battery status icons to lag
> and the lagging of updates also effects power_supply_leds.c .
>=20
> While working on this I noticed a number of races surrounding
> bq27xxx_battery_update(), so patches 1-4 fix those first.
>=20
> Patches 5-10 take care of the status update lagging issues.
>=20
> Regards,
>=20
> Hans

Thanks, I queued to the full series to my fixes branch.

-- Sebastian

>=20
>=20
> Hans de Goede (10):
>   power: supply: bq27xxx: Fix bq27xxx_battery_update() race condition
>   power: supply: bq27xxx: Fix I2C IRQ race on remove
>   power: supply: bq27xxx: Fix poll_interval handling and races on remove
>   power: supply: bq27xxx: Add cache parameter to
>     bq27xxx_battery_current_and_status()
>   power: supply: bq27xxx: Move bq27xxx_battery_update() down
>   power: supply: bq27xxx: Ensure power_supply_changed() is called on
>     current sign changes
>   power: supply: bq27xxx: After charger plug in/out wait 0.5s for things
>     to stabilize
>   power: supply: bq27xxx: Use mod_delayed_work() instead of cancel() +
>     schedule()
>   power: supply: bq25890: Call power_supply_changed() after updating
>     input current or voltage
>   power: supply: bq24190: Call power_supply_changed() after updating
>     input current
>=20
>  drivers/power/supply/bq24190_charger.c     |   1 +
>  drivers/power/supply/bq25890_charger.c     |   3 +
>  drivers/power/supply/bq27xxx_battery.c     | 181 +++++++++++----------
>  drivers/power/supply/bq27xxx_battery_i2c.c |   3 +-
>  include/linux/power/bq27xxx_battery.h      |   4 +
>  5 files changed, 108 insertions(+), 84 deletions(-)
>=20
> --=20
> 2.39.1
>=20

--izz2xj4awwtrhj7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRY+X8ACgkQ2O7X88g7
+pp0Tw//eaFlF+wB960LlfnoiBzrms9OLZ5R+xWfZ0zy8BKVElboYHWaWlMzXsrZ
Y+TJwdMzViq1RuUkZqcyarXP9Ss5e+LxxqbgqyRPBXEKTQAOMxP+AYTrJWaYs/pc
RCBMLUp5y9ONVGHyIr4FwKf84T/O9mdz5z/J3l8UAdKbfoVcB+gd5oW7XZPCNAei
neiQWoWZL+MmlLqDukN4TA89oRWUHbeJUKTPG7urZSqMaqs63US2VfKnHCOjQCkV
JLN/LFbJLzuJeYi/AI6jMNdYM0LE570HVwP4t5rvhkPvcQBsmBZ1yfhRQwBquL3c
RqN7q2Wt/htREE2uPqkRrefXJANx1HllR+O0b/nw/AW4Kv/C9TrojkPfRY/V5DWw
IZXwJ1Hl+sSIoesRsCDnYFf18hCWwB8x96siiqu1x4Pa+CastVmSM7K8p03/VeDC
bvsn8AzaEajL3IyTVFefzZN1KAOM/VoFxXuCqJm3dYkniAEVg2GqenkpXpUlihSd
LxLnkUOZ+l7w0Ee47Cwh3Eo/hLjkVj0zeGNSw/X2pie8yKDUaJJgOuyMVQgMaxlM
tEnjHInKHGA3xTQqBZaZGwyfvoJvhEAj3JpaiVFJjLEpOmsiGpIeGBjRtC2rXARW
az7kiuBUVcsdYJ8HGmEXLR3UqC+T6JOvA41siA8a89Kr7lkkwNk=
=mwGh
-----END PGP SIGNATURE-----

--izz2xj4awwtrhj7x--
