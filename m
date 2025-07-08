Return-Path: <linux-pm+bounces-30362-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88605AFC9EF
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 13:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57BA3B444F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jul 2025 11:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516282D9EDF;
	Tue,  8 Jul 2025 11:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PlWXGtci"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5468927D776;
	Tue,  8 Jul 2025 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751975827; cv=none; b=GNBFrfNNxiMYXNR6XB2uPcDqsvCINZ+GCkiiq88I8UR4XvL0N5QHxlV+GZSolxSv+3Li4pKWBpmuUGmuUCIp5dGcScpd56b9ih2UPv6AMckWzst/5BbXSHCpHtRX0I1X3mSkUhzCR3d4GGAU0cRx7LwYps1u1lkbCiUluIVzbMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751975827; c=relaxed/simple;
	bh=lHQ0tvNoqJ2yord/lFVua7QgHw4bt6G06+wkrQtEyBg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ge3JlJ95Ynq0bGv0pdwGjaGSBE49JsymhSoS6Erw4FQlXnm+Jo5M5UYjgMpAsweCScqhQSO7KqtgjV+x7vlSoCJyIf4wM5ja266ijFDnSVNKjku2YInR6+3QRGCtGOjAWGgL5sT0GvHBLYpcRYx4WeIwFjk6zw0daL94UCshpKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PlWXGtci; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a55fea025bf211f0b1510d84776b8c0b-20250708
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID; bh=lHQ0tvNoqJ2yord/lFVua7QgHw4bt6G06+wkrQtEyBg=;
	b=PlWXGtciKBwCtq6tLTILEx8s1pdXfCY+cB8GMT1V6HaIzP7gOt3d6v3m7AwnEDIu5ggyzLtol/z4TH2CVI95o6u4PH1Ix6qwQ2TwVfqrUHVm4dhidnuUCtRo/0RhoEKSlXPdhMgKJVsS/4TPVUJiTILYoP9U9UNtMxS8JuN6C90=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:9a31a16a-a100-42f2-9aeb-8d433d1d66e2,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:33aefbd7-b768-4ffb-8a44-cd8427608ba6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a55fea025bf211f0b1510d84776b8c0b-20250708
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <mason-cw.chang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1382983593; Tue, 08 Jul 2025 19:56:56 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 8 Jul 2025 19:56:54 +0800
Received: from [10.233.130.16] (10.233.130.16) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1258.39 via Frontend
 Transport; Tue, 8 Jul 2025 19:56:54 +0800
Message-ID: <b014c34a560854e6dd6a6dd483b9443f42252b51.camel@mediatek.com>
Subject: Re: Aw: [PATCH 0/3] thermal/drivers/mediatek/lvts_thermal: add
 mt7988 lvts commands
From: Mason Chang <mason-cw.chang@mediatek.com>
To: "rafael@kernel.org" <rafael@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Nicolas Prado
	<nfraprado@collabora.com>, "jpanis@baylibre.com" <jpanis@baylibre.com>,
	"npitre@baylibre.com" <npitre@baylibre.com>, "colin.i.king@gmail.com"
	<colin.i.king@gmail.com>, "u.kleine-koenig@baylibre.com"
	<u.kleine-koenig@baylibre.com>, "wenst@chromium.org" <wenst@chromium.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, Frank Wunderlich <frank-w@public-files.de>, Steven
 Liu =?UTF-8?Q?=28=E5=8A=89=E4=BA=BA=E8=B1=AA=29?= <steven.liu@mediatek.com>,
	Sam Shih =?UTF-8?Q?=28=E5=8F=B2=E7=A2=A9=E4=B8=89=29?=
	<Sam.Shih@mediatek.com>
Date: Tue, 8 Jul 2025 19:56:54 +0800
In-Reply-To: <trinity-e9eaf8fd-42f1-46d5-b1df-3bfefe02b2fe-1750057280436@trinity-msg-rest-gmx-gmx-live-b647dc579-tr2th>
References: <20250526102659.30225-1-mason-cw.chang@mediatek.com>
	 <trinity-e9eaf8fd-42f1-46d5-b1df-3bfefe02b2fe-1750057280436@trinity-msg-rest-gmx-gmx-live-b647dc579-tr2th>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-06-16 at 07:01 +0000, Frank Wunderlich wrote:
>=20
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
>=20
>=20
> > Gesendet: Montag, 26. Mai 2025 um 12:26
> > Von: "Mason Chang" <mason-cw.chang@mediatek.com>
> > Betreff: [PATCH 0/3] thermal/drivers/mediatek/lvts_thermal: add
> > mt7988 lvts commands
> >=20
> > Add the LVTS commands for Mediatek Filogic 880/MT7988.
> >=20
> > This series fixes severely abnormal and inaccurate LVTS temperature
> > readings when using the default commands.
> >=20
> > Signed-off-by: Mason Chang <mason-cw.chang@mediatek.com>
>=20
> Hi
>=20
> just a friedly reminder for maintainers, is the patch series ok or
> does it need any changes?
>=20
> regards Frank

Hi all,

I submitted the patch a while ago, but haven't received any response
from the maintainer yet. I would really appreciate it if any maintainer
could take a look or provide some comments.

If there is a more appropriate maintainer or reviewer for this patch,
please kindly let me know or help forward it.

Thank you very much for your time and help!

Sincerely,
Mason


