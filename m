Return-Path: <linux-pm+bounces-41438-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGTINY11dmnHQwEAu9opvQ
	(envelope-from <linux-pm+bounces-41438-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 20:57:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2507C82476
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 20:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1AB730036EC
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 19:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589772FF643;
	Sun, 25 Jan 2026 19:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+q73UM9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798D62FF17A;
	Sun, 25 Jan 2026 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769371018; cv=none; b=jlPkqcF0/5O/RyfdMqKITfEmurKvJ0kEEXFZZnvNgwkY5BjPxQG6gKbXoiKHSSdph0fVYk7IpVVOqkcknigVHUMnUw0weBTohXT+e0baQlYXK8PCtL0I6eX2AIvUqhZib4Nzo+P+L06dGioK6pu2ayAp2m6MH+Pu3HamaSooGPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769371018; c=relaxed/simple;
	bh=qTKxnEAJp/Ki0VGMVmpt0zh+HCdIB1MFyEaQiBTjsxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+99pRn34Eo2jmKKq8+sRWPFvAqCedmQOLIXidDtu6UQEe2ehffRK1bNsmuvSd182jTbr4CjX+SE1HRVzgWtTyPB7ZAPw28nNwk90/Xwj1vjO8CAChLG8g2xu+khx8R1m3WxB02fuHRtZkB2i9jSxgcNs/BBfasIwp8JRzSgJFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+q73UM9; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769371017; x=1800907017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qTKxnEAJp/Ki0VGMVmpt0zh+HCdIB1MFyEaQiBTjsxg=;
  b=M+q73UM9YwX4PFXdXOkWFuVDqhoc1hn+1vqjgYQIE9pRvnxb5XzkApKI
   JihXOgarY/hOBORl+1LV7VRc72Fb0M0So19A0zqvWgqIZ/3ZyXq0i01fU
   sxJiOKWrt7c8icCD/e9WmjbVlAk5XJ9oqmb7yjU3kajpO1q/KWF7388iL
   P1VmE4ryFy2MxD3Hn5fpei/rckA2K93Fi864E/tRU28uaBfoW0DfIfXda
   xuO3dSYHOVxq4w0SbOF5sr/KSaDEJnygml2YB0aa9PbqZn/qYqwje0a3d
   A4iS3tfiY6QhAnyy8lU7goSr+WtFndN10RWRQYeT6dMU86dlys8/evwXl
   g==;
X-CSE-ConnectionGUID: 1I+D4FgST9mtVeTefmJIcQ==
X-CSE-MsgGUID: rSaVVg6iRhG0EUd7KDZbfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="70601010"
X-IronPort-AV: E=Sophos;i="6.21,253,1763452800"; 
   d="scan'208";a="70601010"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2026 11:56:56 -0800
X-CSE-ConnectionGUID: BvjibUp4RkOnR7Ek7NSQDQ==
X-CSE-MsgGUID: D0xhRt44Qv2cUqSn23xRjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,253,1763452800"; 
   d="scan'208";a="207564226"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 25 Jan 2026 11:56:52 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vk6E5-00000000Wba-1WlU;
	Sun, 25 Jan 2026 19:56:49 +0000
Date: Mon, 26 Jan 2026 03:56:05 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
	Lee Jones <lee@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Michael Reeves <michael.reeves077@gmail.com>,
	Hector Martin <marcan@marcan.st>, Joey Gouly <joey.gouly@arm.com>
Subject: Re: [PATCH v5 1/2] power: supply: Add macsmc-power driver for Apple
 Silicon
Message-ID: <202601260326.ZuabPAK0-lkp@intel.com>
References: <20260126-b4-macsmc-power-v5-1-302462673b18@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-b4-macsmc-power-v5-1-302462673b18@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,lists.infradead.org,gmail.com,marcan.st,arm.com];
	TAGGED_FROM(0.00)[bounces-41438-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,michael.reeves077.gmail.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2507C82476
X-Rspamd-Action: no action

Hi Michael,

kernel test robot noticed the following build errors:

[auto build test ERROR on ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Reeves-via-B4-Relay/power-supply-Add-macsmc-power-driver-for-Apple-Silicon/20260125-211800
base:   ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea
patch link:    https://lore.kernel.org/r/20260126-b4-macsmc-power-v5-1-302462673b18%40gmail.com
patch subject: [PATCH v5 1/2] power: supply: Add macsmc-power driver for Apple Silicon
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20260126/202601260326.ZuabPAK0-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260126/202601260326.ZuabPAK0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601260326.ZuabPAK0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/power/supply/macsmc-power.c:559:3: error: call to undeclared function 'emergency_sync'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     559 |                 emergency_sync();
         |                 ^
   1 error generated.


vim +/emergency_sync +559 drivers/power/supply/macsmc-power.c

   531	
   532	static void macsmc_power_critical_work(struct work_struct *wrk)
   533	{
   534		struct macsmc_power *power = container_of(wrk, struct macsmc_power, critical_work);
   535		u16 bitv, b0av;
   536		u32 bcf0;
   537	
   538		if (!power->batt)
   539			return;
   540	
   541		/*
   542		 * Avoid duplicate atempts at emergency shutdown
   543		 */
   544		if (power->emergency_shutdown_triggered || system_state > SYSTEM_RUNNING)
   545			return;
   546	
   547		/*
   548		 * EMERGENCY: Check voltage vs design minimum.
   549		 * If we are below BITV, the battery is physically exhausted.
   550		 * We must shut down NOW to protect the filesystem.
   551		 */
   552		if (apple_smc_read_u16(power->smc, SMC_KEY(BITV), &bitv) >= 0 &&
   553		    apple_smc_read_u16(power->smc, SMC_KEY(B0AV), &b0av) >= 0 &&
   554		    b0av < bitv) {
   555			power->emergency_shutdown_triggered = true;
   556			dev_emerg(power->dev,
   557				  "Battery voltage (%d mV) below design minimum (%d mV)! Emergency shutdown.\n",
   558				  b0av, bitv);
 > 559			emergency_sync();
   560			kernel_power_off();
   561		}
   562	
   563		/*
   564		 * Avoid duplicate attempts at orderly shutdown.
   565		 * Voltage check is above this as we may want to
   566		 * "upgrade" an orderly shutdown to a critical power
   567		 * off if voltage drops.
   568		 */
   569		if (power->orderly_shutdown_triggered || system_state > SYSTEM_RUNNING)
   570			return;
   571	
   572		/*
   573		 * Check if SMC flagged the battery as empty.
   574		 * We trigger a graceful shutdown to let the OS save data.
   575		 */
   576		if (apple_smc_read_u32(power->smc, SMC_KEY(BCF0), &bcf0) == 0 && bcf0 != 0) {
   577			power->orderly_shutdown_triggered = true;
   578			dev_crit(power->dev, "Battery critical (empty flag set). Triggering orderly shutdown.\n");
   579			orderly_poweroff(true);
   580		}
   581	}
   582	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

