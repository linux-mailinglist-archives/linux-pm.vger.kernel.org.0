Return-Path: <linux-pm+bounces-22063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281F2A35817
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 08:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBAC516E47F
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 07:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36550215066;
	Fri, 14 Feb 2025 07:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ecd7kKub"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12218FDDB;
	Fri, 14 Feb 2025 07:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739519041; cv=none; b=LhVCmqBwtb9XY/aSJWkUiFXTC0AQerVoHsDwactsp67ra6joUBROpK4C2IYgyNONUvat7J9SdPDuPC4KCtMxkUgoUEjZGuok3WFfEy8wUst7SkQ8l+r/Ad6LX2+Lpazh1j8WDntuzeoUsUyp/Kn1nSO/JKXaRYBXfaOH+bVmkYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739519041; c=relaxed/simple;
	bh=b8HNaR6eRB7BIUa8iKDnODGnEiZ06Ts4TRfNu+PZhRM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kDYXBwsOMDBSaYe56034Kv6RZjUcRSvjyO45arxqupLoq92zmLfAx1SX4C6Gor2dD1qYTcfB1XUVJSFXIxEi9d4LrXHMicsK6EqkeTUT3Ou5lduo/MJnTg8Z6SPG3mlo5WfIw7FzZ79iG4yof0ayBGIDoU/POQYrbHJknT0vL18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ecd7kKub; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 70dd3e2ceaa711efbd192953cf12861f-20250214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qnkcrqEZZ2EzdS7FFRlXKuqzpa+542JwGGqoElF5Pm8=;
	b=Ecd7kKubJaXmx2p9h6OGB3azuIGoDI4uAv7AIFmRWwW3Fjf2mxwUxxkcXGhfG5kptGaXq5sZDSHQKZKT01ulk8xPjQ5Qe3XJytxwD8SMaFfrWagG07tMIgkE5obAUP7fUEWwCKBAh1CQiHq0YgS34tJQLqqLr0cLCZdGxT2/iEg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:2634a7a6-041d-40f2-ba67-69a22f54d2cb,IP:0,U
	RL:0,TC:0,Content:21,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:21
X-CID-META: VersionHash:60aa074,CLOUDID:91ce56fc-7800-43c5-b97b-ddbe32561a5b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 70dd3e2ceaa711efbd192953cf12861f-20250214
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <chun-jen.tseng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1257582152; Fri, 14 Feb 2025 15:43:54 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Feb 2025 15:43:53 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Feb 2025 15:43:53 +0800
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
Subject: [PATCH v3 0/3] fixed mediatek-cpufreq has multi policy concurrency issue
Date: Fri, 14 Feb 2025 15:43:31 +0800
Message-ID: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

For multi cluster SoC, the cpufreq->target_index() is re-enter function
for each policy to change CPU frequency. In the cirtical session must
use glocal mutex lock to avoid get wrong OPP.

Changes since v2:
	  - seperate more patch for detail change.
	  - remove CCI transition_delay patch

Mark Tseng (3):
  cpufreq: mediatek: using global lock avoid race condition
  cpufreq: mediatek: Add CPUFREQ_ASYNC_NOTIFICATION flag
  cpufreq: mediatek: data safety protect

 drivers/cpufreq/mediatek-cpufreq.c | 63 ++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 17 deletions(-)

-- 
2.45.2


