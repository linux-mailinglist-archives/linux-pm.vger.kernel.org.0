Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5824D8938
	for <lists+linux-pm@lfdr.de>; Mon, 14 Mar 2022 17:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiCNQdl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Mar 2022 12:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiCNQdk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Mar 2022 12:33:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8081F20F72
        for <linux-pm@vger.kernel.org>; Mon, 14 Mar 2022 09:32:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8948B1F435FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647275528;
        bh=//u+LJPMMoJbRLbBVsx78e85fQ6TZwlP/eMsprhYtc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IEG3sLqGeSLFFozD7eiqTLDZmfuVtqCmUZ8QwbZ8KqPjpXE6+2FNCulpkE/f/i7bh
         EhgPpCaQ6ABlaQLYx8nT/AR0KCfAY0eTB3e6iL0nXFI8Fk2/h9Esd51USU43qpf164
         My++Rch0/oYa4rDUGb8+wtOFGmpK1uiR/G6PiI4bSD+PyYUlLt2kiWcYf0sMx/IoOm
         279lJGdIhL4ECCaPLKOmWOXtUbLluwK/Wy67/oI62PgX7vmUnsnh5gG6CM6/1Ef8oE
         uA8dzQqbVLNcvwIYDKc39ziq/n65hxWmbSNFhmalXKJPdlFXYLcUTW1uOs6FFFocSx
         QATFCam0GqFzA==
Received: by mercury (Postfix, from userid 1000)
        id 7FED3106025D; Mon, 14 Mar 2022 17:32:06 +0100 (CET)
Date:   Mon, 14 Mar 2022 17:32:06 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marcus Cooper <codekipper@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH] power: ab8500_chargalg: Use CLOCK_MONOTONIC
Message-ID: <20220314163206.prytbmueey3xmozr@mercury.elektranox.org>
References: <20220308154425.296308-1-linus.walleij@linaro.org>
 <42220d81-0f7a-a134-98f6-bdbabc584b20@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vt37ayqtexafhkbv"
Content-Disposition: inline
In-Reply-To: <42220d81-0f7a-a134-98f6-bdbabc584b20@fi.rohmeurope.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vt37ayqtexafhkbv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 09, 2022 at 06:45:59AM +0000, Vaittinen, Matti wrote:
> On 3/8/22 17:44, Linus Walleij wrote:
> > The HRTimer in the AB8500 charging code is using CLOCK_REALTIME
> > to set an alarm some hours forward in time +/- 5 min for a safety
> > timer.
> >=20
> > I have observed that this will sometimes fire sporadically
> > early when charging a battery with the result that
> > charging stops.
> >=20
> > As CLOCK_REALTIME can be subject to adjustments of time from
> > sources such as NTP, this cannot be trusted and will likely
> > for example fire events if the clock is set forward some hours
> > by say NTP.
> >=20
> > Use CLOCK_MONOTONIC as indicated in other instances and the
> > problem goes away. Also initialize the timer to REL mode
> > as this is what will be used later.
> >=20
> > Fixes: 257107ae6b9b ("ab8500-chargalg: Use hrtimer")
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> FWIW:
> Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Thanks, queued.

-- Sebastian

--vt37ayqtexafhkbv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIvbf4ACgkQ2O7X88g7
+pqvSw//R5u2fkOzzG8eCtQqlVrPASXtB2df+aqPcnTp0m/Ju/23oK56F1CkIQvd
zhPpg6jBSlj6lVf8eeyYG+lbbcD26eN1xBRLFqPzk2v9FJjXcUXSwFDmKnzez4Lk
6cXDWuK7KOYwgDsYF6+bkjNMOcRQgFH10YI6trVZRyF4a59dlFZk9lFWgau6owzz
0GQEfLDruwDIiGqHN7YI3IwycVd0nU8gXINaPE4qp5KIc9HGFODPhwqCQnCsJ7GW
7Co47tHoJ4MbgBHuKTjpO7V0hQl9se17OeNVOFzuQssAspNLoRXi7Qj5+bA/yoz4
VlZHshkxJ70S1IiBn7gBibD52rCq5R+Jux+sKjl63GgzEpAHKAl2B7JMdKFBeZum
LMCY7rRqwzamDJjQz4G+jN+ky1WON63k6B/eDffxhnRAbhLX9w2uIczw6QdlWg4J
etevDEQ2EQOuCh/+AqaDoUaTKq/278nQ5+kHbNcNvc2KAtx7YokrglFNvAlKBdqY
9IJjma5TMp9yhJopqgfQJzYLWmlvyrURMyx5uvna4mEqfxyKZN4KvSIdnzxBidKn
ZLVXv0Z127GrSFjLxGpQYvkKJXQ0V3om9t+3qsZco3x4LctAXC8ReZ+QgT5xmevx
1i8HZQTZJXIEMNQofRySQTuBVqZjqulA2JNxcbe0SeV9rq/Cdjw=
=jcJC
-----END PGP SIGNATURE-----

--vt37ayqtexafhkbv--
