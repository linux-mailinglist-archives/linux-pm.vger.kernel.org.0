Return-Path: <linux-pm+bounces-42843-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C/iGqEplmnUbgIAu9opvQ
	(envelope-from <linux-pm+bounces-42843-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 22:05:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D47159C59
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 22:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F98C3002530
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 21:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AF83385AA;
	Wed, 18 Feb 2026 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqEk6aEq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E57F3191BB;
	Wed, 18 Feb 2026 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771448733; cv=none; b=DjprKWBFKTQRzAphQ0WjPsnnJW0dE9+i17/k8vJqM033qw3PoYtiq3nD5/6Z4Hy9Tgr9LvUlwSlLvtOSgvXrk3QF6SwYT/HsS5FZTceQshqC14Rtd6AnJOIjqTmWoWGlPxRlanfcjmUT0oJZRmgwGf2P7hxSnmKToRaH5AzxvVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771448733; c=relaxed/simple;
	bh=1Lfxpeg8BSocI20oyn128+XYsg+gyDtAclOE5cwZdX0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ra3BcN23z8FvU8pL1qvBga6A96lD+n1IKNRYsdYpQ7ysN8j6sQnRYDUE44s/3QmbPdFdrtdZ3rcTl15dY+iPoDYg+Y98mNQiED93MSVhLK/7OZpVClTPkYBkF2wtmwx2Zd5i0XRT6sS69t0VQYbb5L7aCs/CkRGF6SKyeceEXtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqEk6aEq; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771448731; x=1802984731;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1Lfxpeg8BSocI20oyn128+XYsg+gyDtAclOE5cwZdX0=;
  b=nqEk6aEqJA560T9t69tH9QD4kX3OrbvieaT9R1p4azHF0VBJBVvZCKiy
   Qae0SwYEODT+9h5Yn8u/yiYBwGic7CxTerg6ztFWsfV4YPNIUoe0y/b+X
   B4CryxfeRtyI+cMxhU3YYsSBM3YavhrOYWdiH8U0+qy+XqZJSHeuY+hA8
   y5/38+DoAGQsjL6uTU5oG9qkis1vDKI9gmR9LQ4dzYz+8Dq3vg91n18LP
   KglvdcEmbIpcqnJX7ovs1tR5n0LFSxQnteohnp1NCF46go+ID/5qeltEo
   22+wWPbWKpwWUfbrGvWysOei/r9DIsOL15G5hu9FBmxHQwYgt6VyFXWmw
   g==;
X-CSE-ConnectionGUID: gvgjpUL2SeqMSD05gLkpkQ==
X-CSE-MsgGUID: vCb92ym3Toiz4y+AsuE+jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="75144495"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="75144495"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 13:05:30 -0800
X-CSE-ConnectionGUID: YNzBpVIIQ8GTvFcVkiTgaw==
X-CSE-MsgGUID: kmvd8FMMSCi7Ag/6sT7PLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="214163119"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 13:05:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 18 Feb 2026 23:05:23 +0200 (EET)
To: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
    Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
    linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Ionut Nechita <ionut_n2001@yahoo.com>
Subject: Re: [RFC PATCH 2/3] PCI: Add PCIe Gen 7 (128 GT/s) speed detection
 and reporting
In-Reply-To: <20260217080102.206581-6-sunlightlinux@gmail.com>
Message-ID: <b4147a1c-0c2f-f4f1-a0c1-c296b3d1346a@linux.intel.com>
References: <20260217080102.206581-2-sunlightlinux@gmail.com> <20260217080102.206581-6-sunlightlinux@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,linaro.org,intel.com,arm.com,wunner.de,vger.kernel.org,yahoo.com];
	TAGGED_FROM(0.00)[bounces-42843-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 98D47159C59
X-Rspamd-Action: no action

On Tue, 17 Feb 2026, Ionut Nechita (Sunlight Linux) wrote:

> From: Ionut Nechita <ionut_n2001@yahoo.com>
> 
> Add kernel infrastructure to detect and report PCIe Gen 7 128 GT/s
> link speeds:
> 
>   - Extend PCIE_LNKCAP_SLS2SPEED, PCIE_LNKCAP2_SLS2SPEED, and
>     PCIE_LNKCTL2_TLS2SPEED macros with 128 GT/s mapping
>   - Add 128 GT/s to PCIE_SPEED2MBS_ENC bandwidth calculation using
>     1:1 Flit mode encoding (no overhead), consistent with Gen 6
>   - Add PCIE_SPEED_128_0GT to pcie_dev_speed_mbps() switch
>   - Map link speed encoding 7 to PCIE_SPEED_128_0GT in
>     pcie_link_speed[] table
>   - Add "128.0 GT/s PCIe" display string
>   - Add pcie_speed_requires_flit() helper for Gen 6+ speed
>     validation with proper range check against PCI_SPEED_UNKNOWN
>   - Widen pcie_get_supported_speeds() return type from u8 to u16

These are all visible from the patch and as such seem pretty redundant 
information.

>   - Add Flit mode diagnostic warning when Gen 6+ speed is active
>     but PCI_EXP_LNKSTA2_FLIT is not set
> 
> Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
> ---
>  drivers/pci/pci.c   |  7 +++++--
>  drivers/pci/pci.h   | 28 ++++++++++++++++++++++------
>  drivers/pci/probe.c |  3 ++-
>  3 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13dbb405dc31f..8091f7bf30e6f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5912,10 +5912,10 @@ EXPORT_SYMBOL(pcie_bandwidth_available);
>   *
>   * Return: Supported Link Speeds Vector (+ reserved 0 at LSB).
>   */
> -u8 pcie_get_supported_speeds(struct pci_dev *dev)
> +u16 pcie_get_supported_speeds(struct pci_dev *dev)
>  {
>  	u32 lnkcap2, lnkcap;
> -	u8 speeds;
> +	u16 speeds;
>  
>  	/*
>  	 * Speeds retain the reserved 0 at LSB before PCIe Supported Link
> @@ -6020,6 +6020,9 @@ void __pcie_print_link_status(struct pci_dev *dev, bool verbose)
>  
>  	if (dev->bus && dev->bus->flit_mode)
>  		flit_mode = ", in Flit mode";
> +	else if (dev->bus && pcie_speed_requires_flit(dev->bus->cur_bus_speed))
> +		pci_warn(dev, "Flit mode not active at %s, expected for Gen 6+\n",
> +			 pci_speed_string(dev->bus->cur_bus_speed));

This looks entirely unrelated to the new speed, please put it into own 
patch (and justification in the changelog).

>  
>  	if (bw_avail >= bw_cap && verbose)
>  		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)%s\n",
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 60542b05de0c6..4dd23f0d5de9f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -487,7 +487,8 @@ void pci_bus_put(struct pci_bus *bus);
>  ({									\
>  	u32 lnkcap_sls = (lnkcap) & PCI_EXP_LNKCAP_SLS;			\
>  									\
> -	(lnkcap_sls == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
> +	(lnkcap_sls == PCI_EXP_LNKCAP_SLS_128_0GB ? PCIE_SPEED_128_0GT :	\
> +	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
>  	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :	\
>  	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :	\
>  	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :	\
> @@ -498,7 +499,8 @@ void pci_bus_put(struct pci_bus *bus);
>  
>  /* PCIe link information from Link Capabilities 2 */
>  #define PCIE_LNKCAP2_SLS2SPEED(lnkcap2) \
> -	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_64_0GB ? PCIE_SPEED_64_0GT : \
> +	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_128_0GB ? PCIE_SPEED_128_0GT : \
> +	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_64_0GB ? PCIE_SPEED_64_0GT : \
>  	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_32_0GB ? PCIE_SPEED_32_0GT : \
>  	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_16_0GB ? PCIE_SPEED_16_0GT : \
>  	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_8_0GB ? PCIE_SPEED_8_0GT : \
> @@ -510,7 +512,8 @@ void pci_bus_put(struct pci_bus *bus);
>  ({									\
>  	u16 lnkctl2_tls = (lnkctl2) & PCI_EXP_LNKCTL2_TLS;		\
>  									\
> -	(lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT :	\
> +	(lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_128_0GT ? PCIE_SPEED_128_0GT :	\
> +	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT :	\
>  	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_32_0GT ? PCIE_SPEED_32_0GT :	\
>  	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_16_0GT ? PCIE_SPEED_16_0GT :	\
>  	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_8_0GT ? PCIE_SPEED_8_0GT :	\
> @@ -519,9 +522,14 @@ void pci_bus_put(struct pci_bus *bus);
>  	 PCI_SPEED_UNKNOWN);						\
>  })
>  
> -/* PCIe speed to Mb/s reduced by encoding overhead */
> +/* PCIe speed to Mb/s reduced by encoding overhead:
> + *   Gen 1-2 (2.5, 5 GT/s):       8b/10b encoding
> + *   Gen 3-5 (8, 16, 32 GT/s):    128b/130b encoding
> + *   Gen 6+  (64, 128 GT/s):      Flit mode, 1:1 (no encoding overhead)
> + */
>  #define PCIE_SPEED2MBS_ENC(speed) \
> -	((speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \
> +	((speed) == PCIE_SPEED_128_0GT ? 128000*1/1 : \
> +	 (speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \
>  	 (speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
>  	 (speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
>  	 (speed) == PCIE_SPEED_8_0GT  ?  8000*128/130 : \
> @@ -544,6 +552,8 @@ static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
>  		return 32000;
>  	case PCIE_SPEED_64_0GT:
>  		return 64000;
> +	case PCIE_SPEED_128_0GT:
> +		return 128000;
>  	default:
>  		break;
>  	}
> @@ -551,7 +561,13 @@ static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
>  	return -EINVAL;
>  }
>  
> -u8 pcie_get_supported_speeds(struct pci_dev *dev);
> +/* PCIe Gen 6+ (>= 64 GT/s) requires Flit mode with 1:1 encoding */
> +static inline bool pcie_speed_requires_flit(enum pci_bus_speed speed)
> +{
> +	return speed >= PCIE_SPEED_64_0GT && speed <= PCIE_SPEED_128_0GT;
> +}
> +
> +u16 pcie_get_supported_speeds(struct pci_dev *dev);
>  const char *pci_speed_string(enum pci_bus_speed speed);
>  void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
>  void pcie_report_downtraining(struct pci_dev *dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 9d4eeda5ea946..031c3ec8615d2 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -774,7 +774,7 @@ const unsigned char pcie_link_speed[] = {
>  	PCIE_SPEED_16_0GT,		/* 4 */
>  	PCIE_SPEED_32_0GT,		/* 5 */
>  	PCIE_SPEED_64_0GT,		/* 6 */
> -	PCI_SPEED_UNKNOWN,		/* 7 */
> +	PCIE_SPEED_128_0GT,		/* 7 */
>  	PCI_SPEED_UNKNOWN,		/* 8 */
>  	PCI_SPEED_UNKNOWN,		/* 9 */
>  	PCI_SPEED_UNKNOWN,		/* A */
> @@ -816,6 +816,7 @@ const char *pci_speed_string(enum pci_bus_speed speed)
>  	    "16.0 GT/s PCIe",		/* 0x17 */
>  	    "32.0 GT/s PCIe",		/* 0x18 */
>  	    "64.0 GT/s PCIe",		/* 0x19 */
> +	    "128.0 GT/s PCIe",		/* 0x1a */
>  	};
>  
>  	if (speed < ARRAY_SIZE(speed_strings))
> 

-- 
 i.


