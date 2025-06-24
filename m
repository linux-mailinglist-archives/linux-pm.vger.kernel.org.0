Return-Path: <linux-pm+bounces-29426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0D6AE6552
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 14:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC813A3A4B
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 12:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014E0227EA7;
	Tue, 24 Jun 2025 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nXUpl1bp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191A24400
	for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769180; cv=none; b=cvvu+KZMzk0yw8Vou2xOj67YMo9PdJdy1GL//IuSxEuWFVK0MPwJUsdwDL8gZ2XugYfdpfn6Nxy1un+g82Bh6Ebo3mCaTVUB+ig4L1aYUuL9b8e++vglY91Wz58ay0lMTmOlt51F0wvYhN1xHHPruncp+0OffRiZj8qmQ0w2uYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769180; c=relaxed/simple;
	bh=BDYGa+m6K+LmXDWazJkL10WSFSQVLqwK6TRasS5lWhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWwJLOb14PkeKKC5sMsAL0J1M97IlvNxYsAlR02Quo0TnkzyeOhp2zha3i5WEaXNRxcaedNUUIJaEKXlLLv0h9+MHi5QNK+KLZJEhj+kym2VadKJiW29A408Qpiud0Zg9RRjuVAEprtAbK8oNIYfsdWHEUQvXAyuMfrfN6IFrQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nXUpl1bp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750769179; x=1782305179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BDYGa+m6K+LmXDWazJkL10WSFSQVLqwK6TRasS5lWhk=;
  b=nXUpl1bpc81w76eQq13qsXkuZmx4rOtocMq4sWd49Q8ZuCfC33KjSzSO
   jmK++ptYYC2WvaWjDZKRW35sYyd48yCMI52OMFlsZxYtYFMWYi7TKRZ/c
   v+cDRSyd+TjnQ4L8A5nVUmxtulkRKkaJoRE5k/zu/ldQfdZWwIBvqQIrd
   Mnw0aiG3K0dL2nFO7zatKFuzhrcvm6Cq291yh9qOR/ncQa0r9tCYxVuus
   ZJaPFJZ+rPa0/udLQA+Ro62oWadEmypzRyGLq9zp41rcJC1GX3rx6MybO
   u/DFCJ9WB2zV99yGLQVSaqTgCpCpZNSAaZoqwKwmQTZnmOmNUdDwPuMmI
   Q==;
X-CSE-ConnectionGUID: 39iAEXqhSjWOSjaMUG9q8g==
X-CSE-MsgGUID: 43UK2tRLQsu8zyN6Fpv1WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64433880"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="64433880"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 05:46:19 -0700
X-CSE-ConnectionGUID: bXEP/w2kRyu/GbGwa/F6Zg==
X-CSE-MsgGUID: JYeL8FHPR5KD2ghtfKWQSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="157402348"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 24 Jun 2025 05:46:17 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uU32U-000S7u-34;
	Tue, 24 Jun 2025 12:46:14 +0000
Date: Tue, 24 Jun 2025 20:45:56 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-pm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Zhang Rui <rui.zhang@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH] thermal: use a custom lock class for intel x86_pkg_temp
Message-ID: <202506242034.nhZNCW5t-lkp@intel.com>
References: <20250624093001.1359961-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624093001.1359961-1-benjamin@sipsolutions.net>

Hi Benjamin,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v6.16-rc3 next-20250623]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Berg/thermal-use-a-custom-lock-class-for-intel-x86_pkg_temp/20250624-173220
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20250624093001.1359961-1-benjamin%40sipsolutions.net
patch subject: [PATCH] thermal: use a custom lock class for intel x86_pkg_temp
config: i386-buildonly-randconfig-006-20250624 (https://download.01.org/0day-ci/archive/20250624/202506242034.nhZNCW5t-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250624/202506242034.nhZNCW5t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506242034.nhZNCW5t-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/thermal/intel/x86_pkg_temp_thermal.c: In function 'pkg_temp_thermal_device_add':
>> drivers/thermal/intel/x86_pkg_temp_thermal.c:351:9: error: implicit declaration of function 'thermal_zone_device_set_lock_class'; did you mean 'thermal_zone_set_lock_class'? [-Werror=implicit-function-declaration]
     351 |         thermal_zone_device_set_lock_class(zonedev->tzone, &x86_pkg_temp_class);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         thermal_zone_set_lock_class
   cc1: some warnings being treated as errors


vim +351 drivers/thermal/intel/x86_pkg_temp_thermal.c

   309	
   310	static int pkg_temp_thermal_device_add(unsigned int cpu)
   311	{
   312		struct lock_class_key x86_pkg_temp_class;
   313		struct thermal_trip trips[MAX_NUMBER_OF_TRIPS] = { 0 };
   314		int id = topology_logical_die_id(cpu);
   315		u32 eax, ebx, ecx, edx;
   316		struct zone_device *zonedev;
   317		int thres_count, err;
   318		int tj_max;
   319	
   320		if (id >= max_id)
   321			return -ENOMEM;
   322	
   323		cpuid(6, &eax, &ebx, &ecx, &edx);
   324		thres_count = ebx & 0x07;
   325		if (!thres_count)
   326			return -ENODEV;
   327	
   328		thres_count = clamp_val(thres_count, 0, MAX_NUMBER_OF_TRIPS);
   329	
   330		tj_max = intel_tcc_get_tjmax(cpu);
   331		if (tj_max < 0)
   332			return tj_max;
   333	
   334		zonedev = kzalloc(sizeof(*zonedev), GFP_KERNEL);
   335		if (!zonedev)
   336			return -ENOMEM;
   337	
   338		err = pkg_temp_thermal_trips_init(cpu, tj_max, trips, thres_count);
   339		if (err)
   340			goto out_kfree_zonedev;
   341	
   342		INIT_DELAYED_WORK(&zonedev->work, pkg_temp_thermal_threshold_work_fn);
   343		zonedev->cpu = cpu;
   344		zonedev->tzone = thermal_zone_device_register_with_trips("x86_pkg_temp",
   345				trips, thres_count,
   346				zonedev, &tzone_ops, &pkg_temp_tz_params, 0, 0);
   347		if (IS_ERR(zonedev->tzone)) {
   348			err = PTR_ERR(zonedev->tzone);
   349			goto out_kfree_zonedev;
   350		}
 > 351		thermal_zone_device_set_lock_class(zonedev->tzone, &x86_pkg_temp_class);
   352		err = thermal_zone_device_enable(zonedev->tzone);
   353		if (err)
   354			goto out_unregister_tz;
   355	
   356		/* Store MSR value for package thermal interrupt, to restore at exit */
   357		rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, zonedev->msr_pkg_therm_low,
   358		      zonedev->msr_pkg_therm_high);
   359	
   360		cpumask_set_cpu(cpu, &zonedev->cpumask);
   361		raw_spin_lock_irq(&pkg_temp_lock);
   362		zones[id] = zonedev;
   363		raw_spin_unlock_irq(&pkg_temp_lock);
   364	
   365		return 0;
   366	
   367	out_unregister_tz:
   368		thermal_zone_device_unregister(zonedev->tzone);
   369	out_kfree_zonedev:
   370		kfree(zonedev);
   371		return err;
   372	}
   373	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

