Return-Path: <linux-pm+bounces-42814-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPVmNZPDlWmTUgIAu9opvQ
	(envelope-from <linux-pm+bounces-42814-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 14:50:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F8C156D85
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 14:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34E9B301E3C1
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 13:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C91328B5D;
	Wed, 18 Feb 2026 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jEQOS/9M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F72E32862F;
	Wed, 18 Feb 2026 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771422600; cv=none; b=GSzpHug3HO1SjO1Qpgr/JYrjb60NmXTLNviah8W9Xfabifj0+TSz8Ak+HAdCCXy7qOHk3l/5t3fsSRRQtuDjhDtjvWABWvRDt1B3o7wkswE8+JJ7FMza7LgEPFv++R3P2aHSz/bqnCX1z8ATRvO47RCt8VukbIrKZvU4bNECGPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771422600; c=relaxed/simple;
	bh=W31iI7LLVILK7kkuE1ElHWcjo1PB1NNAmLYxWimCXC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvquV6Mez9HjZS0XF1M7Q6/U4d/rKsl3jlMHm+12qFFvEsnktG9eh2xgHwZ6W+OG9WV969E7VPT0WviPW8FCT531s0sv3K7E3RtPRVS4vcq27/d2fPCEAIFjxoSD5G+Ps9g1y1YcImhf+W0cjVYCVQZe2oB60ubzaGrBKc3/dYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jEQOS/9M; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771422599; x=1802958599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W31iI7LLVILK7kkuE1ElHWcjo1PB1NNAmLYxWimCXC8=;
  b=jEQOS/9MNPuaHWZ3eXRZkSf3S3Q1+dRlF8qYYjDZcFc2166vo6H8r5Mr
   6FpSb0MAAuX7xDNqwfA5hM9/L/9tDQnyM115kgF1jHe3CXzVj5iefupIt
   J7ewS1+Qj1lwU7a/iSPGDD65rBhIZLd+Ct7XRa0GXWkhXBCd7O74EEcTd
   np+TDfVdkR9jjBQE7ZggbiuVUb5rEZlnpreDQqobTC7ZaUBIxBGmkWzaI
   rxsO/9Oo5s+yV5FQYcUqUToLprg1+qXh3Mb6J0LQWEY4diQe7DDVRJDqV
   ifWsgqXQxiP3w7wXB/dtgnLCI7QlgVtRCdFr4G6/Z2YmL7ZdIaU6I7ML9
   w==;
X-CSE-ConnectionGUID: o76mS4BiSDC0nkORfIGOTA==
X-CSE-MsgGUID: BCgjWBHHSQOE3WBrCKLYiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="83120855"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="83120855"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 05:49:57 -0800
X-CSE-ConnectionGUID: ZD8PmMrXRNyK6JJMyH8kfw==
X-CSE-MsgGUID: IULIxgMpT5WculU9T9y3Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="218040471"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 18 Feb 2026 05:49:54 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vshw7-000000012Oo-1N5a;
	Wed, 18 Feb 2026 13:49:51 +0000
Date: Wed, 18 Feb 2026 21:49:38 +0800
From: kernel test robot <lkp@intel.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linusw@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, sherry.sun@nxp.com,
	driver-core@lists.linux.dev,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH v7 3/3] PCI: Add support for PCIe WAKE# interrupt
Message-ID: <202602182100.CSUJWXc8-lkp@intel.com>
References: <20260218-wakeirq_support-v7-3-0d4689830207@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218-wakeirq_support-v7-3-0d4689830207@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42814-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 76F8C156D85
X-Rspamd-Action: no action

Hi Krishna,

kernel test robot noticed the following build errors:

[auto build test ERROR on cee73b1e840c154f64ace682cb477c1ae2e29cc4]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-Chaitanya-Chundru/PM-sleep-wakeirq-Add-support-for-dedicated-shared-wake-IRQ-setup/20260218-162247
base:   cee73b1e840c154f64ace682cb477c1ae2e29cc4
patch link:    https://lore.kernel.org/r/20260218-wakeirq_support-v7-3-0d4689830207%40oss.qualcomm.com
patch subject: [PATCH v7 3/3] PCI: Add support for PCIe WAKE# interrupt
config: sparc-randconfig-001-20260218 (https://download.01.org/0day-ci/archive/20260218/202602182100.CSUJWXc8-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260218/202602182100.CSUJWXc8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602182100.CSUJWXc8-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: drivers/pci/pci.o: in function `platform_pci_configure_wake':
>> pci.c:(.text+0x5d0c): undefined reference to `pci_configure_of_wake_gpio'
   sparc64-linux-ld: drivers/pci/pci.o: in function `platform_pci_remove_wake':
>> pci.c:(.text+0x5d4c): undefined reference to `pci_remove_of_wake_gpio'
   sparc64-linux-ld: drivers/pci/endpoint/functions/pci-epf-test.o: in function `pci_epf_test_add_cfs':
   pci-epf-test.c:(.text+0xec): undefined reference to `config_group_init_type_name'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

