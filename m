Return-Path: <linux-pm+bounces-39553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03445CBDCD8
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 13:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8076301F257
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 12:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E871B4F09;
	Mon, 15 Dec 2025 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XpD3toFO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D615C38DD3;
	Mon, 15 Dec 2025 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765801327; cv=none; b=WrSVBikDKQ2Jgt/9T5B67wpUuhnjCTLNqRFzejQIndh9gvIdf/qIecJW115/Q1eijduqZeO8jufw/NWdeRJGDOpvKmHyYHH97oNx0ltVIgG73n1z33heqF93vkwGRHgDJxqFdZDt4aWFB7yj1CrkZL6xM73Shqu1Cqcadj1sfY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765801327; c=relaxed/simple;
	bh=L3gf3MXBtGQUkR/+iiXHdOigP7GU4a+j+hN4NWr+HXE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DuBKy6WPHd4Fyuqvo+ptdLHLT/HPbuG/MjwEpN34SqKuNZPMUfwDN5ocfcBZxstFYw0kQTOjcswThp2vZDQruvT+axVTzW+jc1v+xIi8X7lqPGda9pNE3bdUlflr4wwV1SdkFPh+ktMeZjLmmL/ProN9hzs9Kp4h/QhssvONZ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XpD3toFO; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a7b0d942d9b011f0b2bf0b349165d6e0-20251215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qa/Vn79sYc/2vpTEh8B+lsrkZfuYz71JIBQPlwooPhc=;
	b=XpD3toFO5bN5TlyGuWrok+W1ZUkSrP5q8DnWwmmfAgMI/CwQRiricRBjekECrs98U5HJE7oiqGN251uG9E6n2Mzf8lfmfOWqDDHv8bVyfLFEq5AGKmO0U2zrpOYCBtgvC85vs7O9TaEzAaPAgT+uHfOYLmsRxVqnzgRcmfVJtBs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:a1ce0f2c-3197-40fb-a8e4-76915a0a9703,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:ec168a28-e3a2-4f78-a442-8c73c4eb9e9d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|123|836|888|898,TC:-5,Content:0|
	15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a7b0d942d9b011f0b2bf0b349165d6e0-20251215
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ed.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 928191090; Mon, 15 Dec 2025 20:21:59 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 20:21:58 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 20:21:58 +0800
From: <ed.tsai@mediatek.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<chun-hung.wu@mediatek.com>, <freddy.shin@mediatek.com>, Ed Tsai
	<ed.tsai@mediatek.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	<linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/1] PM: runtime: fix bitfield race of needs_force_resume
Date: Mon, 15 Dec 2025 20:21:42 +0800
Message-ID: <20251215122154.3180001-1-ed.tsai@mediatek.com>
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

From: Ed Tsai <ed.tsai@mediatek.com>

needs_force_resume is a bitfield member in struct dev_pm_info and must
be accessed under the same lock as its bitfield group.

A real concurrent write was observed between needs_force_resume and
idle_notification; stacks below:

write needs_force_resume:
  pm_runtime_reinit+0x110/0x360
  really_probe+0xe0/0x464
  __driver_probe_device+0x9c/0x104
  driver_probe_device+0x3c/0x1a8
  __device_attach_driver+0x100/0x17c
  bus_for_each_drv+0x10c/0x168
  __device_attach_async_helper+0x7c/0xf4
  async_run_entry_fn+0x4c/0x1b4
  process_scheduled_works+0x1dc/0x498
  worker_thread+0x220/0x320
  kthread+0x150/0x27c
  ret_from_fork+0x10/0x20

write idle_notification:
  rpm_idle+0x464/0x5f8
  __pm_runtime_idle+0x7c/0x170
  scsi_autopm_put_device+0x18/0x28
  scsi_sysfs_add_sdev+0x1a0/0x1d8
  scsi_probe_and_add_lun+0xbd8/0xcd0
  __scsi_add_device+0xb8/0x11c
  ufshcd_async_scan+0xb4/0x3a4
  async_run_entry_fn+0x4c/0x1b4
  process_scheduled_works+0x1dc/0x498
  worker_thread+0x220/0x320
  kthread+0x150/0x27c
  ret_from_fork+0x10/0x20

Fixes: 89d9cec3b1e9 ("PM: runtime: Clear power.needs_force_resume in pm_runtime_reinit()")
Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
---
 drivers/base/power/runtime.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 84676cc24221..3328543b1ed8 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1879,11 +1879,22 @@ void pm_runtime_reinit(struct device *dev)
 				pm_runtime_put(dev->parent);
 		}
 	}
+
 	/*
 	 * Clear power.needs_force_resume in case it has been set by
 	 * pm_runtime_force_suspend() invoked from a driver remove callback.
 	 */
+	if (dev->power.irq_safe)
+		spin_lock(&dev->power.lock);
+	else
+		spin_lock_irq(&dev->power.lock);
+
 	dev->power.needs_force_resume = false;
+
+	if (dev->power.irq_safe)
+		spin_unlock(&dev->power.lock);
+	else
+		spin_unlock_irq(&dev->power.lock);
 }
 
 /**
-- 
2.45.2


