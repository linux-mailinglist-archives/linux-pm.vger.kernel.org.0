Return-Path: <linux-pm+bounces-27522-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAAEAC12F5
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 20:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6463B7B10A9
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 18:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8367F1A0BE0;
	Thu, 22 May 2025 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JU8sx/Cq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B7D19DF4A
	for <linux-pm@vger.kernel.org>; Thu, 22 May 2025 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747936936; cv=none; b=YzC563ojC19GjSvSLf/IcLDhqa8jIGTmMJbJvyIxivjQ7nK1w1ykltMQX9qg1kBkGRyVhvh+qw+SIyPnqd2NuMg2loieKyjs9TYFBUUGOjQ8xnOpmpe7VuIFvOwri1W6gmYd894l7Dt38+Igl4RezNlSHqx0hpIP0M7Q+RiCAYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747936936; c=relaxed/simple;
	bh=8YInPG8YQUXhwiAyU/5XR9n/i7FsVkKiowcOMR2A4As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HU38O4TqODB9t/4ePKjpYI00XrWdRL/CpLEkVZXWcTNKb2RRJ70fml7oQWM8DSybTKFocxFvhcPVXRz6xFT1BmsLHIzEIp6u+oguEWxSk8vnHAtS5+0Mi2jG7zbDL/3VvEDSFyVPwDCtiOFwEqtk/MUQeeDQihY68Eje6mk28yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JU8sx/Cq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747936935; x=1779472935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8YInPG8YQUXhwiAyU/5XR9n/i7FsVkKiowcOMR2A4As=;
  b=JU8sx/Cq/5G0XhQNR76Tj46cT03LxyApty+DSjq9Ie6c/GfCVC0IHGse
   FZnK4zP018UdNTR1sd5anXpg4LMJv86i1qvULGIMKLSQU16KWFvj1TuJ9
   hsmrLpEf6e/EehuJGHB+PvxXtkLv06It2SL/ijVMBOBWX/v2fWHh0A6Zt
   iZo9osoFPARNzZqJCufRpTs6OGNh7LEQeSrWwC3p6rOI5TuR+3P0tSfJe
   Tl2qtu8SPpR6IAq+MVSWhmIqRrV69Q/XDLoT3cYxbBjYdwrhWGgL4J1sv
   LDCDnfyBIorS57uTcMo6SNKuxgRZDIejfYLOGDnAiV4CK8L7LsBKRPB5V
   A==;
X-CSE-ConnectionGUID: OMVO/CyTQxi3waFwojwI3Q==
X-CSE-MsgGUID: VfhQLOqASJGb/bn581oUxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49231973"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="49231973"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 11:02:14 -0700
X-CSE-ConnectionGUID: dMuGG/mETuup+TqCaAbpuw==
X-CSE-MsgGUID: 6d+dJjzXQGyUDa9X7vDIEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="141236719"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 22 May 2025 11:02:13 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIAF8-000PZw-0C;
	Thu, 22 May 2025 18:02:10 +0000
Date: Fri, 23 May 2025 02:01:48 +0800
From: kernel test robot <lkp@intel.com>
To: "qiwu.chen" <qiwuchen55@gmail.com>, rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	"qiwu.chen" <qiwu.chen@transsion.com>
Subject: Re: [PATCH] cpuidle: add tracepoint for enter_s2idle flow
Message-ID: <202505230118.SHsiPbMH-lkp@intel.com>
References: <20250520030922.9505-1-qiwu.chen@transsion.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520030922.9505-1-qiwu.chen@transsion.com>

Hi qiwu.chen,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v6.15-rc7 next-20250522]
[cannot apply to daniel-lezcano/clockevents/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/qiwu-chen/cpuidle-add-tracepoint-for-enter_s2idle-flow/20250520-111031
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250520030922.9505-1-qiwu.chen%40transsion.com
patch subject: [PATCH] cpuidle: add tracepoint for enter_s2idle flow
config: x86_64-randconfig-071-20250522 (https://download.01.org/0day-ci/archive/20250523/202505230118.SHsiPbMH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250523/202505230118.SHsiPbMH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505230118.SHsiPbMH-lkp@intel.com/

All errors (new ones prefixed by >>):

>> vmlinux.o: error: objtool: enter_s2idle_proper+0x2f: call to trace_cpu_idle() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

