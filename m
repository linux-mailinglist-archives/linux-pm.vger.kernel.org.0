Return-Path: <linux-pm+bounces-24280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6CCA68CE2
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 13:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2FB43B2E6A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 12:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396A5255248;
	Wed, 19 Mar 2025 12:28:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593A454758;
	Wed, 19 Mar 2025 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387303; cv=none; b=d4Cj92TK6hKrX/QId6XE32l7Axzsg0dsbTmp2bQhK/uWk/+xl1vC/jjCz1iOAIWnVW2AL4LHKfLoTQMMNLZqusdmmpEq/KMz21Acl59xxJzYJ08CpWJBNJFX9OfEgzrEuigeAokjuyAU5LOMtL8L0Vw3bVouvPzsppr1jhWA2Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387303; c=relaxed/simple;
	bh=g3gpu8iZvnxAHE9cyiCJRPk0Fq6KQl9BhIcCPbX1lh0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ir6kUcvJBvpwNAEiBOv0JWd5HmOWgQ19x8fxVnrh91xWS6xgLp3SfB2g7v41LPMQdoFj+CP78EpiTUcnZ5pvIFxwzxMj9oE15fzUR8HOG+2axOjIQZosFLh85rqcGhd+RtBZCq6kitmIFcT0HCrqIpEcznTXWUUU6/Kj8teuZdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZHnwG4TVzzph7P;
	Wed, 19 Mar 2025 20:25:02 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E3FF180044;
	Wed, 19 Mar 2025 20:28:16 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Mar 2025 20:28:15 +0800
Subject: Re: [v5 PATCH 14/14] ubifs: Pass folios to acomp
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Richard
 Weinberger <richard@nod.at>, <linux-mtd@lists.infradead.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	<linux-pm@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
	<netdev@vger.kernel.org>
References: <cover.1742034499.git.herbert@gondor.apana.org.au>
 <99ae6a15afc1478bab201949dc3dbb2c7634b687.1742034499.git.herbert@gondor.apana.org.au>
 <9f77f2a4-e4ba-813e-f44d-3a42d9637d0f@huawei.com>
 <Z9qSkRbwig5VXstP@gondor.apana.org.au>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <82697910-2359-b96c-e454-e38abd8c0a7a@huawei.com>
Date: Wed, 19 Mar 2025 20:28:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z9qSkRbwig5VXstP@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2025/3/19 17:46, Herbert Xu Ð´µÀ:
> On Wed, Mar 19, 2025 at 05:44:17PM +0800, Zhihao Cheng wrote:
>>
>> Tested-by: Zhihao Cheng <chengzhihao1@huawei.com> # For xfstests
> 
> Thank you for testing!
> 
>>>
>>> diff --git a/fs/ubifs/compress.c b/fs/ubifs/compress.c
>>> index a241ba01c9a8..ea6f06adcd43 100644
>>> --- a/fs/ubifs/compress.c
>>> +++ b/fs/ubifs/compress.c
>>> @@ -16,6 +16,7 @@
>>>     */
>>>    #include <crypto/acompress.h>
>>> +#include <linux/highmem.h>
>>>    #include "ubifs.h"
>>>    /* Fake description object for the "none" compressor */
>>> @@ -126,7 +127,7 @@ void ubifs_compress(const struct ubifs_info *c, const void *in_buf,
>>>    	{
>>>    		ACOMP_REQUEST_ALLOC(req, compr->cc, GFP_NOFS | __GFP_NOWARN);
>>> -		acomp_request_set_src_nondma(req, in_buf, in_len);
>>> +		acomp_request_set_src_dma(req, in_buf, in_len);
>>
>> Why not merging it into patch 13?
> 
> Because it will break without this patch.  If the input is a highmem
> folio it cannot be directly passed over to DMA (because the virtual
> address has been remapped by kmap_local).

Makes sense.
> 
> Cheers,
> 


