Return-Path: <linux-pm+bounces-23529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE945A53EE4
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 01:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBB83A8D98
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 00:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AA610E4;
	Thu,  6 Mar 2025 00:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YSGyQeHY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61673366;
	Thu,  6 Mar 2025 00:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219693; cv=none; b=rIvDt/lS6ZMPydIr8Zm1AoIdAoZ69tXnnrpDvkB10cThjJdgBR4D67CfuySauvKKBftJPorPYv7952kO/dziQ0JalF3UwV31DFRSkUBIfuPzB/BA4wU/AdXqArnFmwyFirUWykSzmkfxoSqwFf+7LZNtLEy5CxAQ4HnFEanaOZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219693; c=relaxed/simple;
	bh=XmkEAc+/w2Dkxu/1TNTvMeosZ3tOVAg+QYljZPhFBjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQ/lUSzBaDqS6PDVexIHBbZn0L8bwCM4rcAVK4F+eGGB72iVRlcxMCOFvbbG8g0bsAAoh1QwiL7PShDebQFiNLVR6fPKTKYUHaxSPSRXdPnxGgTp6/3j681+InDL1NJ1RJlHnHGiIE9AL6MxCDVjPLvizrooKWQ7MiZXe5F3GlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YSGyQeHY; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741219692; x=1772755692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XmkEAc+/w2Dkxu/1TNTvMeosZ3tOVAg+QYljZPhFBjc=;
  b=YSGyQeHYdoUNPvRIFBRAPZnPaKMd+rxh08PCBS9imL31ht5nHuvGY9G/
   xQWCjcn1gfy22MP+O+aJT02DVRQ+0So59oaT24hJF/RZe7T1i9yJj3OT6
   X8ebJDZG7gZB0g23EFkWdsm0tZf/tKa4DfUO0y/9NJQyeqBXmiSnG2hVJ
   AovSNX8K3bKXkAek4oSu17uBv/LXuMsrb+dk1NqT29QvACMLGR5nFBcsn
   rztdqK5aGNthh8s62QbAJA+cRhVTjksgQ1+B31+DryTl9fSJvINsBO3J1
   wHo3Hqfh+sChcHt6oKzQPNMRUQrW6uEc8X6+GsJKGVdbZ1upzcXp/vWkd
   g==;
X-CSE-ConnectionGUID: 8VsXSkovQ86/RTBQMBd0nQ==
X-CSE-MsgGUID: U7vsS2ckS2G9VH5+ixXtyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42341118"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="42341118"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 16:05:55 -0800
X-CSE-ConnectionGUID: QY7iUrB3R0C/1HrbrZxxLg==
X-CSE-MsgGUID: 3ucTVqz5SF+bWZZ35HJ1vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="149619719"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 05 Mar 2025 16:05:47 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpyju-000MLA-0L;
	Thu, 06 Mar 2025 00:05:27 +0000
Date: Thu, 6 Mar 2025 08:04:23 +0800
From: kernel test robot <lkp@intel.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	jszhang@kernel.org, ulf.hansson@linaro.org,
	m.szyprowski@samsung.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Michal Wilczynski <m.wilczynski@samsung.com>
Subject: Re: [PATCH v1 2/5] firmware: thead: Add AON firmware protocol driver
Message-ID: <202503060707.a8CwuQbH-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.14-rc5 next-20250305]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Wilczynski/dt-bindings-firmware-thead-th1520-Add-support-for-firmware-node/20250303-230224
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250303145901.446791-3-m.wilczynski%40samsung.com
patch subject: [PATCH v1 2/5] firmware: thead: Add AON firmware protocol driver
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20250306/202503060707.a8CwuQbH-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250306/202503060707.a8CwuQbH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503060707.a8CwuQbH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/firmware/thead,th1520-aon.c: In function 'th1520_aon_init':
   drivers/firmware/thead,th1520-aon.c:206:20: error: implicit declaration of function 'kzalloc' [-Werror=implicit-function-declaration]
     206 |         aon_chan = kzalloc(sizeof(*aon_chan), GFP_KERNEL);
         |                    ^~~~~~~
>> drivers/firmware/thead,th1520-aon.c:206:18: warning: assignment to 'struct th1520_aon_chan *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     206 |         aon_chan = kzalloc(sizeof(*aon_chan), GFP_KERNEL);
         |                  ^
   drivers/firmware/thead,th1520-aon.c:219:17: error: implicit declaration of function 'kfree' [-Werror=implicit-function-declaration]
     219 |                 kfree(aon_chan);
         |                 ^~~~~
   cc1: some warnings being treated as errors


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
   219			kfree(aon_chan);
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

