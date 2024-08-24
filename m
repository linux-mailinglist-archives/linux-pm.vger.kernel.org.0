Return-Path: <linux-pm+bounces-12854-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F49895E035
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 00:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E81B1C20B7C
	for <lists+linux-pm@lfdr.de>; Sat, 24 Aug 2024 22:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A7684E18;
	Sat, 24 Aug 2024 22:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/5llR0S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3934728E0F;
	Sat, 24 Aug 2024 22:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724536941; cv=none; b=PRJ5oQL0TrqwAX9fBAAoY0L/bSOr3uofUvEsCjb6a0JBf/eFq9rp53Wtb0QUFGijNAaApwu/d7qlgDOU58Xl0wuVjzTKyL03MM1qXVdgyYR47WV0kEY2tM9f52J80poUBmpTTIbtiWjxHKKy2VgTtRY/bxPFdjctalO9DUWKZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724536941; c=relaxed/simple;
	bh=MmxaIE2PueHguE0gCbMZQWUzdtg69INhZhqLCKuzG8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfGkhCgVuTQOkdFyOHBN9p+iI9rDmDzVinfF/9ikuE1EK8tWVpwf7C+FO4xyoRfs7qz9FvYqnT+TnLAuGHFhvpPAvapIxqV1Y+Ncqh/mjqdA/XrcsAv0hswfIsLcCiXZAQGArKNVexFtWXH2JMQ7aXy08U0kj0Jy6Gs+OFwHyeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/5llR0S; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724536939; x=1756072939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MmxaIE2PueHguE0gCbMZQWUzdtg69INhZhqLCKuzG8Y=;
  b=P/5llR0S/IDw6VCuHwBFPvozS/NRmtbrY28mh7cTMswNV1k+KOvhNXkF
   Y2J8nm3pm3XOseVymrnsodFXdaplsnJtOPIwTxzu+DAK7WD+IbJv4KUxi
   tNjOzsXRv3UWBBjXkpHCdhizV8Mgld2eaPtnL9aWeTjfcR4ExypQG2+TI
   hK5dUXVnKPgoMOCR3YcHjTNbEyAiB/c+aWxZy6Q51HLxa1tuVrlEhWuQy
   xOqcq7caooc2lq0Afv76sATXt4YsQiMzJMM5XrAv9gccGLiFpVbrsE+9r
   IiYARcKuLmXTSVq50CkKNNwC4iFbukjBldyRfXy2uaOJRJ/BauwSkL57P
   w==;
X-CSE-ConnectionGUID: FOwDzxq4TQuAF4ibCC/3GQ==
X-CSE-MsgGUID: 63mHpBkjTFKQkW7kGBPyCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="45511025"
X-IronPort-AV: E=Sophos;i="6.10,174,1719903600"; 
   d="scan'208";a="45511025"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 15:02:19 -0700
X-CSE-ConnectionGUID: 4RSaj7S5Smqh6zu7TAaaBw==
X-CSE-MsgGUID: tUVB7kDTQzG/IqO6gvMc3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,174,1719903600"; 
   d="scan'208";a="61828874"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 24 Aug 2024 15:02:15 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1shypp-000ElT-1s;
	Sat, 24 Aug 2024 22:02:13 +0000
Date: Sun, 25 Aug 2024 06:01:21 +0800
From: kernel test robot <lkp@intel.com>
To: Yang Ruibin <11162571@vivo.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] drivers:testing:Handle possible memory leaks
Message-ID: <202408250520.ZWvQ82gO-lkp@intel.com>
References: <20240822032108.1223332-1-11162571@vivo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822032108.1223332-1-11162571@vivo.com>

Hi Yang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240821]
[cannot apply to rafael-pm/thermal v6.11-rc4 v6.11-rc3 v6.11-rc2 linus/master v6.11-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Ruibin/drivers-testing-Handle-possible-memory-leaks/20240822-112305
base:   next-20240821
patch link:    https://lore.kernel.org/r/20240822032108.1223332-1-11162571%40vivo.com
patch subject: [PATCH v1] drivers:testing:Handle possible memory leaks
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240825/202408250520.ZWvQ82gO-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240825/202408250520.ZWvQ82gO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408250520.ZWvQ82gO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/testing/command.c:155:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
     155 |                 return -EFAULT;
         |                 ^
   drivers/thermal/testing/command.c:153:2: note: previous statement is here
     153 |         if (copy_from_user(buf, user_buf, count))
         |         ^
   1 warning generated.


vim +/if +155 drivers/thermal/testing/command.c

7801e360656c57 Rafael J. Wysocki 2024-08-02  141  
7801e360656c57 Rafael J. Wysocki 2024-08-02  142  static ssize_t tt_command_process(struct dentry *dentry, const char __user *user_buf,
7801e360656c57 Rafael J. Wysocki 2024-08-02  143  				  size_t count)
7801e360656c57 Rafael J. Wysocki 2024-08-02  144  {
7801e360656c57 Rafael J. Wysocki 2024-08-02  145  	char *buf __free(kfree);
7801e360656c57 Rafael J. Wysocki 2024-08-02  146  	char *arg;
7801e360656c57 Rafael J. Wysocki 2024-08-02  147  	int i;
7801e360656c57 Rafael J. Wysocki 2024-08-02  148  
7801e360656c57 Rafael J. Wysocki 2024-08-02  149  	buf = kmalloc(count + 1, GFP_KERNEL);
7801e360656c57 Rafael J. Wysocki 2024-08-02  150  	if (!buf)
7801e360656c57 Rafael J. Wysocki 2024-08-02  151  		return -ENOMEM;
7801e360656c57 Rafael J. Wysocki 2024-08-02  152  
7801e360656c57 Rafael J. Wysocki 2024-08-02  153  	if (copy_from_user(buf, user_buf, count))
98706c6ade7c2e Yang Ruibin       2024-08-22  154  		kfree(buf);
7801e360656c57 Rafael J. Wysocki 2024-08-02 @155  		return -EFAULT;
7801e360656c57 Rafael J. Wysocki 2024-08-02  156  
7801e360656c57 Rafael J. Wysocki 2024-08-02  157  	buf[count] = '\0';
7801e360656c57 Rafael J. Wysocki 2024-08-02  158  	strim(buf);
7801e360656c57 Rafael J. Wysocki 2024-08-02  159  
7801e360656c57 Rafael J. Wysocki 2024-08-02  160  	arg = strstr(buf, ":");
7801e360656c57 Rafael J. Wysocki 2024-08-02  161  	if (arg) {
7801e360656c57 Rafael J. Wysocki 2024-08-02  162  		*arg = '\0';
7801e360656c57 Rafael J. Wysocki 2024-08-02  163  		arg++;
7801e360656c57 Rafael J. Wysocki 2024-08-02  164  	}
7801e360656c57 Rafael J. Wysocki 2024-08-02  165  
7801e360656c57 Rafael J. Wysocki 2024-08-02  166  	for (i = 0; i < ARRAY_SIZE(tt_command_strings); i++) {
7801e360656c57 Rafael J. Wysocki 2024-08-02  167  		if (!strcmp(buf, tt_command_strings[i]))
7801e360656c57 Rafael J. Wysocki 2024-08-02  168  			return tt_command_exec(i, arg);
7801e360656c57 Rafael J. Wysocki 2024-08-02  169  	}
7801e360656c57 Rafael J. Wysocki 2024-08-02  170  
7801e360656c57 Rafael J. Wysocki 2024-08-02  171  	return -EINVAL;
7801e360656c57 Rafael J. Wysocki 2024-08-02  172  }
7801e360656c57 Rafael J. Wysocki 2024-08-02  173  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

