Return-Path: <linux-pm+bounces-15365-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FF7995CE3
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 03:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2067286F4A
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 01:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659721D69E;
	Wed,  9 Oct 2024 01:20:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4D91C6BE;
	Wed,  9 Oct 2024 01:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728436800; cv=none; b=jdycjrUdhuqp4bWusdZt3BLfiMhyb3SgTwNYgvbdY2uuoNZBcbYVDbNHHK2AgTLCez9u9iV6xeyrw//fkeL5P47ODO3DZg1W7pfhTY3hbYxk1wIsCdB0c8bsC+f8PtkQte2jNNuFFMEilQ305nvYPeS9k00JMygWtLnYsBQpqbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728436800; c=relaxed/simple;
	bh=uygGcT6qHvrybJH2eLlyVe2FguSE5ayAImUP4eDCqac=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GkHCJyvKQA0wZRkl52KHIP7nO3bOmlajUTzwyaIPkj7zVDvd1gMb+I+1rEHHmPtNMkg6KUB3v+B0MrKtFGl/65d1tE6n82L6rhuE+u3XPXjOvUwTJAklGPRxnQoY3eTN3Hb/bNb4B4YmkGKQPhVw2E7HOOqBEK97OG9UOub5j7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 903dd0d685dc11efa216b1d71e6e1362-20241009
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_QP
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI, GTI_FG_IT
	GTI_RG_INFO, GTI_FG_SER, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:570899f7-4243-40a5-92a9-ae7dce16ba38,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:4,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-6
X-CID-INFO: VERSION:1.1.38,REQID:570899f7-4243-40a5-92a9-ae7dce16ba38,IP:0,URL
	:0,TC:0,Content:-5,EDM:0,RT:4,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-6
X-CID-META: VersionHash:82c5f88,CLOUDID:5ef29ecda60a48b00a3bca3a0ea15f74,BulkI
	D:2409062205428B690IWE,BulkQuantity:25,Recheck:0,SF:66|17|19|64|102,TC:nil
	,Content:0,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,
	TF_CID_SPAM_ULS
X-UUID: 903dd0d685dc11efa216b1d71e6e1362-20241009
X-User: duanchenghao@kylinos.cn
Received: from [172.30.80.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1362721873; Wed, 09 Oct 2024 09:19:43 +0800
Message-ID: <0a4dc46ae767c28dd207ae29511ede747f05539a.camel@kylinos.cn>
Subject: Re: [PATCH] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
From: duanchenghao <duanchenghao@kylinos.cn>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Hongyu Xie <xy521521@gmail.com>, gregkh@linuxfoundation.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-usb@vger.kernel.org, niko.mauno@vaisala.com, pavel@ucw.cz, 
 stanley_chang@realtek.com, tj@kernel.org, Hongyu Xie <xiehongyu1@kylinos.cn>
Date: Wed, 09 Oct 2024 09:19:39 +0800
In-Reply-To: <4b27a54007cbc50424662eba6b92cb22a7a528f7.camel@kylinos.cn>
References: <20240906030548.845115-1-duanchenghao@kylinos.cn>
	 <1725931490447646.3.seg@mailgw.kylinos.cn>
	 <a618ada1582c82b58d2503ecf777ea2d726f9399.camel@kylinos.cn>
	 <8b07752d-63c4-41e3-bd20-ce3da43dfffc@rowland.harvard.edu>
	 <8068130ce4ece6078b2893c4c6333c06c792b6c0.camel@kylinos.cn>
	 <b8dc326b-8aee-4903-bbb6-64083cf66b4d@rowland.harvard.edu>
	 <bddecd4e-d3c8-448e-8a22-84bbc98c4d1b@kylinos.cn>
	 <b2ec107d4797f6e1e8e558f97c0ad1be6d46572c.camel@kylinos.cn>
	 <84a4f66a-5b0e-46a8-8746-be6cd7d49629@rowland.harvard.edu>
	 <4b27a54007cbc50424662eba6b92cb22a7a528f7.camel@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Alan,

I haven't received a reply from you since my last email. Could you
please confirm if you have received this one?

I'm worried that there might be an issue with the email system and you
might not be receiving them.

Duanchenghao


=E5=9C=A8 2024-09-29=E6=98=9F=E6=9C=9F=E6=97=A5=E7=9A=84 11:14 +0800=EF=BC=
=8Cduanchenghao=E5=86=99=E9=81=93=EF=BC=9A
> Hi Alan,
>=20
> Please reveiew the patch when you have time.
>=20
> duanchenghao
>=20
> =E5=9C=A8 2024-09-24=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 09:38 -0400=EF=
=BC=8CAlan Stern=E5=86=99=E9=81=93=EF=BC=9A
> > On Mon, Sep 23, 2024 at 04:00:35PM +0800, duanchenghao wrote:
> > > Hi Alan,
> > >=20
> > > Do you think this plan is feasible, or is there any unclear part
> > > in
> > > my
> > > description that needs to be supplemented?
> >=20
> > I apologize for not getting back to you earlier -- I've been
> > incredibly=20
> > busy during the last few weeks.
> >=20
> > I still haven't had time to go over this throroughly.=C2=A0 If I don't=
=20
> > respond by the end of this week, remind me again.
> >=20
> > Alan Stern
> >=20
> > > duanchenghao
> > >=20
> > >=20
> > > =E5=9C=A8 2024-09-14=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 10:43 +0800=
=EF=BC=8CHongyu Xie=E5=86=99=E9=81=93=EF=BC=9A
> > > > From: Hongyu Xie <xiehongyu1@kylinos.cn>
> > > >=20
> > > >=20
> > > > Hi Alan,
> > > > On 2024/9/12 23:00, Alan Stern wrote:
> > > > > On Thu, Sep 12, 2024 at 11:21:26AM +0800, duanchenghao wrote:
> > > > > > =E5=9C=A8 2024-09-11=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 10:40 =
-0400=EF=BC=8CAlan Stern=E5=86=99=E9=81=93=EF=BC=9A
> > > > > > > On Tue, Sep 10, 2024 at 05:36:56PM +0800, duanchenghao
> > > > > > > wrote:
> > > > > > > > S4 wakeup restores the image that was saved before the
> > > > > > > > system
> > > > > > > > entered
> > > > > > > > the S4 sleep state.
> > > > > > > >=20
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 S4 waking up from hibernation
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 kernel initialization
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 |
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 v
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 freeze user task and kernel thread
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 |
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 v
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 load saved image
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 |
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 v
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 freeze the peripheral device and c=
ontroller
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 (Check the HCD_FLAG_WAKEUP_ PENDIN=
G flag of the
> > > > > > > > USB.
> > > > > > > > If
> > > > > > > > it is
> > > > > > > > set,
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return to EBUSY and do not p=
erform the following
> > > > > > > > restore
> > > > > > > > image.)
> > > > > > >=20
> > > > > > > Why is the flag set at this point?=C2=A0 It should not be; th=
e
> > > > > > > device and
> > > > > > > controller should have been frozen with wakeup disabled.
> > > > > > >=20
> > > > > > This is check point, not set point.
> > > > >=20
> > > > > Yes, I know that.=C2=A0 But when the flag was checked, why did th=
e
> > > > > code
> > > > > find
> > > > > that it was set?=C2=A0 The flag should have been clear.
> > > > Maybe duanchenghao means this,
> > > > freeze_kernel_threads
> > > > load_image_and_restore
> > > > =C2=A0=C2=A0 suspend roothub
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 interrupt occurred
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 usb_hcd_resume_root_hub
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set
> > > > HCD_FLAG_WAKEUP_PENDING
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue_work // freezed
> > > > =C2=A0=C2=A0 suspend pci
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 return -EBUSY=C2=A0 because HCD_FLAG_WAKEU=
P_PENDING
> > > >=20
> > > > So s4 resume failed.
> > > > >=20
> > > > > > > Is your problem related to the one discussed in this
> > > > > > > email
> > > > > > > thread?
> > > > > > >=20
> > > > > > > https://lore.kernel.org/linux-usb/d8600868-6e4b-45ab-b328-852=
b6ac8ecb5@rowland.harvard.edu/
> > > > > > >=20
> > > > > > > Would the suggestion I made there -- i.e., have the xhci-
> > > > > > > hcd
> > > > > > > interrupt handler skip calling usb_hcd_resume_root_hub()
> > > > > > > if
> > > > > > > the
> > > > > > > root
> > > > > > > hub
> > > > > > > was suspended with wakeup =3D 0 -- fix your problem?
> > > > > >=20
> > > > > > Skipping usb_hcd_resume_root_hub() should generally be
> > > > > > possible,
> > > > > > but
> > > > > > it's important to ensure that normal remote wakeup
> > > > > > functionality
> > > > > > is not
> > > > > > compromised. Is it HUB_SUSPEND that the hub you are
> > > > > > referring
> > > > > > to
> > > > > > is in
> > > > > > a suspended state?
> > > > >=20
> > > > > I don't understand this question.=C2=A0 hub_quiesce() gets called
> > > > > with
> > > > > HUB_SUSPEND when the hub enters a suspended state.
> > > > >=20
> > > > > You are correct about the need for normal remote wakeup to
> > > > > work
> > > > > properly.=C2=A0 The interrupt handler should skip calling
> > > > > usb_hcd_resume_root_hub() for port connect or disconnect
> > > > > changes
> > > > > and for
> > > > > port overcurrent changes (when the root hub is suspended with
> > > > > wakeup =3D
> > > > > 0).=C2=A0 But it should _not_ skip calling
> > > > > usb_hcd_resume_root_hub()
> > > > > for
> > > > > port
> > > > > resume events.
> > > > >=20
> > > > > Alan Stern
> > > > >=20
> > > >=20
> > > > Hongyu Xie
> > >=20
>=20


