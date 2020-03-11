Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48C47182501
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 23:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbgCKWef (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 18:34:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729518AbgCKWef (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 18:34:35 -0400
Received: from jupiter.universe (dyndsl-037-138-186-138.ewe-ip-backbone.de [37.138.186.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 823CA20739;
        Wed, 11 Mar 2020 22:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583966074;
        bh=V3fdJqhnTbq0PKKcHm1WX0xZLlXMSZene6185lindoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LP7MzjQ1yZ6da5+82P8kQ3YaYw88GNag09hRzJnOk5fOnXEWXsuftdbCh21I+cX9k
         Uqx2nFtmZFWxKVs+Q+l6k3uSGWy5OyvCHFNq+bm58pdJbVFlWP0d3x5YyQyWFwu2Wi
         w2yzs4T6GPxHqjAHQ9ZwuIAuJwavv9bzCKsdJ4K4=
Received: by jupiter.universe (Postfix, from userid 1000)
        id A8AD34800FC; Wed, 11 Mar 2020 23:34:32 +0100 (CET)
Date:   Wed, 11 Mar 2020 23:34:32 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Some optimization for SC27XX poweroff driver
Message-ID: <20200311223432.unrttre7gxr7gzwy@jupiter.universe>
References: <cover.1583740881.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vq7w36tqg7l5yuxi"
Content-Disposition: inline
In-Reply-To: <cover.1583740881.git.baolin.wang7@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vq7w36tqg7l5yuxi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 09, 2020 at 04:18:43PM +0800, Baolin Wang wrote:
> This patch set fixes external subsystems' power issue and allows
> the SC27XX poweroff driver building into a module.

Thanks, queued.

-- Sebastian

> Baolin Wang (2):
>   power: reset: sc27xx: Change to use cpu_down()
>   power: reset: sc27xx: Allow the SC27XX poweroff driver building into a
>     module
>=20
> Sherry Zong (1):
>   power: reset: sc27xx: Power off the external subsystems' connection
>=20
>  drivers/power/reset/Kconfig           |  2 +-
>  drivers/power/reset/sc27xx-poweroff.c | 21 +++++++++++++++++----
>  2 files changed, 18 insertions(+), 5 deletions(-)
>=20
> --=20
> 1.9.1
>=20

--vq7w36tqg7l5yuxi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5pZ3gACgkQ2O7X88g7
+pralRAAplhkbQhl3qd0QmEYch7Ri1uVlVBvCNHjx/x1x3vDaroA6O7niYiyfw7E
epdO0GyhqAckR33GbZ5BVB0S97/6qU9+2QK4+6K8TWMo9Fc0a+5VrRVRFIPFitq2
vuI+GCgpdQX5Mnfs+rg+SclND29+GFlKAh1sGqCcNc4ZqmgN0PBNo7raNCnGMt/R
uHB0kmcxPPuifpSqR+LVy8e1Gbyoemzo3VZIb19BGSYTN+E3qjYh+zWkaHbv5rlS
J/7xUQmTvw+C05M75awen8GquJsypLATI4DEXMpyRvGgPjC9+x/7HWIARXZvUbuV
LOq4ZhJXwOaa0LQvUSrje5Gw2RL6qu5HUYfFbx8W3YcAOTq3YEiOs5fPSEYhAvZp
ctsffJ0K990iEzCCQVub1H4QqpLAw2qCPdCSDl1QR/VMVkGOmH8+Vv5FrUHFBkkA
EjU1IyPTQGz/sJwD+pvb2C977yCO5VrXcmZT7hyLZlfXQPG2qJvlh88uNjBjvtm0
5HDbzr0ZQcgWvXkQlndEvwb88UYX3U/MLW3JuORfHm7WcMlVsOzy8nejtGxeHFTz
dUdIQBmoEc+a4txmWI4f/G98ZF5j04/4PXkxyl54hwn74TiMkyB3Q/3Le3qYPPyK
KAoIQ7npGc7RSRK+nmU8f5oMOL7D5PWDC7PejSmx+9lRsbkw6Bg=
=6NiS
-----END PGP SIGNATURE-----

--vq7w36tqg7l5yuxi--
