Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA6C1AC51B
	for <lists+linux-pm@lfdr.de>; Sat,  7 Sep 2019 09:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404762AbfIGHTy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Sep 2019 03:19:54 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:44732 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391560AbfIGHTy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 7 Sep 2019 03:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IR3EvGN+MwwMJXzsqEU7B+F3++X7EJi4SV2CHNGQ6fc=; b=VcctuK2RCT0GAVUEK2u+yqtKBy
        n5bauOeoHyn+SifXXye9Q3JU5kjuh4oZFzpggfChojVy8/0wIN3JOTvD8UcUNrqNlzAcjva9zGLhj
        5aXFuF/BVPyevM9Y+vuZJ8muYm5GYxHa5jf2M00+bixNg3eMV21A3ewa1o41YTmg9H3U=;
Received: from p200300ccff34e1001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff34:e100:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1i6V0Y-0004U4-8b; Sat, 07 Sep 2019 09:19:44 +0200
Date:   Sat, 7 Sep 2019 09:19:41 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?QW5kcsOp?= Roth <neolynx@gmail.com>,
        =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>,
        kernel@pyra-handheld.com, Linux-OMAP <linux-omap@vger.kernel.org>,
        Adam Ford <aford173@gmail.com>
Subject: Re: [Letux-kernel] [RFC v2 1/3] cpufreq: ti-cpufreq: add support
 for omap34xx and omap36xx
Message-ID: <20190907091941.43a17d56@aktux>
In-Reply-To: <1ED2450A-A445-42B8-8956-58A53F15DBE2@goldelico.com>
References: <cover.1567587220.git.hns@goldelico.com>
        <a889b10386bebfbfd6cdb5491367235290d53247.1567587220.git.hns@goldelico.com>
        <20190905143226.GW52127@atomide.com>
        <20190906030158.leuumg7rwsvowwfx@vireshk-i7>
        <1ED2450A-A445-42B8-8956-58A53F15DBE2@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 6 Sep 2019 22:46:49 +0200
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Hi,
>=20
> > Am 06.09.2019 um 05:01 schrieb Viresh Kumar <viresh.kumar@linaro.org>:
> >=20
> > On 05-09-19, 07:32, Tony Lindgren wrote: =20
> >> * H. Nikolaus Schaller <hns@goldelico.com> [190904 08:54]: =20
> >>> This adds code and tables to read the silicon revision and
> >>> eFuse (speed binned / 720 MHz grade) bits for selecting
> >>> opp-v2 table entries.
> >>>=20
> >>> Since these bits are not always part of the syscon register
> >>> range (like for am33xx, am43, dra7), we add code to directly
> >>> read the register values using ioremap() if syscon access fails. =20
> >>=20
> >> This is nice :) Seems to work for me based on a quick test
> >> on at least omap36xx.
> >>=20
> >> Looks like n900 produces the following though:
> >>=20
> >> core: _opp_supported_by_regulators: OPP minuV: 1270000 maxuV: 1270000,=
 not supported by regulator
> >> cpu cpu0: _opp_add: OPP not supported by regulators (550000000) =20
> >=20
> > That's a DT thing I believe where the voltage doesn't fit what the
> > regulator can support. =20
>=20
> I can confirm this on BeagleBoard C2:
>=20
> root@gta04:~# dmesg|fgrep -i opp
> [    2.347442] core: _opp_supported_by_regulators: OPP minuV: 1270000 max=
uV: 1270000, not supported by regulator
> [    2.359222] cpu cpu0: _opp_add: OPP not supported by regulators (55000=
0000)
> [    2.580993] omap2_set_init_voltage: unable to find boot up OPP for vdd=
_core
> root@gta04:~#=20
>=20
> >  =20
> >> But presumably that can be further patched. =20
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
> 			>; =20
>=20
>=20
> This is OPP4 which is recommended by OMAP3530 data sheet to be 1.27V +/- =
5%
>=20
> Data sheet of tps65950 says
>=20
> 	=E2=80=A2 VDD1: 1.2-A, buck DC/DC converter (VOUT =3D 0.6 V to 1.45 V, i=
n steps of 12.5 mV)
>=20
> This means 1270 mV is not a "step" and rejected by the twl4030 driver.
> Maybe nobody did notice yet because the opp-v1 drivers did not warn...
>=20
The reason probably is that errors about supported voltages were handled
incorrecly in opp code in former times. Then someone fixed and
cpufreq did not work on omap3 at all due to twl-regulator not specifying
voltages for VDD1.
Then I did a fix "regulator: twl: voltage lists for vdd1/2 on twl4030"
which is still living in linux-next/pending-fixes (and probably also
in Nikolaus's trees). Mark Brown
did apparently not send his pull request.

As a side effect of all that voltage checking corrections these
errors are unveiled.

Regards,
Andreas
