Return-Path: <linux-pm+bounces-16647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 013479B43A3
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 09:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CC21F2362C
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 08:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D8D2038A0;
	Tue, 29 Oct 2024 08:01:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709671DF99F;
	Tue, 29 Oct 2024 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188896; cv=none; b=WZpZstAgSPEggbhDkTCZyqbl5kXiOI3nvrCDs7G0z9M3DunVV9oH9Je9098J9MP5tsPnCdVuzv71Cm/WkazE26Brcd2vu98BEdq4aOPms7oTMK0Zh6mKB37eKlW7rkXpkIY4n2t7oiizhy5zoC531oToXyF/I6nF9/ZTkg7c7uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188896; c=relaxed/simple;
	bh=DWyuuNyI5EivBbhvHm3xZId6MbdsDyCE0SGv5o5janU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W6e2QL9axG0o3lg7u97YQWCI/867HviVodWfyWrYonl2rwHlF6tgPw8xToVnd9uLhcygUN/gLmblFgmumyRoiFaW7CK0ejwL24ri2Pc7C2S2dxRTlhZhLo01L02ljrYwTzPVfxZzXnTF03rGuMClDHWPotgQ9qvVH56h7whw57A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f7eb435495cb11efa216b1d71e6e1362-20241029
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_QP
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI
	GTI_FG_IT, GTI_RG_INFO, GTI_FG_SER, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:1712e57f-e99b-43d8-8d36-38876f304438,IP:25,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:10
X-CID-INFO: VERSION:1.1.38,REQID:1712e57f-e99b-43d8-8d36-38876f304438,IP:25,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-META: VersionHash:82c5f88,CLOUDID:8d7803ee997f5958779c7ebadad8ebc0,BulkI
	D:241024105327XGBM1VDO,BulkQuantity:8,Recheck:0,SF:44|64|66|841|24|17|19|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: f7eb435495cb11efa216b1d71e6e1362-20241029
X-User: duanchenghao@kylinos.cn
Received: from [172.30.80.21] [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 645352901; Tue, 29 Oct 2024 16:01:14 +0800
Message-ID: <31be22e3ee6633e0753a717c7c0994802662a39d.camel@kylinos.cn>
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
Date: Tue, 29 Oct 2024 16:01:04 +0800
In-Reply-To: <2024102911-mooned-precise-f526@gregkh>
References: <e795d88afb2b485fab97e2be7759664e823fbfad.camel@kylinos.cn>
	 <20241024024038.26157-1-duanchenghao@kylinos.cn>
	 <2024102432-conjoined-skylight-33f1@gregkh>
	 <8aff9a5acbd21d7bd08b80e02ef2b34f2028cedf.camel@kylinos.cn>
	 <2024102911-mooned-precise-f526@gregkh>
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

=E5=9C=A8 2024-10-29=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 04:27 +0100=EF=BC=
=8CGreg KH=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, Oct 24, 2024 at 04:46:48PM +0800, duanchenghao wrote:
> > hi greg k-h,
> >=20
> > =E5=9C=A8 2024-10-24=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 09:05 +0200=EF=
=BC=8CGreg KH=E5=86=99=E9=81=93=EF=BC=9A
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
> > > > [=C2=A0=C2=A0 27.594598][ 1]=C2=A0 PM: pci_pm_freeze():
> > > > hcd_pci_suspend+0x0/0x28
> > > > returns -16
> > > > [=C2=A0=C2=A0 27.594601][ 1]=C2=A0 PM: dpm_run_callback():
> > > > pci_pm_freeze+0x0/0x100
> > > > returns -16
> > > > [=C2=A0=C2=A0 27.603420][ 1]=C2=A0 ehci-pci 0000:00:04.1:
> > > > pci_pm_freeze+0x0/0x100
> > > > returned 0 after 3 usecs
> > > > [=C2=A0=C2=A0 27.612233][ 1]=C2=A0 ehci-pci 0000:00:05.1:
> > > > pci_pm_freeze+0x0/0x100
> > > > returned -16 after 17223 usecs
> > > > [=C2=A0=C2=A0 27.810067][ 1]=C2=A0 PM: Device 0000:00:05.1 failed t=
o quiesce
> > > > async: error -16
> > > > [=C2=A0=C2=A0 27.816988][ 1]=C2=A0 PM: quiesce of devices aborted a=
fter
> > > > 1833.282
> > > > msecs
> > > > [=C2=A0=C2=A0 27.823302][ 1]=C2=A0 PM: start quiesce of devices abo=
rted after
> > > > 1839.975 msecs
> > > > ......
> > > > [=C2=A0=C2=A0 31.303172][ 1]=C2=A0 PM: recover of devices complete =
after
> > > > 3473.039
> > > > msecs
> > > > [=C2=A0=C2=A0 31.309818][ 1]=C2=A0 PM: Failed to load hibernation i=
mage,
> > > > recovering.
> > > > [=C2=A0=C2=A0 31.348188][ 1]=C2=A0 PM: Basic memory bitmaps freed
> > > > [=C2=A0=C2=A0 31.352686][ 1]=C2=A0 OOM killer enabled.
> > > > [=C2=A0=C2=A0 31.356232][ 1]=C2=A0 Restarting tasks ... done.
> > > > [=C2=A0=C2=A0 31.360609][ 1]=C2=A0 PM: resume from hibernation fail=
ed (0)
> > > > [=C2=A0=C2=A0 31.365800][ 1]=C2=A0 PM: Hibernation image not presen=
t or could
> > > > not
> > > > be loaded.
> > > >=20
> > > > The "do_wakeup" is determined based on whether the controller's
> > > > power/wakeup attribute is set. The current issue necessitates
> > > > considering
> > > > the type of suspend that is occurring. If the suspend type is
> > > > either
> > > > PM_EVENT_FREEZE or PM_EVENT_QUIESCE, then "do_wakeup" should be
> > > > set
> > > > to
> > > > false.
> > > >=20
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes:
> > > > https://lore.kernel.org/oe-kbuild-all/202410151722.rfjtknRz-lkp@int=
el.com/
> > > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > > Signed-off-by: Duan Chenghao <duanchenghao@kylinos.cn>
> > >=20
> > > What commit id does this fix?
> >=20
> > The current patch is not intended to fix an issue with a specific
> > commit, but rather to address a long-standing problem in the USB
> > core.
>=20
> So should it be backported to older stable kernels?=C2=A0 If so, how far
> back?

yes, It needs to be backported. The stable branches such as 6.6.y,
6.10.y, and 6.11.y can be considered for the backport.

Should we backport to these versions?

Thanks=20

Duan Chenghao
>=20
> > > And I missed where Alan provided a signed-off-by, where was that?
> >=20
> > In the following email, Alan proposed using "Signed-off-by" for
> > signing.
> > https://lore.kernel.org/all/489805e7-c19c-4b57-9cd7-713e075261cd@rowlan=
d.harvard.edu/
>=20
> Ah, missed that, sorry.
>=20
> thanks,
>=20
> greg k-h


