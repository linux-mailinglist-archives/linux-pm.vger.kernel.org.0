Return-Path: <linux-pm+bounces-14648-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD2C985516
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 10:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0882A1F244C4
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 08:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44F3158A33;
	Wed, 25 Sep 2024 08:06:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C6614D2BB;
	Wed, 25 Sep 2024 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251603; cv=none; b=K+1NZnQJ++jaImyCFZ7PH1/fDIppj+gfrB0B/qE55LYfMXWa7cQjMI20qLossv42/B//Sm3DEOrppGaUn8INEFgmETe0UTL/mcD1uL4+eoGOtyl7OMpHeHOtKppJRB89XLaWIlHQF1wx9PMy7tEkWrRnI71voA+l3Simg2iDfso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251603; c=relaxed/simple;
	bh=yR8ZPzlojOuGQMgdvt6zlMZL1XkH4oy3FViFpSpTb2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tccD4+4egIZypebCDA0PqpQ5BGfxqSNQc9dDATtN8jBnpOnrQeTS0g+1BaTyh8oEeHIw0EmmjYfg+D0/5t42HiJeDvb22bAVm67SXr1ItHZLynE/Vb3W3MWjq33WjwenRIvF+RZomIIHBO/i3/yzQMiOiOZnZQRhF9z1aBi36NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0e5eb41c7b1511efa216b1d71e6e1362-20240925
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_UNTRUSTED, SA_LOWREP, SA_EXISTED, SN_UNTRUSTED, SN_UNFAMILIAR
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:b315c855-bf32-4aa4-94cb-13f25471b335,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-INFO: VERSION:1.1.38,REQID:b315c855-bf32-4aa4-94cb-13f25471b335,IP:0,URL
	:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:20
X-CID-META: VersionHash:82c5f88,CLOUDID:bd4ce6a220f2334224fd08cd28e9d75c,BulkI
	D:240925144023207KTES0,BulkQuantity:5,Recheck:0,SF:66|17|19|102,TC:nil,Con
	tent:0,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 0e5eb41c7b1511efa216b1d71e6e1362-20240925
X-User: dengjie03@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <dengjie03@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1980744408; Wed, 25 Sep 2024 16:06:23 +0800
From: dengjie <dengjie03@kylinos.cn>
To: gregkh@linuxfoundation.org
Cc: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	xiehongyu1@kylinos.cn,
	duanchenghao@kylinos.cn,
	xiongxin@kylinos.cn
Subject: Re: [PATCH v2] USB: Fix the issue of S4 wakeup queisce phase where task resumption fails due to USB status
Date: Wed, 25 Sep 2024 16:06:18 +0800
Message-Id: <20240925080618.188429-1-dengjie03@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024092543-enforcer-quaintly-9f3e@gregkh>
References: <2024092543-enforcer-quaintly-9f3e@gregkh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> Fixes: 3904bdf0821c ("PM: hibernate: Freeze kernel threads in software_resume()")
>> Signed-off-by: dengjie <dengjie03@kylinos.cn>

>What happened to the other authorship information?
>
I'm very sorry, the information of other authors was 
accidentally added when I was using the script template.

>And again, please use your name, not an email alias.
>
My name is Deng Jie, and dengjie03@kylinos.cn is the 
email account registered with my name, where "03" is 
added to avoid the problem of having the same name.

Thanks,

dengjie

