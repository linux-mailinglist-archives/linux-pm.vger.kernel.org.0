Return-Path: <linux-pm+bounces-36716-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA50C00B38
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 13:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517621A62104
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 11:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2202030DD06;
	Thu, 23 Oct 2025 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJcxCUrR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DB52EC568;
	Thu, 23 Oct 2025 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218619; cv=none; b=F2HsnANrv7GkCA2f/3VmZP48tNQSVauKJKOOaysF1u76H7PMwO0XPwEyAG1Ek1uJptnW5CQQeWYrab8nCsMF9XyUf9iSY4nvtWcM6S1KwWQJt7pxQDssAGrzS0fysC4HjBplHsogThy0ejjTYe22o8odTea7p40ddNqu3SK1a2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218619; c=relaxed/simple;
	bh=AZgER26oUshoP3CdEH8UIX863Xw4lI/oUz06gXKgFQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xm4VMTvKNpnlnXzXglYw8EhMz/t+jV1Emg6t9DGhSN2UPN9zXDvmrd52yqVVuUrJG7hF0NvXiM2Dz6laroKE42H8biu5DK+i61gQGh1nrZvzZralcLz2VteFZelRyOg9IvwcbayPVHeKp0H0qNk62qVNEBo2IY7ARDnwi9WE6dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJcxCUrR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761218617; x=1792754617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AZgER26oUshoP3CdEH8UIX863Xw4lI/oUz06gXKgFQE=;
  b=IJcxCUrRwrmzwFl1VmqzTcHO9zA4XFwHm+CnDXsdJPlch30DaAJ/Oszt
   yyFWHEk+W1g7AdpFY3d6YSfOG/YM2UZU/AxnCDN7ENm7iycVtuGg8anaC
   +/67H0EnpAouV1o131kWYaq8y2Im4n0fRdhKsZrKv2ZoV4wB4Sm8orPwj
   Fei2rOIZj+errhg2f+Y9Q4wglZMEeHvBaUHB8y6padvpBnvPHC8lTR7HX
   4wd2dWKRYcqhgM9b1I3c8K5M6TDVJdi9BmUHf2LNugQRQ76i4QU03o/Tn
   UUTrfUx7K2qumFG7ltdsSFVGXXg25JFiT3jW6ZAosxARbsVGTMBalQ2oI
   A==;
X-CSE-ConnectionGUID: GF2/hH6JSpS9sw7TDh7eKw==
X-CSE-MsgGUID: D0xYr7KCSYe5cS9V1lAyNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74053559"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="74053559"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 04:23:36 -0700
X-CSE-ConnectionGUID: FLLq2LjhTZWOTFEnitNZpg==
X-CSE-MsgGUID: 9flyC3fpTn6Kuf/1p4nXbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="184614924"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 23 Oct 2025 04:23:33 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vBtPn-000DOf-0V;
	Thu, 23 Oct 2025 11:23:31 +0000
Date: Thu, 23 Oct 2025 19:23:30 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	amd-gfx@lists.freedesktop.org, corbet@lwn.net, rafael@kernel.org,
	gregkh@linuxfoundation.org, dakr@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] PM: Allow device drivers to manage the frozen state
 of a device
Message-ID: <202510231933.86hrXJ9i-lkp@intel.com>
References: <20251022155114.48418-2-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022155114.48418-2-mario.limonciello@amd.com>

Hi Mario,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.18-rc2 next-20251023]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/PM-Allow-device-drivers-to-manage-the-frozen-state-of-a-device/20251022-235319
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20251022155114.48418-2-mario.limonciello%40amd.com
patch subject: [PATCH 1/2] PM: Allow device drivers to manage the frozen state of a device
config: x86_64-randconfig-003-20251023 (https://download.01.org/0day-ci/archive/20251023/202510231933.86hrXJ9i-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251023/202510231933.86hrXJ9i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510231933.86hrXJ9i-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/base/power/main.c:1114:26: error: no member named 'is_frozen' in 'struct dev_pm_info'
    1114 |         if (error && dev->power.is_frozen) {
         |                      ~~~~~~~~~~ ^
   1 error generated.


vim +1114 drivers/base/power/main.c

  1026	
  1027	/**
  1028	 * device_resume - Execute "resume" callbacks for given device.
  1029	 * @dev: Device to handle.
  1030	 * @state: PM transition of the system being carried out.
  1031	 * @async: If true, the device is being resumed asynchronously.
  1032	 */
  1033	static void device_resume(struct device *dev, pm_message_t state, bool async)
  1034	{
  1035		pm_callback_t callback = NULL;
  1036		const char *info = NULL;
  1037		int error = 0;
  1038		DECLARE_DPM_WATCHDOG_ON_STACK(wd);
  1039	
  1040		TRACE_DEVICE(dev);
  1041		TRACE_RESUME(0);
  1042	
  1043		if (dev->power.syscore)
  1044			goto Complete;
  1045	
  1046		if (!dev->power.is_suspended)
  1047			goto Complete;
  1048	
  1049		dev->power.is_suspended = false;
  1050	
  1051		if (dev->power.direct_complete) {
  1052			/*
  1053			 * Allow new children to be added under the device after this
  1054			 * point if it has no PM callbacks.
  1055			 */
  1056			if (dev->power.no_pm_callbacks)
  1057				dev->power.is_prepared = false;
  1058	
  1059			/* Match the pm_runtime_disable() in device_suspend(). */
  1060			pm_runtime_enable(dev);
  1061			goto Complete;
  1062		}
  1063	
  1064		if (!dpm_wait_for_superior(dev, async))
  1065			goto Complete;
  1066	
  1067		dpm_watchdog_set(&wd, dev);
  1068		device_lock(dev);
  1069	
  1070		/*
  1071		 * This is a fib.  But we'll allow new children to be added below
  1072		 * a resumed device, even if the device hasn't been completed yet.
  1073		 */
  1074		dev->power.is_prepared = false;
  1075	
  1076		if (dev->pm_domain) {
  1077			info = "power domain ";
  1078			callback = pm_op(&dev->pm_domain->ops, state);
  1079			goto Driver;
  1080		}
  1081	
  1082		if (dev->type && dev->type->pm) {
  1083			info = "type ";
  1084			callback = pm_op(dev->type->pm, state);
  1085			goto Driver;
  1086		}
  1087	
  1088		if (dev->class && dev->class->pm) {
  1089			info = "class ";
  1090			callback = pm_op(dev->class->pm, state);
  1091			goto Driver;
  1092		}
  1093	
  1094		if (dev->bus) {
  1095			if (dev->bus->pm) {
  1096				info = "bus ";
  1097				callback = pm_op(dev->bus->pm, state);
  1098			} else if (dev->bus->resume) {
  1099				info = "legacy bus ";
  1100				callback = dev->bus->resume;
  1101				goto End;
  1102			}
  1103		}
  1104	
  1105	 Driver:
  1106		if (!callback && dev->driver && dev->driver->pm) {
  1107			info = "driver ";
  1108			callback = pm_op(dev->driver->pm, state);
  1109		}
  1110	
  1111	 End:
  1112		error = dpm_run_callback(callback, dev, state, info);
  1113		/* device manages frozen state */
> 1114		if (error && dev->power.is_frozen) {
  1115			dev->power.is_suspended = true;
  1116			error = 0;
  1117		}
  1118	
  1119		device_unlock(dev);
  1120		dpm_watchdog_clear(&wd);
  1121	
  1122	 Complete:
  1123		complete_all(&dev->power.completion);
  1124	
  1125		TRACE_RESUME(error);
  1126	
  1127		if (error) {
  1128			WRITE_ONCE(async_error, error);
  1129			dpm_save_failed_dev(dev_name(dev));
  1130			pm_dev_err(dev, state, async ? " async" : "", error);
  1131		}
  1132	
  1133		dpm_async_resume_subordinate(dev, async_resume);
  1134	}
  1135	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

