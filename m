Return-Path: <linux-pm+bounces-12853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C302E95DFCC
	for <lists+linux-pm@lfdr.de>; Sat, 24 Aug 2024 21:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6D16B21930
	for <lists+linux-pm@lfdr.de>; Sat, 24 Aug 2024 19:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21E177104;
	Sat, 24 Aug 2024 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b8rdUA6u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308247DA69;
	Sat, 24 Aug 2024 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724527757; cv=none; b=G3jTKLuiUfm/CyrM0uecBt3Cqa9Q9l/BVUczhL3L084iHPPMBKkgN7P2yg1cwk4pBDSugQIsyYIeHNXedFbuHevL86NjjZiPc7HFd39+CxXkiFiu7lzelM0Tizr+DfgN6iQNpEAx+AVWNWEQ0u44dl6LcMdsZpVLTsi3Dq1V2Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724527757; c=relaxed/simple;
	bh=wkjLLTLnzEblp1VXgf5+X03nvbMbt03oHfFqeASWXcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3WTwqLx0wGoUEv7eug6gPhZpetsQUgqR55D+S40zPgJro6az+ctm+UWYLDHSIDesikslkopZFdp17MZPc/dJ4zbevhUW6p43eG/+MH4Z3u16PSoQlfk1x8wVkmltEZVSfTB2yAhQwtfKGXk3jFrEO7kksAYqUKtJOA5p1v9KEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b8rdUA6u; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724527756; x=1756063756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wkjLLTLnzEblp1VXgf5+X03nvbMbt03oHfFqeASWXcQ=;
  b=b8rdUA6utsvKTJmzh9SYeC7G3ShJ2IIsaaKDDQazAr9CokNV2XA+jBMk
   jfpgXIOQ9+txN4IOQwhA2n7FkRKqlGLdib0ychRoDuxNnqQZFDdsGIA5h
   N1z5kYhyaXDagcsO9EIBGU09f9CqjH+edIheRrvwVq33AMkJIc0XAjObj
   hmajf24qNST7W28d/N4Het9L/d2Mbd26P7FdNlcGGTlpKxH123cFCZzLN
   8NZsA1IPdt5GtRAYY6St/P7G9Q9k3WZnuPs2vdrsvMBRJcloatQcYSW9T
   2kreTZ4GH+wQy3Toh6gHdDA2mudrB9m5O4ikxuSboB/k2a20TFfIntRo/
   g==;
X-CSE-ConnectionGUID: OCvGni+CRKGlyIgSBjfwHg==
X-CSE-MsgGUID: AncFXq6YRzmL7EP3e7ZWKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="48378983"
X-IronPort-AV: E=Sophos;i="6.10,173,1719903600"; 
   d="scan'208";a="48378983"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 12:29:15 -0700
X-CSE-ConnectionGUID: ljXF93uEQnCIkZwv3gjFxw==
X-CSE-MsgGUID: bPhL2I5pTwCywKMtrXZ/AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,173,1719903600"; 
   d="scan'208";a="61809782"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 24 Aug 2024 12:29:13 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1shwRj-000Ehr-0l;
	Sat, 24 Aug 2024 19:29:11 +0000
Date: Sun, 25 Aug 2024 03:28:44 +0800
From: kernel test robot <lkp@intel.com>
To: Yang Ruibin <11162571@vivo.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] drivers:testing:Handle possible memory leaks
Message-ID: <202408250314.w7DgoEPI-lkp@intel.com>
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
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20240825/202408250314.w7DgoEPI-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240825/202408250314.w7DgoEPI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408250314.w7DgoEPI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/thermal/testing/command.c: In function 'tt_command_process':
>> drivers/thermal/testing/command.c:153:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
     153 |         if (copy_from_user(buf, user_buf, count))
         |         ^~
   drivers/thermal/testing/command.c:155:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
     155 |                 return -EFAULT;
         |                 ^~~~~~


vim +/if +153 drivers/thermal/testing/command.c

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
7801e360656c57 Rafael J. Wysocki 2024-08-02 @153  	if (copy_from_user(buf, user_buf, count))
98706c6ade7c2e Yang Ruibin       2024-08-22  154  		kfree(buf);
7801e360656c57 Rafael J. Wysocki 2024-08-02  155  		return -EFAULT;
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

