Return-Path: <linux-pm+bounces-17175-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93CB9C1688
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 07:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E77728399C
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 06:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455D31D1506;
	Fri,  8 Nov 2024 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KftSXk+a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595AE1CF7C2;
	Fri,  8 Nov 2024 06:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731047998; cv=none; b=NEs/asYetM0xosUKpTPz41Lo7rdcIiezDeOhSVpMO9UOpEXNcXqIGLate12v8o8Px33fCQvrAS68V3rDXnkZ3Z69h9a/8z2lzTNodQrUS8EGyJ/WbLNsUWBLJ8zIjbZh67iL7w+lNeEmeBqMdj6jiOybrZSRbezT2EZaas2Bj+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731047998; c=relaxed/simple;
	bh=gbHnufe999eo+EnZ6ZuFXyzrAj3WzYMOcpbS9pTQA3E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nPHhxj+07qYO+GoHparxIIouPv8tTj+xKc2to5laaJXP13Gbvkgnm/zbFVRvpNWxgWDmTAo59+ke2jfrdXT9jQqnPvOCPd1Cvyexf/hW2/od1E/tOj886aTy79s82OUnSPLWhWzEH/Za0mAVZu815EddQLom1/DqZUEeB+AJY3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=KftSXk+a; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 41e994109d9c11efbd192953cf12861f-20241108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=AH5dye9ghuwYd4dunHk1XwO4UAJNi7Gix6OZFCVkEOI=;
	b=KftSXk+avEMIqZ7JVtqWXS5KpbUCcBfwPKaYuC+TXVkDFK+LGxnJhcCjeFGiEqSUK0i3nGM56azYnOn3mftygov2EUcvVrpMI+DRKmT36IP3BzKdcQl0V9k5/5gt+h0wu1VR7q8JFiTPv8G3FUr3XmbDTTEcCQnCJ0KuyKmR8As=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:1b82c792-a09f-48ec-9168-ced1a7e93cab,IP:0,U
	RL:0,TC:0,Content:15,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-META: VersionHash:b0fcdc3,CLOUDID:7b45c106-6ce0-4172-9755-bd2287e50583,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 41e994109d9c11efbd192953cf12861f-20241108
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <chun-jen.tseng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2028501650; Fri, 08 Nov 2024 14:39:51 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Nov 2024 14:39:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 8 Nov 2024 14:39:48 +0800
From: Mark Tseng <chun-jen.tseng@mediatek.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, "Kyungmin
 Park" <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<chun-jen.tseng@mediatek.com>
Subject: [PATCH v2 0/4] fixed mediatek-cpufreq has multi policy concurrency issue
Date: Fri, 8 Nov 2024 14:39:38 +0800
Message-ID: <20241108063942.19744-1-chun-jen.tseng@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-1.112600-8.000000
X-TMASE-MatchedRID: r9EX/Oe9GqVP6qceA7YxicAmcZEx8XHJN/BTU5ZfZRLD3h2nmZ4BQf2o
	7vT7HSck6P2jQ8ymte/03yRiZxUSQaHtjelygRNaXP5rFAucBUFf6HjaRmqhcER4KzyzRoZGo8W
	MkQWv6iUoTQl7wNH8Pg1fA1QHegDv3QfwsVk0UbswamAE0joFo9Oz+1d0RpMCupiSwmVg/KvnLl
	qusi4ZPmCf5VV9gOCSFKrPn74+giS9bKqTrUhoWufHX8G+0nRv4SJOyqFUkYZNCuhRTC+mgoCE5
	xpCtDRTUbJFyh4XXyqYo/TPOlMB4bCh3zE4wqa8YGNVOdPa5Cp+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-1.112600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5CE8E81E46AFE4466AC0C9543F8E5EB27426992430BDDCD519A671E26ABBF8582000:8

For multi cluster SoC, the cpufreq->target_index() is re-enter function
for each policy to change CPU frequency. In the cirtical session must
use glocal mutex lock to avoid get wrong OPP.

Changes since v1:
	  - seperate more patch for detail change.

Mark Tseng (4):
  cpufreq: mediatek: CCI support SoC , the transition_delay set to 10 ms
  cpufreq: mediatek: using global lock avoid race condition
  cpufreq: mediatek: Add CPUFREQ_ASYNC_NOTIFICATION flag
  cpufreq: mediatek: data safety protect

 drivers/cpufreq/mediatek-cpufreq.c | 65 ++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 16 deletions(-)

-- 
2.45.2


