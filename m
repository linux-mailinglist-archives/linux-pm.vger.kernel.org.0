Return-Path: <linux-pm+bounces-31296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC692B0E288
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 19:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290211888563
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 17:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05DF27FD44;
	Tue, 22 Jul 2025 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WifWnkxB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163FA27E07B;
	Tue, 22 Jul 2025 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205006; cv=none; b=r0YzuyHocnEnz5lhydU9Sw13aMzz4k95B54kUfthF2eMaeE9BAoyn8W47viTE8DXlJLIocz1z0rz+Tkam144Nb7nWRHmrW7RNydf9lqKWUF15SrtSaoC6w/0pa09uvYGMvxS7RnTBIU1Yz7fJxUX1ELLFId4KpH8MUJe/XN25xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205006; c=relaxed/simple;
	bh=iY8DNW2TAKM17+S3GE59sF3ZE1JUQqgmoNS4oXSaDTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKCoQBvZyITYAApfYhyGWUeqPr/HuA3GnTRe1UdhFWIgl7DkhX59ME+AwcvVzHXYsqTJttj1D5vkqNzidpLE8+dc06wtLXzwN1rgg7z/EoZXN1jGt8ek5muVvFKg1345D+IDj8HVqtNSCpPVe687awYFzBUNIA65OlYSCJnUB2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WifWnkxB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753205005; x=1784741005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iY8DNW2TAKM17+S3GE59sF3ZE1JUQqgmoNS4oXSaDTI=;
  b=WifWnkxBen5bDamG5U4akMA3VSuugCaOU26drWI36o/T5/ato0QRKLPa
   TULOyihOf13ZUWSmeaOt0+vuUm8NxMyYAyTWtGw9MetKRFxz5O8l7QD2y
   8eFPez5kOWdIO+Grcev7XAZtCBLveYaGIH516u6sV+oSKboyENT8ZF6D7
   gH50r3qYEd1I/jAu4AX63lSKBRgGUeCw+P5KMGiI5U1zq4YTJUnCwgJRl
   IFnJwr2yWKnsHZTmGaLixAAajchXXTG6Jj+d0HDBl/4Jf2mi4a2BuqSY8
   o1OX7Yw+GvBpQA2mVyFPe6UNhCikbLMs9opk+kig2N5YlNl0s7UhZJg5F
   w==;
X-CSE-ConnectionGUID: cXsJi+OGTlSYXGVzwcVzuQ==
X-CSE-MsgGUID: 1oN0Dz79SHSBklulwzj6og==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="54686982"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="54686982"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 10:23:24 -0700
X-CSE-ConnectionGUID: uaWWmbRTSpWBbZdK7pVGwA==
X-CSE-MsgGUID: lepFhLzqSUi9A8Qk/GF6wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="163750882"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 22 Jul 2025 10:23:18 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ueGhv-000IaB-1e;
	Tue, 22 Jul 2025 17:23:15 +0000
Date: Wed, 23 Jul 2025 01:22:57 +0800
From: kernel test robot <lkp@intel.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, Dmitry Baryshkov <lumag@kernel.org>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	Elliot Berman <quic_eberman@quicinc.com>,
	Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v12 8/8] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
Message-ID: <202507230101.w90DnJxJ-lkp@intel.com>
References: <20250721-arm-psci-system_reset2-vendor-reboots-v12-8-87bac3ec422e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-arm-psci-system_reset2-vendor-reboots-v12-8-87bac3ec422e@oss.qualcomm.com>

Hi Shivendra,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 97987520025658f30bb787a99ffbd9bbff9ffc9d]

url:    https://github.com/intel-lab-lkp/linux/commits/Shivendra-Pratap/power-reset-reboot-mode-Add-device-tree-node-based-registration/20250722-023323
base:   97987520025658f30bb787a99ffbd9bbff9ffc9d
patch link:    https://lore.kernel.org/r/20250721-arm-psci-system_reset2-vendor-reboots-v12-8-87bac3ec422e%40oss.qualcomm.com
patch subject: [PATCH v12 8/8] power: reset: reboot-mode: Expose sysfs for registered reboot_modes
config: arc-randconfig-r111-20250722 (https://download.01.org/0day-ci/archive/20250723/202507230101.w90DnJxJ-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250723/202507230101.w90DnJxJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507230101.w90DnJxJ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/power/reset/reboot-mode.c:82:76: sparse: sparse: Using plain integer as NULL pointer

vim +82 drivers/power/reset/reboot-mode.c

    74	
    75	static ssize_t reboot_modes_show(struct device *dev, struct device_attribute *attr, char *buf)
    76	{
    77		struct reboot_mode_driver **devres_reboot;
    78		struct reboot_mode_driver *reboot;
    79		struct mode_info *info;
    80		ssize_t size = 0;
    81	
  > 82		devres_reboot = devres_find(dev, release_reboot_mode_device, NULL, 0);
    83		reboot = *devres_reboot;
    84		mutex_lock(&reboot->rb_lock);
    85		list_for_each_entry(info, &reboot->head, list) {
    86			size += sprintf(buf + size, "%s,", info->mode);
    87		}
    88		mutex_unlock(&reboot->rb_lock);
    89	
    90		if (size) {
    91			size += sprintf(buf + size - 1, "\n");
    92			return size;
    93		}
    94	
    95		return -ENODATA;
    96	}
    97	static DEVICE_ATTR_RO(reboot_modes);
    98	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

