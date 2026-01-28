Return-Path: <linux-pm+bounces-41634-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P4SE7dDemmr4wEAu9opvQ
	(envelope-from <linux-pm+bounces-41634-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 18:13:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C48EEA6A02
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 18:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3624326D9B2
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 16:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4802436EAA1;
	Wed, 28 Jan 2026 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f71woEqR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2382536BCE6;
	Wed, 28 Jan 2026 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619247; cv=none; b=Q4jIO0/aNYlisLJ/zLApbaTou7Xb0Yq77HbpGHWRWUnkCZS1xcaF9tkCKFUA9cMUC4Kxd/t/i3z8YarWFRzFk0AYj8ZqD2KqovAsshRkpxerkHGUGG4sj0rn1CcpcRjRvLJVeE4GytoKphLPoVfNR5GoCWpFiL8AEa/sgaDZ/yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619247; c=relaxed/simple;
	bh=wjD1JjU+ufMC6qAGdcVwazuGSHIwkRbdDsek0eB02g0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GY7qNexGX08N67LHDODYbgJxMbhm1qGzWDMHK5w9AJCmnXvuXS5IaQCmnE0ljKyOB2KxN+amg/Xopb6gB2mZZkC6yWa8A7poKs2S/VxaYtGs/ternqAgI5Wq8ROOjAMtwrucYGznpgX6P3AVFocRxltuwcEJfXAfsKGnQATQiRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f71woEqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ABCC4CEF1;
	Wed, 28 Jan 2026 16:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619246;
	bh=wjD1JjU+ufMC6qAGdcVwazuGSHIwkRbdDsek0eB02g0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=f71woEqR3TUr+lS24Y4wNcYEiO6+oCU4HWInsmAWCYA1950UIl6+PYOG6Meoz/M5b
	 i78IMS/LFpX7BMHpXqZ0iX3CmegKGCyiytk0l0J1zrEgR+b2OV/Me9v+EqlszCDPP/
	 DsoN2t9EUwlT7yCuZ5hEbFAI2m22a8rswfn6/YKXMJmsXR3pfP6U7YUtqToVSCSZkK
	 fJFzwRbs0FNej8C30P0BzPokpFD9HcQ/i5okTPETjUJfEdQmi71nzMDrIAfxZLJihU
	 4vXsEtQVK8KwVyIyWWTlIyoB8WfgNkgt80yBX1Elq1e7fuMzIKO+9wwSU6DQ5lMcXP
	 DWESbn/ZURc7g==
Date: Wed, 28 Jan 2026 10:54:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 0/2] PCI: Add initial support for handling PCIe M.2
 connectors in devicetree
Message-ID: <20260128165404.GA421308@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128-pci-m2-v7-0-9b3a5fe3d244@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41634-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C48EEA6A02
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 09:07:14PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> This series is an initial attempt to support the PCIe M.2 connectors in the
> kernel and devicetree binding. The PCIe M.2 connectors as defined in the PCI
> Express M.2 Specification are widely used in Notebooks/Tablet form factors (even
> in PCs). On the ACPI platforms, power to these connectors are mostly handled by
> the firmware/BIOS and the kernel never bothered to directly power manage them as
> like other PCIe connectors. But on the devicetree platforms, the kernel needs to
> power manage these connectors with the help of the devicetree description. But
> so far, there is no proper representation of the M.2 connectors in devicetree
> binding. This forced the developers to fake the M.2 connectors as PMU nodes [1]
> and fixed regulators in devicetree.
> 
> So to properly support the M.2 connectors in devicetree platforms, this series
> introduces the devicetree binding for Mechanical Key M connector as an example
> and also the corresponding pwrseq driver and PCI changes in kernel to driver the
> connector.
> 
> The Mechanical Key M connector is used to connect SSDs to the host machine over
> PCIe/SATA interfaces. Due to the hardware constraints, this series only adds
> support for driving the PCIe interface of the connector in the kernel.
> 
> Also, the optional interfaces supported by the Key M connectors are not
> supported in the driver and left for the future enhancements.
> 
> Testing
> =======
> 
> This series, together with the devicetree changes [2] [3] were tested on the
> Qualcomm X1e based Lenovo Thinkpad T14s Laptop which has the NVMe SSD connected
> over PCIe.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts?h=v6.18-rc4&id=d09ab685a8f51ba412d37305ea62628a01cbea57
> [2] https://github.com/Mani-Sadhasivam/linux/commit/40120d02219f34d2040ffa6328f0d406b1e4c04d
> [3] https://github.com/Mani-Sadhasivam/linux/commit/ff6c3075836cc794a3700b0ec6a4a9eb21d14c6f
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Changes in v7:
> - Dropped the pwrseq and binding patches as they got applied
> - Rebased on top of pci/pwrctrl branch
> - Link to v6: https://lore.kernel.org/r/20260122-pci-m2-v6-0-575da9f97239@oss.qualcomm.com
> 
> Changes in v6:
> - Used 'ports' to describe interfaces instead of endpoints in the binding
> - Added GPIOs and USB to the example in binding
> - Incorporated minor comments in the pwrseq driver
> - Dropped the ata binding patch as it got applied
> - Link to v5: https://lore.kernel.org/r/20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com
> 
> Changes in v5:
> - used of_node_get() and devm_action to free regulators
> - Link to v4: https://lore.kernel.org/r/20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com
> 
> Changes in v4:
> - Added graph property to SATA in this series and PCI to dtschema:
>   https://github.com/devicetree-org/dt-schema/pull/180
> - Used 'i2c-parent' instead of SMBus port
> - Reworded the -gpios property description
> - Rebased on top of v6.19-rc1
> - Link to v3: https://lore.kernel.org/r/20251125-pci-m2-v3-0-c528042aea47@oss.qualcomm.com
> 
> Changes in v3:
> - Changed the VIO supply name as per dtschema
> - Added explicit endpoint properties to port 0 node for host I/F
> - Used scope based cleanup for OF node in pwrseq driver
> - Collected review tags
> - Link to v2: https://lore.kernel.org/r/20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com
> 
> Changes in v2:
> - Incorporated comments from Bartosz and Frank for pwrseq and dt-binding
>   patches, especially adding the pwrseq match() code.
> - Link to v1: https://lore.kernel.org/r/20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com
> 
> ---
> Manivannan Sadhasivam (2):
>       PCI/pwrctrl: Add support for handling PCIe M.2 connectors
>       PCI/pwrctrl: Create pwrctrl device if the graph port is found
> 
>  drivers/pci/pwrctrl/Kconfig |  1 +
>  drivers/pci/pwrctrl/core.c  |  7 ++++---
>  drivers/pci/pwrctrl/slot.c  | 31 +++++++++++++++++++++++++++----
>  3 files changed, 32 insertions(+), 7 deletions(-)
> ---
> base-commit: 3e7f562e20ee87a25e104ef4fce557d39d62fa85
> change-id: 20251103-pci-m2-7633631b6faa
> 
> Best regards,
> -- 
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 

Applied to pci/pwrctrl for v6.20, thanks!

