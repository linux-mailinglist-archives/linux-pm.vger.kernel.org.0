Return-Path: <linux-pm+bounces-7669-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6368C0385
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 19:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA1E1F2128D
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 17:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A28F127E34;
	Wed,  8 May 2024 17:45:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B493F79E1
	for <linux-pm@vger.kernel.org>; Wed,  8 May 2024 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190329; cv=none; b=RTW7Dx4wnzQgwEriVKHrwD8V7ELQyp0ET0aeU5cki5S0/yxm1hfr30He0t36sSEk18TRrsCKkWjouhm/baL0Lb4MsNcj6kyM+QU63oLvmPvx5l3TBKID256l1s4C3xFEKYIOao07dLG46YkNh4mAQFqzzIFm3MBA/f02//kuoPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190329; c=relaxed/simple;
	bh=xixW1XrE6XUNfkUYsLnbxkjo7KyBQ68cdDDJ1LsQW7E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cw+6cRYD8hMJJ4tApgzeyOmTqqaFhkvFs1OCKMQOdmvFU8dzkkufyc1IR/2VmbMDhauWgDfpsifbPUe04ar6sYbG5xw3fCMxhnhRQYza2YbxVJM3NxMHECoft7hqpV5/9tERzqz+rgCQxDDwIXxOmFQZ/L0eZLDtLya0FBobTvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1s4lM3-0007bJ-Bb; Wed, 08 May 2024 19:45:23 +0200
Message-ID: <8636fb8d9809aaafbd8274ec0dbfc250e1113c73.camel@pengutronix.de>
Subject: Re: iMX8M Mini suspend/resume hanging on imx8m_blk_ctrl_power_on()
From: Lucas Stach <l.stach@pengutronix.de>
To: Adam Ford <aford173@gmail.com>, vitor <ivitro@gmail.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	vitor.soares@toradex.com, ulf.hansson@linaro.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	rafael@kernel.org, geert+renesas@glider.be, peng.fan@nxp.com, 
	linus.walleij@linaro.org, u.kleine-koenig@pengutronix.de, marex@denx.de
Date: Wed, 08 May 2024 19:45:22 +0200
In-Reply-To: <CAHCN7xJF1=BNgh=wpsyd6WP=haOq2UdCYEt2AaL7rGfhDUh6CQ@mail.gmail.com>
References: <fccbb040330a706a4f7b34875db1d896a0bf81c8.camel@gmail.com>
	 <4e781d80fbec0db13555456ab8af6bdae6dee168.camel@gmail.com>
	 <CAHCN7xJF1=BNgh=wpsyd6WP=haOq2UdCYEt2AaL7rGfhDUh6CQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

Hi Adam,

Am Mittwoch, dem 08.05.2024 um 12:30 -0500 schrieb Adam Ford:
> On Fri, Apr 5, 2024 at 10:09=E2=80=AFAM vitor <ivitro@gmail.com> wrote:
> >=20
> > Hi,
> >=20
> > On Thu, 2024-04-04 at 16:53 +0100, vitor wrote:
> > > Greetings,
> > >=20
> > > I'm trying to suspend/resume our Verdin iMX8M Mini with VPU IP using
> > > the latest 6.9.0-rc2 Kernel. While the system can suspend without
> > > issues, it hangs on the resume routine. After some investigation, I
> > > can
> > > see the Kernel hanging on imx8m_blk_ctrl_power_on()[1] while resuming
> > > the hantro-vpu power domain.
> > >=20
> > > Any hint about that?
> > >=20
> > > [1]
> > > https://elixir.bootlin.com/linux/v6.9-rc2/source/drivers/pmdomain/imx
> > > /imx8m-blk-ctrl.c#L101
> > >=20
> >=20
> + Lucas
>=20
> > Looking at other child nodes of the pgc node, pgc_vpu_[g1|g2|h1] seems
> > to be nested into pgc_vpumix.
> >=20
>=20
> On the surface, that's how it appears and it would be consistent with
> how the GPU's work with the GPC's for each GPU calling the gpumix.
> However, the VPU's all reference the vpu_blk_ctrl which itself
> references the vpumix.
>=20
> Lucas,
>=20
> You seem to know this driver pretty well.  Do you expect the G1, G2,
> and H1 PGC's to all reference the vpumix, or do you expect the
> vpu_blk_ctrl to enable/disable the vpumix?
>=20
Nope, that's incorrect, as discussed here:
https://lore.kernel.org/all/9ce35b9bb5a15891f6bd01bd54b7dc84b3ba4021.camel@=
pengutronix.de/

>=20
>=20
> > After applying the following changes to imx8mm.dtsi, the suspend/resume
> > is working.
> >=20
> >=20
> > @@ -739,16 +739,19 @@ pgc_vpumix: power-domain@6 {
> >         pgc_vpu_g1: power-domain@7 {
> >                 #power-domain-cells =3D <0>;
> >                 reg =3D <IMX8MM_POWER_DOMAIN_VPUG1>;
> > +               power-domains =3D <&pgc_vpumix>;
> >         };
> >=20
> >         pgc_vpu_g2: power-domain@8 {
> >                 #power-domain-cells =3D <0>;
> >                 reg =3D <IMX8MM_POWER_DOMAIN_VPUG2>;
> > +               power-domains =3D <&pgc_vpumix>;
> >         };
> >=20
> >         pgc_vpu_h1: power-domain@9 {
> >                 #power-domain-cells =3D <0>;
> >                 reg =3D <IMX8MM_POWER_DOMAIN_VPUH1>;
> > +               power-domains =3D <&pgc_vpumix>;
> >         };
> >=20
> >=20
> > I will prepare the patch to send in the next couple of days.
>=20
> Please CC me when post the patch, and I can run some tests on my hardware=
.

The correct patch is already out:
https://lore.kernel.org/all/20240418155151.355133-1-ivitro@gmail.com/

Regards,
Lucas

