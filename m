Return-Path: <linux-pm+bounces-19364-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 786C09F47B0
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 10:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381D91883C04
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 09:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B661D5AA5;
	Tue, 17 Dec 2024 09:37:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419393D69
	for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2024 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428245; cv=none; b=VbuvnzVYkgKlNHG2kJM5LtrW4cl3e1mgAUROMO22itcYwg1I5bb+f2j3LFRMi6Wc1fmGRyNV3iIVSSsYUFTUxjSP84fcWEM3GwB+ByF5IyfTtD6me5rDuWCFDucSzrQ8lCnsZQzA0Vv1m3uEprYbw7mb2S+3A7435Ps3wLH4Zzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428245; c=relaxed/simple;
	bh=PbdsB2BhIDuxuM2K/h5mPZ7JGcHKlNVmrrssGgyp37A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HCUIjLOh0iA2tfvof94ZGYoVF3rbK2SAuPkLTcRJSkTAos3njnIA6ghindL3RJ86Wo5hiajXH/euODpVBOpW/Clu0k0bf6eEtqA9HC8bz/0Swv6sEaq2ToDDH+4iWxvT8xg18aNbJulgBHfIPl9W/gG420/o1kAtqcAfh62Sdq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1tNU0y-0006bG-N7; Tue, 17 Dec 2024 10:37:16 +0100
Message-ID: <8956e0daffc89f8c6791f8a53b1666ca31011a45.camel@pengutronix.de>
Subject: Re: imx8m-blk-ctrl: WARNING, no release() function
From: Lucas Stach <l.stach@pengutronix.de>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Peng Fan <peng.fan@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
 Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>,  Fabio Estevam <festevam@gmail.com>, Marek Vasut
 <marex@denx.de>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Jindong Yue <jindong.yue@nxp.com>, Benjamin
 Gaignard <benjamin.gaignard@collabora.com>, Paul Elder
 <paul.elder@ideasonboard.com>,  =?ISO-8859-1?Q?Herv=E9?= Codina
 <herve.codina@bootlin.com>
Date: Tue, 17 Dec 2024 10:37:14 +0100
In-Reply-To: <20241217094219.788cad88@booty>
References: <20241212141003.GA44219@francesco-nb>
	 <PAXPR04MB8459AB53B142CB43782757D988042@PAXPR04MB8459.eurprd04.prod.outlook.com>
	 <20241217094219.788cad88@booty>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
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

Hi Luca,

Am Dienstag, dem 17.12.2024 um 09:42 +0100 schrieb Luca Ceresoli:
> Hello Peng,
>=20
> On Tue, 17 Dec 2024 01:39:09 +0000
> Peng Fan <peng.fan@nxp.com> wrote:
>=20
> > > Subject: imx8m-blk-ctrl: WARNING, no release() function =20
> >=20
> > Please try this patch.
> > https://lore.kernel.org/all/20241206112731.98244-1-peng.fan@oss.nxp.com=
/
>=20
> I cherry-picked the two patches from linux-next:
>=20
>   e1a875703470 ("pmdomain: imx-gpcv2: Suppress bind attrs")
>   afb2a86f002b ("pmdomain: imx8m[p]-blk-ctrl: Suppress bind attrs")
>=20
> but I still have the same warnings:
>=20
> [    5.427038] Device 'mediablk-mipi-csi2-1' does not have a release() fu=
nction, it is broken and must be fixed. See Documentation/core-api/kobject.=
rst.
> [    6.464219] Device 'mediablk-mipi-dsi-1' does not have a release() fun=
ction, it is broken and must be fixed. See Documentation/core-api/kobject.r=
st.
> [    6.752903] Device 'mediablk-mipi-csi2-1' does not have a release() fu=
nction, it is broken and must be fixed. See Documentation/core-api/kobject.=
rst.
> [    7.303529] Device 'mediablk-mipi-dsi-1' does not have a release() fun=
ction, it is broken and must be fixed. See Documentation/core-api/kobject.r=
st.
> [    8.006575] Device 'mediablk-mipi-csi2-1' does not have a release() fu=
nction, it is broken and must be fixed. See Documentation/core-api/kobject.=
rst.
> [    8.598453] Device 'mediablk-mipi-dsi-1' does not have a release() fun=
ction, it is broken and must be fixed. See Documentation/core-api/kobject.r=
st.
>=20
> This is with 6.13-rc3 on a imx8mp.

As far as I can see this isn't emitted due to the blk-ctrl device
itself missing the release function, but from the pseudo devices used
by genpd to control the power of the secondary power domains.

I think this needs to be fixed in genpd itself. I'll take a look.

Regards,
Lucas

