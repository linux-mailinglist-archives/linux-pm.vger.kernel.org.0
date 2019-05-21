Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED7BD24EB9
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 14:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfEUMPO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 08:15:14 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:57554 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUMPN (ORCPT
        <rfc822;groupwise-linux-pm@vger.kernel.org:0:0>);
        Tue, 21 May 2019 08:15:13 -0400
Received: from ezekiel.suse.cz (prva10-snat226-2.provo.novell.com [137.65.226.36])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Tue, 21 May 2019 06:15:04 -0600
Date:   Tue, 21 May 2019 14:14:56 +0200
From:   Petr Tesarik <ptesarik@suse.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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
Subject: Re: [RFC v2 3/5] clk: bcm2835: use firmware interface to update
 pllb
Message-ID: <20190521141456.46f6d4a7@ezekiel.suse.cz>
In-Reply-To: <46004f242c2618a185445630580116c772455613.camel@suse.de>
References: <20190520104708.11980-1-nsaenzjulienne@suse.de>
        <20190520104708.11980-4-nsaenzjulienne@suse.de>
        <1558356237.12672.3.camel@suse.com>
        <46004f242c2618a185445630580116c772455613.camel@suse.de>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/v4zFxgx_udbNpFsK480f9ms"; protocol="application/pgp-signature"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--Sig_/v4zFxgx_udbNpFsK480f9ms
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 21 May 2019 13:39:31 +0200
Nicolas Saenz Julienne <nsaenzjulienne@suse.de> wrote:

> Hi Oliver, thanks for the review.
>=20
> On Mon, 2019-05-20 at 14:43 +0200, Oliver Neukum wrote:
> > On Mo, 2019-05-20 at 12:47 +0200, Nicolas Saenz Julienne wrote: =20
> > > + * For more information on the firmware interface check:
> > > + * https://github.com/raspberrypi/firmware/wiki/Mailbox-property-int=
erface
> > > + */
> > > +struct bcm2835_firmware_prop {
> > > +       u32 id;
> > > +       u32 val;
> > > +       u32 disable_turbo;
> > > +} __packed; =20
> >=20
> > Hi,
> >=20
> > technically we are not in arch and those fields have a defined
> > endianness.
> >  =20
>=20
> Well I set it as packed since it's 'sent' through a memory mapped firmware
> interface. Hence the need for the structure format to be fixed. So I gues=
sed
> we're safer with it, as I'm not 100% sure what the different compilers are
> going to do with it (although it's very likely it'll stay the same). BTW =
this
> will be built both for arm & arm64.

I believe that's not the point Oliver was trying to make. You should
use __le32 instead of u32.

That's because u32 means "host byte order" and this code is not located
under arch/, so host endianness is unknown, but the mailbox interface
requires little-endian.

It's nit-picking, and that's why Oliver writes 'technically'; there is
probably no way this firmware interface could be used on a big-endian
CPU...

Petr T

--Sig_/v4zFxgx_udbNpFsK480f9ms
Content-Type: application/pgp-signature
Content-Description: Digitální podpis OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHl2YIZkIo5VO2MxYqlA7ya4PR6cFAlzj68AACgkQqlA7ya4P
R6f62AgAz0n5U8DxFLjG8+/3CYeQR5ZyeBY4k4i59x0CtEHzdc/KpzHUMeMk4UY4
CX0BTMxH8rszNyr01dpGqYDlRUJTZg+WCs+V9N8ZWDafcI9+ZFoZPTOAZumw4o5g
q7Y4Gpip+ygMHVSrds+uFQkJtinN7eiyr16GR8TLsb55TjYwiaodn4iNRiR3o+Od
qhUwScebGj4vjjru+U0XyYUGUaL22vuKXx8j15aSEO+FB7qYCxs6QbhF33wLvP9T
V7BUmamRLwoNqL1YPgj9RSC73PHPQpWKSCvwi2HcK4eUdwC3GNtfLwId+0ocxqwg
pFEsVHZTqhV18UWpMD/Pnb5Z39zFRQ==
=z3QT
-----END PGP SIGNATURE-----

--Sig_/v4zFxgx_udbNpFsK480f9ms--
