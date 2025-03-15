Return-Path: <linux-pm+bounces-24080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F800A6259D
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 04:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996E8881C76
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 03:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D89C18A6AD;
	Sat, 15 Mar 2025 03:54:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D571401C;
	Sat, 15 Mar 2025 03:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742010899; cv=none; b=tdQTbWm2HdCvUkqZxQ0BeQcN5cdHPomRagzVuJo1xlfJDmxfqDZ5lExto0kDPWiuC+I0tWZbTzBAOdCvxPbVPRp1sjp6PlaXnhaUk0tJnmBF6A/YA0OicmZrErVNM9gUcKErMxGAib63RzWJYOq6BwVHWOlRby9mqLISAPanIGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742010899; c=relaxed/simple;
	bh=+HrchmFiWv4sJJZJLlQcXTxS1XWZzpWTRXOnR4nZLTs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZX2wNidf6BhjwIemn9qoNEPC8PzcXYun6SKfw35lnfLPRL7JU15pyl6a5g/s66VvhCf7M8XSWu8rE9VIm8igzfFir8HUcwu7PTn/g7BFEIc7leCLPiMGWZtvnAnc/n9F4T+9GA7QFtL8XfkxKvrEpdySa1rol05g95dskjVqzN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZF6hD1qVlz2RTJX;
	Sat, 15 Mar 2025 11:50:20 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 499811402E1;
	Sat, 15 Mar 2025 11:54:45 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 15 Mar 2025 11:54:44 +0800
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
Message-ID: <023a23b0-d9fd-6d4d-d5a2-207e47419645@huawei.com>
Date: Sat, 15 Mar 2025 11:54:43 +0800
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
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2025/3/14 20:22, Herbert Xu Ð´µÀ:
> Replace the legacy crypto compression interface with the new acomp
> interface.
> 
> Remove the compression mutexes and the overallocation for memory
> (the offender LZO has been fixed).
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---
>   fs/ubifs/compress.c | 116 ++++++++++++++++++++++++++++----------------
>   fs/ubifs/journal.c  |   2 +-
>   fs/ubifs/ubifs.h    |  15 +-----
>   3 files changed, 77 insertions(+), 56 deletions(-)
> 
> diff --git a/fs/ubifs/compress.c b/fs/ubifs/compress.c
> index 0b48cbab8a3d..9046e796876d 100644
> --- a/fs/ubifs/compress.c
> +++ b/fs/ubifs/compress.c
> @@ -15,7 +15,7 @@
>    * decompression.
>    */
>   
> -#include <linux/crypto.h>
> +#include <crypto/acompress.h>
>   #include "ubifs.h"
>   
>   /* Fake description object for the "none" compressor */
> @@ -26,11 +26,8 @@ static struct ubifs_compressor none_compr = {
>   };
>   
>   #ifdef CONFIG_UBIFS_FS_LZO
> -static DEFINE_MUTEX(lzo_mutex);
> -
>   static struct ubifs_compressor lzo_compr = {
>   	.compr_type = UBIFS_COMPR_LZO,
> -	.comp_mutex = &lzo_mutex,
>   	.name = "lzo",
>   	.capi_name = "lzo",
>   };
> @@ -42,13 +39,8 @@ static struct ubifs_compressor lzo_compr = {
>   #endif
>   
>   #ifdef CONFIG_UBIFS_FS_ZLIB
> -static DEFINE_MUTEX(deflate_mutex);
> -static DEFINE_MUTEX(inflate_mutex);
> -
>   static struct ubifs_compressor zlib_compr = {
>   	.compr_type = UBIFS_COMPR_ZLIB,
> -	.comp_mutex = &deflate_mutex,
> -	.decomp_mutex = &inflate_mutex,
>   	.name = "zlib",
>   	.capi_name = "deflate",
>   };
> @@ -60,13 +52,8 @@ static struct ubifs_compressor zlib_compr = {
>   #endif
>   
>   #ifdef CONFIG_UBIFS_FS_ZSTD
> -static DEFINE_MUTEX(zstd_enc_mutex);
> -static DEFINE_MUTEX(zstd_dec_mutex);
> -
>   static struct ubifs_compressor zstd_compr = {
>   	.compr_type = UBIFS_COMPR_ZSTD,
> -	.comp_mutex = &zstd_enc_mutex,
> -	.decomp_mutex = &zstd_dec_mutex,
>   	.name = "zstd",
>   	.capi_name = "zstd",
>   };
> @@ -80,6 +67,40 @@ static struct ubifs_compressor zstd_compr = {
>   /* All UBIFS compressors */
>   struct ubifs_compressor *ubifs_compressors[UBIFS_COMPR_TYPES_CNT];
>   
> +static int ubifs_compress_req(const struct ubifs_info *c,
> +			      struct acomp_req *req,
> +			      void *out_buf, int *out_len)
> +{
> +	struct crypto_wait wait;
> +	int in_len = req->slen;
> +	int err;
> +
> +	crypto_init_wait(&wait);
> +	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> +				   crypto_req_done, &wait);
> +	acomp_request_set_dst_dma(req, out_buf, *out_len);
> +	err = crypto_acomp_compress(req);
> +	err = crypto_wait_req(err, &wait);
> +	*out_len = req->dlen;
> +
> +	if (unlikely(err)) {
> +		ubifs_warn(c, "cannot compress %d bytes, compressor %s, error %d, leave data uncompressed",
> +			   in_len,
> +			   crypto_acomp_alg_name(crypto_acomp_reqtfm(req)),

We get capi_name by 'crypto_acomp_alg_name(crypto_acomp_reqtfm(req))', 
not compr->name.

There are conflicts in patch 2 on the latest mainline version, can you 
rebase this series so I can do some tests for UBIFS.

