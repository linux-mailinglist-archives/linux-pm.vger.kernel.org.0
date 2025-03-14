Return-Path: <linux-pm+bounces-24018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CEDA60EC9
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 11:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D913B05E0
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 10:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0B21F418A;
	Fri, 14 Mar 2025 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fj1rTbsV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11B21F416F;
	Fri, 14 Mar 2025 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947976; cv=none; b=KoIjNkNtK9OGqY0jH5HO191UcZ0F2yGbfsxsKBzPVX/gr6yZD03ofavhxrHXP8GUhP80yo30ZW6uI0xZ+Wqrsq9nF8b7DYMF1qs7VPA/NYaPgGYNJabzathRBWUh/l1rbkHWzoIUsiBwbO7JZ6ixYwc0aBEcYEco96GAce4PBLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947976; c=relaxed/simple;
	bh=+vfTgiyYFj6cKd5S91WGxW+YTe/QnYFYKuf734yUw90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwgCByrweMRTMhmYOkrTIIsWvLTSzeOHeQB6hgcYP688pfgHBHUCxP9nil6j2QGofNah6TsRqLyTgvKKgnExb/9cibC7m3LbadeSdSqJi1Pk5cyYj22ZsGhC0BKxVcRR4OlVxdlutnNnVTFGUAso31GHcR8lqFeZQweLMVel/ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fj1rTbsV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741947974; x=1773483974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+vfTgiyYFj6cKd5S91WGxW+YTe/QnYFYKuf734yUw90=;
  b=Fj1rTbsVK2pRf5daxtcEvSkZMK2fpEENit6wuIQJ37wRN9E8hHtb/RaE
   B9PBlba6B6ovDWhNH8hV+19pIF6gKqi1K7UEdMmPlS4XG9HcHYeQkZ7Tt
   s9DKUjI+lfy5o5excJwk8DFePQAW4HMWN8pCvUf9KDDnQGQGV9yTSZTfN
   men4lEWn3hk38EYYMN686QzKN870UZ6kiT/swtWTLC0RQAINglQA2ryfk
   3ZUyEImisu2HIppTVVPIC5gLo8DmD2+eeXpYKBwMNpR9oVUzAIQqfZdCn
   KninNeDvit3W8r87MVoiwgSTfP5DeVZuF3PI40h1oOlex+JeamVE6qjNi
   g==;
X-CSE-ConnectionGUID: 5sStalGESwyDxj1wijQzsQ==
X-CSE-MsgGUID: J9vrR9PnS+O5yWbJK9rcAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="60633562"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="60633562"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 03:26:14 -0700
X-CSE-ConnectionGUID: BLIWjnd1TE+RDaPWBBaW9w==
X-CSE-MsgGUID: y3J9GLc1TSyDY43H3pg9tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="158381008"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 14 Mar 2025 03:26:10 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tt2Ey-000AL0-1D;
	Fri, 14 Mar 2025 10:26:08 +0000
Date: Fri, 14 Mar 2025 18:26:03 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v5 6/7] regulator: set Power State Change Reason before
 hw_protection_shutdown()
Message-ID: <202503141835.M6AeKZTU-lkp@intel.com>
References: <20250310103732.423542-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310103732.423542-7-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build errors:

[auto build test ERROR on sre-power-supply/for-next]
[also build test ERROR on broonie-regulator/for-next rafael-pm/thermal linus/master v6.14-rc6]
[cannot apply to next-20250314]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/power-Extend-power_on_reason-h-for-upcoming-PSCRR-framework/20250310-184319
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
patch link:    https://lore.kernel.org/r/20250310103732.423542-7-o.rempel%40pengutronix.de
patch subject: [PATCH v5 6/7] regulator: set Power State Change Reason before hw_protection_shutdown()
config: powerpc64-randconfig-r122-20250314 (https://download.01.org/0day-ci/archive/20250314/202503141835.M6AeKZTU-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250314/202503141835.M6AeKZTU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503141835.M6AeKZTU-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc64-linux-ld: warning: discarding dynamic section .glink
   powerpc64-linux-ld: warning: discarding dynamic section .plt
   powerpc64-linux-ld: linkage table error against `set_power_state_change_reason'
   powerpc64-linux-ld: stubs don't match calculated size
   powerpc64-linux-ld: can not build stubs: bad value
   powerpc64-linux-ld: drivers/regulator/core.o: in function `.regulator_notifier_call_chain':
>> core.c:(.text+0xc55c): undefined reference to `.set_power_state_change_reason'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

