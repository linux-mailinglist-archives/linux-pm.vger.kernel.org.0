Return-Path: <linux-pm+bounces-35466-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E35BA3E2D
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 15:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DD567B353A
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 13:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880C72EF673;
	Fri, 26 Sep 2025 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlqz/49X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8A82DC346;
	Fri, 26 Sep 2025 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758893208; cv=none; b=D6U4bMKOF59K11f+PyJxLnzjWHVERn2VXWMsNVEZizxA5rrREQ1RjTP2QKTgKcFyc/1yH/WFHy6eo3BES+s1HeKlkhYnfaIHsB2QtQ+1R7y5xtUIuqdklCd8SwH3m+qn/95L3a3M6Tm5TLI7IJIib5psxcbKSI0QRYZtIUk/4JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758893208; c=relaxed/simple;
	bh=tt8j4f67Myq2x91/cEcHImKhtQzK3hMmMD/sIcbXrSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5PHxKg9z+9ZFc6Iq3jFRArqJz1O+iztB8/KXyETukLIWoWhTGoRxRNxeKYbVuyFNgs9uODCS+/vIaZBz2hWn0VHE+O8r/iviyi0oOJ40oyeRnPj4ls5xPd35MMdCESnWg1GikpHUE2ihdvQOrQwW8K3mw2Rp6fB6Iq7XDXc21g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mlqz/49X; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758893207; x=1790429207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tt8j4f67Myq2x91/cEcHImKhtQzK3hMmMD/sIcbXrSI=;
  b=mlqz/49Xws/kSlVR6mmKcYj2FWjmAPxW/HiK8HeaFYVmSXtqGUmN2h0C
   KHywxcQ4+Lp04jWA/eeW06Ve9lCKT54V0T9O0sIPaxAP6fljfJUuZbO6A
   PD54ksCVx48yOb5f+cUtjtCR9NnLaW8LbIYjxUmj3YJALJecCxjzSbXgZ
   FLfxrtPnJyMPLxhrg0RzYk+kWE9So9d9HI627hPcyrLUfigV0IKLQyxp+
   zlC5QRSXC2v3SH/KNKRNdf3JKkW5bkuUZuK3D8wDXUHcoQQabcDWn3zCJ
   odQRocxBFVvyiFhLetXuPBdpO01b67B9LLH699WEVR9bRwjz5q8h35efG
   w==;
X-CSE-ConnectionGUID: QEDmuES2Qa6xKrYL2STbYw==
X-CSE-MsgGUID: atCguUkdQ/Snd0P9w5W39g==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="72324276"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="72324276"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 06:26:46 -0700
X-CSE-ConnectionGUID: KyBoOnMDT3WLFyHiLckXHQ==
X-CSE-MsgGUID: gaUzxMHbRR2LRreEpd9+TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="181619627"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 26 Sep 2025 06:26:41 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v28T9-0006GP-0Q;
	Fri, 26 Sep 2025 13:26:39 +0000
Date: Fri, 26 Sep 2025 21:26:01 +0800
From: kernel test robot <lkp@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	ulf.hansson@linaro.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, nfraprado@collabora.com,
	fshao@chromium.org, y.oudjana@protonmail.com, wenst@chromium.org,
	mandyjh.liu@mediatek.com, mbrugger@suse.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 3/5] pmdomain: mediatek: Add support for secure HWCCF
 infra power on
Message-ID: <202509262155.Ux4J6K4D-lkp@intel.com>
References: <20250925143122.39796-4-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925143122.39796-4-angelogioacchino.delregno@collabora.com>

Hi AngeloGioacchino,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20250924]
[cannot apply to robh/for-next linus/master v6.17-rc7 v6.17-rc6 v6.17-rc5 v6.17-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/dt-bindings-power-Add-support-for-MT8196-power-controllers/20250925-223530
base:   next-20250924
patch link:    https://lore.kernel.org/r/20250925143122.39796-4-angelogioacchino.delregno%40collabora.com
patch subject: [PATCH v2 3/5] pmdomain: mediatek: Add support for secure HWCCF infra power on
config: i386-buildonly-randconfig-001-20250926 (https://download.01.org/0day-ci/archive/20250926/202509262155.Ux4J6K4D-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250926/202509262155.Ux4J6K4D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509262155.Ux4J6K4D-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pmdomain/mediatek/mtk-pm-domains.c:124:23: error: variable has incomplete type 'struct arm_smccc_res'
     124 |         struct arm_smccc_res res;
         |                              ^
   drivers/pmdomain/mediatek/mtk-pm-domains.c:124:9: note: forward declaration of 'struct arm_smccc_res'
     124 |         struct arm_smccc_res res;
         |                ^
>> drivers/pmdomain/mediatek/mtk-pm-domains.c:127:2: error: call to undeclared function 'arm_smccc_smc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     127 |         arm_smccc_smc(MTK_SIP_KERNEL_HWCCF_CONTROL, cmd, 0, 0, 0, 0, 0, 0, &res);
         |         ^
>> drivers/pmdomain/mediatek/mtk-pm-domains.c:127:16: error: call to undeclared function 'ARM_SMCCC_CALL_VAL'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     127 |         arm_smccc_smc(MTK_SIP_KERNEL_HWCCF_CONTROL, cmd, 0, 0, 0, 0, 0, 0, &res);
         |                       ^
   drivers/pmdomain/mediatek/mtk-pm-domains.c:55:38: note: expanded from macro 'MTK_SIP_KERNEL_HWCCF_CONTROL'
      55 | #define MTK_SIP_KERNEL_HWCCF_CONTROL    MTK_SIP_SMC_CMD(0x540)
         |                                         ^
   include/linux/soc/mediatek/mtk_sip_svc.h:22:2: note: expanded from macro 'MTK_SIP_SMC_CMD'
      22 |         ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, MTK_SIP_SMC_CONVENTION, \
         |         ^
>> drivers/pmdomain/mediatek/mtk-pm-domains.c:127:16: error: use of undeclared identifier 'ARM_SMCCC_FAST_CALL'
   drivers/pmdomain/mediatek/mtk-pm-domains.c:55:38: note: expanded from macro 'MTK_SIP_KERNEL_HWCCF_CONTROL'
      55 | #define MTK_SIP_KERNEL_HWCCF_CONTROL    MTK_SIP_SMC_CMD(0x540)
         |                                         ^
   include/linux/soc/mediatek/mtk_sip_svc.h:22:21: note: expanded from macro 'MTK_SIP_SMC_CMD'
      22 |         ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, MTK_SIP_SMC_CONVENTION, \
         |                            ^
>> drivers/pmdomain/mediatek/mtk-pm-domains.c:127:16: error: use of undeclared identifier 'ARM_SMCCC_SMC_32'
   drivers/pmdomain/mediatek/mtk-pm-domains.c:55:38: note: expanded from macro 'MTK_SIP_KERNEL_HWCCF_CONTROL'
      55 | #define MTK_SIP_KERNEL_HWCCF_CONTROL    MTK_SIP_SMC_CMD(0x540)
         |                                         ^
   include/linux/soc/mediatek/mtk_sip_svc.h:22:42: note: expanded from macro 'MTK_SIP_SMC_CMD'
      22 |         ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, MTK_SIP_SMC_CONVENTION, \
         |                                                 ^
   include/linux/soc/mediatek/mtk_sip_svc.h:18:41: note: expanded from macro 'MTK_SIP_SMC_CONVENTION'
      18 | #define MTK_SIP_SMC_CONVENTION          ARM_SMCCC_SMC_32
         |                                         ^
>> drivers/pmdomain/mediatek/mtk-pm-domains.c:127:16: error: use of undeclared identifier 'ARM_SMCCC_OWNER_SIP'
   drivers/pmdomain/mediatek/mtk-pm-domains.c:55:38: note: expanded from macro 'MTK_SIP_KERNEL_HWCCF_CONTROL'
      55 | #define MTK_SIP_KERNEL_HWCCF_CONTROL    MTK_SIP_SMC_CMD(0x540)
         |                                         ^
   include/linux/soc/mediatek/mtk_sip_svc.h:23:7: note: expanded from macro 'MTK_SIP_SMC_CMD'
      23 |                            ARM_SMCCC_OWNER_SIP, fn_id)
         |                            ^
   6 errors generated.


vim +124 drivers/pmdomain/mediatek/mtk-pm-domains.c

    54	
  > 55	#define MTK_SIP_KERNEL_HWCCF_CONTROL	MTK_SIP_SMC_CMD(0x540)
    56	
    57	struct scpsys_domain {
    58		struct generic_pm_domain genpd;
    59		const struct scpsys_domain_data *data;
    60		const struct scpsys_hwv_domain_data *hwv_data;
    61		struct scpsys *scpsys;
    62		int num_clks;
    63		struct clk_bulk_data *clks;
    64		int num_subsys_clks;
    65		struct clk_bulk_data *subsys_clks;
    66		struct regulator *supply;
    67	};
    68	
    69	struct scpsys {
    70		struct device *dev;
    71		struct regmap *base;
    72		const struct scpsys_soc_data *soc_data;
    73		u8 bus_prot_index[BUS_PROT_BLOCK_COUNT];
    74		struct regmap **bus_prot;
    75		struct genpd_onecell_data pd_data;
    76		struct generic_pm_domain *domains[];
    77	};
    78	
    79	#define to_scpsys_domain(gpd) container_of(gpd, struct scpsys_domain, genpd)
    80	
    81	static bool scpsys_domain_is_on(struct scpsys_domain *pd)
    82	{
    83		struct scpsys *scpsys = pd->scpsys;
    84		u32 status, status2;
    85	
    86		regmap_read(scpsys->base, pd->data->pwr_sta_offs, &status);
    87		status &= pd->data->sta_mask;
    88	
    89		regmap_read(scpsys->base, pd->data->pwr_sta2nd_offs, &status2);
    90		status2 &= pd->data->sta_mask;
    91	
    92		/* A domain is on when both status bits are set. */
    93		return status && status2;
    94	}
    95	
    96	static bool scpsys_hwv_domain_is_disable_done(struct scpsys_domain *pd)
    97	{
    98		const struct scpsys_hwv_domain_data *hwv = pd->hwv_data;
    99		u32 regs[2] = { hwv->done, hwv->clr_sta };
   100		u32 val[2];
   101		u32 mask = BIT(hwv->setclr_bit);
   102	
   103		regmap_multi_reg_read(pd->scpsys->base, regs, val, 2);
   104	
   105		/* Disable is done when the bit is set in DONE, cleared in CLR_STA */
   106		return (val[0] & mask) && !(val[1] & mask);
   107	}
   108	
   109	static bool scpsys_hwv_domain_is_enable_done(struct scpsys_domain *pd)
   110	{
   111		const struct scpsys_hwv_domain_data *hwv = pd->hwv_data;
   112		u32 regs[3] = { hwv->done, hwv->en, hwv->set_sta };
   113		u32 val[3];
   114		u32 mask = BIT(hwv->setclr_bit);
   115	
   116		regmap_multi_reg_read(pd->scpsys->base, regs, val, 3);
   117	
   118		/* Enable is done when the bit is set in DONE and EN, cleared in SET_STA */
   119		return (val[0] & mask) && (val[1] & mask) && !(val[2] & mask);
   120	}
   121	
   122	static int scpsys_sec_infra_power_on(bool on)
   123	{
 > 124		struct arm_smccc_res res;
   125		unsigned long cmd = on ? 1 : 0;
   126	
 > 127		arm_smccc_smc(MTK_SIP_KERNEL_HWCCF_CONTROL, cmd, 0, 0, 0, 0, 0, 0, &res);
   128		return res.a0;
   129	}
   130	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

