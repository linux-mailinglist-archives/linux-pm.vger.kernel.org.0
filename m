Return-Path: <linux-pm+bounces-19270-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9129F27C8
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 02:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015DF1885B66
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 01:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31202EAD5;
	Mon, 16 Dec 2024 01:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L3rjD+Mh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E09FBE4F;
	Mon, 16 Dec 2024 01:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734312731; cv=none; b=ZAHpOuPKvLzFHDFRow5+ZmIcr4PG4mhKW0xy1N17S4+xrglndsnuoVeeBcY0YGFSelWoLpUhTnM54B4C51hJI5e2iKRvLSPvc9TUwnh9HxQbJd4BXH0/IB180pmEIY5aCSN3JYro3/EFVHJnuLr61MaJ55GrLNG1cckelENGDok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734312731; c=relaxed/simple;
	bh=/3VDW4mHao6RpPast7zxxfBlS9SotnYce1mppF3+j9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oi58sP169lQlQ0uZsuJ6n3+HBIKVzwPo8e763VfejpajFt1UPXTZ08ngNSesv/ODWfqd8bP948K4kVxOuEC/V1kno+wJmrNYeBra8VhujL+Fa9Tl4KAxxNrD/f8U0Cnm1JsPJ3Mm0MzfVnolCn4/GcNzLb1nhJC4Shhg0f9ZWmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L3rjD+Mh; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734312729; x=1765848729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/3VDW4mHao6RpPast7zxxfBlS9SotnYce1mppF3+j9k=;
  b=L3rjD+MhNIjEfMX/+G+CufGITwGu6AxnvF/afQ63hqK6qD4VD5F0XT8q
   QQggTP/7C5QtKs1ppUC7cXQn14ia5BMfqLYWlnW2wI1uVkNN3uhxEtojQ
   IYqZIu+NHFjnjVit4K9Tp7KLYxQgFtKmtthaG5jm/lw4g4jn1sZkYjYav
   EgCm+AVlXnG4ldEoI0mKyH8OgQNmducfdyRkERhh9DcFDr4TngPiXv4PV
   NhU1JMgQHV/L5xrAagqA7Iq8qBL29CmhBu7RiDJSWn0GMD1zxHZIW0FmU
   VYg/UQX6qVdfkEIojhZrYeMtS13WSPi1rr7TmxOyHkrFhtMijFouNUlsn
   A==;
X-CSE-ConnectionGUID: vDL95XuqQ2iv3+SJp2rV7g==
X-CSE-MsgGUID: h4pWJzwORJOfT+SM+7Jgpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="45293656"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="45293656"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 17:32:08 -0800
X-CSE-ConnectionGUID: eYU38wyDQ66NIMcdlkDj7g==
X-CSE-MsgGUID: yA3LqFlIRnObOZIN+lRlYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97850166"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 15 Dec 2024 17:32:06 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMzxq-000Dw6-1j;
	Mon, 16 Dec 2024 01:32:02 +0000
Date: Mon, 16 Dec 2024 09:31:26 +0800
From: kernel test robot <lkp@intel.com>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>, x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
	peterz@infradead.org, dave.hansen@linux.intel.com,
	gautham.shenoy@amd.com, tglx@linutronix.de, len.brown@intel.com,
	artem.bityutskiy@linux.intel.com, patryk.wlazlyn@linux.intel.com
Subject: Re: [PATCH v8 3/4] intel_idle: Provide the default enter_dead()
 handler
Message-ID: <202412160941.mXBc9usk-lkp@intel.com>
References: <20241204140828.11699-4-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204140828.11699-4-patryk.wlazlyn@linux.intel.com>

Hi Patryk,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.13-rc2 next-20241213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Patryk-Wlazlyn/x86-smp-Allow-calling-mwait_play_dead-with-an-arbitrary-hint/20241204-221157
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241204140828.11699-4-patryk.wlazlyn%40linux.intel.com
patch subject: [PATCH v8 3/4] intel_idle: Provide the default enter_dead() handler
config: x86_64-randconfig-071-20241216 (https://download.01.org/0day-ci/archive/20241216/202412160941.mXBc9usk-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241216/202412160941.mXBc9usk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412160941.mXBc9usk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: acpi_processor_ffh_play_dead+0xbe: mwait_play_dead() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: intel_idle_enter_dead+0x29: mwait_play_dead() is missing a __noreturn annotation

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

