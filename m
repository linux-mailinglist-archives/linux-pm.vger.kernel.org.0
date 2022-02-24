Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02044C2B24
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 12:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiBXLpn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 06:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiBXLpn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 06:45:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EFC3EB85
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 03:45:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45619B8243F
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 11:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43FCC340E9;
        Thu, 24 Feb 2022 11:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645703110;
        bh=d2Dbv93H0cqiLL1VOJ5nPWYsr5VQ3TvO/5U0wC48uUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HnVHObYXGQ6IzZxR3o+W5rv42k3c6X6inOwghw8/y6KFlkoyEL0crJvqEoscbNvoo
         /68gJLv8U93goJea9M2+GTVord9FHmMj6O3R4N7wpplR9s9kxjRz3cZ6HyIOqGCYEY
         zqZceWqpdoYkV/ngxAd5r0Wa3SfvQdPbrmJbgbLEJmOyNRFh9gmFKINFhCqJZn/03s
         +w5/cM5krY7Fv8843tBCunwIyzlTvLVfJSRFtgeYq2YS+FYKro4koZYsJAotnH5hdY
         JRVjjiLGTQtNfh7dNVaNdBUX1ETQ7hsH61WdL/6JIdVaJBueEGAx0aiAQRL0UrbQGv
         B3MPGWLtxHJRA==
Date:   Thu, 24 Feb 2022 11:45:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: Use an rbtree rather than flat register
 cache
Message-ID: <YhdvwYt+7ElEGrmZ@sirena.org.uk>
References: <20220222214331.1557723-1-broonie@kernel.org>
 <951baa84-1613-7567-4426-ffc6412994da@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fI4Tm7pBUqTB6OBd"
Content-Disposition: inline
In-Reply-To: <951baa84-1613-7567-4426-ffc6412994da@gmail.com>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fI4Tm7pBUqTB6OBd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 24, 2022 at 02:07:58PM +0300, Dmitry Osipenko wrote:
> 23.02.2022 00:43, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> > -	.num_reg_defaults_raw =3D SMB347_MAX_REGISTER,
> > +	.cache_type	=3D REGCACHE_RBTREE,

> Why you removed the num_reg_defaults_raw? It was needed in order to
> populate the default values on the regcache init, is it somehow
> different for the REGCACHE_RBTREE? Otherwise this patch is incorrect.

rbtree caches will dynamically grow at runtime to accomodate any new
registers they find, it's not like flat caches where they are intended
for use in atomic context.

--fI4Tm7pBUqTB6OBd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIXb8EACgkQJNaLcl1U
h9Ar7wf+I8AWs6tkRwBBvBHDugswTVVXXn02/2bIcAvRF0FViqke9iCfZ+9TQ597
4OVLlTUXRDy1GmabgR4nYWCGJIFOOl+cXxgiMoeu23AyeviY1tFVusfBZlBTFsq/
ndarD41MIbhUjxGAqApTsMfbjBGNLuRCsdnms3c2dIxnPbfCZjF5yxYs+T7kag98
9RscmssqEW8VRwP4OVlXk5urxK7unreyb5mbao5MqbD7d4GEgdYCdppoYITf66+B
7d3ejGF1YRxB5BZwAQG5LdoSPtZxM+OkohM9HKx8muNcLCNwW3hU0JlD+hrnn4th
YJyXbrRTHx6EqYjwj3TRE9R/9hCBAw==
=54GH
-----END PGP SIGNATURE-----

--fI4Tm7pBUqTB6OBd--
