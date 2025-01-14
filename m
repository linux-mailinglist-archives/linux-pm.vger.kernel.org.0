Return-Path: <linux-pm+bounces-20425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E36C6A10CA5
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 17:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB3A3A790E
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7811D54F7;
	Tue, 14 Jan 2025 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQFbUFJH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFED41CDFCC;
	Tue, 14 Jan 2025 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736873182; cv=none; b=qF7WVXfYl5+kEyMYPOA0UFuY050NDe9t5qkWcdikf+mBdKqCbfVjo9PrNEEAxV+i1aFrlH673SpcjdK+zB3orADYnDChBThjLzqBIoXWEKR4JHH5uSlBE0+3ZWuXxkVbnJd4C+WzOC9k4GQ6n5LtOTyGuqsVdNYnNEMXXHi7IYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736873182; c=relaxed/simple;
	bh=33PReFVi4h84quEFzRfZtiIUtXNIsE2Hdqjko8U2cUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LO7LdRvL6DQhSudRDKRSUsDkMHYzKaTwZbFVKkcSSBPRC1baqxz261KmxBLBscY7aA4yJfiag5cPXL4PFdohH/LeycZXswvA+N9IH+w3piTcF0qF711jXdZ2CQupEPlIRpUVAOTIUOmhbsXFfNVg/sCN1jcac8iteSRzzUN7/SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQFbUFJH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736873181; x=1768409181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=33PReFVi4h84quEFzRfZtiIUtXNIsE2Hdqjko8U2cUc=;
  b=fQFbUFJHyNFwiIuPz5p5/kgmzcGrvkp7UsldOXIw0sdlO59pe4pdS2sV
   nZtz/Q/WCX590ZqS/VyqnmbUhz3SqJ5OaOGk3y1GnQ5nUDb+JuEr3GQuC
   IzqYUHE4Qh0dH967uFCJlHrcGU2nkrNL09hDHTx7J3mdiLRtxxUBpUJq9
   LIymmyG1tc93TIUt2Sky95iI45OzqTXIzeiVVInJGWldPK876fiYoDtPX
   ax0gFCEILAW4J9AjB8TYkgpGdF9kGxU0bo6i8iH9ybIUOfzWH/emmuDTf
   e3cyWDcUxUCKCdH1zx9SMDB4yJa71QoitrHOWzHmAyznuPrzETMFf+qTW
   w==;
X-CSE-ConnectionGUID: O0Zb+UxwSFOvTpb1zCAymg==
X-CSE-MsgGUID: Ai2EVxBlSSKV9kjcpYr9Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="39987904"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="39987904"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:46:20 -0800
X-CSE-ConnectionGUID: WuQQS6uuTka+n1YVpfcRuw==
X-CSE-MsgGUID: NY9ioWISRsq57xzSMib7YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110001653"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 14 Jan 2025 08:46:18 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tXk3T-000Olb-2I;
	Tue, 14 Jan 2025 16:46:15 +0000
Date: Wed, 15 Jan 2025 00:45:18 +0800
From: kernel test robot <lkp@intel.com>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] power: supply: add LT8491 battery charger driver
Message-ID: <202501150030.cWwtcIoo-lkp@intel.com>
References: <20250110080235.54808-3-johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110080235.54808-3-johnerasmusmari.geronimo@analog.com>

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a3a8799165ff83bb764fd800c6559c3cba0ddac3]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Erasmus-Mari-Geronimo/dt-bindings-power-supply-add-adi-lt8491-yaml/20250110-160441
base:   a3a8799165ff83bb764fd800c6559c3cba0ddac3
patch link:    https://lore.kernel.org/r/20250110080235.54808-3-johnerasmusmari.geronimo%40analog.com
patch subject: [PATCH 2/2] power: supply: add LT8491 battery charger driver
config: sparc64-randconfig-r071-20250114 (https://download.01.org/0day-ci/archive/20250115/202501150030.cWwtcIoo-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501150030.cWwtcIoo-lkp@intel.com/

smatch warnings:
drivers/power/supply/lt8491_charger.c:66 lt8491_read_serial_number() warn: unsigned 'serial_number[i]' is never less than zero.

vim +66 drivers/power/supply/lt8491_charger.c

    57	
    58	static int lt8491_read_serial_number(struct lt8491_info *info)
    59	{
    60		int i, ret;
    61		u32 serial_number[LT8491_MFR_DATA_LEN];
    62	
    63		for (i = 0; i < LT8491_MFR_DATA_LEN; i++) {
    64			serial_number[i] = i2c_smbus_read_word_data(info->client,
    65						LT8491_MFR_DATA1_LSB_REG + i * 2);
  > 66			if (serial_number[i] < 0)
    67				return serial_number[i];
    68		}
    69	
    70		ret = sprintf(info->serial_number, "%04x%04x%04x", serial_number[0],
    71			      serial_number[1], serial_number[2]);
    72		if (ret < 0)
    73			return ret;
    74	
    75		return 0;
    76	}
    77	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

