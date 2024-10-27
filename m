Return-Path: <linux-pm+bounces-16512-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949969B1C79
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 09:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F79281EFD
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 08:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDDA28382;
	Sun, 27 Oct 2024 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uhnrjmlk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD3FF4FA
	for <linux-pm@vger.kernel.org>; Sun, 27 Oct 2024 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730016962; cv=none; b=SM6DZvlQhtPw0aMtUsoj+QoJaKqPDPFOKcwWOYke93jcoRclaNHdM0NJNxASNOeoWkiRMSR1Oo0SnRjLiAW9JICF+Xd/MFmu5EDy5lJntbImDQB0ZHHJbdbkmIGQbCm/zpZZwJONkMyqQHsgyHurluTS0O6IhstRuROiWIgY8D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730016962; c=relaxed/simple;
	bh=msPchU1wkC7C4xcn9CKpb3rP/qhM778iv3m9ZN2QmIM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fDN4vlt9khKcwEYsmzo4YB/xz118nzibHSj210NFa19tn/rv9torFjg9NV3s0c8cBc16qGfxHnhSA26r/toYMV5B3cHbRZjEJnOfVpNE4/H4ydcxHm3YFqmiEhQAwd6Dmm8Zf3aYclwoj830SrJTJUKtI1O8Gmxa6dAORMJJfAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uhnrjmlk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730016960; x=1761552960;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=msPchU1wkC7C4xcn9CKpb3rP/qhM778iv3m9ZN2QmIM=;
  b=UhnrjmlksZMULY2rABmB67BaWAae3mgeyY2OCIlenbB2eMwAj5kucb8x
   CQR96dJyENIkSuN49m8wnm5Ji4VcPLojP4Ww/Iez3UjVRgdP0A+BIuC51
   gqvJn9X2qZwhH9gCbWwApQxPkYzYMXEHYQVerB5Qgyt/HtsCDWQ+r9sAX
   0wemwEiPCje+HAYFVM4rXN+G6NHAQc2PquzxOQfCdZmD+JLi8uXFWMfT8
   hf4z66u0dHK57Agl2XhDKUEu8/3Qzp6UBEILwe4H4ZGQz2QyKSnYPh1A0
   8iVk4yxOAzdmgPu7uw3a+wwHzeS1I/TnODVTHUL7voepzjXL5Ak6rpUly
   g==;
X-CSE-ConnectionGUID: A547951lQZy8w3/pXKHpdw==
X-CSE-MsgGUID: peze/3nNRtW37rVvzHukqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11237"; a="55044419"
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="55044419"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 01:16:00 -0700
X-CSE-ConnectionGUID: oKANRZioTnWILPULiGHpUQ==
X-CSE-MsgGUID: +HdFOjRYRdmuUmjwj7dXNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="81359490"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 27 Oct 2024 01:15:58 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4yRI-000aWG-0u;
	Sun, 27 Oct 2024 08:15:56 +0000
Date: Sun, 27 Oct 2024 16:14:59 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org
Subject: [amd-pstate:superm1/multiple-platform-profile-handlers-v2 12/15]
 drivers/acpi/platform_profile.c:59:13: warning: variable 'err' set but not
 used
Message-ID: <202410271644.Rn7NUjO7-lkp@intel.com>
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
commit: 543be2020cab67a5411906c96ce670b2f2ac3dab [12/15] ACPI: platform_profile: Make sure all profile handlers agree on profile
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20241027/202410271644.Rn7NUjO7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241027/202410271644.Rn7NUjO7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410271644.Rn7NUjO7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/acpi/platform_profile.c: In function 'platform_profile_get_active':
>> drivers/acpi/platform_profile.c:59:13: warning: variable 'err' set but not used [-Wunused-but-set-variable]
      59 |         int err;
         |             ^~~
   drivers/acpi/platform_profile.c: In function 'platform_profile_show':
>> drivers/acpi/platform_profile.c:115:42: warning: unused variable 'handler' [-Wunused-variable]
     115 |         struct platform_profile_handler *handler;
         |                                          ^~~~~~~


vim +/err +59 drivers/acpi/platform_profile.c

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
 > 115		struct platform_profile_handler *handler;
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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

