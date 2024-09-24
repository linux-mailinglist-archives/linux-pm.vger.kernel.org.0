Return-Path: <linux-pm+bounces-14609-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFA6984411
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 12:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A734A1F20E9B
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 10:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B641A3AA6;
	Tue, 24 Sep 2024 10:59:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08631B85DD;
	Tue, 24 Sep 2024 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727175582; cv=none; b=pyE4aH1AZUDZaXmmJgYDe3gr9zCSLu4GIvfL1NSIOcXppj/oi6Izrsh88qNDkoEUQycM67CECQaYoRynj3uOMRKVmGzBgRCrWqn492t+VcC2HGUbqXnsqPNwaENuUDuypflP9M7ZSxVjfyEpn0PYBXIiWq6Gpw1wX69iDoTYMzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727175582; c=relaxed/simple;
	bh=CJg4Rz2N2irdTkuMFK0MyRbFiPIou0WWPR96DZHZqKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jw0duqBHFGAOJlml7KXViW5DRcmrkThOFA4NrGHj32f/aU+Bp8cGxGipW60zIHwTImIiH5ef/ux95kaA538dAA1X3ocP7zvchBCt4ZGL0Wmnz2im+dhSAuXOIa4/xzwTd3r47/YnR9qcvpfZ7hr5A1xXG72DxoCAMCsDuDMU2h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 10c93ad07a6411efa216b1d71e6e1362-20240924
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_UNTRUSTED, SA_UNFAMILIAR, SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:5961a713-d95c-4801-86a0-a51f2e5d2fdb,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-INFO: VERSION:1.1.38,REQID:5961a713-d95c-4801-86a0-a51f2e5d2fdb,IP:0,URL
	:0,TC:0,Content:0,EDM:25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:30
X-CID-META: VersionHash:82c5f88,CLOUDID:fd4042185f7b3dabe0c66f92e52e2d9f,BulkI
	D:240923210716N7U1R7ME,BulkQuantity:5,Recheck:0,SF:66|72|19|102,TC:nil,Con
	tent:0,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: 10c93ad07a6411efa216b1d71e6e1362-20240924
X-User: dengjie03@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <dengjie03@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 349808720; Tue, 24 Sep 2024 18:59:26 +0800
From: dengjie <dengjie03@kylinos.cn>
To: gregkh@linuxfoundation.org
Cc: dengjie03@kylinos.cn,
	duanchenghao@kylinos.cn,
	len.brown@intel.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pavel@ucw.cz,
	rafael@kernel.org,
	xiehongyu1@kylinos.cn,
	xiongxin@kylinos.cn
Subject: Re: [PATCH] KYLIN: USB: Fix the issue of S4 wakeup queisce phase where task resumption fails due to USB status
Date: Tue, 24 Sep 2024 18:59:23 +0800
Message-Id: <20240924105923.119066-1-dengjie03@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024092355-chip-stuffy-bd93@gregkh>
References: <2024092355-chip-stuffy-bd93@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>Please read the documentation for how to list a Fixes: tag, it should be
>a bit smaller than this line :)
>
I will correct the format

>As the documentation states, we need real names, not email aliases.

>And fix up how you use co-developed-by please, again, the documentation
>shows how to do so.
>
Ok, thank you. I will make the modification.

>What happens if it changes right after this?  Where is the locking
>involved?  And why does USB only care about this and no other subsystem?
>
After the power management enters the quiesce phase, its state will be 
maintained for a relatively long period of time. It will only proceed to 
the restore phase after all devices have been frozen.

Thanks,

dengjie

