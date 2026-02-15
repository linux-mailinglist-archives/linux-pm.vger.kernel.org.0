Return-Path: <linux-pm+bounces-42676-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INTpDZYskmmVrgEAu9opvQ
	(envelope-from <linux-pm+bounces-42676-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 21:29:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA5913FA3D
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 21:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3ADBF30059A0
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 20:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06ED2FBE12;
	Sun, 15 Feb 2026 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ED3tmrop"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228842F9D83;
	Sun, 15 Feb 2026 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771187346; cv=none; b=kWNCHAgyuzXjRQfImFvlX9w3D2pXZhdDqxBpJdKGF6KeDeSbMSLajFzEJToLj0x/QfuAnK/PcvC8FYiSZpegiS5ZQ5itbQBQDVBl/QZgNYiZkUlm5QCAEDCr5EgB/VwVppmwFX8R8aMQhXed159+22arpwJbSHozT3xbOF/GhyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771187346; c=relaxed/simple;
	bh=hVLVSplviPu8tm98WtJ2k363b25r3G+Ovp7/xnmIpJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSlh2pBSeLdZ5YdtV6c54wKc9TplTcGCF9qqaUWviz38gnNXxA9luJWQEdbCYVmOcANTsees0gcKFBFQLkiB2zg2SnWU98sIC762YoqQ4AvmPciIgMiRT16fv95F3arNJoA6fGsVrSnxFnrmFjRWLMk9jcZWrImzFcuKADho7ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ED3tmrop; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771187345; x=1802723345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hVLVSplviPu8tm98WtJ2k363b25r3G+Ovp7/xnmIpJs=;
  b=ED3tmropF3TbJQh8kMDoNBoz45Uv0nHxCj3m7VLOhNugjYnotxKgSzCi
   Yf86n1aSZ3Bwdi4YAv9bWgW7bQhqFp3Tvs2+dJ38Au2w3b6CIHreFkRir
   jfGjADfrrgID1yopiN2l57+o4IKVgrOg1tl5N2tw1OH3xHc9PHzsdaIzC
   Kck/SdDBwJn2IpXq78whMfFDEN+XqSb5MDkmg2UaPf/cEp9b4mwxLe1h2
   T3TO545rS7Q8yyU0gDq/iSMPEnI9nn6VXfjtyS/+3+kQ7PQE+2pJ0eL9P
   9YBhn8uUP/MuA+PrOYKpbaNcBHJpOMp4KNf1L65KMSNDArJ3fTPd/IbYo
   A==;
X-CSE-ConnectionGUID: gLWbu2mrSU+EJ6JwW9Lt4A==
X-CSE-MsgGUID: pxhA4nlJRsmMYzVzuPTh4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="72329949"
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="72329949"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 12:29:04 -0800
X-CSE-ConnectionGUID: XETOTSvKSHO+C3XiRh4rVg==
X-CSE-MsgGUID: p/iu48HgScuRC6tyTII80w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="213518818"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 15 Feb 2026 12:29:01 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vriji-00000000z8e-1N4C;
	Sun, 15 Feb 2026 20:28:58 +0000
Date: Mon, 16 Feb 2026 04:28:11 +0800
From: kernel test robot <lkp@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/7] mfd: Add driver for ASUS Transformer embedded
 controller
Message-ID: <202602160408.CZnIzWhv-lkp@intel.com>
References: <20260214180959.30714-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214180959.30714-3-clamor95@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42676-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,agorria.com,rere.qmqm.pl];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,01.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: CEA5913FA3D
X-Rspamd-Action: no action

Hi Svyatoslav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20260213]
[also build test WARNING on linus/master v6.19]
[cannot apply to dtor-input/next dtor-input/for-linus sre-power-supply/for-next robh/for-next v6.19 v6.19-rc8 v6.19-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Svyatoslav-Ryhel/dt-bindings-embedded-controller-document-ASUS-Transformer-EC/20260215-021406
base:   next-20260213
patch link:    https://lore.kernel.org/r/20260214180959.30714-3-clamor95%40gmail.com
patch subject: [PATCH v3 2/7] mfd: Add driver for ASUS Transformer embedded controller
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20260216/202602160408.CZnIzWhv-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260216/202602160408.CZnIzWhv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602160408.CZnIzWhv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mfd/asus-transformer-ec.c:234:40: warning: field width should have type 'int', but argument has type 'unsigned long' [-Wformat]
           dev_dbg(&priv->self->dev, "EC read: %*ph, ret = %d%s\n",
                                               ~~^
   include/linux/dev_printk.h:165:31: note: expanded from macro 'dev_dbg'
           dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                                        ^~~     ~~~~~~~~~~~
   include/linux/dev_printk.h:19:22: note: expanded from macro 'dev_fmt'
   #define dev_fmt(fmt) fmt
                        ^~~
   include/linux/dynamic_debug.h:285:12: note: expanded from macro 'dynamic_dev_dbg'
                              dev, fmt, ##__VA_ARGS__)
                                   ^~~    ~~~~~~~~~~~
   include/linux/dynamic_debug.h:261:59: note: expanded from macro '_dynamic_func_call'
           _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
                                                                    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:259:65: note: expanded from macro '_dynamic_func_call_cls'
           __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
                                                                          ^~~~~~~~~~~
   include/linux/dynamic_debug.h:231:15: note: expanded from macro '__dynamic_func_call_cls'
                   func(&id, ##__VA_ARGS__);                       \
                               ^~~~~~~~~~~
   1 warning generated.


vim +234 drivers/mfd/asus-transformer-ec.c

   227	
   228	static int asus_ec_read(struct asus_ec_data *priv, bool in_irq)
   229	{
   230		int ret = i2c_smbus_read_i2c_block_data(priv->self, ASUSEC_READ_BUF,
   231							sizeof(priv->ec_data),
   232							priv->ec_data);
   233	
 > 234		dev_dbg(&priv->self->dev, "EC read: %*ph, ret = %d%s\n",
   235			sizeof(priv->ec_data), priv->ec_data,
   236			ret, in_irq ? "; in irq" : "");
   237	
   238		return ret;
   239	}
   240	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

