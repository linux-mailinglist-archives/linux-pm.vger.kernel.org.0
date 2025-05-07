Return-Path: <linux-pm+bounces-26777-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52A1AAD99E
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 10:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7FF4E60CE
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 08:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE90223715;
	Wed,  7 May 2025 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHNBUs5m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53455222568;
	Wed,  7 May 2025 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604744; cv=none; b=TYatBW7tNDsltKNtc23pU1w3/WFYrDkYgT8VCP0xJ9rZDZ7NeBNHIKxTx3lVdMYtpAkOTyNFrFgmBUEbW0h1ZgpddBsWvWSKTNjxhzmSzTBCB3xQIKv7beEGxfHwEV+bUoD0Lctb5/dFg/iHBeEGPvlSk2QTKoKpYKysE65X908=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604744; c=relaxed/simple;
	bh=cJVc8vDwwV6eG3WvH6uiIoTnL+2Yb4/F1G4OnVH37bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0TsRwNIhWoZG5gMWL6UpD+FPQ56K2lovAG+HygHLlankl5y/VzPWmSEY1e8qiEZbg3MhektabdcBJG92YZu2ZZJMxHcUu1cVbVyeqfT4MxPxVXrURVPPvWtz1Dv5P9H2GcN93k0GhW2e9iRNl0ODMsmj1xEjzf58khI+cqX5r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHNBUs5m; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746604743; x=1778140743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cJVc8vDwwV6eG3WvH6uiIoTnL+2Yb4/F1G4OnVH37bo=;
  b=FHNBUs5mDrvEsxe9oKHXAckoUDjW+E+nwv9OduaOoLleq4nr+NivnNRU
   axX8QACXSFiReYugRQaqILIQNVM/2WTB+6ovi+vcyO7kK8ZB19G+2GntJ
   Vc/sgfR9J3TOPA1qa9xon9Ftpc6PNAlRbErEvswo5MwtGdhEbhGNk7OsH
   t6zVBYkkf4BtiKm1PTHShoIUi82o1hIE9xZY9YJmfYWnpW6PkoYqjukJQ
   c9I6QOgZLmm+A4RnwxH8oh2ctGR29pVKzxMObWUeCpJcG2ZpC671lTYIX
   l6nSiJxqVViXh5LoBCczU9CRvlDFrqVBDJESmpRrsYWtZm8/1Zt4pXBwc
   Q==;
X-CSE-ConnectionGUID: 6quq6gNZQQ6YUoBqs1saBg==
X-CSE-MsgGUID: S1scbWBCTpOo7xheNtEUtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="51969535"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="51969535"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:59:02 -0700
X-CSE-ConnectionGUID: i3OY1f7dSP6kowPaS9EQDw==
X-CSE-MsgGUID: XJ5A9IlWRxamSWSXFFzBUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="159175153"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 07 May 2025 00:58:57 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCZg6-0007Mx-21;
	Wed, 07 May 2025 07:58:54 +0000
Date: Wed, 7 May 2025 15:58:14 +0800
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
Subject: Re: [PATCH v3 8/9] serial: qcom-geni: Enable PM runtime for serial
 driver
Message-ID: <202505071523.FhPMXslL-lkp@intel.com>
References: <20250502031018.1292-9-quic_ptalari@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502031018.1292-9-quic_ptalari@quicinc.com>

Hi Praveen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3e039dcc9c1320c0d33ddd51c372dcc91d3ea3c7]

url:    https://github.com/intel-lab-lkp/linux/commits/Praveen-Talari/opp-add-new-helper-API-dev_pm_opp_set_level/20250502-111540
base:   3e039dcc9c1320c0d33ddd51c372dcc91d3ea3c7
patch link:    https://lore.kernel.org/r/20250502031018.1292-9-quic_ptalari%40quicinc.com
patch subject: [PATCH v3 8/9] serial: qcom-geni: Enable PM runtime for serial driver
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20250507/202505071523.FhPMXslL-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250507/202505071523.FhPMXslL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505071523.FhPMXslL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/qcom_geni_serial.c:1876:12: warning: 'qcom_geni_serial_runtime_resume' defined but not used [-Wunused-function]
    1876 | static int qcom_geni_serial_runtime_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/qcom_geni_serial.c:1868:12: warning: 'qcom_geni_serial_runtime_suspend' defined but not used [-Wunused-function]
    1868 | static int qcom_geni_serial_runtime_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/qcom_geni_serial_runtime_resume +1876 drivers/tty/serial/qcom_geni_serial.c

  1867	
> 1868	static int qcom_geni_serial_runtime_suspend(struct device *dev)
  1869	{
  1870		struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
  1871		struct uart_port *uport = &port->uport;
  1872	
  1873		return geni_serial_resources_off(uport);
  1874	};
  1875	
> 1876	static int qcom_geni_serial_runtime_resume(struct device *dev)
  1877	{
  1878		struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
  1879		struct uart_port *uport = &port->uport;
  1880	
  1881		return geni_serial_resources_on(uport);
  1882	};
  1883	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

