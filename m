Return-Path: <linux-pm+bounces-16515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E66289B1CD3
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 10:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5310BB20D15
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 09:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6922B5674D;
	Sun, 27 Oct 2024 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFnbgBjD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AEA56742
	for <linux-pm@vger.kernel.org>; Sun, 27 Oct 2024 09:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730021826; cv=none; b=hbzXL+kmBSJEaLypsP3aNjPNyapWDvwunpoFe4ym0cdgT10UmIoh4EP+Wnuzs+FmEMTNCv1ZzJPIQUioKhO+9r4R1efmC3n/KarHVrKsPAXew//l989NxfgTCc1yU6ZKhZjMFOY8ddi4v2JJzCizFwjtZoQJCRkWZQlplCnDn5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730021826; c=relaxed/simple;
	bh=OQsDUjoTHw3sJT/mORJAthkExOHHFdnrOACKO8dfofw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vj3wG4TNZhqCm0yrICCquHggunXsDOgkAu05X/7BrzTKcl9D8jKXwtrxbecNFW78EFAv7CHLa6i30YLxzFa2DiNlGmJV1IMbYOvlPbKLF9bdj9JJhv2nY1sWA0sxv2rZOPcW+kYHz07Tw7hKlYBFm9LJvU9vPsVid891Tw6Wyzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFnbgBjD; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730021823; x=1761557823;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OQsDUjoTHw3sJT/mORJAthkExOHHFdnrOACKO8dfofw=;
  b=ZFnbgBjDVJT523SrB+PNS/H90HUFw8p1eD96snQ9ABY/8XXY9lUIKG7v
   gxQSW2IB8OqMLxpSjspyEi3MB9Ndo43lCZE2Sx0Dxjt1sEFotau8DB7u/
   mAMJHKPSGCwPHYwfCZvrOvWTo/qUTsJ8iJzQIvPb64nRvDQMrLKV+VEj0
   4a04mMRx3gvcQUW8xW8Y+TvCc5uWABljKPkW/jZmCPT9uI8sYZt5LQGr+
   RNuHTQyOsLOuM4+2kK4neZnV7KjrmbI3Ax1COFwM6QO2EdGD549yMDVGL
   DiHcfVEwNSsz4c08jJ9NHSIrq1YFhtmZpQa3fIUBMOtOIzPBfaE0qXXBJ
   g==;
X-CSE-ConnectionGUID: NfKZq/O3RuGqccYgT3yZ7g==
X-CSE-MsgGUID: Cx/TsEWURECPJ754opYkyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11237"; a="40218811"
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="40218811"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 02:37:02 -0700
X-CSE-ConnectionGUID: HVmLfnKCQU+xhl+3jf2YMQ==
X-CSE-MsgGUID: CnPJ4fuZS9SUbErVpG52Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="81657973"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 27 Oct 2024 02:37:01 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4zhi-000aas-33;
	Sun, 27 Oct 2024 09:36:58 +0000
Date: Sun, 27 Oct 2024 17:36:55 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org
Subject: [amd-pstate:superm1/multiple-platform-profile-handlers-v2 13/15]
 drivers/acpi/platform_profile.c:209:43: warning: passing argument 1 of
 'find_next_bit_wrap' makes pointer from integer without a cast
Message-ID: <202410271730.5bm4L4Nm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git superm1/multiple-platform-profile-handlers-v2
head:   cca7df72a75a655ad552ae621054784b4a41c9ac
commit: e336433fe10fc421aeece46f2d67647e0c91931b [13/15] ACPI: platform_profile: Check all profile handler to calculate next
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20241027/202410271730.5bm4L4Nm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241027/202410271730.5bm4L4Nm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410271730.5bm4L4Nm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/acpi/platform_profile.c: In function 'platform_profile_get_active':
   drivers/acpi/platform_profile.c:59:13: warning: variable 'err' set but not used [-Wunused-but-set-variable]
      59 |         int err;
         |             ^~~
   drivers/acpi/platform_profile.c: In function 'platform_profile_show':
   drivers/acpi/platform_profile.c:115:42: warning: unused variable 'handler' [-Wunused-variable]
     115 |         struct platform_profile_handler *handler;
         |                                          ^~~~~~~
   drivers/acpi/platform_profile.c: In function 'platform_profile_cycle':
>> drivers/acpi/platform_profile.c:209:43: warning: passing argument 1 of 'find_next_bit_wrap' makes pointer from integer without a cast [-Wint-conversion]
     209 |                 next = find_next_bit_wrap(choices,
         |                                           ^~~~~~~
         |                                           |
         |                                           long unsigned int
   In file included from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from drivers/acpi/platform_profile.c:5:
   include/linux/find.h:452:55: note: expected 'const long unsigned int *' but argument is of type 'long unsigned int'
     452 | unsigned long find_next_bit_wrap(const unsigned long *addr,
         |                                  ~~~~~~~~~~~~~~~~~~~~~^~~~


vim +/find_next_bit_wrap +209 drivers/acpi/platform_profile.c

    52	
    53	/* expected to be called under mutex */
    54	static int platform_profile_get_active(enum platform_profile_option *profile)
    55	{
    56		struct platform_profile_handler *handler;
    57		enum platform_profile_option active = PLATFORM_PROFILE_LAST;
    58		enum platform_profile_option active2 = PLATFORM_PROFILE_LAST;
  > 59		int err;
    60	
    61		list_for_each_entry(handler, &platform_profile_handler_list, list) {
    62			if (active == PLATFORM_PROFILE_LAST)
    63				err = handler->profile_get(handler, &active);
    64			else
    65				err = handler->profile_get(handler, &active2);
    66	
    67			if (WARN_ON(active == PLATFORM_PROFILE_LAST))
    68				return -EINVAL;
    69			if (active2 == PLATFORM_PROFILE_LAST)
    70				continue;
    71	
    72			if (active != active2) {
    73				pr_warn("Profile handlers don't agree on current profile\n");
    74				return -EINVAL;
    75			}
    76			active = active2;
    77		}
    78	
    79		/* Check that profile is valid index */
    80		if (WARN_ON((active < 0) || (active >= ARRAY_SIZE(profile_names))))
    81			return -EIO;
    82	
    83		*profile = active;
    84	
    85		return 0;
    86	}
    87	
    88	static ssize_t platform_profile_choices_show(struct device *dev,
    89						struct device_attribute *attr,
    90						char *buf)
    91	{
    92		unsigned long choices;
    93		int len = 0;
    94		int i;
    95	
    96		scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock)
    97			choices = platform_profile_get_choices();
    98	
    99		for_each_set_bit(i, &choices, PLATFORM_PROFILE_LAST) {
   100			if (len == 0)
   101				len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
   102			else
   103				len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
   104		}
   105	
   106		len += sysfs_emit_at(buf, len, "\n");
   107		return len;
   108	}
   109	
   110	static ssize_t platform_profile_show(struct device *dev,
   111						struct device_attribute *attr,
   112						char *buf)
   113	{
   114		enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
   115		struct platform_profile_handler *handler;
   116		int err;
   117	
   118		scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
   119			if (!platform_profile_is_registered())
   120				return -ENODEV;
   121			err = platform_profile_get_active(&profile);
   122			if (err)
   123				return err;
   124		}
   125	
   126		return sysfs_emit(buf, "%s\n", profile_names[profile]);
   127	}
   128	
   129	static ssize_t platform_profile_store(struct device *dev,
   130				    struct device_attribute *attr,
   131				    const char *buf, size_t count)
   132	{
   133		struct platform_profile_handler *handler;
   134		unsigned long choices;
   135		int err, i;
   136	
   137		/* Scan for a matching profile */
   138		i = sysfs_match_string(profile_names, buf);
   139		if (i < 0) {
   140			return -EINVAL;
   141		}
   142	
   143		scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
   144			if (!platform_profile_is_registered())
   145				return -ENODEV;
   146	
   147			/* Check that all handlers support this profile choice */
   148			choices = platform_profile_get_choices();
   149			if (!test_bit(i, &choices))
   150				return -EOPNOTSUPP;
   151	
   152			list_for_each_entry(handler, &platform_profile_handler_list, list) {
   153				err = handler->profile_set(handler, i);
   154				if (err) {
   155					pr_err("Failed to set profile for handler %s\n", handler->name);
   156					break;
   157				}
   158			}
   159			if (err) {
   160				list_for_each_entry_continue_reverse(handler, &platform_profile_handler_list, list) {
   161					if (handler->profile_set(handler, PLATFORM_PROFILE_BALANCED))
   162						pr_err("Failed to revert profile for handler %s\n", handler->name);
   163				}
   164				return err;
   165			}
   166		}
   167	
   168		sysfs_notify(acpi_kobj, NULL, "platform_profile");
   169		return count;
   170	}
   171	
   172	static DEVICE_ATTR_RO(platform_profile_choices);
   173	static DEVICE_ATTR_RW(platform_profile);
   174	
   175	static struct attribute *platform_profile_attrs[] = {
   176		&dev_attr_platform_profile_choices.attr,
   177		&dev_attr_platform_profile.attr,
   178		NULL
   179	};
   180	
   181	static const struct attribute_group platform_profile_group = {
   182		.attrs = platform_profile_attrs
   183	};
   184	
   185	void platform_profile_notify(void)
   186	{
   187		if (!cur_profile)
   188			return;
   189		sysfs_notify(acpi_kobj, NULL, "platform_profile");
   190	}
   191	EXPORT_SYMBOL_GPL(platform_profile_notify);
   192	
   193	
   194	int platform_profile_cycle(void)
   195	{
   196		enum platform_profile_option next = PLATFORM_PROFILE_LAST;
   197		struct platform_profile_handler *handler;
   198		enum platform_profile_option profile;
   199		unsigned long choices;
   200		int err;
   201	
   202		scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
   203			err = platform_profile_get_active(&profile);
   204			if (err)
   205				return err;
   206	
   207			choices = platform_profile_get_choices();
   208	
 > 209			next = find_next_bit_wrap(choices,
   210						  PLATFORM_PROFILE_LAST,
   211						  profile + 1);
   212	
   213			list_for_each_entry(handler, &platform_profile_handler_list, list) {
   214				err = handler->profile_set(handler, next);
   215				if (err) {
   216					pr_err("Failed to set profile for handler %s\n", handler->name);
   217					break;
   218				}
   219			}
   220			if (err) {
   221				list_for_each_entry_continue_reverse(handler, &platform_profile_handler_list, list) {
   222					err = handler->profile_set(handler, PLATFORM_PROFILE_BALANCED);
   223					if (err)
   224						pr_err("Failed to revert profile for handler %s\n", handler->name);
   225				}
   226			}
   227		}
   228	
   229		sysfs_notify(acpi_kobj, NULL, "platform_profile");
   230	
   231		return 0;
   232	}
   233	EXPORT_SYMBOL_GPL(platform_profile_cycle);
   234	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

