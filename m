Return-Path: <linux-pm+bounces-27438-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8986EABE808
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 01:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1F93AAA79
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 23:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC1325C818;
	Tue, 20 May 2025 23:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ClOe1A1U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C05255F2C
	for <linux-pm@vger.kernel.org>; Tue, 20 May 2025 23:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747783731; cv=none; b=Ebj0+Z3HvggMAih9MYhsuD5YY3g4PMRibRVpf9Gk1b8r88x+3KGl+fayNVRn7cjxHPfi3DwMHgNoE/GR8vT1ydNFt48u1vSSZG1dXlnT9K7IqVd01FeTOFdgMvfRBOJTTA2f5yzqbySV0S2NIb0ZlNFGKQYZt/UqL2coo6kJN2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747783731; c=relaxed/simple;
	bh=NTysIJ+F5qZbKDc+/yLytQbpCooGh1tcjCfLIjNCteY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzb+0FWKqj01A7SoqvQnOu8EhaPiwy9xV+0xR/pp2Sd0rlel4pYIWlXpkazNPtIovNg8/vV9Xd2uqOd0k166KAo66yAE2gzIzM7B8eHQ3RP9PbQHfjb0GvjAXrV7gWls5RuSaUR8nZChq4VmBOk74h1wXiKTwZPYpSeVWMUjAvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ClOe1A1U; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747783729; x=1779319729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NTysIJ+F5qZbKDc+/yLytQbpCooGh1tcjCfLIjNCteY=;
  b=ClOe1A1UiGmlilPGBuGb5eV8yTj1GsuE0TDo+US0gCCJFHdFVBN968yW
   Ia6vmBdang10NEGpVTWlxt9yln2ZsCEs1Zw/ZeQHNBgsRzW75Mbjn4FKk
   m0z5XJ+EEPRxRcKOV8DaC/nlEYffqAwLvEIVYwmQtc9KCYbzEB4/Qfc8H
   sIP5oYvGqP+dCZWyBr7VLd9be3HSrUbZjztvCi32cH5wAeffhWiyirG/h
   w4TyFGkanx48EkkCCne7qzhyWwA4BBGbAnVYEZ7VNwWHPxhdlDC/lMdUN
   1j3wB/Nz24DkVhPmShXZRDy1dceBQ7SFKv5xQPk3DZVJ62K76jJE1hKpv
   A==;
X-CSE-ConnectionGUID: 8F3zkq4iSWCnfnbOt4x9bw==
X-CSE-MsgGUID: LGZ2RYhzT0KaExglNLsfQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="75141581"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="75141581"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 16:28:48 -0700
X-CSE-ConnectionGUID: Y5qi0L6BSdevdaW0kU8kzA==
X-CSE-MsgGUID: qHR8R5FaQKeR8+8Nc90uPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="140777402"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 20 May 2025 16:28:46 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHWO3-000Nfc-2t;
	Tue, 20 May 2025 23:28:43 +0000
Date: Wed, 21 May 2025 07:27:45 +0800
From: kernel test robot <lkp@intel.com>
To: "qiwu.chen" <qiwuchen55@gmail.com>, rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pm@vger.kernel.org, "qiwu.chen" <qiwu.chen@transsion.com>
Subject: Re: [PATCH] cpuidle: add tracepoint for enter_s2idle flow
Message-ID: <202505210727.H0ZDt9ng-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v6.15-rc7 next-20250516]
[cannot apply to daniel-lezcano/clockevents/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/qiwu-chen/cpuidle-add-tracepoint-for-enter_s2idle-flow/20250520-111031
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250520030922.9505-1-qiwu.chen%40transsion.com
patch subject: [PATCH] cpuidle: add tracepoint for enter_s2idle flow
config: x86_64-randconfig-075-20250521 (https://download.01.org/0day-ci/archive/20250521/202505210727.H0ZDt9ng-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250521/202505210727.H0ZDt9ng-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505210727.H0ZDt9ng-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: enter_s2idle_proper+0x34: call to trace_cpu_idle() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

