Return-Path: <linux-pm+bounces-13327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B6D968301
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 11:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8761F22880
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 09:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCCC1C2DBD;
	Mon,  2 Sep 2024 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cJKZVsM9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59261C2DB3;
	Mon,  2 Sep 2024 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268893; cv=none; b=OVQG2fRWsMthsJSfeumhrO/XbeKxK1IkmzA0CbcOyLU8xLI1B0aNhSNd1QWmTEkayVpZXyOO5fUEqbK1Y5XydPblkHJ7IcXLcQdraAaQlrvgG6GuyHWVzubNSjYFKtL0uB08n68IKQucH6jT+xmwbSaw9UzewUryr9SOIKrL5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268893; c=relaxed/simple;
	bh=4oGHD2UiJxI8f66x4TrkRtiznhG3g5NXt0ulddIBRGk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h8iTegF6lCPH5YzA6mXIM2N7kjkQj7iebJAfwOo1gyxIOiJUA5cCMSqBsgN8qo5F67LI1rEP81UCCOYeCeZjBX0EI8lCiavx0Okx79Ht36twPGLs19Cpf6WdZPUH7U5WerWlO5lyiyN+lxSlrW0tezgIAUZukDLLKZK0kXiPIYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cJKZVsM9; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b8904d12690c11ef8593d301e5c8a9c0-20240902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xMzH3qhRngUXHdpYWln6cgACFVJGt1ZJWn8uMS7Y4Vo=;
	b=cJKZVsM92DDk0Fj/NaudsLL2S2O/Tu4KDoC2AURBfNiQWLsFOQ2DyhZSKygyt5WriRMWsZxuB/Ln+zu8S6OOMqZDSj6fz4YULL9+fY3c0CAQ8c0mTT5WIT4S9psj5L+UAxVa4YbH+S1x+WJZi68gLUvoHz++6I7EMDnxOe2WUiM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:3bc820f3-073c-41fe-9fef-d2168c3e9f40,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:199b4fbf-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b8904d12690c11ef8593d301e5c8a9c0-20240902
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <yenchia.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1972345126; Mon, 02 Sep 2024 17:21:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 2 Sep 2024 17:21:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 2 Sep 2024 17:21:23 +0800
From: Yenchia Chen <yenchia.chen@mediatek.com>
To: <stable@vger.kernel.org>
CC: Yenchia Chen <yenchia.chen@mediatek.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown
	<len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH 6.1 0/1] pm, restore async device resume optimization
Date: Mon, 2 Sep 2024 17:21:19 +0800
Message-ID: <20240902092121.16369-1-yenchia.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

We have met a deadlock issue on our device which use 5.15.y when resuming.
After applying this patch which is picked from mainline, issue solved.
Backport to 6.1.y also.

Rafael J. Wysocki (1):
  PM: sleep: Restore asynchronous device resume optimization

 drivers/base/power/main.c | 117 +++++++++++++++++++++-----------------
 include/linux/pm.h        |   1 +
 2 files changed, 65 insertions(+), 53 deletions(-)

-- 
2.18.0


