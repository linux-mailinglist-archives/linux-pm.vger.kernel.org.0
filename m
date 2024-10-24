Return-Path: <linux-pm+bounces-16348-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C25829ADF6F
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 10:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30471C21A64
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 08:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35F91AB6FC;
	Thu, 24 Oct 2024 08:47:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F53757FC;
	Thu, 24 Oct 2024 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729759631; cv=none; b=VUdpk1cJdGi4zEhEQjV9R8eBQyWJTV+V8pkXmopwARwuVrjkktU1B6DjbcLjASYZhkowzsHChJ+WAoLZAmVLSsqj6VfrTAbl9q76Pw5ILWsynqh6prrQgFxnO0jerIeKbyrMQvWSA9scO95fa2w6xDSKahiPI66kTjS+NUSBqqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729759631; c=relaxed/simple;
	bh=uQLwCdvFwjd2wtBsjWyQX17+4azNpZFRnN9HIGZtchI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mht/Q+r/Uikh1t1TWeUaTPL+FTz0MyZAZJ7LQC1S8S+rdlSiKGDI3zTevjsaA3xMSiKW43EEnXBC8YoBkP3Mn/8EZxbmjNWjwbRlVtzsQefTyswym6T5fWNnrhxIyLndrZJmiNt8wYkT2FXHnV91oI5ufsl5RMFut/QbnxvVKcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8671ebdc91e411efa216b1d71e6e1362-20241024
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_QP
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI
	GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:a6a3b53d-6385-46f6-bec6-6ef9078227b9,IP:25,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:16
X-CID-INFO: VERSION:1.1.38,REQID:a6a3b53d-6385-46f6-bec6-6ef9078227b9,IP:25,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:16
X-CID-META: VersionHash:82c5f88,CLOUDID:dbc6b0f086e9155b453c3fb394e0f632,BulkI
	D:241024105327XGBM1VDO,BulkQuantity:4,Recheck:0,SF:24|17|19|43|74|64|66|84
	1|102,TC:nil,Content:1|-5,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:40,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
	TF_CID_SPAM_FSI
X-UUID: 8671ebdc91e411efa216b1d71e6e1362-20241024
X-User: duanchenghao@kylinos.cn
Received: from [172.30.80.21] [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1518242663; Thu, 24 Oct 2024 16:46:56 +0800
Message-ID: <8aff9a5acbd21d7bd08b80e02ef2b34f2028cedf.camel@kylinos.cn>
Subject: Re: [PATCH v4] USB: Fix the issue of task recovery failure caused
 by USB status when S4 wakes up
From: duanchenghao <duanchenghao@kylinos.cn>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stern@rowland.harvard.edu, saranya.gopal@intel.com, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-usb@vger.kernel.org, niko.mauno@vaisala.com, pavel@ucw.cz,
 rafael@kernel.org,  stanley_chang@realtek.com, tj@kernel.org,
 xiehongyu1@kylinos.cn,  xy521521@gmail.com, kernel test robot
 <lkp@intel.com>
Date: Thu, 24 Oct 2024 16:46:48 +0800
In-Reply-To: <2024102432-conjoined-skylight-33f1@gregkh>
References: <e795d88afb2b485fab97e2be7759664e823fbfad.camel@kylinos.cn>
	 <20241024024038.26157-1-duanchenghao@kylinos.cn>
	 <2024102432-conjoined-skylight-33f1@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

hi greg k-h,

=E5=9C=A8 2024-10-24=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 09:05 +0200=EF=BC=
=8CGreg KH=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, Oct 24, 2024 at 10:40:38AM +0800, Duan Chenghao wrote:
> > When a device is inserted into the USB port and an S4 wakeup is
> > initiated,
> > after the USB-hub initialization is completed, it will
> > automatically enter
> > suspend mode. Upon detecting a device on the USB port, it will
> > proceed with
> > resume and set the hcd to the HCD_FLAG_WAKEUP_PENDING state. During
> > the S4
> > wakeup process, peripherals are put into suspend mode, followed by
> > task
> > recovery. However, upon detecting that the hcd is in the
> > HCD_FLAG_WAKEUP_PENDING state, it will return an EBUSY status,
> > causing the
> > S4 suspend to fail and subsequent task recovery to not proceed.
> > -
> > [=C2=A0=C2=A0 27.594598][ 1]=C2=A0 PM: pci_pm_freeze(): hcd_pci_suspend=
+0x0/0x28
> > returns -16
> > [=C2=A0=C2=A0 27.594601][ 1]=C2=A0 PM: dpm_run_callback(): pci_pm_freez=
e+0x0/0x100
> > returns -16
> > [=C2=A0=C2=A0 27.603420][ 1]=C2=A0 ehci-pci 0000:00:04.1: pci_pm_freeze=
+0x0/0x100
> > returned 0 after 3 usecs
> > [=C2=A0=C2=A0 27.612233][ 1]=C2=A0 ehci-pci 0000:00:05.1: pci_pm_freeze=
+0x0/0x100
> > returned -16 after 17223 usecs
> > [=C2=A0=C2=A0 27.810067][ 1]=C2=A0 PM: Device 0000:00:05.1 failed to qu=
iesce
> > async: error -16
> > [=C2=A0=C2=A0 27.816988][ 1]=C2=A0 PM: quiesce of devices aborted after=
 1833.282
> > msecs
> > [=C2=A0=C2=A0 27.823302][ 1]=C2=A0 PM: start quiesce of devices aborted=
 after
> > 1839.975 msecs
> > ......
> > [=C2=A0=C2=A0 31.303172][ 1]=C2=A0 PM: recover of devices complete afte=
r 3473.039
> > msecs
> > [=C2=A0=C2=A0 31.309818][ 1]=C2=A0 PM: Failed to load hibernation image=
,
> > recovering.
> > [=C2=A0=C2=A0 31.348188][ 1]=C2=A0 PM: Basic memory bitmaps freed
> > [=C2=A0=C2=A0 31.352686][ 1]=C2=A0 OOM killer enabled.
> > [=C2=A0=C2=A0 31.356232][ 1]=C2=A0 Restarting tasks ... done.
> > [=C2=A0=C2=A0 31.360609][ 1]=C2=A0 PM: resume from hibernation failed (=
0)
> > [=C2=A0=C2=A0 31.365800][ 1]=C2=A0 PM: Hibernation image not present or=
 could not
> > be loaded.
> >=20
> > The "do_wakeup" is determined based on whether the controller's
> > power/wakeup attribute is set. The current issue necessitates
> > considering
> > the type of suspend that is occurring. If the suspend type is
> > either
> > PM_EVENT_FREEZE or PM_EVENT_QUIESCE, then "do_wakeup" should be set
> > to
> > false.
> >=20
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202410151722.rfjtknRz-lkp@intel.c=
om/
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > Signed-off-by: Duan Chenghao <duanchenghao@kylinos.cn>
>=20
> What commit id does this fix?

The current patch is not intended to fix an issue with a specific
commit, but rather to address a long-standing problem in the USB core.

>=20
> And I missed where Alan provided a signed-off-by, where was that?

In the following email, Alan proposed using "Signed-off-by" for
signing.
https://lore.kernel.org/all/489805e7-c19c-4b57-9cd7-713e075261cd@rowland.ha=
rvard.edu/

Thanks
Duan Chenghao

>=20
> thanks,
>=20
> greg k-h



