Return-Path: <linux-pm+bounces-22085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65066A35EB3
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 14:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 056AD7A2B5C
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 13:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1CD264A91;
	Fri, 14 Feb 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAsTH2DE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E32C22D786;
	Fri, 14 Feb 2025 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539101; cv=none; b=QhEX96UaIGvduf9KpFyoKvGhv6VwP08b/hPnoVGx4EfTesoHTsbNN7EsW9NMhW5N6I1kSOc08u/cbGMyY7khVCYUOjLs6P8BL+9xILp9rIhfcVOj4oFXxAMR6u1vP59z5DszQg6z7YH4kB02MetQd9sRsaMAwEU+tVtO1pEjN0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539101; c=relaxed/simple;
	bh=jPuAmynmOel3ZYS+nralVAlab6we2cU4t4qrzTZ2XBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XX3lu3uRaDP1eew2904NRZaq/cqxsdRbEAXeUDAzepEX09cmw2KpmIvvtGnsJQwxLxU7OYMLl6hMzuzCpvFazersHDbBW+1sBTiMcyZ5h9yi3Hfks5B//OL3rb60YQA0Zzw1B11n5vfeySQB6qdaxdhB9W1r+y7GD0a+3bIOM1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAsTH2DE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739539099; x=1771075099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jPuAmynmOel3ZYS+nralVAlab6we2cU4t4qrzTZ2XBs=;
  b=VAsTH2DEydKtvogLLPeK/8IWWWaxjxRewVVaOnX/hrdTXrdczOjWISDU
   VpNE0zNuLAY6NQnuabp+p6T8fUPIJVJ8USvUuFNmCv5jb5Z/fFM/dQ+d1
   +Puyipu2xDVnl4xXniejICAcb8KuM+S68BGQT8XU3ZEZRLyjAI8YIsLlw
   baObUpUM+gEUcjyM7xPzj8viatuQfKA34CAVnuFS+m5Xy9LpCO7RavE12
   5WB3KXTNHL4eVpBwrT60NV1u9dTmKCaonVUtpqfoN6ZJ1gCD+FyyVk5CX
   jRLqjaZvfS/yis2f3l6HuSg2DfECkUUYispVOrItWMHEpQGvySe8zL+yr
   g==;
X-CSE-ConnectionGUID: J/abtWp3S/GGa4RwREheLg==
X-CSE-MsgGUID: y6Xu/VUwTN2cxCwf1YNf9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="50914015"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="50914015"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 05:18:18 -0800
X-CSE-ConnectionGUID: FrGF59/FRKi0aL1+JQPXSQ==
X-CSE-MsgGUID: 1wesBdFHQuu6y47xyf5zKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136679212"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 14 Feb 2025 05:18:15 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiva8-0019Zj-2T;
	Fri, 14 Feb 2025 13:18:12 +0000
Date: Fri, 14 Feb 2025 21:18:04 +0800
From: kernel test robot <lkp@intel.com>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
	amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, rui.zhang@intel.com, lukasz.luba@arm.com,
	david.collins@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] thermal: qcom-spmi-temp-alarm: Add temp alarm data
 struct based on HW subtype
Message-ID: <202502142142.SOgv2k2t-lkp@intel.com>
References: <20250213210403.3396392-3-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213210403.3396392-3-anjelique.melendez@oss.qualcomm.com>

Hi Anjelique,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on linus/master v6.14-rc2 next-20250214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anjelique-Melendez/thermal-qcom-spmi-temp-alarm-enable-stage-2-shutdown-when-required/20250214-050700
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20250213210403.3396392-3-anjelique.melendez%40oss.qualcomm.com
patch subject: [PATCH 2/4] thermal: qcom-spmi-temp-alarm: Add temp alarm data struct based on HW subtype
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20250214/202502142142.SOgv2k2t-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250214/202502142142.SOgv2k2t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502142142.SOgv2k2t-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/qcom/qcom-spmi-temp-alarm.c:161: warning: expecting prototype for qpnp_tm_get_gen2_temp_stage(). Prototype was for qpnp_tm_gen2_get_temp_stage() instead


vim +161 drivers/thermal/qcom/qcom-spmi-temp-alarm.c

   153	
   154	/**
   155	 * qpnp_tm_get_gen2_temp_stage() - return over-temperature stage
   156	 * @chip:		Pointer to the qpnp_tm chip
   157	 *
   158	 * Return: stage on success, or errno on failure.
   159	 */
   160	static int qpnp_tm_gen2_get_temp_stage(struct qpnp_tm_chip *chip)
 > 161	{
   162		u8 reg = 0;
   163		int ret;
   164	
   165		ret = qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
   166		if (ret < 0)
   167			return ret;
   168	
   169		ret = FIELD_GET(STATUS_GEN2_STATE_MASK, reg);
   170	
   171		return alarm_state_map[ret];
   172	}
   173	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

