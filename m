Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC40358369
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 14:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhDHMj2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 08:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDHMj1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 08:39:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5B3C061760;
        Thu,  8 Apr 2021 05:39:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id BE0721F45CCB
Received: by earth.universe (Postfix, from userid 1000)
        id 981E63C0C96; Thu,  8 Apr 2021 14:39:13 +0200 (CEST)
Date:   Thu, 8 Apr 2021 14:39:13 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH -next] power: supply: s3c_adc_battery: fix possible
 use-after-free in s3c_adc_bat_remove()
Message-ID: <20210408123913.f22o2k6qrjte5q2z@earth.universe>
References: <20210407091903.3268399-1-yangyingliang@huawei.com>
 <59bbbad2-a82b-e08d-5225-267fee168ed1@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4ov2bduo2d4jp6it"
Content-Disposition: inline
In-Reply-To: <59bbbad2-a82b-e08d-5225-267fee168ed1@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--4ov2bduo2d4jp6it
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 07, 2021 at 01:15:11PM +0200, Krzysztof Kozlowski wrote:
> On 07/04/2021 11:19, Yang Yingliang wrote:
> > This driver's remove path calls cancel_delayed_work(). However, that
> > function does not wait until the work function finishes. This means
> > that the callback function may still be running after the driver's
> > remove function has finished, which would result in a use-after-free.
> >=20
> > Fix by calling cancel_delayed_work_sync(), which ensures that
> > the work is properly cancelled, no longer running, and unable
> > to re-schedule itself.
> >=20
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> >  drivers/power/supply/s3c_adc_battery.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Thanks,

queued.

-- Sebastian

--4ov2bduo2d4jp6it
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBu+XEACgkQ2O7X88g7
+pooDQ//Z8jExWiRhnEDHZR4OgqQ/5ThXfA1xef1QUpBGf6WzMqx+xzQau27Jz6o
O6WzK0yvhtB8OAJgblUHO8jRLO7ECncyilyJ5RpYoYIM0U5FnKwrglCzUDef5GsQ
hp5XbtojYvU7rYPepl02VPgjyesDdbfAYjxVMZPLjwT69hxqwjPuFCGV9lCQN8/E
wg2IVNd2mUz0yxLuC9or6HbQ5RJK34g+RXE/iCHMVN/4T34PaJBHifE/qkIisZGp
VxEY030YtyGX/SQ941OezdnTkAi4YyKvC7idUkKwfrg2E87EoiF9Hw7HKB81gC3r
G/FsZZ0651lXyk28tje6kPEPvSjayorXGlbBkYsEYHC1JJg2Z27ZyxEM01Rbn6Ch
aWM6I8ZHXHtsOVwi9/Ti1xaTDSLI0joJzrrLpD0nA4JlefXWrXRGSe7tnH7fjFoy
xvVtLB2gYBF1X1NYDgIgno4euHdJ9wd9VjVh+LNO4g2ttoT1HeGRHuTTXGrvmm90
+wKAvoAogh3O/MsGylW4/1enmG8fuqix97T4b1E/syOSqHxWecY2dYVRLvKV6PCw
oeTMofNHpvi783idu7rgzL3QBhPp/oRodSo45gSjD/jQboMmUvTJRRYaXmfH0hL3
NaWhRjP9GyKbP96EicsMjPz3M0QLxIjMIYoz9jOwzp3whtLxX9M=
=XxXJ
-----END PGP SIGNATURE-----

--4ov2bduo2d4jp6it--
