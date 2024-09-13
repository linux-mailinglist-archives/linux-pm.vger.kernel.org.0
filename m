Return-Path: <linux-pm+bounces-14135-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57285977DD7
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 12:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1B61F20F25
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 10:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C961D86E4;
	Fri, 13 Sep 2024 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IPg5vfzM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BCC1D86DE;
	Fri, 13 Sep 2024 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223987; cv=none; b=KbzCHomZ54dTSr0caVe5E3G9x7HvdnNsyAdiq83eS+N8sKrcgV6FHp+IlHDHzHRlPyXgikWBAMebz96OytR9xq+otDwIWECRcHMlXDAi3TB5n1xAmrmK23Q9u3dKdZRbu4NWrmbOkS4c1tkf5SWs1cJEIIQCg2WVix4qC1Qjniw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223987; c=relaxed/simple;
	bh=X2DjAoiHpajHutur2yyr2h73UAP9b/1c+tj3fIstVGw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r/rOyScKFceLKRhKs3uEJu/eu4XKTsP7NiNcepk/gU2meIfJW5M/0uoF+eoiUssjY7BVIDYIP+7kt4TQYvPSfeSGGyoSocDpX9ajAcbUiZcfAFofULycm7CgAHeKndfEAh0YFFCWcqZ2R3gzK2cburQK7Bp+5/OasHmRcG89dP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IPg5vfzM; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7a0ef66671bc11ef8b96093e013ec31c-20240913
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=L/SYtEbl/61399Qh+bHxFsGQAy9IhdUiQzlwegY6SMo=;
	b=IPg5vfzMD5NUoaQMvGTgr+d9pIMoZnhd0N3aaLyAG0dYMWe1x5ZoP/zn3+oXqsm16SdqxhC4LFeDZfybUvK7jnNDH0NxBFgNT2NpqEkFr8Z0+LSmvI05/wGF246GVAh33zNzRB+Whu8QxsGG/NGgftLhIoKRBojqkRTaos2nPp8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:cf55a4b8-e325-4ac6-8b7c-a2517bc4388f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:c9f0ebbf-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7a0ef66671bc11ef8b96093e013ec31c-20240913
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <chun-jen.tseng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 943353095; Fri, 13 Sep 2024 18:39:38 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Sep 2024 03:39:37 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Sep 2024 18:39:37 +0800
From: Mark Tseng <chun-jen.tseng@mediatek.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin
 Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<chun-jen.tseng@mediatek.com>
Subject: [PATCH v1 0/2] fixed mediatek-cpufreq has multi policy concurrency issue
Date: Fri, 13 Sep 2024 18:39:31 +0800
Message-ID: <20240913103933.30895-1-chun-jen.tseng@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

For multi cluster SoC, the cpufreq->target_index() is re-enter function 
for each policy to change CPU frequency. In the cirtical session must 
use glocal mutex lock to avoid get wrong OPP.

Mark Tseng (2):
  PM / devfreq: mediatek: protect oop in critical session
  cpufreq: mediatek: Fixed cpufreq has 2 policy will cause concurrency

 drivers/cpufreq/mediatek-cpufreq.c | 65 ++++++++++++++++++++++--------
 drivers/devfreq/mtk-cci-devfreq.c  | 30 +++++++-------
 2 files changed, 64 insertions(+), 31 deletions(-)

-- 
2.45.2


