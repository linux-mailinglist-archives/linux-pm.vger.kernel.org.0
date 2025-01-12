Return-Path: <linux-pm+bounces-20284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D91F7A0A950
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jan 2025 13:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E416918821D0
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jan 2025 12:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE721B393D;
	Sun, 12 Jan 2025 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGp9Av4b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975491B3921;
	Sun, 12 Jan 2025 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736685845; cv=none; b=G77N74isWEwfBjTV04Xp5Wix+lNkrhPd7HrA3EqdgQgarevhj10mZP8zMopDPsTRKSQrn5nRoqv+9R4iL7tIdhojV70QbxzKN7WCVq4+NDLeRNjUag8ESoC4VzgkPIdYeeLjm7kDYRSeDoxszH7cJ6hu7IAWTTDVaT7KZHnwSZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736685845; c=relaxed/simple;
	bh=fmc3FWSJV9HURTfZRkV0j5Nkeo8ZUM5IM3jPQxX+8XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/R0XWVmTbbPc6EjsPCi39SCvBrYZvxrDWzxbH3z0iC+ComzQci6l2AhH122fsM407MDj+9J5toMA4iAquHX7hihUo3PUNuwVsPQNGL7eeo5PW7Nt8Re1wzpteoZFIYZ3XSQJ9GmRtNwnqkrj01p/AFxsTBAIzxvX2/hfJesYjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGp9Av4b; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736685844; x=1768221844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fmc3FWSJV9HURTfZRkV0j5Nkeo8ZUM5IM3jPQxX+8XA=;
  b=ZGp9Av4bAIn5DeQWiv9jJ4RAJy3+L8ebRfk8ivO6QIgCTBsM83fvNMTW
   pqJTG9sohTwZ+nC9HJ6EfM3rSNp/4XOU0RINHMQyvLl5aXU5FpY0zZnAS
   sE8YVKU0T4yyFbN/Lk24BmtppeWHUCUyPgSroTM8UnVUhYw45uw8vAUei
   0UyJabMNbCkKYmz8HVs3WYQQ/tLNbrrGcrC8ipSPxgr+sX2Z0Xhlk0EzD
   Ml7VVATRyIkfLbNCJOfVYawOhnJxHO5onCJ438Sg7rM5w4CRPIdqi8B8S
   fgsL//vCX04HZwh+EsmBfg7b3kmUbWYjGMC5BVmZDG9+N5h5cRZj33dfU
   g==;
X-CSE-ConnectionGUID: QspeWaRbRsaOOy0XeqEgJQ==
X-CSE-MsgGUID: EDOjC5c6RvCsOLNDRxNJFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="54469082"
X-IronPort-AV: E=Sophos;i="6.12,309,1728975600"; 
   d="scan'208";a="54469082"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 04:44:03 -0800
X-CSE-ConnectionGUID: 0bwufGByQBWXluj5i8aNfg==
X-CSE-MsgGUID: r57qug4hRK2G3QM5AYMeCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135060251"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 12 Jan 2025 04:44:01 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWxJu-000Lx5-2t;
	Sun, 12 Jan 2025 12:43:58 +0000
Date: Sun, 12 Jan 2025 20:43:24 +0800
From: kernel test robot <lkp@intel.com>
To: David Reaver <me@davidreaver.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, David Reaver <me@davidreaver.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] pm: Replace deprecated kmap_atomic() with
 kmap_local_page()
Message-ID: <202501122002.vD4o8M9T-lkp@intel.com>
References: <20250112015535.191527-1-me@davidreaver.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112015535.191527-1-me@davidreaver.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on amd-pstate/linux-next]
[also build test WARNING on amd-pstate/bleeding-edge linus/master v6.13-rc6 next-20250110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Reaver/pm-Replace-deprecated-kmap_atomic-with-kmap_local_page/20250112-100253
base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git linux-next
patch link:    https://lore.kernel.org/r/20250112015535.191527-1-me%40davidreaver.com
patch subject: [PATCH] pm: Replace deprecated kmap_atomic() with kmap_local_page()
config: i386-buildonly-randconfig-005-20250112 (https://download.01.org/0day-ci/archive/20250112/202501122002.vD4o8M9T-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250112/202501122002.vD4o8M9T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501122002.vD4o8M9T-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/power/snapshot.c: In function 'copy_last_highmem_page':
   kernel/power/snapshot.c:2567:23: error: implicit declaration of function 'kmap_page_local' [-Werror=implicit-function-declaration]
    2567 |                 dst = kmap_page_local(last_highmem_page);
         |                       ^~~~~~~~~~~~~~~
>> kernel/power/snapshot.c:2567:21: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    2567 |                 dst = kmap_page_local(last_highmem_page);
         |                     ^
   cc1: some warnings being treated as errors


vim +2567 kernel/power/snapshot.c

  2554	
  2555	/**
  2556	 * copy_last_highmem_page - Copy most the most recent highmem image page.
  2557	 *
  2558	 * Copy the contents of a highmem image from @buffer, where the caller of
  2559	 * snapshot_write_next() has stored them, to the right location represented by
  2560	 * @last_highmem_page .
  2561	 */
  2562	static void copy_last_highmem_page(void)
  2563	{
  2564		if (last_highmem_page) {
  2565			void *dst;
  2566	
> 2567			dst = kmap_page_local(last_highmem_page);
  2568			copy_page(dst, buffer);
  2569			kunmap_local(dst);
  2570			last_highmem_page = NULL;
  2571		}
  2572	}
  2573	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

