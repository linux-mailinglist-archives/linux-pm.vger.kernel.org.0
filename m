Return-Path: <linux-pm+bounces-16334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164849AD9FE
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 04:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B773B2240C
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 02:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D2D14B07A;
	Thu, 24 Oct 2024 02:41:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D69155393;
	Thu, 24 Oct 2024 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729737668; cv=none; b=R6NzAW1m1QAgNFgO3hKX6/ie8eEkpY3ptX/52pvzUWWnYjmSHIMDlPQPRs1gAkqePXSRsSZ+hMp5nbal+7SuoVO7qfYlf2J8oXWBoVsI6hkQ7OOLQ3QXOqGvJKdEvmTWMub91oEHfU/Z85M1esom6NQU0614yVpvyp37x0Qf+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729737668; c=relaxed/simple;
	bh=ym8aAXWzWle8rBcGCn/kYZtEJK/5W23MqG0KAYxeHYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B3jmeTJypDu3aqRmTvfIjuw8OL9+37hT53Sy45r4Ck2TTKpvMf2aoK2zUW7LkRsDqI4Y9cwI93smxZ/wb40Cr8M5lm/1Kzs0W2nAhzPLEaDH+oq0ZHjSNAggHivZSNwyf5YjOLckAaM5ngyYX1mKb30k1wHS8lSmshDRYlsij1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 655aaa8e91b111efa216b1d71e6e1362-20241024
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI, GTI_FG_IT
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:e1ec8d60-5982-423d-b721-47b44e7ba45d,IP:25,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-9
X-CID-INFO: VERSION:1.1.38,REQID:e1ec8d60-5982-423d-b721-47b44e7ba45d,IP:25,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-9
X-CID-META: VersionHash:82c5f88,CLOUDID:0770ba406bcedb27ac5401b646740f2c,BulkI
	D:2410241040578O4XH4Y4,BulkQuantity:0,Recheck:0,SF:24|17|19|43|74|66|841|3
	8|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: 655aaa8e91b111efa216b1d71e6e1362-20241024
X-User: duanchenghao@kylinos.cn
Received: from chenghao.. [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2121517158; Thu, 24 Oct 2024 10:40:56 +0800
From: Duan Chenghao <duanchenghao@kylinos.cn>
To: duanchenghao@kylinos.cn,
	stern@rowland.harvard.edu
Cc: saranya.gopal@intel.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	niko.mauno@vaisala.com,
	pavel@ucw.cz,
	rafael@kernel.org,
	stanley_chang@realtek.com,
	tj@kernel.org,
	xiehongyu1@kylinos.cn,
	xy521521@gmail.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v4] USB: Fix the issue of task recovery failure caused by USB status when S4 wakes up
Date: Thu, 24 Oct 2024 10:40:38 +0800
Message-Id: <20241024024038.26157-1-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e795d88afb2b485fab97e2be7759664e823fbfad.camel@kylinos.cn>
References: <e795d88afb2b485fab97e2be7759664e823fbfad.camel@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a device is inserted into the USB port and an S4 wakeup is initiated,
after the USB-hub initialization is completed, it will automatically enter
suspend mode. Upon detecting a device on the USB port, it will proceed with
resume and set the hcd to the HCD_FLAG_WAKEUP_PENDING state. During the S4
wakeup process, peripherals are put into suspend mode, followed by task
recovery. However, upon detecting that the hcd is in the
HCD_FLAG_WAKEUP_PENDING state, it will return an EBUSY status, causing the
S4 suspend to fail and subsequent task recovery to not proceed.
-
[   27.594598][ 1]  PM: pci_pm_freeze(): hcd_pci_suspend+0x0/0x28 returns -16
[   27.594601][ 1]  PM: dpm_run_callback(): pci_pm_freeze+0x0/0x100 returns -16
[   27.603420][ 1]  ehci-pci 0000:00:04.1: pci_pm_freeze+0x0/0x100 returned 0 after 3 usecs
[   27.612233][ 1]  ehci-pci 0000:00:05.1: pci_pm_freeze+0x0/0x100 returned -16 after 17223 usecs
[   27.810067][ 1]  PM: Device 0000:00:05.1 failed to quiesce async: error -16
[   27.816988][ 1]  PM: quiesce of devices aborted after 1833.282 msecs
[   27.823302][ 1]  PM: start quiesce of devices aborted after 1839.975 msecs
......
[   31.303172][ 1]  PM: recover of devices complete after 3473.039 msecs
[   31.309818][ 1]  PM: Failed to load hibernation image, recovering.
[   31.348188][ 1]  PM: Basic memory bitmaps freed
[   31.352686][ 1]  OOM killer enabled.
[   31.356232][ 1]  Restarting tasks ... done.
[   31.360609][ 1]  PM: resume from hibernation failed (0)
[   31.365800][ 1]  PM: Hibernation image not present or could not be loaded.

The "do_wakeup" is determined based on whether the controller's
power/wakeup attribute is set. The current issue necessitates considering
the type of suspend that is occurring. If the suspend type is either
PM_EVENT_FREEZE or PM_EVENT_QUIESCE, then "do_wakeup" should be set to
false.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410151722.rfjtknRz-lkp@intel.com/
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Duan Chenghao <duanchenghao@kylinos.cn>
---
 drivers/usb/core/hcd-pci.c | 15 +++++++++++++--
 include/linux/pm.h         |  3 ++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index a08f3f228e6d..390b1225f3cc 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -422,7 +422,12 @@ static int suspend_common(struct device *dev, pm_message_t msg)
 	bool			do_wakeup;
 	int			retval;
 
-	do_wakeup = PMSG_IS_AUTO(msg) ? true : device_may_wakeup(dev);
+	if (PMSG_IS_AUTO(msg))
+		do_wakeup = true;
+	else if (PMSG_NO_WAKEUP(msg))
+		do_wakeup = false;
+	else
+		do_wakeup = device_may_wakeup(dev);
 
 	/* Root hub suspend should have stopped all downstream traffic,
 	 * and all bus master traffic.  And done so for both the interface
@@ -521,6 +526,11 @@ static int hcd_pci_suspend(struct device *dev)
 	return suspend_common(dev, PMSG_SUSPEND);
 }
 
+static int hcd_pci_freeze(struct device *dev)
+{
+	return suspend_common(dev, PMSG_FREEZE);
+}
+
 static int hcd_pci_suspend_noirq(struct device *dev)
 {
 	struct pci_dev		*pci_dev = to_pci_dev(dev);
@@ -590,6 +600,7 @@ static int hcd_pci_restore(struct device *dev)
 #else
 
 #define hcd_pci_suspend		NULL
+#define hcd_pci_freeze			NULL
 #define hcd_pci_suspend_noirq	NULL
 #define hcd_pci_poweroff_late	NULL
 #define hcd_pci_resume_noirq	NULL
@@ -624,7 +635,7 @@ const struct dev_pm_ops usb_hcd_pci_pm_ops = {
 	.suspend_noirq	= hcd_pci_suspend_noirq,
 	.resume_noirq	= hcd_pci_resume_noirq,
 	.resume		= hcd_pci_resume,
-	.freeze		= hcd_pci_suspend,
+	.freeze		= hcd_pci_freeze,
 	.freeze_noirq	= check_root_hub_suspended,
 	.thaw_noirq	= NULL,
 	.thaw		= hcd_pci_resume,
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 97b0e23363c8..2a676b2cb699 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -570,7 +570,8 @@ const struct dev_pm_ops name = { \
 					{ .event = PM_EVENT_AUTO_RESUME, })
 
 #define PMSG_IS_AUTO(msg)	(((msg).event & PM_EVENT_AUTO) != 0)
-
+#define PMSG_NO_WAKEUP(msg)	(((msg).event & \
+				(PM_EVENT_FREEZE | PM_EVENT_QUIESCE)) != 0)
 /*
  * Device run-time power management status.
  *
-- 
2.34.1


