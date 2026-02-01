Return-Path: <linux-pm+bounces-41869-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG7IB8yTf2lotwIAu9opvQ
	(envelope-from <linux-pm+bounces-41869-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 18:56:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A9BC6D7C
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 18:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89663300575E
	for <lists+linux-pm@lfdr.de>; Sun,  1 Feb 2026 17:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF73E28314B;
	Sun,  1 Feb 2026 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0navjts"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EB225A2A2;
	Sun,  1 Feb 2026 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968324; cv=none; b=HxHwKyfZXtkH7/nPg4X1FcBlq/8HMY9tJyN7OGGcVHnc296VFY8MtrLKa3tCuq2A/FdeaaCo2eqOpxhMXF8qnG5zTuGQxKvHhGXJWxCgh6f6rPJQv4xgla6FdJ9D4QAAiPLtCeRv6zo3eFUeHSTtpj8pJ7AXr8D4vIbPN6x0oYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968324; c=relaxed/simple;
	bh=+zy0U9CiYJerbX7S6lXZW2jwjnAUHBjyaitfDInMJIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/nsZYpKmU50JIT1QzdsLzYOTRsnGOSiUZmnOKsDC2ojOCIP30AEm3MOPtkm4Nvls/beOH3XrB6AyYrR/7iw2sp/6mXhNerukYHsDW+2L4Dzi7SmDxKXlYs+9L2cmUQ5/5ozGxWQikVROi+4ZN9JrlZp3SMKgIHVyh/ZHshiuDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0navjts; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769968323; x=1801504323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+zy0U9CiYJerbX7S6lXZW2jwjnAUHBjyaitfDInMJIA=;
  b=B0navjtsbdyg1r6imwh/Fc/soODilBDlXJvX7FDUqCzLC094BP7dgvyw
   4m8y1kl3rHUdvEO2ekqYP222oRFRT/rtaf5bqR3MHtVtYjsHyujJFgk61
   SuXe/tn2hHp1JKOz/MFHcQPt0vAxmUcnlEydahniNYLTVhVzo7vTZSIpj
   6Rh4eeoGlZB//Rc14IIlm1+E4gXkhiZcaCFBJUBpoep5tGcfNku2x0zUD
   Y2hd/HilfvK///PybvQ5j2e0kbKwR40+fGHlq1Ax56o0OuX8G6sUHrI+5
   zvp3W6jRgQ6B+zHrcX3/PdHnZ+HGx69leZcl+wmYiuEVZUvZqyeH1c9Te
   g==;
X-CSE-ConnectionGUID: 4AY+UJBgT3yPIqYyCAd/Wg==
X-CSE-MsgGUID: aPAqd+5HSAiAmQpos/Or0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="88562911"
X-IronPort-AV: E=Sophos;i="6.21,267,1763452800"; 
   d="scan'208";a="88562911"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2026 09:52:02 -0800
X-CSE-ConnectionGUID: NGHr3KN9SCGybh4CgVEzAw==
X-CSE-MsgGUID: huMXg5OoRkGKkfxDLCkMCg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 01 Feb 2026 09:51:59 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vmbc4-00000000euW-02pI;
	Sun, 01 Feb 2026 17:51:56 +0000
Date: Mon, 2 Feb 2026 01:51:13 +0800
From: kernel test robot <lkp@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Ion Agorria <ion@agorria.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 4/9] mfd: Add driver for Asus Transformer embedded
 controller
Message-ID: <202602020110.y4aJbWNb-lkp@intel.com>
References: <20260201104343.79231-5-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201104343.79231-5-clamor95@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-41869-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,arndb.de,linuxfoundation.org,rere.qmqm.pl,agorria.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url,git-scm.com:url]
X-Rspamd-Queue-Id: B1A9BC6D7C
X-Rspamd-Action: no action

Hi Svyatoslav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20260130]
[also build test WARNING on linus/master v6.19-rc7]
[cannot apply to lee-mfd/for-mfd-next lee-mfd/for-mfd-fixes dtor-input/next dtor-input/for-linus sre-power-supply/for-next v6.19-rc7 v6.19-rc6 v6.19-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Svyatoslav-Ryhel/dt-bindings-misc-document-ASUS-Transformers-EC-Dockram/20260201-184740
base:   next-20260130
patch link:    https://lore.kernel.org/r/20260201104343.79231-5-clamor95%40gmail.com
patch subject: [PATCH v1 4/9] mfd: Add driver for Asus Transformer embedded controller
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260202/202602020110.y4aJbWNb-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260202/202602020110.y4aJbWNb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602020110.y4aJbWNb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mfd/asus-ec.c:107:40: warning: field width should have type 'int', but argument has type 'unsigned long' [-Wformat]
     107 |         dev_dbg(&priv->self->dev, "EC read: %*ph, ret = %d%s\n",
         |                                             ~~^
     108 |                 sizeof(priv->ec_data), priv->ec_data,
         |                 ~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:31: note: expanded from macro 'dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                      ^~~     ~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: expanded from macro 'dev_fmt'
      19 | #define dev_fmt(fmt) fmt
         |                      ^~~
   include/linux/dynamic_debug.h:285:12: note: expanded from macro 'dynamic_dev_dbg'
     285 |                            dev, fmt, ##__VA_ARGS__)
         |                                 ^~~    ~~~~~~~~~~~
   include/linux/dynamic_debug.h:261:59: note: expanded from macro '_dynamic_func_call'
     261 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:259:65: note: expanded from macro '_dynamic_func_call_cls'
     259 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:231:15: note: expanded from macro '__dynamic_func_call_cls'
     231 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   1 warning generated.


vim +107 drivers/mfd/asus-ec.c

   100	
   101	static int asus_ec_read(struct asus_ec_data *priv, bool in_irq)
   102	{
   103		int ret = i2c_smbus_read_i2c_block_data(priv->self, 0x6A,
   104							sizeof(priv->ec_data),
   105							priv->ec_data);
   106	
 > 107		dev_dbg(&priv->self->dev, "EC read: %*ph, ret = %d%s\n",
   108			sizeof(priv->ec_data), priv->ec_data,
   109			ret, in_irq ? "; in irq" : "");
   110	
   111		return ret;
   112	}
   113	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

