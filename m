Return-Path: <linux-pm+bounces-13334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 567C196834C
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 11:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D991C225C3
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 09:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339FC1D1F7A;
	Mon,  2 Sep 2024 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="I7CG6e0k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD2917BEB2;
	Mon,  2 Sep 2024 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269579; cv=none; b=ufEEQvYD5vTLgforBDkd3OZu1HfKaQ+4jXJylLNIKP0Bg4KTVSXnd25RQ6yvv5rZXjgGx2KDwd0fUnSPmxeeF6NFF1T5n2kehyJhd9M3sDlyF5px/KkKZdWZL4nUl7N4emvHNv+NdYWXLopQQJG1g3hIu2B6F2QGCEVsMxkzhHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269579; c=relaxed/simple;
	bh=QjJKqE2geFBgrfARoVt9yA1FFwK5u8v3ANqDqDMOv/A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UCvf0/pxGZQYYwUfRwGAEGm9gOzcn6tPG6m4SjQ8w+N2LbXaDCJ7OnUuZqf49VDGB6P/TDqKQcaYvDT/BM1IRTuu9j/xDvCqzcG6uMzGSbcf/OcdHeRQBW/zqPk1FEBr9LzW3R11D4CmsM8sfECRIyJrvbiKff9NUnRhKCzpoF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=I7CG6e0k; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 527c538e690e11ef8593d301e5c8a9c0-20240902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=i0kqKgN7CJvd0BeYNnJy0G3k1/9Gmrex+aORwHnQoQU=;
	b=I7CG6e0ktwICWEVW+qJ8oSKi0d8Ucb46CVf87q04ItLyQHe8E/1LPha3ONypyF0otKdMRxluUdM5ouNrMPy1GlFzOfKKIJoeWfX+KoFAUuEMV3EV/o88xewld8yYfzzjpyTLaKt0I30S81saHLIWBzP1e3ILylSNeRe9cyCXyd4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:7402f471-3f2b-4328-ab56-48d0036f8043,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:76c94fbf-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 527c538e690e11ef8593d301e5c8a9c0-20240902
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <yenchia.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 243078402; Mon, 02 Sep 2024 17:32:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 2 Sep 2024 17:32:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 2 Sep 2024 17:32:51 +0800
From: Yenchia Chen <yenchia.chen@mediatek.com>
To: <stable@vger.kernel.org>
CC: Yenchia Chen <yenchia.chen@mediatek.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown
	<len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH 6.6 0/1] pm, restore async device resume optimization
Date: Mon, 2 Sep 2024 17:32:47 +0800
Message-ID: <20240902093249.17275-1-yenchia.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.721600-8.000000
X-TMASE-MatchedRID: NKO9ekWIDjZNfAuy6MOHARWCVBr+Ay98UAjrAJWsTe+CsBeCv8CM/WoY
	8jnT5UNAdvMDsdlFTfx1VOt17I0Spc3AmdtMjGJVngIgpj8eDcAZ1CdBJOsoY9mzcdRxL+xwKra
	uXd3MZDWuikCL8VXXTHd9H3D4g3TAjOdC04VQHm0AQifLWGK23xTY0YxG1fFWyfZaWEB2dsF0BN
	B20+SxH7f8mJY57oZddJaBDYald1lvF9+X2GEIHA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.721600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	01B788881749FE3475082A6EE46C935325F93AB08D3EA507A3A6E8672CEA022C2000:8

We have met a deadlock issue on our device which use 5.15.y when resuming.
After applying this patch which is picked from mainline, issue solved.
Backport to 6.6.y also.

Rafael J. Wysocki (1):
  PM: sleep: Restore asynchronous device resume optimization

 drivers/base/power/main.c | 117 +++++++++++++++++++++-----------------
 include/linux/pm.h        |   1 +
 2 files changed, 65 insertions(+), 53 deletions(-)

-- 
2.18.0


