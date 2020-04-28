Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7104B1BCC40
	for <lists+linux-pm@lfdr.de>; Tue, 28 Apr 2020 21:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgD1TUI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 15:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729135AbgD1TUH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 15:20:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A290C03C1AB;
        Tue, 28 Apr 2020 12:20:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E79792A1F87
Received: by earth.universe (Postfix, from userid 1000)
        id 5F2173C08C6; Tue, 28 Apr 2020 21:20:03 +0200 (CEST)
Date:   Tue, 28 Apr 2020 21:20:03 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jason Yan <yanaijie@huawei.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: ab8500_fg: remove comparison to bool
Message-ID: <20200428192003.yhqfvezez2kntjwi@earth.universe>
References: <20200426094250.23995-1-yanaijie@huawei.com>
 <CACRpkdYwu3LnN9KGfbjhnJu75hmKBKgnSWnDCWmdnGWGGGYPTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ttdcwcb7uw2owqyr"
Content-Disposition: inline
In-Reply-To: <CACRpkdYwu3LnN9KGfbjhnJu75hmKBKgnSWnDCWmdnGWGGGYPTw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ttdcwcb7uw2owqyr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 28, 2020 at 04:02:31PM +0200, Linus Walleij wrote:
> On Sun, Apr 26, 2020 at 11:43 AM Jason Yan <yanaijie@huawei.com> wrote:
>=20
> > Fix the following coccicheck warning:
> >
> > drivers/power/supply/ab8500_fg.c:2402:5-24: WARNING: Comparison to bool
> >
> > Signed-off-by: Jason Yan <yanaijie@huawei.com>
>=20
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, queued.

-- Sebastian

--ttdcwcb7uw2owqyr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6ogeMACgkQ2O7X88g7
+prREQ//Y/BVNO+E0LA3tnVd+n5Vf1Q1Th7uxH5p2Ui1B/Onv5qP7o/mr0ELvddb
1IM5T448L6MgJ0YSepWK3BCzKqun0w5YAa0QZG8TAEJeBrLvFl6zXFWsxgMNSiYZ
pIlYEg7UFlud7FiUt1V1gir+SI4qjG8RXL2A64Z4EQ6J4dpTPnOk4mX/zzgyR2h0
LQ9oCHoK+GNkyAo5jVJoVxAE/2l7kDHT0MQJAv4zS7xgxwz5/giQrn5jJTZadeFM
m/PalOmH1aJ2CQAjlYHr28sKPAIC+mz6i5e9cnYwK7bM7+f53I74xMMrA7YVaTsL
/Mc3k5oVa/DBNgKAdHrGZ4jv4R01aZhoUQcaKevPuiwQEBhqkOXVshoaE5sDiXpb
lkEcyG6Q8AJOC5e4Qm/eRv2oh7Xm7yzedAhQD39AKtFl5X7SeB17tWk914RJXIeS
T/DAm+B8ido7LJZ0myw/k0BwOU3H8mMOkWdmhjnnmbSP8FP4+mtlDZDuH7Y1NOHD
895rfdMVqNEEyhnD1PuWIKBPixZaxshHrC8cuR3pbL4Z926pHkTUR1ltzmtLuDGg
x7OJgfXHBTW7C7vn/YgSe5HdOBybOLXqABCLf9cOc/l04oShE7lVzyKJu6uXgaH7
z/oVfO8VF3uk7SL0JDjKNjujqkECLy77DA1M6QmYNtE2RN1/iPU=
=ghDH
-----END PGP SIGNATURE-----

--ttdcwcb7uw2owqyr--
