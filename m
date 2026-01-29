Return-Path: <linux-pm+bounces-41724-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGoQIQm+e2mnIAIAu9opvQ
	(envelope-from <linux-pm+bounces-41724-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:07:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA614B425B
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A62363002D2A
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 20:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5931832ABCA;
	Thu, 29 Jan 2026 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="YaYoX3Wb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAC729B8D0;
	Thu, 29 Jan 2026 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769717252; cv=none; b=S9Ap9ziCsHrAF3LRC5PnclHZuKANpeyD7slrrPcAPYlXn308X0+vMIhMQhW8j4ENEFz+euj4ZlHpQVI24GhYOOd1TMYbnxDJ9QptpwANAnH9dVRQj7Qrn9EUcasTleEDZB09ce0RXe16o6gGMYV/TxTifXGAi9STqYJ/IoXdtuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769717252; c=relaxed/simple;
	bh=sHZQVoPFDML2yH19xjJAHS7KdlPCg8Xc7i5cg0g1whk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oK5fEEZGzLQchf7T0LRHZC71VJqmzZKCq277FJImFqKQGqw4fs9J5R/FvJvIQeFZjWqiAo9CCyVnDWGppKjcNmeUAB9sSlNzZHAC5rRecW386x/cA7303ydaNWgc4EswA/3GIZgzVBd5+DXuC5f8NZu6xbHJNobZYa4GBeay+zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=YaYoX3Wb; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60TIMR4T1917544;
	Thu, 29 Jan 2026 12:06:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=4Aad3o3c56ZGNBsvIx1Qn7v3KSrkQFci5VYsYK+dTnw=; b=YaYoX3WbHz5W
	rfKoQNZXHk29PaTJhJWgIwOmB90tXCZBpbfnGWegAH/Niu7cyKyHvtZ5gx2bApy7
	OCCxCuMwCXEd7oW3vj6RWNY1XGCbiOoi7cFNK7pcDeuACNuX+QVF7ImLczkccx9G
	6SuAvBdsC6OLbEcDik6Bl8E5iDgWKE9JGEs+Rv3Ql5b7RJje8luPmX2BFvVAnM+H
	fzTlat9+VVxBf0VvlyoOsls76cfMoKD+jI+rKRHU7AIevdQk/rNQFU1VwkrxAWrj
	TL19Peg07pxMOqrdJeoR6TtJU8Q5pef/4w9eHMqF8QUdNsVjXwvq3DsgEtN/Ivje
	HEMZdD7zAA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4c08fv4mng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 29 Jan 2026 12:06:26 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 29 Jan 2026 20:06:24 +0000
From: Chris Mason <clm@meta.com>
To: Kairui Song <ryncsn@gmail.com>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Baoquan
 He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
        Chris Li
	<chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
        Yosry Ahmed
	<yosry.ahmed@linux.dev>,
        David Hildenbrand <david@kernel.org>,
        Johannes
 Weiner <hannes@cmpxchg.org>,
        Youngjun Park <youngjun.park@lge.com>,
        Hugh
 Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Ying
 Huang <ying.huang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Matthew Wilcox (Oracle)"
	<willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, Kairui Song
	<kasong@tencent.com>,
        <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki (Intel)"
	<rafael@kernel.org>
Subject: Re: [PATCH v5 14/19] mm, swap: cleanup swap entry management workflow
Date: Thu, 29 Jan 2026 11:32:38 -0800
Message-ID: <20260129200604.2518109-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251220-swap-table-p2-v5-14-8862a265a033@tencent.com>
References: <20251220-swap-table-p2-v5-0-8862a265a033@tencent.com> <20251220-swap-table-p2-v5-14-8862a265a033@tencent.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xF3qSoIDUEYo5SoFh-hYPuqEGaxNgAIv
X-Proofpoint-ORIG-GUID: xF3qSoIDUEYo5SoFh-hYPuqEGaxNgAIv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDE0NCBTYWx0ZWRfX/jxPxco3ghaj
 CyMdkkqj2tKEUBAmFy8D7iicZr2M0Vhpp2OVVukhEHHhmh58CEL672Ds+hZbvPDNt6h7ZL+amDB
 lLyNARogeomdtORE/XTf5mKyDNskPRf67Lvs3hyzCT/KPHC/uiNvvYkvau8QloluYaZeH/rQjQw
 tJEj6Nbswcz2FGYesLWarRkhFju7g61LaYdIcJhC3/YY44E/NjAbWCdCRJvSoCAfLMk5C3tf4W3
 fYiOMTi4eIbsOxiv3w/7YuuqMLdpsQNCVmSh0Sbcb6MxRebRmqekwKdfrITnewO2eYaIqy+dvtS
 O2tjyIQrN8HoeSKIaDa1d7Jd6ad7H48YUKu797UXRDS0+FUdHsEr4KXMrJcLC20PJF4UrgFy8vz
 4/sXOINoqOMwS/hhyuPp3p2/HGYSbJQDLHSbYO5CwQR86Lf+dpYhbOW3vQk7MyPFvuSOclhty3D
 7LbT/O4WylZGAqG/42A==
X-Authority-Analysis: v=2.4 cv=U72fzOru c=1 sm=1 tr=0 ts=697bbdc2 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=GvQkQWPkAAAA:8
 a=PyCarBDI3Nz51ks_hl0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41724-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,redhat.com,kernel.org,gmail.com,linux.dev,cmpxchg.org,lge.com,google.com,linux.alibaba.com,huaweicloud.com,oracle.com,infradead.org,vger.kernel.org,tencent.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim]
X-Rspamd-Queue-Id: AA614B425B
X-Rspamd-Action: no action

Kairui Song <ryncsn@gmail.com> wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> The current swap entry allocation/freeing workflow has never had a clear
> definition. This makes it hard to debug or add new optimizations.
> 
> This commit introduces a proper definition of how swap entries would be
> allocated and freed. Now, most operations are folio based, so they will
> never exceed one swap cluster, and we now have a cleaner border between
> swap and the rest of mm, making it much easier to follow and debug,
> especially with new added sanity checks. Also making more optimization
> possible.
> 
> Swap entry will be mostly allocated and free with a folio bound.
> The folio lock will be useful for resolving many swap ralated races.
> 
> Now swap allocation (except hibernation) always starts with a folio in
> the swap cache, and gets duped/freed protected by the folio lock:

[ ... ]

Hi everyone,

Apologies for looping back around on this one, but I've got some prompt
changes that break down larger commits into sections and run them
independently through review.  I reran it on mm-new, and it found something
new:

> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 64970ee11fcf7..85bf4f7d9ae7b 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c

[ ... ]

> @@ -2195,7 +2265,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  	/*
>  	 * Some architectures may have to restore extra metadata to the page
>  	 * when reading from swap. This metadata may be indexed by swap entry
> -	 * so this must be called before swap_free().
> +	 * so this must be called before folio_put_swap().
>  	 */
>  	arch_swap_restore(folio_swap(entry, folio), folio);
>
> @@ -2236,7 +2306,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  		new_pte = pte_mkuffd_wp(new_pte);
>  setpte:
>  	set_pte_at(vma->vm_mm, addr, pte, new_pte);
> -	swap_free(entry);
> +	folio_put_swap(folio, page);

Does this corrupt the swap map when ksm_might_need_to_copy() returns a
new folio? In that case, folio != swapcache, and the new folio is NOT in
the swap cache with folio->swap = 0. This would trigger
VM_WARN_ON_FOLIO(!folio_test_swapcache(folio), folio) and call
swap_entries_put_map() with entry.val = 0.

Compare with do_swap_page() which correctly uses folio_put_swap(swapcache,
NULL) when folio != swapcache. Should this use the original entry parameter
or the swapcache folio instead?


