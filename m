Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6B51BD0B9
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 01:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgD1Xtv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Apr 2020 19:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726488AbgD1Xtu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2020 19:49:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3587FC03C1AC;
        Tue, 28 Apr 2020 16:49:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id CCCB9261181
Received: by earth.universe (Postfix, from userid 1000)
        id 74DB03C08C6; Wed, 29 Apr 2020 01:49:44 +0200 (CEST)
Date:   Wed, 29 Apr 2020 01:49:44 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Tang Bin <tangbin@cmss.chinamobile.com>, wens@csie.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] power: supply: axp288_charger: Omit superfluous error
 message
Message-ID: <20200428234944.gldm3dbbvia6fq4t@earth.universe>
References: <20200415042727.13496-1-tangbin@cmss.chinamobile.com>
 <8f9ae92b-9aab-34a2-dc15-a9c3514c7ca8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sv55zhm2thjvfpip"
Content-Disposition: inline
In-Reply-To: <8f9ae92b-9aab-34a2-dc15-a9c3514c7ca8@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--sv55zhm2thjvfpip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 15, 2020 at 10:07:03AM +0200, Hans de Goede wrote:
> Hi,
>=20
> On 4/15/20 6:27 AM, Tang Bin wrote:
> > In the axp288_charger_probe(), when get irq failed, the function
> > platform_get_irq() logs an error message, so remove redundant
> > message here.
> >=20
> > Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> > Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
>=20
> Thank you for this nice cleanup patch:
>=20
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks, queued.

-- Sebastian

--sv55zhm2thjvfpip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6owQ8ACgkQ2O7X88g7
+pqHnQ//c1+fITyIV6mNYcGsWEaaWzlG71Fd6aPmpfBcVKi9GlKI0rFJ+76WM5Yt
WlhTkjNjcJCJwXMTL/xSsK7Tmgjw7Ljh7AQgrumC1HaLhyTq0Wro1GXn1GZHrbSW
/b8yOnXo6FU+kSAI4eW3vwNgp2HD8vHv6I4T0KbRrotlIOYvtBo3a6lM7x6ah9/n
whAQ6sfHcQf1+51J/Uw33kw/uP7KPyuY5zgXFoSSMT/dmCjTQTAgoNDQe14xyiHH
2+AWKIZ4sifHgAEPAuic5j8OLOmKMuDCzV4vPxb6N/6Ek0bBBtRHJop/Xa7gAEN5
75cDtUl3AlmP2ObpI2h7tpECY4D5A5eI9aXIEEcx3bWPNhMKb6jpsQdJxBeCuqEj
O1tMQwvlmIZ7ryZ88+okSd/HSx0IAiE4fKRRBCRrTcV3VFAgzNOFJwmRTVE4Gaer
zEOKgxFyYxZ2dX78i7SQ8CfYwxTMu8wS8clF2grZH8tb47WbOnPRzvG59KNJ0uMI
VoTkGqG8JXKSCb8HBlQjt8+AYMWgM7W87tZrg0XXDzASaEGxCjSCzo/umAR7IFej
FIYHxWeW1tpRbNCcJSjycZns9iAb803wdCVP0Ne66QNUB73mgTJmFITAvSj2rlat
iW/uhwPcynUbXEGoA4dtGnm6eTS7F6A4JkRIZmQx3cbpUOJOZ1M=
=4SrH
-----END PGP SIGNATURE-----

--sv55zhm2thjvfpip--
