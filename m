Return-Path: <linux-pm+bounces-40900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE65ED225FB
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 05:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0A57301E6C1
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 04:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E252C0323;
	Thu, 15 Jan 2026 04:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mmta06fk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C95029B224;
	Thu, 15 Jan 2026 04:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768452233; cv=none; b=LYAsVSg76AEi6LD0rmGXJ2QQP55bzXX+YE6kPI9XPYQWcXDJSlbysIaBwpJnnS67ryiJ5YAXo7W95/YuYS2lw2giNXPHdxwQyClGn449dxvhF/C2U/T+TR35abRgGekLBW3K8kvPtuEr/2h58xxYE4tEjreKR76GG2fw4eTkpWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768452233; c=relaxed/simple;
	bh=PU18uA2LJk51uw3aVkod2MrmRi0NGqJm2Zlpr+b2mgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVdYI3f14gkV2QRejCEHET6k3r4w6qxBnrfRr/N3+lcH09m5BiclkQsWK+KWRRut1l5lkRdY1OdJmESCtEWZGvURfDFgZc0k3OF68sW8YDWccKWN6G7ICqSHjzt/BUthfEO9DHnFoFcBJp5U06LB6I2/ZKAjfGqAQiHMztlbr24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mmta06fk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768452230; x=1799988230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PU18uA2LJk51uw3aVkod2MrmRi0NGqJm2Zlpr+b2mgI=;
  b=Mmta06fk5N5JnR0s25UxnzGsyXb8yheJ01Rkf8JINm3HRHKDVRE7WfUA
   zEGyHsR4FgU6RkxkrOBVzxP/eMXYZB5Y08hxrZA2CBqyz1GnKOtNCXSTE
   apSQOnuq3qoioBy+oQUZYdTME4ddOEjcdwVifCgbpwSYVa4UUx+D4rQOg
   TSSelCq+xyalpUBLXQc/qAGb+CJRMQOE6XBl902yxLPO8C4buGwIx1Ae4
   nbMp0bbLtwuelDlunPxDGk4GNeglWdWANLOmYVeyYNGKacPE1aJ/jQ1Qt
   B3kUZyuAUQNlEZz3tAv8F8EGQ131if+GiNH0V5B179tMH8OmILsEuy0DV
   A==;
X-CSE-ConnectionGUID: v/8hEP8IQgGfK0W/pyw2KA==
X-CSE-MsgGUID: 0QBWAK+XQnSAUkORP6CE9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="68767461"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="68767461"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 20:43:49 -0800
X-CSE-ConnectionGUID: IesX45u0Sw2DyWyX5uh/Ig==
X-CSE-MsgGUID: UZf1tsOzQpeOZpqjANL9XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="209720405"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 14 Jan 2026 20:43:46 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgFCx-00000000HYC-18v4;
	Thu, 15 Jan 2026 04:43:43 +0000
Date: Thu, 15 Jan 2026 12:43:11 +0800
From: kernel test robot <lkp@intel.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: Re: [PATCH v4 5/5] thermal: renesas: rzg3e: add support for RZ/T2H
 and RZ/N2H
Message-ID: <202601151246.oPHRcNB4-lkp@intel.com>
References: <20260108165324.11376-6-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108165324.11376-6-cosmin-gabriel.tanislav.xa@renesas.com>

Hi Cosmin,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/thermal]
[also build test ERROR on linus/master v6.19-rc5 next-20260114]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cosmin-Tanislav/thermal-renesas-rzg3e-make-min-and-max-temperature-per-chip/20260109-015424
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20260108165324.11376-6-cosmin-gabriel.tanislav.xa%40renesas.com
patch subject: [PATCH v4 5/5] thermal: renesas: rzg3e: add support for RZ/T2H and RZ/N2H
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20260115/202601151246.oPHRcNB4-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260115/202601151246.oPHRcNB4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601151246.oPHRcNB4-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/thermal/renesas/rzg3e_thermal.c: In function 'rzg3e_thermal_get_smc_trim':
>> drivers/thermal/renesas/rzg3e_thermal.c:371:30: error: storage size of 'local_res' isn't known
     371 |         struct arm_smccc_res local_res;
         |                              ^~~~~~~~~
>> drivers/thermal/renesas/rzg3e_thermal.c:373:9: error: implicit declaration of function 'arm_smccc_smc' [-Wimplicit-function-declaration]
     373 |         arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPLO,
         |         ^~~~~~~~~~~~~
>> drivers/thermal/renesas/rzg3e_thermal.c:371:30: warning: unused variable 'local_res' [-Wunused-variable]
     371 |         struct arm_smccc_res local_res;
         |                              ^~~~~~~~~


vim +371 drivers/thermal/renesas/rzg3e_thermal.c

   368	
   369	static int rzg3e_thermal_get_smc_trim(struct rzg3e_thermal_priv *priv)
   370	{
 > 371		struct arm_smccc_res local_res;
   372	
 > 373		arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPLO,
   374			      0, 0, 0, 0, 0, 0, &local_res);
   375		priv->trmval0 = local_res.a0 & TSU_CODE_MAX;
   376	
   377		arm_smccc_smc(RZ_SIP_SVC_GET_SYSTSU, OTP_TSU_REG_ADR_TEMPHI,
   378			      0, 0, 0, 0, 0, 0, &local_res);
   379		priv->trmval1 = local_res.a0 & TSU_CODE_MAX;
   380	
   381		return 0;
   382	}
   383	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

