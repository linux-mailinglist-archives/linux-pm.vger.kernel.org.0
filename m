Return-Path: <linux-pm+bounces-29121-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A717AE11D7
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 05:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448454A1E91
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 03:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FE91DE4C5;
	Fri, 20 Jun 2025 03:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUBaWCiJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823311B87F2;
	Fri, 20 Jun 2025 03:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750390406; cv=none; b=t22C8bhTVoL6y6z82t8pVp2SCyPYnNdIjY0ba8KYoJ6yLkcIuCOLkFrwAAktDbhYuMcXGsp4fWnlcWg0bfpHn4cVJdf3naXpwI9lY5jORHLnXqF53s3o7m4mVet2IbYvaWJz1r7HSTj5ZK2DqZHfVWSS5DXdCVGOakjOuQ4sHhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750390406; c=relaxed/simple;
	bh=6+/5o6kmcWKk3e2NbFhat/dx9eXksyOA9L6fkZ/p9uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vyk8emCz4Ftrtls2DAO0OJEErsX38bRbRCZqJPAcJ/00XEQMn0QHD32+yWsF8kR2BrOBftzRi7HUAO3eW4ZsqOo/qULttyhAaTERaq+YyXC7No+S11hLZf4tCLUSkT0ddVFB6B8/noshq3c2X4xAhim1AMvZR6nyNUJhLTRGKPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUBaWCiJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750390404; x=1781926404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6+/5o6kmcWKk3e2NbFhat/dx9eXksyOA9L6fkZ/p9uU=;
  b=gUBaWCiJGuywIjJtog9di/kCyviKcdjpS6ru+SaVCLKQ1dYqTjP+9lr9
   WRrrc2I5XWCjyNTFJ+ERFVrBcHisSh9jS4yefgaz38P6o/R0AfVvpoUVy
   BOsFrj6DeaW7gyQi9/0muR2eYluh9MP5ZlIXllTNVX+ubnBTMPDMF6B5Q
   2474hvuy0l925Z24OciP3BWCV+gJGb1OkE2nCf5cKP2mSrGUq4/Mnriy+
   jFPS563Y45BxpomSgEm4GE6t4yBK/7WzldqNp62sZh34t6tWgfSu5/vwg
   +FMS+iNFruh19kZ00R9Wf40KthlRljOwVfNn+cpAFOYC0qYqAdgOHjs1t
   g==;
X-CSE-ConnectionGUID: asbSkjizR0qeQfwuNlsa7A==
X-CSE-MsgGUID: 1SRYPx4FQJimbAGCwveB/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63692002"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="63692002"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 20:33:24 -0700
X-CSE-ConnectionGUID: VUdPqhjeRb2L7mMeCgCrCw==
X-CSE-MsgGUID: 7ZdBpbZbRx6UeBW6+OSrbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="151105038"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 19 Jun 2025 20:33:20 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uSSVB-000LL8-2s;
	Fri, 20 Jun 2025 03:33:17 +0000
Date: Fri, 20 Jun 2025 11:32:50 +0800
From: kernel test robot <lkp@intel.com>
To: Casey Connolly <casey.connolly@linaro.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Casey Connolly <casey.connolly@linaro.org>
Subject: Re: [PATCH 09/11] power: supply: qcom_smbx: add smb5 support
Message-ID: <202506201101.9HMIR1fb-lkp@intel.com>
References: <20250619-smb2-smb5-support-v1-9-ac5dec51b6e1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619-smb2-smb5-support-v1-9-ac5dec51b6e1@linaro.org>

Hi Casey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bc6e0ba6c9bafa6241b05524b9829808056ac4ad]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Connolly/dt-bindings-power-supply-qcom-pmi89980-charger-add-pm8150b-and-7250b/20250619-230137
base:   bc6e0ba6c9bafa6241b05524b9829808056ac4ad
patch link:    https://lore.kernel.org/r/20250619-smb2-smb5-support-v1-9-ac5dec51b6e1%40linaro.org
patch subject: [PATCH 09/11] power: supply: qcom_smbx: add smb5 support
config: x86_64-buildonly-randconfig-006-20250620 (https://download.01.org/0day-ci/archive/20250620/202506201101.9HMIR1fb-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250620/202506201101.9HMIR1fb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506201101.9HMIR1fb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/power/supply/qcom_smbx.c:250 struct member 'gen' not described in 'smb_chip'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

