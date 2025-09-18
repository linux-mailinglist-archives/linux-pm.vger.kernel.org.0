Return-Path: <linux-pm+bounces-32935-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C62F9B32B5C
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 19:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873501BC6DEB
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 17:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42081DEFF5;
	Sat, 23 Aug 2025 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHwuCjtl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971EB35975;
	Sat, 23 Aug 2025 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755971128; cv=none; b=IqUK+K91ly9K62FHae+1YdYwntuy6mQYaEMnh0+0AFvtDbQ21euJmOo6VmN73QVbx1ZR2ygoornA9e/MC/gQXpledkD6OLEwN+fzXLu1pMq9y0dy4vMn2Nd/5LK0y84XUqxV5PyWlY9C9+BdZb2789khGtZfA4TwUAVFUqW6OEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755971128; c=relaxed/simple;
	bh=B7vOtBDinax+9jsMDcERwJYTAtQqQFK1u1ffILtwcto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0S3QuZeIAE3qNTEPXREnV23qRqjUShKcDyltsD1IGfDRaWIoiJOP8wqnhHYCTpmS/27Xxnw6tgEDYNZazn62MG2UguuII3bqIX+u1v38M8BZUS4vYT2YxxOZhgNRk1IGTU8atU2oN6Vv9IwbqPc5aFSS4pEdh6azST0BshYicA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHwuCjtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD7DC4CEE7;
	Sat, 23 Aug 2025 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755971128;
	bh=B7vOtBDinax+9jsMDcERwJYTAtQqQFK1u1ffILtwcto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CHwuCjtlKsnaSiOLrym9s622h80TWlk+JWEzjkkwmC0P1EMmWb8QmjOd81JeWiKPP
	 u+trPXQjYe94wr2QSB1ok1AqNaKGiG+EMomqKPYZKIqEns1ABRoR1eI/H5pMfnjcUm
	 BcQxX+iRx4fKFP5McaZynL+nuXZHkCOuJEPO3BCAHuMfLhc+lTcDW5IXP8OAGMmNSb
	 SY8dkhqxwtGW7+dbhg2teoIbbec3t1wbdNWQEMR4Xh7rMZC4fMWiAXCfbAjgyK+3k2
	 jGSqDrbqpWTNthei3reQE7c82yf/55nmhnQeft5RDM5w0oO+ZoUroLRuFmX97mKKl0
	 yHXMy5Ql8jszQ==
Date: Sat, 23 Aug 2025 23:15:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: rafael@kernel.org, bhelgaas@google.com, vicamo.yang@canonical.com, 
	kenny@panix.com, ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] PCI/ASPM: Add host-bridge API to override default
 ASPM/CLKPM link state
Message-ID: <fkhd3aoy6jfwjftahsyazx362lpolrtsqdq4r57dxckquysdqx@moqdkybs3m7e>
References: <20250822031159.4005529-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822031159.4005529-1-david.e.box@linux.intel.com>

On Thu, Aug 21, 2025 at 08:11:57PM GMT, David E. Box wrote:
> Synthetic PCIe hierarchies, such as those created by Intel VMD, are not
> enumerated by firmware and do not receive BIOS-provided ASPM or CLKPM
> defaults. Devices in such domains may therefore run without the intended
> power management.
> 
> Add a host-bridge mechanism that lets controller drivers supply their own
> defaults. A new aspm_default_link_state field in struct pci_host_bridge is
> set via pci_host_set_default_pcie_link_state(). During link initialization,
> if this field is non-zero, ASPM and CLKPM defaults come from it instead of
> BIOS.
> 
> This enables drivers like VMD to align link power management with platform
> expectations and avoids embedding controller-specific quirks in ASPM core
> logic.
> 
> Link: https://patchwork.ozlabs.org/project/linux-pci/patch/20250720190140.2639200-1-david.e.box%40linux.intel.com/
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Tested this patch along with the change in the Qcom controller driver. So,

Tested-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks for the work!

- Mani

> ---
> 
> Changes in V1 from RFC:
> 
>   -- Rename field to aspm_dflt_link_state since it stores
>      PCIE_LINK_STATE_XXX flags, not a policy enum.
>   -- Move the field to struct pci_host_bridge since it's being applied to
>      the entire host bridge per Mani's suggestion.
>   -- During testing noticed that clkpm remained disabled and this was
>      also handled by the formerly used pci_enable_link_state(). Add a
>      check in pcie_clkpm_cap_init() as well to enable clkpm during init.
> 
> Changes in V2:
> 
>   -- Host field name changed to aspm_default_link_state.
>   -- Added get/set functions for aspm_default_link_state. Only the
>      setter is exported. Added a kernel-doc describing usage and
>      particulars around meaning of 0.
> 
>  drivers/pci/pcie/aspm.c | 42 +++++++++++++++++++++++++++++++++++++++--
>  include/linux/pci.h     |  9 +++++++++
>  2 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 919a05b97647..b4f0b4805a35 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -373,6 +373,39 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
>  	pcie_set_clkpm_nocheck(link, enable);
>  }
>  
> +/**
> + * pci_host_set_default_pcie_link_state - set controller-provided default ASPM/CLKPM mask
> + * @host: host bridge on which to apply the defaults
> + * @state: PCIE_LINK_STATE_XXX flags
> + *
> + * Allows a PCIe controller driver to specify the default ASPM and/or
> + * Clock Power Management (CLKPM) link state mask that will be used
> + * for links under this host bridge during ASPM/CLKPM capability init.
> + *
> + * The value is consumed in pcie_aspm_cap_init() and pcie_clkpm_cap_init()
> + * to override the firmware-discovered defaults.
> + *
> + * Interpretation of aspm_default_link_state:
> + *   - Nonzero: bitmask of PCIE_LINK_STATE_* values to be used as defaults
> + *   - Zero:    no override provided; ASPM/CLKPM defaults fall back to
> + *              values discovered in hardware/firmware
> + *
> + * Note: zero is always treated as "unset", not as "force ASPM/CLKPM off".
> + */
> +void pci_host_set_default_pcie_link_state(struct pci_host_bridge *host,
> +					  unsigned int state)
> +{
> +	host->aspm_default_link_state = state;
> +}
> +EXPORT_SYMBOL_GPL(pci_host_set_default_pcie_link_state);
> +
> +static u32 pci_host_get_default_pcie_link_state(struct pci_dev *parent)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(parent->bus);
> +
> +	return host ? host->aspm_default_link_state : 0;
> +}
> +
>  static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>  {
>  	int capable = 1, enabled = 1;
> @@ -394,7 +427,10 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
>  			enabled = 0;
>  	}
>  	link->clkpm_enabled = enabled;
> -	link->clkpm_default = enabled;
> +	if (pci_host_get_default_pcie_link_state(link->pdev) & PCIE_LINK_STATE_CLKPM)
> +		link->clkpm_default = 1;
> +	else
> +		link->clkpm_default = enabled;
>  	link->clkpm_capable = capable;
>  	link->clkpm_disable = blacklist ? 1 : 0;
>  }
> @@ -866,7 +902,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  	}
>  
>  	/* Save default state */
> -	link->aspm_default = link->aspm_enabled;
> +	link->aspm_default = pci_host_get_default_pcie_link_state(parent);
> +	if (!link->aspm_default)
> +		link->aspm_default = link->aspm_enabled;
>  
>  	/* Setup initial capable state. Will be updated later */
>  	link->aspm_capable = link->aspm_support;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 59876de13860..8947cbaf9fa6 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -620,6 +620,10 @@ struct pci_host_bridge {
>  	unsigned int	size_windows:1;		/* Enable root bus sizing */
>  	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
>  
> +#ifdef CONFIG_PCIEASPM
> +	unsigned int	aspm_default_link_state;	/* Controller-provided default */
> +#endif
> +
>  	/* Resource alignment requirements */
>  	resource_size_t (*align_resource)(struct pci_dev *dev,
>  			const struct resource *res,
> @@ -1849,6 +1853,8 @@ int pci_disable_link_state(struct pci_dev *pdev, int state);
>  int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
>  int pci_enable_link_state(struct pci_dev *pdev, int state);
>  int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
> +void pci_host_set_default_pcie_link_state(struct pci_host_bridge *host,
> +					  unsigned int state);
>  void pcie_no_aspm(void);
>  bool pcie_aspm_support_enabled(void);
>  bool pcie_aspm_enabled(struct pci_dev *pdev);
> @@ -1861,6 +1867,9 @@ static inline int pci_enable_link_state(struct pci_dev *pdev, int state)
>  { return 0; }
>  static inline int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
>  { return 0; }
> +static inline void
> +pci_host_set_default_pcie_link_state(struct pci_host_bridge *host,
> +				     unsigned int state) { }
>  static inline void pcie_no_aspm(void) { }
>  static inline bool pcie_aspm_support_enabled(void) { return false; }
>  static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
> 
> base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

