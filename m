Return-Path: <linux-pm+bounces-15567-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EDF99B2A4
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 11:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50AD1F22427
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 09:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD1D14D456;
	Sat, 12 Oct 2024 09:47:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D26D22064;
	Sat, 12 Oct 2024 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728726429; cv=none; b=qPiPizQOhiyL8BqFPTKWp9/r9V1g5v0ZvAjv3HdA8ozyYmOqFufMyINAdJK9F0Lp06EYC1jdIGt6nx4KCNzeqj2EwH5jQEvCfzLAnWlqmhI89yWEeZXvTQIm6muOJY+MHJcZYXXK1/VnDdG/jJmKQrDEYEyNpDV3EZ+fSh9Uqqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728726429; c=relaxed/simple;
	bh=aow+ZvCVaf34tfmqrAGOMLfdLPrTE988VL3b2CLE0s0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CFAVL5o+Z4qb0Auv3KXTKHR7lkTTvS6/kdNB6dJfAkZzelBMh9wtx2KugcJ9QgZTFBl9DEum99nbqVQS0l/urV2qWWH13H5cz4EOqRgNVdQ5UjkaraTkCqO3VbS1r3TvDeXCF1TtebMtNIIzQv52y2Wgh4IZE956VHEGbN4FpxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e6b9f508887e11efa216b1d71e6e1362-20241012
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:71e524cc-2c9d-437f-a45c-23ce2d61d35a,IP:15,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-19
X-CID-INFO: VERSION:1.1.38,REQID:71e524cc-2c9d-437f-a45c-23ce2d61d35a,IP:15,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-19
X-CID-META: VersionHash:82c5f88,CLOUDID:77216fdf73ac2bb9d7dc63384849c262,BulkI
	D:2410121746509QEVB7HD,BulkQuantity:0,Recheck:0,SF:19|43|74|66|38|24|17|10
	2,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: e6b9f508887e11efa216b1d71e6e1362-20241012
X-User: duanchenghao@kylinos.cn
Received: from chenghao.. [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 850007511; Sat, 12 Oct 2024 17:46:48 +0800
From: Duan Chenghao <duanchenghao@kylinos.cn>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com,
	linux-usb@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: duanchenghao@kylinos.cn,
	linux-kernel@vger.kernel.org,
	niko.mauno@vaisala.com,
	stanley_chang@realtek.com,
	tj@kernel.org,
	xiehongyu1@kylinos.cn,
	xy521521@gmail.com
Subject: [PATCH v3] USB: Fix the issue of task recovery failure caused by USB status when S4 wakes up
Date: Sat, 12 Oct 2024 17:46:33 +0800
Message-Id: <20241012094633.126736-1-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b8eb28f3-504d-4d26-8b02-ca1ae7309a70@rowland.harvard.edu>
References: <b8eb28f3-504d-4d26-8b02-ca1ae7309a70@rowland.harvard.edu>
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

Co-authored-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Duan Chenghao <duanchenghao@kylinos.cn>
---
 drivers/usb/core/hcd-pci.c | 14 ++++++++++++--
 include/linux/pm.h         |  3 ++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index a08f3f228e6d..2c7d4446b82e 100644
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
@@ -624,7 +634,7 @@ const struct dev_pm_ops usb_hcd_pci_pm_ops = {
 	.suspend_noirq	= hcd_pci_suspend_noirq,
 	.resume_noirq	= hcd_pci_resume_noirq,
 	.resume		= hcd_pci_resume,
-	.freeze		= hcd_pci_suspend,
+	.freeze		= hcd_pci_freeze,
 	.freeze_noirq	= check_root_hub_suspended,
 	.thaw_noirq	= NULL,
 	.thaw		= hcd_pci_resume,
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 97b0e23363c8..0dd7f559188b 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -570,7 +570,8 @@ const struct dev_pm_ops name = { \
 					{ .event = PM_EVENT_AUTO_RESUME, })
 
 #define PMSG_IS_AUTO(msg)	(((msg).event & PM_EVENT_AUTO) != 0)
-
+#define PMSG_NO_WAKEUP(msg)	(((msg.event) & \
+				(PM_EVENT_FREEZE | PM_EVENT_QUIESCE)) != 0)
 /*
  * Device run-time power management status.
  *
-- 
2.34.1


