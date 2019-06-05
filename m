Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3058A35CCA
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 14:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfFEM1a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 08:27:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:40822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727273AbfFEM1a (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 08:27:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 279BDAD2A;
        Wed,  5 Jun 2019 12:27:28 +0000 (UTC)
Message-ID: <8d6eb920ebcaec2ede413439a7080ae030b7e44e.camel@suse.de>
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
Date:   Wed, 05 Jun 2019 14:27:26 +0200
In-Reply-To: <1c9708c9-a3c9-8a8f-4693-8f29d3e60634@gmx.net>
References: <20190604173223.4229-1-nsaenzjulienne@suse.de>
         <2ece3f20-ef8c-c39e-941c-76635ddbe185@gmx.net>
         <1a86637dad1d2f33450950143a82016beb91bdb6.camel@suse.de>
         <1c9708c9-a3c9-8a8f-4693-8f29d3e60634@gmx.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-8ce50Ee7YyHn+6OQ/pXB"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-8ce50Ee7YyHn+6OQ/pXB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

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

Ok, this looks more more like my fault, probably an overflow error somewher=
e. I
saw something similar while testing it on RPI2b. Which board & config was t=
his
run with? Could you confirm the clk-raspberrypi.c message verifying the max=
 and
min frequencies showed up and was correct.

Regards,
Nicolas


--=-8ce50Ee7YyHn+6OQ/pXB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlz3tS4ACgkQlfZmHno8
x/6IPwf5AW2cqDKMXXG6zjSDBbD14gmTvnpBPLctfKW+l06doG1g5uXw/mfkX/DI
jOpcLFRS0GJafFskDnkmvdl10tLmCRQtmSBWfEa/HoYndHNxmy+gjLWQHJY6oUJI
S/oigi4WK561pDhQ9Ey6ooq21zLypgRFpoYElG8YVudvKRP7j0I0S2RZXM18dixs
IQV5bmFY9PMmnwXrsbm+/SpRdsO1NLwk/bFAsEZrZE0lKBVWQdtvqcaSCAF5EvlK
gCoXRwGtQ1pWq9eLoPacapAWs5XMmfPs6hMk9T/8iFHe3XwwIweuJNS+5/AyEtnW
vNFS6cF5duw5115FBxCWc5GtcFF10g==
=GpHh
-----END PGP SIGNATURE-----

--=-8ce50Ee7YyHn+6OQ/pXB--

