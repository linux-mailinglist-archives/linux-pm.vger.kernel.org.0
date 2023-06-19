Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7613B735F57
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jun 2023 23:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjFSVq1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Jun 2023 17:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjFSVq1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jun 2023 17:46:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342BDE65
        for <linux-pm@vger.kernel.org>; Mon, 19 Jun 2023 14:46:26 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EA4A76606F13;
        Mon, 19 Jun 2023 22:46:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687211185;
        bh=EH358iZphtSlp9ur9QNxUTLpEV9aQktzyAyq7OSfP4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MrnR303njynnY+BgdjEOQwRAfEusu+XnbZuBBobp7Q7bAacbC0SXwJsxS5bFhnzyz
         xyZ4viNxB5Poc2n1JtKY8VPmGn0y01808NwTA4z4N8vfrVADUUuth5t71eveEIQjjU
         uwP0TMHpXGdxTzOh0e02h+yYXMBQc1ZE4PudmVi5tsS2tfPj/Z7v0sdjpB9dUFgELF
         meiHCG6RoQVGYmIVpjteg6m5HrIE7u9t8PCkIAFFWuCNiYbEujWZJKSlT/dHrJCtBn
         sL3lugEe5pcYVF4k1iZiyIH1nU0VtYPG7G9pR85rHmhIUkyTiz4RHhLDXFxhXh8+eX
         rit38ThRKB0Zw==
Received: by mercury (Postfix, from userid 1000)
        id 7CE6210614DE; Mon, 19 Jun 2023 23:46:22 +0200 (CEST)
Date:   Mon, 19 Jun 2023 23:46:22 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 1/2] power: reset: at91-reset: change the power on
 reason prototype
Message-ID: <20230619214622.j4x2r72wq7trjhdn@mercury.elektranox.org>
References: <20230616135252.2787679-1-miquel.raynal@bootlin.com>
 <20230616135252.2787679-2-miquel.raynal@bootlin.com>
 <9cb6cebf-80ff-7ca1-6acf-41f58fd831f8@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iovwkiz777kgzmaw"
Content-Disposition: inline
In-Reply-To: <9cb6cebf-80ff-7ca1-6acf-41f58fd831f8@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--iovwkiz777kgzmaw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 19, 2023 at 10:10:05AM +0200, Nicolas Ferre wrote:
> On 16/06/2023 at 15:52, Miquel Raynal wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > It is quite uncommon to use a driver helper with parameters like *pdev
> > and __iomem *base. It is much cleaner and close to today's standards to
> > provide the per-device driver structure and then access its
> > internals. Let's do this with the helper which returns the power on
> > reason. While we change the parameters, we can as well rename the
> > function from at91_reset_status() to at91_reset_reason() to be more
> > accurate with what the helper actually does, and finally because we don=
't
> > really need the pdev argument in this helper besides for printing the
> > reset reason, we can move the dev_info() call into the probe.
> >=20
> > All these modifications prepare the introduction of a sysfs entry to
> > access this information. This way the diff will be much smaller. Thus,
> > there is no intended functional change.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>=20
> Thanks Miquel:
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, queued.

-- Sebastian

>=20
> Best regards,
>   Nicolas
>=20
> > ---
> >   drivers/power/reset/at91-reset.c | 9 ++++-----
> >   1 file changed, 4 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at9=
1-reset.c
> > index 741e44a017c3..d6884841a6dc 100644
> > --- a/drivers/power/reset/at91-reset.c
> > +++ b/drivers/power/reset/at91-reset.c
> > @@ -149,11 +149,10 @@ static int at91_reset(struct notifier_block *this=
, unsigned long mode,
> >          return NOTIFY_DONE;
> >   }
> >=20
> > -static void __init at91_reset_status(struct platform_device *pdev,
> > -                                    void __iomem *base)
> > +static const char * __init at91_reset_reason(struct at91_reset *reset)
> >   {
> > +       u32 reg =3D readl(reset->rstc_base + AT91_RSTC_SR);
> >          const char *reason;
> > -       u32 reg =3D readl(base + AT91_RSTC_SR);
> >=20
> >          switch ((reg & AT91_RSTC_RSTTYP) >> 8) {
> >          case RESET_TYPE_GENERAL:
> > @@ -185,7 +184,7 @@ static void __init at91_reset_status(struct platfor=
m_device *pdev,
> >                  break;
> >          }
> >=20
> > -       dev_info(&pdev->dev, "Starting after %s\n", reason);
> > +       return reason;
> >   }
> >=20
> >   static const struct of_device_id at91_ramc_of_match[] =3D {
> > @@ -392,7 +391,7 @@ static int __init at91_reset_probe(struct platform_=
device *pdev)
> >          if (ret)
> >                  goto disable_clk;
> >=20
> > -       at91_reset_status(pdev, reset->rstc_base);
> > +       dev_info(&pdev->dev, "Starting after %s\n", at91_reset_reason(r=
eset));
> >=20
> >          return 0;
> >=20
> > --
> > 2.34.1
> >=20
>=20
> --=20
> Nicolas Ferre
>=20

--iovwkiz777kgzmaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSQzK4ACgkQ2O7X88g7
+poMMA//dbaMCH4eOD+0ul9Z83n8jThM/wVFpj8cuY3RRevln5eFO6G8Kz1BfCkN
3HVx0+gMq7Xpfj+crMaPSFfIpSEj+p4Gf+rWjVKGnSocQdaPCvCPjUhlRNd1iNP9
o1BdvzBgQxZhJBidKNll9h7FjF4hTWNQLDY9ZNk0UIK/Uad3h2y1hk1WXp4xCLGD
bzEH05gWHQVPTuWTsgF2zjZd8wovxrT1yYG4CwsfxpRUbbzx23gr9M0A2/LouH4/
YTtLzOFwnh8u1g+CaM4VF9jq7RjWkACdY1KKz5K8/EaTNXXfRcnLSWcwKXV6nHN4
gv+V1Jr6ejyWi3BCAIfnNGozH17FtY5uh7Yf7zRJ9wMdF+diy3Kuls/1WJd2NdCH
vEnvZpj0hX4Ur+6tCaJTJL01YxtfLIQSaMekrbhdkg+cmSfW4P7oTyXmFdz7DnbD
ce3RiUVsVY3MoPujFYS/+AN+TxRGgTgzdwDl/Uz0YrWnKtKmg6LWk1cOIN8aC7/2
X/idmPcweGZCNPK/sj0XPmFihpiUPsydwGrDezGadtpK6s7643r7R3fj+JMdrZ2l
qim7ukLV69MK0umW3PfN/Dq2cSt/xmZhlzWkhB5XPnK+Vp6x/cL/9DbKKHk6glEY
Rz3jYUZqMPEoqKSkLrKDOZU+BMxkfy1zSqvOBD4Ri0a8nNJiRK0=
=7G9Q
-----END PGP SIGNATURE-----

--iovwkiz777kgzmaw--
