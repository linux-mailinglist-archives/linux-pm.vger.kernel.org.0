Return-Path: <linux-pm+bounces-16054-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E02729A568E
	for <lists+linux-pm@lfdr.de>; Sun, 20 Oct 2024 21:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960B61F20EEC
	for <lists+linux-pm@lfdr.de>; Sun, 20 Oct 2024 19:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845BB19596F;
	Sun, 20 Oct 2024 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zb50/3Q+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC82D194C92;
	Sun, 20 Oct 2024 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729454001; cv=none; b=RS0uq1UC+c1WcysKI5iT3nf4/m7y4NBND/3AfhgeTiqhprRzjeFTNe481ZyL+i7pLji1aa0KxL+JIQfCfErdNoFCq0Sz+kdUDB01rkF5JYlkozfByv4/ueec5NabVH7mNdWxKAPQIzAXY5jRhinPDvpVt7hGfCvyIVjN05pgwPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729454001; c=relaxed/simple;
	bh=NUl5wLKfXrlmAITdUKRsm1jobjctTNRygTvb2ezjcr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umqnRuk+g6svxKdzF907CTfc87ZnLqHukci6+A0sN0y7k+fr5/iRDHNXPoDFUBkD8Rrs8LS0v3HGW9Z/82U5WVCfKhrLJACaSTi8VPxqeyLjZ8nisVLO2wQhlGhpcnGPY/+riNshPeV7wvWUWOVQ+HXJLs6tv0UfXSqGZcgyoGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zb50/3Q+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729453999; x=1760989999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NUl5wLKfXrlmAITdUKRsm1jobjctTNRygTvb2ezjcr4=;
  b=Zb50/3Q+xQ9dioyQnBdpdIQDVXy6kPlFfDtVSgGaFbFB+rLgPGskZEnP
   ODhCFAN6pg6LTofokMnjMPeVKEREWn5gLnmhuhCjhqeuaSc/Jp6yp3LKY
   IJ1D+SJmqeNGN/KPyNcg4evsFV2BRkky8glCBLY6j8bc6Q7ZzgVVGcCP9
   vftvLrBEQLThqgIjFHa7u1yctKVmntZfBPNZSO+TxGswtvOMM7gv3t5/+
   SypeR3UmHr+uQBfyNPA0v66MIdvNuUqL5EVSFZ+yAbrJtDmRcFx9NadXi
   BbFFHKCGHr5+NNd+zFtsdC2sj9QGrPEgQpNvwwa/pp+6IrX5ZTu2Om3vp
   w==;
X-CSE-ConnectionGUID: /4bZzvmVS52N8GCtJzwwvA==
X-CSE-MsgGUID: JDa8pBFhS/qRfxwvOy5L5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="16557546"
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="16557546"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 12:53:18 -0700
X-CSE-ConnectionGUID: Tc2MKGXrSiunSGsS93Nz/w==
X-CSE-MsgGUID: uK0e0n9VTDK3tsFpNpMgHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,219,1725346800"; 
   d="scan'208";a="78989802"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 20 Oct 2024 12:53:12 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2bzC-000Qkv-01;
	Sun, 20 Oct 2024 19:53:10 +0000
Date: Mon, 21 Oct 2024 03:52:23 +0800
From: kernel test robot <lkp@intel.com>
To: Elliot Berman <quic_eberman@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, cros-qcom-dts-watchers@chromium.org,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Shivendra Pratap <quic_spratap@quicinc.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v6 5/5] arm64: dts: qcom: Add PSCI SYSTEM_RESET2 types
 for sa8775p-ride
Message-ID: <202410210333.KGHmzwGN-lkp@intel.com>
References: <20241018-arm-psci-system_reset2-vendor-reboots-v6-5-50cbe88b0a24@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-arm-psci-system_reset2-vendor-reboots-v6-5-50cbe88b0a24@quicinc.com>

Hi Elliot,

kernel test robot noticed the following build errors:

[auto build test ERROR on 98f7e32f20d28ec452afb208f9cffc08448a2652]

url:    https://github.com/intel-lab-lkp/linux/commits/Elliot-Berman/dt-bindings-power-reset-Convert-mode-properties-to-array/20241019-034308
base:   98f7e32f20d28ec452afb208f9cffc08448a2652
patch link:    https://lore.kernel.org/r/20241018-arm-psci-system_reset2-vendor-reboots-v6-5-50cbe88b0a24%40quicinc.com
patch subject: [PATCH v6 5/5] arm64: dts: qcom: Add PSCI SYSTEM_RESET2 types for sa8775p-ride
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20241021/202410210333.KGHmzwGN-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bfe84f7085d82d06d61c632a7bad1e692fd159e4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241021/202410210333.KGHmzwGN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410210333.KGHmzwGN-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi:504.12-13 syntax error
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

