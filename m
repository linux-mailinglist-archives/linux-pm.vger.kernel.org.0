Return-Path: <linux-pm+bounces-42841-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OP6fH3wglmn9agIAu9opvQ
	(envelope-from <linux-pm+bounces-42841-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 21:26:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B21D01596A7
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 21:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A20DD301BEDA
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 20:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A393446DE;
	Wed, 18 Feb 2026 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkWhgHet"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BA12DF6F6;
	Wed, 18 Feb 2026 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771446392; cv=none; b=t0PsCtcM/2FVMq9z/3BjiOFPnys8EBVdjzKqz+I/LvbJgCRESQlRW7TGkQDT/3XP60RH85sUawKOm+IeIlO1cJf6kyWW6eHj2PWZCkEMpwmKnNbf2/57RbP3o4JS1ji+Iqs7VkMfj/WDSnrLYPj8WKGeDji0+SYSU4PiH+XmcLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771446392; c=relaxed/simple;
	bh=qx+Rzwjaxjl4ViOm2l2iTVOdx+of/wMm9LViGuEEgs8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qrliVSNKek3HwPL0fLF7y5toII4VJrBHQ0zpetFjXUVEyu6K/nSvzypx2pIQW4FMoSugUoNjkof/0tKb/Ckx7d4bV3Ce1vlaDWh3znlKltIk8T63vMFF/LKraev10317C/Xe0gmcgl10uW4Ot1sYAfCxujtAD4BK+TwVn8VrYfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkWhgHet; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771446391; x=1802982391;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qx+Rzwjaxjl4ViOm2l2iTVOdx+of/wMm9LViGuEEgs8=;
  b=JkWhgHetMq4Rbeo11WQOCRKCVrCWga8jQMw+L9qKn2kK/eNsXOHCqLjI
   XuEhpu3CFC2sba5cjIGLqJwm4Di1AN29od3YPJl7WkQMJVqpvIAvXO5Is
   EBlIjqWr0D0oIULlPVbHqtB2ODtdNdMzCQDJSvVr7fDDu4/NT5YXcKT7J
   Fc7Dy4ZshVYAvqwlJgmucIYV5WWUaOSHIXsZVqRAeKlTF6HmFMDU8LHeo
   KvECM26X2/OAuY0qlLkqJw4ncL2t+gPulT8tPnNTr1JwoytiXsry89O4L
   4MmzPtJCDmg6qWV7fjUrCdpKroxPKQ2SHZ7j7FSw1xE15SghPv3RL+wSv
   g==;
X-CSE-ConnectionGUID: ChoV4rtrQ9Sd1Zp6QF3jZQ==
X-CSE-MsgGUID: k5vlg02dRRW+CNds5KOw/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="83635828"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="83635828"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 12:26:30 -0800
X-CSE-ConnectionGUID: fxShg+DKSRO9IcXS9QoP7A==
X-CSE-MsgGUID: qWN9Eh7STWaOZTCENukxbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="213044833"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 12:26:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 18 Feb 2026 22:26:23 +0200 (EET)
To: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
    Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
    linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Ionut Nechita <ionut_n2001@yahoo.com>
Subject: Re: [RFC PATCH 1/3] PCI: Add PCIe Gen 7 (128 GT/s) register and
 speed definitions
In-Reply-To: <20260217080102.206581-4-sunlightlinux@gmail.com>
Message-ID: <36867a01-cc7a-6fed-bcf4-ec84263ea7c4@linux.intel.com>
References: <20260217080102.206581-2-sunlightlinux@gmail.com> <20260217080102.206581-4-sunlightlinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,linaro.org,intel.com,arm.com,wunner.de,vger.kernel.org,yahoo.com];
	TAGGED_FROM(0.00)[bounces-42841-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B21D01596A7
X-Rspamd-Action: no action

On Tue, 17 Feb 2026, Ionut Nechita (Sunlight Linux) wrote:

> From: Ionut Nechita <ionut_n2001@yahoo.com>
> 
> Add register definitions for PCIe Gen 7 128 GT/s link speed:
> 
>   - PCI_EXP_LNKCAP_SLS_128_0GB (encoding 0x7)
>   - PCI_EXP_LNKCAP2_SLS_128_0GB (bit 6 in Supported Link Speeds Vector)
>   - PCI_EXP_LNKCTL2_TLS_128_0GT (Target Link Speed 0x7)
>   - PCIE_SPEED_128_0GT enum value (0x1a)
> 
> Widen pci_dev.supported_speeds from u8 to u16 to accommodate the
> expanded Supported Link Speeds Vector which now uses bits 1-7.
> 
> PCIe Gen 7 doubles the data rate to 128 GT/s using PAM4 signaling
> with mandatory Flit mode encoding (1:1, no overhead), providing
> up to 256 GB/s unidirectional (512 GB/s bi-directional) bandwidth
> on an x16 link.
> 
> Note: Based on the PCIe 7.0 specification announced by PCI-SIG in
> 2022, targeted for member release in 2025. No hardware exists yet

2022?

Please provide more precise spec reference(s) with section numbers (as per 
the usual custom).

> to validate these definitions.
> 
> Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
> ---
>  include/linux/pci.h           | 3 ++-
>  include/uapi/linux/pci_regs.h | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b5cc0c2b99065..21dd6ea5beb6d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -303,6 +303,7 @@ enum pci_bus_speed {
>  	PCIE_SPEED_16_0GT		= 0x17,
>  	PCIE_SPEED_32_0GT		= 0x18,
>  	PCIE_SPEED_64_0GT		= 0x19,
> +	PCIE_SPEED_128_0GT		= 0x1a,
>  	PCI_SPEED_UNKNOWN		= 0xff,
>  };
>  
> @@ -558,7 +559,7 @@ struct pci_dev {
>  	struct pci_tsm *tsm;		/* TSM operation state */
>  #endif
>  	u16		acs_cap;	/* ACS Capability offset */
> -	u8		supported_speeds; /* Supported Link Speeds Vector */
> +	u16		supported_speeds; /* Supported Link Speeds Vector */
>  	phys_addr_t	rom;		/* Physical address if not from BAR */
>  	size_t		romlen;		/* Length if not from BAR */
>  	/*
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 3add74ae25948..fa00c6ca9f382 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -545,6 +545,7 @@
>  #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bit 3 */
>  #define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vector bit 4 */
>  #define  PCI_EXP_LNKCAP_SLS_64_0GB 0x00000006 /* LNKCAP2 SLS Vector bit 5 */
> +#define  PCI_EXP_LNKCAP_SLS_128_0GB 0x00000007 /* LNKCAP2 SLS Vector bit 6 */

Eh, did you make this up? This is not at all what is in the PCIe 7.0 spec!

>  #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
>  #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
>  #define  PCI_EXP_LNKCAP_ASPM_L0S 0x00000400 /* ASPM L0s Support */
> @@ -693,6 +694,7 @@
>  #define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000010 /* Supported Speed 16GT/s */
>  #define  PCI_EXP_LNKCAP2_SLS_32_0GB	0x00000020 /* Supported Speed 32GT/s */
>  #define  PCI_EXP_LNKCAP2_SLS_64_0GB	0x00000040 /* Supported Speed 64GT/s */
> +#define  PCI_EXP_LNKCAP2_SLS_128_0GB	0x00000080 /* Supported Speed 128GT/s */

This is simplifying this too much, the spec says "128 GT/s or higher".

The actual speeds are in the new 128 GT/s Capability and should be 
read from there.

>  #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
>  #define PCI_EXP_LNKCTL2		0x30	/* Link Control 2 */
>  #define  PCI_EXP_LNKCTL2_TLS		0x000f
> @@ -702,6 +704,7 @@
>  #define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
>  #define  PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
>  #define  PCI_EXP_LNKCTL2_TLS_64_0GT	0x0006 /* Supported Speed 64GT/s */
> +#define  PCI_EXP_LNKCTL2_TLS_128_0GT	0x0007 /* Supported Speed 128GT/s */

This is wrong as well.

This entire change (the whole series) is not going to be as 
straightforward as you assumed.

>  #define  PCI_EXP_LNKCTL2_ENTER_COMP	0x0010 /* Enter Compliance */
>  #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
>  #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */

-- 
 i.


