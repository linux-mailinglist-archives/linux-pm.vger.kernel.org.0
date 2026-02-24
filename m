Return-Path: <linux-pm+bounces-43109-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN4hC+xXnWk2OgQAu9opvQ
	(envelope-from <linux-pm+bounces-43109-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 08:49:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DCE1833E4
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 08:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08E7A302796A
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 07:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C75B364EB0;
	Tue, 24 Feb 2026 07:48:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514E303A12
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771919329; cv=none; b=bYvClEdSUTG57tdFJYLCCCer5zjA5YHMrmgcRBJ+11Ul8ndoHM5VlOD9GJJjXUYjAQ+3rZ888r9vPqohtDcrIVH628ZZRr/c0ajO5uLXriiydMbHg19zp0WyLgV0/SaJDSNp3BxH8IcgAhYquRvBKeWbcjreaHaBgTf6wGkKq4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771919329; c=relaxed/simple;
	bh=negKzoHZsxPU4o58MLlTjaixMIH5ZB/SrLcnXPhBDSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcnAMgI7ITtWr8x8qnUWTCErYvCxj2bXs62GS5e5HjiSJ1tXG6mCXoSHddChDSlSGEID0SBBsxQdzShW3zOq44r+hXZ0xTPs+vUogY9sX3Tyvl0el8eNYAuiusvg4G+29WqFRX1RWuKU5QI9aKgUGeFBtVNk8pcYTXSW/VZh5L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 24 Feb 2026 16:48:36 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 24 Feb 2026 16:48:36 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Carsten Grohmann <mail@carstengrohmann.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
	taejoon.song@lge.com,
	"hyungjun.cho@lge.com Carsten Grohmann" <carstengrohmann@gmx.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mm, swap: speed up hibernation allocation and
 writeout
Message-ID: <aZ1X1OwbAUq1k+C6@yjaykim-PowerEdge-T330>
References: <20260216-hibernate-perf-v4-0-1ba9f0bf1ec9@tencent.com>
 <20260216-hibernate-perf-v4-1-1ba9f0bf1ec9@tencent.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216-hibernate-perf-v4-1-1ba9f0bf1ec9@tencent.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43109-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,huaweicloud.com,gmail.com,redhat.com,carstengrohmann.de,vger.kernel.org,lge.com,gmx.de];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[linux-pm];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4DCE1833E4
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 10:58:02PM +0800, Kairui Song via B4 Relay wrote:
> From: Kairui Song &lt;kasong@tencent.com&gt;
> 
> Since commit 0ff67f990bd4 ("mm, swap: remove swap slot cache"),
> hibernation has been using the swap slot slow allocation path for
> simplification, which turns out might cause regression for some
> devices because the allocator now rotates clusters too often, leading to
> slower allocation and more random distribution of data.
...
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index c6863ff7152c..32e0e7545ab8 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1926,8 +1926,9 @@ void swap_put_entries_direct(swp_entry_t entry, int nr)
>  /* Allocate a slot for hibernation */
>  swp_entry_t swap_alloc_hibernation_slot(int type)
>  {
> -	struct swap_info_struct *si = swap_type_to_info(type);
> -	unsigned long offset;
> +	struct swap_info_struct *pcp_si, *si = swap_type_to_info(type);
> +	unsigned long pcp_offset, offset = SWAP_ENTRY_INVALID;
> +	struct swap_cluster_info *ci;
>  	swp_entry_t entry = {0};
>  
>  	if (!si)
> @@ -1937,11 +1938,21 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
>  	if (get_swap_device_info(si)) {

Hi Kairui :)

Reading through the patch, I have some thoughts and review comments regarding
the hibernation slot allocation logic. I'd like to discuss potential
improvements. (Somewhat long... lot of thoughts come up on my mind)

First, regarding the race with swapoff and refcounting.

The code identifies the swap type before allocation, so a swapoff could
occur in between. It seems safer to acquire the reference when identifying
the type (e.g., find_first_swap). Also, instead of repeating get/put for
every slot (allocation and free), could we hold the reference once during
the initial lookup and release it after the image load? This avoids
overhead since swapoff is effectively blocked once hibernation slots are
allocated.

>  		if (si->flags & SWP_WRITEOK) {
>  			/*
> -			 * Grab the local lock to be compliant
> -			 * with swap table allocation.
> +			 * Try the local cluster first if it matches the device. If
> +			 * not, try grab a new cluster and override local cluster.
>  			 */
>  			local_lock(&percpu_swap_cluster.lock);

Second, regarding local_lock:

It seems mandatory now because distinguishing the lock context during swap
table allocation is tricky (e.g., GFP_KERNEL allocation assumes a local
locked context). Have you considered modifying the swap table allocation
logic to handle this specifically? This might allow us to avoid holding the
local_lock, especially if the device is not SWP_SOLIDSTATE.

> -			offset = cluster_alloc_swap_entry(si, NULL);
> +			pcp_si = this_cpu_read(percpu_swap_cluster.si[0]);
> +			pcp_offset = this_cpu_read(percpu_swap_cluster.offset[0]);
> +			if (pcp_si == si && pcp_offset) {
> +				ci = swap_cluster_lock(si, pcp_offset);
> +				if (cluster_is_usable(ci, 0))
> +					offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
> +				else
> +					swap_cluster_unlock(ci);
> +			}
> +			if (!offset)
> +				offset = cluster_alloc_swap_entry(si, NULL);
>  			local_unlock(&percpu_swap_cluster.lock);
>  			if (offset)
>  				entry = swp_entry(si->type, offset);

Third, regarding cluster allocation:

1. If hibernation targets a lower-priority device, the per-cpu cluster
usage might cause priority inversion (though minimal).

2. Have you considered treating clusters as a global resource for this
case? For instance, caching next_offset in si(using union on global_cluster or new field) or allowing the
allocator to calculate the next value directly, rather than splitting
clusters per CPU.

Finally, regarding readahead and freeing:

Hibernation slots might be read during cluster-based readahead. Can we
avoid this (e.g., by checking for a NULL fake shadow entry or adding a specific
check for hibernation slots)? If so, we could also avoid triggering
try_to_reclaim when freeing these slots.

Thanks for your work!

Youngjun Park

