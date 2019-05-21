Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE70B25465
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 17:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfEUPrJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 11:47:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:42456 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728212AbfEUPrI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 May 2019 11:47:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B497EAE1F;
        Tue, 21 May 2019 15:47:05 +0000 (UTC)
Message-ID: <a142b72b828a798610d885d81189dd21b1870d78.camel@suse.de>
Subject: Re: [RFC v2 3/5] clk: bcm2835: use firmware interface to update pllb
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     linux-pm@vger.kernel.org, sboyd@kernel.org,
        viresh.kumar@linaro.org, mturquette@baylibre.com,
        ptesarik@suse.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        mbrugger@suse.de, linux-rpi-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ssuloev@orpaltech.com
Date:   Tue, 21 May 2019 17:47:03 +0200
In-Reply-To: <6383b357-3f7e-f031-f59f-61c598e44763@i2se.com>
References: <20190520104708.11980-1-nsaenzjulienne@suse.de>
         <20190520104708.11980-4-nsaenzjulienne@suse.de>
         <ebc78880-418f-f507-021c-41295113e041@i2se.com>
         <6383b357-3f7e-f031-f59f-61c598e44763@i2se.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-zPUlS9r+c6dQNQzC21+7"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-zPUlS9r+c6dQNQzC21+7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan, thanks for your comments!

On Tue, 2019-05-21 at 14:40 +0200, Stefan Wahren wrote:
> Hi Nicolas,
>=20
> On 20.05.19 14:11, Stefan Wahren wrote:
> > Hi Nicolas,
> >=20
> > the following comments applies only in case Eric is fine with the whole
> > approach.
> >=20
> > On 20.05.19 12:47, Nicolas Saenz Julienne wrote:
> > > Raspberry Pi's firmware, which runs in a dedicated processor, keeps
> > maybe we should clarify that the firmware is running in the VPU
> > > track of the board's temperature and voltage. It's resposible for
> > > scaling the CPU frequency whenever it deems the device reached an uns=
afe
> > > state. On top of that the firmware provides an interface which allows
> > > Linux to to query the clock's state or change it's frequency.
> > I think this requires a separate update of the devicetree binding.
> > > Being the sole user of the bcm2835 clock driver, this integrates the
> > > firmware interface into the clock driver and adds a first user: the C=
PU
> > > pll, also known as 'pllb'.
> > Please verify that the kernel still works (and this clock driver probe)
> > under the following conditions:
> >=20
> > - CONFIG_RASPBERRYPI_FIRMWARE=3Dn
> > - CONFIG_RASPBERRYPI_FIRMWARE=3Dm
> > - older DTBs without patch #1
> i thought about this and the case this driver would return
> -EPROBE_DEFER. The clock driver is too essential for doing such a thing.
> So i think the best solution would be to move these changes into a
> separate driver which should be register by the clock driver (similiar
> to vchiq). This also avoid the need of a new device tree binding.

I understand your concerns.

Wouldn't you prefer registering the device trough the device tree? I'd go w=
ith
the same approach as the firmware touchscreen driver, which is registered a=
fter
the firmware's probe trough dt's 'simple-bus'. That said, it's not a strong=
ly
held opinion, I'm happy with whatever solution as long as it works.

I get from your comments that you'd like the register based version of 'pll=
b'
and 'pllb_arm' to be loaded if for some reason the firmware isn't available=
. Is
that right? The main problem I see with this is the duplication of 'pllb' a=
nd
'pllb_arm'. Both drivers will create the same clock device through differen=
t
interfaces. Any suggestions on how to deal with that? If not I can simply
remove 'pllb' and 'pllb_arm' from clk-bcm2835.c.

Regards,
Nicolas


--=-zPUlS9r+c6dQNQzC21+7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlzkHXcACgkQlfZmHno8
x/58Pwf+J/igXfZ06sc7Gr74B5NqVdWqbVe+23xD1sjLpwUKTfWtUJAnbRuk8LOt
+XgjgwGqFMQHMRLpibxSSqUZrXT+TNh1SiicBzJ9KWNbz42xRcvek4A8sgBDTeUs
l6EVVtCNw+g8nPnT95arGKZ3xEIVAGdsg8tASLoyqbcNOJNb8r2QoXmsdK5oGQ/C
TsgPRiwPvc9TvvqDSkojXxMgEfxfh8pNcYTQ8KFs/HKFOrM+C7hny7s3q02r/xhA
Clhqd5Ur2BlhxvgOflW5i9eMeugVL1+g7pZUplzddVC1JA4U3KMD+RVZxXKhzg2S
srJIknJIKqm1VdajX7OLqqjUae1Dkw==
=kanr
-----END PGP SIGNATURE-----

--=-zPUlS9r+c6dQNQzC21+7--

