Return-Path: <linux-pm+bounces-24273-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39102A688A2
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 10:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F55885F98
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 09:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D21925484C;
	Wed, 19 Mar 2025 09:39:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149F0253B65;
	Wed, 19 Mar 2025 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377169; cv=none; b=Yr/6OG+ezUy7ClP87EJLdKSu9SwY2QWCTKIe5rjRZFIh73E5Pg+Zjy3pWGqV6o3EvxebefmDYHD896GHsk6WSzdcQjIr7UIAumbLJCAoi+zdQAz2txDiQxacO63fBUW6gAikY7V1WweOgKKWvk5oVWZJ18OQss98N1fiwAE216g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377169; c=relaxed/simple;
	bh=O5m4J2uazvVon6VrejWT7QbkzPd8R8Ka6P+/dKxYqY8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FPqyeSEO8sfPgmtpKi0Z1HFOIDT/BkEFIBNL5V1wBimfA2bWGVU2i7P0Rxzfe5Bxpk+qQR5Sny8UHBVtKs9UfKux/jS4MKXe8I6lzkcVcoX2xlE7hoJBjs3O6ekwNUfHtsH7Qamnb4bSVtRFSgeZAk3PBH8RzZQSt2yqKEZMF5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZHk9H6zmDzpg72;
	Wed, 19 Mar 2025 17:36:03 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id D8A7F14033A;
	Wed, 19 Mar 2025 17:39:17 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Mar 2025 17:39:16 +0800
Subject: Re: [v5 PATCH 13/14] ubifs: Use crypto_acomp interface
To: Herbert Xu <herbert@gondor.apana.org.au>, Linux Crypto Mailing List
	<linux-crypto@vger.kernel.org>
CC: Richard Weinberger <richard@nod.at>, <linux-mtd@lists.infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	<linux-pm@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
	<netdev@vger.kernel.org>
References: <cover.1742034499.git.herbert@gondor.apana.org.au>
 <434ca0f270b1e76f2abb222ddb0d68d7f1e0831a.1742034499.git.herbert@gondor.apana.org.au>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <d81b956d-8d08-8ddd-9746-5b0262a4e68e@huawei.com>
Date: Wed, 19 Mar 2025 17:39:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <434ca0f270b1e76f2abb222ddb0d68d7f1e0831a.1742034499.git.herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2025/3/15 18:30, Herbert Xu Ð´µÀ:
> Replace the legacy crypto compression interface with the new acomp
> interface.
> 
> Remove the compression mutexes and the overallocation for memory
> (the offender LZO has been fixed).
> 
> Cap the output buffer length for compression to eliminate the
> post-compression check for UBIFS_MIN_COMPRESS_DIFF.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---
>   fs/ubifs/compress.c | 106 ++++++++++++++++++++++++++------------------
>   fs/ubifs/journal.c  |   2 +-
>   fs/ubifs/ubifs.h    |  15 +------
>   3 files changed, 67 insertions(+), 56 deletions(-)
> 

Tested-by: Zhihao Cheng <chengzhihao1@huawei.com> # For xfstests
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/ubifs/compress.c b/fs/ubifs/compress.c
> index 0b48cbab8a3d..a241ba01c9a8 100644
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
> @@ -80,6 +67,30 @@ static struct ubifs_compressor zstd_compr = {
>   /* All UBIFS compressors */
>   struct ubifs_compressor *ubifs_compressors[UBIFS_COMPR_TYPES_CNT];
>   
> +static int ubifs_compress_req(const struct ubifs_info *c,
> +			      struct acomp_req *req,
> +			      void *out_buf, int *out_len,
> +			      const char *compr_name)
> +{
> +	struct crypto_wait wait;
> +	int in_len = req->slen;
> +	int dlen = *out_len;
> +	int err;
> +
> +	dlen = min(dlen, in_len - UBIFS_MIN_COMPRESS_DIFF);
> +
> +	crypto_init_wait(&wait);
> +	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> +				   crypto_req_done, &wait);
> +	acomp_request_set_dst_dma(req, out_buf, dlen);
> +	err = crypto_acomp_compress(req);
> +	err = crypto_wait_req(err, &wait);
> +	*out_len = req->dlen;
> +	acomp_request_free(req);
> +
> +	return err;
> +}
> +
>   /**
>    * ubifs_compress - compress data.
>    * @c: UBIFS file-system description object
> @@ -112,23 +123,14 @@ void ubifs_compress(const struct ubifs_info *c, const void *in_buf,
>   	if (in_len < UBIFS_MIN_COMPR_LEN)
>   		goto no_compr;
>   
> -	if (compr->comp_mutex)
> -		mutex_lock(compr->comp_mutex);
> -	err = crypto_comp_compress(compr->cc, in_buf, in_len, out_buf,
> -				   (unsigned int *)out_len);
> -	if (compr->comp_mutex)
> -		mutex_unlock(compr->comp_mutex);
> -	if (unlikely(err)) {
> -		ubifs_warn(c, "cannot compress %d bytes, compressor %s, error %d, leave data uncompressed",
> -			   in_len, compr->name, err);
> -		goto no_compr;
> +	{
> +		ACOMP_REQUEST_ALLOC(req, compr->cc, GFP_NOFS | __GFP_NOWARN);
> +
> +		acomp_request_set_src_nondma(req, in_buf, in_len);
> +		err = ubifs_compress_req(c, req, out_buf, out_len, compr->name);
>   	}
>   
> -	/*
> -	 * If the data compressed only slightly, it is better to leave it
> -	 * uncompressed to improve read speed.
> -	 */
> -	if (in_len - *out_len < UBIFS_MIN_COMPRESS_DIFF)
> +	if (err)
>   		goto no_compr;
>   
>   	return;
> @@ -139,6 +141,31 @@ void ubifs_compress(const struct ubifs_info *c, const void *in_buf,
>   	*compr_type = UBIFS_COMPR_NONE;
>   }
>   
> +static int ubifs_decompress_req(const struct ubifs_info *c,
> +				struct acomp_req *req,
> +				const void *in_buf, int in_len, int *out_len,
> +				const char *compr_name)
> +{
> +	struct crypto_wait wait;
> +	int err;
> +
> +	crypto_init_wait(&wait);
> +	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> +				   crypto_req_done, &wait);
> +	acomp_request_set_src_dma(req, in_buf, in_len);
> +	err = crypto_acomp_decompress(req);
> +	err = crypto_wait_req(err, &wait);
> +	*out_len = req->dlen;
> +
> +	if (err)
> +		ubifs_err(c, "cannot decompress %d bytes, compressor %s, error %d",
> +			  in_len, compr_name, err);
> +
> +	acomp_request_free(req);
> +
> +	return err;
> +}
> +
>   /**
>    * ubifs_decompress - decompress data.
>    * @c: UBIFS file-system description object
> @@ -155,7 +182,6 @@ void ubifs_compress(const struct ubifs_info *c, const void *in_buf,
>   int ubifs_decompress(const struct ubifs_info *c, const void *in_buf,
>   		     int in_len, void *out_buf, int *out_len, int compr_type)
>   {
> -	int err;
>   	struct ubifs_compressor *compr;
>   
>   	if (unlikely(compr_type < 0 || compr_type >= UBIFS_COMPR_TYPES_CNT)) {
> @@ -176,17 +202,13 @@ int ubifs_decompress(const struct ubifs_info *c, const void *in_buf,
>   		return 0;
>   	}
>   
> -	if (compr->decomp_mutex)
> -		mutex_lock(compr->decomp_mutex);
> -	err = crypto_comp_decompress(compr->cc, in_buf, in_len, out_buf,
> -				     (unsigned int *)out_len);
> -	if (compr->decomp_mutex)
> -		mutex_unlock(compr->decomp_mutex);
> -	if (err)
> -		ubifs_err(c, "cannot decompress %d bytes, compressor %s, error %d",
> -			  in_len, compr->name, err);
> +	{
> +		ACOMP_REQUEST_ALLOC(req, compr->cc, GFP_NOFS | __GFP_NOWARN);
>   
> -	return err;
> +		acomp_request_set_dst_nondma(req, out_buf, *out_len);
> +		return ubifs_decompress_req(c, req, in_buf, in_len, out_len,
> +					    compr->name);
> +	}
>   }
>   
>   /**
> @@ -199,7 +221,7 @@ int ubifs_decompress(const struct ubifs_info *c, const void *in_buf,
>   static int __init compr_init(struct ubifs_compressor *compr)
>   {
>   	if (compr->capi_name) {
> -		compr->cc = crypto_alloc_comp(compr->capi_name, 0, 0);
> +		compr->cc = crypto_alloc_acomp(compr->capi_name, 0, 0);
>   		if (IS_ERR(compr->cc)) {
>   			pr_err("UBIFS error (pid %d): cannot initialize compressor %s, error %ld",
>   			       current->pid, compr->name, PTR_ERR(compr->cc));
> @@ -218,7 +240,7 @@ static int __init compr_init(struct ubifs_compressor *compr)
>   static void compr_exit(struct ubifs_compressor *compr)
>   {
>   	if (compr->capi_name)
> -		crypto_free_comp(compr->cc);
> +		crypto_free_acomp(compr->cc);
>   }
>   
>   /**
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index 36ba79fbd2ff..7629ca9ecfe8 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -1625,7 +1625,7 @@ static int truncate_data_node(const struct ubifs_info *c, const struct inode *in
>   	int err, dlen, compr_type, out_len, data_size;
>   
>   	out_len = le32_to_cpu(dn->size);
> -	buf = kmalloc_array(out_len, WORST_COMPR_FACTOR, GFP_NOFS);
> +	buf = kmalloc(out_len, GFP_NOFS);
>   	if (!buf)
>   		return -ENOMEM;
>   
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
> -
>   #ifdef CONFIG_FS_ENCRYPTION
>   #define UBIFS_CIPHER_BLOCK_SIZE FSCRYPT_CONTENTS_ALIGNMENT
>   #else
> @@ -141,7 +134,7 @@
>    * How much memory is needed for a buffer where we compress a data node.
>    */
>   #define COMPRESSED_DATA_NODE_BUF_SZ \
> -	(UBIFS_DATA_NODE_SZ + UBIFS_BLOCK_SIZE * WORST_COMPR_FACTOR)
> +	(UBIFS_DATA_NODE_SZ + UBIFS_BLOCK_SIZE)
>   
>   /* Maximum expected tree height for use by bottom_up_buf */
>   #define BOTTOM_UP_HEIGHT 64
> @@ -835,16 +828,12 @@ struct ubifs_node_range {
>    * struct ubifs_compressor - UBIFS compressor description structure.
>    * @compr_type: compressor type (%UBIFS_COMPR_LZO, etc)
>    * @cc: cryptoapi compressor handle
> - * @comp_mutex: mutex used during compression
> - * @decomp_mutex: mutex used during decompression
>    * @name: compressor name
>    * @capi_name: cryptoapi compressor name
>    */
>   struct ubifs_compressor {
>   	int compr_type;
> -	struct crypto_comp *cc;
> -	struct mutex *comp_mutex;
> -	struct mutex *decomp_mutex;
> +	struct crypto_acomp *cc;
>   	const char *name;
>   	const char *capi_name;
>   };
> 


