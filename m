Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 012A93594D
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 11:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfFEJLQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 05:11:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:57580 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726502AbfFEJLQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 05:11:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 627BEAE16;
        Wed,  5 Jun 2019 09:11:14 +0000 (UTC)
Message-ID: <17ea99902e4329db735080d1a8fc04f5c06c9bf0.camel@suse.de>
Subject: Re: [PATCH 3/4] clk: bcm2835: register Raspberry Pi's firmware clk
 device
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Eric Anholt <eric@anholt.net>, stefan.wahren@i2se.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 05 Jun 2019 11:11:12 +0200
In-Reply-To: <87muiwzyrw.fsf@anholt.net>
References: <20190604173223.4229-1-nsaenzjulienne@suse.de>
         <20190604173223.4229-4-nsaenzjulienne@suse.de> <87muiwzyrw.fsf@anholt.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Y0gkZzcIbprnY+sekDS2"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-Y0gkZzcIbprnY+sekDS2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-06-04 at 17:00 -0700, Eric Anholt wrote:
> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> writes:
>=20
> > Registers clk-raspberrypi as a platform device as part of the driver's
> > probe sequence.
>=20
> Similar to how we have VCHI register platform devices for the services
> VCHI provides, shouldn't we have the firmware driver register the device
> for clk_raspberrypi?  Or put the clk provider in the fw driver instead
> of a separate driver (no opinion on my part).

Makes sense to me, I'll move the platform driver registration into the firm=
ware
driver.


--=-Y0gkZzcIbprnY+sekDS2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlz3hzAACgkQlfZmHno8
x/5W0AgAk1lBDDOGbH2IxMCBbNMjMT+5XCPJUI+HhTTIY6r2lj0vF9v2mMl6idjj
Dy1k0dx1BmB4S8bAAoLUO0AjOriCapLoDDwotUSpT5XPXABdmQyacS0hzbgNtdR2
e/6Ks/dgPThgKTyWrFH5ebLK5GBqm+NtYUkFOIugECaL2oIAwaM7jFntdSin/42W
1/ZInxhc6/yeMOGZqtfnOKlzxJQ2yO6kamz6neOY6prXtJSSjjVQ8NLRun5gj8xB
FThb3WLHnZ3xUit7GnbhzzSkUAgdvTrRVesxViN+FtmGySqYeI3HVCHjjyBEu6CY
yrDjYy0kizct4ZRNg3HEGeF3/kd+EA==
=Ryff
-----END PGP SIGNATURE-----

--=-Y0gkZzcIbprnY+sekDS2--

