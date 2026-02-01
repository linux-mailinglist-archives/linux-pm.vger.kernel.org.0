Return-Path: <linux-pm+bounces-41870-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMl/BnOkf2k6vAIAu9opvQ
	(envelope-from <linux-pm+bounces-41870-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 20:07:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2697C706C
	for <lists+linux-pm@lfdr.de>; Sun, 01 Feb 2026 20:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE61A3006781
	for <lists+linux-pm@lfdr.de>; Sun,  1 Feb 2026 19:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B3629ACFC;
	Sun,  1 Feb 2026 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jc6joXMO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02C0289824;
	Sun,  1 Feb 2026 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769972829; cv=none; b=EQ08FJE5v++P9/tz4Oe+Eh5cxxeaAo3KNjQmbKeBukJeK8f3Qa0uAxkexYZxRo90EczG91xcTweeM1fHwiu3w5EnNW2JVgPuQIfMR7jIKTQcOWCN+hfincU4AWeoC46J8FQQWXgcKKpAY1LOqj8QXip7LAaHIG8zxGE4yslNeuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769972829; c=relaxed/simple;
	bh=HDc8MgK94VWVzVgRm9d6Qx3vZrZMN40UDaueJ4l3KF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WY7nE3M+wrPY2LMmJ+ZjFF+k4V8JDzVQ/T6F1krh4i7alvmslzVVlMGcuIqsVHbO8Z3XrBUQHuoSSUlxTOe/e42ow4ki/VUadLFKHXCp0nUrIY9/a5BPQI5aQrrRPUpDHPbReibXPmNhFxMK8YmqK6KXue7oMtEfGHuvArT4zGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jc6joXMO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769972828; x=1801508828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HDc8MgK94VWVzVgRm9d6Qx3vZrZMN40UDaueJ4l3KF8=;
  b=jc6joXMOwKjngwzSKhU1Qi1MXSQdRKDA5aKu/mo4sZOd5cNkURzANHZ0
   KpfhoSU5YUOsxNqb1UvQ92n88rKSAcxFj56diAHvhn7O+A45md85k3KqM
   cAf88pVAhpfgvFHmwyXzNZk5R62hlGnNUwjKO1ypa97jwkj1Db8BV3E13
   fLaAfR5QxUlulIMAlKTmt4EXrhuTEkLbgArPvzrDbE6eus9j1wnJQaXJW
   Yn7lMRQQEYxVQC70yrreU0RV9nodRrHbVK8HdkdPVcJEkDDTX/+dj5IVT
   cA2bvevdzmDOXhor6LxW2b2GoVbKXrfce3QNDsAnOcM+5Qnvz2346lmOw
   g==;
X-CSE-ConnectionGUID: Q8KiqOVVTxWQvxtT3JHJtg==
X-CSE-MsgGUID: EiFBfhOkT/+z9VKu7HB1xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="82255926"
X-IronPort-AV: E=Sophos;i="6.21,267,1763452800"; 
   d="scan'208";a="82255926"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2026 11:07:07 -0800
X-CSE-ConnectionGUID: ugA4nLfWSjyZvYiWt2l5kQ==
X-CSE-MsgGUID: 7tL4sXaqRAS0Y96Yzv4Lsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,267,1763452800"; 
   d="scan'208";a="209116615"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 01 Feb 2026 11:07:02 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vmcmh-00000000eye-2ywo;
	Sun, 01 Feb 2026 19:06:59 +0000
Date: Mon, 2 Feb 2026 03:06:31 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 4/9] mfd: Add driver for Asus Transformer embedded
 controller
Message-ID: <202602020344.ZGXToDMx-lkp@intel.com>
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
	TAGGED_FROM(0.00)[bounces-41870-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,arndb.de,linuxfoundation.org,rere.qmqm.pl,agorria.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,git-scm.com:url]
X-Rspamd-Queue-Id: A2697C706C
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
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20260202/202602020344.ZGXToDMx-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260202/202602020344.ZGXToDMx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602020344.ZGXToDMx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:620,
                    from include/asm-generic/bug.h:31,
                    from arch/alpha/include/asm/bug.h:23,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:6,
                    from ./arch/alpha/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/delay.h:13,
                    from drivers/mfd/asus-ec.c:7:
   drivers/mfd/asus-ec.c: In function 'asus_ec_read':
>> drivers/mfd/asus-ec.c:107:35: warning: field width specifier '*' expects argument of type 'int', but argument 4 has type 'long unsigned int' [-Wformat=]
     107 |         dev_dbg(&priv->self->dev, "EC read: %*ph, ret = %d%s\n",
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:231:29: note: in definition of macro '__dynamic_func_call_cls'
     231 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:261:9: note: in expansion of macro '_dynamic_func_call_cls'
     261 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:284:9: note: in expansion of macro '_dynamic_func_call'
     284 |         _dynamic_func_call(fmt, __dynamic_dev_dbg,              \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:9: note: in expansion of macro 'dynamic_dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:165:30: note: in expansion of macro 'dev_fmt'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/mfd/asus-ec.c:107:9: note: in expansion of macro 'dev_dbg'
     107 |         dev_dbg(&priv->self->dev, "EC read: %*ph, ret = %d%s\n",
         |         ^~~~~~~
   drivers/mfd/asus-ec.c:107:46: note: format string is defined here
     107 |         dev_dbg(&priv->self->dev, "EC read: %*ph, ret = %d%s\n",
         |                                             ~^~
         |                                              |
         |                                              int


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

