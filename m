Return-Path: <linux-pm+bounces-17042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332A89BDB33
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 02:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6292DB21BF2
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 01:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076DC188CAD;
	Wed,  6 Nov 2024 01:29:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83FC10E5;
	Wed,  6 Nov 2024 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730856579; cv=none; b=EHL9ZwAtMdgEoN8Dtah2SGpKaajQie5eAi1Yie7PB1mFDIhRRXsZGZdbmap4P3D+p+shsyW9g5n3S1Qw1xx8SrZtPzswFPaO0J0O45QpW8GDi+P5GBppBgd3CSqXnYwq20X905lwB58tfkEahlyH3L8wwDy5zpF/q/RCtcD6Xck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730856579; c=relaxed/simple;
	bh=sEHlccvVIDnUA+pWV3Zdm/HwlJWyCMeUl+3zhMfrAPk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XHYDTkeB8agPRjDM9iK6dYhxw5xskiOSoZ/Ua/7eiNNbH7+FDLATzf2o4oE8LzuIQEtSabS6SkPKjLS+mK5Ua/MYOkWr8c0jJHKprJoSr6gShAcjRPdroeUWndYAuhNYzjF/hnvC97qpgg2GCYrlzYe2GXJ8Ql/XM87HpN+r2CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8e2598c09bde11efa216b1d71e6e1362-20241106
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_QP
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED
	DN_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_C_CI, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:33516c21-8de6-47ef-8293-dc6222754ca8,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-5
X-CID-INFO: VERSION:1.1.38,REQID:33516c21-8de6-47ef-8293-dc6222754ca8,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:da3027b8c79bdb720694bd44dcd65b71,BulkI
	D:241024105327XGBM1VDO,BulkQuantity:10,Recheck:0,SF:44|64|66|841|38|24|17|
	19|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:40,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_OBB,TF_CID_SPAM_ULS,
	TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 8e2598c09bde11efa216b1d71e6e1362-20241106
X-User: duanchenghao@kylinos.cn
Received: from [172.30.80.21] [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2086433120; Wed, 06 Nov 2024 09:29:24 +0800
Message-ID: <2239f30a31d48b326c1b11a2f551439652781419.camel@kylinos.cn>
Subject: Re: [PATCH v4] USB: Fix the issue of task recovery failure caused
 by USB status when S4 wakes up
From: duanchenghao <duanchenghao@kylinos.cn>
To: Greg KH <gregkh@linuxfoundation.org>, stern@rowland.harvard.edu
Cc: stern@rowland.harvard.edu, saranya.gopal@intel.com, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-usb@vger.kernel.org, niko.mauno@vaisala.com, pavel@ucw.cz,
 rafael@kernel.org,  stanley_chang@realtek.com, tj@kernel.org,
 xiehongyu1@kylinos.cn,  xy521521@gmail.com, kernel test robot
 <lkp@intel.com>
Date: Wed, 06 Nov 2024 09:29:15 +0800
In-Reply-To: <31be22e3ee6633e0753a717c7c0994802662a39d.camel@kylinos.cn>
References: <e795d88afb2b485fab97e2be7759664e823fbfad.camel@kylinos.cn>
	 <20241024024038.26157-1-duanchenghao@kylinos.cn>
	 <2024102432-conjoined-skylight-33f1@gregkh>
	 <8aff9a5acbd21d7bd08b80e02ef2b34f2028cedf.camel@kylinos.cn>
	 <2024102911-mooned-precise-f526@gregkh>
	 <31be22e3ee6633e0753a717c7c0994802662a39d.camel@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Greg k-h & Alan,

Excuse me, both of you. I've noticed that you haven't replied to the
emails for quite some time, which prompted me to send this one. I'd
like to inquire if the proposal in the current email is feasible and if
it can be integrated into the community.

Thanks,

Duan Chenghao

=E5=9C=A8 2024-10-29=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 16:01 +0800=EF=BC=
=8Cduanchenghao=E5=86=99=E9=81=93=EF=BC=9A
> hi greg k-h,
>=20
> =E5=9C=A8 2024-10-29=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 04:27 +0100=EF=
=BC=8CGreg KH=E5=86=99=E9=81=93=EF=BC=9A
> > On Thu, Oct 24, 2024 at 04:46:48PM +0800, duanchenghao wrote:
> > > hi greg k-h,
> > >=20
> > > =E5=9C=A8 2024-10-24=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 09:05 +0200=
=EF=BC=8CGreg KH=E5=86=99=E9=81=93=EF=BC=9A
> > > > On Thu, Oct 24, 2024 at 10:40:38AM +0800, Duan Chenghao wrote:
> > > > > When a device is inserted into the USB port and an S4 wakeup
> > > > > is
> > > > > initiated,
> > > > > after the USB-hub initialization is completed, it will
> > > > > automatically enter
> > > > > suspend mode. Upon detecting a device on the USB port, it
> > > > > will
> > > > > proceed with
> > > > > resume and set the hcd to the HCD_FLAG_WAKEUP_PENDING state.
> > > > > During
> > > > > the S4
> > > > > wakeup process, peripherals are put into suspend mode,
> > > > > followed
> > > > > by
> > > > > task
> > > > > recovery. However, upon detecting that the hcd is in the
> > > > > HCD_FLAG_WAKEUP_PENDING state, it will return an EBUSY
> > > > > status,
> > > > > causing the
> > > > > S4 suspend to fail and subsequent task recovery to not
> > > > > proceed.
> > > > > -
> > > > > [=C2=A0=C2=A0 27.594598][ 1]=C2=A0 PM: pci_pm_freeze():
> > > > > hcd_pci_suspend+0x0/0x28
> > > > > returns -16
> > > > > [=C2=A0=C2=A0 27.594601][ 1]=C2=A0 PM: dpm_run_callback():
> > > > > pci_pm_freeze+0x0/0x100
> > > > > returns -16
> > > > > [=C2=A0=C2=A0 27.603420][ 1]=C2=A0 ehci-pci 0000:00:04.1:
> > > > > pci_pm_freeze+0x0/0x100
> > > > > returned 0 after 3 usecs
> > > > > [=C2=A0=C2=A0 27.612233][ 1]=C2=A0 ehci-pci 0000:00:05.1:
> > > > > pci_pm_freeze+0x0/0x100
> > > > > returned -16 after 17223 usecs
> > > > > [=C2=A0=C2=A0 27.810067][ 1]=C2=A0 PM: Device 0000:00:05.1 failed=
 to quiesce
> > > > > async: error -16
> > > > > [=C2=A0=C2=A0 27.816988][ 1]=C2=A0 PM: quiesce of devices aborted=
 after
> > > > > 1833.282
> > > > > msecs
> > > > > [=C2=A0=C2=A0 27.823302][ 1]=C2=A0 PM: start quiesce of devices a=
borted
> > > > > after
> > > > > 1839.975 msecs
> > > > > ......
> > > > > [=C2=A0=C2=A0 31.303172][ 1]=C2=A0 PM: recover of devices complet=
e after
> > > > > 3473.039
> > > > > msecs
> > > > > [=C2=A0=C2=A0 31.309818][ 1]=C2=A0 PM: Failed to load hibernation=
 image,
> > > > > recovering.
> > > > > [=C2=A0=C2=A0 31.348188][ 1]=C2=A0 PM: Basic memory bitmaps freed
> > > > > [=C2=A0=C2=A0 31.352686][ 1]=C2=A0 OOM killer enabled.
> > > > > [=C2=A0=C2=A0 31.356232][ 1]=C2=A0 Restarting tasks ... done.
> > > > > [=C2=A0=C2=A0 31.360609][ 1]=C2=A0 PM: resume from hibernation fa=
iled (0)
> > > > > [=C2=A0=C2=A0 31.365800][ 1]=C2=A0 PM: Hibernation image not pres=
ent or
> > > > > could
> > > > > not
> > > > > be loaded.
> > > > >=20
> > > > > The "do_wakeup" is determined based on whether the
> > > > > controller's
> > > > > power/wakeup attribute is set. The current issue necessitates
> > > > > considering
> > > > > the type of suspend that is occurring. If the suspend type is
> > > > > either
> > > > > PM_EVENT_FREEZE or PM_EVENT_QUIESCE, then "do_wakeup" should
> > > > > be
> > > > > set
> > > > > to
> > > > > false.
> > > > >=20
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Closes:
> > > > > https://lore.kernel.org/oe-kbuild-all/202410151722.rfjtknRz-lkp@i=
ntel.com/
> > > > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > > > Signed-off-by: Duan Chenghao <duanchenghao@kylinos.cn>
> > > >=20
> > > > What commit id does this fix?
> > >=20
> > > The current patch is not intended to fix an issue with a specific
> > > commit, but rather to address a long-standing problem in the USB
> > > core.
> >=20
> > So should it be backported to older stable kernels?=C2=A0 If so, how fa=
r
> > back?
>=20
> yes, It needs to be backported. The stable branches such as 6.6.y,
> 6.10.y, and 6.11.y can be considered for the backport.
>=20
> Should we backport to these versions?
>=20
> Thanks=20
>=20
> Duan Chenghao
> >=20
> > > > And I missed where Alan provided a signed-off-by, where was
> > > > that?
> > >=20
> > > In the following email, Alan proposed using "Signed-off-by" for
> > > signing.
> > > https://lore.kernel.org/all/489805e7-c19c-4b57-9cd7-713e075261cd@rowl=
and.harvard.edu/
> >=20
> > Ah, missed that, sorry.
> >=20
> > thanks,
> >=20
> > greg k-h
>=20


