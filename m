Return-Path: <linux-pm+bounces-15532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE860999DAD
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 09:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9778B1F23A42
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 07:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18091208994;
	Fri, 11 Oct 2024 07:17:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E7D1C2452;
	Fri, 11 Oct 2024 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728631047; cv=none; b=jJXXuPTeczJnPXgN5HEgt+qWOKP7oTPXRchqyFnrZUlH1s/QUFrZzqphXHSLIa0i8Ym4N3ivNDEvuKEhRsfP36CNxkindspGpGomMYmfJQk8yeGjA8j5ahVne1PY3/vQeVr1h3hEcqSaTTeQzN+GK8yXUfZyayBQikn1pjVMSmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728631047; c=relaxed/simple;
	bh=FX9dhhM5iSlG/uRacnQXf0og6KmGorv/e3P36dD+KHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DEKRTs018eAYAOVe4384WLV7zLGb2zfboYlvNJRYxFVSq1+obzIZSej3O5jPceaThXEU4to5UgxnafjLTgI5z3PUXsAsZCabffSUwuoyvTCjXiCzuh+6EHApKrDDpp/5wHm1SfMJxjZBV7RV7BlItc3iNuv4+hWLkO8kZsuvFQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d57a307087a011efa216b1d71e6e1362-20241011
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI, GTI_FG_IT
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:ddaadf42-204d-47b4-8b7b-cabfc7e1de4d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-INFO: VERSION:1.1.38,REQID:ddaadf42-204d-47b4-8b7b-cabfc7e1de4d,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:bc066f0161618f66ac22e27bd7da1e75,BulkI
	D:240925144023207KTES0,BulkQuantity:28,Recheck:0,SF:64|66|17|19|817|102,TC
	:nil,Content:0|-5,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_OBB,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,
	TF_CID_SPAM_FSD
X-UUID: d57a307087a011efa216b1d71e6e1362-20241011
X-User: dengjie03@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <dengjie03@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1561715663; Fri, 11 Oct 2024 15:17:11 +0800
From: Deng Jie <dengjie03@kylinos.cn>
To: stern@rowland.harvard.edu
Cc: dengjie03@kylinos.cn,
	duanchenghao@kylinos.cn,
	gregkh@linuxfoundation.org,
	len.brown@intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pavel@ucw.cz,
	rafael@kernel.org,
	xiehongyu1@kylinos.cn,
	xiongxin@kylinos.cn
Subject: Re: [PATCH v2] USB: Fix the issue of S4 wakeup queisce phase where task resumption fails due to USB status
Date: Fri, 11 Oct 2024 15:17:07 +0800
Message-Id: <20241011071707.216160-1-dengjie03@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <13977202-1571-4987-9f2f-20312f8446fa@rowland.harvard.edu>
References: <13977202-1571-4987-9f2f-20312f8446fa@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> 1. Although during the S4 quiesce phase, the do_remote_wakeup flag is set
>> to 0 within the usb_suspend->choose_wakeup function, the subsequent sequence
>> of usb_suspend->usb_suspend_both->usb_suspend_device->hcd_bus_suspend->
>> xhci_bus_suspend will disable remote wakeup for the RootHub port.
>> 2. However, during the loading image phase prior to the S4 quiesce phase,
>> the USB device may have generated an interrupt, setting the WAKEUP_PENDING flag.
>> Additionally, due to the execution of freeze_kernel_threads before the loading
>> image phase, the USB interrupt generated during the loading image phase is
>> unable to execute its interrupt handler's bottom half, resulting in the
>> WAKEUP_PENDING flag remaining uncleared.
>> 3. Therefore, even though the remote wakeup for the RootHub is disabled in
>> usb_suspend_both() during the quiesce phase, due to the WAKEUP_PENDING flag not
>> being cleared, the xhci still believes that the RootHub has generated a wakeup
>> event when it attempts to suspend. Consequently, the xhci suspend function
>> returns an -EBUSY error and does not proceed with the suspend operation.
>> 
>> >Now maybe things are't working the way they are supposed to.  If that's
>> >so then you should submit a patch fixing the code so that it _does_ work
>> >this way.
>> >
>> >For instance, in suspend_common(), do_wakeup is derived from
>> >device_may_wakeup(rhdev), which is determined by
>> >rhdev->power.should_wakeup -- see the definition in
>> >include/linux/pm_wakeup.h.  Maybe this flag isn't getting cleared
>> >properly.  (In fact, at the moment I don't see where that flag gets set
>> >or cleared at all...)
>> 
>> After configuring CONFIG_PM_SLEEP, the return value of device_may_wakeup
>> should be equal to dev->power.can_wakeup && !!dev->power.wakeup.
>
>Please see my reply on this other email thread, which concerns the same 
>problem:
>
>https://lore.kernel.org/linux-usb/2c368013-8363-4a4e-bfee-2f0b14d01162@rowland.harvard.edu/
>
>I should have CC'ed you on that message, but I didn't think of it at the 
>time.
>

Thank you for your reply. I will analyze it carefully.

Thanks,

Deng Jie

