Return-Path: <linux-pm+bounces-27008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5153AB281E
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 14:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694BB3B953A
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 12:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED442566E8;
	Sun, 11 May 2025 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHz5zmL9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE02194AD5;
	Sun, 11 May 2025 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746965803; cv=none; b=Km3OvYuQGkS7+Spl8Jg52zKUCXK3IwzhYcILiKVZG+cvVvsgSw5wLXtSQuilXmUNX/pjCK8Xsx4XC5BqycOWXBlDYATt1iGO2IEQcky3OfPtBeRxxeWiroRQKYHMwZG9r87vlDaDTJ+XvlpJIXrp/rynpipr/RstSGKaxbstWrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746965803; c=relaxed/simple;
	bh=kyw+l1wJVeveYIBNAH1Tn2Vy7iGJtAsbUzmEZBVbWyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDyrFRqJ8tE4G+y2CLa+VeuoMUpTlJDUM/eQYcfarQh4LHoe/eFwzRM8Zf4ftdv00DpcCdWWBPvJnGx78jVpifEQOaz/fXwa59Y9UOdq5FzkvOiD6nLbu9FBwpp3Q66zJIdukZYnWljdV8Vd2Olu0UuhQiInLoWRodF1iYP7NY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHz5zmL9; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746965801; x=1778501801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kyw+l1wJVeveYIBNAH1Tn2Vy7iGJtAsbUzmEZBVbWyI=;
  b=NHz5zmL95f9xlJDnC63kQ1fPOOSNs9FhiqsmCa7E+VwGKaToLa+Ag8Qe
   wktRbubBZfmB0gNy4kicmOjSomtVpa/COk+hNp8mF6D4cQUXsYTqdjkjM
   zcnpfSPDx3qpBfhZqgu9OxAkjVXizm66B6Fttcgr7UJe1lgUtPW7zSquc
   Zjl36NT4QppepoUDpzTAdCC4sizcKy5XVYi8psYk4RZ5CGBlY0Wd861xs
   +zh5HK7bvyENDkW6XoPhpxlsvGCFeKnBZK5sfLg9oX7Rj4oFPrMgoN7fG
   w6gXK5BC6I5FKThy/0VhQSHyA3S+G0ERLy7Eehvy47B3nkU/O4XSrbjn2
   g==;
X-CSE-ConnectionGUID: Asmvh2IwRtCp1M7U47m/9Q==
X-CSE-MsgGUID: 5snTjAbTQAawtusc0Zn+MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="74151044"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="74151044"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 05:16:40 -0700
X-CSE-ConnectionGUID: u5/ngfmrQSepRT4nB89Sgw==
X-CSE-MsgGUID: /P9mnNRNRmeMn9yjtROsIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="142223787"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 11 May 2025 05:16:37 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uE5be-000Dkl-2I;
	Sun, 11 May 2025 12:16:34 +0000
Date: Sun, 11 May 2025 20:16:28 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v6 2/2] thermal: Add support for Airoha EN7581 thermal
 sensor
Message-ID: <202505112056.HaqX6Bef-lkp@intel.com>
References: <20250510172509.2547273-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510172509.2547273-2-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on linus/master v6.15-rc5 next-20250509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/thermal-Add-support-for-Airoha-EN7581-thermal-sensor/20250511-012647
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20250510172509.2547273-2-ansuelsmth%40gmail.com
patch subject: [PATCH v6 2/2] thermal: Add support for Airoha EN7581 thermal sensor
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250511/202505112056.HaqX6Bef-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250511/202505112056.HaqX6Bef-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505112056.HaqX6Bef-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/airoha_thermal.c:317:2: warning: label at end of compound statement is a C23 extension [-Wc23-extensions]
     317 |         }
         |         ^
   1 warning generated.


vim +317 drivers/thermal/airoha_thermal.c

   297	
   298	static irqreturn_t airoha_thermal_irq(int irq, void *data)
   299	{
   300		struct airoha_thermal_priv *priv = data;
   301		enum thermal_notify_event event;
   302		bool update = false;
   303		u32 status;
   304	
   305		status = readl(priv->base + EN7581_TEMPMONINTSTS);
   306		switch (status & (EN7581_HOFSINTSTS0 | EN7581_LOFSINTSTS0)) {
   307		case EN7581_HOFSINTSTS0:
   308			event = THERMAL_TRIP_VIOLATED;
   309			update = true;
   310			break;
   311		case EN7581_LOFSINTSTS0:
   312			event = THERMAL_EVENT_UNSPECIFIED;
   313			update = true;
   314			break;
   315		/* Should be impossible as we enable only these interrupt */
   316		default:
 > 317		}
   318	
   319		/* reset interrupt */
   320		writel(status, priv->base + EN7581_TEMPMONINTSTS);
   321	
   322		if (update)
   323			thermal_zone_device_update(priv->tz, event);
   324	
   325		return IRQ_HANDLED;
   326	}
   327	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

