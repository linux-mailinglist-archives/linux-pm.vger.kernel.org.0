Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E01A43644E
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 21:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFETLN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 15:11:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:51156 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbfFETLN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 15:11:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9FC83AF0C;
        Wed,  5 Jun 2019 19:11:10 +0000 (UTC)
Message-ID: <6f40f43ed32c5c519761879245423f7c371e4ae6.camel@suse.de>
Subject: Re: [PATCH 0/4] cpufreq support for the Raspberry Pi
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <wahrenst@gmx.net>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     f.fainelli@gmail.com, ptesarik@suse.com, sboyd@kernel.org,
        viresh.kumar@linaro.org, mturquette@baylibre.com,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org, eric@anholt.net,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        mbrugger@suse.de, ssuloev@orpaltech.com
Date:   Wed, 05 Jun 2019 21:11:06 +0200
In-Reply-To: <1c9708c9-a3c9-8a8f-4693-8f29d3e60634@gmx.net>
References: <20190604173223.4229-1-nsaenzjulienne@suse.de>
         <2ece3f20-ef8c-c39e-941c-76635ddbe185@gmx.net>
         <1a86637dad1d2f33450950143a82016beb91bdb6.camel@suse.de>
         <1c9708c9-a3c9-8a8f-4693-8f29d3e60634@gmx.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-PJNAuTBnger31MKfSUoC"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-PJNAuTBnger31MKfSUoC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-06-05 at 13:34 +0200, Stefan Wahren wrote:
> Hi,
>=20
> Am 05.06.19 um 13:00 schrieb Nicolas Saenz Julienne:
> > Hi Stefan,
> > thanks for the review, I took note of your code comments.
> >=20
> > On Wed, 2019-06-05 at 11:46 +0200, Stefan Wahren wrote:
> > > Hi Nicolas,
> > >=20
> > > Am 04.06.19 um 19:32 schrieb Nicolas Saenz Julienne:
> > > > Hi all,
> > > > this series aims at adding cpufreq support to the Raspberry Pi fami=
ly of
> > > > boards.
> > > >=20
> > > > The previous revision can be found at:=20
> > > > https://lkml.org/lkml/2019/5/20/431
> > > >=20
> > > > The series first factors out 'pllb' from clk-bcm2385 and creates a =
new
> > > > clk driver that operates it over RPi's firmware interface[1]. We ar=
e
> > > > forced to do so as the firmware 'owns' the pll and we're not allowe=
d to
> > > > change through the register interface directly as we might race wit=
h the
> > > > over-temperature and under-voltage protections provided by the firm=
ware.
> > > it would be nice to preserve such design decision in the driver as a
> > > comment, because the cover letter usually get lost.
> > > > Next it creates a minimal cpufreq driver that populates the CPU's o=
pp
> > > > table, and registers cpufreq-dt. Which is needed as the firmware
> > > > controls the max and min frequencies available.
> > > I tested your series on top of Linux 5.2-rc1 with multi_v7_defconfig =
and
> > > manually enable this drivers. During boot with Raspbian rootfs i'm
> > > getting the following:
> > >=20
> > > [    1.177009] cpu cpu0: failed to get clock: -2
> > > [    1.183643] cpufreq-dt: probe of cpufreq-dt failed with error -2
> > This is surprising, who could be creating a platform_device for cpufreq=
-dt
> > apart from raspberrypi-cpufreq? Just to make things clear, you're using=
 the
> > device tree from v5.2-rc1 (as opposed to the Raspbian one)?
>=20
> sorry my fault, i thought it already has been replaced. The behavior in
> this unexpected case is fine, since it doesn't crash.
>=20
> I replaced the the DTB with the mainline one, but now i'm getting this:
>=20
> [    4.566068] cpufreq: cpufreq_online: CPU0: Running at unlisted freq:
> 600000 KHz
> [    4.580690] cpu cpu0: dev_pm_opp_set_rate: Invalid target frequency 0
> [    4.594391] cpufreq: __target_index: Failed to change cpu frequency: -=
22

For the record this fixes it:

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index aa51756fd4d6..edb71eefe9cf 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1293,7 +1293,7 @@ static int clk_core_determine_round_nolock(struct clk=
_core
*core,
        } else if (core->ops->round_rate) {
                rate =3D core->ops->round_rate(core->hw, req->rate,
                                             &req->best_parent_rate);
-               if (rate < 0)
+               if (IS_ERR_VALUE(rate))
                        return rate;

                req->rate =3D rate;

round_rate() returns a 'long' value, yet 'pllb' in rpi3b+ goes as high as
2.8GHz, which only fits in an 'unsigned long'. This explains why I didn't s=
ee
this issue with RPI2b.

I'll add the patch to the series.

Regards,
Nicolas


--=-PJNAuTBnger31MKfSUoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlz4E8oACgkQlfZmHno8
x/65VAf/fn1es6te2vdGehlcnMHV8inkQwAi0BEftzdL8s5w+Yv3WsJH3lwZM3sD
DPZNWwlL/U2nVcKb997HnAcZm6CkosH87jzzF8n41F2LlzJGAzVDOZyxcbTJlK5V
XtGsBvTkcqww24j6tKopUZ+9lWTSDTy2Jt3o/yxliP1oMFDrOVDQ0H20Qcprx32O
lgev+7L7raIhmw8Fzy4DLU0nLe8kqkxGOHdorK7cRELAhys0rCx4WEX5MjJGUHQe
TE9hQOG8bbGjvTtfE0MN837iw+S0D4XIyvjY5REPut2RTEcyf7uTea52DyXMeX5v
vAGHR2WLM77yT5igIMv746NEBYT2SA==
=2JhT
-----END PGP SIGNATURE-----

--=-PJNAuTBnger31MKfSUoC--

