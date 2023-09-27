Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051247B0CD9
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 21:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjI0Tkn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 15:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0Tkn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 15:40:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC9510E;
        Wed, 27 Sep 2023 12:40:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9C0C433C7;
        Wed, 27 Sep 2023 19:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695843641;
        bh=F85gmfE8TcTzez0LIiUybafKKE+G4+vF/BPE1rkK/QI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFu0wf6hzJvTwoAWNtrzrb512NOZGHph6bzupFx5lnAzjNTBi5w1R4DyrPvxY6f54
         ssx6zJwg0ZIx+CWXtCSUi/tAkCPY8MLMnwO985W/0XghcHkaeUJ0kj/JKEoxv+Aku/
         rahxXQK/3vYNGDL7ch5mV5X/fmTczFJ4IVXBf83tURBo/xmtdaXuCJpFq6PjDzvQNm
         3+h/WcvKLmM5KBZe1IsgwwVyy10PG75tk90rGodnXwOqTG7wGGYOL/CXEmjzbfZxD1
         Z7GfI2AuWyHElZe8/zuiEsVzoGH6GrWqZItwBXulGEw9R0QczillJ9EsxuzvmSG5W9
         XKlgIiZ9QnOWg==
Date:   Wed, 27 Sep 2023 21:40:38 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 21/31] thermal: rcar: Convert to platform remove callback
 returning void
Message-ID: <ZRSFNk0k8Pm2VWVF@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
References: <20230927193736.2236447-1-u.kleine-koenig@pengutronix.de>
 <20230927193736.2236447-22-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qayWWwnlFWgAqzZ0"
Content-Disposition: inline
In-Reply-To: <20230927193736.2236447-22-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qayWWwnlFWgAqzZ0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 09:37:26PM +0200, Uwe Kleine-K=C3=B6nig wrote:
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


--qayWWwnlFWgAqzZ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmUUhTYACgkQFA3kzBSg
KbapXxAArH+6U219Ws+KXwwPPtXac0IwSmJF/fk4DaPh6IYjOfIHurWQ9+Q82UOn
NbtM7S4hleJHpMNU0/WDBCzhKJxL7QuS9nwXMuOUd+FiXqhoJhukLhBsDbSHYtFn
W108wv3TiBb7gBzzscYpups9Dj8P6DJNOANcj3415owkyfK7fnGNwABCy0AxkzMa
pQ6lGzh/zMB10ni1D2IzS+ZFPEqX6VTMXGUlp3V+3RjGmXCMf067zezvVhOJbUQM
1eBJVdWEZ2EP4P9wpe3GSX3mKv1tMm8UyO98XXfz/WIvzSCu3bBHFnT3jX2l0zAF
W4FH/Rb6rTl73/AMhCDn11DttPtxvbfLpXDy+JPii8VyXKdhN++UsdNynvBpdUYz
M6T1jpxWuD8PVic8IeHuXb35+zOpRFgRqTatd8gOH1uzEqDq3QQlIbqpSdfce8ir
/ICen6EWe6mfY/2R+jPv/wTSFfz5S1NmSoqU0lWuTWglm5NtFJpQo2TCRd5qXnqH
9yLkDQZerpa9EwowwB2IRiiwF4PWhLtrTNZzoG9qD3tJ6pFcIozLELs783o82OCL
SqOmNl/yW6vduHwmna2Ik80Z+qNAQolZtZivahDopjLsyRuomIDjjJP+enkx8HJb
3nWsyRd7E9aS/p6F2AAktUTWUI65IMJjE9pYlTWUoBKTIOvJAGE=
=+ieM
-----END PGP SIGNATURE-----

--qayWWwnlFWgAqzZ0--
