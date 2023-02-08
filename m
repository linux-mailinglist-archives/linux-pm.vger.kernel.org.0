Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E96F68F083
	for <lists+linux-pm@lfdr.de>; Wed,  8 Feb 2023 15:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBHOOd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Feb 2023 09:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjBHOOc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2023 09:14:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434C94B1AF;
        Wed,  8 Feb 2023 06:14:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D39BD61554;
        Wed,  8 Feb 2023 14:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3081C433D2;
        Wed,  8 Feb 2023 14:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675865647;
        bh=ElDYKyIKxY0GAmVI1DT9edC+TsIyIstrC2dLihEWpeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IlbL67f7h+FSoYQDHaW9k/Z7Ml6D7r/RxeLtUJMJkDiRVPpkvBY5LR1/XyoWV0EM6
         iIQqPEyH6yzitBRKQNENOVsMVC8sxm4JMdpG2w9fc9BPXtiQG+5qfv6WFEk6pErAmE
         DXHj6Np31PU7SO2W6SXLtaYbwL+cMEEVBYipShKPNzdWdlZgXCwkI7ynnGOWFB/ZWm
         QZsZAid0L2ykz7optptiHR9JaQHlOdWljd8EiXcYTXooz7Ih5iBzAL79t928PhlO2d
         AwLP7CvLHy52PAPWlWuqBJOvX49A/FgmWxYSP2dGr8AE284O3q2TFdFNd3orvOIctg
         CRYew3Caq54BQ==
Date:   Wed, 8 Feb 2023 15:14:04 +0100
From:   Wolfram Sang <wsa@kernel.org>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers/thermal/rcar_gen3_thermal: Fix device
 initialization
Message-ID: <Y+OuLEUcMseeL0oF@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20230207171011.1596127-1-niklas.soderlund+renesas@ragnatech.se>
 <20230207171011.1596127-3-niklas.soderlund+renesas@ragnatech.se>
 <Y+NWKZuQm6uLMkTD@ninjato>
 <Y+N1dDVKqUTnHLQj@oden.dyn.berto.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vvNGnJY5+3JkXuMb"
Content-Disposition: inline
In-Reply-To: <Y+N1dDVKqUTnHLQj@oden.dyn.berto.se>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vvNGnJY5+3JkXuMb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> While not updating a not yet created zone is fine. But this should never=
=20
> happen (tm) as the trip points have not been set when this window=20
> exists, but better safe then sorry.

Full Ack! Thanks for the heads up.


--vvNGnJY5+3JkXuMb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmPjriwACgkQFA3kzBSg
KbYFGQ//Vzv6bOtpQk0Le8rf1CEIpcCymm3Xzcsta+d1K9WyLJuGecW00HLZhhWn
VvQrcve6tKXB+LF/WKuQmaz7HiCV+PhSxGIIs3R90YNstPZ0fNZc8L2TvSkvYDbN
O/ff/mIQUkNNJf2SrICRzwk0RGHA8SbNO6QmRqmLXsYOleEQ3aqvb63SZvVUHtin
eUWkbzgoWzSOrC3KMg5w9GRsejLVg9mYiBURKKK73qX0osgLXFW/KtByBAv5bXbo
lQLOhNA66oNQeow9pIF2HKOurWFFc4HUD5maDWlRwlg6v7ak4jpL8uYesH+sbD+T
CQRlCXjvC0Crdm9gLYr6pWor/zxgbu6gOoTKUEeinLrDz3i1EO+vmvzRVT2wbZh9
i0bOcPlvY0Bpc41IavUtSzLwibpMWsdXVNAwOxZneK+ZTQpDndp4oxXfl5TSMwsd
8hFlQkXglyhMn8G1Ox1LxYmBzRh0WL6cueWfVqGAAvjMVz5MEwp2CJz/SEvRKqyw
XWaadVjEU3GuO9MQ4HQq0/fYuJLUtwIjdjldijODyyNPFNWq2NvJcwqiRELaUQOf
1LrW1tJyXhkeb2TL4V+6uW7hQg8u/XJOVsE9YQshKm4V3HfLsGIgdYFB3Y7y9Jnd
x7OWS8nr6qkYjT7tiunMTVecGbCjG7cLf7OeDKUJ6T9nLPlJgeI=
=f+ED
-----END PGP SIGNATURE-----

--vvNGnJY5+3JkXuMb--
