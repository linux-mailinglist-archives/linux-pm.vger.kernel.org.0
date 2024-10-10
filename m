Return-Path: <linux-pm+bounces-15515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAF99998EA
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 03:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15188B22B6E
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 01:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63F08BE5;
	Fri, 11 Oct 2024 01:16:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657D4A31;
	Fri, 11 Oct 2024 01:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728609364; cv=none; b=EBIqvXftUQbDqv7I2snunaAfMuum9a5JQ+/GlJe7gHQlyh+XsWPFeA7gH4d7CgWuf351xfnylo4hXwy5bHe4C+t+/84hUjr08g4sDYJ+NByoHTRYjwX7N4M8FUpc4XH7lwpvpXml/qg4SLU2oYIlhgWNUOFQzQ2qIrSXvi7I5C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728609364; c=relaxed/simple;
	bh=X0fdnhlNWN3WChTKv5072MtcWTbFVZrq4OyGc5KN0lU=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 MIME-Version:Date; b=hxy3glZlNYrVLeLcVARllMByErq+856rOF0xuATiNUuFX+MwTafRb/MWpMiHD0jyAt8G1/4NDkothM3XvPfOBy7WfjScQgUpjSOYSWtwSL3qbVrbD/DbJUjEgRCT+DmAF6krN03VlT9DeBcuLDvMD+Xn3sEFNXrG256XacgIdVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5b0f078e876e11efa216b1d71e6e1362-20241011
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_QP
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:c626f364-f2b2-4676-9331-f0793413ca62,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
	N:release,TS:23
X-CID-INFO: VERSION:1.1.38,REQID:c626f364-f2b2-4676-9331-f0793413ca62,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
	release,TS:23
X-CID-META: VersionHash:82c5f88,CLOUDID:a781ed74474aa5932de4f4e26ca4023d,BulkI
	D:2409062205428B690IWE,BulkQuantity:42,Recheck:0,SF:64|66|38|17|19|102,TC:
	nil,Content:1|-5,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:40|20,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_OBB,TF_CID_SPAM_FCD,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,
	TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 5b0f078e876e11efa216b1d71e6e1362-20241011
X-User: duanchenghao@kylinos.cn
Received: from [172.30.80.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 469428937; Fri, 11 Oct 2024 09:15:51 +0800
Message-ID: <075bed9dc766b31291a57805d2e4a3c72619e3c8.camel@kylinos.cn>
Subject: Re: [PATCH] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
From: duanchenghao <duanchenghao@kylinos.cn>
To: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki"
	 <rafael@kernel.org>
Cc: Hongyu Xie <xy521521@gmail.com>, gregkh@linuxfoundation.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-usb@vger.kernel.org, niko.mauno@vaisala.com, pavel@ucw.cz, 
 stanley_chang@realtek.com, tj@kernel.org, Hongyu Xie <xiehongyu1@kylinos.cn>
In-Reply-To: <2c368013-8363-4a4e-bfee-2f0b14d01162@rowland.harvard.edu>
References: <20240906030548.845115-1-duanchenghao@kylinos.cn>
	 <1725931490447646.3.seg@mailgw.kylinos.cn>
	 <a618ada1582c82b58d2503ecf777ea2d726f9399.camel@kylinos.cn>
	 <8b07752d-63c4-41e3-bd20-ce3da43dfffc@rowland.harvard.edu>
	 <8068130ce4ece6078b2893c4c6333c06c792b6c0.camel@kylinos.cn>
	 <b8dc326b-8aee-4903-bbb6-64083cf66b4d@rowland.harvard.edu>
	 <bddecd4e-d3c8-448e-8a22-84bbc98c4d1b@kylinos.cn>
	 <b2ec107d4797f6e1e8e558f97c0ad1be6d46572c.camel@kylinos.cn>
	 <84a4f66a-5b0e-46a8-8746-be6cd7d49629@rowland.harvard.edu>
	 <fa347849defa66a7d4af23ac6317ae5b37357ea4.camel@kylinos.cn>
	 <2c368013-8363-4a4e-bfee-2f0b14d01162@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Oct 2024 13:53:49 +0800
User-Agent: Evolution 3.44.4-0ubuntu2 

Hi Alan,

=E5=9C=A8 2024-10-09=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 11:50 -0400=EF=BC=
=8CAlan Stern=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, Oct 09, 2024 at 10:35:05AM +0800, duanchenghao wrote:
> > Hi Alan,
> >=20
> > These are two patches, each addressing the same issue. The current
> > patch is a direct solution to the problem of the interrupt bottom
> > half
> > being frozen. The patch you replied with is another, alternative
> > solution to the same problem. Please review which solution is more
> > suitable, or if there are any other revised proposals.
> >=20
> >=20
> > Please review the patch I mentioned:
> > https://lore.kernel.org/all/0a4dc46ae767c28dd207ae29511ede747f05539a.ca=
mel@kylinos.cn/
>=20
> I still think your whole approach is wrong.=C2=A0 There is no need to
> change=20
> the way the HCD_FLAG_WAKEUP_PENDING flag gets set or cleared; that's
> not=20
> the reason for the problem you're seeing.
>=20

Thank you very much for your evaluation of the scheme. I have a
question regarding why the set_bit operation for the
HCD_FLAG_WAKEUP_PENDING flag is performed in the top half of an
interrupt handler, while the clear_bit operation is done in the bottom
half. This seems to contradict conventional practices. The issue is not
limited to S4; if other processes freeze the work queue in the bottom
half, the same problem may arise.

The solution you described below should be able to resolve the current
S4 issue, but for now, we haven't identified any other scenarios that
require the same operation. Based on my understanding, the USB device
is woken up in the bottom half of the interrupt, and both the set_bit
and clear_bit operations for the HCD_FLAG_WAKEUP_PENDING flag should be
executed within the same thread in the bottom half. May I ask if there
are any other reasons why the set_bit is executed in the top half?

> The problem occurs because when suspend_common() in=20
> drivers/usb/core/hcd-pci.c sets do_wakeup, it does so by calling=20
> device_may_wakeup(), and the value that function returns is not what
> we=20
> want.=C2=A0 The value is based on whether the controller's power/wakeup=
=20
> attribute is set, but we also have to take into account the type of=20
> suspend that's happening.
>=20
> Basically, if msg is one of the suspend types for which wakeups
> should=20
> always be disabled, then do_wakeup should be set to false.=C2=A0 There
> isn't=20
> a macro to test for these things, but there should be.=C2=A0 Something
> like=20
> PMSG_IS_AUTO() in include/linux/pm.h; maybe call it
> PMSG_NO_WAKEUP().=C2=A0=20
> This macro should return true if the PM_EVENT_FREEZE or
> PM_EVENT_QUIESCE=20
> bits are set in msg.event.
>=20
> Rafael, please correct me if I got any of this wrong.
>=20
> So the right way to fix the problem is to add to pm.h:
>=20
> #define PMSG_NO_WAKEUP(msg)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(((msg.event) & =
\
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0(PM_EVENT_FREEZE | PM_EVENT_QUIESCE)) !=3D 0)
>=20
> and in suspend_common():
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (PMSG_IS_AUTO(msg))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0do_wakeup =3D true;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else if (PMSG_NO_WAKEUP(m=
sg))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0do_wakeup =3D false;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0do_wakeup =3D device_may_wakeup(dev);
>=20
> Then with do_wakeup set to false, none of the HCD_WAKEUP_PENDING()
> tests=20
> in the following code will be executed, so the routine won't fail
> during=20
> the freeze or restore phase with -EBUSY.
>=20
> You'll also have to define an hcd_pci_freeze() routine, just=20
> like hcd_pci_suspend() except that it uses PMSG_FREEZE instead of=20
> PMSG_SUSPEND.=C2=A0 And the .freeze callback in usb_hcd_pci_pm_ops should
> be=20
> changed to hcd_pci_freeze.
>=20
> In fact, it looks like choose_wakeup() in drivers/usb/core/driver.c=20
> could also use the new macro, instead of checking for FREEZE or
> QUIESCE=20
> directly the way it does now.
>=20
> Alan Stern


