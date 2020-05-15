Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E618C1D53ED
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 17:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgEOPON (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 11:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726188AbgEOPON (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 11:14:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B9CC061A0C;
        Fri, 15 May 2020 08:14:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id CBFDA2A3488
Received: by earth.universe (Postfix, from userid 1000)
        id C07A63C08C6; Fri, 15 May 2020 17:14:08 +0200 (CEST)
Date:   Fri, 15 May 2020 17:14:08 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Emil Velikov <emil.velikov@collabora.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv1 03/19] power: supply: core: add manufacture date
 properties
Message-ID: <20200515151408.vbj75fag6ya5g2bq@earth.universe>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
 <20200513185615.508236-4-sebastian.reichel@collabora.com>
 <20200515144732.GC2836808@arch-x1c3>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3xq2l5oxqmhxeqpo"
Content-Disposition: inline
In-Reply-To: <20200515144732.GC2836808@arch-x1c3>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3xq2l5oxqmhxeqpo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 15, 2020 at 03:47:32PM +0100, Emil Velikov wrote:
> On 2020/05/13, Sebastian Reichel wrote:
> > Some smart batteries store their manufacture date, which is
> > useful to identify the battery and/or to know about the cell
> > quality.
> >=20
> Have you considered exposing this as a single file? Say following
> the ISO8601 format - YYYY-MM-DD.

Yes. My initial implementation was exactly that. The thing is, that
I suspect some fuel gauge implementations may only expose the year
or just year + month. I chose 3 files, since receiving 'YYYY-MM'
instead of full ISO code might be more unexpected than not having
the DAY file available. But I don't have a strong opinion on this.

-- Sebastian

--3xq2l5oxqmhxeqpo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6+sbgACgkQ2O7X88g7
+prQgQ/8DObxqwSGq8FRackNMigPfBZos5u1g1+5PprsLQ9E7zb0ibMFybVRGQse
PJa82uqIwP4lYAyZx6EwFBeOFhI6i9A5sHEugiuarjRAJjXZuyW3YjObCw/UfC54
eUkVm6F4iy7r3NyucF+be398TDZEEwJ+fqIIOY/YagSurMpxR3Pdemy2mDAxykI9
ZJXIT5on3/L0X7E0Trdx1IyfeQQfvLjTtJaBV3J+WaIYViIb+pkMpHsSZD1SOLi+
qOLT31pXXp87D9xicCLU5ayWgdIxi93fGMEQnGHcfIbNjjD8ncGy2BBR/tbsU065
lqO7edflFoXocf35ZQCLzCXK+AfNkYw1GZw+URAnh5icGK41IHVPNe041YFrySCs
8qzl7f7/G+WUznezbxFYpqtRpNW2KfThnezhJsV+Istc1zhE6hCCliBVmXlcJjO/
Ts2FlER/OfePg99I7TRtnr/Ld49gX74S9balftKrrvc18e0U4+J1B8c9cqe0reWo
8OVpPvQ1b7HQ5/VzsmhJf0QpXp1vG+EHD8toIt5EwCtPfmr9lzHOIo63YdElsCvP
b1qRVHv9Sc/Rusfg4aE8Lqsor5SnMoE988Tj8lhFpJD5pucK91WxGzfyWtb6qtnp
QHx0gsVOQCZBQYSSudMEPNSqH9P0qSHTfwtKCnyNSKqo2s37zuU=
=D2js
-----END PGP SIGNATURE-----

--3xq2l5oxqmhxeqpo--
