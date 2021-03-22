Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6A4344663
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 15:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhCVN76 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 09:59:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230501AbhCVN70 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Mar 2021 09:59:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A02F61931;
        Mon, 22 Mar 2021 13:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616421565;
        bh=6uNGZYiD7TptJN9tSXE/bFTNOQAIFTxSCqtDwCYJemM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N+IE9qtbr+8FlphNLpfm5zQ33ol3vtZB83BpNmoToW2PlftLptO+K0aM9HEkldptQ
         G9n0InbUkoCU37kiTQXoPYc+OdiPCFfzSS+bHINadxmW7h3WVr5zbWQP+f12c42Wr3
         bgP3F5le9bqMR9OVZp/LdE2ksdSWIP+imxrO/vfPX5XYW83a5jD03lQ3LGr3zPZ0wR
         0VKOuSnSSadvm1UikL5TbojH2QGLd0wrrHXDsIUffIp9zX7LdNimLHfIeLQyqr9NYC
         Lu83CCJ5BfHgK5MCfbB4K4jNZs14+BP3wH8NiVP7srDqbpk/d/XQecjlPzWagHYWbH
         iptWTKMmr5Ggw==
Received: by earth.universe (Postfix, from userid 1000)
        id 6897A3C0C96; Mon, 22 Mar 2021 14:59:23 +0100 (CET)
Date:   Mon, 22 Mar 2021 14:59:23 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     robh+dt@kernel.org, pali@kernel.org, krzk@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com
Subject: Re: [PATCH V7 0/2] power: supply: bq27xxx: Add support for BQ78Z100
Message-ID: <20210322135923.mwva57vzokpu4wee@earth.universe>
References: <20210319110236.4353-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7rts4mwuk3ytnhn2"
Content-Disposition: inline
In-Reply-To: <20210319110236.4353-1-Qing-wu.Li@leica-geosystems.com.cn>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--7rts4mwuk3ytnhn2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 19, 2021 at 11:02:34AM +0000, LI Qingwu wrote:
> Changes in V7:
>=20
> Add    POWER_SUPPLY_CHARGE_NOW
> Remove POWER_SUPPLY_PROP_ENERGY_NOW
> Refresh result of dump uevent
>=20
>=20
> LI Qingwu (2):
>   dt-bindings: power: bq27xxx: add bq78z100
>   power: supply: bq27xxx: Add support for BQ78Z100
>=20
>  .../bindings/power/supply/bq27xxx.yaml        |  1 +
>  drivers/power/supply/bq27xxx_battery.c        | 44 +++++++++++++++++++
>  drivers/power/supply/bq27xxx_battery_i2c.c    |  2 +
>  include/linux/power/bq27xxx_battery.h         |  1 +
>  4 files changed, 48 insertions(+)

Thanks, queued.

-- Sebastian

--7rts4mwuk3ytnhn2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBYorsACgkQ2O7X88g7
+ppUxhAApT+tGZZdr1XjomjDjh+1wuDJlUhB8l4OTAVmdyVpn2qe6VKKiP4USmVS
B5now5XQEpRPZPRN/Ya0TglNQSam/7xYQndzysZ/oFP6YMA1H6sdbSWABw7U4peh
bjnYGCHTZY5VpsERMfqftv8GVWHPLo61Hvm2Tpgste0VmOgRqg3DyuzIT65dzynd
JX+yxy11DfKvbN+WI6VsOcXRo8lHkW52/JsgC08qOVHdXoGcJfFILxeOhhYrwRjY
3oGbfz8tof0tbBMhN0F4W0F1J/qdwu1x5UJyA4oiGXVApkwzWQ3LI/v9WnMehV3a
1y0z2N60FemGHNZfEJjyJ/XtX07BTIU/rnAsNaUK73FORL7HiCvIBhTMAQV70Wyj
+n1VIlNW9FT0XeTm/Grh1e6onP4FFOjKLA6vim4QKI5ARxOEvdAm+W6dyWFX1akf
2SkCoYw73esglbznPPCJpWxj25a8fqyqDJ4QzpPfQAGzReeNCytZAJUXgL8yabRW
oNNoO3P/230LGM2mKwoU6Vo9qUBE4by29ru6Z79y/ecXIWK43NaQ5PZeJow9dOlM
Xq+wn+aEZ8mQ62HR1iIoCuernyJqRyCe7ftQ2a3Pg/Suar3DfoZpw4JsdAtVCmAs
3MeSqt95sealtJNzf5xaNTKycW2wzzmhRmOs17ZhL9Dc/FZ4MOc=
=eEyc
-----END PGP SIGNATURE-----

--7rts4mwuk3ytnhn2--
