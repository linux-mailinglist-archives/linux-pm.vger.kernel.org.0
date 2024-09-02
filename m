Return-Path: <linux-pm+bounces-13311-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68EA967E11
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 05:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49531B22A8B
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 03:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EE43A1C9;
	Mon,  2 Sep 2024 03:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jDQkMdQc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB66479C0;
	Mon,  2 Sep 2024 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725246673; cv=none; b=YIi9E82p68XN5QbqzRyennMqqpNmOrqjKTvqu1krFvWudgtaUwRUQmhQNgI9xWu5OUUWpjdAsr3t+15Vb/2ZtKybauK95exvrHkuSq4KTjAgb4oeyRqV9sVCPwE8A6JeFIZTN1C94jF4mWrda56riVvzg6CY3PrvyB1evc7u2Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725246673; c=relaxed/simple;
	bh=hMAhG4HQfZuE2iWAvAPKvQciL3MaBKed+Mk9j5o2opw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M8Mw5cz8rM1Myu6v1Neo9l3uKVLaIU9N92ajf7PRsOL2qX/dANPfJXFz8mE8pgDzZi5xxcyPrV7YkC//eJ9q4Tduajhmhj3hB+56D2L7BSJlYEZ43mFg8NauUhalbN9LpaglS2tP9APLKBfd5MnrEIVzOK2M9Ezw8lO//tdsNsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jDQkMdQc; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f9bc208868d811ef8593d301e5c8a9c0-20240902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=2nK5QbU5dkc5U5TwQYN/wO/nlEp/eum7zig0Mq8CzQA=;
	b=jDQkMdQcGG2LNgty19i+pWnsKbV1A91GCIS1UN5ZZgAX/rql+fuKVibbSDjkun4wt9xMwISmNe8niwEV2AErE1RzJTheMyQ1y1/0I1sdcLNNig5UbEu9BejYtyEvkbCHJnFJ3Hpllwn0bvqIOqxOLLdD/ZLHDpfGlBrK+mo1OSw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:8250548f-e42f-44b3-a2cc-6767e3472b09,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:56a849bf-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f9bc208868d811ef8593d301e5c8a9c0-20240902
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <yenchia.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 109499073; Mon, 02 Sep 2024 11:10:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 2 Sep 2024 11:10:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 2 Sep 2024 11:10:55 +0800
From: Yenchia Chen <yenchia.chen@mediatek.com>
To: <stable@vger.kernel.org>
CC: yenchia.chen <yenchia.chen@mediatek.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown
	<len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH 5.15 0/1] pm, restore async device resume optimization
Date: Mon, 2 Sep 2024 11:10:44 +0800
Message-ID: <20240902031047.9865-1-yenchia.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.129900-8.000000
X-TMASE-MatchedRID: JLcFkSgMIWN2Rany8ZWn3tOEZs/2oH3cCt59Uh3p/NWCsBeCv8CM/WAd
	cSpevRjQiHW59WKjt/cKqKe3zUn9YqPoJzzb7KzWhK8o4aoss8pKPIx+MJF9o5soi2XrUn/J8m+
	hzBStanvCLNfu05PakAtuKBGekqUpOlxBO2IcOBbEyMTWd4/m6PO/B9+EIe5KemHOHsKuv6TiRL
	HA99IRmBkGY5qDZgwhHFrKplBIbYwx59TrzsqD5L8cT6DUrvrGOPVhQvN7rWbBkGBTIlURuXoXD
	z8+lMxFpW+aIDJ4DaRzkxJ+SIkUjmncuUSUEdOX
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.129900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 3C10582E582375B77A6D1BA0557EB6A54834D49EE7523CB6CA1E816963D448C32000:8

From: "yenchia.chen" <yenchia.chen@mediatek.com>

We have met a deadlock issue on our device when resuming.
After applying this patch which is picked from mainline, issue solved.
We'd like to backport to 5.15.y and could you help to review? thanks.

[ Upstream commit 3e999770ac1c7c31a70685dd5b88e89473509e9c ]

Rafael J. Wysocki (1):
  PM: sleep: Restore asynchronous device resume optimization

 drivers/base/power/main.c | 117 +++++++++++++++++++++-----------------
 include/linux/pm.h        |   1 +
 2 files changed, 65 insertions(+), 53 deletions(-)

-- 
2.18.0


