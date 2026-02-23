Return-Path: <linux-pm+bounces-43061-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPvVOpyZnGmKJgQAu9opvQ
	(envelope-from <linux-pm+bounces-43061-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 19:17:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B73917B65F
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 19:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA18D3120209
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 18:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517C033B95D;
	Mon, 23 Feb 2026 18:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ge7InMPi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2DC33B6FA;
	Mon, 23 Feb 2026 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771870221; cv=none; b=EjwUc9P42vbe3xQGCQGibnU5yXBc2tf3DMJzMgiS7oUwdwGRZNpvMRxqGljIs6eV2MCtbe4Eg04/AVs9rwmXcQUY/qGKyErW5yZ+G/4/sDgeGLwVSL/E0QfcagbCwOsPFeDJWpIEoiSx3BbXzA/GCRY/61hNvrughahjSQqK9bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771870221; c=relaxed/simple;
	bh=16cOUP8C9o+EwrZvc78geBBZllCsV2dgigYYBQoJhoA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h03ck0AEMD/ew+dsldkEthxJ2TWeWWkPOnAcuHBBwHyz9nwzDsE8gVyuAvqvtz23gXSoEc+eoX7AyCAq2arveWdHkW56H/shP+D0FyhB2ODpQq08uMqpy/Fyxm6i/Op+DWfFcc84fIzGlwziQ/PbGLb2LQ8OnJCN8N/VRMdM8wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ge7InMPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E68CC116C6;
	Mon, 23 Feb 2026 18:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771870220;
	bh=16cOUP8C9o+EwrZvc78geBBZllCsV2dgigYYBQoJhoA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ge7InMPiu+LiA49+/qUlTyPFdeX/VLo2FmpjYMVekRpxG8DwIpZZLLJGHvuciBb/F
	 BiJbJRfZ3kyZVGu/ykJQJhBc/X6DN7getwKS8cmKu2D14oivJw1HQW1Q4JQdodyBbd
	 lygozEiECso5Xb8cBqTojfUQ0r1Dk5v9ZEa0Pk0BODbUW3jC6ov7L/fL30hC033jDC
	 fpLzenRyc4/7FrizehKsOF9cqmj7Ikf0+8XfVRJv84rmU4HoQigfciiXUXI7C6ZyfA
	 jjiu537s4GsdsHayFjk2RtLtInMQQYEyhHdtzO8h6kpQ3m0RoBCpgieQBWlD7nPLki
	 W6xQbOZiQTarw==
Date: Mon, 23 Feb 2026 12:10:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, jonathanh@nvidia.com,
	bjorn.andersson@oss.qualcomm.com,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] PCI: host-common: Add helper to determine host
 bridge D3cold eligibility
Message-ID: <20260223181019.GA3700351@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217-d3cold-v2-1-89b322864043@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43061-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,vger.kernel.org,lists.infradead.org,nvidia.com,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B73917B65F
X-Rspamd-Action: no action

[+cc Rafael, linux-pm]

On Tue, Feb 17, 2026 at 04:49:06PM +0530, Krishna Chaitanya Chundru wrote:
> Add a common helper, pci_host_common_can_enter_d3cold(), to determine
> whether a PCI host bridge can safely transition to D3cold.
> 
> This helper is intended to be used by PCI host controller drivers to
> decide whether they may safely put the host bridge into D3cold based on
> the power state and wakeup capabilities of downstream endpoints.
> 
> The helper walks all devices on the bridge's primary bus and only allows
> the host bridge to enter D3cold if all PCIe endpoints are already in
> PCI_D3hot. This ensures that we do not power off the host bridge while
> any active endpoint still requires the link to remain powered.
> 
> For devices that may wake the system, the helper additionally requires
> that the device supports PME wake from D3cold (via WAKE#). Devices that
> do not have wakeup enabled are not restricted by this check and do not
> block the host bridge from entering D3cold.
> 
> Devices without a bound driver and with PCI not enabled via sysfs are
> treated as inactive and therefore do not prevent the host bridge from
> entering D3cold. This allows controllers to power down more aggressively
> when there are no actively managed endpoints.

This series is currently structured so it's only applicable to native
host bridge drivers, i.e., things using DT.  Is there anything that
prevents using D3cold for host bridges in ACPI systems?

> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/pci-host-common.c | 45 ++++++++++++++++++++++++++++++++
>  drivers/pci/controller/pci-host-common.h |  2 ++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index d6258c1cffe5ec480fd2a7e50b3af39ef6ac4c8c..b0a4a3c995e80e0245657f0273a349334071013c 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -106,5 +106,50 @@ void pci_host_common_remove(struct platform_device *pdev)
>  }
>  EXPORT_SYMBOL_GPL(pci_host_common_remove);
>  
> +static int pci_host_common_check_d3cold(struct pci_dev *pdev, void *userdata)
> +{
> +	bool *d3cold_allow = userdata;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +		return 0;
> +
> +	if (!pdev->dev.driver && !pci_is_enabled(pdev))
> +		return 0;
> +
> +	if (pdev->current_state != PCI_D3hot)
> +		goto exit;
> +
> +	if (device_may_wakeup(&pdev->dev) && !pci_pme_capable(pdev, PCI_D3cold))
> +		goto exit;
> +
> +	return 0;
> +exit:
> +	*d3cold_allow = false;
> +	return -EBUSY;
> +}
> +
> +/**
> + * pci_host_common_can_enter_d3cold - Determine whether a host bridge may enter D3cold
> + * @bridge: PCI host bridge to check
> + *
> + * Walk downstream PCIe endpoint devices and determine whether the host bridge
> + * is permitted to transition to D3cold.
> + *
> + * The host bridge may enter D3cold only if all active PCIe endpoints are in
> + * %PCI_D3hot and any wakeup-enabled endpoint is capable of generating PME from
> + * D3cold. Inactive endpoints are ignored.
> + *
> + * Return: %true if the host bridge may enter D3cold, otherwise %false.
> + */
> +bool pci_host_common_can_enter_d3cold(struct pci_host_bridge *bridge)
> +{
> +	bool d3cold_allow = true;
> +
> +	pci_walk_bus(bridge->bus, pci_host_common_check_d3cold, &d3cold_allow);
> +
> +	return d3cold_allow;
> +}
> +EXPORT_SYMBOL_GPL(pci_host_common_can_enter_d3cold);
> +
>  MODULE_DESCRIPTION("Common library for PCI host controller drivers");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
> index b5075d4bd7eb31fbf1dc946ef1a6afd5afb5b3c6..18a731bca058828340bca84776d0e91da1edbbf7 100644
> --- a/drivers/pci/controller/pci-host-common.h
> +++ b/drivers/pci/controller/pci-host-common.h
> @@ -20,4 +20,6 @@ void pci_host_common_remove(struct platform_device *pdev);
>  
>  struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
>  	struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
> +
> +bool pci_host_common_can_enter_d3cold(struct pci_host_bridge *bridge);
>  #endif
> 
> -- 
> 2.34.1
> 

