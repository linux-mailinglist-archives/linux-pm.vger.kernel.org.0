Return-Path: <linux-pm+bounces-9817-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BFD913795
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 05:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309511F21ADB
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2024 03:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF802CA7;
	Sun, 23 Jun 2024 03:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7LZJZTU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC014C85
	for <linux-pm@vger.kernel.org>; Sun, 23 Jun 2024 03:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719114522; cv=none; b=jEZMU3wmEDIF0bSXCl9Yy2ui9VoaTjePChhJkhkLdag8fw72x2bNOuvcDzQjCzpVKQOVQPGFlQ82sXwZGkks4mJ69SczyQnuwzq+3pw9GRvWRoVYw5z5Tomo6nuglB0VFfsufKsmqZ0FpDaGVRuXkR4zU77Stk7HffKHU4eU46Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719114522; c=relaxed/simple;
	bh=ECP4qV5DuOp7eCw5OS92rOKQwYeC/FDdAZPAb5fOzLA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bxEpBNYgvh5rTBUQyrpxJBSmTmxHkY3sfiRHuzIAnuMj3PeLxj97T0j2VbHV/gHEIAFg+7dpjrRjdwthx+ycV23JcBAriV+dwJrxAtknN6iBODUSzC/O+jcpESCQDGagNNa8vvCqdh0R+/+xpF3bSgXU7aLliBhJkTvvxuk6g3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7LZJZTU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719114520; x=1750650520;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ECP4qV5DuOp7eCw5OS92rOKQwYeC/FDdAZPAb5fOzLA=;
  b=i7LZJZTUtPNv16O4YTYRrZKtGqZFpy6iqCrI8UkgaKqu/GEUy1/YFqoi
   FEgJDx35kITXlGJxYO6P7nkkCndg1LKS+3vKA2w+hOVQtGIo+gq/JTM9U
   PuXTtbvaktRz8qLQhY/ypXMlhpJuk8/UxUHpD7FU7wPwP0HM/vDGK54m3
   QXKrPnWvYaO5pCV/3Ghv4D2yfWv6eqp2q4/6xeyYqgSUCHwKGvA4g87o5
   XkmWu7HyWs5DL170f463Kv3Nf8YqJRbNN1zLx1UiSKmLvyK8w/uKIKt/i
   P3ErkYFqvEdbQs+RVaM8yZdvdPCcQzdX7Q7mpLiZMD9qgdAPr12eA5ctH
   g==;
X-CSE-ConnectionGUID: MjdK88KkSeytUZRQCkTu0A==
X-CSE-MsgGUID: RnNhb/1QQC6kVHIrkhHLog==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="33652966"
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="33652966"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2024 20:48:39 -0700
X-CSE-ConnectionGUID: 04kVIvEYRa2NgFmx+JYp9A==
X-CSE-MsgGUID: 0j3v0Sk3TzCkuKLrUJnHdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="42837706"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 22 Jun 2024 20:48:38 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sLEDU-000AEk-1B;
	Sun, 23 Jun 2024 03:48:36 +0000
Date: Sun, 23 Jun 2024 11:47:36 +0800
From: kernel test robot <lkp@intel.com>
To: Perry Yuan <Perry.Yuan@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [amd-pstate:bleeding-edge 17/21] amd-pstate-ut.c:undefined reference
 to `amd_pstate_global_params'
Message-ID: <202406231105.RgaCje6y-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
head:   ca8cc4ec88d54d4b7c59fe82de0deae3fcefb711
commit: 6c3b56339488b6cca212f68096519d3c009c31e1 [17/21] cpufreq: amd-pstate: implement cpb_boost sysfs entry for boost control
config: i386-buildonly-randconfig-004-20240623 (https://download.01.org/0day-ci/archive/20240623/202406231105.RgaCje6y-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240623/202406231105.RgaCje6y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406231105.RgaCje6y-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/cpufreq/amd-pstate-ut.o: in function `amd_pstate_ut_check_freq':
>> amd-pstate-ut.c:(.text+0x3ba): undefined reference to `amd_pstate_global_params'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

