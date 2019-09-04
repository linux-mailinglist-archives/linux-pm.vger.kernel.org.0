Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36728A8DA8
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 21:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbfIDRZR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 13:25:17 -0400
Received: from sauhun.de ([88.99.104.3]:44264 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfIDRZR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Sep 2019 13:25:17 -0400
Received: from localhost (p54B337F1.dip0.t-ipconnect.de [84.179.55.241])
        by pokefinder.org (Postfix) with ESMTPSA id E42F02C08C3;
        Wed,  4 Sep 2019 19:25:14 +0200 (CEST)
Date:   Wed, 4 Sep 2019 19:25:14 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     miquel.raynal@bootlin.com, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, eric@anholt.net, wahrenst@gmx.net,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        mmayer@broadcom.com, computersforpeace@gmail.com,
        gregory.0xf0@gmail.com, matthias.bgg@gmail.com, agross@kernel.org,
        heiko@sntech.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, marc.w.gonzalez@free.fr, mans@mansr.com,
        talel@amazon.com, jun.nie@linaro.org, shawnguo@kernel.org,
        phil@raspberrypi.org, gregkh@linuxfoundation.org,
        david.hernandezsanchez@st.com, horms+renesas@verge.net.au,
        wsa+renesas@sang-engineering.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH -next 15/15] thermal: rcar: use
 devm_platform_ioremap_resource() to simplify code
Message-ID: <20190904172514.GA2602@kunai>
References: <20190904122939.23780-1-yuehaibing@huawei.com>
 <20190904122939.23780-16-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20190904122939.23780-16-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2019 at 08:29:39PM +0800, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

I think for such straightforward (and manifold) conversions, one patch
per subsystem is better than one patch per driver. But this is not my
subsystem, so I'll leave it to the thermal maintainers.


--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1v83EACgkQFA3kzBSg
KbZOUg/+Jw+mcZ79x8rHt2nPfBEtW1lYrickXXODhze40rPG/rARNtQxdyBIRKOj
cl3g5q/PL2U0k4nrUuD3osCpUNceFye3A7o5eE81j8hSOBvwADNtAIPaIXenudHD
P8krbODpUIy3ifIf24cUnCMr6teo0CduolmrCpDlmd1LWJmRpbdY+sejDVi8qAzs
xJDN67R6O8lEDJSS0o63xXu4+ZSizqcfVQqlWdkTxc3wqHhdUXFLeCWH5Ow1RsbP
ArXyH7xGG9xQxkiKavZSxYciob3PqcvRdfDv4dNRgNpJFir+mxbJVpQ2IyKr/hyn
jYzzcz9sd02cXsxAOURY1OS7AhPUiRl5XZIhWR+0VRXwJhBTkpHh/Ro4RRgzMHCC
UnRZgonQvO50HpmC3IHKPjq2rvKYYAYF2kr+rTjAiXsT2ZgECU5nQRypkMPy3CX2
YdP9JnaDd7OpDw3+tvPRmbEpAkjcXK5QQp4vHnqaTrnaqyxbMVA6uRt68uSbNHIY
gkTny6PNBTAr/0scsb7xo481yPA0MOCeShSAj6Dvk0pagXrfE4AgWf1vLPbUieUZ
PrZ+0B6jIYMKswq8FVvwSvn+Jrk/RFvFOLFpiuCnWZx0kDz8BDVrkQrwz5NsNm7D
NNOQUh/6TBD6/1TLapgeH4dtXhje3qlv8OzuEYhnkwS4UX3HvAI=
=XQ0z
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
