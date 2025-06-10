Return-Path: <linux-pm+bounces-28515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EB7AD628E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 00:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113021BC193F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 22:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872BE248F6E;
	Wed, 11 Jun 2025 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="AbSv3Rvp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB38DF49;
	Wed, 11 Jun 2025 22:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681619; cv=none; b=AhXM2CnJoTG08kCwvP/AhLNMNO9St6in/gcl1s3IS1iWcrPjG/FKXzhHAVlwcmx78NzDzz7wYCq0Zt2djAkmAwyPQIVGOPqcwtfOblWr+i64ScuxE0K4Is+/VgaxqwBvtfZ6qKIN6dPBtNv9VV8+4QPIuNS4fPieEYLl1oDtBXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681619; c=relaxed/simple;
	bh=HYGzR/0lPajAJjjHFrDLDOmO2EpjmvNf1NtQvCaKh30=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=XIPtrjFohzh9s7CTDMX6tV3MYpqFQIKDR6X2Voj57nOdCVZXa0PkL3f+m9MMDR1BUsG8dozgIqbMlHiWa61TcCu1cHgf1muOjAZ9ZzotxknFINOtfkdi8cwtEtVtgO2gvVjMAkSFu62nm0il2l2ld+ZGKIqbpD0EZGTx1Ya6mUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=AbSv3Rvp; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1749681557; x=1750286357; i=frank-w@public-files.de;
	bh=M+DXZolM1CuO7m1q3GplhJNNpS0Vq/tj3+DzTCCdtGY=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AbSv3RvpaGHmnIxBfz6Jm7PJR1BejaK56qmKAeVrkzZdZe/dbl4UUjTGRbHn/bNl
	 qqxYTUZ+W2lbEZMu2KaPMmCw7VdAnRCeignFySXeStAg3L4G8X+KRBNwlwOPJR7V7
	 nD74yYStoBmuZnudYlF9cdUQZrUZb/xv8vkYGxkvW7hcOvexfxVm+vSl+WReKjXY+
	 nR3DzpIqV4MXTL0ekNIIMxTst1ZpsBYy+J7oOlMG2s3aWofEXhCwPQwWfQdZoDx7R
	 Pggob6RUD4BdRqEx0LbI8/GlfESHJGBu2sjfmJVoNrg2A1Cap+3S/njxojrYCcAsH
	 7v/EP+MZGmUT0QqpjA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([194.15.82.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpNo-1uyGt446V8-00bewy; Thu, 12
 Jun 2025 00:39:17 +0200
Date: Tue, 10 Jun 2025 15:32:23 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: Andrew Lunn <andrew@lunn.ch>
CC: linux@fw-web.de, myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
 cw00.choi@samsung.com, djakov@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 jia-wei.chang@mediatek.com, johnson.wang@mediatek.com, arinc.unal@arinc9.com,
 Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
 daniel@makrotopia.org, lorenzo@kernel.org, nbd@nbd.name,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_Re=3A_=5BPATCH_v3_12/13=5D_arm64=3A_dts=3A_mediatek=3A?=
 =?US-ASCII?Q?_mt7988a-bpi-r4=3A_add_sfp_cages_and_link_to_gmac?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <e1a49ca7-f082-4983-89fe-1a8f8c8a3de1@lunn.ch>
References: <20250608211452.72920-1-linux@fw-web.de> <20250608211452.72920-13-linux@fw-web.de> <934b1515-2da1-4479-848e-cd2475ebe98d@lunn.ch> <trinity-b9ab960d-38f8-4524-b645-fc0832ce72ec-1749546239525@trinity-msg-rest-gmx-gmx-live-5d9b465786-6phds> <e1a49ca7-f082-4983-89fe-1a8f8c8a3de1@lunn.ch>
Message-ID: <87B3002D-46DD-4392-BD0E-54D2B1DA5EAB@public-files.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DsPiSpMR8xb6e8i18zfPbYVrfbaG4v6s3QvSjVXohv/Uc0Js7TW
 T13ewz6NHM6Jsu4kkwPnhT4bmwivrR7L7kmktDCU8A9NgFKYSktihrBDX5j13mb/pBPcsCl
 JwAyZBffD23sZBYwUUATi9Zn3dxoWNTC48+uTkTjXLrcx7XVBTcKm+Rv36/2EZFTXP4MTv6
 CFJkZx0ABx2kBvIt9bC8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5TUBUR1RzM4=;Xb/FftVWsM+f589cjF/ztCS/hl/
 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
 716VAXP

Am 10=2E Juni 2025 14:58:44 MESZ schrieb Andrew Lunn <andrew@lunn=2Ech>:
>> > sff,sfp=2Eyaml says:
>> >=20
>> >   maximum-power-milliwatt:
>> >     minimum: 1000
>> >     default: 1000
>> >     description:
>> >       Maximum module power consumption Specifies the maximum power co=
nsumption
>> >       allowable by a module in the slot, in milli-Watts=2E Presently,=
 modules can
>> >       be up to 1W, 1=2E5W or 2W=2E
>> >=20
>> > I've no idea what will happen when the SFP core sees 3000=2E Is the
>> > comment out of date?
>>=20
>> at least sfp-core has no issue with the setting
>>=20
>> root@bpi-r4-phy-8G:~# dmesg | grep sfp
>> [    1=2E269437] sfp sfp1: Host maximum power 3=2E0W
>> [    1=2E613749] sfp sfp1: module CISCO-FINISAR    FTLX8571D3BCL-C2 rev=
 A    sn S2209167650      dc 220916 =20
>>=20
>> imho some modules require more than 2W (some gpon/xpon and 10G copper e=
thernet)=2E
>
>Looking at the code:
>
>static int sfp_module_parse_power(struct sfp *sfp)
>{
>        u32 power_mW =3D 1000;
>        bool supports_a2;
>
>        if (sfp->id=2Eext=2Esff8472_compliance >=3D SFP_SFF8472_COMPLIANC=
E_REV10_2 &&
>            sfp->id=2Eext=2Eoptions & cpu_to_be16(SFP_OPTIONS_POWER_DECL)=
)
>                power_mW =3D 1500;
>        /* Added in Rev 11=2E9, but there is no compliance code for this =
*/
>        if (sfp->id=2Eext=2Esff8472_compliance >=3D SFP_SFF8472_COMPLIANC=
E_REV11_4 &&
>            sfp->id=2Eext=2Eoptions & cpu_to_be16(SFP_OPTIONS_HIGH_POWER_=
LEVEL))
>                power_mW =3D 2000;
>
>How does your module indicate it needs 3000 mW? Does this bit of code
>need extending to read additional bits?

Message says "host maximum power",not that sfp needs the 3w=2E

>	Andrew


regards Frank

