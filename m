Return-Path: <linux-pm+bounces-27647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4749FAC3DD8
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 12:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08370171852
	for <lists+linux-pm@lfdr.de>; Mon, 26 May 2025 10:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687AB1F4C85;
	Mon, 26 May 2025 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Y81Efuj7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84711C3BFC;
	Mon, 26 May 2025 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748255350; cv=none; b=UP7WAsNgeMmbR1CZLXYQe8eceV7ZHWNoxm4VPm+vJJcX2M8axSJAgeiSitQo+rkxr94BVmADEarakqAKW/0tssUT9C34Tf1ZzWkF1Zh39nJpT8iSbOl4ZycCH7Je5i4La3z7aNkpBlr5mnJER6fle+PP6fq+8G+q3HtooehDSqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748255350; c=relaxed/simple;
	bh=dZOAvYOewadzcPcnvWUn/AR8zt4RFBd2FLaurgPflTE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=itc19ceMzsh9o4qGdKTr1QOMDlgGxPFrlOAlpMUTIo0X5hHhD3UyFcny8x6Ib9hubaGJZnWSTa6CZkWSvhQ2NvaeOr4VJiVZJ+RtL23RLTYqoO7dQ3wn4NEpF9FZpJ0H92QCQliD4QMg1Luw+Gx5JoxKNIkHnzBbpUchLSVOF2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Y81Efuj7; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3f096b223a1c11f0813e4fe1310efc19-20250526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GAsd9eNeTAxwTsjxWBsXwdLIVBhMhnuoasv/118TESw=;
	b=Y81Efuj7ph0c55XAV2JEUAxkpG08fbsWoyqMcJ6uSQdpiYmlS5w7qbPoaJDQaM6igZjwDjEDWa+fnP4yJbEBBJyQTOCNz80b38G4VwNV9We8UlfnPWB7g2jSJlD5Cyo8F7JD984tgcW8VW9kLnUp4Mz4spa6cta7Ie3xi8uI+1Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:35b8a956-95bf-49e7-8a5a-717c8956de20,IP:0,UR
	L:0,TC:0,Content:56,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:26
X-CID-META: VersionHash:0ef645f,CLOUDID:e225fc57-abad-4ac2-9923-3af0a8a9a079,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:3|50,EDM:2,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3f096b223a1c11f0813e4fe1310efc19-20250526
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <mason-cw.chang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1944595671; Mon, 26 May 2025 18:29:03 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 26 May 2025 18:28:59 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 26 May 2025 18:28:59 +0800
From: Mason Chang <mason-cw.chang@mediatek.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
	<nfraprado@collabora.com>, Julien Panis <jpanis@baylibre.com>, Nicolas Pitre
	<npitre@baylibre.com>, Colin Ian King <colin.i.king@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Chen-Yu
 Tsai <wenst@chromium.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Frank Wunderlich
	<frank-w@public-files.de>, Daniel Golle <daniel@makrotopia.org>, Steven Liu
	<steven.liu@mediatek.com>, Sam Shih <sam.shih@mediatek.com>
CC: Mason Chang <mason-cw.chang@mediatek.com>
Subject: [PATCH 0/3] thermal/drivers/mediatek/lvts_thermal: add mt7988 lvts commands
Date: Mon, 26 May 2025 18:26:56 +0800
Message-ID: <20250526102659.30225-1-mason-cw.chang@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add the LVTS commands for Mediatek Filogic 880/MT7988.

This series fixes severely abnormal and inaccurate LVTS temperature
readings when using the default commands.

Signed-off-by: Mason Chang <mason-cw.chang@mediatek.com>

Mason Chang (3):
  thermal/drivers/mediatek/lvts_thermal: change lvts commands array to
    static const
  thermal/drivers/mediatek/lvts_thermal: add lvts commands and their
    sizes to driver data
  thermal/drivers/mediatek/lvts_thermal: add mt7988 lvts commands

 drivers/thermal/mediatek/lvts_thermal.c | 74 ++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 13 deletions(-)

-- 
2.45.2


