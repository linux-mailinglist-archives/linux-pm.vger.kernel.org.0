Return-Path: <linux-pm+bounces-13744-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E1A96E7FE
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 05:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E44C1F248E3
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2024 03:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D83D22334;
	Fri,  6 Sep 2024 03:06:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AC11805A;
	Fri,  6 Sep 2024 03:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725592008; cv=none; b=Ti9GcLWQAuLa54sz9SVJUNq29YNR1UhMZMfShH2s8KA6Bm8fLBC77Ekpjk8Nm6V8HEqzx1qxH5xK8d/eV9xflZCr7GlDqCC8Zx47YkT0OikI5DNjraVaVzQCcDKmuqRWMtlxnqOMDhFGcpjlO5ebu3fo5Ny/7VuwtzpD3ojXLkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725592008; c=relaxed/simple;
	bh=b1tjpeyOK9mQG3APi9N8ElGJuuJJDMoUoJ6UWqqFFfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D4kkPGPpze0Guw1abdMJ+P3J4HEcn6Z1w0SJX/WcC/K2FyZLYT2rKVZBjni+6ScI0XVDmcf7CFsxCl037aMsZ3i3MmNETW2udBEoBkw3WNfNbQO+YRhR6xCyD5LAZ9+Gd4gG6SWRWGUGLrQcje5nuJdQenxKx0umUTL/wc3GoFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0526b2866bfd11efa216b1d71e6e1362-20240906
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR
	SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:b7458673-1f35-4cd1-824b-bb1b443d8abe,IP:10,
	URL:0,TC:0,Content:0,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-20
X-CID-INFO: VERSION:1.1.38,REQID:b7458673-1f35-4cd1-824b-bb1b443d8abe,IP:10,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:-20
X-CID-META: VersionHash:82c5f88,CLOUDID:2c00f2f9f017478b15ea7a3b45cd0dee,BulkI
	D:240906110635Q3J4J70O,BulkQuantity:0,Recheck:0,SF:44|66|38|24|72|19|102,T
	C:nil,Content:0,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 0526b2866bfd11efa216b1d71e6e1362-20240906
X-User: duanchenghao@kylinos.cn
Received: from chenghao.. [(223.70.160.255)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 747009131; Fri, 06 Sep 2024 11:06:32 +0800
From: Duan Chenghao <duanchenghao@kylinos.cn>
To: gregkh@linuxfoundation.org,
	pavel@ucw.cz,
	linux-pm@vger.kernel.org
Cc: niko.mauno@vaisala.com,
	stanley_chang@realtek.com,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	duanchenghao@kylinos.cn
Subject: [PATCH] USB: Fix the issue of task recovery failure caused by USB status when S4 wakes up
Date: Fri,  6 Sep 2024 11:05:48 +0800
Message-Id: <20240906030548.845115-1-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a device is inserted into the USB port and an S4 wakeup is initiated,
after the USB-hub initialization is completed, it will automatically enter suspend mode.
Upon detecting a device on the USB port, it will proceed with resume and set the hcd to the HCD_FLAG_WAKEUP_PENDING state.
During the S4 wakeup process, peripherals are put into suspend mode, followed by task recovery.
However, upon detecting that the hcd is in the HCD_FLAG_WAKEUP_PENDING state,
it will return an EBUSY status, causing the S4 suspend to fail and subsequent task recovery to not proceed.

This patch makes two modifications in total:
1. The set_bit and clean_bit operations for the HCD_FLAG_WAKEUP_PENDING flag of Hcd,
which were previously split between the top half and bottom half of the interrupt,
are now unified and executed solely in the bottom half of the interrupt.
This prevents the bottom half tasks from being frozen during the S4 process,
ensuring that the clean_bit process can proceed without interruption.

2. Add a condition to the set_bit operation for the hcd status HCD_FLAG_WAKEUP_PENDING.
When the hcd status is HC_STATE_SUSPENDED, perform the setting of the aforementioned status bit.
This prevents a subsequent set_bit from occurring after the clean_bit if the hcd is in the resuming process.

Signed-off-by: Duan Chenghao <duanchenghao@kylinos.cn>
---
 drivers/usb/core/hcd.c | 1 -
 drivers/usb/core/hub.c | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 1ff7d901fede..a6bd0fbd82f4 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2389,7 +2389,6 @@ void usb_hcd_resume_root_hub (struct usb_hcd *hcd)
 	spin_lock_irqsave (&hcd_root_hub_lock, flags);
 	if (hcd->rh_registered) {
 		pm_wakeup_event(&hcd->self.root_hub->dev, 0);
-		set_bit(HCD_FLAG_WAKEUP_PENDING, &hcd->flags);
 		queue_work(pm_wq, &hcd->wakeup_work);
 	}
 	spin_unlock_irqrestore (&hcd_root_hub_lock, flags);
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 4b93c0bd1d4b..7f847c4afc0d 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3835,11 +3835,14 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
 
 int usb_remote_wakeup(struct usb_device *udev)
 {
+	struct usb_hcd  *hcd = bus_to_hcd(udev->bus);
 	int	status = 0;
 
 	usb_lock_device(udev);
 	if (udev->state == USB_STATE_SUSPENDED) {
 		dev_dbg(&udev->dev, "usb %sresume\n", "wakeup-");
+		if (hcd->state == HC_STATE_SUSPENDED)
+			set_bit(HCD_FLAG_WAKEUP_PENDING, &hcd->flags);
 		status = usb_autoresume_device(udev);
 		if (status == 0) {
 			/* Let the drivers do their thing, then... */
-- 
2.34.1


