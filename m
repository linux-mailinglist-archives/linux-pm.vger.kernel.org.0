Return-Path: <linux-pm+bounces-15584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7208499BD52
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 03:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AE44B21449
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 01:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB369460;
	Mon, 14 Oct 2024 01:33:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4254917741;
	Mon, 14 Oct 2024 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728869597; cv=none; b=kSywXfr6/j537TkJKvuJc1hn4ANyptdsFIsXmXJoxE/bO/fJ5nOH7r1F3bWzSg9MK9bKZneNVww7UXzMHQKpZ5IVk+qqFlWzP+v0jZa9qrChpSpOVNQojV+nTdkPGRYGlAIYGrr4yxgXi8aS0jOCXUKstZil+yQ+DhrMjij4MF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728869597; c=relaxed/simple;
	bh=K7KkYnXzduFrP5oSPnvT7Em4fgQJPCbnqjdTkYEu3NY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cLmH5bxBambiy2Qobq8qDIYWdlcQ+0d8bRy3u8tHcn3dV0gENNXIDsqjveB7lBbNbNXaxGhOpacUOp9pgQtmUhmhNlI0TYzNxiVwDlDj3yycpNlU+FoJ82z9JWoKHljywYvRYID6FAmBfe8x2SosLMUHjlj4tLRKUeC41QcisHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3f344fc889cc11efa216b1d71e6e1362-20241014
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
X-CID-O-INFO: VERSION:1.1.38,REQID:83f6e01f-99f5-4c21-8779-ad68f5db6b3b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
	N:release,TS:23
X-CID-INFO: VERSION:1.1.38,REQID:83f6e01f-99f5-4c21-8779-ad68f5db6b3b,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
	release,TS:23
X-CID-META: VersionHash:82c5f88,CLOUDID:c4d65cb5e8edec7e89a819a9742e3ae6,BulkI
	D:2409062205428B690IWE,BulkQuantity:54,Recheck:0,SF:64|66|17|19|102,TC:nil
	,Content:1|-5,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:40|20,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,TF_CID_SPAM_FCD,
	TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 3f344fc889cc11efa216b1d71e6e1362-20241014
X-User: duanchenghao@kylinos.cn
Received: from [172.30.80.21] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 44029525; Mon, 14 Oct 2024 09:32:59 +0800
Message-ID: <e15a0430bd6958fe155a06115fc5f5857ab9a337.camel@kylinos.cn>
Subject: Re: [PATCH] USB: Fix the issue of task recovery failure caused by
 USB status when S4 wakes up
From: duanchenghao <duanchenghao@kylinos.cn>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hongyu Xie
 <xy521521@gmail.com>,  gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,  linux-pm@vger.kernel.org,
 linux-usb@vger.kernel.org, niko.mauno@vaisala.com,  pavel@ucw.cz,
 stanley_chang@realtek.com, tj@kernel.org, Hongyu Xie <xiehongyu1@kylinos.cn>
Date: Mon, 14 Oct 2024 09:32:51 +0800
In-Reply-To: <74848334-7cd7-4ce1-ad96-5dd29d70d3bb@rowland.harvard.edu>
References: <bddecd4e-d3c8-448e-8a22-84bbc98c4d1b@kylinos.cn>
	 <b2ec107d4797f6e1e8e558f97c0ad1be6d46572c.camel@kylinos.cn>
	 <84a4f66a-5b0e-46a8-8746-be6cd7d49629@rowland.harvard.edu>
	 <fa347849defa66a7d4af23ac6317ae5b37357ea4.camel@kylinos.cn>
	 <2c368013-8363-4a4e-bfee-2f0b14d01162@rowland.harvard.edu>
	 <5f2f6b979e95e4c2bc33ea0277112939164f6024.camel@kylinos.cn>
	 <d70e070f-5224-402c-ac27-0703b4010b18@rowland.harvard.edu>
	 <0ad92e8fef2f07672aa8e97bc04f20657469ac6e.camel@kylinos.cn>
	 <b8eb28f3-504d-4d26-8b02-ca1ae7309a70@rowland.harvard.edu>
	 <f27bcdb6c5ddd4e91a1dc9f86b4f0c55c50671a8.camel@kylinos.cn>
	 <74848334-7cd7-4ce1-ad96-5dd29d70d3bb@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

=E5=9C=A8 2024-10-12=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 11:01 -0400=EF=BC=
=8CAlan Stern=E5=86=99=E9=81=93=EF=BC=9A
> On Sat, Oct 12, 2024 at 05:51:41PM +0800, duanchenghao wrote:
> >=20
> > Hi Alan,
> >=20
> > The V3 patch has been sent. Please review it to check if it aligns
> > with
> > the solution you described.
>=20
> Yes, that is what I meant.
>=20
> Have you and all the other people at kylinos.cn tested the patch to
> make=20
> sure that it fixes the problem?
>=20

Yes, I'm currently arranging for the testing to be conducted. Since the
S4 test takes time, the test results will be released later. Based on
my understanding, this patch should be able to solve the problem, but I
will rely solely on the actual test results for final confirmation.

> Alan Stern

Duan Chenghao


