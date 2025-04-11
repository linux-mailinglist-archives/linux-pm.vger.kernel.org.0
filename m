Return-Path: <linux-pm+bounces-25291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09033A865A6
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 20:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012FD4A721C
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 18:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6AF269836;
	Fri, 11 Apr 2025 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b3gmgPBj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2218A2690F0;
	Fri, 11 Apr 2025 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744396911; cv=none; b=FpydZ459t7Ahbn4DxnpctBVLM/KQbAPbe7A0fxwXB8I7pTaenX1qfbeQpAROsTf9pwupuEGhc57/sJjXREjCj9g0NFuMNYh/4Bp90Nv8I6rqp2J596BVq7KKIvPCsHZ3SrlNwGVK1z0+k4zerzFMeXV31V6Hp3tLpwhzMy3p2lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744396911; c=relaxed/simple;
	bh=1iI4AfPrlPKUrGY6yeu/1zp9gMl5LZUj8I/yLIFJQZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLOILKuppf+8tHReN3PiaMIAjy0rmOk4lCvg9mmMn1XM78A/G+weWQdASdYfsArESngheodF53fecVVY794+FuOL0tfdLVX2NKx3RAwHGl/ED3dngHimKA6gvJ6mj8d+1UoYQUICu6TavrL/6hBMg0ZFies9xF3TNCGZgBprP90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b3gmgPBj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744396909; x=1775932909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1iI4AfPrlPKUrGY6yeu/1zp9gMl5LZUj8I/yLIFJQZk=;
  b=b3gmgPBjzm7JSGgp//U02k+WH6FpxneP4+wnlHuzYcjJLEm1L3Hb5S7b
   B57d77Lwlxrj4tOcQ9CC98cZzFsHJXRtIGrr/A1fnzatEExasdwfdtZD6
   3n8BUoEV+Q2mccfw0WcMqzjzn5oZ46U+cMQq3t+Cte2mXa9diJ4m9vguc
   LeCBmeJCXnYEIqJNSiJzBkZTG04afDbZsL9jMnysUpd+uhZP+9q0moGdN
   6mFT/aRW2eGmr/rUjDBQoVyod4mFvXNKVa4eAEaAGDTgB3S3GDnGqn/hs
   lAFzVJUa8rqe2q3XRC5/064MtuZPAjEuYEmFiPs9al5knaMO5Bc1k8NkD
   A==;
X-CSE-ConnectionGUID: MJO0Ehl1RHuT70iYESW5YQ==
X-CSE-MsgGUID: m2V9Yo7jQQW4PFH8xLRoDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="63500548"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="63500548"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 11:41:48 -0700
X-CSE-ConnectionGUID: pJSGaWLJTF2fqMRCROz6IQ==
X-CSE-MsgGUID: nmZqz5r4RXGz8z9j0H9ajw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="129124557"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 11 Apr 2025 11:41:43 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u3JJt-000BJc-0s;
	Fri, 11 Apr 2025 18:41:41 +0000
Date: Sat, 12 Apr 2025 02:40:52 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, psodagud@quicinc.com, djaggi@quicinc.com,
	quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
	quic_arandive@quicinc.com, quic_mnaresh@quicinc.com,
	quic_shazhuss@quicinc.com
Subject: Re: [PATCH v1 4/9] soc: qcom: geni-se: Enable QUPs on SA8255p
 Qualcomm platforms
Message-ID: <202504120240.SMbLkgHv-lkp@intel.com>
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
config: arc-randconfig-001-20250412 (https://download.01.org/0day-ci/archive/20250412/202504120240.SMbLkgHv-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250412/202504120240.SMbLkgHv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504120240.SMbLkgHv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/soc/qcom/qcom-geni-se.c: In function 'geni_se_probe':
>> drivers/soc/qcom/qcom-geni-se.c:953:1: warning: label 'out' defined but not used [-Wunused-label]
     953 | out:
         | ^~~
--
>> drivers/soc/qcom/qcom-geni-se.c:110: warning: Function parameter or struct member 'geni_se_rsc_init' not described in 'geni_se_desc'


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

