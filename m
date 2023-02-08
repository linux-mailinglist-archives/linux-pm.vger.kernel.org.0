Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F99C68E973
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 08:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjBHH6j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 02:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBHH6i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 02:58:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C2440FC;
        Tue,  7 Feb 2023 23:58:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B17EC6153C;
        Wed,  8 Feb 2023 07:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD1DC433D2;
        Wed,  8 Feb 2023 07:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675843116;
        bh=ekCkgDhcpNyTrRI5U/hbOWjhHL/iqJL0wlX8hHfuD04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lymkujf6Tjydq6qfdneiPootbGvCjYiXKslv/Hg1nuijXMQ6kJ3jVQMgzN72PYzRe
         hxTwqY+uVH0AvgkQtHAGSKUcv6IOQPvbNi836nwCwqnXqipmpmmqAVNELqmw+8SRXR
         0aj0uqEUZDtDyLtmClbc5W2Pfa3aU/QBbixiXF0K54Y6vqhHnglAc6c+xNDqjCjsy2
         2oC3DTulpjc/5/OnS4CIZobqgSot6d3DhyPgQNHP3HsIgaVDRq0YtkAJE8+6iPvuPb
         s5aH3w1layMXYMBRJWH/10PbNw2hYsIANpfv1iP7zdejE4mPKWQ2nhW1wkzx3ugRth
         dTAoXc4QzLYHA==
Date:   Wed, 8 Feb 2023 08:58:33 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers/thermal/rcar_gen3_thermal: Fix device
 initialization
Message-ID: <Y+NWKZuQm6uLMkTD@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20230207171011.1596127-1-niklas.soderlund+renesas@ragnatech.se>
 <20230207171011.1596127-3-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="arIY7se3Q65hGe11"
Content-Disposition: inline
In-Reply-To: <20230207171011.1596127-3-niklas.soderlund+renesas@ragnatech.se>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--arIY7se3Q65hGe11
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2023 at 06:10:11PM +0100, Niklas S=C3=B6derlund wrote:
> The thermal zone is registered before the device is register and the
> thermal coefficients are calculated, providing a window for very
> incorrect readings.

While I could never actually be in this race window, the patch makes a
lot of sense to me.

> The reason why the zone was register before the device was fully
> initialized was that the presence of the set_trips() callback is used to
> determine if the driver supports interrupt or not, as it is not defined
> if the device is incapable of interrupts.
>=20
> Fix this by using the operations structure in the private data instead
> of the zone to determine if interrupts are available or not, and
> initialize the device before registering the zone.
>=20
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

One minor question:

> -		if (status)
> +		if (status && priv->tscs[i]->zone)
>  			thermal_zone_device_update(priv->tscs[i]->zone,
>  						   THERMAL_EVENT_UNSPECIFIED);

Isn't this a seperate change?


--arIY7se3Q65hGe11
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmPjVikACgkQFA3kzBSg
KbbtDBAAmTRKdLM3/GUY7HdnBMctjrIX7Sz3rid4nQcY7eFfvSO6lwzOHfSMQ3WP
tmtY8eeQFlA3wvsu2loCgg2jHYJ3oMpBqmjoo1ds/kRiG7AncoIaRbqifgYo3TrT
mNe50Vr4/0BRIvHi3recyUtfrt3nJyMbsE6pPXKXar4z1zt90McalErJu/DS/DHU
AD7UqNe7orqxXtuRy+i+ayVOdchF7L4gWjmAFEgbpXmKacXY/0jOIQpA/k9zWsp4
fUwTZJr+sxXAqWwsssDz34kr56cWScHzk/Flj92cpTUyMo47xCamFxIfCOGYkFUh
UyTkFUbERS35UcPuwcDTk6qdEfM1qZGYZ97uVF+tUU/gC2FSWiuJf30KOPU7fE+c
qoZUQV/zg70EiyvXqJS50QQOMTS+FDA96FaRVWb5lW9AGiasN0o5otKcS9Q8qhFj
XUO4VhvPUq+KV10Waq4Mlk86mk4AeQO9yXrEAvYPVEQQqxRv7so6/0UTYYqFQX/a
oijrgsfez+KvCIc01LMN+lhlSCsvV17P9XWD+VGkkp5LoSFiuxSwZ2gVyPvrgllm
8b/Q6W1M2Txdj189IHsgL3iJIy4C6nN31wZ6JOwBGWqKWZtQHPsXH1wobo4bEB8I
srwWFhqueQkwxuU0ie8pamJjfYViPGO1Y32/BcAF5E2sY0B5v20=
=uYPz
-----END PGP SIGNATURE-----

--arIY7se3Q65hGe11--
