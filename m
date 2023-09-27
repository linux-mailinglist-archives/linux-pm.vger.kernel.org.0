Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D65D7B0CD8
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjI0Tke (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0Tkd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:40:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DA610E;
        Wed, 27 Sep 2023 12:40:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08192C433C9;
        Wed, 27 Sep 2023 19:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695843632;
        bh=QQvdzs1AcF0olINXFx2N1I0XNRhFjx9/EKURcYlLpGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X4qVDpKyjq5L27GEmmuDN2kZ+tMoB5P45GHqxqnIPD2h+l6BKNPMHM0jYIm24nCng
         evqV7Mj5kfav8MZPlZ0tkSDx4fyWMsp/cNCvWfVVGHEKTXRq9IhNHKqvYVNPk7UBV4
         o8ZqSPRM5Pktufa0G8CkmAjh+y9FL3euCCIayc70+Fm/BCq4/ucSxmxpdfdn6E4Tvq
         0Eon3Ixs85Ll6+0sNtVnDS0hle8PCq15MnzxcyQu+af3zfuDjE0h7ydGBOrHLvGvm4
         prY0Y5M805LdWS/5PAsRmjTDaWtXvhpRdorsxN9zwcw7OvlZ4LeNhcnkBlgtx6hRAR
         qWfWfO52tto4w==
Date:   Wed, 27 Sep 2023 21:40:29 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 20/31] thermal: rcar_gen3: Convert to platform remove
 callback returning void
Message-ID: <ZRSFLXVuXWIUoVlT@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
 <20230927193736.2236447-21-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q/+pK+ejbnJj4EQX"
Content-Disposition: inline
In-Reply-To: <20230927193736.2236447-21-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--Q/+pK+ejbnJj4EQX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 09:37:25PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--Q/+pK+ejbnJj4EQX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmUUhSwACgkQFA3kzBSg
KbZhuxAArprAYZC8IYlnRXUNAcXTgIHwiDUukcHeZruQUClAXbfF1DgA8Q9Xr6Jm
ZhmhIbNBq06MVDWuqqe6oUV0VajN3r4bJ8dEaclZOXt6ULmeSQCWCbiCcR89jJu4
Bx1CJxLhSy3kMJr2GNrEwDwkLUtHMa0Q6mVUxTcESmwhkFpyAKsy0LL9uBCuiqyd
e64agaWQ1ouyycTAb5Dh9sspYQVGvzFzGcVM2rpkAYpzSOo0ZDLLqiMVYd0gwwOK
8QaFXa7saX9oJdQdI0HVsb4X/XG3t1f7WSYbgmYToWnbV2BsNN34lJVWZ4DsSjZD
NqU6BfynZBIjkRWMNqFeXNwhRNgiGmdyJuOEl2e5iysgijPLvYRU500DAqJXUwJi
tjmwULtpNjaW9FV8wQJN949n8bg8svVURgS6j9f4ZIWPCTyim801LCMQtqSADGwQ
QJ7hJya5EGUb/eFSprIw/MuTfDrjz2LUpUXu48q/6E0kmmF6Cb+BRgLJCxZEIF7C
cZa4/mwQU2TTCq7/9misql94KI3S7p24/4z1hbc+7ZX5dOvhxCUFikC8RQiXBqj/
IyUNEJDdjEvjzHCvaMwaYl/N+zro+1jeJu2wbU2T6ZNaC94uiWk5P/Q44ArYZVrJ
wevREEiaciX96s741csENwwCSbF9kuLuiQC7LpgdugZ5zpJbwSU=
=A4Uz
-----END PGP SIGNATURE-----

--Q/+pK+ejbnJj4EQX--
