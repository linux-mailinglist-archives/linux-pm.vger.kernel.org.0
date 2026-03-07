Return-Path: <linux-pm+bounces-43889-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2B7PLy6Gq2n/dgEAu9opvQ
	(envelope-from <linux-pm+bounces-43889-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 02:58:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1AE2298A4
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 02:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1207F3011C65
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2026 01:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868B83290B4;
	Sat,  7 Mar 2026 01:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORdCfLTY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD8C314A84;
	Sat,  7 Mar 2026 01:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772848602; cv=none; b=Ez8hJ5xVWqHduu0hCABuX4FCVKQO2g5OGbakmZDwxg11cZ9q7LShPJo8jHPoXnZ2DN7O+0bgHQpW3gBH457INU962UdGiK3FhlvvVlojJqUMEBWfZNKnKTv22O+jlsXBtZxf/ifMC5MCmYPy8L51Hd6CsSAyLpoNIJ63+AZJ0dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772848602; c=relaxed/simple;
	bh=4KkiSIkmcsUUjhDsGlgCY3FhirtVFCrYEGWFVmVmz3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGvMms4jki9th+TOt/UPMNPfpSx/z/DvtKIM8JN5BlrsNdlYHt/cQNOR9JJZWcaBy+3SGyyVSNjiVwWEKR8B22msT+rdsxlF90iqBr/QDfIv/CcX6Q+0QCjTRhIygYxKpCJDxgCaHzDUrVa+KD4JTK33yBxgcUgu/tp8McIO6os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORdCfLTY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772848596; x=1804384596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4KkiSIkmcsUUjhDsGlgCY3FhirtVFCrYEGWFVmVmz3I=;
  b=ORdCfLTYTWq8Bpmul0uGT4fYm+TdYThvGV/TYVnXr+e8aDkwRVquX1LX
   g2YT4h9osYwkZmcjypUXg4hxpJkLNPx+phzFUYf2Pyh0fDjNw6B3I8A7X
   27WrFCMDasGKeuvEf/apoyAi+c/esJWDzJM0s2Hn8iDP3xUlWpcGMBNdz
   NKwMR65DUk8Nr9X8bNzZxvvROnqd/NHo9/z89e64z/W96Vt8RVgcUHVFP
   DtpiVZSBjQvw8F+cTQyeG92m12E2csH5gfizzn2TrDzUfAPfOKBihLdm4
   vD7Td/yeA/hM8lki6SiKpwFXx9VV69XP3PBhCPT3qfSaXmHtNOAup3ALL
   Q==;
X-CSE-ConnectionGUID: vAmKVMQOTSS/K8Lk19C5iw==
X-CSE-MsgGUID: tRJij0yHQaCmR6WtG2uI+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="91347070"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="91347070"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 17:56:32 -0800
X-CSE-ConnectionGUID: fPUKtHanSNOD/eBAP3RPQQ==
X-CSE-MsgGUID: B6dacdi9RLe28YSS6XQoJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="223659731"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 06 Mar 2026 17:56:28 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vygu1-000000001aF-1UhP;
	Sat, 07 Mar 2026 01:56:25 +0000
Date: Sat, 7 Mar 2026 09:56:22 +0800
From: kernel test robot <lkp@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] mfd: Add driver for ASUS Transformer embedded
 controller
Message-ID: <202603070925.iN0ySWQA-lkp@intel.com>
References: <20260304185751.83494-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304185751.83494-3-clamor95@gmail.com>
X-Rspamd-Queue-Id: 3A1AE2298A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43889-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,agorria.com,rere.qmqm.pl];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.975];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,01.org:url,intel.com:dkim,intel.com:email,intel.com:mid,git-scm.com:url]
X-Rspamd-Action: no action

Hi Svyatoslav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on robh/for-next linus/master v7.0-rc2 next-20260305]
[cannot apply to dtor-input/next dtor-input/for-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Svyatoslav-Ryhel/dt-bindings-embedded-controller-document-ASUS-Transformer-EC/20260305-030907
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20260304185751.83494-3-clamor95%40gmail.com
patch subject: [PATCH v5 2/7] mfd: Add driver for ASUS Transformer embedded controller
config: openrisc-randconfig-r134-20260305 (https://download.01.org/0day-ci/archive/20260307/202603070925.iN0ySWQA-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603070925.iN0ySWQA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603070925.iN0ySWQA-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mfd/asus-transformer-ec.c:482:36: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *src @@     got char const [noderef] __user *buf @@
   drivers/mfd/asus-transformer-ec.c:482:36: sparse:     expected void const *src
   drivers/mfd/asus-transformer-ec.c:482:36: sparse:     got char const [noderef] __user *buf
>> drivers/mfd/asus-transformer-ec.c:476:16: sparse: sparse: dereference of noderef expression

vim +482 drivers/mfd/asus-transformer-ec.c

   467	
   468	static int dockram_write_one(struct i2c_client *client, int reg,
   469				     const char __user *buf, size_t count)
   470	{
   471		struct dockram_ec_data *priv = i2c_get_clientdata(client);
   472		int ret;
   473	
   474		if (!count || count > DOCKRAM_ENTRY_SIZE)
   475			return -EINVAL;
 > 476		if (buf[0] != count - 1)
   477			return -EINVAL;
   478	
   479		guard(mutex)(&priv->ctl_lock);
   480	
   481		priv->ctl_data[0] = (u8)count;
 > 482		memcpy(priv->ctl_data + 1, buf, count);
   483		ret = asus_dockram_write(client, reg, priv->ctl_data);
   484	
   485		return ret;
   486	}
   487	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

