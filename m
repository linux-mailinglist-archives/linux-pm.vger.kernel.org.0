Return-Path: <linux-pm+bounces-24097-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E10B4A629B0
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 10:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED103AE099
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 09:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3221F8697;
	Sat, 15 Mar 2025 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="BCMB4R3U"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FB61F874C;
	Sat, 15 Mar 2025 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742029991; cv=none; b=msBwt3XncFa8sF2MvMT8CFHdrvsFnskd9xNh3h1sySqkMgUw04tG/7GGWnRHvvMhE3qkgqzFDjHH1AbhoW9Uxq0ViojyBIl2GljuJlJ7Oi23kvDvfuZqM91WtpMOoZPl9KLubNKa5c8LyRHBu7KH6OQBkLrIAi6Ao0ACbjDCU1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742029991; c=relaxed/simple;
	bh=Co8TgTPPayATuCFqoIvwrLVbz+AI+MPDFu4xTzLvh20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoujrGU3nHiGm4mTdFWeLyOgj0F4havJ7Qf/51uduBi4p0LZFwC6zqUaJkrhqoF9c4iZS26NNg9tRnWk31vyQShPePHsQIcnLxHadaJ+CEw/rtkewavhGYm/e16X15jVAwq6MQt+ifTLv/ZKCGPtOeeYg4BETLYLj1i6geEi2uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=BCMB4R3U; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VWHBgHEGmNRsI4i6gNO6N2/SFYCtEltdgRavNwz+CQE=; b=BCMB4R3U8161ThdPChrnM3v9HW
	Rp7CPQRfgGKukWph+cO7HVLKntFMY6hSK83i8C3tZQKpF4c8YxFF8zk7BmMaXrvQ5ZPfgfSaMl99+
	CDVg5wn1Uv9rG2XAnh4Oe1KT622KkrcZ8ARPo0IHjs3ejnbkonccRr8YR6pnQqsIMWD86NncSvWY/
	Vrx2863CC9XvPz873YFHES1tIy93C4kMdoj7fP81olxpRkako2wumfvwKuGxfKHUF0+tpLfUXRt7Q
	QC+WBonv7ybH0VHQLdsuhfD6Axq14328WmOhegJfjTKVmazW74rbS79OyWmYQjw3bo1cU9aBbECGu
	oxh+BLcQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ttNZY-006o1w-1b;
	Sat, 15 Mar 2025 17:12:49 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 15 Mar 2025 17:12:48 +0800
Date: Sat, 15 Mar 2025 17:12:48 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org
Subject: Re: [v4 PATCH 10/13] ubifs: Use crypto_acomp interface
Message-ID: <Z9VEkEOul9bt4bc1@gondor.apana.org.au>
References: <cover.1741954523.git.herbert@gondor.apana.org.au>
 <349a78bc53d3620a29cc6105b55985db51aa0a11.1741954523.git.herbert@gondor.apana.org.au>
 <e5792e49-588d-8dee-0e3e-9e73e4bedebf@huawei.com>
 <Z9VCPB_pcT4ycYyt@gondor.apana.org.au>
 <dfa799fd-5ece-4ea4-d5d0-8c1da39a3a8d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa799fd-5ece-4ea4-d5d0-8c1da39a3a8d@huawei.com>

On Sat, Mar 15, 2025 at 05:08:47PM +0800, Zhihao Cheng wrote:
>
> According to the warning message, current compressor is zstd. The output
> buffer size is limited only for LZO compressor by [1].

Any algorithm can and will produce output longer than the input,
if you give it enough output buffer.

Previously an output buffer length of 2x the input length was given
to all algorithms, meaning that they would all succeed no matter
whether the input can be compressed or not.

This has now been changed so that incompressible data is not
needlessly compressed all the way to the end.  In fact we should
reduce it further to eliminate the UBIFS_MIN_COMPRESS_DIFF check.

I will remove the warning on compression since failures are
expected and reduce the output buffer length further to remove
the post-compression length check.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

