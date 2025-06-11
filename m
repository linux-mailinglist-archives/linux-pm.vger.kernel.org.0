Return-Path: <linux-pm+bounces-28467-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CE0AD5098
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 11:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C8AB7A54AC
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A55825C83E;
	Wed, 11 Jun 2025 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="Xo8m6QJC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0002AD2C;
	Wed, 11 Jun 2025 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749635613; cv=none; b=A/TfqIf8/n3nzTP3Q2STi553QVEv6b5v8CRtwdeYNjNx3bqHjDpTn8WRP12ZuPDwqIxjUKuINFmfUXtisIph9TPqTlftvkTeOm4LKbLmfZXxOUF3eUQ6QLawESqAKLlcvyAx5alp94hbrycLVi2gNUlfO5vZDOGmzxEIxEG3s9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749635613; c=relaxed/simple;
	bh=HKpIzjGHEcjtHwxkZNmWbD6HEfZzSXNM1aVPTfuLGTw=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=l6eYTsuwXdXSGysd+U11USX0t6YvFi5hfQH0zDpARyn1/1mDtwWS3viybTOX6ru90Lbq+tEO1Z5wnfpLMGeX7qtd5HeiK8LuvvmYVPcKxOH/Vj56z9UYmiYEjV3CE0Fv2Z8Hzs+QCgM4JLSU9wz5upglVLa3794AXJE+NYIIvb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=Xo8m6QJC; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1749635594; x=1750240394; i=frank-w@public-files.de;
	bh=zYXRhiTCKjL/ILq0gnh0QN/qZigjj3xGh6BayDOZZXM=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Xo8m6QJCi1JyBEsPJjQ97sZu9YQMq5UsQ72KLON8c8AQU4UkYH2k0L6HiMzd8Qm/
	 vgz3OvDfSnHTx+ByyF7I2B3iCZU+PtY3wyiVoq4DjAzGRiIFjQMkFjs5PFIkiPdzE
	 nJca4cpThicSjz1ZKm3bk4nhioTV0OoKHuOYhw2UTt126ntxmmGLnXKta8UTeuzs4
	 V8i1JA+Y7mWJy/o7GuOkogc0h7MBnYdlvBKCc7LS6StO97JvVXleC68/NaDVTWOfz
	 ieSKAWS5rGI0OUKqz5/Lx8/sc2QPwulr/6nVh40Gf8BAeeRSoIveN92IAPr/z2IXK
	 3r/sEEgp5T+chUDbJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [100.64.173.171] ([100.64.173.171]) by
 trinity-msg-rest-gmx-gmx-live-847b5f5c86-xfcwg (via HTTP); Wed, 11 Jun 2025
 09:53:14 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-86821bec-44c3-4443-948c-129059072e31-1749635594371@trinity-msg-rest-gmx-gmx-live-847b5f5c86-xfcwg>
From: Frank Wunderlich <frank-w@public-files.de>
To: angelogioacchino.delregno@collabora.com, linux@fw-web.de,
 myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com,
 djakov@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com
Cc: jia-wei.chang@mediatek.com, johnson.wang@mediatek.com,
 arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, daniel@makrotopia.org, lorenzo@kernel.org,
 nbd@nbd.name, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Aw: Re: [PATCH v3 06/13] arm64: dts: mediatek: mt7988: add basic
 ethernet-nodes
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Jun 2025 09:53:14 +0000
In-Reply-To: <10d6fe88-75ff-4c02-8fdd-e1101aaa565c@collabora.com>
References: <20250608211452.72920-1-linux@fw-web.de>
 <20250608211452.72920-7-linux@fw-web.de>
 <10d6fe88-75ff-4c02-8fdd-e1101aaa565c@collabora.com>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:Q2R61HcTqndi0q11hWidyahbItcW6ovT4kgROL1nVAsKt0arHVAd/NiryzdzXvAIws3t1
 ltx6Ujod5/iaAeAuFrBp4VokrPC0pJudFY+6gFvpd1MtY33eWlb2ozX94z0F2Mjq/aXDsO/3ET5G
 GFAlTdZsBexqzqnJ+QwafaN3oXIxoVCkaoBT1kMbhQtbf32oXXYwf8ZlyRiRYv/4/94izt82b38Q
 NThXJCHzy8z7Zt5QvO7dDdxPjFfYAK6TA992FYMywk7zpo/mgwL3rvjWvd59fDqeE2tV7SE01nEu
 hMqr+0lS+1c7ydPOToBhQUpp+Fg99b2tHnBunWJPcfetcBJ0wpzTXiMDJJ+hiq5Tv4=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2Zyrp1I1JME=;mBDTp/4Eo5Q/GEjqqicjM4prH5Z
 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
 6/+IGGwuXw==
Content-Transfer-Encoding: quoted-printable

Hi Angelo,

thanks for review.

> Gesendet: Mittwoch, 11. Juni 2025 um 11:33
> Von: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.c=
om>
> Betreff: Re: [PATCH v3 06/13] arm64: dts: mediatek: mt7988: add basic et=
hernet-nodes
>
> Il 08/06/25 23:14, Frank Wunderlich ha scritto:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >=20
> > Add basic ethernet related nodes.
> >=20
> > Mac1+2 needs pcs (sgmii+usxgmii) to work correctly which will be linke=
d
> > later when driver is merged.
> >=20
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 124 ++++++++++++++++++++=
+-
> >   1 file changed, 121 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/bo=
ot/dts/mediatek/mt7988a.dtsi
> > index 560ec86dbec0..ee1e01d720fe 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> > @@ -680,7 +680,28 @@ xphyu3port0: usb-phy@11e13000 {
> >   			};
> >   		};
> >  =20
> > -		clock-controller@11f40000 {
> > +		xfi_tphy0: phy@11f20000 {
> > +			compatible =3D "mediatek,mt7988-xfi-tphy";
> > +			reg =3D <0 0x11f20000 0 0x10000>;
> > +			resets =3D <&watchdog 14>;
> > +			clocks =3D <&xfi_pll CLK_XFIPLL_PLL_EN>,
> > +				 <&topckgen CLK_TOP_XFI_PHY_0_XTAL_SEL>;
> > +			clock-names =3D "xfipll", "topxtal";
>=20
> resets here please, not after reg.

OK

> > +			mediatek,usxgmii-performance-errata;
> > +			#phy-cells =3D <0>;

maybe #phy-cells above vendor-specific property like below?

> > +		};
> > +
> > +		xfi_tphy1: phy@11f30000 {
> > +			compatible =3D "mediatek,mt7988-xfi-tphy";
> > +			reg =3D <0 0x11f30000 0 0x10000>;
> > +			resets =3D <&watchdog 15>;
> > +			clocks =3D <&xfi_pll CLK_XFIPLL_PLL_EN>,
> > +				 <&topckgen CLK_TOP_XFI_PHY_1_XTAL_SEL>;
> > +			clock-names =3D "xfipll", "topxtal";
>=20
> ditto

ok, #phy-cells last?

> > +			#phy-cells =3D <0>;
> > +		};
> > +
> > +		xfi_pll: clock-controller@11f40000 {
> >   			compatible =3D "mediatek,mt7988-xfi-pll";
> >   			reg =3D <0 0x11f40000 0 0x1000>;
> >   			resets =3D <&watchdog 16>;
> > @@ -714,19 +735,116 @@ phy_calibration_p3: calib@97c {
> >   			};
> >   		};
> >  =20
> > -		clock-controller@15000000 {
> > +		ethsys: clock-controller@15000000 {
> >   			compatible =3D "mediatek,mt7988-ethsys", "syscon";
> >   			reg =3D <0 0x15000000 0 0x1000>;
> >   			#clock-cells =3D <1>;
> >   			#reset-cells =3D <1>;
> >   		};
> >  =20
> > -		clock-controller@15031000 {
> > +		ethwarp: clock-controller@15031000 {
> >   			compatible =3D "mediatek,mt7988-ethwarp";
> >   			reg =3D <0 0x15031000 0 0x1000>;
> >   			#clock-cells =3D <1>;
> >   			#reset-cells =3D <1>;
> >   		};
> > +
> > +		eth: ethernet@15100000 {
> > +			compatible =3D "mediatek,mt7988-eth";
> > +			reg =3D <0 0x15100000 0 0x80000>,
> > +			      <0 0x15400000 0 0x200000>;
>=20
> reg =3D <0 0x15100000 0 0x80000>, <0 0x15400000 0 0x200000>;
>=20
> it's 83 columns - it's fine.

ok, thought 80 columns is the limit...

> > +			interrupts =3D <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks =3D <&ethsys CLK_ETHDMA_CRYPT0_EN>,
> > +				 <&ethsys CLK_ETHDMA_FE_EN>,
> > +				 <&ethsys CLK_ETHDMA_GP2_EN>,
> > +				 <&ethsys CLK_ETHDMA_GP1_EN>,
> > +				 <&ethsys CLK_ETHDMA_GP3_EN>,
> > +				 <&ethwarp CLK_ETHWARP_WOCPU2_EN>,
> > +				 <&ethwarp CLK_ETHWARP_WOCPU1_EN>,
> > +				 <&ethwarp CLK_ETHWARP_WOCPU0_EN>,
> > +				 <&ethsys CLK_ETHDMA_ESW_EN>,
> > +				 <&topckgen CLK_TOP_ETH_GMII_SEL>,
> > +				 <&topckgen CLK_TOP_ETH_REFCK_50M_SEL>,
> > +				 <&topckgen CLK_TOP_ETH_SYS_200M_SEL>,
> > +				 <&topckgen CLK_TOP_ETH_SYS_SEL>,
> > +				 <&topckgen CLK_TOP_ETH_XGMII_SEL>,
> > +				 <&topckgen CLK_TOP_ETH_MII_SEL>,
> > +				 <&topckgen CLK_TOP_NETSYS_SEL>,
> > +				 <&topckgen CLK_TOP_NETSYS_500M_SEL>,
> > +				 <&topckgen CLK_TOP_NETSYS_PAO_2X_SEL>,
> > +				 <&topckgen CLK_TOP_NETSYS_SYNC_250M_SEL>,
> > +				 <&topckgen CLK_TOP_NETSYS_PPEFB_250M_SEL>,
> > +				 <&topckgen CLK_TOP_NETSYS_WARP_SEL>,
> > +				 <&ethsys CLK_ETHDMA_XGP1_EN>,
> > +				 <&ethsys CLK_ETHDMA_XGP2_EN>,
> > +				 <&ethsys CLK_ETHDMA_XGP3_EN>;
> > +			clock-names =3D "crypto", "fe", "gp2", "gp1",
> > +				      "gp3",
>=20
> clock-names =3D "crypto", "fe", "gp2", "gp1", "gp3",
>=20
> :-)

do not know how this was happen...of course i change this ;)

> > +				      "ethwarp_wocpu2", "ethwarp_wocpu1",
> > +				      "ethwarp_wocpu0", "esw", "top_eth_gmii_sel",
> > +				      "top_eth_refck_50m_sel", "top_eth_sys_200m_sel",
> > +				      "top_eth_sys_sel", "top_eth_xgmii_sel",
> > +				      "top_eth_mii_sel", "top_netsys_sel",
> > +				      "top_netsys_500m_sel", "top_netsys_pao_2x_sel",
> > +				      "top_netsys_sync_250m_sel",
> > +				      "top_netsys_ppefb_250m_sel",
> > +				      "top_netsys_warp_sel","xgp1", "xgp2", "xgp3";
> > +			assigned-clocks =3D <&topckgen CLK_TOP_NETSYS_2X_SEL>,
> > +					  <&topckgen CLK_TOP_NETSYS_GSW_SEL>,
> > +					  <&topckgen CLK_TOP_USXGMII_SBUS_0_SEL>,
> > +					  <&topckgen CLK_TOP_USXGMII_SBUS_1_SEL>,
> > +					  <&topckgen CLK_TOP_SGM_0_SEL>,
> > +					  <&topckgen CLK_TOP_SGM_1_SEL>;
> > +			assigned-clock-parents =3D <&apmixedsys CLK_APMIXED_NET2PLL>,
> > +						 <&topckgen CLK_TOP_NET1PLL_D4>,
> > +						 <&topckgen CLK_TOP_NET1PLL_D8_D4>,
> > +						 <&topckgen CLK_TOP_NET1PLL_D8_D4>,
> > +						 <&apmixedsys CLK_APMIXED_SGMPLL>,
> > +						 <&apmixedsys CLK_APMIXED_SGMPLL>;
>=20
> Address and size cells must go *before* vendor-specific properties

OK, same for #phy-cells above?

> > +			mediatek,ethsys =3D <&ethsys>;
> > +			mediatek,infracfg =3D <&topmisc>;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +
>=20
> Cheers!
> Angelo
>=20

