Return-Path: <linux-pm+bounces-16906-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 631419BA6A4
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2024 17:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F07F1F21739
	for <lists+linux-pm@lfdr.de>; Sun,  3 Nov 2024 16:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D77187879;
	Sun,  3 Nov 2024 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqZcvEmw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6943617C234;
	Sun,  3 Nov 2024 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730651257; cv=none; b=kDUabD47rSLfeuudE/0UlqC/CduHwMEo7CwmhFWREoDHmBgtn3EiZlaXEKb/TrYCPLXZxSidkkfw1Ao2bH7aUrM0sCOfO9KDaOXcq0hauV29tIGRCItKwwmwfkabYzeY5sCL/BR5hrCdo8vPbLOm8j7m3Dgw5kqtbExx55soehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730651257; c=relaxed/simple;
	bh=GFbGjoWnh5QiJUZnY79oXxX4ZJdes3mjS6mT2FxB164=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HukwwVlUF18UJ7ltia8PmvCFHe/IU82+1vQt4DxAGbg6DibHbPc1qbh1EPfiH8ohZwOgpYUumuNjgw9Tv6anWnYDjzYMdg6Bf6xPOgCWDSgpfErhRd9qB+o+kDWdLc6EIG/aN/sjJKdGpo02KgsjMfOxga99d5yUU/6eXhp+1gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HqZcvEmw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730651256; x=1762187256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GFbGjoWnh5QiJUZnY79oXxX4ZJdes3mjS6mT2FxB164=;
  b=HqZcvEmwzTcXFGGiSaZRSDRucHGxik82MAQTgVq1vE3TiIt99rHdfBbK
   +fIWrbNbG85K2fZiQqOSv7BTadYHcNlWjA8omvOEy3NNinVPErYckAtHr
   kLEFq5SZTdseoONjjNWnDudCO1ABsoS2FwkzPgd3shvN7hrjYTBhDrZwa
   fNNtgbD+t8v4lnzoz/1j4WgJlX2mE2P26TsVAejjJQWMQhH85OOOVWbhZ
   zS4z/DUaS0OTlbTvYvHzHxahkWBHyGgoQL2zbeTh7TLfseaFpZVGHP+KE
   MxMSjPxz+BVifsKzyZ92dh2SOlgtICPmwV0ycwl8DFRxQlbEu68XMBroi
   g==;
X-CSE-ConnectionGUID: TOw3NpEoQCWHDsrqUeQaAQ==
X-CSE-MsgGUID: orvPr2KgRbGhTdE7cktLwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="55749539"
X-IronPort-AV: E=Sophos;i="6.11,255,1725346800"; 
   d="scan'208";a="55749539"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 08:27:35 -0800
X-CSE-ConnectionGUID: FFKZBkeIRp66xBgCDD4U9w==
X-CSE-MsgGUID: cZe+WybvQaSTXaQBallnqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,255,1725346800"; 
   d="scan'208";a="83111146"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 03 Nov 2024 08:27:32 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7dRq-000k4F-28;
	Sun, 03 Nov 2024 16:27:30 +0000
Date: Mon, 4 Nov 2024 00:27:04 +0800
From: kernel test robot <lkp@intel.com>
To: Vishnu Sanal T <t.v.s10123@gmail.com>, linux-pm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, trenn@suse.com, shuah@kernel.org,
	jwyatt@redhat.com, jkacur@redhat.com, linux-kernel@vger.kernel.org,
	Vishnu Sanal T <t.v.s10123@gmail.com>
Subject: Re: [PATCH v2] implement set_enabled functions on powercap.c
Message-ID: <202411040029.mXFFVJ8w-lkp@intel.com>
References: <20241030152706.179779-2-t.v.s10123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030152706.179779-2-t.v.s10123@gmail.com>

Hi Vishnu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on amd-pstate/linux-next]
[also build test WARNING on amd-pstate/bleeding-edge linus/master v6.12-rc5 next-20241101]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vishnu-Sanal-T/implement-set_enabled-functions-on-powercap-c/20241030-233021
base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git linux-next
patch link:    https://lore.kernel.org/r/20241030152706.179779-2-t.v.s10123%40gmail.com
patch subject: [PATCH v2] implement set_enabled functions on powercap.c
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241104/202411040029.mXFFVJ8w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411040029.mXFFVJ8w-lkp@intel.com/

All warnings (new ones prefixed by >>):

   lib/powercap.c: In function 'powercap_set_enabled':
>> lib/powercap.c:79:40: warning: '%s' directive writing up to 254 bytes into a region of size 253 [-Wformat-overflow=]
      79 |         sprintf(command, "echo -n %c > %s", yes_no, path);
         |                                        ^~
   ......
      95 |         return sysfs_set_enabled(path, mode);
         |                                  ~~~~   
   In function 'sysfs_set_enabled',
       inlined from 'powercap_set_enabled' at lib/powercap.c:95:9:
   lib/powercap.c:79:9: note: 'sprintf' output between 13 and 267 bytes into a destination of size 265
      79 |         sprintf(command, "echo -n %c > %s", yes_no, path);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/powercap.c: In function 'powercap_zone_set_enabled':
>> lib/powercap.c:79:40: warning: '%s' directive writing up to 254 bytes into a region of size 253 [-Wformat-overflow=]
      79 |         sprintf(command, "echo -n %c > %s", yes_no, path);
         |                                        ^~
   ......
     203 |         return sysfs_set_enabled(path, mode);
         |                                  ~~~~   
   In function 'sysfs_set_enabled',
       inlined from 'powercap_zone_set_enabled' at lib/powercap.c:203:9:
   lib/powercap.c:79:9: note: 'sprintf' output between 13 and 267 bytes into a destination of size 265
      79 |         sprintf(command, "echo -n %c > %s", yes_no, path);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

