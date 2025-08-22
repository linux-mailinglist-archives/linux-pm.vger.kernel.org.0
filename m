Return-Path: <linux-pm+bounces-32912-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E76EB31A39
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 15:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BDDB5A0BCD
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC9A3054E5;
	Fri, 22 Aug 2025 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTdzuJvM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7883043AB;
	Fri, 22 Aug 2025 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870399; cv=none; b=kc390Y5CumW7p1xh/X87LM+q5oFFzA8HIZ1j6m++IQusOwBMMlukSbT/qHVLfcDUm6i1qMe2F0p53boO/fiWPs1ZZ2wR8uprWOjecRrEpJiBdR7TWKOFeX48M1FyYXxeZnBxCWJyq7HqbW3NyHxUvgFQicDYZgaArZLYbTnmOcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870399; c=relaxed/simple;
	bh=I7ueha+r9tVxSlgmxhcRqo50bwX+Ec9JtVfEvdOGt10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kxvkv096blqPNOgPThW8OkfvXOwx6EcXz380+UHOrBxhakJhx1sp1IlrZxYckbSRQ1nCYYDCiVDhSWleXwQG/ExCOzDs4aaTyUk1uNRvEVyj7x0L/jakLhCSIxMIZx5ZGtGeM/VmFzjSpNh1esFO7qYnUPycOhHrTWEyFOAyLO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTdzuJvM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755870397; x=1787406397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I7ueha+r9tVxSlgmxhcRqo50bwX+Ec9JtVfEvdOGt10=;
  b=DTdzuJvMHM/6ruLZKTzHAhUg5NkqiKcM5Rg6rjjfWkFrn8/5j3069N2q
   WzJ6NIftEc2H/TSgcGuL2EasPR2SRLdT0/Wc6id26OOJKy2q3nEm5DmVE
   G3qRGK4TRYB2J8h3jc/ejQAMUUUWZWdhus+32Myr5z5I8r3xie6ovk5tV
   x0eGjfeAPJbc+1Hctv8QDNtH0Jqqpr+LgjEoU0qynn7mE3sd0BYd/ct0l
   ekP+g+Tgxx+uUpX+jbHyDKyQeiqZvAy9EWHOk9MnGyoT8FWsF79ViFhRE
   og3Ew9FX5EPqSBjTm2QGB3hIOx8aBddttn/p4ESdE9n3KSsMW2uD/h9uB
   A==;
X-CSE-ConnectionGUID: bMC/YndSQO+axPdpf31bfw==
X-CSE-MsgGUID: i9dU/ETpQnC5opOGej68TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58127721"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58127721"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 06:46:34 -0700
X-CSE-ConnectionGUID: QwgNP83qSI+txb7SNHlEkQ==
X-CSE-MsgGUID: 5VsrkszkTQqlDQwFZFKWqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168614612"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 22 Aug 2025 06:46:30 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upS68-000LLP-22;
	Fri, 22 Aug 2025 13:46:28 +0000
Date: Fri, 22 Aug 2025 21:46:03 +0800
From: kernel test robot <lkp@intel.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, David Wronek <david@mainlining.org>,
	Karel Balej <balejk@matfyz.cz>, phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Subject: Re: [PATCH v2 3/4] clk: mmp: Add PXA1908 power domain driver
Message-ID: <202508222109.6oqAqWW7-lkp@intel.com>
References: <20250821-pxa1908-genpd-v2-3-eba413edd526@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-pxa1908-genpd-v2-3-eba413edd526@dujemihanovic.xyz>

Hi Duje,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9]

url:    https://github.com/intel-lab-lkp/linux/commits/Duje-Mihanovi/dt-bindings-clock-marvell-pxa1908-Add-syscon-compatible-to-apmu/20250821-192805
base:   c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
patch link:    https://lore.kernel.org/r/20250821-pxa1908-genpd-v2-3-eba413edd526%40dujemihanovic.xyz
patch subject: [PATCH v2 3/4] clk: mmp: Add PXA1908 power domain driver
config: m68k-kismet-CONFIG_PM-CONFIG_COMMON_CLK_PXA1908-0-0 (https://download.01.org/0day-ci/archive/20250822/202508222109.6oqAqWW7-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250822/202508222109.6oqAqWW7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508222109.6oqAqWW7-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PM when selected by COMMON_CLK_PXA1908
   WARNING: unmet direct dependencies detected for PM
     Depends on [n]: !MMU [=y]
     Selected by [y]:
     - COMMON_CLK_PXA1908 [=y] && COMMON_CLK [=y] && (ARCH_MMP || COMPILE_TEST [=y]) && OF [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

