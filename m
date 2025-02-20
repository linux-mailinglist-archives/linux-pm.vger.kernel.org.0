Return-Path: <linux-pm+bounces-22528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5899DA3D11C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 07:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493C61888B61
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 06:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2F71BE86E;
	Thu, 20 Feb 2025 06:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fg0WmP3p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F6E190072
	for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 06:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740031505; cv=none; b=f9dLMRuOKM/DI/7zZpZzbUFQ1g+T7cJGJi4iahzLNbFA9r5gKwIVKVVQzkz9BsQMFboZIMVYR8CZE4NlaVx8ZfprZwHl6zl4LZ1u/g1KLWHQC/uRRHB62nQ7yFr0aXQYYYR02t5tnJlWw8+F8SL4ZP3budqIlm0tQoppJz3yHGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740031505; c=relaxed/simple;
	bh=LEMI46MYGP6Mj44o8JnfUs/f51k6JJbhxElJkechiqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Np8J58mbIgcv735lUspW4D6S+/sFdAxE2w0PBlxbSP4oRI8xVkogF6Znn0MzGTds9NhPT5ewjftAcoMMyx5afhe6YQFeSPqNX1GebRTqhKCbkwpT95eduAaALgFEtKIy/q9OQVz9bSc28/eUyrvt1+e0N+06Q+8JaNpx+hDpVnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fg0WmP3p; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740031502; x=1771567502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LEMI46MYGP6Mj44o8JnfUs/f51k6JJbhxElJkechiqY=;
  b=Fg0WmP3p8eBC56Sax9Xx0UTpKOdJkJ7SXtznOdnFesQVWYjUF7+yo4ZG
   NFO3fdW816Oun2cZSAduVhepf8fRySvdgaQHMRv27Mz3S2Kl1lThWSLzR
   L/wkBs9f2aPmArwoTPelrn/TRCqbxl/DKxjCn7iz1cAr5xFFzHgLG94tf
   5UwXM2zLdJcQAAtyYsaolBZu92ecdr/aQpkIbqVyOFzI/stAorDhtScvb
   4F0u5R7YL1W1RJ1GQavxkNMLmN31iBsoLIYxYxNXHWjUHc2sy76lGP/le
   r4PXS5LQWFI9lmk1mGQoEZgFqUDa8AXiyuEZufG8sTctc+IKZ77wvBQb9
   w==;
X-CSE-ConnectionGUID: 2aFKfWuIRmWPD6PHlOFf1Q==
X-CSE-MsgGUID: DV2xrS+/St2rvkJiygLSng==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="52204138"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="52204138"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 22:05:01 -0800
X-CSE-ConnectionGUID: g8GBfc0VRW+MBI47bJprLQ==
X-CSE-MsgGUID: NNip9r77T1e9k0x4lesnfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="114924865"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 19 Feb 2025 22:04:59 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkzg8-0003ub-2u;
	Thu, 20 Feb 2025 06:04:56 +0000
Date: Thu, 20 Feb 2025 14:04:30 +0800
From: kernel test robot <lkp@intel.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] pmdomain: rockchip: Check if smcc could be handled by TA
Message-ID: <202502201601.rQYwZmA8-lkp@intel.com>
References: <1739926689-151827-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1739926689-151827-1-git-send-email-shawn.lin@rock-chips.com>

Hi Shawn,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250218]
[cannot apply to v6.14-rc3 v6.14-rc2 v6.14-rc1 linus/master v6.14-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Lin/pmdomain-rockchip-Check-if-smcc-could-be-handled-by-TA/20250219-122924
base:   next-20250218
patch link:    https://lore.kernel.org/r/1739926689-151827-1-git-send-email-shawn.lin%40rock-chips.com
patch subject: [PATCH] pmdomain: rockchip: Check if smcc could be handled by TA
config: i386-buildonly-randconfig-001-20250220 (https://download.01.org/0day-ci/archive/20250220/202502201601.rQYwZmA8-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250220/202502201601.rQYwZmA8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502201601.rQYwZmA8-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/pmdomain/rockchip/pm-domains.o: in function `rockchip_do_pmu_set_power_domain':
>> drivers/pmdomain/rockchip/pm-domains.c:575: undefined reference to `arm_smccc_1_1_get_conduit'


vim +575 drivers/pmdomain/rockchip/pm-domains.c

   537	
   538	static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *pd,
   539						     bool on)
   540	{
   541		struct rockchip_pmu *pmu = pd->pmu;
   542		struct generic_pm_domain *genpd = &pd->genpd;
   543		u32 pd_pwr_offset = pd->info->pwr_offset;
   544		bool is_on, is_mem_on = false;
   545		struct arm_smccc_res res;
   546	
   547		if (pd->info->pwr_mask == 0)
   548			return;
   549	
   550		if (on && pd->info->mem_status_mask)
   551			is_mem_on = rockchip_pmu_domain_is_mem_on(pd);
   552	
   553		if (pd->info->pwr_w_mask)
   554			regmap_write(pmu->regmap, pmu->info->pwr_offset + pd_pwr_offset,
   555				     on ? pd->info->pwr_w_mask :
   556				     (pd->info->pwr_mask | pd->info->pwr_w_mask));
   557		else
   558			regmap_update_bits(pmu->regmap, pmu->info->pwr_offset + pd_pwr_offset,
   559					   pd->info->pwr_mask, on ? 0 : -1U);
   560	
   561		wmb();
   562	
   563		if (is_mem_on && rockchip_pmu_domain_mem_reset(pd))
   564			return;
   565	
   566		if (readx_poll_timeout_atomic(rockchip_pmu_domain_is_on, pd, is_on,
   567					      is_on == on, 0, 10000)) {
   568			dev_err(pmu->dev,
   569				"failed to set domain '%s', val=%d\n",
   570				genpd->name, is_on);
   571			return;
   572		}
   573	
   574		/* Inform firmware to keep this pd on or off */
 > 575		if (arm_smccc_1_1_get_conduit() != SMCCC_CONDUIT_NONE)
   576			arm_smccc_smc(ROCKCHIP_SIP_SUSPEND_MODE, ROCKCHIP_SLEEP_PD_CONFIG,
   577					pmu->info->pwr_offset + pd_pwr_offset,
   578					pd->info->pwr_mask, on, 0, 0, 0, &res);
   579	}
   580	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

