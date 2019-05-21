Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2912524E85
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 14:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfEUMCY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 08:02:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:42886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727765AbfEUMCY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 May 2019 08:02:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 207ACAE31;
        Tue, 21 May 2019 12:02:22 +0000 (UTC)
Message-ID: <a54bd83c219b328153352f0d2c96badbac042353.camel@suse.de>
Subject: Re: [RFC v2 0/5] cpufreq support for the Raspberry Pi
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     stefan.wahren@i2se.com, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        mbrugger@suse.de, rjw@rjwysocki.net, sboyd@kernel.org,
        eric@anholt.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        ssuloev@orpaltech.com, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org
Date:   Tue, 21 May 2019 14:02:20 +0200
In-Reply-To: <20190520105153.ftlnjx7ocr2qkxhd@vireshk-i7>
References: <20190520104708.11980-1-nsaenzjulienne@suse.de>
         <20190520105153.ftlnjx7ocr2qkxhd@vireshk-i7>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+jPebD3prxDeK5SyijTN"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-+jPebD3prxDeK5SyijTN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh, thanks for the comments.

On Mon, 2019-05-20 at 16:21 +0530, Viresh Kumar wrote:
> On 20-05-19, 12:47, Nicolas Saenz Julienne wrote:
> > Hi all,
> > as some of you may recall I've been spending some time looking into
> > providing 'cpufreq' support for the Raspberry Pi platform[1]. I think
> > I'm close to something workable, so I'd love for you to comment on it.
> >=20
> > There has been some design changes since the last version. Namely the
> > fact that I now make sure *only* the CPU frequency is updated. The
> > firmware API we use has two modes, with or without turbo. Enabling turb=
o
> > implies not only scaling the CPU clock but also the VPU and other
> > peripheral related clocks.  This is problematic as some of them are not
> > prepared for this kind frequency changes. I spent some time adapting th=
e
> > peripheral drivers, but the result was disappointing as they poorly
> > support live frequency changes (which most other chips accept, think fo=
r
> > instance I2C and clock stretching) but also turned out hard to integrat=
e
> > into the kernel. As we were planning to use 'clk_notifiers' which turns
> > out not to be such a good idea as it's prone to deadlocks and not
> > recommended by the clock maintainers[2]. It's also worth mentioning tha=
t
> > the foundation kernel doesn't support VPU frequency scaling either.
> >=20
> > With this in mind, and as suggested by clock maintainers[2], I've
> > decided to integrate the firmware clock interface into the bcm2835 cloc=
k
> > driver. This, in my opinion, provides the least friction with the
> > firmware and lets us write very simple and portable higher level
> > drivers. As I did with the 'cpufreq' driver which simply queries the ma=
x
> > and min frequencies available, which are configurable in the firmware,
> > to then trigger the generic 'cpufreq-dt'.
> >=20
> > In the future we could further integrate other firmware dependent clock=
s
> > into the main driver. For instance to be able to scale the VPU clock,
> > which should be operated through a 'devfreq' driver.
> >=20
> > This was tested on a RPi3b+ and if the series is well received I'll tes=
t
> > it further on all platforms I own.
>=20
> Please always supply version history on what has changed from V1.

Will do

> And why do you keep sending it as RFC ?

Well it's because of patch #3 which integrates the firmware interface into =
the
clock driver. I want some approval from the maintainers before cleaning it =
up
testing it on all RPi versions.

> Just keep the default PATCH thing,the patches are in good shape I would s=
ay.

Thanks :)

Regards,
Nicolas


--=-+jPebD3prxDeK5SyijTN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlzj6MwACgkQlfZmHno8
x/71TwgAn7hhXU5xBPx2AtDtmx95N4yx8PRK0rNIgfZVHYNj+CYHgmn1xTbGTNUQ
ZEAwEtz4nCxuCKORfYFpQUobPrcHyHFGv2UPpy+EmqsKVqPhkOBJGsjashoIk4lK
m9Hd1Nb+JQQIahBR10CpKteuw/Sfk5UhyA07zzDQs6H6Qihc4xGZm20r6vsKLO7t
Vm8El7HkxVyxGIMqU9mysSclpbZzVGeEkKY/BlWj31rDhf5RzWYiEq6IaMY2PaTX
Vb0LLw+3SHDGQ7GoKZf8wbKNB24zdwCgjZFkacCfBzN63HpaMWrbLQhzLRnAQ0bV
OBkmX/49IOaRTIbQHc93kQZLdfS1sQ==
=Ae8T
-----END PGP SIGNATURE-----

--=-+jPebD3prxDeK5SyijTN--

