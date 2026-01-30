Return-Path: <linux-pm+bounces-41790-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKgVDNTgfGmpPAIAu9opvQ
	(envelope-from <linux-pm+bounces-41790-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 17:48:20 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AD418BC9F0
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 17:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13FD83001FDC
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 16:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22302EFD99;
	Fri, 30 Jan 2026 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enma0iK4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B20E2D3231
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 16:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769791697; cv=none; b=JMKrpQujffkLG5WStrgihUcPJazDnbPh8zK3TirJ1PZq9SCDWtiIYqopTDCwsIoHhfJBGHW27QNEk6roHMZP2PZ4ypiowHJ+ss3UD8T3QMIIjQs9g7Ugc3+aSq2xaxasMRiNFbEBcQscq5R577O8ilweY5FVxMbfMt/kLMqksKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769791697; c=relaxed/simple;
	bh=8TcyAVAzuazTCLZLMOXh3if7mTGu0BMjq8uuxiKKG+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDjg7kj1vVzhTWiE+z2q5C4f7EaaVoGUCCZNw8WVLN2pnHrY3zIYmwiJWncsfZ0dIZJRk7MMVDjfzDoGUQ0dGjHLth4fwV/AV9c3f2Xp1N1Ncu1qS0iJBpJpDH8uKJ9DZ6hfLnuZrtqwlNFVlsPnT8vC0Wg5XFD/yJ1Y8yObMpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enma0iK4; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3543b9f60e3so563205a91.3
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 08:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769791696; x=1770396496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d0bsS3V6tz831x+5BztayPCxzrLGcuyzVdHvWPehnBU=;
        b=enma0iK4uHt+tEIzZxr4PmsZuvwFTlqL/8aB9yHNT2jM7dWl2r/GMhF0t+wZYDC3Xq
         LzebU6fKbQU/MYkGlm2UtE08PamLUJe92pQoDvApMbxYIW3SzJBrqbnOuarP+5znJhXz
         Dg29ybzqVIFTD4hsrazEHNYR9byFgReD2SvJqdtmeZhaWee7soDkMOzN6ey9a3pWa1wb
         1powYclP6PzMorCMXPHavYLs2JbPfm5v1Vdb/iYLEGD4Od1Bhr5L7qPhMrKRvreetre8
         LFvniiD19lr3VCuLAVxNIrMNiZSz8ugWMeMtsNaMJT8Oiop7cZpIsbAAh1Lpjt9b9QTt
         peQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769791696; x=1770396496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0bsS3V6tz831x+5BztayPCxzrLGcuyzVdHvWPehnBU=;
        b=Wm6tIfiNFyQEy/PqqzWWpVWdHnInmZNMnXesxd1s2ZIS5sj5a/2r2dsp9WRS+/vfXM
         DLBiSkA4Ft73ICdDKoSd4lyiOwqG1feR3eYytc8yGOSPcsCfEyhDXL471U2Vbifmq28n
         48Q5VtT8xKvxTbM0SInkE62lMhOWO29LyubAn3e+q74LFEcj8aT6Ll2cd7ynbY1hyH9c
         lZNp8JbQWb6czCkxMYm3rvWWWBI9iSoYYxkc84rK+Q04wHJ0DH8TWCk9w3MXsPDmxzxq
         /Fs8fk7A459Rlw+MmhxdTZ47lsbaj0UTEa1z5MS00Ewhf/P3lF9HCpG0u5IiFUS65Gfs
         KiRw==
X-Forwarded-Encrypted: i=1; AJvYcCVCdbdfHzuymMwkYVZmNkzyfnHy08ED+BQeHjb+CpKQFb4KONGKPuHPVXfB/8oDPWSyAoMJtXfmhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxN5XLROsRBFHpw4iQEQ0/SH2rWrsYGo1yLNiBNYBVIVrjzebo
	Gmo19ndru08ZK+x9wlGh4tk3F26c1RdS1s1k5RU1IESu3+yRGtWqD8dw
X-Gm-Gg: AZuq6aIYqlQffMbE4wVrDrz73U5NLr3T+7vZ7CxqoNWwP78m7LUPaz5r5+wf+9KAdrh
	b2BvP1YvNoKaVTzBi3N14kl6iEYyB7CJIV7lmNYcsWbs2EKn0XJ8/D1oVPVAEjKH6z4dOc6mtoL
	uRX5mB0numef2CDGC9oPRdDRyEPtCD8K5rRO3PmAgNhnUjJCHLXEGramjfE5RnfZn00iWXSu7u3
	YEocErxThQ3KxKmgPj4k6tU/QNbvB9ztfvtRjeU0n3K/SRytiHZ9JClZ5AwhUFJExpJiTYy2FJU
	i1ziNXQkTxeXSKaXRBElCXcFimrTZKhyycd0u6oMntJfBBN6gjufI+W3TAS9JaxNJKGUKStspx9
	kB3vSJdyLXMcxuK2wBk4AFR+d0xhrAAhP13Ig3wdNecdGiHFL2kI1yq7QLbg+I9+/qexFf5ItA2
	GMKZWQG4Ndz1EmK8XiOsu/CQYS5YMldakEpdVHWpvA3zdv5TE=
X-Received: by 2002:a17:90b:1348:b0:34c:2db6:57f1 with SMTP id 98e67ed59e1d1-3543b3d1227mr3086067a91.30.1769791695949;
        Fri, 30 Jan 2026 08:48:15 -0800 (PST)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3543c1b0c72sm1048655a91.6.2026.01.30.08.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:48:15 -0800 (PST)
Date: Sat, 31 Jan 2026 00:48:07 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Chris Mason <clm@meta.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>, linux-pm@vger.kernel.org, 
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Subject: Re: [PATCH v5 14/19] mm, swap: cleanup swap entry management workflow
Message-ID: <aXxkANcET3l2Xu6J@KASONG-MC4>
References: <20251220-swap-table-p2-v5-0-8862a265a033@tencent.com>
 <20251220-swap-table-p2-v5-14-8862a265a033@tencent.com>
 <20260129200604.2518109-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129200604.2518109-1-clm@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41790-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,redhat.com,kernel.org,gmail.com,linux.dev,cmpxchg.org,lge.com,google.com,linux.alibaba.com,huaweicloud.com,oracle.com,infradead.org,vger.kernel.org,tencent.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD418BC9F0
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 11:32:38AM +0800, Chris Mason wrote:
> Kairui Song <ryncsn@gmail.com> wrote:
> > From: Kairui Song <kasong@tencent.com>
> > 
> > The current swap entry allocation/freeing workflow has never had a clear
> > definition. This makes it hard to debug or add new optimizations.
> > 
> > This commit introduces a proper definition of how swap entries would be
> > allocated and freed. Now, most operations are folio based, so they will
> > never exceed one swap cluster, and we now have a cleaner border between
> > swap and the rest of mm, making it much easier to follow and debug,
> > especially with new added sanity checks. Also making more optimization
> > possible.
> > 
> > Swap entry will be mostly allocated and free with a folio bound.
> > The folio lock will be useful for resolving many swap ralated races.
> > 
> > Now swap allocation (except hibernation) always starts with a folio in
> > the swap cache, and gets duped/freed protected by the folio lock:
> 
> [ ... ]
> 
> Hi everyone,
> 
> Apologies for looping back around on this one, but I've got some prompt
> changes that break down larger commits into sections and run them
> independently through review.  I reran it on mm-new, and it found something
> new:
> 
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 64970ee11fcf7..85bf4f7d9ae7b 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> 
> [ ... ]
> 
> > @@ -2195,7 +2265,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
> >  	/*
> >  	 * Some architectures may have to restore extra metadata to the page
> >  	 * when reading from swap. This metadata may be indexed by swap entry
> > -	 * so this must be called before swap_free().
> > +	 * so this must be called before folio_put_swap().
> >  	 */
> >  	arch_swap_restore(folio_swap(entry, folio), folio);
> >
> > @@ -2236,7 +2306,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
> >  		new_pte = pte_mkuffd_wp(new_pte);
> >  setpte:
> >  	set_pte_at(vma->vm_mm, addr, pte, new_pte);
> > -	swap_free(entry);
> > +	folio_put_swap(folio, page);
> 
> Does this corrupt the swap map when ksm_might_need_to_copy() returns a
> new folio? In that case, folio != swapcache, and the new folio is NOT in
> the swap cache with folio->swap = 0. This would trigger
> VM_WARN_ON_FOLIO(!folio_test_swapcache(folio), folio) and call
> swap_entries_put_map() with entry.val = 0.
> 
> Compare with do_swap_page() which correctly uses folio_put_swap(swapcache,
> NULL) when folio != swapcache. Should this use the original entry parameter
> or the swapcache folio instead?

Thanks again for running the AI review. And it's really helpful.

This is a valid case, I missed the KSM copy pages for swapoff indeed.

We do need the following change squashed as you suggested.

Hi Andrew, can you help squash add following fix? I just ran more
stress tests with KSM and racing swapoff, and everything is looking
good now.

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 8c0f31363c1f..d652486898de 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2305,7 +2305,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		new_pte = pte_mkuffd_wp(new_pte);
 setpte:
 	set_pte_at(vma->vm_mm, addr, pte, new_pte);
-	folio_put_swap(folio, page);
+	folio_put_swap(swapcache, folio_file_page(swapcache, swp_offset(entry)));
 out:
 	if (pte)
 		pte_unmap_unlock(pte, ptl);

