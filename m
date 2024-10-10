Return-Path: <linux-pm+bounces-15427-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 259E39979C6
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 02:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FC728402F
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 00:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D0E63B9;
	Thu, 10 Oct 2024 00:47:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C05B224EF;
	Thu, 10 Oct 2024 00:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728521232; cv=none; b=F0JWUjYmBSZRda2k3E06NHr7y6ZHEbz4bnVxK8BQ5UzMGpO1DNr6oBVU1vtcDtTCyZYb9Dq2eRMqaQvZv8s0onv4Aa3xQyvFarnFN6XokJZvzWH+Ht3C4LC55uQYP0UTao9ATwOjG5hgwHhJjCPN/to7UTi9J64z1VP0npccM4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728521232; c=relaxed/simple;
	bh=XLoZVWOMfKt89VV8RNx0MGgo5pk6fXaVTBOOuuco2zI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfvPSBjZsH3bj/D1N2YM1QJaqxs2EQbVxtAOoXs834anKDJMDRKt0x4s6qoEFfROu+mIdUBDVLaFkjogzQhx6BPyNgxLOZlYoIo0cSjd7JBETdFfnEOZEv7G2rNKDxfDGhoJ1D5LPkW+vqi8Q2IqkAr5n+vQXB0dj6D98IIXwIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 286df56086a111efa216b1d71e6e1362-20241010
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:0560a972-691e-4dee-a4f7-ce20381c9831,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:2,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-3
X-CID-INFO: VERSION:1.1.38,REQID:0560a972-691e-4dee-a4f7-ce20381c9831,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:2,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:-3
X-CID-META: VersionHash:82c5f88,CLOUDID:d228c99d6b4b369ec39ab1020f4ee98a,BulkI
	D:240925144023207KTES0,BulkQuantity:21,Recheck:0,SF:19|64|66|38|17|102,TC:
	nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB
X-UUID: 286df56086a111efa216b1d71e6e1362-20241010
X-User: dengjie03@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <dengjie03@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1464132761; Thu, 10 Oct 2024 08:46:59 +0800
From: Deng Jie <dengjie03@kylinos.cn>
To: stern@rowland.harvard.edu,
	rafael@kernel.org
Cc: dengjie03@kylinos.cn,
	gregkh@linuxfoundation.org,
	len.brown@intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pavel@ucw.cz,
	xiehongyu1@kylinos.cn,
	xiongxin@kylinos.cn,
	duanchenghao@kylinos.cn
Subject: Re: [PATCH v2] USB: Fix the issue of S4 wakeup queisce phase where task resumption fails due to USB status
Date: Thu, 10 Oct 2024 08:46:55 +0800
Message-Id: <20241010004655.9382-1-dengjie03@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <85105e45-3553-4a8c-b132-3875c4657c4b@rowland.harvard.edu>
References: <85105e45-3553-4a8c-b132-3875c4657c4b@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alan
  I'm thrilled to receive your reply. Thank you very much.
Sorry for the late response due to the holiday.
>
>> Reproduction of the problem: During the S4 stress test, when a USB device is inserted or
>> removed, there is a probability that the S4 wakeup will turn into a reboot.The following
>> two points describe how to analyze and locate the problem points:
>>
>> 1. During the boot stage when S4 is awakened, after the USB RootHub is initialized,
>> it will enter the runtime suspend state. From then on, whenever an xhci port change
>> event occurs, it will trigger a remote wakeup request event and add wakeup_work
>> to pm_wq, where the subsequent RootHub runtime resume process will be handled by pm_wq.
>>
>> xhci runtime suspend flow：
>> S4 boot
>>    |->xhci init
>>        |->register_root_hub
>>         |->hub_probe
>>             |->callback = RPM_GET_CALLBACK(dev, runtime_suspend)   /* xhci RootHub runtime suspend */
>>
>> xhci runtime resume flow ：
>> xhci_irq()
>>     |->xhci_handle_event()
>>      |->handle_port_status()
>>          |->if(hcd->state == HC_STATE_SUSPENDED)
>>               |->usb_hcd_resume_root_hub()
>>                  |->set_bit(HCD_FLAG_WAKEUP_PENDING, &hcd->flags)   /* wakeup pending signal to be set */
>>                  |->queue_work(pm_wq, &hcd->wakeup_work)
>>                      |->hcd_resume_work()                           /* hcd->wakeup_work */
>>                          |->usb_remote_wakeup()
>>                              |->callback = RPM_GET_CALLBACK(dev, runtime_resume)
>>                                  |->usb_runtime_resume()            /* usb runtime resume  */
>>                                      |->generic_resume()
>>                                          |->hcd_bus_resume()
>>                                              |->clear_bit(HCD_FLAG_WAKEUP_PENDING, &hcd->flags);
>>                                                /* wakeup pending signal to be clear */
>>
>> 2. However, during the quiesce phase of S4 wakeup, freeze_kernel_threads() will freeze this pm_wq,
>> and between freeze_kernel_threads() and dpm_suspend_start(), there exists a very time-consuming
>> S4 image loading process. This leads to a situation where, if an xhci port change event occurs
>> after freeze_kernel_threads(), triggering the wakeup pending signal to be set,but it cannot
>> be processed by pm_wq to clear this wakeup_pending bit, it will result in a subsequent
>> dpm_suspend_start() where USB suspend_common() detects the wakeup pending signal being
>> set and returns an -EBUSY error, interrupting the S4 quiesce process and reverting to a reboot.
>>
>> S4 wakeup
>>     |->resume_store
>>      |->software_resume()
>>          |->freeze_kernel_threads()          /* will freeze pm_wq */
>>          |->load_image_and_restore()
>>                |->swsusp_read()              /* S4 image loading: time-consuming .
>> When an xhci port change event occurs at this point, it triggers the wakeup pending signal to be set.
>> However, since the pm_wq is in a frozen state, the wakeup_pending bit cannot be cleared.*/
>>                |->hibernation_restore
>>                      |->dpm_suspend_start(PMSG_QUIESCE)
>>                          |->hcd_pci_suspend()
>>                              |->suspend_common()
>>                                  |->if (do_wakeup && HCD_WAKEUP_PENDING(hcd))  return -EBUSY;
>
>At this point, do_wakeup is supposed to be 0 and so the "return -EBUSY"
>error should not occur.
>
>You can see that this is true by reading choose_wakeup() in
>drivers/usb/core/driver.c.  At the start of the function it says:
>
>       /*
>        * For FREEZE/QUIESCE, disable remote wakeups so no interrupts get
>        * generated.
>        */
>       if (msg.event == PM_EVENT_FREEZE || msg.event == PM_EVENT_QUIESCE) {
>               w = 0;
>
>and at the end it does:
>
>       udev->do_remote_wakeup = w;
>
>Therefore the problem you are describing should not happen and your
>patch should not be needed.
>

1. Although during the S4 quiesce phase, the do_remote_wakeup flag is set
to 0 within the usb_suspend->choose_wakeup function, the subsequent sequence
of usb_suspend->usb_suspend_both->usb_suspend_device->hcd_bus_suspend->
xhci_bus_suspend will disable remote wakeup for the RootHub port.
2. However, during the loading image phase prior to the S4 quiesce phase,
the USB device may have generated an interrupt, setting the WAKEUP_PENDING flag.
Additionally, due to the execution of freeze_kernel_threads before the loading
image phase, the USB interrupt generated during the loading image phase is
unable to execute its interrupt handler's bottom half, resulting in the
WAKEUP_PENDING flag remaining uncleared.
3. Therefore, even though the remote wakeup for the RootHub is disabled in
usb_suspend_both() during the quiesce phase, due to the WAKEUP_PENDING flag not
being cleared, the xhci still believes that the RootHub has generated a wakeup
event when it attempts to suspend. Consequently, the xhci suspend function
returns an -EBUSY error and does not proceed with the suspend operation.

>Now maybe things are't working the way they are supposed to.  If that's
>so then you should submit a patch fixing the code so that it _does_ work
>this way.
>
>For instance, in suspend_common(), do_wakeup is derived from
>device_may_wakeup(rhdev), which is determined by
>rhdev->power.should_wakeup -- see the definition in
>include/linux/pm_wakeup.h.  Maybe this flag isn't getting cleared
>properly.  (In fact, at the moment I don't see where that flag gets set
>or cleared at all...)

After configuring CONFIG_PM_SLEEP, the return value of device_may_wakeup
should be equal to dev->power.can_wakeup && !!dev->power.wakeup.

Thanks,

Deng Jie


