Return-Path: <linux-pm+bounces-11065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB0C93035D
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jul 2024 04:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD92B1F226D3
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jul 2024 02:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B29A175BF;
	Sat, 13 Jul 2024 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GMA9YB6w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A61F14012;
	Sat, 13 Jul 2024 02:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720838586; cv=none; b=Iqljc9vxBVTr/8ES/6xJCSlPktjFVvRB7mkiZdu8gm136H+/KA3CJ7222OyQxe5TWe9aICGYukXdchOlXqVvMbjtpFT+gXlplF3+/QV+zQDT+wrZb1lljPYohcWbUIYU6f0YvZcigHHiSmIouxfK99oBtUYKdO/FjRfckBuu7Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720838586; c=relaxed/simple;
	bh=c0cx8eCSqK5HZVrMPn+doc9P2P0lifDncReHUUcAH3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FF4sVGMIbDuT5RihtXZc0QuK9S6/DESWmpi9kkfo65TqJ9W6tpAW5Yd4LaiC883c/eO5rPB8XA1ixu6fsbb27TQrYzZy3OqqY+DgA1OBx5H3MF59oUYEnVVuC9aVk+z4bi4ATHKbeAVklxZP/v3x5acjn/3V0GbYF15eIqwq56o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GMA9YB6w; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720838584; x=1752374584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c0cx8eCSqK5HZVrMPn+doc9P2P0lifDncReHUUcAH3k=;
  b=GMA9YB6wVHdJfVeBxcTr9cc3ROHk1beXrHl/XLfsv7PEJaRjRfwryICb
   cYUoSnGH1M95qHkGqLh37U2MjVlOTatn1Xz6yl7QI6f9S2gjI20Y4P9at
   YFXB+1+wgOLsMya+v47xcnis4nJJMRjD1z0ErmcdLa+EE8IjbKPHpU3EH
   kHW9qxqSWNI3ypkFQEniXDQ6G9W+5hA1NbIkYVl7+Trps6pMb5aiaygiz
   YwbHxmGprlm0wzxlrAy0L8KW2P1a7pIn3jWMq3s+8JN5guI/BkbNeEJYs
   ia4mMF3oLgkLWOQY/FSYw+xh3YkYt07fQQU3/LJmoOFQBkVljpEnZA5FK
   g==;
X-CSE-ConnectionGUID: e+rVr8cMSEiMRpiPB5IXtA==
X-CSE-MsgGUID: Sn28/8b8STagTDKTErIknA==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="22165437"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="22165437"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 19:43:03 -0700
X-CSE-ConnectionGUID: oLHqdyb5T2yapw+C1VEJmQ==
X-CSE-MsgGUID: tWfou8M1SO2MrgcJfikAOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="72300665"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 Jul 2024 19:43:00 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSSiu-000bZy-2Q;
	Sat, 13 Jul 2024 02:42:56 +0000
Date: Sat, 13 Jul 2024 10:42:02 +0800
From: kernel test robot <lkp@intel.com>
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-media@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] PM: domains: add device managed version of
 dev_pm_domain_attach|detach_list()
Message-ID: <202407131034.zV21FEsV-lkp@intel.com>
References: <1720763312-13018-2-git-send-email-quic_dikshita@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1720763312-13018-2-git-send-email-quic_dikshita@quicinc.com>

Hi Dikshita,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.10-rc7 next-20240712]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dikshita-Agarwal/PM-domains-add-device-managed-version-of-dev_pm_domain_attach-detach_list/20240712-135151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/1720763312-13018-2-git-send-email-quic_dikshita%40quicinc.com
patch subject: [PATCH 1/2] PM: domains: add device managed version of dev_pm_domain_attach|detach_list()
config: x86_64-buildonly-randconfig-001-20240713 (https://download.01.org/0day-ci/archive/20240713/202407131034.zV21FEsV-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240713/202407131034.zV21FEsV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407131034.zV21FEsV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/base/power/common.c:288: warning: Function parameter or struct member '_list' not described in 'devm_pm_domain_detach_list'
>> drivers/base/power/common.c:288: warning: expecting prototype for dev_pm_domain_detach_list(). Prototype was for devm_pm_domain_detach_list() instead
>> drivers/base/power/common.c:307: warning: Function parameter or struct member 'dev' not described in 'devm_pm_domain_attach_list'
>> drivers/base/power/common.c:307: warning: Function parameter or struct member 'data' not described in 'devm_pm_domain_attach_list'
>> drivers/base/power/common.c:307: warning: Function parameter or struct member 'list' not described in 'devm_pm_domain_attach_list'


vim +288 drivers/base/power/common.c

   278	
   279	/**
   280	 * dev_pm_domain_detach_list - devres-enabled version of dev_pm_domain_detach_list.
   281	 * @list: The list of PM domains to detach.
   282	 *
   283	 * This function reverse the actions from devm_pm_domain_attach_list().
   284	 * it will be invoked during the remove phase from drivers implicitly if driver
   285	 * uses devm_pm_domain_attach_list() to attach the PM domains.
   286	 */
   287	void devm_pm_domain_detach_list(void *_list)
 > 288	{
   289		struct dev_pm_domain_list *list = _list;
   290	
   291		dev_pm_domain_detach_list(list);
   292	}
   293	EXPORT_SYMBOL_GPL(devm_pm_domain_detach_list);
   294	
   295	/**
   296	 * devm_pm_domain_attach_list - devres-enabled version of dev_pm_domain_attach_list
   297	 *
   298	 * NOTE: this will also handle calling devm_pm_domain_detach_list() for
   299	 * you during remove phase.
   300	 *
   301	 * Returns the number of attached PM domains or a negative error code in case of
   302	 * a failure.
   303	 */
   304	int devm_pm_domain_attach_list(struct device *dev,
   305				       const struct dev_pm_domain_attach_data *data,
   306				       struct dev_pm_domain_list **list)
 > 307	{
   308		int ret, num_pds = 0;
   309	
   310		num_pds = dev_pm_domain_attach_list(dev, data, list);
   311	
   312		ret = devm_add_action_or_reset(dev, devm_pm_domain_detach_list, (void *)list);
   313		if (ret)
   314			return ret;
   315	
   316		return num_pds;
   317	}
   318	EXPORT_SYMBOL_GPL(devm_pm_domain_attach_list);
   319	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

