Return-Path: <linux-pm+bounces-41751-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMuNCxRUfGnTLwIAu9opvQ
	(envelope-from <linux-pm+bounces-41751-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 07:47:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 793C6B7B02
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 07:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 650EE3015857
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 06:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34691288C25;
	Fri, 30 Jan 2026 06:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NSu12NcL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23B227EA8;
	Fri, 30 Jan 2026 06:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769755663; cv=none; b=PKCVzrShofKi7COi8k7+QC72mpNelj20zu9YFQQhs0MIVVwUr75EbJdU7mcTF+8gEKmPrwtZYLMNVJa17vRiEY/bY5gXAtb71aU6XXAF3RIMmCWb1zxz8s4cc68NmLiOo+eaQGCyZXeZkmiHT9oqm/40J7xJav7BZWP5/DK5Txg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769755663; c=relaxed/simple;
	bh=Iv59V8CKc0qtXos8K9LAn+rxLfb+csskkymoBjija0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKTo+vD8/L0NDn5kL0fBvIz+rSZ6rZAvmGouztjVaewz5bcp0RRqOdlB6RkLrvPrcDCpJWVpFfv6gPPKCH0dI9oQeAHh49f3g3ItG5aJ4GAKI+4KCChstVbnL/wC1g4E1xK17wxwqeSg/1WTJJU/JstX/WaMFAZ72+7TYphbeaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NSu12NcL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769755662; x=1801291662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Iv59V8CKc0qtXos8K9LAn+rxLfb+csskkymoBjija0M=;
  b=NSu12NcL1/vYlnIjTu+B6LxO0gYmroac4Ccsn9ucQNSkWF3hds7FTE5Z
   JumJ0rVo/s+ukEJM46xkU6W2W5VaFUy9t7PBkkJjUhvFJ/lSmfBT+kv53
   B699DXMpNdejIYqr9kyKBh6efrQznfPsrbh/Y2YaeRnhlnAs2mFaDuR7g
   LJ5LkvT3A3u1zr+2tlGSIyKlnZUHC+eNQG8DE1SkHLv6W4YOmDlf7EYiR
   CT34woRXf/77BpJw6cG9rKGsNswaVzKmNx+jMrdFCs9X1a1SKjNN4rmDx
   dCYJVrLdo3zkyOl57WU2NsGBtpEK0w5BfVFGZ8vpaKIJjf5Vc5Ea7aq3A
   w==;
X-CSE-ConnectionGUID: W8GkgsBeQbySdF6GKDpQDw==
X-CSE-MsgGUID: W883w8FZQ4SnqnB0Hsj1UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="81737459"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="81737459"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 22:47:41 -0800
X-CSE-ConnectionGUID: 3L9c0NKCTwiY8cJqLmo1mw==
X-CSE-MsgGUID: HJLuYA3oScWUn6tZ2Plaxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="212861100"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 29 Jan 2026 22:47:36 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vliI1-00000000cHc-3Plc;
	Fri, 30 Jan 2026 06:47:33 +0000
Date: Fri, 30 Jan 2026 14:47:16 +0800
From: kernel test robot <lkp@intel.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>, andersson@kernel.org,
	mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
	konradybcio@kernel.org, mani@kernel.org, casey.connolly@linaro.org,
	amit.kucheria@oss.qualcomm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	gaurav.kohli@oss.qualcomm.com, manaf.pallikunhi@oss.qualcomm.com
Subject: Re: [PATCH v2 1/8] thermal: Add Remote Proc cooling driver
Message-ID: <202601301416.z6Jz4P0R-lkp@intel.com>
References: <20260127155722.2797783-2-gaurav.kohli@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127155722.2797783-2-gaurav.kohli@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41751-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,git-scm.com:url,01.org:url]
X-Rspamd-Queue-Id: 793C6B7B02
X-Rspamd-Action: no action

Hi Gaurav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20260126]
[also build test WARNING on v6.19-rc7]
[cannot apply to robh/for-next rafael-pm/thermal remoteproc/rproc-next linus/master v6.19-rc7 v6.19-rc6 v6.19-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gaurav-Kohli/thermal-Add-Remote-Proc-cooling-driver/20260128-000753
base:   next-20260126
patch link:    https://lore.kernel.org/r/20260127155722.2797783-2-gaurav.kohli%40oss.qualcomm.com
patch subject: [PATCH v2 1/8] thermal: Add Remote Proc cooling driver
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20260130/202601301416.z6Jz4P0R-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260130/202601301416.z6Jz4P0R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601301416.z6Jz4P0R-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/remoteproc_cooling.c:87:1: warning: no previous prototype for function 'remoteproc_cooling_register' [-Wmissing-prototypes]
   remoteproc_cooling_register(struct device_node *np,
   ^
   drivers/thermal/remoteproc_cooling.c:86:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct remoteproc_cdev *
   ^
   static 
>> drivers/thermal/remoteproc_cooling.c:131:6: warning: no previous prototype for function 'remoteproc_cooling_unregister' [-Wmissing-prototypes]
   void remoteproc_cooling_unregister(struct remoteproc_cdev *rproc_cdev)
        ^
   drivers/thermal/remoteproc_cooling.c:131:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void remoteproc_cooling_unregister(struct remoteproc_cdev *rproc_cdev)
   ^
   static 
   2 warnings generated.


vim +/remoteproc_cooling_register +87 drivers/thermal/remoteproc_cooling.c

    85	
    86	struct remoteproc_cdev *
  > 87	remoteproc_cooling_register(struct device_node *np,
    88				    const char *name, const struct remoteproc_cooling_ops *ops,
    89				     void *devdata)
    90	{
    91		struct remoteproc_cdev *rproc_cdev;
    92		struct thermal_cooling_device *cdev;
    93		int ret;
    94	
    95		if (!name || !ops)
    96			return ERR_PTR(-EINVAL);
    97	
    98		rproc_cdev = kzalloc(sizeof(*rproc_cdev), GFP_KERNEL);
    99		if (!rproc_cdev)
   100			return ERR_PTR(-ENOMEM);
   101	
   102		rproc_cdev->ops = ops;
   103		rproc_cdev->devdata = devdata;
   104		mutex_init(&rproc_cdev->lock);
   105	
   106		char *rproc_name __free(kfree) =
   107			kasprintf(GFP_KERNEL, REMOTEPROC_PREFIX "%s", name);
   108		/* Register with thermal framework */
   109		if (np)
   110			cdev = thermal_of_cooling_device_register(np, rproc_name, rproc_cdev,
   111								  &remoteproc_cooling_ops);
   112		else
   113			cdev = thermal_cooling_device_register(rproc_name, rproc_cdev,
   114							       &remoteproc_cooling_ops);
   115	
   116		if (IS_ERR(cdev)) {
   117			ret = PTR_ERR(cdev);
   118			goto free_rproc_cdev;
   119		}
   120	
   121		rproc_cdev->cdev = cdev;
   122	
   123		return rproc_cdev;
   124	
   125	free_rproc_cdev:
   126		kfree(rproc_cdev);
   127		return ERR_PTR(ret);
   128	}
   129	EXPORT_SYMBOL_GPL(remoteproc_cooling_register);
   130	
 > 131	void remoteproc_cooling_unregister(struct remoteproc_cdev *rproc_cdev)
   132	{
   133		if (!rproc_cdev)
   134			return;
   135	
   136		thermal_cooling_device_unregister(rproc_cdev->cdev);
   137		mutex_destroy(&rproc_cdev->lock);
   138		kfree(rproc_cdev);
   139	}
   140	EXPORT_SYMBOL_GPL(remoteproc_cooling_unregister);
   141	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

