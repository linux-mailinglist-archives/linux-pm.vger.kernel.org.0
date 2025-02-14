Return-Path: <linux-pm+bounces-22089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D618A361C1
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 16:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BBC93A4AA9
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 15:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B285F266B7D;
	Fri, 14 Feb 2025 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOPWJHR7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6216926659B;
	Fri, 14 Feb 2025 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547098; cv=none; b=gcUW7jKu2o+Tzy+c+vsZdAHLS9HgQWi5BR81DnAKJn/XKppXnvtG5B1yZDBkpIJmaV1aCcq9K0PjiOk/8UwhtTFOvwMbygEnv5D/zFc00jEJ7DE5J6kMmj+p9FVVZst5sBCA0AjrXbrECLCvwlkYn3JPrmOXIoJtr8DGoEUGvRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547098; c=relaxed/simple;
	bh=7P5KfUUs2ZOeZWd7glFomIFleZsfHmdy42H1Kar+cJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdBkjrU6W/4QRzVFXZ8uDmEIKo/nhv4d4L+uDuzjTdKZ9yq22DuQC5lWM8zae8NRx71+8aKgET5qyDUQ8TGdgyLZF9Eq/dJsmDPRpE9qGtz3i02WYZ+nlcVGXhjWKXN+oddzw0Y+AilS1YliLghqPpsvZwzZtv498IiAFHFXVS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOPWJHR7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739547096; x=1771083096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7P5KfUUs2ZOeZWd7glFomIFleZsfHmdy42H1Kar+cJk=;
  b=FOPWJHR7N4bvNJb28j4xSoATD1UCNAU024LGUoV1a4BPkBnb3K1HXUkE
   FLnBkjUnHIj9tc3LElXDvgZmoHdYAYWrpU4F0ghDt8LAOq+1iFtD3MWxA
   K3AHuwdbTN6M52gFVVJ2AuOsF+uu4gWSdrCYT0oWEx3OZicho3kjuQTwM
   h66TZyJXEme757VlV/E2aHn/16ZG21/wDtHehxJowNFMS54KWdhTPSdRc
   i8alEA7WweCqCac2BFwQNkPEoL90C+mLrZAvGfk3GM7fzTDIXB+pdUYWr
   813jT4g0NIjhkJ/n4jYhOzch8og59mP1BkKvry2/a9GaLNlibA3W0n06n
   g==;
X-CSE-ConnectionGUID: KDLJygDZR62DrQEE7IuGmw==
X-CSE-MsgGUID: zr5A9SSKQwCiFf+4J2uPOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="50512364"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="50512364"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 07:31:36 -0800
X-CSE-ConnectionGUID: CR1ia8JuS++UWH5gInrNzg==
X-CSE-MsgGUID: VFwFGR/cS1q9lN4KptVY/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118416806"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Feb 2025 07:31:32 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tixf8-0019m7-19;
	Fri, 14 Feb 2025 15:31:30 +0000
Date: Fri, 14 Feb 2025 23:31:18 +0800
From: kernel test robot <lkp@intel.com>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
	amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	rui.zhang@intel.com, lukasz.luba@arm.com,
	david.collins@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] thermal: qcom-spmi-temp-alarm: add support for LITE
 PMIC peripherals
Message-ID: <202502142339.NmW9FTBM-lkp@intel.com>
References: <20250213210403.3396392-5-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213210403.3396392-5-anjelique.melendez@oss.qualcomm.com>

Hi Anjelique,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on linus/master v6.14-rc2 next-20250214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anjelique-Melendez/thermal-qcom-spmi-temp-alarm-enable-stage-2-shutdown-when-required/20250214-050700
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20250213210403.3396392-5-anjelique.melendez%40oss.qualcomm.com
patch subject: [PATCH 4/4] thermal: qcom-spmi-temp-alarm: add support for LITE PMIC peripherals
config: i386-buildonly-randconfig-003-20250214 (https://download.01.org/0day-ci/archive/20250214/202502142339.NmW9FTBM-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250214/202502142339.NmW9FTBM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502142339.NmW9FTBM-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/thermal/qcom/qcom-spmi-temp-alarm.c:196:9: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     196 |         return FIELD_GET(STATUS_GEN1_STAGE_MASK, reg);
         |                ^
   drivers/thermal/qcom/qcom-spmi-temp-alarm.c:217:8: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     217 |         ret = FIELD_GET(STATUS_GEN2_STATE_MASK, reg);
         |               ^
>> drivers/thermal/qcom/qcom-spmi-temp-alarm.c:477:9: error: call to undeclared function 'FIELD_PREP'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     477 |         reg |= FIELD_PREP(LITE_TEMP_CFG_THRESHOLD_MASK, thresh);
         |                ^
   drivers/thermal/qcom/qcom-spmi-temp-alarm.c:634:11: error: call to undeclared function 'FIELD_GET'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     634 |         thresh = FIELD_GET(LITE_TEMP_CFG_THRESHOLD_MASK, reg);
         |                  ^
   4 errors generated.


vim +/FIELD_PREP +477 drivers/thermal/qcom/qcom-spmi-temp-alarm.c

   418	
   419	static int qpnp_tm_lite_set_temp_thresh(struct qpnp_tm_chip *chip, int trip, int temp)
   420	{
   421		int ret, temp_cfg, i;
   422		const long *temp_map;
   423		u16 addr;
   424		u8 reg, thresh;
   425	
   426		if (trip < 0 || trip >= STAGE_COUNT) {
   427			dev_err(chip->dev, "invalid TEMP_LITE trip = %d\n", trip);
   428			return -EINVAL;
   429		}
   430	
   431		switch (trip) {
   432		case 0:
   433			temp_map = temp_lite_warning_map;
   434			addr = QPNP_TM_REG_LITE_TEMP_CFG1;
   435			break;
   436		case 1:
   437			/*
   438			 * The second trip point is purely in software to facilitate
   439			 * a controlled shutdown after the warning threshold is crossed
   440			 * but before the automatic hardware shutdown threshold is
   441			 * crossed.
   442			 */
   443			return 0;
   444		case 2:
   445			temp_map = temp_lite_shutdown_map;
   446			addr = QPNP_TM_REG_LITE_TEMP_CFG2;
   447			break;
   448		default:
   449			return 0;
   450		}
   451	
   452		if (temp < temp_map[THRESH_MIN] || temp > temp_map[THRESH_MAX]) {
   453			dev_err(chip->dev, "invalid TEMP_LITE temp = %d\n", temp);
   454			return -EINVAL;
   455		}
   456	
   457		thresh = 0;
   458		temp_cfg = temp_map[thresh];
   459		for (i = THRESH_MAX; i >= THRESH_MIN; i--) {
   460			if (temp >= temp_map[i]) {
   461				thresh = i;
   462				temp_cfg = temp_map[i];
   463				break;
   464			}
   465		}
   466	
   467		if (temp_cfg == chip->temp_thresh_map[trip])
   468			return 0;
   469	
   470		ret = qpnp_tm_read(chip, addr, &reg);
   471		if (ret < 0) {
   472			dev_err(chip->dev, "LITE_TEMP_CFG read failed, ret=%d\n", ret);
   473			return ret;
   474		}
   475	
   476		reg &= ~LITE_TEMP_CFG_THRESHOLD_MASK;
 > 477		reg |= FIELD_PREP(LITE_TEMP_CFG_THRESHOLD_MASK, thresh);
   478	
   479		ret = qpnp_tm_write(chip, addr, reg);
   480		if (ret < 0) {
   481			dev_err(chip->dev, "LITE_TEMP_CFG write failed, ret=%d\n", ret);
   482			return ret;
   483		}
   484	
   485		chip->temp_thresh_map[trip] = temp_cfg;
   486	
   487		return 0;
   488	}
   489	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

