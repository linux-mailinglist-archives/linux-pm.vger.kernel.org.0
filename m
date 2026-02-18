Return-Path: <linux-pm+bounces-42818-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFgTOOHvlWlTWwIAu9opvQ
	(envelope-from <linux-pm+bounces-42818-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 17:59:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 103DA157FA0
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 17:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE50B3002538
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04A7344D85;
	Wed, 18 Feb 2026 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iVd1CVn9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8D533A9C5;
	Wed, 18 Feb 2026 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771433948; cv=none; b=Bj6wa9qgHIAhAQy03KzQ1UbtGx9koga0ucFhqT/yuwyXsFLn8l7YBEp0dmcg96Fw9AZiBxcDzra3ACvGDvBF1xVCp2bZSd16RVINNW8JMJgsIywnCkS9kFeUkwDl0jzZnMoD9FuoctRsharJjMT5gPZcNm1dfzoaDFttEpCd4To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771433948; c=relaxed/simple;
	bh=rv0N2rf5GatvQtHBquY8uQJtkNYnn9jlDezi83Fnk1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpZVZRiiEVECXi9Cgb5CYgTNgOtfv1ia6vYjCudEHIP92EP64mf7XT24SI/nSVZgWJWJyWI9Gqnii9vnmb4lXlqPEzDWX99PHON+e3dxkalnFFGNVVXwECnhkS+0ooEUY4mIJt5/QJRS0wRyLQs8SlaSvcSJ03VgqbpATlJqyTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iVd1CVn9; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771433946; x=1802969946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rv0N2rf5GatvQtHBquY8uQJtkNYnn9jlDezi83Fnk1w=;
  b=iVd1CVn9BnXCiDkQjaOe7DhL7staLTqHY6jFPCMlGaeEMUfDrJkpOVT4
   +iHIzFD0x+kIK4vxE251YMaimrebjbV00YFnig3IVLOP74cAqDhNVxjrW
   ukp/bunmRvssV4tm6u5uk7azxo4YHmVbexgasQUSVLmyTZbSKOqSR5Vp8
   AlEKnsrA0AFWdmNVUyeO5nVg2LOSxdaq+2hpTw2xNg6tEtlzDYCOyiqwc
   kVfzQ4qNr5cQQJJsvPRcHAFR6mWCLVn0V/RGk/RhE79kGgM59+dbdbBLW
   HC0HbJ2e0fPIMXwk1mTcbHfpEXw1ac9NKDT9oBBSfgBRLaQ1t0c/dDNPU
   Q==;
X-CSE-ConnectionGUID: qQ8AmmpzTG2kwfCmusdjow==
X-CSE-MsgGUID: 8IIrChlFSV6dniMjkAajww==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="83964062"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="83964062"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 08:59:06 -0800
X-CSE-ConnectionGUID: pDJla79oSkW0ateKXGfvvw==
X-CSE-MsgGUID: cNlPIIxzRGO6mWXNNZtOgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="218775369"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 18 Feb 2026 08:59:01 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vskt8-000000012Yu-3H6h;
	Wed, 18 Feb 2026 16:58:58 +0000
Date: Thu, 19 Feb 2026 00:58:34 +0800
From: kernel test robot <lkp@intel.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linusw@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, sherry.sun@nxp.com,
	driver-core@lists.linux.dev,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH v7 3/3] PCI: Add support for PCIe WAKE# interrupt
Message-ID: <202602190038.BHg9UcM5-lkp@intel.com>
References: <20260218-wakeirq_support-v7-3-0d4689830207@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218-wakeirq_support-v7-3-0d4689830207@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42818-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email,01.org:url]
X-Rspamd-Queue-Id: 103DA157FA0
X-Rspamd-Action: no action

Hi Krishna,

kernel test robot noticed the following build errors:

[auto build test ERROR on cee73b1e840c154f64ace682cb477c1ae2e29cc4]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-Chaitanya-Chundru/PM-sleep-wakeirq-Add-support-for-dedicated-shared-wake-IRQ-setup/20260218-162247
base:   cee73b1e840c154f64ace682cb477c1ae2e29cc4
patch link:    https://lore.kernel.org/r/20260218-wakeirq_support-v7-3-0d4689830207%40oss.qualcomm.com
patch subject: [PATCH v7 3/3] PCI: Add support for PCIe WAKE# interrupt
config: sparc64-randconfig-002-20260218 (https://download.01.org/0day-ci/archive/20260219/202602190038.BHg9UcM5-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260219/202602190038.BHg9UcM5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602190038.BHg9UcM5-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: drivers/pci/pci.o: in function `platform_pci_configure_wake':
>> drivers/pci/pci.c:1128:(.text+0x39c8): undefined reference to `pci_configure_of_wake_gpio'
   sparc64-linux-ld: drivers/pci/pci.o: in function `platform_pci_remove_wake':
>> drivers/pci/pci.c:1133:(.text+0x39d4): undefined reference to `pci_remove_of_wake_gpio'


vim +1128 drivers/pci/pci.c

  1125	
  1126	void platform_pci_configure_wake(struct pci_dev *dev)
  1127	{
> 1128		return pci_configure_of_wake_gpio(dev);
  1129	}
  1130	
  1131	void platform_pci_remove_wake(struct pci_dev *dev)
  1132	{
> 1133		return pci_remove_of_wake_gpio(dev);
  1134	}
  1135	/**
  1136	 * pci_update_current_state - Read power state of given device and cache it
  1137	 * @dev: PCI device to handle.
  1138	 * @state: State to cache in case the device doesn't have the PM capability
  1139	 *
  1140	 * The power state is read from the PMCSR register, which however is
  1141	 * inaccessible in D3cold.  The platform firmware is therefore queried first
  1142	 * to detect accessibility of the register.  In case the platform firmware
  1143	 * reports an incorrect state or the device isn't power manageable by the
  1144	 * platform at all, we try to detect D3cold by testing accessibility of the
  1145	 * vendor ID in config space.
  1146	 */
  1147	void pci_update_current_state(struct pci_dev *dev, pci_power_t state)
  1148	{
  1149		if (platform_pci_get_power_state(dev) == PCI_D3cold) {
  1150			dev->current_state = PCI_D3cold;
  1151		} else if (dev->pm_cap) {
  1152			u16 pmcsr;
  1153	
  1154			pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
  1155			if (PCI_POSSIBLE_ERROR(pmcsr)) {
  1156				dev->current_state = PCI_D3cold;
  1157				return;
  1158			}
  1159			dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
  1160		} else {
  1161			dev->current_state = state;
  1162		}
  1163	}
  1164	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

