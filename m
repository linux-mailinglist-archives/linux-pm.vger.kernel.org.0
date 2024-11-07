Return-Path: <linux-pm+bounces-17125-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39C79C0B98
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 17:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225021C21D67
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 16:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E30A216E1E;
	Thu,  7 Nov 2024 16:22:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B223216E02
	for <linux-pm@vger.kernel.org>; Thu,  7 Nov 2024 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996578; cv=none; b=Q4bUPqI/aj4ENZ9r8HzLAQRRmfuxjRtRgZdw2ljnIhLsiBNY7UEllbSJ6GO3ypwudgtdm0IpeWzhoWjo2kj6brsYTd9fgWNQbWvmDDcPxtsKZo/G4/wWgWofY4NvXwZScHOvwr+bqSA7xyWEVfPngP5q4TlSr0YKg4KLWGhEsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996578; c=relaxed/simple;
	bh=2/bRKqcIgv50s+uci/nHRLio45G6bn5b9DhmqYan3Sg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WjT3/YujILs4CgTBRmtaQYOAfk6FzhHd0XwmreEbwhtzzavtLqum/aIefdgESdXOqSqUpYn25+oOriaz1U9VIc32whov4OrKJRvvCU8DWSGSQmk/FQ5+lPR7yNxLETSpjWytn+HUrK8Iq9I0Z8AP7EWmpHNMDmkKZ1TX8AUBK6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1t95H5-0001Ei-FD; Thu, 07 Nov 2024 17:22:23 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1t95H3-002UGY-2S;
	Thu, 07 Nov 2024 17:22:21 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1t95H3-000Ci2-28;
	Thu, 07 Nov 2024 17:22:21 +0100
Message-ID: <7a9bf4649ea1cb89cb6478833ab84dc480065308.camel@pengutronix.de>
Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Biju Das
	 <biju.das.jz@bp.renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "vkoul@kernel.org" <vkoul@kernel.org>, "kishon@kernel.org"
 <kishon@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>,  "geert+renesas@glider.be"
 <geert+renesas@glider.be>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
  "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
 <sboyd@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>
Date: Thu, 07 Nov 2024 17:22:21 +0100
In-Reply-To: <91916297-8156-44d9-b56f-9a67e651a9a4@tuxon.dev>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
	 <35dc7414-f5bd-4ed4-bfa1-f723f4f0078c@tuxon.dev>
	 <TY3PR01MB11346A4814F83FE296A1DED8886922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
	 <TY3PR01MB1134648BF51F1B52BFE34DD6D86932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
	 <fbfa9179-2f52-429f-8b69-f7f4064e796b@tuxon.dev>
	 <TYCPR01MB11332EF1A8D064C491D8F261286932@TYCPR01MB11332.jpnprd01.prod.outlook.com>
	 <f7c57e76-b890-491f-880d-62d060b7b31e@tuxon.dev>
	 <TYCPR01MB11332BE2EDB318950B9C7B54C86932@TYCPR01MB11332.jpnprd01.prod.outlook.com>
	 <TY3PR01MB113469FC8A9F49D9B1FA432FD86932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
	 <0b73544b-0253-43b9-b631-6578b48eaca8@tuxon.dev>
	 <TY3PR01MB1134689573A785E91A9041E1886932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
	 <5bcdc677-e61e-4312-a19b-57b4600685d3@tuxon.dev>
	 <TY3PR01MB1134690F9D37E3BB4814D864386932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
	 <d64243fe-48ea-4cb5-b6d6-e9f820e1b8a3@tuxon.dev>
	 <91916297-8156-44d9-b56f-9a67e651a9a4@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Hi Claudiu,

On Do, 2024-11-07 at 12:00 +0200, Claudiu Beznea wrote:
> Hi, all,
>=20
> On 03.09.2024 17:48, claudiu beznea wrote:
> >=20
> >=20
> > On 03.09.2024 16:45, Biju Das wrote:
> > > Hi Claudiu,
> > >=20
> > > > -----Original Message-----
> > > > From: claudiu beznea <claudiu.beznea@tuxon.dev>
> > > > Sent: Tuesday, September 3, 2024 1:57 PM
> > > > Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas =
RZ/G3S SoC
> > > >=20
> > > >=20
> > > >=20
> > > > On 03.09.2024 15:37, Biju Das wrote:
> > > > >=20
> > > > >=20
> > > > > > -----Original Message-----
> > > > > > From: claudiu beznea <claudiu.beznea@tuxon.dev>
> > > > > > Sent: Tuesday, September 3, 2024 1:26 PM
> > > > > > To: Biju Das <biju.das.jz@bp.renesas.com>; Ulf Hansson
> > > > > > <ulf.hansson@linaro.org>
> > > > > > Cc: vkoul@kernel.org; kishon@kernel.org; robh@kernel.org;
> > > > > > krzk+dt@kernel.org; conor+dt@kernel.org; p.zabel@pengutronix.de=
;
> > > > > > geert+renesas@glider.be; magnus.damm@gmail.com;
> > > > > > gregkh@linuxfoundation.org; mturquette@baylibre.com;
> > > > > > sboyd@kernel.org; Yoshihiro Shimoda
> > > > > > <yoshihiro.shimoda.uh@renesas.com>;
> > > > > > linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
> > > > > > linux-kernel@vger.kernel.org; linux- renesas-soc@vger.kernel.or=
g;
> > > > > > linux-usb@vger.kernel.org; linux-arm-kernel@lists.infradead.org=
;
> > > > > > linux- clk@vger.kernel.org; linux-pm@vger.kernel.org; Claudiu B=
eznea
> > > > > > <claudiu.beznea.uj@bp.renesas.com>
> > > > > > Subject: Re: [PATCH 00/16] Add initial USB support for the Rene=
sas
> > > > > > RZ/G3S SoC
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > On 03.09.2024 15:00, Biju Das wrote:
> > > > > > >=20
> > > > > > >=20
> > > > > > > > -----Original Message-----
> > > > > > > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > > > > Sent: Tuesday, September 3, 2024 12:07 PM
> > > > > > > > To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>; Ulf Hansson
> > > > > > > > <ulf.hansson@linaro.org>
> > > > > > > > Cc: vkoul@kernel.org; kishon@kernel.org; robh@kernel.org;
> > > > > > > > krzk+dt@kernel.org; conor+dt@kernel.org; p.zabel@pengutroni=
x.de;
> > > > > > > > geert+renesas@glider.be; magnus.damm@gmail.com;
> > > > > > > > gregkh@linuxfoundation.org; mturquette@baylibre.com;
> > > > > > > > sboyd@kernel.org; Yoshihiro Shimoda
> > > > > > > > <yoshihiro.shimoda.uh@renesas.com>;
> > > > > > > > linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
> > > > > > > > linux-kernel@vger.kernel.org; linux- renesas-soc@vger.kerne=
l.org;
> > > > > > > > linux-usb@vger.kernel.org; linux-arm-kernel@lists.infradead=
.org;
> > > > > > > > linux- clk@vger.kernel.org; linux-pm@vger.kernel.org; Claud=
iu
> > > > > > > > Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > > > > > > Subject: RE: [PATCH 00/16] Add initial USB support for the =
Renesas
> > > > > > > > RZ/G3S SoC
> > > > > > > >=20
> > > > > > > > Hi Claudiu,
> > > > > > > >=20
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: claudiu beznea <claudiu.beznea@tuxon.dev>
> > > > > > > > > Sent: Tuesday, September 3, 2024 12:00 PM
> > > > > > > > > Subject: Re: [PATCH 00/16] Add initial USB support for th=
e Renesas
> > > > > > > > > RZ/G3S SoC
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > On 03.09.2024 13:31, Biju Das wrote:
> > > > > > > > > > > > During boot clr USB PWR READY signal in TF-A.
> > > > > > > > > > > > STR case, suspend set USB PWR READY signal in TF-A.
> > > > > > > > > > > > STR case, resume clr USB PWR READY signal in TF-A.
> > > > > > > > > > > As I said previously, it can be done in different way=
s. My point
> > > > > > > > > > > was to let Linux set what it needs for all it's devic=
es to work.
> > > > > > > > > > > I think the way to go forward is a
> > > > > > > > > maintainer decision.
> > > > > > > > > >=20
> > > > > > > > > > I agree, there can be n number of solution for a proble=
m.
> > > > > > > > > >=20
> > > > > > > > > > Since you modelled system state signal (USB PWRRDY) as =
reset
> > > > > > > > > > control signal, it is reset/DT maintainer's decision to=
 say the
> > > > > > > > > > final word whether this signal fits in reset
> > > > > > > > > system framework or not?
> > > > > > > > >=20
> > > > > > > > > I was thinking:
> > > > > > > > > 1/ Geert would be the best to say if he considers it OK t=
o handle this
> > > > > > > > >    in Linux
> > > > > > > >=20
> > > > > > > > I agree Geert is the right person for taking SYSTEM decisio=
ns,
> > > > > > > > since the signal is used only during state transitions (Tab=
le
> > > > > > > > 41.6.4 AWO to ALL_ON and 41.6.3 ALL_ON to AWO)
> > > > > > >=20
> > > > > > > One more info, as per [1], this USB PWRRDY signal setting to =
be before Linux kernel boots.
> > > > > >=20
> > > > > > The "controlled by" column mentions CA-55 on PWRRDY signal cont=
rol
> > > > > > line and it is b/w steps "DDR exits from retention mode" and  "=
clock
> > > > > > start settings for system bus and peripheral modules". AFAICT, =
after DDR exists retention mode
> > > > Linux is ready to run.
> > > > >=20
> > > > > DDR retention exit happens in TF-A and it jumps into reset code w=
here it executes BL2 in TF_A. Bl2
> > > > checks for warm or cold reset.
> > > > > If it is warm reset, it sets required minimal clocks/resets and p=
ass
> > > > > the control to linux by calling the SMC callback handler. Which i=
n turn calls resume(step 11-->14)
> > > > path.
> > > >=20
> > > > Is this from HW manual or some specific documentation? I'm referrin=
g at "resume" =3D=3D "steps 11-->14"
> > > >=20
> > > > >=20
> > > > > Step 8, Cortex-A55 Exit from DDR retention mode (when using) Sett=
ing
> > > > > for exiting form DDR retention mode Step 9, Cortex-A55 USB PHY PW=
RRDY
> > > > > signal control (if use USB) SYS_USB_PWRRDY Step 10, Cortex-A55 PC=
Ie
> > > > > RST_RSM_B signal control (if use PCIe) SYS_PCIE_RST_RSM_B
> > > >=20
> > > > Note *if use*: how does the TF-A know if USB/PCIe is used by Linux?=
 The documentation mention to set
> > > > it *if use*. Same note is on ALL_ON to VBATT transition documentati=
on (namely "if using USB", "if
> > > > using PCIe"). If TF-A will do this it should set this signals uncon=
ditionally. It will not be
> > > > something wrong though. We don't know at the moment what this invol=
ves in terms of power consumption,
> > > > if it means something...
> > >=20
> > > IIUC,
> > > The only information we have is,
> > >=20
> > > "SYS_USB_PWRRDY and SYS_PCIE_RST_RSM_B are used when transition from =
ALL_ON to AWO (or from AWO to ALL_ON).
> > > "When turning off USB PHY and PCIe PHY, if they are not controlled, P=
HY may break"
> > >=20
> > > ALL_ON to AWO_MODE state transition:=20
> > > USB/PCIe are part of PD_ISOVCC power domain and before turning PD_ISO=
VCC to off,
> > > we need to set USBPWRRDY signal.
> > >=20
> > > AWO_MODE to ALL_ON state transition:
> > >=20
> > > Turn on PD_ISOVCC first, then clr USBPWRRDY signal for USB usage in l=
inux.
> > >=20
> > > Maybe we need to ask hw team, exact usage of USBPWRRDY signal other t=
han state transition.
> >=20
> > As you may already know, this is open for quite some time and is ongoin=
g.
>=20
> I got more clarification about the USB PWRRDY signal from the HW team.
>=20
> The conclusion is that the USB PWRRDY is a signal controlled by SYSC
> controller that goes to the USB PHY and it tells the USB PHY if the power
> supply is ready or not.
>=20
> In the diagram at [1] the PWRRDY signal need to be asserted/de-asserted
> before/after G6, G7, G8, G9, G10 signals.
>=20
> Philipp,
>=20
> Can you please confirm that you don't want this signal to be implemented =
as
> a reset signal to know clearly your input on it? I would like to start
> looking for another approach in that case.

If this is not a reset signal I don't want it to be implemented as one.

regards
Philipp

