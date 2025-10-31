Return-Path: <linux-pm+bounces-37182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C99BAC250F2
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 13:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E643AA15D
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 12:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B3134A785;
	Fri, 31 Oct 2025 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezrt3+t3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23C3342CA5;
	Fri, 31 Oct 2025 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914622; cv=none; b=uyhVdn3IuUn6RLET10eNb0JvGo6JDxxJFgjyCj7SPF9KQzGKHcHzRvcl5sHfp8cMaILOW9Ua78N5pPdf+/D8dlpyYHCRh+lDLbmLiX8HuHBP1SqN+qnCXGg/895d2s4Y1dKkZC7R4IeHX5ujk4PRaXMq/dPbzoe6iqOWPD0iOKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914622; c=relaxed/simple;
	bh=sF35hppqD3HWncobGIVIUzqVORCZRJuB6R7SU1cG6+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEy35fTzxvkSOZmyKwf8JXGkBABuYPQYICPe9Ubw/442LQ3Ch1rFOxMKdCChaa0yk7eqtXdRK3XSmIg1w8PDpDrfEhjGXwDBppLW5zmJxLH7qYEE/3cadT6FyLf3ZAHJ6/ZrcVcs+ciBZOe8fByAKhKNtRQUlGX8vYY8PTCthuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezrt3+t3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761914607; x=1793450607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sF35hppqD3HWncobGIVIUzqVORCZRJuB6R7SU1cG6+U=;
  b=ezrt3+t31QLLFGHgQo6NIgHwvxsx7rJuP39gYI2YnKWIaepA69umuWhQ
   9QugiwP1BKFMs0V5qetbN7BxqaqGp+LacZgP5sdFfrkhXicn/EIgRjOia
   61KTk7iopk9SenzAb9SwrJX+qgPLGfvcE9k2JClXK7qIJLQgyIKdhrCUE
   MYNCVv9dPDn5yumFfi6fMSM3Lh7RjoXM4JDLXBjlrKJgyV91SJxV8nRP8
   70uK/0iT7cSjKuhT6JGFSGm4nkiU7A1HgszwG4PgtwItiR4VpGpkgE0NA
   R4By3qO9/OENnqOjpWUetmbPRZrUqLHBh/eNcj8GKvVlptCv7O6hGlVO9
   A==;
X-CSE-ConnectionGUID: GU3bK0a7S0SWLpy3A/PTVQ==
X-CSE-MsgGUID: 8EdR+VC7T+WJngi1x3yjmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="67935027"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="67935027"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 05:43:22 -0700
X-CSE-ConnectionGUID: AwmRUQfkS8mQ6Q97oh0umQ==
X-CSE-MsgGUID: Ko1mJjW+QF6FrzORNVX+vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="185500706"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 31 Oct 2025 05:43:19 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEoSz-000N6m-10;
	Fri, 31 Oct 2025 12:42:55 +0000
Date: Fri, 31 Oct 2025 20:40:29 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Wu <wusamuel@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, tuhaowen@uniontech.com,
	Samuel Wu <wusamuel@google.com>,
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] PM: Support aborting sleep during filesystem sync
Message-ID: <202510312048.Ylb5GU76-lkp@intel.com>
References: <20251030210110.298612-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030210110.298612-1-wusamuel@google.com>

Hi Samuel,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.18-rc3 next-20251031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Wu/PM-Support-aborting-sleep-during-filesystem-sync/20251031-050330
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20251030210110.298612-1-wusamuel%40google.com
patch subject: [PATCH v6] PM: Support aborting sleep during filesystem sync
config: arm64-randconfig-r061-20251031 (https://download.01.org/0day-ci/archive/20251031/202510312048.Ylb5GU76-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510312048.Ylb5GU76-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510312048.Ylb5GU76-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/power/main.c: In function 'pm_init':
>> kernel/power/main.c:1159:17: error: implicit declaration of function 'pm_start_fs_sync_workqueue'; did you mean 'pm_start_workqueue'? [-Wimplicit-function-declaration]
    1159 |         error = pm_start_fs_sync_workqueue();
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 pm_start_workqueue


vim +1159 kernel/power/main.c

  1153	
  1154	static int __init pm_init(void)
  1155	{
  1156		int error = pm_start_workqueue();
  1157		if (error)
  1158			return error;
> 1159		error = pm_start_fs_sync_workqueue();
  1160		if (error)
  1161			return error;
  1162		hibernate_image_size_init();
  1163		hibernate_reserved_size_init();
  1164		pm_states_init();
  1165		power_kobj = kobject_create_and_add("power", NULL);
  1166		if (!power_kobj)
  1167			return -ENOMEM;
  1168		error = sysfs_create_groups(power_kobj, attr_groups);
  1169		if (error)
  1170			return error;
  1171		pm_print_times_init();
  1172		return pm_autosleep_init();
  1173	}
  1174	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

