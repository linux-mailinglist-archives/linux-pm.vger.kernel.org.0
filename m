Return-Path: <linux-pm+bounces-15518-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F969999B1
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 03:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1F57B21421
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 01:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30E7E56C;
	Fri, 11 Oct 2024 01:42:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2BF5256;
	Fri, 11 Oct 2024 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728610949; cv=none; b=JtXjGQ+/lcXQ+B2y7RQt4M3YaulZCa4hyj1EbgMOPO8VcrGwdzlheYwTry9EUcf6vy1uchMerwN4zpYe0s9B032H34Avo9gXIATfC6Gb19ZpWpaGEEVOsW8CHXDe17T8zQzkpYKAIKrSpqP6/XGQExLKHSzImOdIXblFSBlVZJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728610949; c=relaxed/simple;
	bh=f2dMoScAMjBtyqLW+aVYSSEnpRqBkVrhbYqObYmKrmM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rWNmhkw1A7dPzAMb5jngfXA+e0S+t191FwxZf1W284FFZzfOnt6eW+QGlZKPGLwdyPo6Q6dfQNO/UYOjXBUc//oNGN/AB8wHe/4A5FoQncDI/NPRR/tl7uQwSRFHSjBNb0rZdMW5mjSTxE6nUi3mQH5jFPbrq4BIQ6aMlOSDiOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0bcdcfe4877211efa216b1d71e6e1362-20241011
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
X-CID-O-INFO: VERSION:1.1.38,REQID:6de5114d-8d2e-48cc-a0a7-d0e499e21d07,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
	N:release,TS:23
X-CID-INFO: VERSION:1.1.38,REQID:6de5114d-8d2e-48cc-a0a7-d0e499e21d07,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
	release,TS:23
X-CID-META: VersionHash:82c5f88,CLOUDID:da190a37cf2f4b0084d9db82a8fcb2e9,BulkI
	D:2409062205428B690IWE,BulkQuantity:44,Recheck:0,SF:64|66|17|19|102,TC:nil
	,Content:1|-5,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:40|20,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,
	TF_CID_SPAM_FCD
X-UUID: 0bcdcfe4877211efa216b1d71e6e1362-20241011
X-User: duanchenghao@kylinos.cn
Received: from [172.30.80.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1290677965; Fri, 11 Oct 2024 09:42:16 +0800
Message-ID: <0ad92e8fef2f07672aa8e97bc04f20657469ac6e.camel@kylinos.cn>
Subject: Re: [PATCH] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
From: duanchenghao <duanchenghao@kylinos.cn>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hongyu Xie
 <xy521521@gmail.com>,  gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,  linux-pm@vger.kernel.org,
 linux-usb@vger.kernel.org, niko.mauno@vaisala.com,  pavel@ucw.cz,
 stanley_chang@realtek.com, tj@kernel.org, Hongyu Xie <xiehongyu1@kylinos.cn>
Date: Fri, 11 Oct 2024 09:42:11 +0800
In-Reply-To: <d70e070f-5224-402c-ac27-0703b4010b18@rowland.harvard.edu>
References: <a618ada1582c82b58d2503ecf777ea2d726f9399.camel@kylinos.cn>
	 <8b07752d-63c4-41e3-bd20-ce3da43dfffc@rowland.harvard.edu>
	 <8068130ce4ece6078b2893c4c6333c06c792b6c0.camel@kylinos.cn>
	 <b8dc326b-8aee-4903-bbb6-64083cf66b4d@rowland.harvard.edu>
	 <bddecd4e-d3c8-448e-8a22-84bbc98c4d1b@kylinos.cn>
	 <b2ec107d4797f6e1e8e558f97c0ad1be6d46572c.camel@kylinos.cn>
	 <84a4f66a-5b0e-46a8-8746-be6cd7d49629@rowland.harvard.edu>
	 <fa347849defa66a7d4af23ac6317ae5b37357ea4.camel@kylinos.cn>
	 <2c368013-8363-4a4e-bfee-2f0b14d01162@rowland.harvard.edu>
	 <5f2f6b979e95e4c2bc33ea0277112939164f6024.camel@kylinos.cn>
	 <d70e070f-5224-402c-ac27-0703b4010b18@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

=E5=9C=A8 2024-10-10=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 10:21 -0400=EF=BC=
=8CAlan Stern=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, Oct 10, 2024 at 01:59:08PM +0800, duanchenghao wrote:
> > Hi Alan,
>=20
> > Thank you very much for your evaluation of the scheme. I have a
> > question regarding why the set_bit operation for the
> > HCD_FLAG_WAKEUP_PENDING flag is performed in the top half of an
> > interrupt handler, while the clear_bit operation is done in the
> > bottom
> > half. This seems to contradict conventional practices. The issue is
> > not
> > limited to S4; if other processes freeze the work queue in the
> > bottom
> > half, the same problem may arise.
>=20
> The flag is treated this way because that's what it means: A wakeup
> is=20
> pending.=C2=A0 The kernel first learns about the wakeup when it receives
> the=20
> wakeup interrupt from the host controller, so that's when it sets the
> flag -- in the top half of the interrupt handler.=C2=A0 The wakeup
> procedure=20
> isn't complete until the root hub has been resumed, so the flag
> remains=20
> set until that resume is finished, in the bottom half.
>=20
> You say "the same problem may arise", but I don't think it is a
> problem.=C2=A0=20
> If the system is about to suspend the host controller with wakeups=20
> enabled, and a wakeup request has already been received but the
> system=20
> has not yet finished acting on it, then the suspend _should_ fail.=C2=A0=
=20
> After all, if the wakeup interrupt had arrived just after the host=20
> controller was suspended rather than just before, it would have
> caused=20
> the host controller to be resumed right away -- with exactly the same
> effect as if the controller had never been suspended in the first
> place.
>=20
> > The solution you described below should be able to resolve the
> > current
> > S4 issue, but for now, we haven't identified any other scenarios
> > that
> > require the same operation.
>=20
> Perhaps because there aren't any.
>=20
> > =C2=A0Based on my understanding, the USB device
> > is woken up in the bottom half of the interrupt,
>=20
> You are failing to distinguish between the host controller and the
> root=20
> hub.=C2=A0 The host controller (which is a PCI device on your system, not
> a=20
> USB device) is woken up in the top half of the interrupt handler.=C2=A0
> The=20
> root hub (which is a virtual USB device) is woken up in the bottom
> half.=C2=A0=20
> Both operations have to occur before the wakeup can be considered
> fully=20
> complete.
>=20
> > =C2=A0and both the set_bit
> > and clear_bit operations for the HCD_FLAG_WAKEUP_PENDING flag
> > should be
> > executed within the same thread in the bottom half. May I ask if
> > there
> > are any other reasons why the set_bit is executed in the top half?
>=20
> Because the root hub's wakeup becomes pending when the host
> controller=20
> is resumed, in the top half.
>=20
> Alan Stern
>=20

Hi Alan,

I roughly understand now.

In your previous email, you mentioned assigning a value to do_wakeup
based on the judgment of PMSG in suspend_common, but there is no
parameter passing of PMSG in suspend_common.

Do you mean using the global parameter pm_transition.event for the
judgment?

Thanks
Duanchenghao



