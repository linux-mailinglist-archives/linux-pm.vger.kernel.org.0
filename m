Return-Path: <linux-pm+bounces-24096-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E73A62997
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 10:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEF23B2ACC
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 09:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50BF1F4275;
	Sat, 15 Mar 2025 09:08:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064BD1DC99C;
	Sat, 15 Mar 2025 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742029735; cv=none; b=lAAomQOUA22iubAveKlV8KubXi6AgEFZXzzFSXq7HzEMwxvQaKjitMMsRlIFENsDHYrLlbZbrKhS7BY0I0Fkx5RE9Vc8DmoAY/YntssKAhEbBlezNZlniFAczpIR6rktdYgibzcHRVdjW8FWI3FS+6BXXu2uop6leow6in2FhFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742029735; c=relaxed/simple;
	bh=wNZDhXoG7gxKCl9k5tdaMabTIkWl9Utr0B+PTGM3Yck=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NKyzwPsp2x0GVZZoT+VTIDTKrd0FP9g5cH3i8YcWKquBahiQZyaS/ZjsBSCG+/6veM91CqAE8cnHDxUEZsUWGNVawZwKrZSc061tSvwfw4L7avdwd8m/g27dg2uOUf9QhtdnYsD0V992TddBvPX3Z7d/MmNlCM+H3yE0zzd+vfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZFFlY2q6Zz1cyhS;
	Sat, 15 Mar 2025 17:08:41 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id AA55E14010D;
	Sat, 15 Mar 2025 17:08:49 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 15 Mar 2025 17:08:48 +0800
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
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <dfa799fd-5ece-4ea4-d5d0-8c1da39a3a8d@huawei.com>
Date: Sat, 15 Mar 2025 17:08:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z9VCPB_pcT4ycYyt@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2025/3/15 17:02, Herbert Xu Ð´µÀ:
> On Sat, Mar 15, 2025 at 04:58:31PM +0800, Zhihao Cheng wrote:
>>
>> Hi, Herbert, I got some warning messages while running xfstests, it looks
>> like the compressor returns error code.
> 
> Yes this is expected as incompressible data will now show up as
> errors since we reduced the output buffer size due to LZO getting
> fixed.  I'll silence that warning.

According to the warning message, current compressor is zstd. The output 
buffer size is limited only for LZO compressor by [1].

ubifs_compress_req [ubifs]: cannot compress 4096 bytes, compressor zstd, 
error -22, leave data uncompressed

[1] 
https://web.git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/commit/?id=cc47f07234f72cbd8e2c973cdbf2a6730660a463
> 
> There are no reasons why compression should fail, other than the
> data being incompressible.
> 
> Thanks,
> 


