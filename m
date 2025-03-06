Return-Path: <linux-pm+bounces-23535-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A25A54346
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 08:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BBB57A54DF
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 07:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530F71A5BB4;
	Thu,  6 Mar 2025 07:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LeAjoiyi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A4017578;
	Thu,  6 Mar 2025 07:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741244942; cv=none; b=hS8jgRoWLT/2UPCDUERtA6V6prEKBJGk8nVBAxy+eOoP/KWFqJBT6pec01FKsOlfzBbAwKcJPXssYM7Xy+LdB3qFetNQy3h+jU4QfWvoBlY/yJsmDv90G7PxrwbcdVpeJ+WEe/xSAsTJxaCscv0bAjusEh4NgK/nuTc3MR7Pwpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741244942; c=relaxed/simple;
	bh=JHi8UXl8GUqLSAuscmwn6bMuAQ1tJw2Jj/t1j0/pNyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDJT3jhDBQx1LpatHDVInqdSx9E/CR4pbG1QP5D0vf4gp7wkQ45TzYyp3h4zgggFsXYB8xrICkh8UEa40vwk14qIa43cXJUb89lH2+nvkx8U3UR3sQv6CLRHQDwVW8AEXGrcnvg1NssWhS64c5APF4IPmntSTJOPM2J0iruhmww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LeAjoiyi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741244941; x=1772780941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JHi8UXl8GUqLSAuscmwn6bMuAQ1tJw2Jj/t1j0/pNyo=;
  b=LeAjoiyicOtxJdOwrEAhHSCWgo+K6h7qayOLIV8+j/2L9gHVUoKu1t9u
   j+TPoEdFXSZ1p9KjpUmLzblS9Shc6Cvaur7no3pj5y1bnxRbRwiPIn5zB
   KTtMDI1NdoRbr2NlcqTSwGh+jlUyqUKYkL/Z3TQ1xtVMq9m0SW7tEHxnS
   1Bi6WPhc+SEOYJRDIzeT4Ie5zMYnEN4ySpNDSU3M+gQAuayRb/HrCjdS0
   YQJ8NE8WepYdYXCwZxMO7VPiOEDZb+4fMCxacNMOOpLxKi3UBgnDsIyfZ
   UNv6zeRo6tQv3IlozAUkoQvcsNbEXy+loEBWyocOyXVK0sXcnPFdJTZjI
   g==;
X-CSE-ConnectionGUID: VnE/NhqEQ2e5aECzqvzLCQ==
X-CSE-MsgGUID: VM+6X3LdSVWoCrXvQS3NAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59787446"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="59787446"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 23:09:00 -0800
X-CSE-ConnectionGUID: rpYd3w6+RUWDRAvL7JK5AQ==
X-CSE-MsgGUID: G2PCcL1KTNSzZ9P29oZOyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156159759"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 05 Mar 2025 23:08:54 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tq5LQ-000Mgg-06;
	Thu, 06 Mar 2025 07:08:50 +0000
Date: Thu, 6 Mar 2025 15:07:43 +0800
From: kernel test robot <lkp@intel.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, ulf.hansson@linaro.org,
	m.szyprowski@samsung.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Michal Wilczynski <m.wilczynski@samsung.com>
Subject: Re: [PATCH v1 2/5] firmware: thead: Add AON firmware protocol driver
Message-ID: <202503061453.DvzBlKdM-lkp@intel.com>
References: <20250303145901.446791-3-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303145901.446791-3-m.wilczynski@samsung.com>

Hi Michal,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.14-rc5 next-20250305]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Wilczynski/dt-bindings-firmware-thead-th1520-Add-support-for-firmware-node/20250303-230224
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250303145901.446791-3-m.wilczynski%40samsung.com
patch subject: [PATCH v1 2/5] firmware: thead: Add AON firmware protocol driver
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20250306/202503061453.DvzBlKdM-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250306/202503061453.DvzBlKdM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503061453.DvzBlKdM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/firmware/thead,th1520-aon.c:206:13: error: call to undeclared function 'kzalloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     206 |         aon_chan = kzalloc(sizeof(*aon_chan), GFP_KERNEL);
         |                    ^
>> drivers/firmware/thead,th1520-aon.c:206:11: error: incompatible integer to pointer conversion assigning to 'struct th1520_aon_chan *' from 'int' [-Wint-conversion]
     206 |         aon_chan = kzalloc(sizeof(*aon_chan), GFP_KERNEL);
         |                  ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/firmware/thead,th1520-aon.c:219:3: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     219 |                 kfree(aon_chan);
         |                 ^
   drivers/firmware/thead,th1520-aon.c:241:2: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     241 |         kfree(aon_chan);
         |         ^
   4 errors generated.


vim +206 drivers/firmware/thead,th1520-aon.c

   185	
   186	/**
   187	 * th1520_aon_init() - Initialize TH1520 AON firmware protocol interface
   188	 * @dev: Device pointer for the AON subsystem
   189	 *
   190	 * This function initializes the TH1520 AON firmware protocol interface by:
   191	 * - Allocating and initializing the AON channel structure
   192	 * - Setting up the mailbox client
   193	 * - Requesting the AON mailbox channel
   194	 * - Initializing synchronization primitives
   195	 *
   196	 * Return:
   197	 * * Valid pointer to th1520_aon_chan structure on success
   198	 * * ERR_PTR(-ENOMEM) if memory allocation fails
   199	 * * ERR_PTR() with other negative error codes from mailbox operations
   200	 */
   201	struct th1520_aon_chan *th1520_aon_init(struct device *dev)
   202	{
   203		struct th1520_aon_chan *aon_chan;
   204		struct mbox_client *cl;
   205	
 > 206		aon_chan = kzalloc(sizeof(*aon_chan), GFP_KERNEL);
   207		if (!aon_chan)
   208			return ERR_PTR(-ENOMEM);
   209	
   210		cl = &aon_chan->cl;
   211		cl->dev = dev;
   212		cl->tx_block = true;
   213		cl->tx_tout = MAX_TX_TIMEOUT;
   214		cl->rx_callback = th1520_aon_rx_callback;
   215	
   216		aon_chan->ch = mbox_request_channel_byname(cl, "aon");
   217		if (IS_ERR(aon_chan->ch)) {
   218			dev_err(dev, "Failed to request aon mbox chan\n");
 > 219			kfree(aon_chan);
   220			return ERR_CAST(aon_chan->ch);
   221		}
   222	
   223		mutex_init(&aon_chan->transaction_lock);
   224		init_completion(&aon_chan->done);
   225	
   226		return aon_chan;
   227	}
   228	EXPORT_SYMBOL_GPL(th1520_aon_init);
   229	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

