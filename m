Return-Path: <linux-pm+bounces-43888-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xkyKMs92q2mRdQEAu9opvQ
	(envelope-from <linux-pm+bounces-43888-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 01:52:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E80922920A
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 01:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3B97300C0DE
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2026 00:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C0928642D;
	Sat,  7 Mar 2026 00:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y69B5nb+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79243272813;
	Sat,  7 Mar 2026 00:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772844746; cv=none; b=l12q+nsdeCw9PzH9+19FZlpBcsc0ix+4GrWXfxoRfG52BPGytInnLn3IVx0HERVy/+moVJrax6vT/D12BdUN8RGcs4yXjpenvr4ZhkqWCsQRoOkOtdrLX3DnmxXwHjAsHoa/qVGyzpRsb3YDlj+JckOnSabsg+eqx31wS0aempE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772844746; c=relaxed/simple;
	bh=gxSunjcvBRErBew/28rdha/zcYzd5detHG3z951c4Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHE5B+G+SypCHXnw0hqbpFODz/f5Zkr21iVhQrcw5PF8EXXgbk2SgSO5X1wfJuu5ry13bAhGgChthTbigSHxKhE3L50t48PK3ZPUvpuJkZdHovzKZwVJjZnBmTw/BDnrrwdiOcDuO1YU+0BqvMN/sg1svKjq5IF2PlG0XEiQ0yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y69B5nb+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772844744; x=1804380744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gxSunjcvBRErBew/28rdha/zcYzd5detHG3z951c4Vk=;
  b=Y69B5nb+Q/xRvQrEbTDXnMIbmHEN4+6+l8fZPvgdO2ZfLscl2bX9YmBt
   45g7eakwZ2BCFuMnDKsSEQo4X/MQ/xi5WzNOsSbHB/OgGo/+EW83mcXdO
   Ets9ufM+XozOaB5N2KauLM8ItsoTOctrroFSxDMi59WgjUmToxd9m5tXx
   fqtM9zbxkwRO+yFaTXAP1m0k86hsXCBYTqWNb+RfOZVt/nrnlA0o0ASFg
   NdPiE5KhtDW56RE5LzmUlm6K8N2LZIxDk+n9yCz6AsopqDhrCzEbj5hfJ
   0Vt19bMiCtLBExmgQ9wrj5xXO/aI4Ls+vbeEY0TRCjYNwO+7k+/voKgSw
   w==;
X-CSE-ConnectionGUID: ynHhHKJ8Q3mxFma1RrMKEg==
X-CSE-MsgGUID: 4XE1whecQMK2y1+75eLbow==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="73861669"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="73861669"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 16:52:23 -0800
X-CSE-ConnectionGUID: mDquklK+T9SW69HyvsN3Zg==
X-CSE-MsgGUID: Vmru8usbRN6VOsUsgTzISQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="216893402"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 06 Mar 2026 16:52:20 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyftx-000000001Wr-283S;
	Sat, 07 Mar 2026 00:52:17 +0000
Date: Sat, 7 Mar 2026 08:51:46 +0800
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
Message-ID: <202603070848.ib570eG8-lkp@intel.com>
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
X-Rspamd-Queue-Id: 5E80922920A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43888-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
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
config: powerpc64-randconfig-r133-20260305 (https://download.01.org/0day-ci/archive/20260307/202603070848.ib570eG8-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 9a109fbb6e184ec9bcce10615949f598f4c974a9)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603070848.ib570eG8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603070848.ib570eG8-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mfd/asus-transformer-ec.c:482:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char const [noderef] __user *buf @@
   drivers/mfd/asus-transformer-ec.c:482:9: sparse:     expected void const *
   drivers/mfd/asus-transformer-ec.c:482:9: sparse:     got char const [noderef] __user *buf
>> drivers/mfd/asus-transformer-ec.c:482:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got char const [noderef] __user *buf @@
   drivers/mfd/asus-transformer-ec.c:482:9: sparse:     expected void const *
   drivers/mfd/asus-transformer-ec.c:482:9: sparse:     got char const [noderef] __user *buf
   drivers/mfd/asus-transformer-ec.c:482:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got char const [noderef] __user *buf @@
   drivers/mfd/asus-transformer-ec.c:482:9: sparse:     expected void const *
   drivers/mfd/asus-transformer-ec.c:482:9: sparse:     got char const [noderef] __user *buf
   drivers/mfd/asus-transformer-ec.c:476:16: sparse: sparse: dereference of noderef expression

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
   476		if (buf[0] != count - 1)
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

