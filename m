Return-Path: <linux-pm+bounces-24101-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F0AA62AF0
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 11:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0833BED51
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 10:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D401F790C;
	Sat, 15 Mar 2025 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="G1woJYRS"
X-Original-To: linux-pm@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33FC1DB15B;
	Sat, 15 Mar 2025 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742034644; cv=none; b=hXg9vXyLh1tQHECd8Bjo97y13Z0/KASp4zlX5mPBculCNNmndv9KVwW8gTcU8EXm6c+eu4O3xyIk0QDM5MP5vXhGTzjicTJtRdpVt9XzRn5oZQrUbifCoNaWH/Y8OIjs9ZmgcEFw+uuB53yblRqZsw8S/wi4me+hDmX5WO5o4bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742034644; c=relaxed/simple;
	bh=WO7xQ01sHeL4YTrIA8uxOk4H/cHor8dGJNliT9jaopQ=;
	h=Date:Message-Id:From:Subject:To:Cc; b=QVQ3eILPGobBDXwGQjt2gOzZfjawlpq6LUb6JS0uKJ6A+bjsfw3JWwZNBto613CNRRlnRIfgcYNvDB/cHQzZxeAOxUdDJbBK8Eeh8cmD5jt1Jtyba+H63DgNwc2X2fmz2ahkgJYVBVEVOPpaPuc+9pQGhlspinJbk0IpXiSKQnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=G1woJYRS; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Cc:To:Subject:From:Message-Id:Date:Sender:Reply-To:MIME-Version
	:Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fhIc9XPrh2CE8j9ZrLLDo3g0ZlybEeC0zVWTmTtBtXM=; b=G1woJYRS5JwsVVfsKNvtHl8Hv2
	/eWfbM1T8RQaXpjfoUzkOzNXILGjeYTCEDuE1DdkVGouDHeMGBtBYuhrCHtct8ZpWMNo89wKO2CZ9
	Gf7IqkwA5ErVp8igNs2K2Dz3DqwMzFNyj7Ghs2W1jdK6n1YJjM7nG/ZDQJich1QEB2nJ7trx/BkBl
	v4U14YAWq+219IeM7hisZOdeuleeAp8JZzjdnuCmpBkYf7RV4xLKQs5J0DrbuL722MUotfiEEHC26
	SgyVY388zHU03nUBKwRKtlNYFVMgM19pDkmwtiGxr4p1P052bKWwA7X7qquh2J1lPUBSgjICx60QW
	W5WgeyWQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1ttOmX-006p8t-28;
	Sat, 15 Mar 2025 18:30:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 15 Mar 2025 18:30:17 +0800
Date: Sat, 15 Mar 2025 18:30:17 +0800
Message-Id: <cover.1742034499.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v5 PATCH 00/14] crypto: acomp - Add virtual address and folio support
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, linux-mtd@lists.infradead.org, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

v5 removes the incompressible warnings in ubifs, removes more dead
code from qat, and replaces crypto_has_comp with crypto_has_acomp
in hibernate and ipcomp.

This patch series adds virtual address and folio support to acomp.
This finally brings it to feature parity with the legacy crypto_comp,
which enables us to convert the existing users to acomp.

The three users are converted according to their characteristics:
ubifs uses folio+linear, hibernate uses linear only while ipcomp
uses SG only.

Only ipcomp is fully asynchronous, ubifs supports asynchronous
but will wait on it and hibernate is synchronous only.

Herbert Xu (14):
  xfrm: ipcomp: Call pskb_may_pull in ipcomp_input
  crypto: scomp - Remove support for some non-trivial SG lists
  crypto: iaa - Remove dst_null support
  crypto: qat - Remove dst_null support
  crypto: acomp - Remove dst_free
  crypto: scomp - Add chaining and virtual address support
  crypto: acomp - Add ACOMP_REQUEST_ALLOC and acomp_request_alloc_extra
  crypto: iaa - Use acomp stack fallback
  crypto: acomp - Add async nondma fallback
  crypto: acomp - Add support for folios
  xfrm: ipcomp: Use crypto_acomp interface
  PM: hibernate: Use crypto_acomp interface
  ubifs: Use crypto_acomp interface
  ubifs: Pass folios to acomp

 crypto/acompress.c                            | 148 ++++--
 crypto/scompress.c                            | 189 ++++---
 drivers/crypto/intel/iaa/iaa_crypto_main.c    | 164 +-----
 drivers/crypto/intel/qat/qat_common/qat_bl.c  | 159 ------
 drivers/crypto/intel/qat/qat_common/qat_bl.h  |   6 -
 .../intel/qat/qat_common/qat_comp_algs.c      |  85 +---
 .../intel/qat/qat_common/qat_comp_req.h       |  10 -
 fs/ubifs/compress.c                           | 208 ++++++--
 fs/ubifs/file.c                               |  74 +--
 fs/ubifs/journal.c                            |  11 +-
 fs/ubifs/ubifs.h                              |  26 +-
 include/crypto/acompress.h                    | 184 ++++++-
 include/crypto/internal/acompress.h           |  26 +-
 include/crypto/internal/scompress.h           |   2 -
 include/linux/crypto.h                        |   1 +
 include/net/ipcomp.h                          |  13 +-
 kernel/power/hibernate.c                      |   5 +-
 kernel/power/swap.c                           |  58 ++-
 net/xfrm/xfrm_algo.c                          |   7 +-
 net/xfrm/xfrm_ipcomp.c                        | 478 +++++++++---------
 20 files changed, 932 insertions(+), 922 deletions(-)

-- 
2.39.5


