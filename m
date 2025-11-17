Return-Path: <linux-pm+bounces-38120-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F470C63D1A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 12:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7EF0B353E25
	for <lists+linux-pm@lfdr.de>; Mon, 17 Nov 2025 11:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751DE28031C;
	Mon, 17 Nov 2025 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YuGDdhb2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D3C24503B;
	Mon, 17 Nov 2025 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763378637; cv=none; b=XedqtMeayiZyn14H2MOUI7DEasnN2RiR2tARw7kN8K6WpLB2wUhqWIA8AHfOpJqJVejx1wP1wTeGs9L17Jit5tmtGlNRS2QWz6/miI+FToC8bxzfuLeY6vp73jxCAyXo49jXPKIW88RivhN2IFT/ytMMfvq3u0Z3kIYqXFykYqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763378637; c=relaxed/simple;
	bh=cTGDxRw5DV/5F6cyNFPFL7KahCJxLa5f7QjjORs1c9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H62ZqRylDYLZ8R/9j8dcRhOlB+qvYwcad3x/fqQ96VX+1cb2vWMEvEOZzL7HjaV/sErKqx/pGINqaUJ8bGo66JTnkaNnu6xlBghhlt1RsTtZevYjGYt+mhctLmq7T8bDIb0lXbG4t086Gr1+zoIGAoDtxzg9TNroQwGmyAkOY6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YuGDdhb2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763378634; x=1794914634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cTGDxRw5DV/5F6cyNFPFL7KahCJxLa5f7QjjORs1c9I=;
  b=YuGDdhb2gKIEzxN1ag/fvMDfj+wnYK+F46cPsQjZ8VDGMwcJNFpNtTme
   N/xb0Y6wjLamp0FT+mLz4mRHK089Eh37HeS6V3VdY0MCGns62sB7cXJri
   0A6wZm0CHMpo2plLXNKwXsIiSG7Pd/tzif8KggIZDHHXaBwBNEP5WqkFZ
   4HSeEeH52zJfw0SavP24cJQKyiYaqcgIsJGGgNd9nvVDRe6COxlrJ9gQR
   cf3Z6LoQkjEKCTgMDStp9gKjXEjApOyf0uV8uAVvrM0QT31VTOYwgppji
   cWhBAGDhEStzf5jwtaTolbMZgwBhwMO2aHS3sV3qhFogIzY3ie1QTq4z3
   Q==;
X-CSE-ConnectionGUID: GSZ0lbnKSkq1jURrYvg/Bg==
X-CSE-MsgGUID: hwwvv15EQz6Lr7iPbXPyow==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="75695577"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="75695577"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 03:23:54 -0800
X-CSE-ConnectionGUID: b9ifM0dCTFS+JVYwdDo7VQ==
X-CSE-MsgGUID: OrnG25PlR/6uAcHgIyuVEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="190871048"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 17 Nov 2025 03:23:49 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vKxKk-0000U3-1w;
	Mon, 17 Nov 2025 11:23:46 +0000
Date: Mon, 17 Nov 2025 19:23:00 +0800
From: kernel test robot <lkp@intel.com>
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 14/19] mm, swap: sanitize swap entry management
 workflow
Message-ID: <202511171942.psG9jTRx-lkp@intel.com>
References: <20251117-swap-table-p2-v2-14-37730e6ea6d5@tencent.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117-swap-table-p2-v2-14-37730e6ea6d5@tencent.com>

Hi Kairui,

kernel test robot noticed the following build errors:

[auto build test ERROR on 41218ede767f6b218185af65ce919d0cade75f6b]

url:    https://github.com/intel-lab-lkp/linux/commits/Kairui-Song/mm-swap-rename-__read_swap_cache_async-to-swap_cache_alloc_folio/20251117-021532
base:   41218ede767f6b218185af65ce919d0cade75f6b
patch link:    https://lore.kernel.org/r/20251117-swap-table-p2-v2-14-37730e6ea6d5%40tencent.com
patch subject: [PATCH v2 14/19] mm, swap: sanitize swap entry management workflow
config: s390-defconfig (https://download.01.org/0day-ci/archive/20251117/202511171942.psG9jTRx-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 0bba1e76581bad04e7d7f09f5115ae5e2989e0d9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251117/202511171942.psG9jTRx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511171942.psG9jTRx-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/s390/mm/gmap_helpers.c:35:2: error: call to undeclared function 'free_swap_and_cache'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      35 |         free_swap_and_cache(entry);
         |         ^
   arch/s390/mm/gmap_helpers.c:35:2: note: did you mean 'free_swap_cache'?
   include/linux/swap.h:435:6: note: 'free_swap_cache' declared here
     435 | void free_swap_cache(struct folio *folio);
         |      ^
   1 error generated.


vim +/free_swap_and_cache +35 arch/s390/mm/gmap_helpers.c

200197908dc4af Claudio Imbrenda 2025-05-28  19  
200197908dc4af Claudio Imbrenda 2025-05-28  20  /**
6539cf8c98a8cc Lorenzo Stoakes  2025-11-10  21   * ptep_zap_softleaf_entry() - discard a software leaf entry.
200197908dc4af Claudio Imbrenda 2025-05-28  22   * @mm: the mm
6539cf8c98a8cc Lorenzo Stoakes  2025-11-10  23   * @entry: the software leaf entry that needs to be zapped
200197908dc4af Claudio Imbrenda 2025-05-28  24   *
6539cf8c98a8cc Lorenzo Stoakes  2025-11-10  25   * Discards the given software leaf entry. If the leaf entry was an actual
6539cf8c98a8cc Lorenzo Stoakes  2025-11-10  26   * swap entry (and not a migration entry, for example), the actual swapped
200197908dc4af Claudio Imbrenda 2025-05-28  27   * page is also discarded from swap.
200197908dc4af Claudio Imbrenda 2025-05-28  28   */
6539cf8c98a8cc Lorenzo Stoakes  2025-11-10  29  static void ptep_zap_softleaf_entry(struct mm_struct *mm, softleaf_t entry)
200197908dc4af Claudio Imbrenda 2025-05-28  30  {
6539cf8c98a8cc Lorenzo Stoakes  2025-11-10  31  	if (softleaf_is_swap(entry))
200197908dc4af Claudio Imbrenda 2025-05-28  32  		dec_mm_counter(mm, MM_SWAPENTS);
6539cf8c98a8cc Lorenzo Stoakes  2025-11-10  33  	else if (softleaf_is_migration(entry))
6539cf8c98a8cc Lorenzo Stoakes  2025-11-10  34  		dec_mm_counter(mm, mm_counter(softleaf_to_folio(entry)));
200197908dc4af Claudio Imbrenda 2025-05-28 @35  	free_swap_and_cache(entry);
200197908dc4af Claudio Imbrenda 2025-05-28  36  }
200197908dc4af Claudio Imbrenda 2025-05-28  37  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

