Return-Path: <linux-pm+bounces-14651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF97985557
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 10:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5EE01C22689
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 08:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2668159568;
	Wed, 25 Sep 2024 08:18:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66F615B968;
	Wed, 25 Sep 2024 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727252320; cv=none; b=FZXmloXyTu+Un7KZ3ienUydPxZ31zZXdZxSz0E5IxbUXyxkABaprDzOiPfzcF+gFa+HDj6xHHMhLlx23lqUQnw6OsTZnLbtebta3SxuPonEfs03WKZ11jx9I/yT79nut59UjK9eJthnzNmybJKAym1HYxwpkPV7WcSFANzKehd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727252320; c=relaxed/simple;
	bh=+0YFLpub1Y4HInlgfqUnAB+eG+j44TxlEcYL8WdQX0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OuJ/4qiWPGZXdv/zxmtKEgyg7wHQjZV5HMEA/HCqiKhdo/CxUJahazdbEQ6XPXVN2vCXgEb1ddvd8WiCostHyBteyBARcH370yI01hp6sfBBTW9BRLLxwwR+LY2IwDhp5cc16wkamjGuzCWzZ/Hc3/Il109nYr5RtzAMJ2+FmQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bfe770927b1611efa216b1d71e6e1362-20240925
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_UNTRUSTED, SA_LOWREP, SA_EXISTED, SN_UNTRUSTED, SN_UNFAMILIAR
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:6f8d0b0c-46bc-49b8-bf8b-8ab908dc377f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-INFO: VERSION:1.1.38,REQID:6f8d0b0c-46bc-49b8-bf8b-8ab908dc377f,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:695219811593fbe85e15dfcede684a86,BulkI
	D:240925144023207KTES0,BulkQuantity:9,Recheck:0,SF:64|66|17|19|817|102,TC:
	nil,Content:0|-5,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: bfe770927b1611efa216b1d71e6e1362-20240925
X-User: dengjie03@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <dengjie03@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2091786093; Wed, 25 Sep 2024 16:18:31 +0800
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
Date: Wed, 25 Sep 2024 16:18:27 +0800
Message-Id: <20240925081827.189845-1-dengjie03@kylinos.cn>
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

>> Reproduction of the problem: During the S4 stress test, when a USB device is inserted or
>> removed, there is a probability that the S4 wakeup will turn into a reboot.The following
>> two points describe how to analyze and locate the problem points:
>
>Also please wrap your paragraphs at a much narrower line length like 72
>or 75 characters or so.
>
Thank you for pointing out the problem. I will pay attention to it in 
the future.

Thanks,

dengjie

