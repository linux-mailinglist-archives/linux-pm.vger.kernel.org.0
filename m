Return-Path: <linux-pm+bounces-15568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88B999B2A8
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 11:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3BA2B217D9
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2024 09:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602B014E2E2;
	Sat, 12 Oct 2024 09:52:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534E1610D;
	Sat, 12 Oct 2024 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728726735; cv=none; b=RMNQUCiZzXyGEEUm1bVeNA0sM3EZihpVG9kLjQsVT6hs8uVyPUIvIURVGnbL4HqswYLUZv2w8ASC4dyoXfb8TqDCtLf0WCBvxRwIgAosKrTfjNERu17a6GTSvm26Uxedk9my7/YEvo7HMWlgaDfMt1y28iWcBX2UvuBtcqcSN28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728726735; c=relaxed/simple;
	bh=YM2nOJDHQqCe4ZN10QsJPlTS9MzeI3IK14jzmJprcCs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hj4Jo8vVa0Hl7iXbvf5A8r/9Rc/dgVBmYVUouGRYMp3cROeKa+Pmg1638aUHZpIMDl4hrlhccy/qJV0W0yoM7291cH2NLi3prBVry7cLxvJh9g1djoZ/VxlTy9r7TtY+8WOGtjDrOUv7r/kBdbTIe/pODMkFy2Fo82/gFIuUvtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a45f3154887f11efa216b1d71e6e1362-20241012
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_QP
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:f0b1919e-98f5-4f16-8e46-58bd1e6aba64,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:28,RULE:Release_Ham,AC
	TION:release,TS:23
X-CID-INFO: VERSION:1.1.38,REQID:f0b1919e-98f5-4f16-8e46-58bd1e6aba64,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:28,RULE:Release_Ham,ACTI
	ON:release,TS:23
X-CID-META: VersionHash:82c5f88,CLOUDID:091d50f0acaa3a031b102810ab794131,BulkI
	D:2409062205428B690IWE,BulkQuantity:49,Recheck:0,SF:19|44|64|66|24|17|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40|20,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_OBB,TF_CID_SPAM_FCD
X-UUID: a45f3154887f11efa216b1d71e6e1362-20241012
X-User: duanchenghao@kylinos.cn
Received: from [172.30.80.21] [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2075062559; Sat, 12 Oct 2024 17:52:07 +0800
Message-ID: <f27bcdb6c5ddd4e91a1dc9f86b4f0c55c50671a8.camel@kylinos.cn>
Subject: Re: [PATCH] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
From: duanchenghao <duanchenghao@kylinos.cn>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hongyu Xie
 <xy521521@gmail.com>,  gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,  linux-pm@vger.kernel.org,
 linux-usb@vger.kernel.org, niko.mauno@vaisala.com,  pavel@ucw.cz,
 stanley_chang@realtek.com, tj@kernel.org, Hongyu Xie <xiehongyu1@kylinos.cn>
Date: Sat, 12 Oct 2024 17:51:41 +0800
In-Reply-To: <b8eb28f3-504d-4d26-8b02-ca1ae7309a70@rowland.harvard.edu>
References: <8068130ce4ece6078b2893c4c6333c06c792b6c0.camel@kylinos.cn>
	 <b8dc326b-8aee-4903-bbb6-64083cf66b4d@rowland.harvard.edu>
	 <bddecd4e-d3c8-448e-8a22-84bbc98c4d1b@kylinos.cn>
	 <b2ec107d4797f6e1e8e558f97c0ad1be6d46572c.camel@kylinos.cn>
	 <84a4f66a-5b0e-46a8-8746-be6cd7d49629@rowland.harvard.edu>
	 <fa347849defa66a7d4af23ac6317ae5b37357ea4.camel@kylinos.cn>
	 <2c368013-8363-4a4e-bfee-2f0b14d01162@rowland.harvard.edu>
	 <5f2f6b979e95e4c2bc33ea0277112939164f6024.camel@kylinos.cn>
	 <d70e070f-5224-402c-ac27-0703b4010b18@rowland.harvard.edu>
	 <0ad92e8fef2f07672aa8e97bc04f20657469ac6e.camel@kylinos.cn>
	 <b8eb28f3-504d-4d26-8b02-ca1ae7309a70@rowland.harvard.edu>
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

The V3 patch has been sent. Please review it to check if it aligns with
the solution you described.

Thanks
Duan Chenghao

=E5=9C=A8 2024-10-11=E6=98=9F=E6=9C=9F=E4=BA=94=E7=9A=84 09:53 -0400=EF=BC=
=8CAlan Stern=E5=86=99=E9=81=93=EF=BC=9A
> On Fri, Oct 11, 2024 at 09:42:11AM +0800, duanchenghao wrote:
> > Hi Alan,
> >=20
> > I roughly understand now.
> >=20
> > In your previous email, you mentioned assigning a value to
> > do_wakeup
> > based on the judgment of PMSG in suspend_common, but there is no
> > parameter passing of PMSG in suspend_common.
>=20
> In my kernel tree, the first line of code in suspend_common()
> (following=20
> all the variable definitions) is this:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0do_wakeup =3D PMSG_IS_AUT=
O(msg) ? true :
> device_may_wakeup(dev);
>=20
> That's what I was talking about.
>=20
> > Do you mean using the global parameter pm_transition.event for the
> > judgment?
>=20
> No, I meant what I wrote.
>=20
> Alan Stern


