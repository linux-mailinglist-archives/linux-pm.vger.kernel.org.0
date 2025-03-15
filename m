Return-Path: <linux-pm+bounces-24094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE1BA62964
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 09:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637FE3BEAEE
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 08:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4E41E04AC;
	Sat, 15 Mar 2025 08:58:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001771DC9B1;
	Sat, 15 Mar 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742029125; cv=none; b=TsQWiwQCjOAkIeiPSEzY/O3vU8kENaa+R37p62tWSPc+AFJKeTHlDr9EiZJeTLsBPMMEKTHLLR1rlCrv2dQSEd0w7eiOTZoOJHS4bQ9vOxagh0TioOLynZoiOcdZZolUx1ZBd8uUOta0OjuF5cQ2PbgKQ8RRwN9vnVf/PDVUSEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742029125; c=relaxed/simple;
	bh=mhFM5wlrDVBEC0D5+YR8xY0s6jbjNsGkv4pO4QP4Fc8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TdIANiyzqik51BK3UG9WWzGlmIVWa4JUn9tmv6bXNAlJhSvBtHUwWNkkpmzx7iOq6Fdl4eaShSxOWSa5rdhVetrftiiYMdMxg1R53q6tnWxKMx3P33kx9ms0X4F/iyG8DjZ85KneV00NGCBVRdfUQwjXvMOpO6B4ciyIh1sWcF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZFFS85G52zDsqJ;
	Sat, 15 Mar 2025 16:55:20 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 197CA1800EC;
	Sat, 15 Mar 2025 16:58:33 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 15 Mar 2025 16:58:32 +0800
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
Message-ID: <e5792e49-588d-8dee-0e3e-9e73e4bedebf@huawei.com>
Date: Sat, 15 Mar 2025 16:58:31 +0800
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
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Hi, Herbert, I got some warning messages while running xfstests, it 
looks like the compressor returns error code.

[  397.971086] run fstests generic/103 at 2025-03-15 16:48:29
[  398.182347] run fstests generic/104 at 2025-03-15 16:48:29
[  398.396986] run fstests generic/105 at 2025-03-15 16:48:29
[  398.602640] run fstests generic/106 at 2025-03-15 16:48:29
[  398.816819] run fstests generic/107 at 2025-03-15 16:48:30
[  399.032602] run fstests generic/108 at 2025-03-15 16:48:30
[  399.271669] run fstests generic/109 at 2025-03-15 16:48:30
[  399.449228] UBIFS (ubi1:0): default file-system created
[  399.449257] UBIFS (ubi1:0): Mounting in unauthenticated mode
[  399.449359] UBIFS (ubi1:0): background thread "ubifs_bgt1_0" started, 
PID 1703
[  399.449876] UBIFS (ubi1:0): UBIFS: mounted UBI device 1, volume 0, 
name "vol_a"
[  399.449882] UBIFS (ubi1:0): LEB size: 129024 bytes (126 KiB), 
min./max. I/O unit sizes: 2048 bytes/2048 bytes
[  399.449886] UBIFS (ubi1:0): FS size: 220631040 bytes (210 MiB, 1710 
LEBs), max 1722 LEBs, journal size 11096064 bytes (10 MiB, 86 LEBs)
[  399.449890] UBIFS (ubi1:0): reserved for root: 4952683 bytes (4836 KiB)
[  399.449892] UBIFS (ubi1:0): media format: w5/r0 (latest is w5/r0), 
UUID 56E8FEFD-CF25-445D-9159-BE65FC10EC9B, small LPT model
[  399.449904] UBIFS (ubi1:0): full atime support is enabled.
[  400.054087] UBIFS warning (ubi0:0 pid 110): ubifs_compress_req 
[ubifs]: cannot compress 4096 bytes, compressor zstd, error -22, leave 
data uncompressed
[  400.055631] UBIFS warning (ubi0:0 pid 110): ubifs_compress_req 
[ubifs]: cannot compress 4096 bytes, compressor zstd, error -22, leave 
data uncompressed
[  400.057137] UBIFS warning (ubi0:0 pid 110): ubifs_compress_req 
[ubifs]: cannot compress 4096 bytes, compressor zstd, error -22, leave 
data uncompressed
[  400.058760] UBIFS warning (ubi0:0 pid 110): ubifs_compress_req 
[ubifs]: cannot compress 4096 bytes, compressor zstd, error -22, leave 
data uncompressed


