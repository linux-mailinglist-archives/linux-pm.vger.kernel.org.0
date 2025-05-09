Return-Path: <linux-pm+bounces-26952-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6296AB16DC
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 16:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDC13A33FC
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 14:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932A123D2A0;
	Fri,  9 May 2025 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/l7M2+Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28BA2A8C1
	for <linux-pm@vger.kernel.org>; Fri,  9 May 2025 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799493; cv=none; b=eZ+J6rFdjooKiUS4gOjtCRE6O9K4twjbdNWEwXzqh6UysCbaNcrvFFJklxWVc79MjOhGLgxE3ULHCnJrDtKALxaSY6tQvSnDFPAInYE7zkspgLpHy4ZxTOlbmkqaW/sqDXMG7SHFwcg5Wuv6aFD3Won5WlzragEXydKoHZkJcGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799493; c=relaxed/simple;
	bh=vgZZ0cBokw9wBZvDIVBrkMp/yvPHNsYliJTfhRSfCzY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tnhMkXli5JgrxMteCA0MdUtRw1+075lK4oCtsagt2ZHlcyuymHmQ3SJzWfU7nSt61d+ccT6aH2TQ9iBLBkx0kKNn7xWVsViwjwwDengBCX80pPXvUV6u9Ic7LoDdrEs5cK4pVt0u7DBXW01HRdyL3EYh6kc6wqgVXN1ZFzmm4C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/l7M2+Z; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746799492; x=1778335492;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vgZZ0cBokw9wBZvDIVBrkMp/yvPHNsYliJTfhRSfCzY=;
  b=W/l7M2+Z19CPQNZSUxII5sTM56JVR5OsjCBU1vOTjpLvCcKYre349Lwd
   jQNK5loZVvj377WoRXK3Sb3FgLnN8DNGLckLWy51oSfFGiyW81gM7SPQY
   kQ3EXnyU1aTIpgFv+orNk1MH2UAqHl3MU4Vgsh1GU4YCBtIg8eYfbaLKw
   KN89akXdsNMSyxs079oVglNnRoPK3i3mio0fUVNQjMY84E1Wd1fZ4q1ei
   Vqqp5p5XJf/w+bzhgH82SRWBiuhFcUMOE+ExChcJS+8URiZMkucPwADtw
   YfuGnynmJjCYicw7lprhqfPq3JwfOPIc2vDokPbxKXxB0LadfRBbRJWui
   g==;
X-CSE-ConnectionGUID: VNC6TOOxSl+XwDPhBgr7Pw==
X-CSE-MsgGUID: 5Cnv/++9TAqnINuMqhCNUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59972343"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59972343"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 07:03:22 -0700
X-CSE-ConnectionGUID: C4SaQpo/RzqXtS1119Zmgg==
X-CSE-MsgGUID: AK9FnrvzQpasHCgJ5fx6Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136505681"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 09 May 2025 07:03:20 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDOJp-000C8l-2k;
	Fri, 09 May 2025 14:03:17 +0000
Date: Fri, 9 May 2025 22:02:46 +0800
From: kernel test robot <lkp@intel.com>
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>
Subject: [chanwoo:devfreq-testing 5/5]
 drivers/devfreq/hisi_uncore_freq.c:552:16: sparse: sparse: incorrect type in
 return expression (different modifiers)
Message-ID: <202505092135.WsWbEZNU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git devfreq-testing
head:   a0983893e344a836747449e1d20f5273761d39fa
commit: a0983893e344a836747449e1d20f5273761d39fa [5/5] PM / devfreq: Add HiSilicon uncore frequency scaling driver
config: nios2-randconfig-r131-20250509 (https://download.01.org/0day-ci/archive/20250509/202505092135.WsWbEZNU-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250509/202505092135.WsWbEZNU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505092135.WsWbEZNU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/devfreq/hisi_uncore_freq.c:552:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected struct cpumask * @@     got struct cpumask const * @@
   drivers/devfreq/hisi_uncore_freq.c:552:16: sparse:     expected struct cpumask *
   drivers/devfreq/hisi_uncore_freq.c:552:16: sparse:     got struct cpumask const *
   drivers/devfreq/hisi_uncore_freq.c:562:16: sparse: sparse: incorrect type in return expression (different modifiers) @@     expected struct cpumask * @@     got struct cpumask const * @@
   drivers/devfreq/hisi_uncore_freq.c:562:16: sparse:     expected struct cpumask *
   drivers/devfreq/hisi_uncore_freq.c:562:16: sparse:     got struct cpumask const *
>> drivers/devfreq/hisi_uncore_freq.c:590:1: sparse: sparse: symbol 'dev_attr_related_cpus' was not declared. Should it be static?

vim +552 drivers/devfreq/hisi_uncore_freq.c

   549	
   550	static struct cpumask *get_package_cpumask(int cpu)
   551	{
 > 552		return topology_core_cpumask(cpu);
   553	}
   554	
   555	static int get_cluster_id(int cpu)
   556	{
   557		return topology_cluster_id(cpu);
   558	}
   559	
   560	static struct cpumask *get_cluster_cpumask(int cpu)
   561	{
   562		return topology_cluster_cpumask(cpu);
   563	}
   564	
   565	static int hisi_uncore_mark_related_cpus_wrap(struct hisi_uncore_freq *uncore)
   566	{
   567		int rc;
   568	
   569		cpumask_clear(&uncore->related_cpus);
   570	
   571		rc = hisi_uncore_mark_related_cpus(uncore, "related-package",
   572						   get_package_id,
   573						   get_package_cpumask);
   574		if (rc == 0)
   575			return rc;
   576	
   577		return hisi_uncore_mark_related_cpus(uncore, "related-cluster",
   578						     get_cluster_id,
   579						     get_cluster_cpumask);
   580	}
   581	
   582	static ssize_t related_cpus_show(struct device *dev,
   583					 struct device_attribute *attr, char *buf)
   584	{
   585		struct hisi_uncore_freq *uncore = dev_get_drvdata(dev->parent);
   586	
   587		return cpumap_print_to_pagebuf(true, buf, &uncore->related_cpus);
   588	}
   589	
 > 590	DEVICE_ATTR_RO(related_cpus);
   591	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

