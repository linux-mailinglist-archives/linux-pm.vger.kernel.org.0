Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D3DA7E45
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2019 10:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfIDIrU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Sep 2019 04:47:20 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:24534 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfIDIrT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Sep 2019 04:47:19 -0400
X-Greylist: delayed 165066 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Sep 2019 04:47:18 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567586836;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Tz1SNv7+7mwC04RCYM6zEntjQIfTGl/IpU/FemTzlv4=;
        b=VKVi29+uQWA5b7Z5NOdhdmRLRTlkgwhfBq5Nslebgu3Yx49JgYMyDmvvxUx3/v64wI
        yyo7CwN+7syL2dk9Kdoxv8gfGEvlb3bvjv0JSi7rWfHsicQ/qFmIpe2jWHdiqf3rPbfj
        DVWEI+dGQNXaXvffaGjh0JGwPpHze85pop7wlTK6rLYwgrFExw1l5Y/178rLxAe+uMx/
        PvDdmEloshRPfhcN0748HCy+OYQdC88ThWx8i0IcSP2jF6iAXK0J+g8kVC71mW32czgU
        hjn6bQtVF1MkK/gZdJplbfIJwbO1fx+JFgzQtbvJ/n4teSqi9pp4GZ75uciGSWtfPYCk
        PZ8w==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlabXAYFwg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v848l7cEH
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 4 Sep 2019 10:47:07 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC 5/5] ARM: dts: omap3-beagle: make explicitly compatible to ti,omap34xx
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190903134000.GM52127@atomide.com>
Date:   Wed, 4 Sep 2019 10:47:07 +0200
Cc:     =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C3C8BEA-F03E-42CE-8E5C-397A025CB684@goldelico.com>
References: <cover.1567421750.git.hns@goldelico.com> <150eb34a95b2e7ead8ac81a9ab275592ea31595b.1567421751.git.hns@goldelico.com> <20190903134000.GM52127@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Tony,

> Am 03.09.2019 um 15:40 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [190902 10:56]:
>> Matching the ti-cpufreq driver needs to specify explicitly if
>> a board uses an omap34xx or omap36xx chip.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/arm/boot/dts/omap3-beagle.dts | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/arm/boot/dts/omap3-beagle.dts =
b/arch/arm/boot/dts/omap3-beagle.dts
>> index e3df3c166902..d47213c7a4d0 100644
>> --- a/arch/arm/boot/dts/omap3-beagle.dts
>> +++ b/arch/arm/boot/dts/omap3-beagle.dts
>> @@ -8,7 +8,7 @@
>>=20
>> / {
>> 	model =3D "TI OMAP3 BeagleBoard";
>> -	compatible =3D "ti,omap3-beagle", "ti,omap3";
>> +	compatible =3D "ti,omap3-beagle", "ti,omap34xx", "ti,omap3";
>>=20
>> 	cpus {
>> 		cpu@0 {
>=20
> For a clean-up patch, we should just use the following compatibles
> in general for omap3:
>=20
> ti,omap3	omap3
> ti,omap34	omap34xx and omap35xx
> ti,omap36	omap36xx and dm37xx
> ti,am35		am35xx
>=20
> So we should just leave out the "xx" part. But we still need parse
> also the legacy binding with "xx" in drivers.

Yes, getting rid of the xx in the device trees would be nice.

But I have looked through the kernel tree and that makes more problems
than it solves...

There is code that explicitly checks for "ti,omap36xx" in =
drivers/clk/ti/dpll.c

Maybe that should be replaced by a check for a "ti,dpll5" property
which is only defined in omap36xx.dtsi to make the code depend
on a feature rather than SoC family string. Although such a change
may break other things or we have to keep even more legacy code around.

And there is a binding document omap.txt that does not describe
it the way you propose. IMHO that should be changed first.

Next is that omap.txt explicitly says that ti,omap3 defauls to OMAP3430.
And OMAP3430 should be specified as compatible =3D "ti,omap3430", =
"ti,omap3"
while OMAP3630 should have compatible =3D "ti,omap36xx", "ti,omap3".
AM3517 is compatible =3D "ti,am3517", "ti,omap3" which seems to ignore
the AM3505 (maybe there was never a board using it).

So this clean up is much more than what we need for moving from
opp-v1 to opp-v2 and it should therefore be addressed separately.

Therefore I'd prefer if we can keep all these problems isolated
into a separate set of patches. And because of this I have prepared
an RFC-V2 which only adds the "ti,omap3430" to those boards which
do not yet have it (in accordance to existing omap.txt).

AM3517 does not seem to have any opp table and therefore I also
exclude it at the moment.

BR and thanks,
Nikolaus

