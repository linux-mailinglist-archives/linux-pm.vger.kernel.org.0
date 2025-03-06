Return-Path: <linux-pm+bounces-23581-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EE1A557C0
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 21:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD8E176E8E
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 20:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D7A2063EB;
	Thu,  6 Mar 2025 20:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYLduU9d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E6D205502;
	Thu,  6 Mar 2025 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294222; cv=none; b=TpL9wPv8e+2lTuYa6qbfNoItTFj0nH+gmG9tmuagC57DGdlt9WJ1g1My6w7H+OROx1fcMImKjn9fqBiJok6L6+bDFk2u5uIc4XWh/YO5UrtHzypw/HqUlY/xxKqlXUEo6J/HuFCjmK3kkQvvOxAg2teZEzkK4nDRNlWqrBnlv0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294222; c=relaxed/simple;
	bh=cvf/ipSb+K3a68VNt2N4RXjMJlyp30yAxRniCB2UBM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KADt2pWJIln/dT8qqRXEjv4EGdl/Yopd80QKJDvaeqvOS37bsglCiI8SMROGo8rSOQRiXExm5RVdx017siflOtwAF+GPbolna/cj1e/SY4W2loWfkj8QOOtkwc1rOEBHOxsg04guYNd3lbM0OA73nu0W6N1IpO0PfZbG6LoKGas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYLduU9d; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741294221; x=1772830221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cvf/ipSb+K3a68VNt2N4RXjMJlyp30yAxRniCB2UBM8=;
  b=IYLduU9dQn2RXRnZfTZHeIilSD0zvpt3Lw8CEWmXDR8nnBw3p3qHTJVn
   Uclgy1gXhEORB03Tjn9sC5TqkCekrnyNZyXeJX3lUiiNhHJpWE/hqQkUu
   3lFniyvPhKqyeSfg+e0+aSeXatD9oNPD4x2JRtOXsnnbTx+b9nG/ResCP
   n8sQw9tJ8rDRw17gqJcPwKmhzBFWW/ycsxGCbC92eo/+SGxL9LzOWgITU
   caOQ95ukKogQ7UOQ2Pghfj1GoGENkAX+rC2CXrVKey5WAoI3501fytPyJ
   YswMxPJBZ2kP7w8Nu5ioyQnyuUAtdz6FkMNs4A2WZMIX/maA3HyiI7GnV
   A==;
X-CSE-ConnectionGUID: fg45Lxw4QvicRNx6RWFggQ==
X-CSE-MsgGUID: udITrILpS76cgepxiJHRVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="41502045"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="41502045"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 12:50:20 -0800
X-CSE-ConnectionGUID: ZCMNw3ZDQFC0f7jhlngx6A==
X-CSE-MsgGUID: qh4lq5bpSq+Xez7Ou7jcRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119052143"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 06 Mar 2025 12:50:09 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqIAQ-000NbS-31;
	Thu, 06 Mar 2025 20:50:06 +0000
Date: Fri, 7 Mar 2025 04:49:17 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, kernel@collabora.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Andrew Perepech <andrew.perepech@mediatek.com>
Subject: Re: [PATCH v3 04/20] ASoC: mediatek: mt6359-accdet: Add compatible
 property
Message-ID: <202503070421.25fbw6zg-lkp@intel.com>
References: <20250304-mt6359-accdet-dts-v3-4-5b0eafc29f5b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304-mt6359-accdet-dts-v3-4-5b0eafc29f5b@collabora.com>

Hi Nícolas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 20d5c66e1810e6e8805ec0d01373afb2dba9f51a]

url:    https://github.com/intel-lab-lkp/linux/commits/N-colas-F-R-A-Prado/ASoC-dt-bindings-Add-document-for-mt6359-accdet/20250304-233834
base:   20d5c66e1810e6e8805ec0d01373afb2dba9f51a
patch link:    https://lore.kernel.org/r/20250304-mt6359-accdet-dts-v3-4-5b0eafc29f5b%40collabora.com
patch subject: [PATCH v3 04/20] ASoC: mediatek: mt6359-accdet: Add compatible property
config: s390-randconfig-r133-20250306 (https://download.01.org/0day-ci/archive/20250307/202503070421.25fbw6zg-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20250307/202503070421.25fbw6zg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503070421.25fbw6zg-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/soc/codecs/mt6359-accdet.c:1050:27: sparse: sparse: symbol 'accdet_of_match' was not declared. Should it be static?

vim +/accdet_of_match +1050 sound/soc/codecs/mt6359-accdet.c

  1049	
> 1050	const struct of_device_id accdet_of_match[] = {
  1051		{ .compatible = "mediatek,mt6359-accdet", },
  1052		{ /* sentinel */ },
  1053	};
  1054	MODULE_DEVICE_TABLE(of, accdet_of_match);
  1055	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

