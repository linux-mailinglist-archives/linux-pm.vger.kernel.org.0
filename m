Return-Path: <linux-pm+bounces-15423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F38699761C
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 22:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6697284728
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 20:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD1B1940A2;
	Wed,  9 Oct 2024 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KMy6GLe1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F52175D5F;
	Wed,  9 Oct 2024 20:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728504087; cv=none; b=Hd2TYdEvUQfojyLOxKCz91y03LTuh6dAL9FtSWToaPlba6qqnRVmhyICEwRSbY+z5PhLsoGU5AzH8amnUjjB0X+iCsuWRO9TZUTV+0zBtz71hEuqTHjX5LMuoc502rKfpmRgv8N0diKmQyBu6DigoQ8whgDRSL1eiiMf9g+gCE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728504087; c=relaxed/simple;
	bh=zFdUQ+MRpLUDqfQc+JTntU/+06D/KiG/nS/BisdDa08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcYL9UtVfHeht/d+s81gRNnu1ASAqhewS7IQFMd0XJ7o43AABDifGki84saRQfTU9wbqfKw6PvYHQhG9lZf00IS3bdXjLhM4yTqbCw5WOfqZMMODol78N3RHtk0jcCy6XB4OBlqO6VPN+oQvjCjkCh0J0dsbp9x5MOO4fZlpZAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KMy6GLe1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728504085; x=1760040085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zFdUQ+MRpLUDqfQc+JTntU/+06D/KiG/nS/BisdDa08=;
  b=KMy6GLe1+gIoSIJGqPxcUPvt+WuG2R3hGccpasf9tdgvd5XIVWejVcMw
   IZuffw1UUCrNfRgyiSkI/E0Hxeht/c2iY0KhtqDeVIK9/uNQftEVYCIAq
   fCqIx7F7ZkLf0eqIn1OhkOl0cPBROz5Yf/5gVivgtHDTnQsPZ8HizGnvM
   /1EgqTExbhRQTkRcKeOuvPC1dCiO931RW/B67j+l3s81HJ8OcILYbZdtb
   BkdBgbwhGapUl9PxYMluv3G7qS1XcJ7AA6ue6Rp9m8NGDsIMkQGDDQGzJ
   cUKmF2/PjgyAo0GwwNHy1SzDyIgmMkjfYxaGUvsGljg6vP8LoDm1ymlB6
   w==;
X-CSE-ConnectionGUID: fBSSH2L0T0SXmqdfJyyXjw==
X-CSE-MsgGUID: BPuUqIG0StCi49gsSR+dwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="45304849"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="45304849"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 13:01:24 -0700
X-CSE-ConnectionGUID: iACf1EpnQ+m0h4w8o7hFeA==
X-CSE-MsgGUID: FanvvHS4RrKCbi65y4S7Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="81163288"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 09 Oct 2024 13:01:19 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sycs0-0009kn-2F;
	Wed, 09 Oct 2024 20:01:16 +0000
Date: Thu, 10 Oct 2024 04:00:32 +0800
From: kernel test robot <lkp@intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>, Rob Herring <robh+dt@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: oe-kbuild-all@lists.linux.dev,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
	linux-scsi@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3 5/5] scsi: ufs: rockchip: initial support for UFS
Message-ID: <202410100321.D89hHCPV-lkp@intel.com>
References: <1728368130-37213-6-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728368130-37213-6-git-send-email-shawn.lin@rock-chips.com>

Hi Shawn,

kernel test robot noticed the following build errors:

[auto build test ERROR on jejb-scsi/for-next]
[also build test ERROR on mkp-scsi/for-next robh/for-next linus/master v6.12-rc2 next-20241009]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Lin/scsi-ufs-core-Add-UFSHCI_QUIRK_DME_RESET_ENABLE_AFTER_HCE/20241009-042350
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
patch link:    https://lore.kernel.org/r/1728368130-37213-6-git-send-email-shawn.lin%40rock-chips.com
patch subject: [PATCH v3 5/5] scsi: ufs: rockchip: initial support for UFS
config: csky-randconfig-r073-20241010 (https://download.01.org/0day-ci/archive/20241010/202410100321.D89hHCPV-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241010/202410100321.D89hHCPV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410100321.D89hHCPV-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/ufs/host/ufs-rockchip.c: In function 'ufs_rockchip_runtime_suspend':
>> drivers/ufs/host/ufs-rockchip.c:293:16: error: implicit declaration of function 'ufshcd_runtime_suspend'; did you mean 'pm_runtime_suspend'? [-Wimplicit-function-declaration]
     293 |         return ufshcd_runtime_suspend(dev);
         |                ^~~~~~~~~~~~~~~~~~~~~~
         |                pm_runtime_suspend
   drivers/ufs/host/ufs-rockchip.c: In function 'ufs_rockchip_runtime_resume':
>> drivers/ufs/host/ufs-rockchip.c:312:16: error: implicit declaration of function 'ufshcd_runtime_resume'; did you mean 'pm_runtime_resume'? [-Wimplicit-function-declaration]
     312 |         return ufshcd_runtime_resume(dev);
         |                ^~~~~~~~~~~~~~~~~~~~~
         |                pm_runtime_resume
   drivers/ufs/host/ufs-rockchip.c: In function 'ufs_rockchip_system_suspend':
>> drivers/ufs/host/ufs-rockchip.c:324:16: error: implicit declaration of function 'ufshcd_system_suspend'; did you mean 'ufs_rockchip_system_suspend'? [-Wimplicit-function-declaration]
     324 |         return ufshcd_system_suspend(dev);
         |                ^~~~~~~~~~~~~~~~~~~~~
         |                ufs_rockchip_system_suspend
   drivers/ufs/host/ufs-rockchip.c: At top level:
>> drivers/ufs/host/ufs-rockchip.c:315:12: warning: 'ufs_rockchip_system_suspend' defined but not used [-Wunused-function]
     315 | static int ufs_rockchip_system_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/ufs/host/ufs-rockchip.c:296:12: warning: 'ufs_rockchip_runtime_resume' defined but not used [-Wunused-function]
     296 | static int ufs_rockchip_runtime_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/ufs/host/ufs-rockchip.c:275:12: warning: 'ufs_rockchip_runtime_suspend' defined but not used [-Wunused-function]
     275 | static int ufs_rockchip_runtime_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +293 drivers/ufs/host/ufs-rockchip.c

   274	
 > 275	static int ufs_rockchip_runtime_suspend(struct device *dev)
   276	{
   277		struct ufs_hba *hba = dev_get_drvdata(dev);
   278		struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
   279		struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
   280	
   281		clk_disable_unprepare(host->ref_out_clk);
   282	
   283		/*
   284		 * Shouldn't power down if rpm_lvl is less than level 5.
   285		 * This flag will be passed down to platform power-domain driver
   286		 * which has the final decision.
   287		 */
   288		if (hba->rpm_lvl < UFS_PM_LVL_5)
   289			genpd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
   290		else
   291			genpd->flags &= ~GENPD_FLAG_RPM_ALWAYS_ON;
   292	
 > 293		return ufshcd_runtime_suspend(dev);
   294	}
   295	
 > 296	static int ufs_rockchip_runtime_resume(struct device *dev)
   297	{
   298		struct ufs_hba *hba = dev_get_drvdata(dev);
   299		struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
   300		int err;
   301	
   302		err = clk_prepare_enable(host->ref_out_clk);
   303		if (err) {
   304			dev_err(hba->dev, "failed to enable ref out clock %d\n", err);
   305			return err;
   306		}
   307	
   308		reset_control_assert(host->rst);
   309		usleep_range(1, 2);
   310		reset_control_deassert(host->rst);
   311	
 > 312		return ufshcd_runtime_resume(dev);
   313	}
   314	
 > 315	static int ufs_rockchip_system_suspend(struct device *dev)
   316	{
   317		struct ufs_hba *hba = dev_get_drvdata(dev);
   318		struct ufs_rockchip_host *host = ufshcd_get_variant(hba);
   319	
   320		/* Pass down desired spm_lvl to Firmware */
   321		arm_smccc_smc(ROCKCHIP_SIP_SUSPEND_MODE, ROCKCHIP_SLEEP_PD_CONFIG,
   322				host->pd_id, hba->spm_lvl < 5 ? 1 : 0, 0, 0, 0, 0, NULL);
   323	
 > 324		return ufshcd_system_suspend(dev);
   325	}
   326	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

