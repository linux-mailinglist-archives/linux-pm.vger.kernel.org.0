Return-Path: <linux-pm+bounces-17979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37C09D68A2
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2024 11:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634BD16131C
	for <lists+linux-pm@lfdr.de>; Sat, 23 Nov 2024 10:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0F818454E;
	Sat, 23 Nov 2024 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mC4DLkYA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A077E81AC8;
	Sat, 23 Nov 2024 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732358258; cv=none; b=oI88bdMzxyL9aTdzDtKbAyCDYri1Rp1kjOyVW96vU1jrTkc6YFKx+iVTFlCwIfC7BpbALTYnSafH5JIwua08QwqfNVuNpcUYeN7fZX6hAeRJFuXQyqvv3JmXVxfCVARlubVw9hpaofQvc12Br8RoPq9wR3moWKnFcr807UaZ/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732358258; c=relaxed/simple;
	bh=PzMZ72Z71bHownk54H4oqMOjYw2DS3p4x+O65zcoeFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5BTB1wNhZjNdfxmGV0LFydpJRXoFfERi9GikPGwrD4oY6kshNSZPp6qQvTQGh15Mzbxbk2TCMYe/kAGUSiWSmidfC2VbhBOdGkuuRvGHOl6bQIRV7VKvwVcsGAGMpWKmJ5CRg1PrfLNHTQbnnQ1Yblte7rtZL9EMwgkX6M1ijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mC4DLkYA; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732358257; x=1763894257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PzMZ72Z71bHownk54H4oqMOjYw2DS3p4x+O65zcoeFo=;
  b=mC4DLkYAE0r+owBspmz+IsUElVuyJhWKd3RXVX6Hqk0mNdy0MSzG6uPW
   pX/YgpABc3h7ZDnVkhEcwSVi4WH3yzLEJa3jL2s8ZOQMJbT0kcyipUCb7
   jCGgEIvaO4GD3XTYOo/YIfkj9Ja8O1fd1n7Nb6ruUDvGzGIQAyd3nBdFq
   dSyfys5LDEBBod5Yv7RPtpGkkeNl/5/IUzDZWVp+qJzCdWeTISaX9Zr78
   rf/N79AFGzcHpZhcAxbfpRDdxVoWxnnr8uYni+PF8Iw5+iyQiuUzFwykO
   B7Hk0SXLSi/09LcEESoEdt4V7bgBnpCyxkJhHwT5h6l+NtqBUqO06Hsfd
   A==;
X-CSE-ConnectionGUID: 39igVUW/SpKrzasaDAB3mA==
X-CSE-MsgGUID: EsLtZ2RKRvqdBpFjbK2CCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43912616"
X-IronPort-AV: E=Sophos;i="6.12,178,1728975600"; 
   d="scan'208";a="43912616"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2024 02:37:36 -0800
X-CSE-ConnectionGUID: +RD5Yp9eSiGJxq8Sp+pejQ==
X-CSE-MsgGUID: 9h8GyPJtSF+ajVYA9ZqASA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,178,1728975600"; 
   d="scan'208";a="95579719"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 23 Nov 2024 02:37:33 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEnW7-0004Zb-17;
	Sat, 23 Nov 2024 10:37:31 +0000
Date: Sat, 23 Nov 2024 18:36:35 +0800
From: kernel test robot <lkp@intel.com>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Odelu Kukatla <quic_okukatla@quicinc.com>,
	Mike Tipton <quic_mdtipton@quicinc.com>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] interconnect: qcom: sdx75: Drop QP0 related
 interconnect and BCM nodes
Message-ID: <202411232022.F33FHrZo-lkp@intel.com>
References: <20241121172737.255-3-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121172737.255-3-quic_rlaggysh@quicinc.com>

Hi Raviteja,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.12 next-20241122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Raviteja-Laggyshetty/dt-bindings-interconnect-qcom-drop-QPIC_CORE-IDs/20241122-013857
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20241121172737.255-3-quic_rlaggysh%40quicinc.com
patch subject: [PATCH 2/2] interconnect: qcom: sdx75: Drop QP0 related interconnect and BCM nodes
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20241123/202411232022.F33FHrZo-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241123/202411232022.F33FHrZo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411232022.F33FHrZo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/interconnect/qcom/sdx75.c:878:10: error: 'bcm_qp0' undeclared here (not in a function); did you mean 'bcm_qup0'?
     878 |         &bcm_qp0,
         |          ^~~~~~~
         |          bcm_qup0

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +878 drivers/interconnect/qcom/sdx75.c

3642b4e5cbfe48 Rohit Agarwal 2023-09-13  876  
3642b4e5cbfe48 Rohit Agarwal 2023-09-13  877  static struct qcom_icc_bcm * const clk_virt_bcms[] = {
3642b4e5cbfe48 Rohit Agarwal 2023-09-13 @878  	&bcm_qp0,
3642b4e5cbfe48 Rohit Agarwal 2023-09-13  879  	&bcm_qup0,
3642b4e5cbfe48 Rohit Agarwal 2023-09-13  880  };
3642b4e5cbfe48 Rohit Agarwal 2023-09-13  881  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

