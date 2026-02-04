Return-Path: <linux-pm+bounces-42039-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHlmK9PagmnkcwMAu9opvQ
	(envelope-from <linux-pm+bounces-42039-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 06:36:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FECAE204B
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 06:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C73C3089B36
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 05:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A551E318EEB;
	Wed,  4 Feb 2026 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8GxI8XD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CC3301486;
	Wed,  4 Feb 2026 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770183314; cv=none; b=CxH/P/AZWnC42WRyqNGheMIQd6LladFr3SVZscRgXjr9u+Cp2Y0PRt1EAxFUgTWdE9NXL7F9Vo6ceUfu/4qzWdYc5Z4/ME3cJt3BBdWeLjVPB+glGq8yT5WLiIRKICHl753kIGL8LymbWiUeOZ/FPBDpRETNXbNGA9fXYbBeL9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770183314; c=relaxed/simple;
	bh=UiA+0nIlRA9eZg6V1t1vdhmUp7Yaj6ecIYLUK5A2F+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fi5elJcBlsHR6CtMPYkTinArJGeYBt+RSGzpSjYNIxEHyKkpqYGEu4buI4yCmsjWEQ8x6dC4Gc/Dfv5GMW9iFYLbF7uxYkcgHY9UC35EKsP8aU8XMfGs6Ce76s5x+vxhFrFRgqi7DrR00+d5KlxgvVZui5BgUOy4RXxM+Tu+tfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8GxI8XD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770183314; x=1801719314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UiA+0nIlRA9eZg6V1t1vdhmUp7Yaj6ecIYLUK5A2F+U=;
  b=V8GxI8XDtGAqhImUrs+AByR5KxQ1w4dbR7NFVgUNNTLOk9qP0CXO8X0S
   unrEBMa2i8aodq9d+0cSo3wEjOa+c8YNtw/rUSRfkWdQ/Y/DFUmaQJyvS
   KZwJ8Uz6d4JK7sed7LO5x1x6ZP+pvKni6heAQFlq3Nym2fw6uZK23No09
   GFH3bSVJS9Aq6M+sFjyNWIIt18EzzX/TaiVuinuH8xY2mTFKANQmee9A7
   slMOoB1dZV1Ewcj0GahvIpXDR0h7RCMKBpUDaHMUDV5J5dYGM2sAX2zzD
   Y4/Codam/TTyqOW4LfUTZK64lpdPd94P0DM6LEKDxsuLaJ2RJzs5Lkj2u
   w==;
X-CSE-ConnectionGUID: ytQR9aXwTL2xHdgb7MIx+A==
X-CSE-MsgGUID: Qx97iOrvQU6QAlcLSk6Ddw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82475014"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="82475014"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 21:35:14 -0800
X-CSE-ConnectionGUID: GhG6b3VCQIeq3Y/x6PawtA==
X-CSE-MsgGUID: dquvDNJpRN6VUWvxIfdVGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="209447946"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 03 Feb 2026 21:35:08 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnVXc-00000000hTc-161f;
	Wed, 04 Feb 2026 05:35:04 +0000
Date: Wed, 4 Feb 2026 13:34:09 +0800
From: kernel test robot <lkp@intel.com>
To: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>,
	Amit Sunil Dhamne <amitsd@google.com>
Subject: Re: [PATCH v5 4/5] power: supply: max77759: add charger driver
Message-ID: <202602041321.6ubHpkpR-lkp@intel.com>
References: <20260203-max77759-charger-v5-4-b50395376a5f@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203-max77759-charger-v5-4-b50395376a5f@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42039-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,amitsd.google.com,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 2FECAE204B
X-Rspamd-Action: no action

Hi Amit,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8dfce8991b95d8625d0a1d2896e42f93b9d7f68d]

url:    https://github.com/intel-lab-lkp/linux/commits/Amit-Sunil-Dhamne-via-B4-Relay/dt-bindings-mfd-maxim-max77759-reference-power-supply-schema-and-add-regulator-property/20260204-065326
base:   8dfce8991b95d8625d0a1d2896e42f93b9d7f68d
patch link:    https://lore.kernel.org/r/20260203-max77759-charger-v5-4-b50395376a5f%40google.com
patch subject: [PATCH v5 4/5] power: supply: max77759: add charger driver
config: sparc-randconfig-001-20260204 (https://download.01.org/0day-ci/archive/20260204/202602041321.6ubHpkpR-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260204/202602041321.6ubHpkpR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602041321.6ubHpkpR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/power/supply/max77759_charger.c: In function 'set_fast_charge_current_limit':
>> drivers/power/supply/max77759_charger.c:301:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     int ret;
         ^~~
   drivers/power/supply/max77759_charger.c: In function 'set_float_voltage_limit':
   drivers/power/supply/max77759_charger.c:343:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     int ret;
         ^~~


vim +/ret +301 drivers/power/supply/max77759_charger.c

   295	
   296	static int set_fast_charge_current_limit(struct max77759_charger *chg,
   297						 u32 cc_max_ua)
   298	{
   299		bool found;
   300		u32 regval;
 > 301		int ret;
   302	
   303		ret = linear_range_get_selector_high(&chg_ranges[MAX77759_CHGR_RANGE_CHGCC],
   304						     cc_max_ua, &regval, &found);
   305		if (!found)
   306			return -EINVAL;
   307	
   308		return regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_02,
   309					  MAX77759_CHGR_REG_CHG_CNFG_02_CHGCC, regval);
   310	}
   311	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

