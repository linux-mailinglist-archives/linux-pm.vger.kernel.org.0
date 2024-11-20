Return-Path: <linux-pm+bounces-17799-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BD49D321B
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 03:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24BFE1F21595
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2024 02:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09CD446A1;
	Wed, 20 Nov 2024 02:15:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CBC2E40E;
	Wed, 20 Nov 2024 02:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732068903; cv=none; b=YqINQHLLCbTIA+UCS4MCsmjT8OlQs/SX26x9bfOOjp3oi1dnIhkbW7UcIVuXuSGF8FgAcxE2C83rqkKn3Gzg+Yi/7DphCxTZzGpuqQB7UOqB/80oIaWWTAMhF8uDvJzNbHHI+ugeshGCHLv1RxG5S30y768o6m2L3aOGzieNgDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732068903; c=relaxed/simple;
	bh=nRMO5tBPsD78K2k5il0gmaxJciw7QdFyq4xgfVpMoes=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A77U3cXb3SIyXtqDeY+OyRzlbqva8uBG7NGVcXAQlaEEPNkn6NrQdvoxM657wTfawo5TSAnYZt6lwxPXh/sueAZk4bsTsX52ehQHTMsmCL28jol8oFm/y4+uFZlPhQ2uLjDyWpa7yMmJM1eYlfOQpviBLHpITsuPIjh21JG24/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3bf04b74a6e511efa216b1d71e6e1362-20241120
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CHARSET
	HR_CHARSET_NUM, HR_CTE_8B, HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD
	HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_CHARSET, HR_SJ_DIGIT_LEN, HR_SJ_HAN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_C_CI, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:34f309a5-bdce-44ba-93d4-feb4254b643f,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:2,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-8
X-CID-INFO: VERSION:1.1.38,REQID:34f309a5-bdce-44ba-93d4-feb4254b643f,IP:0,URL
	:0,TC:0,Content:-5,EDM:0,RT:2,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-8
X-CID-META: VersionHash:82c5f88,CLOUDID:69e8dde557714b4bae663c109e263228,BulkI
	D:241120095158LUGR8NIB,BulkQuantity:2,Recheck:0,SF:64|66|841|38|17|19|102,
	TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 3bf04b74a6e511efa216b1d71e6e1362-20241120
X-User: duanchenghao@kylinos.cn
Received: from [172.30.80.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1445782142; Wed, 20 Nov 2024 10:14:55 +0800
Message-ID: <4d59c6f60fb0b1c718cd150d75471f62db03de3b.camel@kylinos.cn>
Subject: =?gb2312?Q?=BB=D8=B8=B4=A3=BA=5BPATCH?= v4] USB: Fix the issue of
 task recovery failure caused by USB status when S4 wakes up
From: Duan Chenghao <duanchenghao@kylinos.cn>
To: Greg KH <gregkh@linuxfoundation.org>, Alan Stern
 <stern@rowland.harvard.edu>
Cc: stern@rowland.harvard.edu, saranya.gopal@intel.com, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-usb@vger.kernel.org, niko.mauno@vaisala.com, pavel@ucw.cz,
 rafael@kernel.org,  stanley_chang@realtek.com, tj@kernel.org,
 xiehongyu1@kylinos.cn,  xy521521@gmail.com, kernel test robot
 <lkp@intel.com>
Date: Wed, 20 Nov 2024 10:14:50 +0800
In-Reply-To: <2024102911-mooned-precise-f526@gregkh>
References: <e795d88afb2b485fab97e2be7759664e823fbfad.camel@kylinos.cn>
	 <20241024024038.26157-1-duanchenghao@kylinos.cn>
	 <2024102432-conjoined-skylight-33f1@gregkh>
	 <8aff9a5acbd21d7bd08b80e02ef2b34f2028cedf.camel@kylinos.cn>
	 <2024102911-mooned-precise-f526@gregkh>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2kord0k2.4.25.1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg KH/Alan,

I haven't received a reply from both of you for a long time. Sorry for
the disturbance. May I ask if the current patch can be merged into the
mainline or stable branch? I need this conclusion as it is very
important to me. Thank you very much.

Thanks
Duan Chenghao 

在 2024-10-29星期二的 04:27 +0100，Greg KH写道：
> On Thu, Oct 24, 2024 at 04:46:48PM +0800, duanchenghao wrote:
> > hi greg k-h,
> > 
> > 在 2024-10-24星期四的 09:05 +0200，Greg KH写道：
> > > On Thu, Oct 24, 2024 at 10:40:38AM +0800, Duan Chenghao wrote:
> > > > When a device is inserted into the USB port and an S4 wakeup is
> > > > initiated,
> > > > after the USB-hub initialization is completed, it will
> > > > automatically enter
> > > > suspend mode. Upon detecting a device on the USB port, it will
> > > > proceed with
> > > > resume and set the hcd to the HCD_FLAG_WAKEUP_PENDING state.
> > > > During
> > > > the S4
> > > > wakeup process, peripherals are put into suspend mode, followed
> > > > by
> > > > task
> > > > recovery. However, upon detecting that the hcd is in the
> > > > HCD_FLAG_WAKEUP_PENDING state, it will return an EBUSY status,
> > > > causing the
> > > > S4 suspend to fail and subsequent task recovery to not proceed.
> > > > -
> > > > [   27.594598][ 1]  PM: pci_pm_freeze():
> > > > hcd_pci_suspend+0x0/0x28
> > > > returns -16
> > > > [   27.594601][ 1]  PM: dpm_run_callback():
> > > > pci_pm_freeze+0x0/0x100
> > > > returns -16
> > > > [   27.603420][ 1]  ehci-pci 0000:00:04.1:
> > > > pci_pm_freeze+0x0/0x100
> > > > returned 0 after 3 usecs
> > > > [   27.612233][ 1]  ehci-pci 0000:00:05.1:
> > > > pci_pm_freeze+0x0/0x100
> > > > returned -16 after 17223 usecs
> > > > [   27.810067][ 1]  PM: Device 0000:00:05.1 failed to quiesce
> > > > async: error -16
> > > > [   27.816988][ 1]  PM: quiesce of devices aborted after
> > > > 1833.282
> > > > msecs
> > > > [   27.823302][ 1]  PM: start quiesce of devices aborted after
> > > > 1839.975 msecs
> > > > ......
> > > > [   31.303172][ 1]  PM: recover of devices complete after
> > > > 3473.039
> > > > msecs
> > > > [   31.309818][ 1]  PM: Failed to load hibernation image,
> > > > recovering.
> > > > [   31.348188][ 1]  PM: Basic memory bitmaps freed
> > > > [   31.352686][ 1]  OOM killer enabled.
> > > > [   31.356232][ 1]  Restarting tasks ... done.
> > > > [   31.360609][ 1]  PM: resume from hibernation failed (0)
> > > > [   31.365800][ 1]  PM: Hibernation image not present or could
> > > > not
> > > > be loaded.
> > > > 
> > > > The "do_wakeup" is determined based on whether the controller's
> > > > power/wakeup attribute is set. The current issue necessitates
> > > > considering
> > > > the type of suspend that is occurring. If the suspend type is
> > > > either
> > > > PM_EVENT_FREEZE or PM_EVENT_QUIESCE, then "do_wakeup" should be
> > > > set
> > > > to
> > > > false.
> > > > 
> > > > Reported-by: kernel test robot <
> > > > lkp@intel.com
> > > > >
> > > > Closes:
> > > > https://lore.kernel.org/oe-kbuild-all/202410151722.rfjtknRz-lkp@intel.com/
> > > > 
> > > > Signed-off-by: Alan Stern <
> > > > stern@rowland.harvard.edu
> > > > >
> > > > Signed-off-by: Duan Chenghao <
> > > > duanchenghao@kylinos.cn
> > > > >
> > > 
> > > What commit id does this fix?
> > 
> > The current patch is not intended to fix an issue with a specific
> > commit, but rather to address a long-standing problem in the USB
> > core.
> 
> So should it be backported to older stable kernels?  If so, how far
> back?
> 
> > > And I missed where Alan provided a signed-off-by, where was that?
> > 
> > In the following email, Alan proposed using "Signed-off-by" for
> > signing.
> > https://lore.kernel.org/all/489805e7-c19c-4b57-9cd7-713e075261cd@rowland.harvard.edu/
> > 
> 
> Ah, missed that, sorry.
> 
> thanks,
> 
> greg k-h


