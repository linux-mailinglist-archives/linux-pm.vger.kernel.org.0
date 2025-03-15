Return-Path: <linux-pm+bounces-24098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8786A62A08
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 10:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26FC03AF188
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 09:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201BE1F4630;
	Sat, 15 Mar 2025 09:27:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60947485;
	Sat, 15 Mar 2025 09:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742030850; cv=none; b=jbtE4cm9kPLkddvjEtqdIbH/S53wmyRdhhblrungT8AM9rMwZh1odOnu10nrvkT/WOa/zpj9kqV2y2MzK5WGKkWfrVLqPsElIIv+meVQ8BUUaI5VH7dVlq7bY6Tc2gOl1FV6g81Euc/bZqmcI/PeG5zceESbCKn065Qiae65fR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742030850; c=relaxed/simple;
	bh=WvKPZmJN+aBrVxPyton3c9gvaGrdKJIaVZucaoenKW8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GFbZ2ilVCMS22v97pcJmi/pp7+WurJB+naHGlSKT7rkd9Z27U8nN/PB8bZGeKtlP3bYpEhQA520ZTUFZl0kk3iSWRYvzrNibbq5tjLue5Sj7j/Z8jmi1hVwSpSgVl6g3eTW2sFc7TKIt7QQ9cpwtHALmMQCj2nzKMlG3bdCnkJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZFG5R5vpQz2CchB;
	Sat, 15 Mar 2025 17:24:11 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id E805A1A016C;
	Sat, 15 Mar 2025 17:27:23 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 15 Mar 2025 17:27:23 +0800
Subject: Re: [v4 PATCH 10/13] ubifs: Use crypto_acomp interface
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Richard
 Weinberger <richard@nod.at>, <linux-mtd@lists.infradead.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	<linux-pm@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
	<netdev@vger.kernel.org>
References: <cover.1741954523.git.herbert@gondor.apana.org.au>
 <349a78bc53d3620a29cc6105b55985db51aa0a11.1741954523.git.herbert@gondor.apana.org.au>
 <e5792e49-588d-8dee-0e3e-9e73e4bedebf@huawei.com>
 <Z9VCPB_pcT4ycYyt@gondor.apana.org.au>
 <dfa799fd-5ece-4ea4-d5d0-8c1da39a3a8d@huawei.com>
 <Z9VEkEOul9bt4bc1@gondor.apana.org.au>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <1b6176d7-31a8-7211-b648-a79bd25af6dc@huawei.com>
Date: Sat, 15 Mar 2025 17:27:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z9VEkEOul9bt4bc1@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2025/3/15 17:12, Herbert Xu Ð´µÀ:
> On Sat, Mar 15, 2025 at 05:08:47PM +0800, Zhihao Cheng wrote:
>>
>> According to the warning message, current compressor is zstd. The output
>> buffer size is limited only for LZO compressor by [1].
> 
> Any algorithm can and will produce output longer than the input,
> if you give it enough output buffer.
> 
> Previously an output buffer length of 2x the input length was given
> to all algorithms, meaning that they would all succeed no matter
> whether the input can be compressed or not.
> 
> This has now been changed so that incompressible data is not
> needlessly compressed all the way to the end.  In fact we should
> reduce it further to eliminate the UBIFS_MIN_COMPRESS_DIFF check.

Ah, I get it. Thanks for reminding, and I verify that the root cause is 
the output buffer becomes smaller.
> 
> I will remove the warning on compression since failures are
> expected and reduce the output buffer length further to remove
> the post-compression length check.
> 

I think we should keep the warning, it would be better to distinguish 
the different error types.

