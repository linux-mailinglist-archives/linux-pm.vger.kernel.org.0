Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C61F524E08
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 13:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfEULjf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 07:39:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:37156 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726692AbfEULjf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 May 2019 07:39:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F1FFEADFA;
        Tue, 21 May 2019 11:39:33 +0000 (UTC)
Message-ID: <46004f242c2618a185445630580116c772455613.camel@suse.de>
Subject: Re: [RFC v2 3/5] clk: bcm2835: use firmware interface to update pllb
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Oliver Neukum <oneukum@suse.com>, stefan.wahren@i2se.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 21 May 2019 13:39:31 +0200
In-Reply-To: <1558356237.12672.3.camel@suse.com>
References: <20190520104708.11980-1-nsaenzjulienne@suse.de>
         <20190520104708.11980-4-nsaenzjulienne@suse.de>
         <1558356237.12672.3.camel@suse.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-cEa8KPU0g/Abd6RRg7/R"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-cEa8KPU0g/Abd6RRg7/R
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oliver, thanks for the review.

On Mon, 2019-05-20 at 14:43 +0200, Oliver Neukum wrote:
> On Mo, 2019-05-20 at 12:47 +0200, Nicolas Saenz Julienne wrote:
> > + * For more information on the firmware interface check:
> > + * https://github.com/raspberrypi/firmware/wiki/Mailbox-property-inter=
face
> > + */
> > +struct bcm2835_firmware_prop {
> > +       u32 id;
> > +       u32 val;
> > +       u32 disable_turbo;
> > +} __packed;
>=20
> Hi,
>=20
> technically we are not in arch and those fields have a defined
> endianness.
>=20

Well I set it as packed since it's 'sent' through a memory mapped firmware
interface. Hence the need for the structure format to be fixed. So I guesse=
d
we're safer with it, as I'm not 100% sure what the different compilers are
going to do with it (although it's very likely it'll stay the same). BTW th=
is
will be built both for arm & arm64.

Regards,
Nicolas


--=-cEa8KPU0g/Abd6RRg7/R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlzj43MACgkQlfZmHno8
x/4swQf/ZO31nuk1cd9h0edi7kTrZyY6O60vgTBA1GZt/PM8nP82e0m7LYXaDdY2
UIDyPklgdDR2Lhy0rvroVAGIL8tFgkTRTJ6zbUxUcItWSawQraXQNIcQlpDupxpd
WCy25NhYQhAuC3sn7djLogWr4ECLJMQcOHHNhh+rUr9Li0Mp5aRP/+QV1vh3sdN4
5AG5GMwl33WdNBjS52R8+XpqvpRDQjIz30eu2o2D3qdNZx4Q8yH15Rn8V2B0ggmV
DHZp731xIkZv68U3NXFRmyiwFelo26lSt4bGON4G2HBTXbsw7wqQ42euR/k0vmAo
qKqRuMJidrvdLD5ABg3jPne3CI3Xpg==
=Eo7y
-----END PGP SIGNATURE-----

--=-cEa8KPU0g/Abd6RRg7/R--

