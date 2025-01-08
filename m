Return-Path: <linux-pm+bounces-20070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66894A05282
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 06:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FE0160808
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 05:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80CA1A01CC;
	Wed,  8 Jan 2025 05:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ns5l8eQD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FA719DFA7;
	Wed,  8 Jan 2025 05:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736312991; cv=none; b=DPf6LdiDvHx5JmdI17FFYG7qcHVJSFHAiFEdesTpbzHBhh2emVgd9lpWUqEtMlJckgBSaAp1THl8YZB7mKyMZn/ZccFeIinSMlzyFTVRR/QxjSleRTtCp+pIW7asRurRgiJT5YiDPgJOk1B9uD7bLpGv/tTiynQTjYJK6jb0v9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736312991; c=relaxed/simple;
	bh=ii0v9G2O/Sgddpd5WwL725dEVh2c4NbCrDvHOB1LtgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axNR7tRO3/QrLaQWNrtb7Jr5PBoDhaooODYDgBeqDoncYbkbUZa0TiLJqQvWz7tIeEREfbdzowHdFiU7f2kagxjzhD19DnQIRXZRexnSTs1aE+vfbv/++2JM/lU0iRDb1bLzX9pH3wMdocIO80vNiUA6hKsL0+GH/FR6iiq/Omg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ns5l8eQD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736312990; x=1767848990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ii0v9G2O/Sgddpd5WwL725dEVh2c4NbCrDvHOB1LtgI=;
  b=ns5l8eQDcpPoL0OSl87NA4dOseJn3fTQpKHkG8kpJxRX3VcUvYYAqpBc
   GLCBeXarc3f/qKJGqXyBxxwAjCjrTywLNSn4osuKcCPaeje9o2WlqQQJl
   iIKBnJ3ixZsWuw1mVfC2F5tERZYBx/5VeDxZTOsD5Hr42O6qMUskMPgxG
   w9UW5zMQPkJq4DcaITFCpw5bUhH08soEhgxVuDBx1Q1H5ZH438GUC0jVr
   x9HsBepQqDkH1raCq+x1LX/7hmCGhG2q2yH3hTuoJoxQAqb/f7iARc5vF
   LNM9WhC2KfK1PyypB1sXT/IF/OU603YSjaXVs+z0o6hIzMcu2ICnxxCN2
   w==;
X-CSE-ConnectionGUID: GZbP1qXdTnCmqc+iGx7oNg==
X-CSE-MsgGUID: G4GOO6dmS222PyYdnjLcqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="40469244"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="40469244"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 21:09:49 -0800
X-CSE-ConnectionGUID: vx9g9AvbQVWLcojtSVYr2Q==
X-CSE-MsgGUID: qyolrQBbSMWp3rcHNGmDXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="103198374"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 07 Jan 2025 21:09:47 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tVOK8-000Fe3-0o;
	Wed, 08 Jan 2025 05:09:44 +0000
Date: Wed, 8 Jan 2025 13:08:56 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, upstream@airoha.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v9 1/2] pmdomain: airoha: Add Airoha CPU PM Domain support
Message-ID: <202501081205.3pBFrmYH-lkp@intel.com>
References: <20250105142645.20128-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250105142645.20128-1-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.13-rc6 next-20250107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/cpufreq-airoha-Add-EN7581-CPUFreq-SMCCC-driver/20250105-223027
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250105142645.20128-1-ansuelsmth%40gmail.com
patch subject: [PATCH v9 1/2] pmdomain: airoha: Add Airoha CPU PM Domain support
config: arm-randconfig-r063-20250108 (https://download.01.org/0day-ci/archive/20250108/202501081205.3pBFrmYH-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250108/202501081205.3pBFrmYH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501081205.3pBFrmYH-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "arm_smccc_1_1_get_conduit" [drivers/pmdomain/mediatek/airoha-cpu-pmdomain.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

