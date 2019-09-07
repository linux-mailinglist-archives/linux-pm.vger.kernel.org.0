Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6532CAC4E9
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2019 08:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405759AbfIGGee (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Sep 2019 02:34:34 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:22516 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733303AbfIGGee (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Sep 2019 02:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567838071;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=GUX1eWsEK1Al1N1ta4hnlkUwJe6XR50RrgXmahK2eDg=;
        b=dO7tIyh8N0bVjWVWI+hGom1sV6MO9Z1dlKXl/6LIMdq1IqgF5i2oQeICJVimb+sqk0
        gtJd/EWtwHvejp18oLzJtWfs+qcQCM8XRxzCIAhVdnGasnRAg4H4tYQse6Kx0FgvGjSB
        NWvO3PnY+561uTae0WyOHxNRl8Zm2agxK0S11yRHr3oz8fvg4jxCgHY855amMtf1Oz4r
        q3D6O4kiZwo6XWguIe9yZcMfjwLcow8zutO42mgsdTOGNqMH2zYkgNoLSiSb/12wrU8H
        7FfUbNyOzRbDO0LpCRlkkwlVuPjBqxS6TYiRlOBoiwGgjcOPCyggqGn8cIxnKdnxZxKQ
        Tffg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDVCaXAwLbA=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id u036f9v876YFqUD
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 7 Sep 2019 08:34:15 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC v2 1/3] cpufreq: ti-cpufreq: add support for omap34xx and omap36xx
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <1ED2450A-A445-42B8-8956-58A53F15DBE2@goldelico.com>
Date:   Sat, 7 Sep 2019 08:34:14 +0200
Cc:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        kernel@pyra-handheld.com, Linux-OMAP <linux-omap@vger.kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <12A8E9DF-3D58-48A7-BC91-898B21536E04@goldelico.com>
References: <cover.1567587220.git.hns@goldelico.com> <a889b10386bebfbfd6cdb5491367235290d53247.1567587220.git.hns@goldelico.com> <20190905143226.GW52127@atomide.com> <20190906030158.leuumg7rwsvowwfx@vireshk-i7> <1ED2450A-A445-42B8-8956-58A53F15DBE2@goldelico.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> Am 06.09.2019 um 22:46 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Hi,
>=20
>> Am 06.09.2019 um 05:01 schrieb Viresh Kumar =
<viresh.kumar@linaro.org>:
>>=20
>> On 05-09-19, 07:32, Tony Lindgren wrote:
>>> * H. Nikolaus Schaller <hns@goldelico.com> [190904 08:54]:
>>>> This adds code and tables to read the silicon revision and
>>>> eFuse (speed binned / 720 MHz grade) bits for selecting
>>>> opp-v2 table entries.
>>>>=20
>>>> Since these bits are not always part of the syscon register
>>>> range (like for am33xx, am43, dra7), we add code to directly
>>>> read the register values using ioremap() if syscon access fails.
>>>=20
>>> This is nice :) Seems to work for me based on a quick test
>>> on at least omap36xx.
>>>=20
>>> Looks like n900 produces the following though:
>>>=20
>>> core: _opp_supported_by_regulators: OPP minuV: 1270000 maxuV: =
1270000, not supported by regulator
>>> cpu cpu0: _opp_add: OPP not supported by regulators (550000000)
>>=20
>> That's a DT thing I believe where the voltage doesn't fit what the
>> regulator can support.
>=20
> I can confirm this on BeagleBoard C2:
>=20
> root@gta04:~# dmesg|fgrep -i opp
> [    2.347442] core: _opp_supported_by_regulators: OPP minuV: 1270000 =
maxuV: 1270000, not supported by regulator
> [    2.359222] cpu cpu0: _opp_add: OPP not supported by regulators =
(550000000)
> [    2.580993] omap2_set_init_voltage: unable to find boot up OPP for =
vdd_core
> root@gta04:~#=20
>=20
>>=20
>>> But presumably that can be further patched.
>=20
> Well, the opp-v1 table also has this voltage point:
>=20
> 			/* OMAP343x/OMAP35xx variants OPP1-5 */
> 			operating-points =3D <
> 				/* kHz    uV */
> 				125000   975000
> 				250000  1075000
> 				500000  1200000
> 				550000  1270000
> 				600000  1350000
> 			>;
>=20
>=20
> This is OPP4 which is recommended by OMAP3530 data sheet to be 1.27V =
+/- 5%
>=20
> Data sheet of tps65950 says
>=20
> 	=E2=80=A2 VDD1: 1.2-A, buck DC/DC converter (VOUT =3D 0.6 V to =
1.45 V, in steps of 12.5 mV)
>=20
> This means 1270 mV is not a "step" and rejected by the twl4030 driver.
> Maybe nobody did notice yet because the opp-v1 drivers did not warn...
>=20
> The closest value to 1.27V is 0.6V + 54 * 12.5mV is 1.275V
>=20
> So let's also change the OPP4 to 1275000 uV in the opp-v2 table.

The OPP is now available. Only

[    2.569519] omap2_set_init_voltage: unable to find boot up OPP for =
vdd_core

remains but this is a different issue (mismatch between U-Boot =
clock/vdd_core
setup and kernel table). Most likely U-Boot runs with an 300MHz OPP =
which is
not defined by data sheet or kernel opp tables.

BR,
Nikolaus=
