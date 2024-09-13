Return-Path: <linux-pm+bounces-14121-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AC197768A
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 03:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CEE1C24251
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 01:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546968C1F;
	Fri, 13 Sep 2024 01:51:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D980D1FC8;
	Fri, 13 Sep 2024 01:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726192318; cv=none; b=mwmYMigPIdoplmpbx49n+ogtC6vFtxputMJnazp5N783BtxvtyZCy8EbdmF1+kXaTsgXDK0hG8gzTq/DnCoBlDCX2aoRWYGlXDShUxLtAuPp1WigvF9isghL00qXfIxguzI/V9jPp5VWDqZkag0J1AC6qu95vC2BTOOK8r3fVP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726192318; c=relaxed/simple;
	bh=m2YuuK5/NoMzZiGWxExt1KGnDHV8c8/PkeQskUZNWNU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=juV6G9woNLb5gOInT3dTKckPXW5h/OXATQmmEZqztcJ6y/Xm9ZwDs4AXYO7RRSq/Ohm4MAb2gcNmn9xNSwY+F7DL0b7KzyxLq0AFBzXyu/KOrtl6R6Kp3Ndsaz0Tr8pCU6pKgx5bbEhM41Ag0kr5GdcrE5DqOslAO5OCCG/Sbjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: baafb5e2717211efa216b1d71e6e1362-20240913
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:50fe07c5-a2ac-43d4-8ce5-8e03b6ddf441,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-INFO: VERSION:1.1.38,REQID:50fe07c5-a2ac-43d4-8ce5-8e03b6ddf441,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:b9edadf3f44f7a72e7299162749d91dc,BulkI
	D:2409062205428B690IWE,BulkQuantity:12,Recheck:0,SF:64|66|17|19|102,TC:nil
	,Content:1|-5,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,
	TF_CID_SPAM_ULS
X-UUID: baafb5e2717211efa216b1d71e6e1362-20240913
X-User: duanchenghao@kylinos.cn
Received: from [172.30.80.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 66091797; Fri, 13 Sep 2024 09:51:44 +0800
Message-ID: <52b9fd0ab9d279c7da1e2c70e1f023c7e3333ad6.camel@kylinos.cn>
Subject: Re: [PATCH] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
From: duanchenghao <duanchenghao@kylinos.cn>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, pavel@ucw.cz, linux-pm@vger.kernel.org, 
	niko.mauno@vaisala.com, stanley_chang@realtek.com, tj@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date: Fri, 13 Sep 2024 09:51:40 +0800
In-Reply-To: <b8dc326b-8aee-4903-bbb6-64083cf66b4d@rowland.harvard.edu>
References: <20240906030548.845115-1-duanchenghao@kylinos.cn>
	 <1725931490447646.3.seg@mailgw.kylinos.cn>
	 <a618ada1582c82b58d2503ecf777ea2d726f9399.camel@kylinos.cn>
	 <8b07752d-63c4-41e3-bd20-ce3da43dfffc@rowland.harvard.edu>
	 <8068130ce4ece6078b2893c4c6333c06c792b6c0.camel@kylinos.cn>
	 <b8dc326b-8aee-4903-bbb6-64083cf66b4d@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

=E5=9C=A8 2024-09-12=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 11:00 -0400=EF=BC=
=8CAlan Stern=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, Sep 12, 2024 at 11:21:26AM +0800, duanchenghao wrote:
> > =E5=9C=A8 2024-09-11=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 10:40 -0400=EF=
=BC=8CAlan Stern=E5=86=99=E9=81=93=EF=BC=9A
> > > On Tue, Sep 10, 2024 at 05:36:56PM +0800, duanchenghao wrote:
> > > > S4 wakeup restores the image that was saved before the system
> > > > entered
> > > > the S4 sleep state.
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 S4 waking up from hibernation
> > > > =C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > =C2=A0=C2=A0=C2=A0 kernel initialization
> > > > =C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0 v=C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0 freeze user task and kernel thread
> > > > =C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0 v=C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0 load saved image
> > > > =C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0 v=C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0 freeze the peripheral device and controller
> > > > =C2=A0=C2=A0=C2=A0 (Check the HCD_FLAG_WAKEUP_ PENDING flag of the =
USB. If it
> > > > is
> > > > set,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 return to EBUSY and do not perform the fol=
lowing restore
> > > > image.)
> > >=20
> > > Why is the flag set at this point?=C2=A0 It should not be; the device
> > > and=20
> > > controller should have been frozen with wakeup disabled.
> > >=20
> > This is check point, not set point.
>=20
> Yes, I know that.=C2=A0 But when the flag was checked, why did the code
> find=20
> that it was set?=C2=A0 The flag should have been clear.

Yes, the current issue is that during S4 testing, there is a
probabilistic scenario where clear_bit is not called after set_bit, or
clear_bit is called but does not execute after set_bit. Please refer to
the two modification points in the v2 patch for details, as both of
them can cause the current issue.

>=20
> > > Is your problem related to the one discussed in this email
> > > thread?
> > >=20
> > > https://lore.kernel.org/linux-usb/d8600868-6e4b-45ab-b328-852b6ac8ecb=
5@rowland.harvard.edu/
> > >=20
> > > Would the suggestion I made there -- i.e., have the xhci-hcd=20
> > > interrupt handler skip calling usb_hcd_resume_root_hub() if the
> > > root
> > > hub=20
> > > was suspended with wakeup =3D 0 -- fix your problem?
> >=20
> > Skipping usb_hcd_resume_root_hub() should generally be possible,
> > but
> > it's important to ensure that normal remote wakeup functionality is
> > not
> > compromised. Is it HUB_SUSPEND that the hub you are referring to is
> > in
> > a suspended state?
>=20
> I don't understand this question.=C2=A0 hub_quiesce() gets called with=
=20
> HUB_SUSPEND when the hub enters a suspended state.
>=20
> You are correct about the need for normal remote wakeup to work=20
> properly.=C2=A0 The interrupt handler should skip calling=20
> usb_hcd_resume_root_hub() for port connect or disconnect changes and
> for=20
> port overcurrent changes (when the root hub is suspended with wakeup
> =3D=20
> 0).=C2=A0 But it should _not_ skip calling usb_hcd_resume_root_hub() for
> port=20
> resume events.

The current issue arises when rh_state is detected as RH_SUSPEND and
usb_hcd_resume_root_hub() is called to resume the root hub. However,
there is no mutual exclusion between the suspend flag, set_bit, and
clear_bit, which can lead to two scenarios:

    1. After set_bit is called, the state of the USB device is modified
by another process to !USB_STATE_SUSPEND, preventing the hub's resume
from being executed, and consequently, clear_bit is not called again.

    2. In another scenario, during the hub resume process, after
HCD_FLAG_WAKEUP_PENDING is cleared by clear_bit, rh_state has not yet
been set to !RH_SUSPENDED. At this point, set_bit is executed, but
since the hub has already entered the running state, the clear_bit
associated with the resume operation is not executed.

Please review the v2 patch, where I have described both the logical
flow before the modification and the revised logical flow after the
modification.

>=20
> Alan Stern


