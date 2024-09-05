Return-Path: <linux-pm+bounces-13672-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A821696D36E
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 11:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6580A28A25B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 09:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D36194AD9;
	Thu,  5 Sep 2024 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="t2VoHsTM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C19E192B94;
	Thu,  5 Sep 2024 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528881; cv=none; b=MGXmicvQ4QEB8Pk6hQrzAKoiyV+Aw4sv6+tG0JXiUf2Th27diSg5nFgrnIitLzKOPu9qVyORfYM7GimlB9NzYgUcvw4z5uqR1FgF8qAxP9FVJUJAttxTZ7piL0QuRIMcNttnQNLapJoPG5akUbd6MZfWihY9IDvC51SQ8hQ3jkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528881; c=relaxed/simple;
	bh=IkSNWXMT7ELTSE8Xuk7SvHDOSBbMhJFwNUOAwKhQJ/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaCGeCRQQyT5eS2pN3/9vShfWzGn8Uf5giF0K1tUUCjAGh9tsQ0M2AVIcOziFeHrneNRJUg9+8YgnXlExgH5w9XyiF7cYn0TkKySAYMMvSmdBFxF8kaSzewXdeiVbCZPcICzwqcxaFq2Qdy8zqAVU/nTdDvGYfHtUnCvKtbsReA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=t2VoHsTM; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0f7cc0ba6b6a11ef8593d301e5c8a9c0-20240905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4kGH80ordyv20AcZCJJKyTo4JdPjwcej8QohhqZgdvY=;
	b=t2VoHsTMZ4CWxVCvLzLnAlcQ0LFjqwR+TK9nnZcVxLw4efD21oh817RTue6OtnHi9o/R31fDUgx/c0vwAEe7yx51vm11qTFi99yKmkBYkkuJQpPisaduZnyXxtzXso6kNB66BVzFQdpNeTST47vFWmfSx+hm6k3bfVnXN5j3Ylw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:431400ad-4aa8-4d44-9e81-535fac55d622,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:08f03b05-42cd-428b-a1e3-ab5b763cfa17,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:817|102,TC:nil,Content:0|-5,EDM:-3,I
	P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
	,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0f7cc0ba6b6a11ef8593d301e5c8a9c0-20240905
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <yenchia.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 254534137; Thu, 05 Sep 2024 17:34:34 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 5 Sep 2024 02:34:33 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 5 Sep 2024 17:34:33 +0800
From: Yenchia Chen <yenchia.chen@mediatek.com>
To: <gregkh@linuxfoundation.org>
CC: <angelogioacchino.delregno@collabora.com>, <len.brown@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<matthias.bgg@gmail.com>, <pavel@ucw.cz>, <rafael.j.wysocki@intel.com>,
	<rafael@kernel.org>, <stable@vger.kernel.org>, <yenchia.chen@mediatek.com>
Subject: Re: [PATCH 6.6 1/1] PM: sleep: Restore asynchronous device resume optimization
Date: Thu, 5 Sep 2024 17:34:33 +0800
Message-ID: <20240905093433.4798-1-yenchia.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <2024090420-protozoan-clench-cca7@gregkh>
References: <2024090420-protozoan-clench-cca7@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

>> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>> 
>> commit 3e999770ac1c7c31a70685dd5b88e89473509e9c upstream.
>> 
>> Before commit 7839d0078e0d ("PM: sleep: Fix possible deadlocks in core
>> system-wide PM code"), the resume of devices that were allowed to resume
>> asynchronously was scheduled before starting the resume of the other
>> devices, so the former did not have to wait for the latter unless
>> functional dependencies were present.
>> 
>> Commit 7839d0078e0d removed that optimization in order to address a
>> correctness issue, but it can be restored with the help of a new device
>> power management flag, so do that now.
>> 
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
>> Signed-off-by: Yenchia Chen <yenchia.chen@mediatek.com>
>> ---
>>  drivers/base/power/main.c | 117 +++++++++++++++++++++-----------------
>>  include/linux/pm.h        |   1 +
>>  2 files changed, 65 insertions(+), 53 deletions(-)

>Why does this need to be backported?  What bug is it fixing?

>confused,

>greg k-h

Below is the scenario we met the issue:
1) use command 'echo 3 > /proc/sys/vm/drop_caches'
   and enter suspending stage immediately.
2) power on device, our driver try to read mmc after leaving resume callback
   and got stucked.

We found if we did not drop caches, mmc_blk_resume will be called and
system works fine.

If we drop caches before suspending, there is a high possibility that
mmc_blk_resume not be called and our driver stucked at filp_open.

We still try to find the root casue is but with this patch, it works.

Since it has been merged in mainline, we'd like to know it is ok to merge to stable.


