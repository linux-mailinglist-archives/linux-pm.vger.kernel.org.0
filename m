Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 856F0A60FD
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2019 08:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfICGBR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Sep 2019 02:01:17 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:36482 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfICGBR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Sep 2019 02:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567490475;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=u/+ojArweC8kk4EIq1yNectL323djAJn8D6lLCw1aG0=;
        b=aOr7oPejYboHMGMxBCvjhkCHGo86jukLqZsi8v/hfVeVe4qZUqF4dvhzTqo0mr/5Q4
        AnzPyZ2PRKutoR1jtWqGMpRq+BjCyvzDKHUvOhwKPc2FTH9ZqU0XavLededCHXFe3J6q
        YCq4c9sb4kTxvfFN1tluslKLQHWIdP8OFcmkLAlwgdDj2MLrWkP/RvoDqirmgLq7tiH5
        Kg/zAZSk5q6VpMifEsah9GFvhbHtmNL8VzlUcc3UyJN04PrjPyAVeHPYqXCWLKQS30w/
        Kp1VdPBH1KmzA08IVIU/nHO28qsOglt6c7os35aNcBk3jVlO28Gu0KP1u0ZYvxjrgiFa
        9CJQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlWfXA4ONfA="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v83616Ugh
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 3 Sep 2019 08:01:06 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC 4/5] ARM: dts: omap3-n950-n9: remove opp-v1 table
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20190903023635.44yf32jowpm3hgfp@vireshk-i7>
Date:   Tue, 3 Sep 2019 08:01:05 +0200
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
Message-Id: <8BC1AEC9-7B24-4C07-8659-16741D018164@goldelico.com>
References: <cover.1567421750.git.hns@goldelico.com> <2f978667c1533e46e3a5df58871e9048f3eb74e9.1567421751.git.hns@goldelico.com> <20190903023635.44yf32jowpm3hgfp@vireshk-i7>
To:     Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> Am 03.09.2019 um 04:36 schrieb Viresh Kumar <viresh.kumar@linaro.org>:
>=20
> On 02-09-19, 12:55, H. Nikolaus Schaller wrote:
>> With opp-v2 in omap36xx.dtsi and ti-cpufreq driver the
>> 1GHz capability is automatically detected.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> arch/arm/boot/dts/omap3-n950-n9.dtsi | 7 -------
>> 1 file changed, 7 deletions(-)
>>=20
>> diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi =
b/arch/arm/boot/dts/omap3-n950-n9.dtsi
>> index 5441e9ffdbb4..e98b0c615f19 100644
>> --- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
>> +++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
>> @@ -11,13 +11,6 @@
>> 	cpus {
>> 		cpu@0 {
>> 			cpu0-supply =3D <&vcc>;
>> -			operating-points =3D <
>> -				/* kHz    uV */
>> -				300000  1012500
>> -				600000  1200000
>> -				800000  1325000
>> -				1000000	1375000
>> -			>;
>> 		};
>> 	};
>=20
> This should be merged with 2/5 ?

Well, it bloats 2/5.

What I hope (I can't test) is that this opp-v1 table
is ignored if an opp-v2 table exists. So that it can be
removed by a separate follow-up patch.

BR,
Nikolaus=
