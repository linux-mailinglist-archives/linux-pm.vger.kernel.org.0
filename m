Return-Path: <linux-pm+bounces-41323-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMcuHcBqcmnckQAAu9opvQ
	(envelope-from <linux-pm+bounces-41323-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 19:21:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D406C489
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 19:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B25923003303
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 18:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7334833D6F6;
	Thu, 22 Jan 2026 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2wtkrWW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D17342CB0;
	Thu, 22 Jan 2026 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769106097; cv=none; b=Man3RCpUiUHFH7IH34QvQCW0Hl0UjtSO40dUzDwZIXhvMAHaDaEpOayogBT9183T5v265csAirDuEW/aiTNtrqMwU2G8GQiFLYMjgHgdQTDNJbIcLvXEBEH+4GgByoc7ojdOGmnBFaRJpI9uUDmSaIC71KpDh4NUTFKQWRWbb9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769106097; c=relaxed/simple;
	bh=9hfJDvPjP8hTC2y5nxOsy/1hrW2h9ywqSpuTvunhT3A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OMG6e5AwHdHyiwncD1RSkRLMbAzkSCnH/PvqSdF3WZNVuVhoNy4LvTTrlIUlcERA7u8/jNDwIwGiAXRhViSVEkGhorKSgoSFnR5ZN0HjsHApGcXCUR6rs1YkGriZA//J1CLl6LvRm2KzmhXnMivWvTLg6/aNFLl/XY6hJtrwCPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2wtkrWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBD6C116D0;
	Thu, 22 Jan 2026 18:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769106093;
	bh=9hfJDvPjP8hTC2y5nxOsy/1hrW2h9ywqSpuTvunhT3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=h2wtkrWWC2KbX2ko4GKw0YHXrWk0VR+mgT46AnKFdymZ4Ppr97h781GwDRqXjWgCD
	 /1Gz/aSYhIlyXtzkXzz1dI2VhrINMx/q5otdjWygVCZFxUTxjxQpIq+BlTB+ECZ66q
	 snYDGEJ3aT7GHD1y5br8ID/7g//Z2dclmwhLW3z0fDvEAxpVCzEhVrw8V/VcWnSipJ
	 OXNFuJ/aVKGTv5w8gw8hkzKiesBpLKxtFfRfjpObO4WWOP7wv2lzAg34FVdLRnEZvf
	 DOCurtU3QiL5UO2o0fZlnXXQAJTFCYCh3Zxp5of7jR4azw8+kEFyb3RgkODsDkNv7V
	 +8UWcXhf0QTYw==
Date: Thu, 22 Jan 2026 12:21:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v5] PCI/PM: Prevent runtime suspend until devices are
 fully initialized
Message-ID: <20260122182132.GA16540@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122094815.v5.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41323-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C5D406C489
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:48:15AM -0800, Brian Norris wrote:
> Previously, it was possible for a PCI device to be runtime-suspended before
> it was fully initialized. When that happened, the suspend process could
> save invalid device state, for example, before BAR assignment. Restoring
> the invalid state during resume may leave the device non-functional.
> 
> Prevent runtime suspend for PCI devices until they are fully initialized by
> deferring pm_runtime_enable().
> 
> More details on how exactly this may occur:
> 
>   1. PCI device is created by pci_scan_slot() or similar
> 
>   2. As part of pci_scan_slot(), pci_pm_init() puts the device in D0 and
>      prevents runtime suspend prevented via pm_runtime_forbid()
> 
>   3. pci_device_add() adds the underlying 'struct device' via device_add(),
>      which means user space can allow runtime suspend, e.g.,
> 
>        echo auto > /sys/bus/pci/devices/.../power/control
> 
>   4. PCI device receives BAR configuration
>      (pci_assign_unassigned_bus_resources(), etc.)
> 
>   5. pci_bus_add_device() applies final fixups, saves device state, and
>      tries to attach a driver
> 
> The device may potentially be suspended between #3 and #5, so this is racy
> with user space (udev or similar).
> 
> Many PCI devices are enumerated at subsys_initcall time and so will not
> race with user space, but devices created later by hotplug or modular
> pwrctrl or host controller drivers are susceptible to this race.
> 
> More runtime PM details at the first Link: below.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
> Link: https://lore.kernel.org/all/0e35a4e1-894a-47c1-9528-fc5ffbafd9e2@samsung.com/
> 
> Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
> Cc: <stable@vger.kernel.org>

Applied to pci/pm for v6.20, thanks!

> ---
> 
> Changes in v5:
>  * Put pm_runtime_set_active() back where it was, to ensure our parent
>    can't suspend before we're really ready. (See bug report in 2nd
>    "Link:")
>  * Add comments
>  * Update commit description with Bjorn's rewrite
>  * Add Marek's Tested-by
> 
> Changes in v4:
>  * Move pm_runtime_set_active() too
> 
> Changes in v3:
>  * Add Link to initial discussion
>  * Add Rafael's Reviewed-by
>  * Add lengthier footnotes about forbid vs allow vs sysfs
> 
> Changes in v2:
>  * Update CC list
>  * Rework problem description
>  * Update solution: defer pm_runtime_enable(), instead of trying to
>    get()/put()
> 
>  drivers/pci/bus.c | 7 +++++++
>  drivers/pci/pci.c | 5 ++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 4383a36fd6ca..90954f81962b 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -15,6 +15,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/proc_fs.h>
>  #include <linux/slab.h>
>  
> @@ -379,6 +380,12 @@ void pci_bus_add_device(struct pci_dev *dev)
>  		put_device(&pdev->dev);
>  	}
>  
> +	/*
> +	 * Enable runtime PM (and potentially suspend) only after we've fully
> +	 * configured the PCI state.
> +	 */
> +	pm_runtime_enable(&dev->dev);
> +
>  	if (!dn || of_device_is_available(dn))
>  		pci_dev_allow_binding(dev);
>  
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13dbb405dc31..07b0d029aa51 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3196,8 +3196,11 @@ void pci_pm_init(struct pci_dev *dev)
>  poweron:
>  	pci_pm_power_up_and_verify_state(dev);
>  	pm_runtime_forbid(&dev->dev);
> +	/*
> +	 * Mark ourselves active now, to prevent our parent from suspending
> +	 * while we finish configuring the PCI device.
> +	 */
>  	pm_runtime_set_active(&dev->dev);
> -	pm_runtime_enable(&dev->dev);
>  }
>  
>  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> -- 
> 2.52.0.457.g6b5491de43-goog
> 

