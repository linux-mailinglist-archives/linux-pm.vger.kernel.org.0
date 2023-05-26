Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050A4712A20
	for <lists+linux-pm@lfdr.de>; Fri, 26 May 2023 18:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243927AbjEZQAi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 May 2023 12:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243897AbjEZQAh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 May 2023 12:00:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58F0187
        for <linux-pm@vger.kernel.org>; Fri, 26 May 2023 09:00:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2Zrl-0007N5-50; Fri, 26 May 2023 18:00:33 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2Zrk-002zHp-Gc; Fri, 26 May 2023 18:00:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q2Zrj-008Cim-QB; Fri, 26 May 2023 18:00:31 +0200
Date:   Fri, 26 May 2023 18:00:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: Switch i2c drivers back to use .probe()
Message-ID: <20230526160031.itnqw4skpfdwlawt@pengutronix.de>
References: <20230517165514.163216-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="owunuezhnqoqlitd"
Content-Disposition: inline
In-Reply-To: <20230517165514.163216-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--owunuezhnqoqlitd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, May 17, 2023 at 06:55:14PM +0200, Uwe Kleine-K=F6nig wrote:
> After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> call-back type"), all drivers being converted to .probe_new() and then
> 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") convert
> back to (the new) .probe() to be able to eventually drop .probe_new() from
> struct i2c_driver.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> I used v6.4-rc1 as base for this patch, but it also fits on top of
> today's next master. If there are some conflicts when you apply it, feel
> free to just drop all conflicting hunks, I'll care about the fallout
> later.
>=20
> I chose to do this in a single patch for all drivers below
> drivers/power/supply. If you want me to split it, just tell me.
>=20
> Also note I didn't Cc: all the individual maintainers to not exceed the
> allowed length of To: and Cc:. If this patch will be split I can extend
> the audience accordingly.

I didn't get any feedback on this patch. It's great if it makes it into
the mainline during the next merge window. Any chances for that?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--owunuezhnqoqlitd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRw154ACgkQj4D7WH0S
/k57EggApRqzzTC+44kfUD2qS4RLJcxMM3V2LDNij6RcRLKVE7IThzX2ct3Vl2Ta
5Q/j6akppzwvvfF7ynBLaU+zAmc+1HRQ3rmoCi8yMGXs5gLAxEMU0OP72uzU7H6o
1167nROizoqApsEpbdFi0iXeKvVy/BBwb031iWJgBV4KHZvKPF4dzJ+148KLWzdL
FmuSJsRsd/vsbAHeXuWwTDJtBIgQ57KQauQC9U8xXTZOZnvjBD9zo0Q69Xaz328S
6sAuVPPAgVBvLdcREX9bCmeyp3FMO6Xy/v1ZG0taoOeQZ4W4s5iPgASff2gbB4sg
7r+jABY4XXFrim+BTg2+QpdxT/qqrg==
=Zg4L
-----END PGP SIGNATURE-----

--owunuezhnqoqlitd--
