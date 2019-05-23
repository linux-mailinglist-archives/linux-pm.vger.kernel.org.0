Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD1927874
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2019 10:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfEWIvM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 May 2019 04:51:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:55230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbfEWIvM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 May 2019 04:51:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B42A7ADD8;
        Thu, 23 May 2019 08:51:09 +0000 (UTC)
Message-ID: <c756c54d5e924d61b8ec6eccecf9bfdce7c2b543.camel@suse.de>
Subject: Re: [RFC v2 3/5] clk: bcm2835: use firmware interface to update pllb
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     linux-arm-kernel@lists.infradead.org, ptesarik@suse.com,
        sboyd@kernel.org, viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, mbrugger@suse.de, ssuloev@orpaltech.com
Date:   Thu, 23 May 2019 10:51:07 +0200
In-Reply-To: <1599901940.259900.1558475026379@email.ionos.de>
References: <20190520104708.11980-1-nsaenzjulienne@suse.de>
         <20190520104708.11980-4-nsaenzjulienne@suse.de>
         <ebc78880-418f-f507-021c-41295113e041@i2se.com>
         <6383b357-3f7e-f031-f59f-61c598e44763@i2se.com>
         <a142b72b828a798610d885d81189dd21b1870d78.camel@suse.de>
         <1599901940.259900.1558475026379@email.ionos.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-rttIxA1wzU/XwAkxrIx0"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-rttIxA1wzU/XwAkxrIx0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-05-21 at 23:43 +0200, Stefan Wahren wrote:
> > Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 21. Mai 2019 um =
17:47
> > geschrieben:
> >=20
> >=20
> > Hi Stefan, thanks for your comments!
> >=20
> > On Tue, 2019-05-21 at 14:40 +0200, Stefan Wahren wrote:
> > > Hi Nicolas,
> > >=20
> > > On 20.05.19 14:11, Stefan Wahren wrote:
> > > > Hi Nicolas,
> > > >=20
> > > > the following comments applies only in case Eric is fine with the w=
hole
> > > > approach.
> > > >=20
> > > > On 20.05.19 12:47, Nicolas Saenz Julienne wrote:
> > > > > Raspberry Pi's firmware, which runs in a dedicated processor, kee=
ps
> > > > maybe we should clarify that the firmware is running in the VPU
> > > > > track of the board's temperature and voltage. It's resposible for
> > > > > scaling the CPU frequency whenever it deems the device reached an
> > > > > unsafe
> > > > > state. On top of that the firmware provides an interface which al=
lows
> > > > > Linux to to query the clock's state or change it's frequency.
> > > > I think this requires a separate update of the devicetree binding.
> > > > > Being the sole user of the bcm2835 clock driver, this integrates =
the
> > > > > firmware interface into the clock driver and adds a first user: t=
he
> > > > > CPU
> > > > > pll, also known as 'pllb'.
> > > > Please verify that the kernel still works (and this clock driver pr=
obe)
> > > > under the following conditions:
> > > >=20
> > > > - CONFIG_RASPBERRYPI_FIRMWARE=3Dn
> > > > - CONFIG_RASPBERRYPI_FIRMWARE=3Dm
> > > > - older DTBs without patch #1
> > > i thought about this and the case this driver would return
> > > -EPROBE_DEFER. The clock driver is too essential for doing such a thi=
ng.
> > > So i think the best solution would be to move these changes into a
> > > separate driver which should be register by the clock driver (similia=
r
> > > to vchiq). This also avoid the need of a new device tree binding.
> >=20
> > I understand your concerns.
> >=20
> > Wouldn't you prefer registering the device trough the device tree? I'd =
go
> > with
> > the same approach as the firmware touchscreen driver, which is register=
ed
> > after
> > the firmware's probe trough dt's 'simple-bus'. That said, it's not a
> > strongly
> > held opinion, I'm happy with whatever solution as long as it works.
>=20
> A devicetree binding always introduce some kind of inflexibility. In case
> someone finds a better solution later things can get really messy. A rece=
nt
> example is the clock handling for i2c-bcm2835.

Fair enough.

> > I get from your comments that you'd like the register based version of
> > 'pllb'
> > and 'pllb_arm' to be loaded if for some reason the firmware isn't avail=
able.
> > Is
> > that right?=20
>=20
> This wasn't my intention. I would prefer a simple approch here (no handov=
er).=20
>=20
> > The main problem I see with this is the duplication of 'pllb' and
> > 'pllb_arm'. Both drivers will create the same clock device through diff=
erent
> > interfaces. Any suggestions on how to deal with that? If not I can simp=
ly
> > remove 'pllb' and 'pllb_arm' from clk-bcm2835.c.
>=20
> Yes. So even if this driver is disabled, there shouldn't be a regression.=
 Or
> did i miss something?

No, there shoudn't be any regressions as these clocks are not being used at=
 the
moment.

I'll send a follow-up series soon :)

Regrads,
Nicolas


--=-rttIxA1wzU/XwAkxrIx0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlzmXvsACgkQlfZmHno8
x/5grgf8DaKHj4n6xgx7Eziw8ZvWeoGXlEqp0jORn3i0LMRCmP3NfeQjeI6JKcqk
cr+LKsKAOdKqi+LSK5E97AD+dhifsZBkQWdXiiWmlqTALBoRx9jug+Bz5hcXQWSP
GEc7b3ptWKWhdHCkNYDPUMs/2QECyhvdzS64cqzxyWVitzkue3oucEuHBB0zKEVS
d4O3HJXxgFhUE0hyBEmlaPm94mBq9wIywm01Ifj2Lmzb/gXrM8mYfyZoxW9jM7tl
2bXiN04WcM6kSq+J4t+3v+baNCP6YlHDnDU7scJ2grPkydirg+E5O87YrKJ0RGys
okD9UnL1HYEPsLM94xjqSw+H5f2sgQ==
=kYhp
-----END PGP SIGNATURE-----

--=-rttIxA1wzU/XwAkxrIx0--

