Return-Path: <linux-pm+bounces-39933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD56CDDA52
	for <lists+linux-pm@lfdr.de>; Thu, 25 Dec 2025 11:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62CF03012DF0
	for <lists+linux-pm@lfdr.de>; Thu, 25 Dec 2025 10:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052143126A9;
	Thu, 25 Dec 2025 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1W47Ncn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C56225409;
	Thu, 25 Dec 2025 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766657865; cv=none; b=oiHgnzhloL5m1NwcnecY+LqM+E+R5mkOmtaIGSm3wKO2Ye0Lfb2AuKxx8/0KDbwFyz5ERIKXby8l9vvh0X5tbTlZS2vj0Kh5/nznS+swMqCDi/AsJUVlmvN7l+rwbm3qYtCict1OHEUWWAQrTWtbHtU7WYM3GSda+QoIVcFJx6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766657865; c=relaxed/simple;
	bh=z2zkTqgnaCZ2l0dBJOIwxsTOjEU6LlBHNrA3F5oZGwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJGDyuf/vJc8HjWrl8bfHqPqq8YB3iN2iZyAiEbcJy2VlJApqfE8jwXhIgTo66qRGPfbto2IkrGciK81/6vYE9bB+4G9TsI6/QlyVmTxSdkNze24EkmBxMN0viRdr/6q/8VNYGSVJG2AnokBg4pjcBtFZokwusBpEI0kmn9uMzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1W47Ncn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766657864; x=1798193864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z2zkTqgnaCZ2l0dBJOIwxsTOjEU6LlBHNrA3F5oZGwE=;
  b=e1W47NcnnMTpnKkzGLZ18P9tb/wQ7bIAspbweb9lhxnGkmjy1wpjg2tH
   149kMZCL85Eaoc3AakMOfuRi/6xFpzT//6iKLe7BGTx24xsdGNK4KDEe2
   NT7/63zg7uKBPbqCiL+kVA5UJOx6KjlN+78LEfTNRKpf+28ksYjppmaXL
   V3KyqEc+b+c2GVJcTTJ3ZP4wNQgaXyu6pJFqeVfzm10xk8MUB49txRMTU
   L6BHIa2ZmihKpr5H1MgSf9pQIKauWCIR6R5U+aFn5mlPWMSWiQWC+mws5
   AhheWDRWVcLWFwW973spLB2hmYIV3Z40bh7fklZCDb3uJ5hfjy3jmyV/V
   w==;
X-CSE-ConnectionGUID: +9r7lmHWROK5KfOUlUVTLA==
X-CSE-MsgGUID: bBv3D1F/R8qr+TWipJUgwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="71043619"
X-IronPort-AV: E=Sophos;i="6.21,176,1763452800"; 
   d="scan'208";a="71043619"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2025 02:17:44 -0800
X-CSE-ConnectionGUID: e9oWw/OmSZmybIlP8sqXOQ==
X-CSE-MsgGUID: 6Y9eA6kYTQSsOs36kMHSbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,176,1763452800"; 
   d="scan'208";a="204698249"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 25 Dec 2025 02:17:38 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vYiPJ-000000003yb-0W6B;
	Thu, 25 Dec 2025 10:17:30 +0000
Date: Thu, 25 Dec 2025 18:16:34 +0800
From: kernel test robot <lkp@intel.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Andre Draszik <andre.draszik@linaro.org>,
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v18 01/10] power: reset: reboot-mode: Remove devres based
 allocations
Message-ID: <202512251820.e0ZKwuCc-lkp@intel.com>
References: <20251223-arm-psci-system_reset2-vendor-reboots-v18-1-32fa9e76efc3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223-arm-psci-system_reset2-vendor-reboots-v18-1-32fa9e76efc3@oss.qualcomm.com>

Hi Shivendra,

kernel test robot noticed the following build errors:

[auto build test ERROR on cc3aa43b44bdb43dfbac0fcb51c56594a11338a8]

url:    https://github.com/intel-lab-lkp/linux/commits/Shivendra-Pratap/power-reset-reboot-mode-Remove-devres-based-allocations/20251224-011508
base:   cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
patch link:    https://lore.kernel.org/r/20251223-arm-psci-system_reset2-vendor-reboots-v18-1-32fa9e76efc3%40oss.qualcomm.com
patch subject: [PATCH v18 01/10] power: reset: reboot-mode: Remove devres based allocations
config: powerpc64-randconfig-r072-20251225 (https://download.01.org/0day-ci/archive/20251225/202512251820.e0ZKwuCc-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 4ef602d446057dabf5f61fb221669ecbeda49279)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251225/202512251820.e0ZKwuCc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512251820.e0ZKwuCc-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/power/reset/reboot-mode.c:94:10: error: call to undeclared function 'kzalloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      94 |                 info = kzalloc(sizeof(*info), GFP_KERNEL);
         |                        ^
>> drivers/power/reset/reboot-mode.c:94:8: error: incompatible integer to pointer conversion assigning to 'struct mode_info *' from 'int' [-Wint-conversion]
      94 |                 info = kzalloc(sizeof(*info), GFP_KERNEL);
         |                      ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/power/reset/reboot-mode.c:120:2: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     120 |         kfree(info);
         |         ^
   drivers/power/reset/reboot-mode.c:145:3: error: call to undeclared function 'kfree'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     145 |                 kfree(info);
         |                 ^
   4 errors generated.


vim +/kzalloc +94 drivers/power/reset/reboot-mode.c

    66	
    67	/**
    68	 * reboot_mode_register - register a reboot mode driver
    69	 * @reboot: reboot mode driver
    70	 *
    71	 * Returns: 0 on success or a negative error code on failure.
    72	 */
    73	int reboot_mode_register(struct reboot_mode_driver *reboot)
    74	{
    75		struct mode_info *info;
    76		struct mode_info *next;
    77		struct property *prop;
    78		struct device_node *np = reboot->dev->of_node;
    79		size_t len = strlen(PREFIX);
    80		u32 magic;
    81		int ret;
    82	
    83		INIT_LIST_HEAD(&reboot->head);
    84	
    85		for_each_property_of_node(np, prop) {
    86			if (strncmp(prop->name, PREFIX, len))
    87				continue;
    88	
    89			if (of_property_read_u32(np, prop->name, &magic)) {
    90				pr_err("reboot mode %s without magic number\n", prop->name);
    91				continue;
    92			}
    93	
  > 94			info = kzalloc(sizeof(*info), GFP_KERNEL);
    95			if (!info) {
    96				ret = -ENOMEM;
    97				goto error;
    98			}
    99	
   100			info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
   101			if (!info->mode) {
   102				ret =  -ENOMEM;
   103				goto error;
   104			} else if (info->mode[0] == '\0') {
   105				kfree_const(info->mode);
   106				ret = -EINVAL;
   107				pr_err("invalid mode name(%s): too short!\n", prop->name);
   108				goto error;
   109			}
   110	
   111			list_add_tail(&info->list, &reboot->head);
   112		}
   113	
   114		reboot->reboot_notifier.notifier_call = reboot_mode_notify;
   115		register_reboot_notifier(&reboot->reboot_notifier);
   116	
   117		return 0;
   118	
   119	error:
 > 120		kfree(info);
   121		list_for_each_entry_safe(info, next, &reboot->head, list) {
   122			list_del(&info->list);
   123			kfree_const(info->mode);
   124			kfree(info);
   125		}
   126	
   127		return ret;
   128	}
   129	EXPORT_SYMBOL_GPL(reboot_mode_register);
   130	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

