Return-Path: <linux-pm+bounces-27791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBB4AC7794
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 07:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D954E39EB
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 05:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8C124E4B4;
	Thu, 29 May 2025 05:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="l3MrNSt2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA6F1DFDA1;
	Thu, 29 May 2025 05:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748495920; cv=none; b=uN3ykC1xsMW4QwQmQPGBdcUQORStwbQBACjv+TdiXXN8/kCVD5jhHmLjsQv1M+4tFg+XQs1cekVCPGWOrOA4Rqy/0RJbs73QY/7gK6ewyfn0AJN3OIH8jTyq/u9T7e0MQqe7k+368Hep7ICFuCpW8D1JTilv7EFycUMd0jsBmAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748495920; c=relaxed/simple;
	bh=/Uk1Nq98La4/jPGd0KEXutNI+cKnRhZO03LKwcA6mT0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=taUZRxULHwAKrxjMdc/XO9rF72T8NyKOXDL9G1l7vdbWX7XuehQxtGpqus8jSjJ44j34LKwTZftLykgoZGl/SBLytxiih0SCUg8jI1+txJU4ZW/kMGKNKV8WVV9HNXhHEehWi8Oi+5E25yqLQEZef0kZNK9ALHZhlRozkBLOGIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=l3MrNSt2; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5b55eba23c4c11f0813e4fe1310efc19-20250529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID; bh=aOoiOxcK2kOgEKpsrb+lB/8+GYoC6yDyjvcP+th49RY=;
	b=l3MrNSt2Up5544GZVgw6vLJ2GebiZLI0/GImcvSwH0R+2vu9jGZGhotdqB+xAe/BeLAvMydhgBdKeEpxeQ33ZfBF1Trp3HOdR+BUiSxa0aApZ8co/sUVIhCs+UiwqKhxRLpDJPiJqzFnedU4hXDVxNQzvXQot4zrga9pEd4+hTg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:0d9934e9-48da-49b3-b1e6-082f6b80ed65,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:12513c59-eac4-4b21-88a4-d582445d304a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 5b55eba23c4c11f0813e4fe1310efc19-20250529
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <mason-cw.chang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 236733128; Thu, 29 May 2025 13:18:29 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 29 May 2025 13:18:26 +0800
Received: from [10.233.130.16] (10.233.130.16) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1258.39 via Frontend
 Transport; Thu, 29 May 2025 13:18:26 +0800
Message-ID: <f0913ce328a2e501566dc311cf8e6c4539d492d3.camel@mediatek.com>
Subject: Re: Aw: [PATCH 2/3] thermal/drivers/mediatek/lvts_thermal: add lvts
 commands and their sizes to driver data
From: Mason Chang <mason-cw.chang@mediatek.com>
To: Frank Wunderlich <frank-w@public-files.de>, <rafael@kernel.org>,
	<daniel.lezcano@linaro.org>, <rui.zhang@intel.com>, <lukasz.luba@arm.com>,
	<angelogioacchino.delregno@collabora.com>, <nfraprado@collabora.com>,
	<jpanis@baylibre.com>, <npitre@baylibre.com>, <colin.i.king@gmail.com>,
	<u.kleine-koenig@baylibre.com>, <wenst@chromium.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<daniel@makrotopia.org>, <steven.liu@mediatek.com>, <sam.shih@mediatek.com>
Date: Thu, 29 May 2025 13:18:28 +0800
In-Reply-To: <trinity-319df51e-2ff3-42cd-8efd-139fda159824-1748448614514@trinity-msg-rest-gmx-gmx-live-6995845bd-wzmz6>
References: <20250526102659.30225-1-mason-cw.chang@mediatek.com>
	 <20250526102659.30225-3-mason-cw.chang@mediatek.com>
	 <trinity-319df51e-2ff3-42cd-8efd-139fda159824-1748448614514@trinity-msg-rest-gmx-gmx-live-6995845bd-wzmz6>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


Hi Frank,

First of all, thank you for providing the link to the actual issue
case. This issue does not affect all MT7988 ICs. Based on the
information collected from users and production lines, we have found
that about 2% of the ICs show severe temperature anomalies without this
patch.

> Hi Mason,
>=20
> thank you for working on this.
>=20
> I have not yet tested the series, but did not have the issue (which
> should be solved by it) reported [1].
>=20
> So just my thoughts when looking through changes
>=20
> > Gesendet: Montag, 26. Mai 2025 um 12:26
> > Von: "Mason Chang" <mason-cw.chang@mediatek.com>
> > Betreff: [PATCH 2/3] thermal/drivers/mediatek/lvts_thermal: add
> > lvts commands and their sizes to driver data
> >=20
> > Add LVTS commands and their sizes to driver data in preparation for
> > adding different commands.
> >=20
> > Signed-off-by: Mason Chang <mason-cw.chang@mediatek.com>
> > ---
> > =C2=A0drivers/thermal/mediatek/lvts_thermal.c | 65 ++++++++++++++++++++=
-
> > ----
> > =C2=A01 file changed, 52 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/thermal/mediatek/lvts_thermal.c
> > b/drivers/thermal/mediatek/lvts_thermal.c
> > index 7e4f56831..5b7bf29a7 100644
> > --- a/drivers/thermal/mediatek/lvts_thermal.c
> > +++ b/drivers/thermal/mediatek/lvts_thermal.c
> > @@ -96,17 +96,6 @@
> >=20
> > =C2=A0#define LVTS_MINIMUM_THRESHOLD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20000
> >=20
> > -static const u32 default_conn_cmds[] =3D { 0xC103FFFF, 0xC502FF55 };
> > -/*
> > - * Write device mask: 0xC1030000
> > - */
> > -static const u32 default_init_cmds[] =3D {
> > -=C2=A0=C2=A0=C2=A0=C2=A0 0xC1030E01, 0xC1030CFC, 0xC1030A8C, 0xC103098=
D, 0xC10308F1,
> > -=C2=A0=C2=A0=C2=A0=C2=A0 0xC10307A6, 0xC10306B8, 0xC1030500, 0xC103042=
0, 0xC1030300,
> > -=C2=A0=C2=A0=C2=A0=C2=A0 0xC1030030, 0xC10300F6, 0xC1030050, 0xC103006=
0, 0xC10300AC,
> > -=C2=A0=C2=A0=C2=A0=C2=A0 0xC10300FC, 0xC103009D, 0xC10300F1, 0xC10300E=
1
> > -};
>=20
> could you please move this block in part 1 to the position used here
> in v2 to avoid deletion/adding again here?

To clearly separate changes and maintain the principle of minimal
modifications, you can see that in patch [1/3], the functions
lvts_ctrl_connect and lvts_ctrl_initialize call the commands.
Therefore, the commands cannot be moved to the part in patch [2/3].

> Maybe magic numbers can be described a bit?

This is just an initialization sequence, it cannot be adjusted.

> > =C2=A0static int golden_temp =3D LVTS_GOLDEN_TEMP_DEFAULT;
> > =C2=A0static int golden_temp_offset;
> >=20
> ...
> > @@ -1446,6 +1442,17 @@ static int lvts_resume(struct device *dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > =C2=A0}
> >=20
> > +static const u32 default_conn_cmds[] =3D { 0xC103FFFF, 0xC502FF55 };
> > +/*
> > + * Write device mask: 0xC1030000
> > + */
> > +static const u32 default_init_cmds[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 0xC1030E01, 0xC1030CFC, 0xC1030A8C, 0xC103098=
D, 0xC10308F1,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 0xC10307A6, 0xC10306B8, 0xC1030500, 0xC103042=
0, 0xC1030300,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 0xC1030030, 0xC10300F6, 0xC1030050, 0xC103006=
0, 0xC10300AC,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 0xC10300FC, 0xC103009D, 0xC10300F1, 0xC10300E=
1
> > +};
> > +
> > =C2=A0/*
> > =C2=A0 * The MT8186 calibration data is stored as packed 3-byte little-
> > endian
> > =C2=A0 * values using a weird layout that makes sense only when viewed
> > as a 32-bit
> > @@ -1740,7 +1747,11 @@ static const struct lvts_ctrl_data
> > mt8195_lvts_ap_data_ctrl[] =3D {
>                                                                     =20
> regards Frank
>=20
> [1]
> https://urldefense.com/v3/__https://github.com/openwrt/openwrt/pull/18750=
*issuecomment-2877554514__;Iw!!CTRNKA9wMg0ARbw!lVkeuQXjfQ1pWGSvoDCEmf0FEFQq=
qQDEb0ovZ5cSsNiXi7hud5epYUyl9xFjO6U7vukgfBY1Ue_-xJ78F5Qe7rw4UzwJyA$

Thank you for focusing on this issue!

Sincerely
Mason

