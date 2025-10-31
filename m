Return-Path: <linux-pm+bounces-37180-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D37C25014
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 13:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21B85350D5A
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 12:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7261D2DC78B;
	Fri, 31 Oct 2025 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f7SbTAvU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0D41B142D;
	Fri, 31 Oct 2025 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913854; cv=none; b=Na57PyCDpAMEeoctr2fSNhROrZN92NLIsh0PA+kejwdfwtnPHGL/xKNoPAs+gV7PskOZSxjpAqQ4Gf/Jb1tGhNQZtU0D4su2VeV9XrYmzpViUkjAJk5ikAAiH29AfQ0/10vWV+tsZP/xLORjwb3P4A+zRAcgoGUJFBRoFjwZheY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913854; c=relaxed/simple;
	bh=EKUBekgrM5YHzOr1CYFWpexPh2n9tyOsa3c5XVlztVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyRf7GMhuLdQor/fk6nNKJIIxTqPG0NICWs+cPU+IIO8FjmT4qUl45k1hTrCm0YKOxDkQR1sTMvxWolI3FiKe2B1nYd1SJgUAvsAdzmlH/Yc1G3pv2jr0G29gtOhjhNlaNoX3V78cVdjloDeH9oGi0o3XgN7fAKPEy7idASJnCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f7SbTAvU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761913852; x=1793449852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EKUBekgrM5YHzOr1CYFWpexPh2n9tyOsa3c5XVlztVs=;
  b=f7SbTAvUUW1VK17EL9ske+KKNwt15/n+fWtafxwnHw6pCGgIYVBF7eof
   9kiW+GEhC9EvCNdqCjdQeqYifIk6znlnPp3qBdtXBzTKy+skTQejQVKMn
   UKnTPs4VMqAPV22tfsYzoyjD5qSEX8MdAxDW5U8FbowBdQfQgXOnhPcUk
   g74egpKML2ejMljzOoFL9CpppfJWfRkMLp0FGCKLrYkuBYVY3fTn2k1Ze
   BRzHFy+4lZ0daFZ/QdFHczvt+EiS1yOz5g3BIBkHtRdXnJA1LQGbJpSFy
   ZQUAiDYFlheQQZbGkm+9K1i4Zr6Z0UnhKzFyM85YZzBnVxTW7p5aijg7W
   A==;
X-CSE-ConnectionGUID: 2dPckrK1QaKdg8VQJ0zouQ==
X-CSE-MsgGUID: NraQ9150QUSdjnqGjRX4Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64224877"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="64224877"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 05:30:52 -0700
X-CSE-ConnectionGUID: XmVY6QafQyWfspjt3dEkwQ==
X-CSE-MsgGUID: YLrRAJLMSxe/Mv9d4uWDQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="185498784"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 31 Oct 2025 05:30:49 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEoHH-000N64-0O;
	Fri, 31 Oct 2025 12:30:47 +0000
Date: Fri, 31 Oct 2025 20:29:46 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Wu <wusamuel@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	tuhaowen@uniontech.com, Samuel Wu <wusamuel@google.com>,
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] PM: Support aborting sleep during filesystem sync
Message-ID: <202510312012.eHtS316T-lkp@intel.com>
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
config: sparc64-randconfig-002-20251031 (https://download.01.org/0day-ci/archive/20251031/202510312012.eHtS316T-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d1c086e82af239b245fe8d7832f2753436634990)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251031/202510312012.eHtS316T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510312012.eHtS316T-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/power/main.c:1159:10: error: call to undeclared function 'pm_start_fs_sync_workqueue'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1159 |         error = pm_start_fs_sync_workqueue();
         |                 ^
   kernel/power/main.c:1159:10: note: did you mean 'pm_start_workqueue'?
   kernel/power/main.c:1147:19: note: 'pm_start_workqueue' declared here
    1147 | static int __init pm_start_workqueue(void)
         |                   ^
    1148 | {
    1149 |         pm_wq = alloc_workqueue("pm", WQ_FREEZABLE | WQ_UNBOUND, 0);
    1150 | 
    1151 |         return pm_wq ? 0 : -ENOMEM;
    1152 | }
    1153 | 
    1154 | static int __init pm_init(void)
    1155 | {
    1156 |         int error = pm_start_workqueue();
    1157 |         if (error)
    1158 |                 return error;
    1159 |         error = pm_start_fs_sync_workqueue();
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 pm_start_workqueue
   1 error generated.


vim +/pm_start_fs_sync_workqueue +1159 kernel/power/main.c

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

