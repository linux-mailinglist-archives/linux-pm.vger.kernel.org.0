Return-Path: <linux-pm+bounces-24035-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD12A610CB
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 13:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C813B9BD8
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 12:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28D81FF1A8;
	Fri, 14 Mar 2025 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="GO8oSoAX"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFBF1FECD7;
	Fri, 14 Mar 2025 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741954974; cv=none; b=LcoYmgyLL/26li8iCr+q3mzgmUHcjHpRrty4uaQSA1ZHl4ATeLDseukwl0u0L21DVqhWeVk4VP8xForY+HMIdefO39p0Wwtsk+xdlduZHQQJb+asHRmFs2rqSbqA7iu6QpRA8RLG5lvf7EXID15ipiQ/UacsgwrTwotfNcnncB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741954974; c=relaxed/simple;
	bh=1RQCqU1dZB3I7+96/ytKcOKW9uXw+y9egomPB/BMn9E=;
	h=Date:Message-Id:From:Subject:To:Cc; b=E+ha9JVMM2gNKmvSTH2PLCckela1RcFtekuPnxEW/UKU3CUvO91DOaDe5Lfr5D7A60mTGsgala1n/Zjk+YK8r0+x6McyZFXwhn797s9fZlDxsTxGe1MzTB0+/ZHzFRFVb+n5kcn6bLhv7wRfLCEE31BVqPKe6ZMtFaS1/iDglsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=GO8oSoAX; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:Message-Id:Date:Sender:Reply-To:MIME-Version
	:Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=abGE60kWy5OfZ2b7kpGtLFLGgmHvoUGWwq+9Pjo5fp0=; b=GO8oSoAX5AGdMfajMdfcr6+AQ5
	PjgnxTyjBMRN7KNGC3MU4RITCRDuGxyw/x6G+b80isWXiaeqO6hbLyEvtPw6ElKGeIN0iXIaPLgTg
	uFbDTL6cehX4zj+KnJxTLqpjP+ZU24ZDni2wwKMhRllBYMpxRO1dDGJG+iQTcoasZxNqGIxXgbErX
	o44H9eDEvSRkilysSUHd2fSxMU7+TmqnID8t5pl3s3cVgcKphh12ZXJQQX/0gwX/8G1MBhf+dLDjr
	5ecdERQs5iNIyARDmA3M5+h0zjzFvqDz420kWoYDerTTwNDk8GX11/100ooBR5WgES+1mo1wxS6nc
	v7begvWA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tt43N-006ZlE-05;
	Fri, 14 Mar 2025 20:22:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Mar 2025 20:22:17 +0800
Date: Fri, 14 Mar 2025 20:22:17 +0800
Message-Id: <cover.1741954523.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v4 PATCH 00/13] crypto: acomp - Add virtual address and folio support
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, linux-mtd@lists.infradead.org, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

v4 adds acomp software fallback path, folio support and converts
existing legacy crypto_comp users.

This patch series adds virtual address and folio support to acomp.
This finally brings it to feature parity with the legacy crypto_comp,
which enables us to convert the existing users to acomp.

The three users are converted according to their characteristics:
ubifs uses folio+linear, hibernate uses linear only while ipcomp
uses SG only.

Only ipcomp is fully asynchronous, ubifs supports asynchronous
but will wait on it and hibernate is synchronous only.

Herbert Xu (13):
  crypto: qat - Remove dst_null support
  crypto: iaa - Remove dst_null support
  crypto: scomp - Remove support for some non-trivial SG lists
  crypto: acomp - Remove dst_free
  crypto: scomp - Add chaining and virtual address support
  crypto: acomp - Add ACOMP_REQUEST_ALLOC and acomp_request_alloc_extra
  crypto: iaa - Use acomp stack fallback
  crypto: acomp - Add async nondma fallback
  crypto: acomp - Add support for folios
  ubifs: Use crypto_acomp interface
  ubifs: Pass folios to acomp
  PM: hibernate: Use crypto_acomp interface
  xfrm: ipcomp: Use crypto_acomp interface

 crypto/acompress.c                            | 148 ++++--
 crypto/scompress.c                            | 189 ++++---
 drivers/crypto/intel/iaa/iaa_crypto_main.c    | 164 +-----
 .../intel/qat/qat_common/qat_comp_algs.c      |  83 ---
 fs/ubifs/compress.c                           | 217 ++++++--
 fs/ubifs/file.c                               |  74 +--
 fs/ubifs/journal.c                            |  11 +-
 fs/ubifs/ubifs.h                              |  26 +-
 include/crypto/acompress.h                    | 184 ++++++-
 include/crypto/internal/acompress.h           |  26 +-
 include/crypto/internal/scompress.h           |   2 -
 include/linux/crypto.h                        |   1 +
 include/net/ipcomp.h                          |  13 +-
 kernel/power/swap.c                           |  58 ++-
 net/xfrm/xfrm_ipcomp.c                        | 477 +++++++++---------
 15 files changed, 932 insertions(+), 741 deletions(-)

-- 
2.39.5


