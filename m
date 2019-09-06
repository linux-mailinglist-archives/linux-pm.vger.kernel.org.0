Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACF3DABF02
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 19:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436488AbfIFRuu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 13:50:50 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:31859 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436487AbfIFRuu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Sep 2019 13:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567792247;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=zWqUl/D9qgP5vSQuEcJUw56yuZP8tzxb9O/b8P5+E0c=;
        b=FcC4ty+RDXIyUR4VpzR9yWVcMiMnId0S4U3UNu6tOqVjQfVAYas0KhVAlxLW4My4UJ
        1Z0+bz64C3vxj5bO0m5USXM2k9jgPbJo9Jjw65ya514gRiuqptr2DRT87Qm6Frrp/O/p
        z+v0hpv2WNAc+l0MinqZKHiI7LnuUcG0xf3/DnXNO1c83WKjT0pVnRiS54vtsvQXcr2L
        xgJ5W3zlXKvHF4PBUfPnwgX1Kltz/KIZ4UFL4on+sNOQxjisZ5pQ43V76qN91WE/8duR
        kPkRrekj3rRccLDOEGfGidg9PMaIz8UeOSB2zpAhnVpe+e2ghNHPE7nmcipvGBqkOoUI
        PW0Q==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/PqwDqp5w=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v86HodpiH
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 6 Sep 2019 19:50:39 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC v2 3/3] ARM: dts: omap3: bulk convert compatible to be explicitly ti,omap3430 or ti,omap36xx
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190906172403.GG52127@atomide.com>
Date:   Fri, 6 Sep 2019 19:50:38 +0200
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <06661291-1025-4714-99BF-A3CE787E2782@goldelico.com>
References: <cover.1567587220.git.hns@goldelico.com> <a2b56edcada7b9000a6e906387a02c0ee42681db.1567587220.git.hns@goldelico.com> <20190905142734.GV52127@atomide.com> <4BC39938-D63E-4BDC-BA28-5132F77F602D@goldelico.com> <20190906154732.GC52127@atomide.com> <8C8644AC-FA12-4D26-B96A-76B78798612A@goldelico.com> <20190906172403.GG52127@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> Am 06.09.2019 um 19:24 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [190906 17:09]:
>> for i in 3430 34xx 3630 36xx; do echo $i $(fgrep '"'ti,omap$i'"' =
arch/arm/boot/dts/*.dts* | wc -l); done
>>=20
>> 3430 12
>> 34xx 28
>> 3630 3
>> 36xx 23
>>=20
>> which would indicate that 34xx and 36xx are more common.
>=20
> Right, but the xx variants are against the device tree naming and
> that's why we should get rid of them in the dts. The compatible
> should be named after the first instance like "ti,omap3430" and
> similar devices can just use that.
>=20
>> BTW there is also some code that does special SoC detection based on
>> soc_device_match(), mainly in omapdrm/dss.
>>=20
>> If we were to use this mechanism in the ti-cpufreq driver we could
>> match it to ti,omap3 and could avoid all these changes.
>>=20
>> But make it less maintainable and code more complex.
>=20
> Hmm right, yeah using soc_device_match() would remove this issue.
> It might be worth doing as these SoC variants do not change
> much and the code should not need updating. Up to you to
> decide.
>=20
>> I'll also take a look at omap.txt bindings since that likely needs
>> an update as well to better describe what the official ones are
>> and which are legacy.
>=20
> OK. Just limit the compatible changes to the ones that
> need to be modified for this series, the rest can be
> done with a separate patches.

Well, with this rule we modify almost all of them.
In total ca. 35 files. But it looks right.

The rest is just one missing ti,am3517.

Here is the script I want to use for bulk conversion:

# add ti,omap3430 if missing
find arch/arm/boot/dts -name '*.dts*' -exec fgrep -q '"ti,omap34xx"' {} =
\; ! -exec fgrep -q '"ti,omap3430"' {} \; -exec sed -i '' =
's/"ti,omap34xx"/"ti,omap3430", "ti,omap34xx"/' {} \;
# add ti,omap3630 if missing
find arch/arm/boot/dts -name '*.dts*' -exec fgrep -q '"ti,omap36xx"' {} =
\; ! -exec fgrep -q '"ti,omap3630"' {} \; -exec sed -i '' =
's/"ti,omap36xx"/"ti,omap3630", "ti,omap36xx"/' {} \;
# add ti,omap3430 default if missing
find arch/arm/boot/dts -name 'omap*.dts*' -exec fgrep -q '"ti,omap3"' {} =
\; ! -exec fgrep -q '"ti,omap3630"' {} \; ! -exec fgrep -q =
'"ti,omap36xx"' {} \; ! -exec fgrep -q '"ti,am3517"' {} \; ! -exec fgrep =
-q '"ti,omap34xx"' {} \; ! -exec fgrep -q '"ti,omap3430"' {} \; -exec =
sed -i '' 's/"ti,omap3"/"ti,omap3430", "ti,omap3"/' {} \;

+ manually add ti,am3517 to arch/arm/boot/dts/am3517_mt_ventoux.dts

BR,
Nikolaus

