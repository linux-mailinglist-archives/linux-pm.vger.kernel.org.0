Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6270A6153
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 08:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfICGYE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Sep 2019 02:24:04 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:10245 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfICGYE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Sep 2019 02:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567491842;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=i2z0P/ZmQl7508HzfoAgu+obqBy87SZaXGkASqxOCg0=;
        b=OVuL3E59RSHGtK/bRGqP/YqLcTDtpvtoix1fUIMsax6jSs9QyELXKvwanFdb8M3/GT
        PRGJdJ4ChJuEnwJnn02gjuxKXrgogedhjR0knS8erTCSToO+1CwDzRqq/Kq7SYxx9ZTR
        UWgzFuWVx+BVhtSIBQzE68jfu5+e1tZcxwQDe9qZhgHZWUaJJeZDN/nED2DpARVs0Ios
        p51MPvhG+pkDcYFmh+9U0kUA8tsAjc9gLTcpg9MUzYrk3TxJQIa8eDLsHBxVDHs+aynz
        SvwD7DLDbq/X6L11PCVCSXfn1w4XARkUYJUdt+/LTP50fgO6E+gdwQBI+eXtQcCdHbqa
        FHtQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlWfXA4ONfA="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v836NqUod
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 3 Sep 2019 08:23:52 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC 4/5] ARM: dts: omap3-n950-n9: remove opp-v1 table
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190903061403.k3d333f54gj2kuxi@vireshk-i7>
Date:   Tue, 3 Sep 2019 08:23:51 +0200
Cc:     =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B7B0EDB-8A60-48A0-AFAB-8A266358300C@goldelico.com>
References: <cover.1567421750.git.hns@goldelico.com> <2f978667c1533e46e3a5df58871e9048f3eb74e9.1567421751.git.hns@goldelico.com> <20190903023635.44yf32jowpm3hgfp@vireshk-i7> <8BC1AEC9-7B24-4C07-8659-16741D018164@goldelico.com> <20190903061403.k3d333f54gj2kuxi@vireshk-i7>
To:     Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> Am 03.09.2019 um 08:14 schrieb Viresh Kumar <viresh.kumar@linaro.org>:
>=20
> On 03-09-19, 08:01, H. Nikolaus Schaller wrote:
>>=20
>>> Am 03.09.2019 um 04:36 schrieb Viresh Kumar =
<viresh.kumar@linaro.org>:
>>>=20
>>> On 02-09-19, 12:55, H. Nikolaus Schaller wrote:
>>>> With opp-v2 in omap36xx.dtsi and ti-cpufreq driver the
>>>> 1GHz capability is automatically detected.
>>>>=20
>>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>>> ---
>>>> arch/arm/boot/dts/omap3-n950-n9.dtsi | 7 -------
>>>> 1 file changed, 7 deletions(-)
>>>>=20
>>>> diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi =
b/arch/arm/boot/dts/omap3-n950-n9.dtsi
>>>> index 5441e9ffdbb4..e98b0c615f19 100644
>>>> --- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
>>>> +++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
>>>> @@ -11,13 +11,6 @@
>>>> 	cpus {
>>>> 		cpu@0 {
>>>> 			cpu0-supply =3D <&vcc>;
>>>> -			operating-points =3D <
>>>> -				/* kHz    uV */
>>>> -				300000  1012500
>>>> -				600000  1200000
>>>> -				800000  1325000
>>>> -				1000000	1375000
>>>> -			>;
>>>> 		};
>>>> 	};
>>>=20
>>> This should be merged with 2/5 ?
>>=20
>> Well, it bloats 2/5.
>=20
> It is logically the right place to do this as that's where we are
> adding opp-v2.

Well, sometimes the philosophy of patches is to add something new
first and remove the old in a second separate patch if the system
can live with both. This makes it easier to digest single patches
(because they are smaller) and might also better pinpoint an issue
by bisect.

>=20
>> What I hope (I can't test) is that this opp-v1 table
>> is ignored if an opp-v2 table exists. So that it can be
>> removed by a separate follow-up patch.
>=20
> It should work as that's what we are doing in OPP core, but I still
> feel this better get merged with 2/5.

Ok, I see. Noted for RFCv2.

There will also be a big batch of changes for the compatible record
(omap3530->omap35xx, add omap34xx where needed) of ca. 10 board =
definition
DTS files. Should this then also become part of the new 2/5?

BR and thanks,
Nikolaus

