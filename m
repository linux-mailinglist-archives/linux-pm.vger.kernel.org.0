Return-Path: <linux-pm+bounces-40851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3770D1EB76
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 13:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A8CD309A5FC
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 12:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D84395DBA;
	Wed, 14 Jan 2026 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="qDp8hvbT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23162D0618;
	Wed, 14 Jan 2026 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393084; cv=none; b=rKzsNExX2r34b7cbQXBu40Z0Ad5z0LjrLWpjwma+GfoQhNRx1zbleHzIGj1BfCYZEeVcQSCQzCKD20XLtyKNyTFX1XM6HuoPEtRU0bMKwkVTRDVe/0HRTelqOHMdgtSHiVKbN0K98aZtJ48KbE0x2x5iltIXi5gbB8JX+0OUJgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393084; c=relaxed/simple;
	bh=TE86AEXcChUwqQeyxno+oNPqkwH/1N47g3g2foYpftA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPu2h7Fwayh2ljKPy3FDarawKD5qN2bfQ7pe+K0dDCvXSg55hj3DvSbA7HIdHlq84+XeiiGUsFNQEEAm6zADhqJu2xi3cqSR5UXuy8jFwwmIEWHQ3B/QcXkvjxW5LdbsGSzmRGkALTvCWsntl8HqYDFcUn6fZaU0WOoML7iwhB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=qDp8hvbT; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60E0vSXu1638917;
	Wed, 14 Jan 2026 04:17:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=bLiraS6G0ujGAs1161707SLd84yAjvJ0ILuh8g4ymAE=; b=qDp8hvbT4oRq
	Ic71j+P5Cud2KF6pNniv1HyFR96hb0pEw7VOA0c8zN1E5ofYBMYWi31HRe2pqvZN
	j0MYAdgQUiLcwfimaYzYwrawpYjMzZ6oJgNSTEDijXQsKti65ZByWNQdD+HRaKJi
	Ozkji8xc62BOfE/HwuKwUE0UhcROeI+Yvr2Db14CPFUMHquyha9zViaCRm7zVuCJ
	MUbGAhZiu7fYNgJLIpDj1xbbwiNwYgL4ja2H+LyNUrgd+8Vbey0DAMkAB/oJyjua
	kfs5MNkmtMu0uXxcg+dBqx9zrDWxyz+ruQc27tkyDOLk3XLJBIrL75FGgePhmwMt
	AqsV9t4Ibg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4bp12aby1k-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 14 Jan 2026 04:17:14 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 14 Jan 2026 12:17:09 +0000
From: Chris Mason <clm@meta.com>
To: Kairui Song <ryncsn@gmail.com>
CC: Chris Mason <clm@meta.com>, <linux-mm@kvack.org>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Barry Song
	<baohua@kernel.org>,
        Chris Li <chrisl@kernel.org>, Nhat Pham
	<nphamcs@gmail.com>,
        Yosry Ahmed <yosry.ahmed@linux.dev>,
        David Hildenbrand
	<david@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Youngjun Park
	<youngjun.park@lge.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>,
        "Matthew Wilcox (Oracle)"
	<willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, Kairui Song
	<kasong@tencent.com>,
        <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki (Intel)"
	<rafael@kernel.org>
Subject: Re: [PATCH v5 14/19] mm, swap: cleanup swap entry management workflow
Date: Wed, 14 Jan 2026 04:16:51 -0800
Message-ID: <20260114121654.1029110-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251220-swap-table-p2-v5-14-8862a265a033@tencent.com>
References:
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: l86fYLqm09mw1sGmgoYqJKS0iX9e17pd
X-Proofpoint-GUID: l86fYLqm09mw1sGmgoYqJKS0iX9e17pd
X-Authority-Analysis: v=2.4 cv=KcjfcAYD c=1 sm=1 tr=0 ts=6967894a cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8
 a=k3sPG3Yi4uvsF8qPn4kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEwMSBTYWx0ZWRfX34SFKLUZwSHE
 W9V8eNoSED2L+ABXQvnl5NpeaAXYgFEd7nV0yGcqmbi4auytq2DtwmnoI0Ab5TqMwtGNeW6XPFS
 nvn1mMxajdTescl8CIvvYKNF1n9nSk12ZtzN2ZhT8sFNBc94RA5WcxRL39JTmpfq7dXeolnYyq6
 OO8kml4XEoOgtDQ0YjccbPYnI8eZHSws+zmsFUul8pprrB6N66dS6g/lmU8cigXCec+SVE/GI7G
 SMgfYdUsKA5GY3rBeKcUAVhxvh2E5gSIoucAWVRlTo6fO9O/0QsHwDirDyEe7oK7vMywHm4GFGm
 ZW+6ceotx74UbpWCW/4uhPGIs8rrdVRjazXEvuEWIOzP+8oGLRy4AyYFoUPUoA2CsTQB+nGBgtH
 RDegsldmSEli9f9jNQROapMGcM9DntF/WVIn3+bnChRDSqioIoyjprLK0L0g2vhXoTjjRygLIpL
 q/2le8npXcgkO/m3A4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01

On Sat, 20 Dec 2025 03:43:43 +0800 Kairui Song <ryncsn@gmail.com> wrote:

Hi everyone,

I ran mm-new through the AI review prompts, and this one was flagged:

> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 8050e51828351..036489d3b01a9 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c

[ ... ]

> @@ -186,6 +186,7 @@ sector_t alloc_swapdev_block(int swap)
>
>  void free_all_swap_pages(int swap)
>  {
> +	unsigned long offset;
>  	struct rb_node *node;
>
>  	/*
> @@ -197,8 +198,9 @@ void free_all_swap_pages(int swap)
>
>  		ext = rb_entry(node, struct swsusp_extent, node);
>  		rb_erase(node, &swsusp_extents);
> -		swap_free_nr(swp_entry(swap, ext->start),
> -			     ext->end - ext->start + 1);
> +
> +		for (offset = ext->start; offset < ext->end; offset++)
> +			swap_free_hibernation_slot(swp_entry(swap, offset));
                                           ^^^^^^^^^^^

Is this loop missing the final slot at ext->end?

The old code freed (ext->end - ext->start + 1) entries, which is the
inclusive range [ext->start, ext->end]. Looking at swsusp_extents_insert(),
when a single slot is inserted it sets ext->start = ext->end = offset, and
merging extends the range by incrementing ext->end or decrementing
ext->start. This means ext->end is inclusive.

The new loop uses "offset < ext->end" which iterates [ext->start, ext->end),
missing the slot at ext->end. Should this be "offset <= ext->end" instead?



