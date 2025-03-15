Return-Path: <linux-pm+bounces-24083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B610EA6266C
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 06:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA9A19C4548
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 05:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDD818DB3D;
	Sat, 15 Mar 2025 05:15:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383A21863E;
	Sat, 15 Mar 2025 05:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742015722; cv=none; b=NrfmaHl1Xkp82xApHJ3TBHTACtoq0/VvFRwxw1oin4Gznc6jHGOQVjMLzK0K9/nMWJyDlSbdpiD/Y7UK23w3GsmrFXP3wUDfTW2sY9EdWIig0+fvJC2o++NPdPw8XDIDeqvAZ/FLJYk+Nl1Q/xErmgfFRjzq51wz+MjGT9m02LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742015722; c=relaxed/simple;
	bh=zU2OjNVSTqN4GDJE+zve+/677mHqsOE8uNqQIdqye7k=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=c0rjV54ZoVApK/T8te1ufrqggmw6dlDg3SxK9tGvgIGPi6uFW5pfMD2DdRTOHffZoLsBcuGsSEGCa4nblNT1AxKKe2/dRkoXKtwpzVNxRcHAxiV5oGYPXQ1NzZYubVtbbs5ddrhIqvpADdMgWTdxyaO1VJ2Qh7u2jD3ZjrDG71c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZF8Yz44S1z1cyxW;
	Sat, 15 Mar 2025 13:15:03 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id A12C818007F;
	Sat, 15 Mar 2025 13:15:11 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 15 Mar 2025 13:15:10 +0800
Subject: Re: [v4 PATCH 10/13] ubifs: Use crypto_acomp interface
To: Herbert Xu <herbert@gondor.apana.org.au>, Linux Crypto Mailing List
	<linux-crypto@vger.kernel.org>
CC: Richard Weinberger <richard@nod.at>, <linux-mtd@lists.infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	<linux-pm@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
	<netdev@vger.kernel.org>
References: <cover.1741954523.git.herbert@gondor.apana.org.au>
 <349a78bc53d3620a29cc6105b55985db51aa0a11.1741954523.git.herbert@gondor.apana.org.au>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <02dd5000-7ced-df02-d9d0-a3c1a410d062@huawei.com>
Date: Sat, 15 Mar 2025 13:15:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <349a78bc53d3620a29cc6105b55985db51aa0a11.1741954523.git.herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2025/3/14 20:22, Herbert Xu Ð´µÀ:
> Replace the legacy crypto compression interface with the new acomp
> interface.
> 
> Remove the compression mutexes and the overallocation for memory
> (the offender LZO has been fixed).

Hi, Herbert. Can you show me which patch fixed the problem in LZO?
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---
>   fs/ubifs/compress.c | 116 ++++++++++++++++++++++++++++----------------
>   fs/ubifs/journal.c  |   2 +-
>   fs/ubifs/ubifs.h    |  15 +-----
>   3 files changed, 77 insertions(+), 56 deletions(-)
> 

[...]
> diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
> index 3375bbe0508c..7d0aaf5d2e23 100644
> --- a/fs/ubifs/ubifs.h
> +++ b/fs/ubifs/ubifs.h
> @@ -124,13 +124,6 @@
>   #define OLD_ZNODE_AGE 20
>   #define YOUNG_ZNODE_AGE 5
>   
> -/*
> - * Some compressors, like LZO, may end up with more data then the input buffer.
> - * So UBIFS always allocates larger output buffer, to be sure the compressor
> - * will not corrupt memory in case of worst case compression.
> - */
> -#define WORST_COMPR_FACTOR 2

Does LZO guarantee the output data length smaller than input buffer 
length? Which commit fixed the issue?
> -
>   #ifdef CONFIG_FS_ENCRYPTION
>   #define UBIFS_CIPHER_BLOCK_SIZE FSCRYPT_CONTENTS_ALIGNMENT
>   #else

