Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 749B4ABE57
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 19:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbfIFRJD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 13:09:03 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:34190 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732130AbfIFRJD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Sep 2019 13:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567789738;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=rBCaqKNoNCZ9+3F1oh6m+vepb8uT3GJ5XSm5+YAEkEU=;
        b=QEN5WL28EpXn0/MfyxW2jtAwC8543Mw/SDhdZu9jtwZHp0Z57uE0BsRpwmxnKJcuJj
        qv4v265RmfIiLmUyWM8EegwGKi6WOE8LGw+CaBRWv096Z4hxUvEnFnCvFG8vLe/upRul
        CrrOzj5daMuvdQaw2w7iQOyO9e9K169O/3hu2hMMQVRhMD7O3WanVmBTlLK2iIC/DNpL
        VjFnouyKcXWJe0wg2JVRSWiE32cV0xywAa7bwMrPercwL1i+umUNECV+Sh3md+CPHzEp
        O4Qvi/ifB99qe6wI5drmH0nFznCMgXjUdb9F0RFwdqbn5eWT/O4GZOV08ihU5Ykr2efP
        +eLg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/PqwDqp5w=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v86H8spen
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 6 Sep 2019 19:08:54 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC v2 3/3] ARM: dts: omap3: bulk convert compatible to be explicitly ti,omap3430 or ti,omap36xx
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190906154732.GC52127@atomide.com>
Date:   Fri, 6 Sep 2019 19:08:54 +0200
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
Message-Id: <8C8644AC-FA12-4D26-B96A-76B78798612A@goldelico.com>
References: <cover.1567587220.git.hns@goldelico.com> <a2b56edcada7b9000a6e906387a02c0ee42681db.1567587220.git.hns@goldelico.com> <20190905142734.GV52127@atomide.com> <4BC39938-D63E-4BDC-BA28-5132F77F602D@goldelico.com> <20190906154732.GC52127@atomide.com>
To:     Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Tony,

> Am 06.09.2019 um 17:47 schrieb Tony Lindgren <tony@atomide.com>:
>=20
> * H. Nikolaus Schaller <hns@goldelico.com> [190906 07:53]:
>>> Am 05.09.2019 um 16:27 schrieb Tony Lindgren <tony@atomide.com>:
>>> compatible =3D "ti,omap3-ldp", "ti,omap3430", "ti,omap34xx", =
"ti,omap3";
>>=20
>> After thinking a little about the whole topic the main rule of this =
change must be:
>>=20
>> * do not break any existing in-tree DTS
>> 	=3D> only *add* to compatible what we need to distinguish =
between omap34 and omap36
>>=20
>> * additions shall only follow new scheme
>> 	=3D> we only add "ti,omap34xx" or "ti,omap36xx"
>>           but neither "ti,omap3630" nor "ti,omap3430"
>=20
> Sorry I don't follow you on this one.. We should always add =
"ti,omap3630"
> where "ti,omap36xx" is currently used so we can eventually get rid of
> "ti,omap36xx". And the same for 34xx.

Ah, ok now I see.

You want to make the "ti,omap3630" the official one and "ti,omap36xx" =
legacy.
It is probably an arbitrary choice if we want to get rid of the xx or =
the 30.

I had thought to do it the other way round because I had done this =
statistics:

for i in 3430 34xx 3630 36xx; do echo $i $(fgrep '"'ti,omap$i'"' =
arch/arm/boot/dts/*.dts* | wc -l); done

3430 12
34xx 28
3630 3
36xx 23

which would indicate that 34xx and 36xx are more common.

>> * cover some out-of-tree DTS
>> 	=3D> make the ti-cpufreq driver still match "ti,omap3430" or =
"ti,omap3630"
>> 	   even if this duplicates compatibility
>>=20
>> This would mean that the logicpd-som-lv-37xx-devkit.dts gets the =
additional "ti,omap36xx"
>> while the omap3-ldp.dts would only get an "ti,omap34xx" but no =
"ti,omap3430" (since we
>> do not use it anywhere).
>>=20
>> Could you agree on this approach?
>=20
> Yeah sounds like logicpd-som-lv-37xx-devkit.dts currently still needs
> "ti,omap36xx" for now.
>=20
> If modifying omap3-ldp.dts, also add "ti,omap3430" in additon to
> "ti,omap34xx" that it already has.
>=20
> So basically let's assume the following:
>=20
> "ti,omap3430" =3D=3D "ti,omap34xx"
> "ti,omap3630" =3D=3D "ti,omap36xx"
>=20
> This means code needs to parse both.

Yes, it already does everywhere.

BTW there is also some code that does special SoC detection based on
soc_device_match(), mainly in omapdrm/dss.

If we were to use this mechanism in the ti-cpufreq driver we could
match it to ti,omap3 and could avoid all these changes.

But make it less maintainable and code more complex.

>=20
> And eventually we just drop the "xx" variants.

>=20
> So while patching compatibles, let's also update for this to
> avoid multiple patches churning the same compatibles over and
> over.

Ok. I'll rework the patch so that we never add "ti,34xx" or "ti,36xx"
but add "ti,3430" or "ti,3630" if missing.

I'll also take a look at omap.txt bindings since that likely needs
an update as well to better describe what the official ones are
and which are legacy.

BR and thanks,
Nikolaus

