Return-Path: <linux-pm+bounces-43040-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CKOFzhfnGkUFQQAu9opvQ
	(envelope-from <linux-pm+bounces-43040-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 15:07:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C60A2177BF3
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 15:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF0F73005143
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9F6265CA8;
	Mon, 23 Feb 2026 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPvGrBGV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267F226ADC;
	Mon, 23 Feb 2026 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855668; cv=none; b=MRMaobHGcmvJmlCXn7lg1TJ4fyJiZRMwKsRdHcRrJ0qv9ogQD1KylLs+wW/IJ8Xp5K/uap9mey4me33VIUlFKDOV6hfbQPp7eRrnzmOskDc9nwloYKR5kd322UAxn19HtXG5BjCLHuI9Ljll7RrD+Mr/kLfocod2qhiyW4HRdBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855668; c=relaxed/simple;
	bh=dDYPhdIEdbDF1rBlpY/BXOms6MErEYtGXlLpzU7HHOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h84yd4ao88Mhv7FtIYEGtFxInBCV2Nid89Wa2JFzSRHoFdUKnWwgnVd52+4ZZFMUEA+OnFD8w3Xcs4hJJwb8vXh1EEW9XACpu0KgCyzrGykSFC10bBVE7b2pZVUN0m5fG5MM+Tb1AJ7D54+cMfFIlm8r37JvQeXgR4f+4K+LC5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPvGrBGV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB57C116C6;
	Mon, 23 Feb 2026 14:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771855667;
	bh=dDYPhdIEdbDF1rBlpY/BXOms6MErEYtGXlLpzU7HHOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IPvGrBGVF2v2yL4LlrsF4wTm4ZSPbuU5uhI4xZRidahK7i+xK2gFONhYyWixOSR7w
	 uwR50Gu/pvCbYRwmTqqPvOm2cz87aC92HlGM5RhbrluJn5Ajm8MBI5ZbdTDs4Y6HG/
	 weBTiPqXjogD9se7vo1/t6z5HglySBCLoQ0BAi1wo031yUGUvqgF1wc8OlLlB62711
	 h/ezyUMJ5XU6tJm5D94aFY27d++FL4P4FuTjwiguSy/0l6vRVwjaDz7eJnjRtRUlc5
	 rS3x9aMk4BiKlXGuNKP88zrkoFIlcwjBkDYwQuqJelUv+jTRfemBY8I88ZlPcgsve1
	 evLYbqrm7U1cw==
Date: Mon, 23 Feb 2026 19:37:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, quic_vbadigan@quicinc.com, 
	quic_mrana@quicinc.com, sherry.sun@nxp.com, driver-core@lists.linux.dev
Subject: Re: [PATCH v7 3/3] PCI: Add support for PCIe WAKE# interrupt
Message-ID: <pjeee3vwggsrvp4kxarc46vjx2igk53xd6eoxjqh7ri5rf6fhi@5d3ccirqnxu6>
References: <20260218-wakeirq_support-v7-0-0d4689830207@oss.qualcomm.com>
 <20260218-wakeirq_support-v7-3-0d4689830207@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260218-wakeirq_support-v7-3-0d4689830207@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43040-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C60A2177BF3
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 01:42:25PM +0530, Krishna Chaitanya Chundru wrote:
> According to the PCI Express specification (PCIe r7.0, Section 5.3.3.2),
> two link wakeup mechanisms are defined: Beacon and WAKE#. Beacon is a
> hardware-only mechanism and is invisible to software (PCIe r7.0,
> Section 4.2.7.8.1). This change adds support for the WAKE# mechanism in
> the PCI core.
> 
> According to the PCIe specification, multiple WAKE# signals can exist in
> a system or each component in the hierarchy could share a single WAKE#
> signal. In configurations involving a PCIe switch, each downstream port
> (DSP) of the switch may be connected to a separate WAKE# line, allowing
> each endpoint to signal WAKE# independently. From figure 5.4 in sec
> 5.3.3.2, WAKE# can also be terminated at the switch itself. To support
> this, the WAKE# should be described in the device tree node of the
> endpoint/bridge. If all endpoints share a single WAKE# line, then each
> endpoint node should describe the same WAKE# signal or a single WAKE# in
> the Root Port node.
> 
> In pci_device_add(), PCI framework will search for the WAKE# in device
> node, If not found, it searches in its upstream port only if upstream port
> is Root Port. Once found, register for the wake IRQ in shared mode, as the
> WAKE# may be shared among multiple endpoints.
> 
> When a device asserts WAKE#, PM core will wakeup the system, resume the
> device and its parent(s) in the hierarchy, which will cause the restoration
> of power and refclk to the device.
> 
> WAKE# is added in dts schema and merged based on below links.
> 
> Link: https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/
> Link: https://github.com/devicetree-org/dt-schema/pull/170
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/of.c     | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.c    |  9 +++++++++
>  drivers/pci/pci.h    |  8 ++++++++
>  drivers/pci/probe.c  |  2 ++
>  drivers/pci/remove.c |  1 +
>  include/linux/pci.h  |  2 ++
>  6 files changed, 77 insertions(+)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 9bb5f258759be3f1e23496f083353600a4ef6743..23248900253faafaf9509d87c531b454fca41798 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -7,6 +7,7 @@
>  #define pr_fmt(fmt)	"PCI: OF: " fmt
>  
>  #include <linux/cleanup.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/irqdomain.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
> @@ -15,6 +16,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_wakeirq.h>
>  #include "pci.h"
>  
>  #ifdef CONFIG_PCI
> @@ -586,6 +588,59 @@ int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
>  	return irq_create_of_mapping(&oirq);
>  }
>  EXPORT_SYMBOL_GPL(of_irq_parse_and_map_pci);
> +
> +static void pci_configure_wake_irq(struct pci_dev *pdev, struct gpio_desc *wake)
> +{
> +	int ret, wake_irq;
> +
> +	wake_irq = gpiod_to_irq(wake);
> +	if (wake_irq < 0) {
> +		pci_err(pdev, "Failed to get wake irq: %d\n", wake_irq);
> +		return;
> +	}
> +
> +	device_init_wakeup(&pdev->dev, true);
> +
> +	ret = dev_pm_set_dedicated_shared_wake_irq(&pdev->dev, wake_irq,
> +						   IRQ_TYPE_EDGE_FALLING);
> +	if (ret < 0) {
> +		pci_err(pdev, "Failed to set wake IRQ: %d\n", ret);
> +		device_init_wakeup(&pdev->dev, false);
> +	}
> +}
> +
> +void pci_configure_of_wake_gpio(struct pci_dev *dev)
> +{
> +	struct device_node *dn = pci_device_to_OF_node(dev);
> +	struct pci_dev *upstream;
> +	struct gpio_desc *gpio;
> +
> +	if (!dn)
> +		return;
> +
> +	gpio = fwnode_gpiod_get(of_fwnode_handle(dn), "wake",
> +				GPIOD_IN | GPIOD_FLAGS_BIT_NONEXCLUSIVE, NULL);
> +	if (IS_ERR(gpio)) {
> +		/*
> +		 * In case the entire topology shares a single WAKE# signal, look for it
> +		 * in the upstream bridge node. But if it is not Root Port, then skip it.
> +		 */

This comment need to be a bit more verbose. Something like,

"The devices in a hierarchy expose wakeup capability through the 'wake-gpios'
property defined either in the device node or in the Slot node. So first check
for the property in device node and if not available, check in the Slot node."

Also, move it above fwnode_gpiod_get().

> +		upstream = pci_upstream_bridge(dev);
> +		if (upstream && pci_is_root_bus(upstream->bus) && upstream->wake)

Check directly in the Root Port (Slot) node.

> +			pci_configure_wake_irq(dev, upstream->wake);

I don't think we need to request an IRQ in the fallback case. Let's assume that
there is a single device in hierarchy and the wake-gpios property is defined in
the Slot node. So here, we should just let the PCI/PM core know that this device
supports wakeup and PME_EN needs to be set (if the device is also capable of
generating PME#).

And then we should call pci_configure_wake_irq() from platform_pci_set_wakeup()
to setup the IRQ handler only for the device which has the wake-gpios property.

So the flow would be:

pci_device_add()->platform_pci_init_wakeup()->of_pci_init_wakeup():
Request fwnode_gpiod_get() and call device_init_wakeup()
and set 'dev->wake' if WAKE# is available in the device node. If not, then check
the Root Port (Slot) node and if WAKE# is available, then just call
device_init_wakeup() to indicate the PCI and PM cores that this device *may*
support wakeup.

pci_enable_wake()->platform_pci_set_wakeup()->of_pci_set_wakeup():
Request WAKE# IRQ only if the device has the wake-gpios property ie., dev->wake
set. If only the Slot supports wakeup, then the IRQ should be requested for the
Root Port device. This will allow us to keep both the ACPI and OF platform code
in sync to some extent.

Then once the WAKE# is asserted, the platform will wakeup with the help of the
above wakeup event and the host controller driver will apply power to the
hierarchy.

But you do not seem to call pci_pme_wakeup_bus() after resume...

> +	} else {
> +		dev->wake = gpio;
> +		pci_configure_wake_irq(dev, gpio);
> +	}
> +}
> +
> +void pci_remove_of_wake_gpio(struct pci_dev *dev)
> +{

Missing of_node check.

> +	dev_pm_clear_wake_irq(&dev->dev);
> +	device_init_wakeup(&dev->dev, false);
> +	gpiod_put(dev->wake);
> +	dev->wake = NULL;
> +}
>  #endif	/* CONFIG_OF_IRQ */
>  
>  static int pci_parse_request_of_pci_ranges(struct device *dev,
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f3244630bfd05b15d52f866d80a015ed21f98f49..225cb861b3425700fc0d9d4805f5d9efcaab6f56 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1123,6 +1123,15 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>  	return acpi_pci_bridge_d3(dev);
>  }
>  
> +void platform_pci_configure_wake(struct pci_dev *dev)
> +{
> +	return pci_configure_of_wake_gpio(dev);
> +}
> +
> +void platform_pci_remove_wake(struct pci_dev *dev)
> +{
> +	return pci_remove_of_wake_gpio(dev);
> +}

As mentioned above, these should go away and be part of
platform_pci_set_wakeup().

>  /**
>   * pci_update_current_state - Read power state of given device and cache it
>   * @dev: PCI device to handle.
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 13d998fbacce6698514d92500dfea03cc562cdc2..22709573e41caf0ed45b20ee7ded5963f55aa9fe 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -282,6 +282,8 @@ void pci_msix_init(struct pci_dev *dev);
>  bool pci_bridge_d3_possible(struct pci_dev *dev);
>  void pci_bridge_d3_update(struct pci_dev *dev);
>  int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
> +void platform_pci_configure_wake(struct pci_dev *dev);
> +void platform_pci_remove_wake(struct pci_dev *dev);
>  
>  static inline bool pci_bus_rrs_vendor_id(u32 l)
>  {
> @@ -1195,6 +1197,9 @@ void pci_release_of_node(struct pci_dev *dev);
>  void pci_set_bus_of_node(struct pci_bus *bus);
>  void pci_release_bus_of_node(struct pci_bus *bus);
>  
> +void pci_configure_of_wake_gpio(struct pci_dev *dev);
> +void pci_remove_of_wake_gpio(struct pci_dev *dev);
> +
>  int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
>  bool of_pci_supply_present(struct device_node *np);
>  int of_pci_get_equalization_presets(struct device *dev,
> @@ -1240,6 +1245,9 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
>  	return 0;
>  }
>  
> +static inline void pci_configure_of_wake_gpio(struct pci_dev *dev) { }
> +static inline void pci_remove_of_wake_gpio(struct pci_dev *dev) { }
> +

You've added function definitions under CONFIG_OF_IRQ, but stubs under
CONFIG_OF. This is why kernel robot also barks at you.

Move the stubs to include/linux/of_pci.h under CONFIG_OF_IRQ guard.

- Mani

>  static inline bool of_pci_supply_present(struct device_node *np)
>  {
>  	return false;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2975974f35e88b5025701d2b721df8386419de8d..7f5132c0c8de36a6ec2775468a3d4e5156a046d0 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2771,6 +2771,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	/* Establish pdev->tsm for newly added (e.g. new SR-IOV VFs) */
>  	pci_tsm_init(dev);
>  
> +	platform_pci_configure_wake(dev);
> +
>  	pci_npem_create(dev);
>  
>  	pci_doe_sysfs_init(dev);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index e9d519993853f92f1810d3eff9f44ca7e3e1abd9..d781b41e57c4444077075690cec926a9fe15334f 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -35,6 +35,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
>  	if (pci_dev_test_and_set_removed(dev))
>  		return;
>  
> +	platform_pci_remove_wake(dev);
>  	pci_doe_sysfs_teardown(dev);
>  	pci_npem_remove(dev);
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1c270f1d512301de4d462fe7e5097c32af5c6f8d..d1e08df8a8deaa87780589f23242767fdcdba541 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -586,6 +586,8 @@ struct pci_dev {
>  	/* These methods index pci_reset_fn_methods[] */
>  	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
>  
> +	struct gpio_desc *wake; /* Holds WAKE# gpio */
> +
>  #ifdef CONFIG_PCIE_TPH
>  	u16		tph_cap;	/* TPH capability offset */
>  	u8		tph_mode;	/* TPH mode */
> 
> -- 
> 2.34.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

