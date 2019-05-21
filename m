Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 810FE24ED8
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 14:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfEUMS4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 08:18:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:46484 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726692AbfEUMS4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 May 2019 08:18:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 586D4ABD4;
        Tue, 21 May 2019 12:18:55 +0000 (UTC)
Message-ID: <b757047cc0151bee57749415a53989309a9fa590.camel@suse.de>
Subject: Re: [RFC v2 3/5] clk: bcm2835: use firmware interface to update pllb
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Petr Tesarik <ptesarik@suse.com>
Cc:     Oliver Neukum <oneukum@suse.com>, stefan.wahren@i2se.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>, mbrugger@suse.de,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 21 May 2019 14:18:53 +0200
In-Reply-To: <20190521141456.46f6d4a7@ezekiel.suse.cz>
References: <20190520104708.11980-1-nsaenzjulienne@suse.de>
         <20190520104708.11980-4-nsaenzjulienne@suse.de>
         <1558356237.12672.3.camel@suse.com>
         <46004f242c2618a185445630580116c772455613.camel@suse.de>
         <20190521141456.46f6d4a7@ezekiel.suse.cz>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Hgwp9Ctbw+KDH82tk7Jk"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-Hgwp9Ctbw+KDH82tk7Jk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-05-21 at 14:14 +0200, Petr Tesarik wrote:
> On Tue, 21 May 2019 13:39:31 +0200
> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> wrote:
>=20
> > Hi Oliver, thanks for the review.
> >=20
> > On Mon, 2019-05-20 at 14:43 +0200, Oliver Neukum wrote:
> > > On Mo, 2019-05-20 at 12:47 +0200, Nicolas Saenz Julienne wrote: =20
> > > > + * For more information on the firmware interface check:
> > > > + *=20
> > > > https://github.com/raspberrypi/firmware/wiki/Mailbox-property-inter=
face
> > > > + */
> > > > +struct bcm2835_firmware_prop {
> > > > +       u32 id;
> > > > +       u32 val;
> > > > +       u32 disable_turbo;
> > > > +} __packed; =20
> > >=20
> > > Hi,
> > >=20
> > > technically we are not in arch and those fields have a defined
> > > endianness.
> > >  =20
> >=20
> > Well I set it as packed since it's 'sent' through a memory mapped firmw=
are
> > interface. Hence the need for the structure format to be fixed. So I gu=
essed
> > we're safer with it, as I'm not 100% sure what the different compilers =
are
> > going to do with it (although it's very likely it'll stay the same). BT=
W
> > this
> > will be built both for arm & arm64.
>=20
> I believe that's not the point Oliver was trying to make. You should
> use __le32 instead of u32.
>=20
> That's because u32 means "host byte order" and this code is not located
> under arch/, so host endianness is unknown, but the mailbox interface
> requires little-endian.
>=20
> It's nit-picking, and that's why Oliver writes 'technically'; there is
> probably no way this firmware interface could be used on a big-endian
> CPU...

Understood, thanks for the clarification.

Regards,
Nicolas


--=-Hgwp9Ctbw+KDH82tk7Jk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlzj7K0ACgkQlfZmHno8
x/4XSgf/dX+SRWpz1Yfel/oXn5vJOOTYCsXlSCJYpWE0gv6LT/WuRPch0Zo7Z6Rz
veT2xjkMaccOr+FHdkDbFNjkqO/WjZzvwPtZmGs0T+mSqBbVua/PMVIryY8XvpNL
KzP/8x8P+Yq3Q9HtiuNf1uHiSKs8xe82uqNmdVLDenuqijJdSTEqKmJ+IqX+uK13
eNHSu8qIF1Z6hIveCrfI841fypd/VXaerf+oWxGnmV4YAPvqSx9mAqHZd1RPZUaK
qNOo/QE5KPrx2uqBmx/gNw3n0NHhgyU03SGaZnDuDDzvOlAHpPO2u3jBrqrXJJts
prXi/m6LkrKFPFK2IBXYEjzf7Gc52Q==
=krKa
-----END PGP SIGNATURE-----

--=-Hgwp9Ctbw+KDH82tk7Jk--

