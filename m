Return-Path: <linux-pm+bounces-35384-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A78BA0616
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 17:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22243B4AF2
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 15:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FFF2E4266;
	Thu, 25 Sep 2025 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YI/2h8BM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056652DEA95
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814294; cv=none; b=qr8bGXl+jup+RtZLZeL5FS2x3NsdOL3wAcyL/e4kjh/bCEbUzqml/OR3DmFG6UUXIq9FJEcej/cMuGC6KfnWficGPNMJJAMLYR3UvdDbVh/vZI+O/AF67X9fgvLKHaCIs++fpcI8iyzubMkNIu2VzACFikoqJV+0g7ftlfKQl48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814294; c=relaxed/simple;
	bh=ICtwjw/cDqxlbtBd+vd9OvqVhxcoYE4gqtN8z1wBFQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tf3if9OlumGl7NqyaGckig7uVknPKsomYYaFejPLSJlEtrb/kvbfLbyy5XKA3Uvg9TDn2LnZwZWGoxlh4Zf2c+90xAgvKayz6GmPl9eYvggdiytZ7PEa8FoR8r/tDuyqUBuJVgIVG0jGXlZjotK8UQUVoFwq5Cv1yGeD28oFm5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YI/2h8BM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758814293; x=1790350293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ICtwjw/cDqxlbtBd+vd9OvqVhxcoYE4gqtN8z1wBFQU=;
  b=YI/2h8BMcGlm8VmozaY6IuJm4jW8nMsjwauKPdUWKfdMRotWnBTuXEXB
   97nbbxHqUmjZbIGU/ANJ6rvc2NKs1SX0jJcCHNxbse6oLETkMVF64eQ1L
   ctud8J+kThW1ahPexrGEgi+gm3E/+Z9OkD2Zjs+TB1OuTVqpQAhZGlCg7
   QmvC0eh+tIiXz0HPbmJgZP4zIsjN+K+H2SlEmpn8oYyUJPbsNv3oDM1BW
   TIlb7aZGzJf1t4r9iMAw0fSUZdJXHECr8urZieIil2m+zYQy57CRPw+SZ
   eNBePoTc/UnQvg67oTOGF7qpIhYNVgtNCmSMMPZyloR04HMZyyXGtuiJr
   g==;
X-CSE-ConnectionGUID: /92eD6nbTDmyBtqNzB7znQ==
X-CSE-MsgGUID: SvM8PohcT5Sp0NeftNyRGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="78572508"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="78572508"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 08:31:33 -0700
X-CSE-ConnectionGUID: FNGNocOQQHaIivuoZ7GMQQ==
X-CSE-MsgGUID: o4vhrpcgRU+NVd7QSyLGrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="214492547"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 25 Sep 2025 08:31:31 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1nwI-0005Lf-0h;
	Thu, 25 Sep 2025 15:31:23 +0000
Date: Thu, 25 Sep 2025 23:30:37 +0800
From: kernel test robot <lkp@intel.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Samuel Zhang <guoqing.zhang@amd.com>,
	amd-gfx@lists.freedesktop.org,
	"(open list:HIBERNATION (aka Software Suspend, aka swsusp))" <linux-pm@vger.kernel.org>,
	"aka swsusp)), Mario Limonciello" <superm1@kernel.org>,
	Ionut Nechita <ionut_n2001@yahoo.com>
Subject: Re: [PATCH 2/3] PM: hibernate: Add pm_hibernation_mode_is_suspend()
Message-ID: <202509252350.szp2l5YT-lkp@intel.com>
References: <20250924205211.1059571-3-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924205211.1059571-3-superm1@kernel.org>

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on amd-pstate/linux-next]
[also build test WARNING on amd-pstate/bleeding-edge linus/master v6.17-rc7 next-20250924]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello-AMD/PM-hibernate-Fix-hybrid-sleep/20250925-045432
base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git linux-next
patch link:    https://lore.kernel.org/r/20250924205211.1059571-3-superm1%40kernel.org
patch subject: [PATCH 2/3] PM: hibernate: Add pm_hibernation_mode_is_suspend()
config: i386-randconfig-004-20250925 (https://download.01.org/0day-ci/archive/20250925/202509252350.szp2l5YT-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250925/202509252350.szp2l5YT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509252350.szp2l5YT-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/power/hibernate.c: In function 'pm_hibernation_mode_is_suspend':
   kernel/power/hibernate.c:88:36: error: 'HIBERNATION_SUSPEND' undeclared (first use in this function); did you mean 'HIBERNATION_SHUTDOWN'?
      88 |         return hibernation_mode == HIBERNATION_SUSPEND;
         |                                    ^~~~~~~~~~~~~~~~~~~
         |                                    HIBERNATION_SHUTDOWN
   kernel/power/hibernate.c:88:36: note: each undeclared identifier is reported only once for each function it appears in
   kernel/power/hibernate.c: In function 'hibernate':
   kernel/power/hibernate.c:875:41: error: 'HIBERNATION_SUSPEND' undeclared (first use in this function); did you mean 'HIBERNATION_SHUTDOWN'?
     875 |                 if (hibernation_mode != HIBERNATION_SUSPEND)
         |                                         ^~~~~~~~~~~~~~~~~~~
         |                                         HIBERNATION_SHUTDOWN
   kernel/power/hibernate.c: In function 'pm_hibernation_mode_is_suspend':
>> kernel/power/hibernate.c:89:1: warning: control reaches end of non-void function [-Wreturn-type]
      89 | }
         | ^


vim +89 kernel/power/hibernate.c

    82	
    83	/**
    84	 * pm_hibernation_mode_is_suspend - Check if hibernation has been set to suspend
    85	 */
    86	bool pm_hibernation_mode_is_suspend(void)
    87	{
  > 88		return hibernation_mode == HIBERNATION_SUSPEND;
  > 89	}
    90	EXPORT_SYMBOL_GPL(pm_hibernation_mode_is_suspend);
    91	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

