Return-Path: <linux-pm+bounces-25292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC6FA865AB
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 20:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A5F4A72C3
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 18:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39527269D01;
	Fri, 11 Apr 2025 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d9Lq+nM/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C85269892;
	Fri, 11 Apr 2025 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744396913; cv=none; b=l5pZ3RNN8cQQDDl9dXqu/i8g40ECWq7tcioHORhB5HnusllLtODBW6KShmrp3j1rfE4HXnxqysVXblmRzyQEltAZVmTF52qMS8Hm8M7SOY1PMXQdBls9qXHrTXmoLnZE0Hfl8avyH6B59ItUEFDH1iw6fMzMwafZ5wmCyu9QmO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744396913; c=relaxed/simple;
	bh=NY8+7+ZEmdWqqx0zQOF9aAujJPW4CRyp6FmkPwIcd+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6pCbFvNiXcmQ1fxo1MNa+q0oQGFulYTYgdFrQMY7cKBaqaBufzSURQmpU69BA5NNU++N/Nyd5tm6CSxLOAh0jWnKaFudOwk8JR6+61D4S19A8UHsfHENJXBZ8h/7PmbaJgOSBL3jNPn1sWG1gtrVjPtyiNsTbe/Hf5dE+2l940=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d9Lq+nM/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744396911; x=1775932911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NY8+7+ZEmdWqqx0zQOF9aAujJPW4CRyp6FmkPwIcd+w=;
  b=d9Lq+nM/2lV5ChjjnQ/zGREVg7pP3vjW11ZIFfd4SEd6pb5Os7uEyySQ
   Kb0V/rnnpuaEomBjr2ZjfvuWI0Ya2NkEKYgnpZSKvcI0S7NL0RUrRGqUL
   G5puANSFUtBwqgQ5g/HgOl1YbdqAfBLnmnBAfXX7k/6NFcecqLSJPIbeF
   cfysNlryKFaoPJ3lCZH2umQQ4X62Ybn/OeaOisEORL3A7F3vdLegaWo7/
   mMIRTEHIJootX7LO2jQAOjJ6hr9KRoxTfa08gdjCyicZobvcq5ndSBIdN
   xISSme44mctcWE8vPAWKhraV0it29da9AFwvgxteVwE/2/pXKQ0EbfNBT
   g==;
X-CSE-ConnectionGUID: RlttfFGIS3mXtNGLCkFurA==
X-CSE-MsgGUID: WARzn40OR9Cm0hDklpGVWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="63500552"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="63500552"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 11:41:48 -0700
X-CSE-ConnectionGUID: e3q01x+CRf6UfIA1beGItA==
X-CSE-MsgGUID: 8a1ba08VQkKVcgN2zvTF2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="129124558"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 11 Apr 2025 11:41:43 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u3JJt-000BJa-0o;
	Fri, 11 Apr 2025 18:41:41 +0000
Date: Sat, 12 Apr 2025 02:40:51 +0800
From: kernel test robot <lkp@intel.com>
To: Praveen Talari <quic_ptalari@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	psodagud@quicinc.com, djaggi@quicinc.com, quic_msavaliy@quicinc.com,
	quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
	quic_mnaresh@quicinc.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH v1 4/9] soc: qcom: geni-se: Enable QUPs on SA8255p
 Qualcomm platforms
Message-ID: <202504120226.2XbpK0yU-lkp@intel.com>
References: <20250410174010.31588-5-quic_ptalari@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410174010.31588-5-quic_ptalari@quicinc.com>

Hi Praveen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus robh/for-next driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.15-rc1 next-20250411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Praveen-Talari/opp-add-new-helper-API-dev_pm_opp_set_level/20250411-015310
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20250410174010.31588-5-quic_ptalari%40quicinc.com
patch subject: [PATCH v1 4/9] soc: qcom: geni-se: Enable QUPs on SA8255p Qualcomm platforms
config: arm-randconfig-001-20250412 (https://download.01.org/0day-ci/archive/20250412/202504120226.2XbpK0yU-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250412/202504120226.2XbpK0yU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504120226.2XbpK0yU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/soc/qcom/qcom-geni-se.c:953:1: warning: unused label 'out' [-Wunused-label]
     953 | out:
         | ^~~~
   1 warning generated.


vim +/out +953 drivers/soc/qcom/qcom-geni-se.c

   928	
   929	static int geni_se_probe(struct platform_device *pdev)
   930	{
   931		struct device *dev = &pdev->dev;
   932		struct geni_wrapper *wrapper;
   933		const struct geni_se_desc *desc;
   934		int ret;
   935	
   936		wrapper = devm_kzalloc(dev, sizeof(*wrapper), GFP_KERNEL);
   937		if (!wrapper)
   938			return -ENOMEM;
   939	
   940		wrapper->dev = dev;
   941		wrapper->base = devm_platform_ioremap_resource(pdev, 0);
   942		if (IS_ERR(wrapper->base))
   943			return PTR_ERR(wrapper->base);
   944	
   945		desc = device_get_match_data(&pdev->dev);
   946	
   947		if (!has_acpi_companion(&pdev->dev) && desc->geni_se_rsc_init) {
   948			ret = desc->geni_se_rsc_init(wrapper, desc);
   949			if (ret)
   950				return -EINVAL;
   951		}
   952	
 > 953	out:
   954		dev_set_drvdata(dev, wrapper);
   955		dev_dbg(dev, "GENI SE Driver probed\n");
   956		return devm_of_platform_populate(dev);
   957	}
   958	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

