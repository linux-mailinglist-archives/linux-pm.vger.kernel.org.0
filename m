Return-Path: <linux-pm+bounces-24275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF52A68889
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 10:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6F9E7A31EA
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 09:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E679256C93;
	Wed, 19 Mar 2025 09:44:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FB0256C92;
	Wed, 19 Mar 2025 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377464; cv=none; b=iD1Awj3Rj8T+6z3oYU8A3HhaxZS6pxdV/y1WdSVF5AhU052yHC1B4RJIETldnrPRwdI4WD7HC/0+r72E/CfsxZhefSdrLKJQTzfYT3x++uCZbxpZ1Yz/XGioEfEFXNu5DJ5J+c8PySfvEade7KdAmrDmD5AW2xM3n2FTJ+4i6dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377464; c=relaxed/simple;
	bh=pID1YVqDrR/XGfOmfBf1DckSXCMMhnSS8zNIM2xIcXo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YGu1TUHnDtxgHvNRVKGP4aIu85BNnPNiADIUlOH7yFFA1yAK6dDejUZDXv02emQ9LCFZTNC0LCSpJULMmLi4zDzZe1RFg9k6FwJocrbhtOpi66KsrllZ6Tl0C7+MlwK8Pv1IeUNDEH1dpD36kBIm+51Ig+4bTEsKrACcTMOeKGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZHkLY6m8Gz1d0DC;
	Wed, 19 Mar 2025 17:44:05 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 728FC1800C8;
	Wed, 19 Mar 2025 17:44:19 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Mar 2025 17:44:18 +0800
Subject: Re: [v5 PATCH 14/14] ubifs: Pass folios to acomp
To: Herbert Xu <herbert@gondor.apana.org.au>, Linux Crypto Mailing List
	<linux-crypto@vger.kernel.org>
CC: Richard Weinberger <richard@nod.at>, <linux-mtd@lists.infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	<linux-pm@vger.kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
	<netdev@vger.kernel.org>
References: <cover.1742034499.git.herbert@gondor.apana.org.au>
 <99ae6a15afc1478bab201949dc3dbb2c7634b687.1742034499.git.herbert@gondor.apana.org.au>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <9f77f2a4-e4ba-813e-f44d-3a42d9637d0f@huawei.com>
Date: Wed, 19 Mar 2025 17:44:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <99ae6a15afc1478bab201949dc3dbb2c7634b687.1742034499.git.herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2025/3/15 18:30, Herbert Xu Ð´µÀ:
> As the acomp interface supports folios, use that instead of mapping
> the data in ubifs.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---
>   fs/ubifs/compress.c | 106 +++++++++++++++++++++++++++++++++++++++++++-
>   fs/ubifs/file.c     |  74 +++++++++++--------------------
>   fs/ubifs/journal.c  |   9 ++--
>   fs/ubifs/ubifs.h    |  11 ++++-
>   4 files changed, 145 insertions(+), 55 deletions(-)


Tested-by: Zhihao Cheng <chengzhihao1@huawei.com> # For xfstests

> 
> diff --git a/fs/ubifs/compress.c b/fs/ubifs/compress.c
> index a241ba01c9a8..ea6f06adcd43 100644
> --- a/fs/ubifs/compress.c
> +++ b/fs/ubifs/compress.c
> @@ -16,6 +16,7 @@
>    */
>   
>   #include <crypto/acompress.h>
> +#include <linux/highmem.h>
>   #include "ubifs.h"
>   
>   /* Fake description object for the "none" compressor */
> @@ -126,7 +127,7 @@ void ubifs_compress(const struct ubifs_info *c, const void *in_buf,
>   	{
>   		ACOMP_REQUEST_ALLOC(req, compr->cc, GFP_NOFS | __GFP_NOWARN);
>   
> -		acomp_request_set_src_nondma(req, in_buf, in_len);
> +		acomp_request_set_src_dma(req, in_buf, in_len);

Why not merging it into patch 13?
>   		err = ubifs_compress_req(c, req, out_buf, out_len, compr->name);
>   	}
>   
> @@ -141,6 +142,58 @@ void ubifs_compress(const struct ubifs_info *c, const void *in_buf,
>   	*compr_type = UBIFS_COMPR_NONE;
>   }
>   
> +/**
> + * ubifs_compress_folio - compress folio.
> + * @c: UBIFS file-system description object
> + * @in_folio: data to compress
> + * @in_offset: offset into @in_folio
> + * @in_len: length of the data to compress
> + * @out_buf: output buffer where compressed data should be stored
> + * @out_len: output buffer length is returned here
> + * @compr_type: type of compression to use on enter, actually used compression
> + *              type on exit
> + *
> + * This function compresses input folio @in_folio of length @in_len and
> + * stores the result in the output buffer @out_buf and the resulting length
> + * in @out_len. If the input buffer does not compress, it is just copied
> + * to the @out_buf. The same happens if @compr_type is %UBIFS_COMPR_NONE
> + * or if compression error occurred.
> + *
> + * Note, if the input buffer was not compressed, it is copied to the output
> + * buffer and %UBIFS_COMPR_NONE is returned in @compr_type.
> + */
> +void ubifs_compress_folio(const struct ubifs_info *c, struct folio *in_folio,
> +			  size_t in_offset, int in_len, void *out_buf,
> +			  int *out_len, int *compr_type)
> +{
> +	int err;
> +	struct ubifs_compressor *compr = ubifs_compressors[*compr_type];
> +
> +	if (*compr_type == UBIFS_COMPR_NONE)
> +		goto no_compr;
> +
> +	/* If the input data is small, do not even try to compress it */
> +	if (in_len < UBIFS_MIN_COMPR_LEN)
> +		goto no_compr;
> +
> +	{
> +		ACOMP_REQUEST_ALLOC(req, compr->cc, GFP_NOFS | __GFP_NOWARN);
> +
> +		acomp_request_set_src_folio(req, in_folio, in_offset, in_len);
> +		err = ubifs_compress_req(c, req, out_buf, out_len, compr->name);
> +	}
> +
> +	if (err)
> +		goto no_compr;
> +
> +	return;
> +
> +no_compr:
> +	memcpy_from_folio(out_buf, in_folio, in_offset, in_len);
> +	*out_len = in_len;
> +	*compr_type = UBIFS_COMPR_NONE;
> +}
> +
>   static int ubifs_decompress_req(const struct ubifs_info *c,
>   				struct acomp_req *req,
>   				const void *in_buf, int in_len, int *out_len,
> @@ -205,7 +258,56 @@ int ubifs_decompress(const struct ubifs_info *c, const void *in_buf,
>   	{
>   		ACOMP_REQUEST_ALLOC(req, compr->cc, GFP_NOFS | __GFP_NOWARN);
>   
> -		acomp_request_set_dst_nondma(req, out_buf, *out_len);
> +		acomp_request_set_dst_dma(req, out_buf, *out_len);

Same as the suggestion above.
> +		return ubifs_decompress_req(c, req, in_buf, in_len, out_len,
> +					    compr->name);
> +	}
> +}
> +
> +/**
> + * ubifs_decompress_folio - decompress folio.
> + * @c: UBIFS file-system description object
> + * @in_buf: data to decompress
> + * @in_len: length of the data to decompress
> + * @out_folio: output folio where decompressed data should
> + * @out_offset: offset into @out_folio
> + * @out_len: output length is returned here
> + * @compr_type: type of compression
> + *
> + * This function decompresses data from buffer @in_buf into folio
> + * @out_folio.  The length of the uncompressed data is returned in
> + * @out_len.  This functions returns %0 on success or a negative error
> + * code on failure.
> + */
> +int ubifs_decompress_folio(const struct ubifs_info *c, const void *in_buf,
> +			   int in_len, struct folio *out_folio,
> +			   size_t out_offset, int *out_len, int compr_type)
> +{
> +	struct ubifs_compressor *compr;
> +
> +	if (unlikely(compr_type < 0 || compr_type >= UBIFS_COMPR_TYPES_CNT)) {
> +		ubifs_err(c, "invalid compression type %d", compr_type);
> +		return -EINVAL;
> +	}
> +
> +	compr = ubifs_compressors[compr_type];
> +
> +	if (unlikely(!compr->capi_name)) {
> +		ubifs_err(c, "%s compression is not compiled in", compr->name);
> +		return -EINVAL;
> +	}
> +
> +	if (compr_type == UBIFS_COMPR_NONE) {
> +		memcpy_to_folio(out_folio, out_offset, in_buf, in_len);
> +		*out_len = in_len;
> +		return 0;
> +	}
> +
> +	{
> +		ACOMP_REQUEST_ALLOC(req, compr->cc, GFP_NOFS | __GFP_NOWARN);
> +
> +		acomp_request_set_dst_folio(req, out_folio, out_offset,
> +					    *out_len);
>   		return ubifs_decompress_req(c, req, in_buf, in_len, out_len,
>   					    compr->name);
>   	}

