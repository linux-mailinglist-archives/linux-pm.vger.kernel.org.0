Return-Path: <linux-pm+bounces-11066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0DF930390
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jul 2024 05:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BECE1C210E9
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jul 2024 03:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E27217BA7;
	Sat, 13 Jul 2024 03:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIOvkEy2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1451C171AA;
	Sat, 13 Jul 2024 03:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720840628; cv=none; b=ow2Hk4f0GCZKpxljVfCPlTvnoHa8R1mKwaBDyoUc0dJRvMfTdlGTwmeYUp6JBtf0XMXV6GPpoAQXeTXIDNsQQiW3WZo/4PgXc3iXYixwAqqc0u3InrPBRq4S5laV1hSv7WJeTc/Ds0OV5frzGhSGgzJyb6UB+vvdegKuH0Y0bYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720840628; c=relaxed/simple;
	bh=cqXtSMLX0z2oaB34cPC8+RoGJShzn/idNzy5wtgQHMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoT2cBlID0tR4QbuajndqdM5/urUJDSaR9ySUYVuRRnQnMuOcFAHUYXKDIQpUb7il0IDhOc27XCNnhQWNjfNelwVkflBcUHBOf3DTSBCIpJL1S4/nkuTenczw9Zut9yLprtYp43zBSg9OjRjiWjwcace1rL17mRaOqGG1ePj8R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIOvkEy2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720840625; x=1752376625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cqXtSMLX0z2oaB34cPC8+RoGJShzn/idNzy5wtgQHMU=;
  b=gIOvkEy2WQh8kI1piXDrzv+D0D9cHWE0R6Z+6i/FZbatUABE2lZkx54s
   GYjMstaxfGJfqwvpj71WIH5Pdbm2ti0gjh2R3IhthCDhmlIMENMeNaL4m
   iPdOYnNqpkaZTaSYMsqotsQOtrZPSYFggXnsOCr49GeSlCtn+terlxMZf
   +P7We4834T5J4LplxUjP/8vSkAF9WhAen+C5RW7s+YsVgCH3K49fdMJ7L
   qQKQRWyl6TKZwaGrTqEiy+AS1qOMjdE0qzdVTvztW6+MF1AAmC31NE+2O
   5q+0LD75hfpS7DHBB51p4M0xCixD25cWp+OyBsgHClgf3vN2vS97cOWGx
   w==;
X-CSE-ConnectionGUID: 62RgK7Q1Q6isrAVyXfP/yA==
X-CSE-MsgGUID: sVkdN1nxSNWHIgZCLCj+9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="29688423"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="29688423"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 20:17:05 -0700
X-CSE-ConnectionGUID: SH/MYtNRQEeFLxhQLqofRA==
X-CSE-MsgGUID: PG09s4KXQjidP0SrBlDbsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="53459510"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 12 Jul 2024 20:17:00 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSTFp-000bbs-2U;
	Sat, 13 Jul 2024 03:16:57 +0000
Date: Sat, 13 Jul 2024 11:16:01 +0800
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
Subject: Re: [PATCH 2/2] media: venus: use device managed APIs for power
 domains
Message-ID: <202407131046.zNlz3AxD-lkp@intel.com>
References: <1720763312-13018-3-git-send-email-quic_dikshita@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1720763312-13018-3-git-send-email-quic_dikshita@quicinc.com>

Hi Dikshita,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge media-tree/master linus/master v6.10-rc7 next-20240712]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dikshita-Agarwal/PM-domains-add-device-managed-version-of-dev_pm_domain_attach-detach_list/20240712-135151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/1720763312-13018-3-git-send-email-quic_dikshita%40quicinc.com
patch subject: [PATCH 2/2] media: venus: use device managed APIs for power domains
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20240713/202407131046.zNlz3AxD-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project a0c6b8aef853eedaa0980f07c0a502a5a8a9740e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240713/202407131046.zNlz3AxD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407131046.zNlz3AxD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/media/platform/qcom/venus/pm_helpers.c:9:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/media/platform/qcom/venus/pm_helpers.c:9:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/media/platform/qcom/venus/pm_helpers.c:9:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   In file included from drivers/media/platform/qcom/venus/pm_helpers.c:11:
   In file included from include/linux/pm_domain.h:11:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2258:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/media/platform/qcom/venus/pm_helpers.c:872:8: error: call to undeclared function 'devm_pm_domain_attach_list'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     872 |         ret = devm_pm_domain_attach_list(dev, &vcodec_data, &core->pmdomains);
         |               ^
   drivers/media/platform/qcom/venus/pm_helpers.c:872:8: note: did you mean 'dev_pm_domain_attach_list'?
   include/linux/pm_domain.h:483:19: note: 'dev_pm_domain_attach_list' declared here
     483 | static inline int dev_pm_domain_attach_list(struct device *dev,
         |                   ^
   17 warnings and 1 error generated.


vim +/devm_pm_domain_attach_list +872 drivers/media/platform/qcom/venus/pm_helpers.c

   856	
   857	static int vcodec_domains_get(struct venus_core *core)
   858	{
   859		int ret;
   860		struct device **opp_virt_dev;
   861		struct device *dev = core->dev;
   862		const struct venus_resources *res = core->res;
   863		struct dev_pm_domain_attach_data vcodec_data = {
   864			.pd_names = res->vcodec_pmdomains,
   865			.num_pd_names = res->vcodec_pmdomains_num,
   866			.pd_flags = PD_FLAG_NO_DEV_LINK,
   867		};
   868	
   869		if (!res->vcodec_pmdomains_num)
   870			goto skip_pmdomains;
   871	
 > 872		ret = devm_pm_domain_attach_list(dev, &vcodec_data, &core->pmdomains);
   873		if (ret < 0)
   874			return ret;
   875	
   876	skip_pmdomains:
   877		if (!core->res->opp_pmdomain)
   878			return 0;
   879	
   880		/* Attach the power domain for setting performance state */
   881		ret = devm_pm_opp_attach_genpd(dev, res->opp_pmdomain, &opp_virt_dev);
   882		if (ret)
   883			goto opp_attach_err;
   884	
   885		core->opp_pmdomain = *opp_virt_dev;
   886		core->opp_dl_venus = device_link_add(dev, core->opp_pmdomain,
   887						     DL_FLAG_RPM_ACTIVE |
   888						     DL_FLAG_PM_RUNTIME |
   889						     DL_FLAG_STATELESS);
   890		if (!core->opp_dl_venus) {
   891			ret = -ENODEV;
   892			goto opp_attach_err;
   893		}
   894	
   895		return 0;
   896	
   897	opp_attach_err:
   898		return ret;
   899	}
   900	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

