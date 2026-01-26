Return-Path: <linux-pm+bounces-41490-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCzLGwTEd2nckgEAu9opvQ
	(envelope-from <linux-pm+bounces-41490-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 20:44:04 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C19D38CB4D
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 20:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8761530247EC
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 19:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FD928643C;
	Mon, 26 Jan 2026 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="derieL3L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AA01F4CBC;
	Mon, 26 Jan 2026 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456496; cv=none; b=tszCGxiEoTzYg61xJlPEzeb6XugsR7Vegh9nw9wQWDnq3YCTQ9DN3Ohl9j9RbNoDTgwyBX/p73KYojGsvA/g9WDUC2MxapSdiXfGho6O4uew3d+OTZvjzVPPyc1m4tk2Q86bom3z62IXsMG0j44HLALPKGc57Cm/syfDPFdm7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456496; c=relaxed/simple;
	bh=uQFMWGnGGz/UkepHe6qNZM7ssltN76ODEap8qFaeK2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MaxGYJjD8+uW8iVU+S8U47p4FCiAG158GQF6LzqqlT0RdjfdzTU4ffibIZ/LJNc8n/AtfYuw8821aoPy/uBcBlLnhWILXJlaYOr+xgvnGWb5IzGLKJ5CNq65qZ9X0zs++m32J7MPAbYLypJ5eJ9ArWZkN5k/sKVDVb2wL9i7gcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=derieL3L; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769456494; x=1800992494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uQFMWGnGGz/UkepHe6qNZM7ssltN76ODEap8qFaeK2s=;
  b=derieL3LLtDdLkKo62F/2aghx7RorjhNNvIFNM3y62aJ5uFizAoBe8iu
   1At6KcH7MVaWC7f/J+n5FVM/nDFpxINAXVofD5cCafOk34W7ylQgBcjRW
   YQVSKVx/lor3hPrirIzN3FEn8vcMQ70p81nBdw9hpC4gLSzKew0HVXj/o
   bcjRpAOnEghYpq3zBCpNZzkICk/a9HgkVNRoeCrocxC/Zd/+Bf4u6aApH
   3PxnOh6h1iQXCcj3EVp8F7SU9ZyXuzS6x3t3jmXz4+t3gUsNXPhJhhRns
   ElT6aYmdgP1MDzLOoppsA72Bx99NFD6xO8ARm30znAx8xzKbk6Ht1QXTj
   Q==;
X-CSE-ConnectionGUID: iROUj1cSSs2gn1LuTof2hQ==
X-CSE-MsgGUID: cdogRa0CQ4Gqx2hPytNR1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70545872"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="70545872"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 11:41:33 -0800
X-CSE-ConnectionGUID: n0esMp9ySU+Mz1YRzxo6RQ==
X-CSE-MsgGUID: jseCndPdQO2p/ZZbLSbXCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="206992580"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 26 Jan 2026 11:41:28 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkSSj-00000000XdK-0FbY;
	Mon, 26 Jan 2026 19:41:25 +0000
Date: Tue, 27 Jan 2026 03:41:05 +0800
From: kernel test robot <lkp@intel.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sebastian Reichel <sre@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: Re: [PATCH v2 06/12] mfd: sec: add support for S2MU005 PMIC
Message-ID: <202601270307.Ds4yus7I-lkp@intel.com>
References: <20260126-s2mu005-pmic-v2-6-78f1a75f547a@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-s2mu005-pmic-v2-6-78f1a75f547a@disroot.org>
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
	TAGGED_FROM(0.00)[bounces-41490-lists,linux-pm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: C19D38CB4D
X-Rspamd-Action: no action

Hi Kaustabh,

kernel test robot noticed the following build errors:

[auto build test ERROR on ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea]

url:    https://github.com/intel-lab-lkp/linux/commits/Kaustabh-Chakraborty/dt-bindings-leds-document-Samsung-S2M-series-PMIC-flash-LED-device/20260126-031457
base:   ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea
patch link:    https://lore.kernel.org/r/20260126-s2mu005-pmic-v2-6-78f1a75f547a%40disroot.org
patch subject: [PATCH v2 06/12] mfd: sec: add support for S2MU005 PMIC
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20260127/202601270307.Ds4yus7I-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260127/202601270307.Ds4yus7I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601270307.Ds4yus7I-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mfd/sec-irq.c:218:7: error: expression is not an integer constant expression
           case irqf_regs[0]:
                ^~~~~~~~~~~~
   drivers/mfd/sec-irq.c:218:7: note: initializer of 'irqf_regs' is not a constant expression
   drivers/mfd/sec-irq.c:204:21: note: declared here
           const unsigned int irqf_regs[] = {
                              ^
   drivers/mfd/sec-irq.c:220:7: error: expression is not an integer constant expression
           case mask_regs[0]:
                ^~~~~~~~~~~~
   drivers/mfd/sec-irq.c:220:7: note: initializer of 'mask_regs' is not a constant expression
   drivers/mfd/sec-irq.c:210:21: note: declared here
           const unsigned int mask_regs[] = {
                              ^
   2 errors generated.


vim +218 drivers/mfd/sec-irq.c

   200	
   201	static unsigned int s2mu005_irq_get_reg(struct regmap_irq_chip_data *data,
   202						unsigned int base, int index)
   203	{
   204		const unsigned int irqf_regs[] = {
   205			S2MU005_REG_CHGR_INT1,
   206			S2MU005_REG_FLED_INT1,
   207			S2MU005_REG_MUIC_INT1,
   208			S2MU005_REG_MUIC_INT2,
   209		};
   210		const unsigned int mask_regs[] = {
   211			S2MU005_REG_CHGR_INT1M,
   212			S2MU005_REG_FLED_INT1M,
   213			S2MU005_REG_MUIC_INT1M,
   214			S2MU005_REG_MUIC_INT2M,
   215		};
   216	
   217		switch (base) {
 > 218		case irqf_regs[0]:
   219			return irqf_regs[index];
   220		case mask_regs[0]:
   221			return mask_regs[index];
   222		}
   223	
   224		return base;
   225	}
   226	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

