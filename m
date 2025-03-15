Return-Path: <linux-pm+bounces-24082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F07A5A62650
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 06:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62ABE175F4A
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 05:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAF018B484;
	Sat, 15 Mar 2025 05:08:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7084C5228;
	Sat, 15 Mar 2025 05:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742015310; cv=none; b=BXidaY8sQ5kakzbvpiMog0whYhLJcsHuQQzxjnlhYP/6+ZAV7bVoC8liz+6HMqCBiJB0kVenQzE7R+5Zqho9/28F04L1ZUx9Bd28eAWXtu2Y+E7EdSGWAKBuSlp45M186ZLyrf2b1juW3o1t9gIJVugeACykyoN80zh6TBH69LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742015310; c=relaxed/simple;
	bh=EG4cjoHOnE2X2PAW04QcW/jn7WS2xMGsBvp8UpA1+pQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cvE6c5Wno2hhgJglCdO3o1u2fdWojode78NVjzWTiI1SLSeXzp2rHl/CXHNByVSlskt9tJmiQjPvA0BVP4GlUO5YEsZtNcNUkdiesQWxIAjPQ3KLqHYBm+ly3et/fWylFTsdmXSoH6muQfY1Pv8YcMbl1jEiaKI+PDYojl5X4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZF8K91pNRz1f0sc;
	Sat, 15 Mar 2025 13:03:57 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id E65A61402E1;
	Sat, 15 Mar 2025 13:08:22 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 15 Mar 2025 13:08:22 +0800
Subject: Re: [v4 PATCH 10/13] ubifs: Use crypto_acomp interface
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Richard
 Weinberger <richard@nod.at>, <linux-mtd@lists.infradead.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	<linux-pm@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
	<netdev@vger.kernel.org>
References: <cover.1741954523.git.herbert@gondor.apana.org.au>
 <349a78bc53d3620a29cc6105b55985db51aa0a11.1741954523.git.herbert@gondor.apana.org.au>
 <023a23b0-d9fd-6d4d-d5a2-207e47419645@huawei.com>
 <Z9T79PKW0TFO-2xl@gondor.apana.org.au>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <f4a51d32-0b04-2c27-924d-f3a54d6b63a5@huawei.com>
Date: Sat, 15 Mar 2025 13:08:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z9T79PKW0TFO-2xl@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2025/3/15 12:03, Herbert Xu Ð´µÀ:
> On Sat, Mar 15, 2025 at 11:54:43AM +0800, Zhihao Cheng wrote:
>>
>> We get capi_name by 'crypto_acomp_alg_name(crypto_acomp_reqtfm(req))', not
>> compr->name.
> 
> It should return the same string.

The crypto_acomp_alg_name() gets name from compr->cc(the name is 
initialized by compr->capi_name).
I got the following messages after verifying:
[  154.907048] UBIFS warning (ubi0:0 pid 110): ubifs_compress_req.isra.0 
[ubifs]: cannot compress 4096 bytes, compressor deflate, error -12, 
leave data uncompressed

The 'deflate' is zlib compressor's capi_name, but we expect it be 'zlib' 
here.
> 
>> There are conflicts in patch 2 on the latest mainline version, can you
>> rebase this series so I can do some tests for UBIFS.
> 
> Thanks for testing! I've just pushed it to
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git acomp
> 
> So you should be able to pull that to test.
> 
> Cheers,
> 


