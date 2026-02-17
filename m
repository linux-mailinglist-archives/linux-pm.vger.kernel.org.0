Return-Path: <linux-pm+bounces-42764-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ItZHl6dlGmrFwIAu9opvQ
	(envelope-from <linux-pm+bounces-42764-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 17:54:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7418914E6D6
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 17:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A1D9300602B
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D24936F402;
	Tue, 17 Feb 2026 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYWqrTK8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6A736D51B;
	Tue, 17 Feb 2026 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771347289; cv=none; b=pjnzD+a1vOaGiauv6wmY85EmbHhmMc5g2XrBNpxa0xuv4BbcXeK+HhByEOmzsLHyYrxEpIgmBEQCKOXBAstnfsQozAABDoeGkpLhl+PQVPVciU+qbhvb8ai23h7/faLX8io6P9oPCwTinCZ+dd+UHugtJeZNBmeZzKH11fQ0g3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771347289; c=relaxed/simple;
	bh=Y3Fy5Lc/I4IpIBx75svNgPnLo2jSF1OPdd+J4APXBpI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AhaEb149lyvxsbR8sFAkW3Fzq0g5QrZ2K0CGtlgwqKCu+PSJtYIzzBrzYdzD+nrQiAk9mlkipciEtpliKvlgUhxSncs7ssgW6q0+JYh6IcAuHENWH1l2hys7mr/RP6XUt3uPndTCQ6wIWCnpJ3DipV+zQZrogqvQMrJ79hGWKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYWqrTK8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771347286; x=1802883286;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Y3Fy5Lc/I4IpIBx75svNgPnLo2jSF1OPdd+J4APXBpI=;
  b=bYWqrTK8b+Xf+IBjuxB/4AIcy670Ab2OJvsjJFoxRU5LKY2wn1q+WR6l
   28SgXVKj1EolzkNyF89GW7f0GW79tNY4IIvnSKi6QM4wEl97dhiSQNuJK
   GoERHeX2Z5PqFHD8he/TMlwuvCfmABaG9UNDVZcFUikynG9nBXT/TYckK
   Mrr6vGAdTQxblrLvrFq/ikrZE5Amieihby6hg2cYiLaTGub58Ap8SPNpJ
   y9VpT0Ck8MB+MddSC+wMAzk/gxrTrHMdQGQJeorkwaWuSV6/GNmU9PfFU
   ZTkxNlirNqZ9vNQ9XD8gQvjK7CWUFugiaUvGBDAjsihDTGmJlrHy4E5xW
   w==;
X-CSE-ConnectionGUID: 1oZiWjz6TGSiDGWcdi+07w==
X-CSE-MsgGUID: C6xNtf7KT9aMcqXtVvZw1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="97880748"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="97880748"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 08:54:45 -0800
X-CSE-ConnectionGUID: FbfGvy+qTz6X6YbUyhdRYQ==
X-CSE-MsgGUID: ckY2InvjQTy6Z+3MfbPd1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="213945652"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 08:54:46 -0800
Message-ID: <9b639ed0-1765-4cca-814e-18a1260e01b9@linux.intel.com>
Date: Tue, 17 Feb 2026 08:54:46 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260213231428.613164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260213231428.613164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,wunner.de:email,linux.intel.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sathyanarayanan.kuppuswamy@linux.intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42764-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 7418914E6D6
X-Rspamd-Action: no action

Hi Rafael,

On 2/13/2026 3:14 PM, Kuppuswamy Sathyanarayanan wrote:
> On Intel Catlow Lake platforms, PCH PCIe root ports do not reliably
> update PME status registers (PME Status and PME Requester_ID in the
> Root Status register) during D3hot to D0 transitions, even though PME
> interrupts are delivered correctly.
> 
> This issue manifests during PCIe hotplug operations as follows:
> 
> 1. After a hot-remove event, the PCIe port transitions to D3hot and
>    the hotplug interrupt enable (HPIE) flag is disabled as the port
>    enters low power state.
> 
> 2. When a hot-add occurs while the port is in D3hot, a PME interrupt
>    fires as expected to wake the port.
> 
> 3. However, the PME interrupt handler finds the PME_Status and
>    PME_Requester_ID registers unpopulated, preventing identification
>    of which device triggered the PME. The handler returns IRQ_NONE,
>    leaving the port in D3hot.
> 
> 4. Because the port remains in D3hot with HPIE disabled, the hotplug
>    driver ignores the hot-add event, resulting in the newly inserted
>    device not being recognized.
> 
> The PME interrupt delivery mechanism itself works correctly;
> interrupts arrive reliably. The problem is purely the missing status
> register updates. Verification via IOSF-SideBand (IOSF-SB) backdoor
> reads confirms that these registers remain empty when the PME
> interrupt fires. Neither BIOS nor kernel code is clearing these
> registers.
> 
> This issue is present in all steppings of Catlow Lake PCH and affects
> customers in production deployments. A public hardware errata document
> is not yet available.
> 
> Work around this issue by disabling runtime PM for affected ports,
> keeping them in D0 during runtime operation. This ensures hotplug
> events are handled via direct interrupts rather than relying on
> unreliable PME-based wakeup.
> 
> During system suspend/resume, PCIe ports are resumed unconditionally
> when coming out of system sleep due to DPM_FLAG_SMART_SUSPEND set by
> pcie_portdrv_probe(), and pciehp re-enables interrupts and checks slot
> occupation status during resume.
> 
> The quirk is applied only to Catlow PCH PCIe root ports (device IDs
> 0x7a30 through 0x7a4b). Catlow CPU PCIe ports are not affected as
> they are not hotplug-capable.
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---

Could you please review this patch and let us know if calling
pm_runtime_disable() from a PCI quirk is acceptable?

The quirk keeps specific Catlow Lake PCH PCIe root ports in D0 to
work around a hardware bug where PME status registers are not reliably
updated during D3hot to D0 transitions, causing hotplug events to be
missed.

System suspend/resume is unaffected as DPM_FLAG_SMART_SUSPEND ensures
ports are resumed unconditionally and pciehp checks slot occupation
on resume.


> 
> Changes since v1:
>  * Removed hack in hotplug driver and disabled runtime PM on affected ports.
>  * Fixed the commit log and comments accordingly.
> 
>  drivers/pci/quirks.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 280cd50d693b..779cd65b1a8a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6340,3 +6340,52 @@ static void pci_mask_replay_timer_timeout(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer_timeout);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer_timeout);
>  #endif
> +
> +/*
> + * Intel Catlow Lake PCH PCIe root ports have a hardware issue where
> + * PME status registers (PME Status and PME Requester_ID in Root Status)
> + * are not reliably updated during D3hot to D0 transitions, even though
> + * PME interrupts are delivered correctly.
> + *
> + * When a hotplug event occurs while the port is in D3hot, the PME
> + * interrupt fires but the status registers remain empty. This prevents
> + * the PME handler from identifying the event source, leaving the port
> + * in D3hot and causing the hotplug driver to miss the event.
> + *
> + * Disable runtime PM to keep these ports in D0, ensuring hotplug events
> + * are handled via direct interrupts.
> + */
> +static void quirk_intel_catlow_pcie_no_pme_wakeup(struct pci_dev *dev)
> +{
> +	pm_runtime_disable(&dev->dev);
> +	pci_info(dev, "Catlow PCH port: PME status unreliable, disabling runtime PM\n");
> +}
> +/* Apply quirk to Catlow Lake PCH root ports (0x7a30 - 0x7a4b) */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a30, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a31, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a32, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a33, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a34, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a35, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a36, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a37, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a38, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a39, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3a, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3b, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3c, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3d, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3e, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3f, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a40, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a41, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a42, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a43, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a44, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a45, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a46, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a47, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a48, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a49, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a4a, quirk_intel_catlow_pcie_no_pme_wakeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a4b, quirk_intel_catlow_pcie_no_pme_wakeup);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


