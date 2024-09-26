Return-Path: <linux-pm+bounces-14786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD81986EA8
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 10:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1901C211D3
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 08:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF611A4B70;
	Thu, 26 Sep 2024 08:20:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3059B143C4C;
	Thu, 26 Sep 2024 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727338854; cv=none; b=RF4C/YH0NzIv4OMkXqsomXS3bkKpn80ZQN35m2wsp9Fy7Z+jGKE7OT2iC/ryMF5qRzpMON1b4bILFY8c6h9VVNY//2CtOhutAKGX/ZplVrZeoNzD7dkbPrBbYnRS9mck6L+bHuDE7/ieE+2GJvQZsg/qz8FkoGiok7nIkKlISKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727338854; c=relaxed/simple;
	bh=5SG9w7Q4WnBvy27ddGc1bzdc8ZHjDro5bwU/EkO6oNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MqwFNRjo4aNn/UzjR/9w+y1QNfoA6oX6zHrBiLNXiAx4IBhN5rWq34MTG8/H5VGGodJyDn+lHt4D03s35hl5OWFjcUhVqRubXAFlWg0vXGKDKSrVTOwsciXWflBU/dp5QRE6Yo4069mYlMCAOuRY45LIVKt8IAdg3pVp1dF20aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3787687c7be011efa216b1d71e6e1362-20240926
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_UNTRUSTED, SA_LOWREP, SA_EXISTED, SN_UNTRUSTED, SN_LOWREP
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:7c3be859-750f-40b3-914d-316f1a05d482,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-INFO: VERSION:1.1.38,REQID:7c3be859-750f-40b3-914d-316f1a05d482,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:b629355be24ee38a092c299d6801b1bb,BulkI
	D:240925144023207KTES0,BulkQuantity:13,Recheck:0,SF:64|66|17|19|102,TC:nil
	,Content:0,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB
X-UUID: 3787687c7be011efa216b1d71e6e1362-20240926
X-User: dengjie03@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <dengjie03@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 866411718; Thu, 26 Sep 2024 16:20:40 +0800
From: Deng Jie <dengjie03@kylinos.cn>
To: gregkh@linuxfoundation.org
Cc: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	xiehongyu1@kylinos.cn,
	duanchenghao@kylinos.cn,
	xiongxin@kylinos.cn
Subject: Re: [PATCH v2] USB: Fix the issue of S4 wakeup queisce phase where task resumption fails due to USB status
Date: Thu, 26 Sep 2024 16:20:36 +0800
Message-Id: <20240926082036.312203-1-dengjie03@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024092525-envision-impotency-c1a6@gregkh>
References: <2024092525-envision-impotency-c1a6@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,
Do you think this plan is feasible? Do I need to add more explanations?

Thanks,

Deng Jie

>---
>v2:
>	* Fix the formatting issues and function naming conventions in the v1 patch.
>v1:
>	* USB: Fix the issue of S4 wakeup queisce phase where task resumption fails
> 	   due to USB status.
>---
>
>diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>index fb4d18a0b185..7723e7082a36 100644
>--- a/drivers/base/power/main.c
>+++ b/drivers/base/power/main.c
>@@ -559,6 +559,11 @@ bool dev_pm_may_skip_resume(struct device *dev)
> 	return !dev->power.must_resume && pm_transition.event != PM_EVENT_RESTORE;
> }
> 
>+bool pm_event_is_queisce(void)
>+{
>+	return pm_transition.event == PM_EVENT_QUIESCE;
>+}
>+
> static pm_callback_t dpm_subsys_resume_noirq_cb(struct device *dev,
> 						pm_message_t state,
> 						const char **info_p)
>diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
>index 77830f120834..af2c60049e4a 100644
>--- a/drivers/usb/core/hcd-pci.c
>+++ b/drivers/usb/core/hcd-pci.c
>@@ -456,18 +456,25 @@ static int suspend_common(struct device *dev, bool do_wakeup)
> 		/* Optimization: Don't suspend if a root-hub wakeup is
> 		 * pending and it would cause the HCD to wake up anyway.
> 		 */
>-		if (do_wakeup && HCD_WAKEUP_PENDING(hcd))
>-			return -EBUSY;
>-		if (do_wakeup && hcd->shared_hcd &&
>-				HCD_WAKEUP_PENDING(hcd->shared_hcd))
>+		/* Considering the restore process that occurs after
>+		 * the quiesce phase during S4 wakeup, which essentially
>+		 * resets all root hubs,checking this wakeup pending status
>+		 * in USB suspend_common() during the quiesce phase is of
>+		 * little significance and should therefore be filtered out.
>+		 */
>+		if (!pm_event_is_queisce() && do_wakeup &&
>+		    (HCD_WAKEUP_PENDING(hcd) ||
>+		     (hcd->shared_hcd &&
>+		      HCD_WAKEUP_PENDING(hcd->shared_hcd))))
> 			return -EBUSY;
> 		retval = hcd->driver->pci_suspend(hcd, do_wakeup);
> 		suspend_report_result(hcd->driver->pci_suspend, retval);
> 
> 		/* Check again in case wakeup raced with pci_suspend */
>-		if ((retval == 0 && do_wakeup && HCD_WAKEUP_PENDING(hcd)) ||
>-				(retval == 0 && do_wakeup && hcd->shared_hcd &&
>-				 HCD_WAKEUP_PENDING(hcd->shared_hcd))) {
>+		if (retval == 0 && !pm_event_is_queisce() && do_wakeup &&
>+		    (HCD_WAKEUP_PENDING(hcd) ||
>+		     (hcd->shared_hcd &&
>+		      HCD_WAKEUP_PENDING(hcd->shared_hcd)))) {
> 			if (hcd->driver->pci_resume)
> 				hcd->driver->pci_resume(hcd, false);
> 			retval = -EBUSY;
>diff --git a/include/linux/pm.h b/include/linux/pm.h
>index 4c441be03079..dad87c9ecfee 100644
>--- a/include/linux/pm.h
>+++ b/include/linux/pm.h
>@@ -758,6 +758,7 @@ extern void pm_generic_complete(struct device *dev);
> 
> extern bool dev_pm_may_skip_resume(struct device *dev);
> extern bool dev_pm_smart_suspend_and_suspended(struct device *dev);
>+extern bool pm_event_is_queisce(void);
> 
> #else /* !CONFIG_PM_SLEEP */
>

