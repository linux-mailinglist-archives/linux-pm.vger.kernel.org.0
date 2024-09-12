Return-Path: <linux-pm+bounces-14063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8A2976178
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 08:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176B41C21778
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 06:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CBC18B48C;
	Thu, 12 Sep 2024 06:26:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB718146A6F;
	Thu, 12 Sep 2024 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726122389; cv=none; b=ExVPIvd/PJwVXOe6mt8aUfDApmevQLVnbBHdOPo9649dTP53yVbYulC7P2Z8WF7BD5cM+dvKjHA8x5UbfRqDdabINHMgmxP5gb/kbDivPsgtvaNF5vg7Tw5fRLUuzmbmYpEtpjB2KZre4+knROcDHpnvkIfxRxQYWoWibKVif1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726122389; c=relaxed/simple;
	bh=GdrOQN2hqCNhkSgAt9AvaHK+fAjtnWoxdSdqTlSk/xY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4q3su4iATjHK0FZxI74KftqDll9aA4QUKz5TeO73/aX4JR8GAGpjB7b4MKEQprcM8kVoIzJO34r+/E8dN5/cTg2vNxba3EbNOfqY4hv3xvQLX4b2szOncSFeBK2S/1xpL+zYPb8D/qzu7eg+jnUAK8Eolno1kJlQSQlRHKj+rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e92db1b070cf11efa216b1d71e6e1362-20240912
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_AS_FROM, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:f43f41e6-9860-42b8-86ba-e81feab4d3cc,IP:20,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:0
X-CID-INFO: VERSION:1.1.38,REQID:f43f41e6-9860-42b8-86ba-e81feab4d3cc,IP:20,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:f2f1e052db5a3a9be1df2f79b511018f,BulkI
	D:240910185731PV8ZAN7Q,BulkQuantity:1,Recheck:0,SF:66|24|17|19|44|102,TC:n
	il,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: e92db1b070cf11efa216b1d71e6e1362-20240912
X-User: duanchenghao@kylinos.cn
Received: from chenghao.. [(223.70.160.255)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 802348301; Thu, 12 Sep 2024 14:26:14 +0800
From: Duan Chenghao <duanchenghao@kylinos.cn>
To: duanchenghao@kylinos.cn
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	niko.mauno@vaisala.com,
	pavel@ucw.cz,
	stanley_chang@realtek.com,
	stern@rowland.harvard.edu,
	tj@kernel.org
Subject: [PATCH v2] USB: Fix the issue of task recovery failure caused by USB status when S4 wakes up
Date: Thu, 12 Sep 2024 14:26:06 +0800
Message-Id: <20240912062606.357373-1-duanchenghao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8068130ce4ece6078b2893c4c6333c06c792b6c0.camel@kylinos.cn>
References: <8068130ce4ece6078b2893c4c6333c06c792b6c0.camel@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a device is inserted into the USB port and an S4 wakeup is initiated,
after the USB-hub initialization is completed, it will automatically enter
suspend mode. Upon detecting a device on the USB port, it will proceed with
resume and set the hcd to the HCD_FLAG_WAKEUP_PENDING state. During the S4
wakeup process, peripherals are put into suspend mode, followed by task
recovery. However, upon detecting that the hcd is in the
HCD_FLAG_WAKEUP_PENDING state, it will return an EBUSY status, causing the
S4 suspend to fail and subsequent task recovery to not proceed.

    S4 waking up from hibernation
    =============================
    kernel initialization
    |
    v
    freeze user task and kernel thread
    |
    v
    load saved image
    |
    v
    freeze the peripheral device and controller(*** Error point ***)
    (Check the HCD_FLAG_WAKEUP_ PENDING flag of the USB. If it is set,
     return to EBUSY and do not perform the following restore image.)
    |
    v
    restore image(task recovery)

This patch makes two modifications in total:
1. The set_bit and clear_bit operations for the HCD_FLAG_WAKEUP_PENDING
flag of Hcd, which were previously split between the top half and bottom
half of the interrupt,are now unified and executed solely in the bottom
half of the interrupt.This prevents the bottom half tasks from being frozen
during the S4 process,ensuring that the clear_bit process can proceed
without interruption.

    Before modification：

    ehci interrupt handler
    =====================
    remote wakeup
    if (ehci->rh_state == EHCI_RH_SUSPENDED)	    |
	usb_hcd_resume_root_hub			    |
    |						    |
    v						    | top half
    set_bit HCD_FLAG_WAKEUP_PENDING		    |
    |						    |
    v						    |
    queue_work(pm_wq, &hcd->wakeup_work)	    |
    |
    v
    hub resume					    |
    |						    |
    v						    | bottom half
    clear_bit HCD_FLAG_WAKEUP_PENDING		    |

    After modification:

    ehci interrupt handler
    =====================
    remote wakeup
    if (ehci->rh_state == EHCI_RH_SUSPENDED)        |
        usb_hcd_resume_root_hub                     |
    |						    | top half
    v						    |
    queue_work(pm_wq, &hcd->wakeup_work)	    |
    |
    v
    set_bit HCD_FLAG_WAKEUP_PENDING		    |
    |						    |
    v						    |
    hub resume                                      | bottom half
    |                                               |
    v                                               |
    clear_bit HCD_FLAG_WAKEUP_PENDING               |

2. Add a condition to the set_bit operation for the hcd flags
HCD_FLAG_WAKEUP_PENDING.When the hcd status is HC_STATE_SUSPENDED, perform
the setting of the aforementioned status bit.This prevents a subsequent
set_bit from occurring after the clear_bit if the hcd is in the resuming
process.

    Before modification：
    ehci interrupt handler(CPUx)		ehci init(CPUy)
    =====================			=============
    remote wakeup				initialization complete
    usb_hcd_resume_root_hub
    				    		Enter suspend and detect that there
						is a device inserted
						(udev->state = USB_STATE_SUSPENDED)

						hcd->state = HC_STATE_RESUMING
						bus_resume
    if (udev->state == USB_STATE_SUSPENDED)	clear_bit HCD_FLAG_WAKEUP_PENDING
    set_bit HCD_FLAG_WAKEUP_PENDING		udev->state = !USB_STATE_SUSPENDED

    In the aforementioned scenario, there is no mutual exclusion between
    the set_bit operation in ehci interrupts, the judgment of udev->state,
    and the clear_bit as well as the assignment of udev->state during ehci
    initialization. There exists a situation where clear_bit is followed by
    set_bit, but due to the judgment on udev->state, the clear_bit
    operation might not occur again, leading to an error in the flag bit.

    After modification:
    ehci interrupt handler(CPUx)		ehci init(CPUy)
    =====================			=============
    remote wakeup				initialization complete
    usb_hcd_resume_root_hub
    				    		Enter suspend and detect that there
						is a device inserted
						(udev->state = USB_STATE_SUSPENDED)

						hcd->state = HC_STATE_RESUMING
						bus_resume
    if (udev->state == USB_STATE_SUSPENDED)	clear_bit HCD_FLAG_WAKEUP_PENDING
    if (hcd->state != HC_STATE_RESUMING)	udev->state = !USB_STATE_SUSPENDED
    set_bit HCD_FLAG_WAKEUP_PENDING

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


