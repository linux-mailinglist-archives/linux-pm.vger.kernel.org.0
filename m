Return-Path: <linux-pm+bounces-16000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FD79A4A9F
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 02:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EFC71F22D4D
	for <lists+linux-pm@lfdr.de>; Sat, 19 Oct 2024 00:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D07170A0C;
	Sat, 19 Oct 2024 00:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UX7YVdUx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E546166F00;
	Sat, 19 Oct 2024 00:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729297637; cv=none; b=DVIjtW1plu3U54eQ2pdzWTBGHkcIyjWhTzzbZkpSguYKrqm/TZ8B2As2gWilKWrsee9RUC03TYWsHBzI2wL2PCHqEUnwRcHGOlf1eVw7EOmPix4lTAzi0SAciOPGlXzBlN04+R6ka4VRRSEriSG9CIhG8NYrsPNLN4GpEYlTjaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729297637; c=relaxed/simple;
	bh=XpzszTUw/nXjc6n+zFmxRLkcGB/oPankYYv5sQFIh/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o49r6pnSdl27Gz47o4VH89g3/8Xy+CiUYegLCGjTvIaFpZ9KfD33DzZkxiQIKVpA4a4Mi/WmyKS/Q8ZoS6nkqGs0nXcQ27GLrpE82tKGdRrOwvC08FiQohcy4zFtdfqjMgpuqnAVJVBTuJtyvo4JHaL1ITDtakK7e53nss69vgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UX7YVdUx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729297635; x=1760833635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XpzszTUw/nXjc6n+zFmxRLkcGB/oPankYYv5sQFIh/Y=;
  b=UX7YVdUxnzjzxwJ5fZegEWPT1rgn3QUTsNyGecCbs8VdVQWAvr7wiDmS
   FOmt04Ck5/YoRXj0NSt1DRomwLcQEZ3BkPAxIbApiZb2iIdDpq9WMRuGg
   yFBQN2gAzZCordoIShtn9cwoM6i4mRimWvkLD4k86s1s9xLluxyXE0Syt
   FccyI0QriapOCzozFqsaEOnBAE9SpBUsZwWl6/QepZhplhxjZ0okqmJgh
   ek8v10VefBNLyTGltnCrNg5m/GAVzuDJ5HrmQV299XZntVkNAkgCmqYn6
   D6/WvSWFRuc75zMkb5i+v2QHpEV69c/Gj8tg1SL2oU8Jkn7eLiLz2fIF8
   g==;
X-CSE-ConnectionGUID: Wo4GxFC2Rs+IDsNColV4zA==
X-CSE-MsgGUID: rNPjA97xRt+uTf0G1vw8lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="28977087"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="28977087"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 17:27:15 -0700
X-CSE-ConnectionGUID: bccPquIaRFSenCipGZI1Lw==
X-CSE-MsgGUID: ZsMos1PaRsWVxJHIHDYSzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="116470078"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 18 Oct 2024 17:27:13 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1xJG-000OT3-24;
	Sat, 19 Oct 2024 00:27:10 +0000
Date: Sat, 19 Oct 2024 08:26:26 +0800
From: kernel test robot <lkp@intel.com>
To: Jennifer Berringer <jberring@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, Jennifer Berringer <jberring@redhat.com>
Subject: Re: [PATCH 3/3] power: reset: nvmem-reboot-mode: fix write for small
 cells
Message-ID: <202410190829.e98plEvU-lkp@intel.com>
References: <20241017160904.2803663-3-jberring@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017160904.2803663-3-jberring@redhat.com>

Hi Jennifer,

kernel test robot noticed the following build errors:

[auto build test ERROR on 98f7e32f20d28ec452afb208f9cffc08448a2652]

url:    https://github.com/intel-lab-lkp/linux/commits/Jennifer-Berringer/nvmem-core-add-nvmem_cell_write_variable_u32/20241018-001140
base:   98f7e32f20d28ec452afb208f9cffc08448a2652
patch link:    https://lore.kernel.org/r/20241017160904.2803663-3-jberring%40redhat.com
patch subject: [PATCH 3/3] power: reset: nvmem-reboot-mode: fix write for small cells
config: i386-randconfig-015-20241019 (https://download.01.org/0day-ci/archive/20241019/202410190829.e98plEvU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241019/202410190829.e98plEvU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410190829.e98plEvU-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/power/reset/nvmem-reboot-mode.c: In function 'nvmem_reboot_mode_write':
>> drivers/power/reset/nvmem-reboot-mode.c:27:15: error: implicit declaration of function 'nvmem_cell_write_variable_u32'; did you mean 'nvmem_cell_read_variable_le_u32'? [-Werror=implicit-function-declaration]
      27 |         ret = nvmem_cell_write_variable_u32(nvmem_rbm->cell, magic);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               nvmem_cell_read_variable_le_u32
   cc1: some warnings being treated as errors


vim +27 drivers/power/reset/nvmem-reboot-mode.c

    18	
    19	static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
    20					    unsigned int magic)
    21	{
    22		int ret;
    23		struct nvmem_reboot_mode *nvmem_rbm;
    24	
    25		nvmem_rbm = container_of(reboot, struct nvmem_reboot_mode, reboot);
    26	
  > 27		ret = nvmem_cell_write_variable_u32(nvmem_rbm->cell, magic);
    28		if (ret < 0)
    29			dev_err(reboot->dev, "update reboot mode bits failed\n");
    30	
    31		return ret;
    32	}
    33	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

