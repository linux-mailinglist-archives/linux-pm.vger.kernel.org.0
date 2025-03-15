Return-Path: <linux-pm+bounces-24084-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B80A626B2
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 06:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A3A17020D
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 05:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BA8191F6D;
	Sat, 15 Mar 2025 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="TmjZvaJx"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F252E3387;
	Sat, 15 Mar 2025 05:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742017287; cv=none; b=aHnqH17s8zgR/udoVfcRqxVnae/sD6RmWhzY1gqa0JIb8BTpO2WqQ+E4lYkOZFn7RZx/3mJfQtQ0c7M6JKq4d+p3L45tk/Jl3I0id4plBGGGFSsWHJ73LuS+fcx4k3md3/m7TBXTxkohmPz/Fu7dxpOIMccgTiNmsUkYYrAiQIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742017287; c=relaxed/simple;
	bh=rgIC/He6gLrLCsnbiiJ2Y3rn7wOLYhxi1Bnz9gAzNBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esMZGNBut09zkhcA1K3HIyka9f8bhgAlNSHzik3/8vFlUs/xfokJvY3Pg7Ya0OsIbBAEMGrGABSRbOwtAbSz5vfM62VunmTS/c3vhMYzjZLf6FpU8wOBvhOPxgTDTVBmTqTkkC/UUST128aiEIInsdnBG9xa3nprenLf2eNwl/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=TmjZvaJx; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HjjilZAPTlwOchWvZyZ1q1uWUh7zlEVWWuPECm1h8LY=; b=TmjZvaJxud5OczKDCInvffv+OJ
	SDuAn+eeML7DIHMQ/x5/VWJsvbyfmFmC2lDJttLfA3sYnPkwQSTMaMtxzs5VRA/1zdWjsA7gGxvTe
	OSNAkB1rb/xocNlS+OsQm/OvmFZd7qwrZBV/sFMkZ8sPiS+vBoeJEVlYIPe80o6MHD18J6WSJIgWI
	Fx7ZODaRqT1qu8d0+N5ool4Hmr0TevIYYjKP3vQQ6mkkZbykgKrCTGJEhE25A2Ypw7nOTwigcFRSD
	twLeW1Y2JHG8+yeyWUIb/Y78t27M2cEqR2pSDCiBk84/oHBBwsDKQqk8ABZBCu6aD1LDoFgn94LLx
	sMcoXoMQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ttKGU-006mFg-2z;
	Sat, 15 Mar 2025 13:40:56 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 15 Mar 2025 13:40:54 +0800
Date: Sat, 15 Mar 2025 13:40:54 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: Re: [v4 PATCH 10/13] ubifs: Use crypto_acomp interface
Message-ID: <Z9US5rHr1Y7sCpns@gondor.apana.org.au>
References: <cover.1741954523.git.herbert@gondor.apana.org.au>
 <349a78bc53d3620a29cc6105b55985db51aa0a11.1741954523.git.herbert@gondor.apana.org.au>
 <023a23b0-d9fd-6d4d-d5a2-207e47419645@huawei.com>
 <Z9T79PKW0TFO-2xl@gondor.apana.org.au>
 <f4a51d32-0b04-2c27-924d-f3a54d6b63a5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4a51d32-0b04-2c27-924d-f3a54d6b63a5@huawei.com>

On Sat, Mar 15, 2025 at 01:08:21PM +0800, Zhihao Cheng wrote:
> 
> The crypto_acomp_alg_name() gets name from compr->cc(the name is initialized
> by compr->capi_name).
> I got the following messages after verifying:
> [  154.907048] UBIFS warning (ubi0:0 pid 110): ubifs_compress_req.isra.0
> [ubifs]: cannot compress 4096 bytes, compressor deflate, error -12, leave
> data uncompressed
> 
> The 'deflate' is zlib compressor's capi_name, but we expect it be 'zlib'
> here.

Sorry I overlooked this difference.  I will fold the following
patch into the series when I repost.

Thanks,

diff --git a/fs/ubifs/compress.c b/fs/ubifs/compress.c
index 9973a2853de7..8d481c8338c3 100644
--- a/fs/ubifs/compress.c
+++ b/fs/ubifs/compress.c
@@ -70,7 +70,8 @@ struct ubifs_compressor *ubifs_compressors[UBIFS_COMPR_TYPES_CNT];
 
 static int ubifs_compress_req(const struct ubifs_info *c,
 			      struct acomp_req *req,
-			      void *out_buf, int *out_len)
+			      void *out_buf, int *out_len,
+			      const char *compr_name)
 {
 	struct crypto_wait wait;
 	int in_len = req->slen;
@@ -86,9 +87,7 @@ static int ubifs_compress_req(const struct ubifs_info *c,
 
 	if (unlikely(err)) {
 		ubifs_warn(c, "cannot compress %d bytes, compressor %s, error %d, leave data uncompressed",
-			   in_len,
-			   crypto_acomp_alg_name(crypto_acomp_reqtfm(req)),
-			   err);
+			   in_len, compr_name, err);
 	} else if (in_len - *out_len < UBIFS_MIN_COMPRESS_DIFF) {
 		/*
 		 * If the data compressed only slightly, it is better
@@ -138,7 +137,7 @@ void ubifs_compress(const struct ubifs_info *c, const void *in_buf,
 		ACOMP_REQUEST_ALLOC(req, compr->cc, GFP_NOFS | __GFP_NOWARN);
 
 		acomp_request_set_src_dma(req, in_buf, in_len);
-		err = ubifs_compress_req(c, req, out_buf, out_len);
+		err = ubifs_compress_req(c, req, out_buf, out_len, compr->name);
 	}
 
 	if (err)
@@ -190,7 +189,7 @@ void ubifs_compress_folio(const struct ubifs_info *c, struct folio *in_folio,
 		ACOMP_REQUEST_ALLOC(req, compr->cc, GFP_NOFS | __GFP_NOWARN);
 
 		acomp_request_set_src_folio(req, in_folio, in_offset, in_len);
-		err = ubifs_compress_req(c, req, out_buf, out_len);
+		err = ubifs_compress_req(c, req, out_buf, out_len, compr->name);
 	}
 
 	if (err)
@@ -206,7 +205,8 @@ void ubifs_compress_folio(const struct ubifs_info *c, struct folio *in_folio,
 
 static int ubifs_decompress_req(const struct ubifs_info *c,
 				struct acomp_req *req,
-				const void *in_buf, int in_len, int *out_len)
+				const void *in_buf, int in_len, int *out_len,
+				const char *compr_name)
 {
 	struct crypto_wait wait;
 	int err;
@@ -221,9 +221,7 @@ static int ubifs_decompress_req(const struct ubifs_info *c,
 
 	if (err)
 		ubifs_err(c, "cannot decompress %d bytes, compressor %s, error %d",
-			  in_len,
-			  crypto_acomp_alg_name(crypto_acomp_reqtfm(req)),
-			  err);
+			  in_len, compr_name, err);
 
 	acomp_request_free(req);
 
@@ -270,7 +268,8 @@ int ubifs_decompress(const struct ubifs_info *c, const void *in_buf,
 		ACOMP_REQUEST_ALLOC(req, compr->cc, GFP_NOFS | __GFP_NOWARN);
 
 		acomp_request_set_dst_dma(req, out_buf, *out_len);
-		return ubifs_decompress_req(c, req, in_buf, in_len, out_len);
+		return ubifs_decompress_req(c, req, in_buf, in_len, out_len,
+					    compr->name);
 	}
 }
 
@@ -318,7 +317,8 @@ int ubifs_decompress_folio(const struct ubifs_info *c, const void *in_buf,
 
 		acomp_request_set_dst_folio(req, out_folio, out_offset,
 					    *out_len);
-		return ubifs_decompress_req(c, req, in_buf, in_len, out_len);
+		return ubifs_decompress_req(c, req, in_buf, in_len, out_len,
+					    compr->name);
 	}
 }
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

