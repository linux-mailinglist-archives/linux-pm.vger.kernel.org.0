Return-Path: <linux-pm+bounces-34430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F25B52773
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 06:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459E5466692
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 04:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A61620D4FF;
	Thu, 11 Sep 2025 04:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="T+c3U+WP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140288479;
	Thu, 11 Sep 2025 04:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757563579; cv=none; b=Z6KKeZLYvmIUFaLqeyLqSD1JrcB98UtCV4Uu9U5slQNG6EbNfEjcrh56UXIOlfO7XndDq+EQF6rzdDL5DeydyKfrqahx+1YsxGzLw60+Qnqn297UGn48NUaHh34Leu0PLu3JX2Ff8W3eRvq/pMHAz2rLT4YNx/hf9Swt0oavET4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757563579; c=relaxed/simple;
	bh=XD1QSSFfVHOr4OTEEmvGiDD54M5WcW1c3PzamhsKJ98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPhzKImVBbNohDXqqKG6xqw+7+Bxl1rmRjAP3QIuyRNWpSppznw1zsfXvR0bZvtxPrX36lGv4RzerHMG8OHtNBg7SYciq4V/CtFqd7uuc490JMHQzALBgkMwqfBBVe7y1gPAizDT6EvwY4Pvhr4ZASOR9V3/rY9WW/XiuS60Ccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=T+c3U+WP; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=L+ZiXp1IFzinH43Jn6HBGwbQndfUjUiqfZdlX6XJIdo=;
	b=T+c3U+WPfvefnsNsJJ30wBpxcsv2kbWCzFHmObn6AGfSdiSSo+VttGO6OwIfJralUoLj3+q4r
	XmJf+7xJEjt2Ar4kAZ9pJfcfHDORNqjRWgvpJxbf0BooCMeJv7gzACG+HrCj+qHQyEYUbOahAI3
	psxF0XBvtHkBbxPpkzhVcZw=
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4cMkW81DtKzYl1NY;
	Thu, 11 Sep 2025 12:05:56 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 11 Sep
 2025 12:06:13 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 11 Sep
 2025 12:06:13 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <akpm@linux-foundation.org>, <feng.han@honor.com>, <lenb@kernel.org>,
	<liam.howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-pm@vger.kernel.org>, <liulu.liu@honor.com>,
	<lorenzo.stoakes@oracle.com>, <pavel@kernel.org>, <rafael@kernel.org>,
	<rientjes@google.com>, <shakeel.butt@linux.dev>, <surenb@google.com>,
	<tglx@linutronix.de>, <zhongjinji@honor.com>
Subject: Re: [PATCH v9 2/2] mm/oom_kill: The OOM reaper traverses the VMA maple tree in reverse order
Date: Thu, 11 Sep 2025 12:06:09 +0800
Message-ID: <20250911040609.6126-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <aMGXsenuvA682-Dc@tiehlicka>
References: <aMGXsenuvA682-Dc@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w012.hihonor.com (10.68.27.189) To a018.hihonor.com
 (10.68.17.250)

> On Wed 10-09-25 22:37:26, zhongjinji wrote:
> > Although the oom_reaper is delayed and it gives the oom victim chance to
> > clean up its address space this might take a while especially for
> > processes with a large address space footprint. In those cases
> > oom_reaper might start racing with the dying task and compete for shared
> > resources - e.g. page table lock contention has been observed.
> > 
> > Reduce those races by reaping the oom victim from the other end of the
> > address space.
> > 
> > It is also a significant improvement for process_mrelease(). When a process
> > is killed, process_mrelease is used to reap the killed process and often
> > runs concurrently with the dying task. The test data shows that after
> > applying the patch, lock contention is greatly reduced during the procedure
> > of reaping the killed process.
> > 
> > The test is based on arm64.
> > 
> > Without the patch:
> > |--99.57%-- oom_reaper
> > |    |--0.28%-- [hit in function]
> > |    |--73.58%-- unmap_page_range
> > |    |    |--8.67%-- [hit in function]
> > |    |    |--41.59%-- __pte_offset_map_lock
> > |    |    |--29.47%-- folio_remove_rmap_ptes
> > |    |    |--16.11%-- tlb_flush_mmu
> > |    |    |--1.66%-- folio_mark_accessed
> > |    |    |--0.74%-- free_swap_and_cache_nr
> > |    |    |--0.69%-- __tlb_remove_folio_pages
> > |    |--19.94%-- tlb_finish_mmu
> > |    |--3.21%-- folio_remove_rmap_ptes
> > |    |--1.16%-- __tlb_remove_folio_pages
> > |    |--1.16%-- folio_mark_accessed
> > |    |--0.36%-- __pte_offset_map_lock
> > 
> > With the patch:
> > |--99.53%-- oom_reaper
> > |    |--55.77%-- unmap_page_range
> > |    |    |--20.49%-- [hit in function]
> > |    |    |--58.30%-- folio_remove_rmap_ptes
> > |    |    |--11.48%-- tlb_flush_mmu
> > |    |    |--3.33%-- folio_mark_accessed
> > |    |    |--2.65%-- __tlb_remove_folio_pages
> > |    |    |--1.37%-- _raw_spin_lock
> > |    |    |--0.68%-- __mod_lruvec_page_state
> > |    |    |--0.51%-- __pte_offset_map_lock
> > |    |--32.21%-- tlb_finish_mmu
> > |    |--6.93%-- folio_remove_rmap_ptes
> > |    |--1.90%-- __tlb_remove_folio_pages
> > |    |--1.55%-- folio_mark_accessed
> > |    |--0.69%-- __pte_offset_map_lock
> 
> I do not object to the patch but this profile is not telling much really
> as already pointed out in prior versions as we do not know the base
> those percentages are from. It would be really much more helpful to
> measure the elapse time for the oom_repaer and exit_mmap to see those
> gains.

I got it. I will reference the perf report like this [1] in the changelog.
link : https://lore.kernel.org/all/20250908121503.20960-1-zhongjinji@honor.com/ [1]

