Return-Path: <linux-pm+bounces-14552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A74A97E70A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 10:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1BED1F21825
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 08:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9355838397;
	Mon, 23 Sep 2024 08:00:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3DABE5E;
	Mon, 23 Sep 2024 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078452; cv=none; b=UfHswa26cH1pvdeCXGk/mZd0Jx7T60D8l4VHHaXreGhcqf2s3u1GWSvPqslnGU/HnggWnRgwvtazPKCnZomL6Fba8pbZCXCrOIL4sl5GRnrC+6LJRnlRTPMU+RoWiBPCN3nylFZOwo9WMaUuN7eHvdxRrIGPKnx4OFN4gc9aP9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078452; c=relaxed/simple;
	bh=h7TD2Rc4yDS+RKMF9p5uRg7KiVZgwGR29KUk2p36pEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M2n1r4JAHjmiH43D5T5634srTr2FFAuhemBJOT95tlPlZ3LqR1WXCQUQUerX1sj5iglWDe6O3cUhnMRUa4ZLU1iKVpzGI0JlNQaL3AufecLjGjiBSOwi3EH1r4lSVZTu1EP0ULffrZRj4JY9BRCSfMTvNDxbOCbGjRcJxY5rxoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ecd718b4798111efa216b1d71e6e1362-20240923
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_QP
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED
	DN_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_ED
	GTI_C_CI, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:f0e27d6b-7620-474f-847a-072d5e28ef71,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-INFO: VERSION:1.1.38,REQID:f0e27d6b-7620-474f-847a-072d5e28ef71,IP:0,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-10
X-CID-META: VersionHash:82c5f88,CLOUDID:468851687257fa3dde0479ee0944718a,BulkI
	D:2409062205428B690IWE,BulkQuantity:18,Recheck:0,SF:64|66|38|17|19|102,TC:
	nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,
	TF_CID_SPAM_FAS
X-UUID: ecd718b4798111efa216b1d71e6e1362-20240923
X-User: duanchenghao@kylinos.cn
Received: from [172.30.80.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1188481415; Mon, 23 Sep 2024 16:00:40 +0800
Message-ID: <b2ec107d4797f6e1e8e558f97c0ad1be6d46572c.camel@kylinos.cn>
Subject: Re: [PATCH] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
From: duanchenghao <duanchenghao@kylinos.cn>
To: Hongyu Xie <xy521521@gmail.com>, stern@rowland.harvard.edu
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
 niko.mauno@vaisala.com,  pavel@ucw.cz, stanley_chang@realtek.com,
 tj@kernel.org, Hongyu Xie <xiehongyu1@kylinos.cn>
Date: Mon, 23 Sep 2024 16:00:35 +0800
In-Reply-To: <bddecd4e-d3c8-448e-8a22-84bbc98c4d1b@kylinos.cn>
References: <20240906030548.845115-1-duanchenghao@kylinos.cn>
	 <1725931490447646.3.seg@mailgw.kylinos.cn>
	 <a618ada1582c82b58d2503ecf777ea2d726f9399.camel@kylinos.cn>
	 <8b07752d-63c4-41e3-bd20-ce3da43dfffc@rowland.harvard.edu>
	 <8068130ce4ece6078b2893c4c6333c06c792b6c0.camel@kylinos.cn>
	 <b8dc326b-8aee-4903-bbb6-64083cf66b4d@rowland.harvard.edu>
	 <bddecd4e-d3c8-448e-8a22-84bbc98c4d1b@kylinos.cn>
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

Do you think this plan is feasible, or is there any unclear part in my
description that needs to be supplemented?

duanchenghao


=E5=9C=A8 2024-09-14=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 10:43 +0800=EF=BC=
=8CHongyu Xie=E5=86=99=E9=81=93=EF=BC=9A
> From: Hongyu Xie <xiehongyu1@kylinos.cn>
>=20
>=20
> Hi Alan,
> On 2024/9/12 23:00, Alan Stern wrote:
> > On Thu, Sep 12, 2024 at 11:21:26AM +0800, duanchenghao wrote:
> > > =E5=9C=A8 2024-09-11=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 10:40 -0400=
=EF=BC=8CAlan Stern=E5=86=99=E9=81=93=EF=BC=9A
> > > > On Tue, Sep 10, 2024 at 05:36:56PM +0800, duanchenghao wrote:
> > > > > S4 wakeup restores the image that was saved before the system
> > > > > entered
> > > > > the S4 sleep state.
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 S4 waking up from hibernation
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 kernel initialization
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 |
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 v
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 freeze user task and kernel thread
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 |
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 v
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 load saved image
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 |
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 v
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 freeze the peripheral device and control=
ler
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 (Check the HCD_FLAG_WAKEUP_ PENDING flag=
 of the USB. If
> > > > > it is
> > > > > set,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return to EBUSY and do not perform=
 the following
> > > > > restore
> > > > > image.)
> > > >=20
> > > > Why is the flag set at this point?=C2=A0 It should not be; the
> > > > device and
> > > > controller should have been frozen with wakeup disabled.
> > > >=20
> > > This is check point, not set point.
> >=20
> > Yes, I know that.=C2=A0 But when the flag was checked, why did the code
> > find
> > that it was set?=C2=A0 The flag should have been clear.
> Maybe duanchenghao means this,
> freeze_kernel_threads
> load_image_and_restore
> =C2=A0=C2=A0 suspend roothub
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 interrupt occurred
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 usb_hcd_resume_root_hub
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 set HCD_FLAG_WAKEUP_PENDING
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 queue_work // freezed
> =C2=A0=C2=A0 suspend pci
> =C2=A0=C2=A0=C2=A0=C2=A0 return -EBUSY=C2=A0 because HCD_FLAG_WAKEUP_PEND=
ING
>=20
> So s4 resume failed.
> >=20
> > > > Is your problem related to the one discussed in this email
> > > > thread?
> > > >=20
> > > > https://lore.kernel.org/linux-usb/d8600868-6e4b-45ab-b328-852b6ac8e=
cb5@rowland.harvard.edu/
> > > >=20
> > > > Would the suggestion I made there -- i.e., have the xhci-hcd
> > > > interrupt handler skip calling usb_hcd_resume_root_hub() if the
> > > > root
> > > > hub
> > > > was suspended with wakeup =3D 0 -- fix your problem?
> > >=20
> > > Skipping usb_hcd_resume_root_hub() should generally be possible,
> > > but
> > > it's important to ensure that normal remote wakeup functionality
> > > is not
> > > compromised. Is it HUB_SUSPEND that the hub you are referring to
> > > is in
> > > a suspended state?
> >=20
> > I don't understand this question.=C2=A0 hub_quiesce() gets called with
> > HUB_SUSPEND when the hub enters a suspended state.
> >=20
> > You are correct about the need for normal remote wakeup to work
> > properly.=C2=A0 The interrupt handler should skip calling
> > usb_hcd_resume_root_hub() for port connect or disconnect changes
> > and for
> > port overcurrent changes (when the root hub is suspended with
> > wakeup =3D
> > 0).=C2=A0 But it should _not_ skip calling usb_hcd_resume_root_hub() fo=
r
> > port
> > resume events.
> >=20
> > Alan Stern
> >=20
>=20
> Hongyu Xie


