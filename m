Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7ECA42A841
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 17:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbhJLPbv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 11:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237199AbhJLPbu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Oct 2021 11:31:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885DDC061570;
        Tue, 12 Oct 2021 08:29:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id DC6221F43D1A
Received: by earth.universe (Postfix, from userid 1000)
        id 867523C0CA8; Tue, 12 Oct 2021 17:29:44 +0200 (CEST)
Date:   Tue, 12 Oct 2021 17:29:44 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        iskren.chernev@gmail.com
Subject: Re: [PATCH] power: supply: max17040: fix null-ptr-deref in
 max17040_probe()
Message-ID: <20211012152944.facevquz5nsfk6zc@earth.universe>
References: <20211008063150.822066-1-yangyingliang@huawei.com>
 <394b0984-50a6-af80-195b-033bf9624dea@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kngmmh6z6q435rks"
Content-Disposition: inline
In-Reply-To: <394b0984-50a6-af80-195b-033bf9624dea@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--kngmmh6z6q435rks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 09, 2021 at 07:18:30PM +0200, Krzysztof Kozlowski wrote:
> On 08/10/2021 08:31, Yang Yingliang wrote:
> > Add check the return value of devm_regmap_init_i2c(), otherwise
> > later access may cause null-ptr-deref as follows:
> >=20
> > KASAN: null-ptr-deref in range [0x0000000000000360-0x0000000000000367]
> > RIP: 0010:regmap_read+0x33/0x170
> > Call Trace:
> >   max17040_probe+0x61b/0xff0 [max17040_battery]
> >  ? write_comp_data+0x2a/0x90
> >  ? max17040_set_property+0x1d0/0x1d0 [max17040_battery]
> >  ? tracer_hardirqs_on+0x33/0x520
> >  ? __sanitizer_cov_trace_pc+0x1d/0x50
> >  ? _raw_spin_unlock_irqrestore+0x4b/0x60
> >  ? trace_hardirqs_on+0x63/0x2d0
> >  ? write_comp_data+0x2a/0x90
> >  ? __sanitizer_cov_trace_pc+0x1d/0x50
> >  ? max17040_set_property+0x1d0/0x1d0 [max17040_battery]
> >  i2c_device_probe+0xa31/0xbe0
> >=20
> > Fixes: 6455a8a84bdf ("power: supply: max17040: Use regmap i2c")
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> >  drivers/power/supply/max17040_battery.c | 2 ++
> >  1 file changed, 2 insertions(+)
>=20
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Thanks, queued.

-- Sebastian

--kngmmh6z6q435rks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFlqeQACgkQ2O7X88g7
+prlEw//WPn9+8y3sCuv9/yIVXBi63dF/jtvF1FzXbXSRtPVS+0eHWgSZevQhYRM
yAeekAWm9P0i4BVAT+MLpT7dXm3SNuydlCH4f+uV52xjBzCpb6hLZyjdl/2ZbELl
yUdFzNtU+otwZdA5n7v1T4kZPBSqurdRQlRWY6wsFjh25SZeOs97lLhgmZqR0Rhr
VOZR7yA/N98AUrCL+idl8DOKyoCC06QrDOb3ZBOqSEw9uurWTxCpMKE7j8us3N88
XP+84Fp2HncHH5qiqqRT/lmRlFnaSQ1WXHElohXqU7DrRSgqK+u0SJ25IznujbIr
j3kWFZHnSZEUsmO/4B46iqF5TjRS9+GTsTe92Vfa/b2K2hvTBsAvRX3luOImbl9j
DLLwUpoOdObHGNgIqZOo79X9xenDiv3j+KfRljfHFGSrkHg5O581BR8as9uvavmD
+46h0iMjar4BfgSC8xSyOhYceddC93r3Gppt3MUhdh/jGDsql22yCKG4pT/Yt8bA
KHVFZ2yL2zcjEQag/aGTVlBxxw+VhTZoElbz87mdleNKfz3MeMyGVR5CIM/f1Jpf
lKnQ/hekgVN9fg2t46nArKhXpNkabuHKKB4xDqdSXsy8wCf3Sa7nUzm3ZFREWAPa
jLsakY+8hsyZ1Py/7D1zjUUbvwtAMP9ivg1wzFrtijPcSgNjAbo=
=6soH
-----END PGP SIGNATURE-----

--kngmmh6z6q435rks--
