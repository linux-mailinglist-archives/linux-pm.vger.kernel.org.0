Return-Path: <linux-pm+bounces-41746-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ3HHFtEfGnZLgIAu9opvQ
	(envelope-from <linux-pm+bounces-41746-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 06:40:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C573DB75D1
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 06:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39C333003725
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 05:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83A437418B;
	Fri, 30 Jan 2026 05:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSn+NuRt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298AC36D4F1;
	Fri, 30 Jan 2026 05:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769751638; cv=none; b=IbHYSQxWTSaDSIOnNH98LI3nAxmmCZ1KZrcXIu6nfmHCMGUtAKed8pjcNChy4Gl/1daFs4AEvVvJZIacDuo88ggNhZ+bmPMfBwjhx6KQzI1u0uW2rpUvivoehVlUB0fgoio588psmum8I72xKkOQbax/zG+cFSkoy26QQMClFV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769751638; c=relaxed/simple;
	bh=O0yrTfM/db7ruCmnkUxHUcsXFLt25Gn8UsW4TJhHR4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSQGNFnM3ovYWYfQmQ8sknIZOq1Eda5bwYjFtnzGpaYCT96Desv0ooBxwNRMEQg8FPVEl1PYPfmGvMLkx5/C+9ol10E5+kluYt5yxmQmgGXPldo5QpSBheiJ1AhmITjACeJKNb0N6Xsdl4UzVmgHG6bCN3u1pd57sXpgGicQk5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSn+NuRt; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769751637; x=1801287637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O0yrTfM/db7ruCmnkUxHUcsXFLt25Gn8UsW4TJhHR4w=;
  b=TSn+NuRtw7KmX1SceMaZJyVUlKhfvSv8Ji5D1L6U+oRiUcGB8k34T4Jw
   Mljv/nQOPnsoavZ1s8l0Si9BoO7LahZGaNsQ5LlfBPMQwHxf66r1zo+7Y
   NE/Q1BjuRbEfRLywfhQqjOLmk67lv5RJek143Fn+L0oKKL+EC5mTG4NjP
   eMZCUAqFZWlxx+dGRrBpLjQSCf8yIEBCP/B1kB5cwWxP4qpUG+sRQ5jMr
   oAzuqmLeO0VyyLXqpRHm6IkjO8cHv3UDS35CIVeCF26K0OwhA5HDrRrLh
   X/0Ka0BIm5AFLUSWNiS8vboh9v9DiUgXQYE8xM/RVUaaGkVrdc8nNxN+Y
   w==;
X-CSE-ConnectionGUID: aX4KMcCwToa4Sk+4Pzc39Q==
X-CSE-MsgGUID: PVJbhADMSdCDEoSQ+McgKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="71037445"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="71037445"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 21:40:36 -0800
X-CSE-ConnectionGUID: zoU1rLYHTa6f8aixvlR8nw==
X-CSE-MsgGUID: a2vdqcYNQAOq6a4llo9v+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="213299494"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 29 Jan 2026 21:40:31 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlhF7-00000000cDg-0npS;
	Fri, 30 Jan 2026 05:40:29 +0000
Date: Fri, 30 Jan 2026 13:39:31 +0800
From: kernel test robot <lkp@intel.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>, andersson@kernel.org,
	mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
	konradybcio@kernel.org, mani@kernel.org, casey.connolly@linaro.org,
	amit.kucheria@oss.qualcomm.com
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, gaurav.kohli@oss.qualcomm.com,
	manaf.pallikunhi@oss.qualcomm.com
Subject: Re: [PATCH v2 1/8] thermal: Add Remote Proc cooling driver
Message-ID: <202601301354.3ERTn2SC-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41746-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,01.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C573DB75D1
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
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20260130/202601301354.3ERTn2SC-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260130/202601301354.3ERTn2SC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601301354.3ERTn2SC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/remoteproc_cooling.c:87:1: warning: no previous prototype for 'remoteproc_cooling_register' [-Wmissing-prototypes]
      87 | remoteproc_cooling_register(struct device_node *np,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/thermal/remoteproc_cooling.c:131:6: warning: no previous prototype for 'remoteproc_cooling_unregister' [-Wmissing-prototypes]
     131 | void remoteproc_cooling_unregister(struct remoteproc_cdev *rproc_cdev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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

