Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF2F89AD84
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 12:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389475AbfHWKoV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 06:44:21 -0400
Received: from foss.arm.com ([217.140.110.172]:59984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387638AbfHWKoU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Aug 2019 06:44:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 408A2337;
        Fri, 23 Aug 2019 03:44:18 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 660E63F246;
        Fri, 23 Aug 2019 03:44:17 -0700 (PDT)
Date:   Fri, 23 Aug 2019 11:44:15 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/3] PCI: Add PCI_ERROR_RESPONSE definition
Message-ID: <20190823104415.GC14582@e119886-lin.cambridge.arm.com>
References: <20190822200551.129039-1-helgaas@kernel.org>
 <20190822200551.129039-2-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822200551.129039-2-helgaas@kernel.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 22, 2019 at 03:05:49PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> An MMIO read from a PCI device that doesn't exist or doesn't respond causes
> a PCI error.  There's no real data to return to satisfy the CPU read, so
> most hardware fabricates ~0 data.
> 
> Add a PCI_ERROR_RESPONSE definition for that and use it where appropriate
> to make these checks consistent and easier to find.
> 
> Note that successful reads *also* may return ~0 data, so additional
> information (e.g., knowledge that ~0 is not a valid register value) is
> needed to reliably identify errors.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/access.c                          | 13 ++++++------
>  .../pci/controller/dwc/pcie-designware-host.c |  2 +-
>  drivers/pci/controller/pci-aardvark.c         |  2 +-
>  drivers/pci/controller/pci-mvebu.c            |  4 ++--
>  drivers/pci/controller/pci-thunder-ecam.c     | 20 +++++++++----------
>  drivers/pci/controller/pci-thunder-pem.c      |  2 +-
>  drivers/pci/controller/pcie-altera.c          |  2 +-
>  drivers/pci/controller/pcie-iproc.c           |  2 +-
>  drivers/pci/controller/pcie-mediatek.c        |  4 ++--
>  drivers/pci/controller/pcie-rcar.c            |  2 +-
>  drivers/pci/controller/pcie-rockchip-host.c   |  2 +-
>  drivers/pci/controller/vmd.c                  |  2 +-
>  drivers/pci/hotplug/cpqphp_ctrl.c             | 12 +++++------
>  drivers/pci/hotplug/cpqphp_pci.c              | 20 +++++++++----------
>  drivers/pci/hotplug/pciehp_hpc.c              |  6 +++---
>  drivers/pci/pci.c                             |  8 ++++----
>  drivers/pci/pcie/dpc.c                        |  3 ++-
>  drivers/pci/pcie/pme.c                        |  4 ++--
>  drivers/pci/probe.c                           |  4 ++--
>  drivers/pci/quirks.c                          |  2 +-
>  include/linux/pci.h                           |  7 +++++++
>  21 files changed, 65 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 544922f097c0..02186f3471d8 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -81,7 +81,7 @@ int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
>  
>  	addr = bus->ops->map_bus(bus, devfn, where);
>  	if (!addr) {
> -		*val = ~0;
> +		*val = (u32) PCI_ERROR_RESPONSE;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  
> @@ -123,7 +123,7 @@ int pci_generic_config_read32(struct pci_bus *bus, unsigned int devfn,
>  
>  	addr = bus->ops->map_bus(bus, devfn, where & ~0x3);
>  	if (!addr) {
> -		*val = ~0;
> +		*val = (u32) PCI_ERROR_RESPONSE;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  
> @@ -536,7 +536,7 @@ EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
>  int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
>  {
>  	if (pci_dev_is_disconnected(dev)) {
> -		*val = ~0;
> +		*val = (u8) PCI_ERROR_RESPONSE;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  	return pci_bus_read_config_byte(dev->bus, dev->devfn, where, val);
> @@ -546,18 +546,17 @@ EXPORT_SYMBOL(pci_read_config_byte);
>  int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
>  {
>  	if (pci_dev_is_disconnected(dev)) {
> -		*val = ~0;
> +		*val = (u16) PCI_ERROR_RESPONSE;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  	return pci_bus_read_config_word(dev->bus, dev->devfn, where, val);
>  }
>  EXPORT_SYMBOL(pci_read_config_word);
>  
> -int pci_read_config_dword(const struct pci_dev *dev, int where,
> -					u32 *val)
> +int pci_read_config_dword(const struct pci_dev *dev, int where, u32 *val)
>  {
>  	if (pci_dev_is_disconnected(dev)) {
> -		*val = ~0;
> +		*val = (u32) PCI_ERROR_RESPONSE;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  	return pci_bus_read_config_dword(dev->bus, dev->devfn, where, val);
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f93252d0da5b..eb2e8b080a7d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -594,7 +594,7 @@ static int dw_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>  	struct pcie_port *pp = bus->sysdata;
>  
>  	if (!dw_pcie_valid_device(pp, bus, PCI_SLOT(devfn))) {
> -		*val = 0xffffffff;
> +		*val = (u32) PCI_ERROR_RESPONSE;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index fc0fe4d4de49..77ad25ed7d38 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -520,7 +520,7 @@ static int advk_pcie_rd_conf(struct pci_bus *bus, u32 devfn,
>  	int ret;
>  
>  	if (!advk_pcie_valid_device(pcie, bus, devfn)) {
> -		*val = 0xffffffff;
> +		*val = (u32) PCI_ERROR_RESPONSE;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index d3a0419e42f2..a45e45226790 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -648,7 +648,7 @@ static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>  
>  	port = mvebu_pcie_find_port(pcie, bus, devfn);
>  	if (!port) {
> -		*val = 0xffffffff;
> +		*val = (u32) PCI_ERROR_RESPONSE;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  
> @@ -658,7 +658,7 @@ static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>  						 size, val);
>  
>  	if (!mvebu_pcie_link_up(port)) {
> -		*val = 0xffffffff;
> +		*val = (u32) PCI_ERROR_RESPONSE;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  
> diff --git a/drivers/pci/controller/pci-thunder-ecam.c b/drivers/pci/controller/pci-thunder-ecam.c
> index 32d1d7b81ef4..b0332f349863 100644
> --- a/drivers/pci/controller/pci-thunder-ecam.c
> +++ b/drivers/pci/controller/pci-thunder-ecam.c
> @@ -42,7 +42,7 @@ static int handle_ea_bar(u32 e0, int bar, struct pci_bus *bus,
>  	if (where_a == 0x4) {
>  		addr = bus->ops->map_bus(bus, devfn, bar); /* BAR 0 */
>  		if (!addr) {
> -			*val = ~0;
> +			*val = (u32) PCI_ERROR_RESPONSE;
>  			return PCIBIOS_DEVICE_NOT_FOUND;
>  		}
>  		v = readl(addr);
> @@ -57,7 +57,7 @@ static int handle_ea_bar(u32 e0, int bar, struct pci_bus *bus,
>  
>  		addr = bus->ops->map_bus(bus, devfn, bar); /* BAR 0 */
>  		if (!addr) {
> -			*val = ~0;
> +			*val = (u32) PCI_ERROR_RESPONSE;
>  			return PCIBIOS_DEVICE_NOT_FOUND;
>  		}
>  		barl_orig = readl(addr + 0);
> @@ -73,7 +73,7 @@ static int handle_ea_bar(u32 e0, int bar, struct pci_bus *bus,
>  	if (where_a == 0xc) {
>  		addr = bus->ops->map_bus(bus, devfn, bar + 4); /* BAR 1 */
>  		if (!addr) {
> -			*val = ~0;
> +			*val = (u32) PCI_ERROR_RESPONSE;
>  			return PCIBIOS_DEVICE_NOT_FOUND;
>  		}
>  		v = readl(addr); /* EA entry-3. Base-H */
> @@ -105,7 +105,7 @@ static int thunder_ecam_p2_config_read(struct pci_bus *bus, unsigned int devfn,
>  
>  	addr = bus->ops->map_bus(bus, devfn, where_a);
>  	if (!addr) {
> -		*val = ~0;
> +		*val = (u32) PCI_ERROR_RESPONSE;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  
> @@ -136,7 +136,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
>  
>  	addr = bus->ops->map_bus(bus, devfn, 0xc);
>  	if (!addr) {
> -		*val = ~0;
> +		*val = (u32) PCI_ERROR_RESPONSE;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  
> @@ -147,7 +147,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
>  
>  	addr = bus->ops->map_bus(bus, devfn, 8);
>  	if (!addr) {
> -		*val = ~0;
> +		*val = (u32) PCI_ERROR_RESPONSE;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  
> @@ -177,7 +177,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
>  
>  	addr = bus->ops->map_bus(bus, devfn, 0);
>  	if (!addr) {
> -		*val = ~0;
> +		*val = (u32) PCI_ERROR_RESPONSE;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  
> @@ -197,7 +197,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
>  
>  		addr = bus->ops->map_bus(bus, devfn, 0x70);
>  		if (!addr) {
> -			*val = ~0;
> +			*val = (u32) PCI_ERROR_RESPONSE;
>  			return PCIBIOS_DEVICE_NOT_FOUND;
>  		}
>  		/* E_CAP */
> @@ -212,7 +212,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
>  		if (where_a == 0xb0) {
>  			addr = bus->ops->map_bus(bus, devfn, where_a);
>  			if (!addr) {
> -				*val = ~0;
> +				*val = (u32) PCI_ERROR_RESPONSE;
>  				return PCIBIOS_DEVICE_NOT_FOUND;
>  			}
>  			v = readl(addr);
> @@ -269,7 +269,7 @@ static int thunder_ecam_config_read(struct pci_bus *bus, unsigned int devfn,
>  		if (where_a == 0x70) {
>  			addr = bus->ops->map_bus(bus, devfn, where_a);
>  			if (!addr) {
> -				*val = ~0;
> +				*val = (u32) PCI_ERROR_RESPONSE;
>  				return PCIBIOS_DEVICE_NOT_FOUND;
>  			}
>  			v = readl(addr);
> diff --git a/drivers/pci/controller/pci-thunder-pem.c b/drivers/pci/controller/pci-thunder-pem.c
> index f127ce8bd4ef..115e2c94d968 100644
> --- a/drivers/pci/controller/pci-thunder-pem.c
> +++ b/drivers/pci/controller/pci-thunder-pem.c
> @@ -31,7 +31,7 @@ static int thunder_pem_bridge_read(struct pci_bus *bus, unsigned int devfn,
>  	struct thunder_pem_pci *pem_pci = (struct thunder_pem_pci *)cfg->priv;
>  
>  	if (devfn != 0 || where >= 2048) {
> -		*val = ~0;
> +		*val = (u32) PCI_ERROR_RESPONSE;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  
> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> index d2497ca43828..3bd63b507eb1 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -512,7 +512,7 @@ static int altera_pcie_cfg_read(struct pci_bus *bus, unsigned int devfn,
>  		return PCIBIOS_BAD_REGISTER_NUMBER;
>  
>  	if (!altera_pcie_valid_device(pcie, bus, PCI_SLOT(devfn))) {
> -		*value = 0xffffffff;
> +		*value = (u32) PCI_ERROR_RESPONSE;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index 2d457bfdaf66..1fafedb39c00 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -668,7 +668,7 @@ static int iproc_pci_raw_config_read32(struct iproc_pcie *pcie,
>  
>  	addr = iproc_pcie_map_cfg_bus(pcie, 0, devfn, where & ~0x3);
>  	if (!addr) {
> -		*val = ~0;
> +		*val = (u32) PCI_ERROR_RESPONSE;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 80601e1b939e..38f15a5e18ad 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -361,13 +361,13 @@ static int mtk_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
>  
>  	port = mtk_pcie_find_port(bus, devfn);
>  	if (!port) {
> -		*val = ~0;
> +		*val = (u32) PCI_ERROR_RESPONSE;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  
>  	ret = mtk_pcie_hw_rd_cfg(port, bn, devfn, where, size, val);
>  	if (ret)
> -		*val = ~0;
> +		*val = (u32) PCI_ERROR_RESPONSE;
>  
>  	return ret;
>  }
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index f6a669a9af41..ae8d95146351 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -277,7 +277,7 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
>  	ret = rcar_pcie_config_access(pcie, RCAR_PCI_ACCESS_READ,
>  				      bus, devfn, where, val);
>  	if (ret != PCIBIOS_SUCCESSFUL) {
> -		*val = 0xffffffff;
> +		*val = (u32) PCI_ERROR_RESPONSE;
>  		return ret;
>  	}
>  
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index 8d20f1793a61..48d85f648d79 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -226,7 +226,7 @@ static int rockchip_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>  	struct rockchip_pcie *rockchip = bus->sysdata;
>  
>  	if (!rockchip_pcie_valid_device(rockchip, bus, PCI_SLOT(devfn))) {
> -		*val = 0xffffffff;
> +		*val = (u32) PCI_ERROR_RESPONSE;
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	}
>  
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 4575e0c6dc4b..2af43b9e85db 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -578,7 +578,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  
>  		membar2_offset = 0x2018;
>  		ret = pci_read_config_dword(vmd->dev, PCI_REG_VMLOCK, &vmlock);
> -		if (ret || vmlock == ~0)
> +		if (ret || vmlock == (u32) PCI_ERROR_RESPONSE)
>  			return -ENODEV;
>  
>  		if (MB2_SHADOW_EN(vmlock)) {
> diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
> index b7f4e1f099d9..e9d2bf4eeeef 100644
> --- a/drivers/pci/hotplug/cpqphp_ctrl.c
> +++ b/drivers/pci/hotplug/cpqphp_ctrl.c
> @@ -1497,7 +1497,7 @@ static u32 board_added(struct pci_func *func, struct controller *ctrl)
>  	/* Check for a power fault */
>  	if (func->status == 0xFF) {
>  		/* power fault occurred, but it was benign */
> -		temp_register = 0xFFFFFFFF;
> +		temp_register = (u32) PCI_ERROR_RESPONSE;
>  		dbg("%s: temp register set to %x by power fault\n", __func__, temp_register);
>  		rc = POWER_FAILURE;
>  		func->status = 0;
> @@ -1510,7 +1510,7 @@ static u32 board_added(struct pci_func *func, struct controller *ctrl)
>  
>  		if (rc != 0) {
>  			/* Something's wrong here */
> -			temp_register = 0xFFFFFFFF;
> +			temp_register = (u32) PCI_ERROR_RESPONSE;
>  			dbg("%s: temp register set to %x by error\n", __func__, temp_register);
>  		}
>  		/* Preset return code.  It will be changed later if things go okay. */
> @@ -1518,7 +1518,7 @@ static u32 board_added(struct pci_func *func, struct controller *ctrl)
>  	}
>  
>  	/* All F's is an empty slot or an invalid board */
> -	if (temp_register != 0xFFFFFFFF) {
> +	if (temp_register != (u32) PCI_ERROR_RESPONSE) {
>  		res_lists.io_head = ctrl->io_head;
>  		res_lists.mem_head = ctrl->mem_head;
>  		res_lists.p_mem_head = ctrl->p_mem_head;
> @@ -2277,7 +2277,7 @@ static u32 configure_new_device(struct controller  *ctrl, struct pci_func  *func
>  		while ((function < max_functions) && (!stop_it)) {
>  			pci_bus_read_config_dword(ctrl->pci_bus, PCI_DEVFN(func->device, function), 0x00, &ID);
>  
> -			if (ID == 0xFFFFFFFF) {
> +			if (ID == (u32) PCI_ERROR_RESPONSE) {
>  				function++;
>  			} else {
>  				/* Setup slot structure. */
> @@ -2516,12 +2516,12 @@ static int configure_new_function(struct controller *ctrl, struct pci_func *func
>  		for (device = 0; (device <= 0x1F) && !rc; device++) {
>  			irqs.barber_pole = (irqs.barber_pole + 1) & 0x03;
>  
> -			ID = 0xFFFFFFFF;
> +			ID = (u32) PCI_ERROR_RESPONSE;
>  			pci_bus->number = hold_bus_node->base;
>  			pci_bus_read_config_dword(pci_bus, PCI_DEVFN(device, 0), 0x00, &ID);
>  			pci_bus->number = func->bus;
>  
> -			if (ID != 0xFFFFFFFF) {	  /*  device present */
> +			if (ID != (u32) PCI_ERROR_RESPONSE) {	  /*  device present */
>  				/* Setup slot structure. */
>  				new_slot = cpqhp_slot_create(hold_bus_node->base);
>  
> diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
> index 1b2b3f3b648b..d6ab73b9b280 100644
> --- a/drivers/pci/hotplug/cpqphp_pci.c
> +++ b/drivers/pci/hotplug/cpqphp_pci.c
> @@ -138,7 +138,7 @@ static int PCI_RefinedAccessConfig(struct pci_bus *bus, unsigned int devfn, u8 o
>  
>  	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, &vendID) == -1)
>  		return -1;
> -	if (vendID == 0xffffffff)
> +	if (vendID == (u32) PCI_ERROR_RESPONSE)
>  		return -1;
>  	return pci_bus_read_config_dword(bus, devfn, offset, value);
>  }
> @@ -251,7 +251,7 @@ static int PCI_GetBusDevHelper(struct controller *ctrl, u8 *bus_num, u8 *dev_num
>  			*dev_num = tdevice;
>  			ctrl->pci_bus->number = tbus;
>  			pci_bus_read_config_dword(ctrl->pci_bus, *dev_num, PCI_VENDOR_ID, &work);
> -			if (!nobridge || (work == 0xffffffff))
> +			if (!nobridge || (work == (u32) PCI_ERROR_RESPONSE))
>  				return 0;
>  
>  			dbg("bus_num %d devfn %d\n", *bus_num, *dev_num);
> @@ -330,10 +330,10 @@ int cpqhp_save_config(struct controller *ctrl, int busnumber, int is_hot_plug)
>  	/* Save PCI configuration space for all devices in supported slots */
>  	ctrl->pci_bus->number = busnumber;
>  	for (device = FirstSupported; device <= LastSupported; device++) {
> -		ID = 0xFFFFFFFF;
> +		ID = (u32) PCI_ERROR_RESPONSE;
>  		rc = pci_bus_read_config_dword(ctrl->pci_bus, PCI_DEVFN(device, 0), PCI_VENDOR_ID, &ID);
>  
> -		if (ID == 0xFFFFFFFF) {
> +		if (ID == (u32) PCI_ERROR_RESPONSE) {
>  			if (is_hot_plug) {
>  				/* Setup slot structure with entry for empty
>  				 * slot
> @@ -431,7 +431,7 @@ int cpqhp_save_config(struct controller *ctrl, int busnumber, int is_hot_plug)
>  			 */
>  			while ((function < max_functions) && (!stop_it)) {
>  				rc = pci_bus_read_config_dword(ctrl->pci_bus, PCI_DEVFN(device, function), PCI_VENDOR_ID, &ID);
> -				if (ID == 0xFFFFFFFF) {
> +				if (ID == (u32) PCI_ERROR_RESPONSE) {
>  					function++;
>  					continue;
>  				}
> @@ -474,12 +474,12 @@ int cpqhp_save_slot_config(struct controller *ctrl, struct pci_func *new_slot)
>  	int cloop = 0;
>  	int stop_it;
>  
> -	ID = 0xFFFFFFFF;
> +	ID = (u32) PCI_ERROR_RESPONSE;
>  
>  	ctrl->pci_bus->number = new_slot->bus;
>  	pci_bus_read_config_dword(ctrl->pci_bus, PCI_DEVFN(new_slot->device, 0), PCI_VENDOR_ID, &ID);
>  
> -	if (ID == 0xFFFFFFFF)
> +	if (ID == (u32) PCI_ERROR_RESPONSE)
>  		return 2;
>  
>  	pci_bus_read_config_byte(ctrl->pci_bus, PCI_DEVFN(new_slot->device, 0), 0x0B, &class_code);
> @@ -522,7 +522,7 @@ int cpqhp_save_slot_config(struct controller *ctrl, struct pci_func *new_slot)
>  		while ((function < max_functions) && (!stop_it)) {
>  			pci_bus_read_config_dword(ctrl->pci_bus, PCI_DEVFN(new_slot->device, function), PCI_VENDOR_ID, &ID);
>  
> -			if (ID == 0xFFFFFFFF)
> +			if (ID == (u32) PCI_ERROR_RESPONSE)
>  				function++;
>  			else {
>  				pci_bus_read_config_byte(ctrl->pci_bus, PCI_DEVFN(new_slot->device, function), 0x0B, &class_code);
> @@ -1049,7 +1049,7 @@ int cpqhp_valid_replace(struct controller *ctrl, struct pci_func *func)
>  		pci_bus_read_config_dword(pci_bus, devfn, PCI_VENDOR_ID, &temp_register);
>  
>  		/* No adapter present */
> -		if (temp_register == 0xFFFFFFFF)
> +		if (temp_register == (u32) PCI_ERROR_RESPONSE)
>  			return(NO_ADAPTER_PRESENT);
>  
>  		if (temp_register != func->config_space[0])
> @@ -1267,7 +1267,7 @@ int cpqhp_find_available_resources(struct controller *ctrl, void __iomem *rom_st
>  		pci_bus_read_config_dword(ctrl->pci_bus, dev_func, PCI_VENDOR_ID, &temp_dword);
>  		dbg("temp_D_word = %x\n", temp_dword);
>  
> -		if (temp_dword != 0xFFFFFFFF) {
> +		if (temp_dword != (u32) PCI_ERROR_RESPONSE) {
>  			index = 0;
>  			func = cpqhp_slot_find(primary_bus, dev_func >> 3, 0);
>  
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index bd990e3371e3..f0489f305ad7 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -70,7 +70,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
>  
>  	while (true) {
>  		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> -		if (slot_status == (u16) ~0) {
> +		if (slot_status == (u16) PCI_ERROR_RESPONSE) {
>  			ctrl_info(ctrl, "%s: no response from device\n",
>  				  __func__);
>  			return 0;
> @@ -148,7 +148,7 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
>  	pcie_wait_cmd(ctrl);
>  
>  	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
> -	if (slot_ctrl == (u16) ~0) {
> +	if (slot_ctrl == (u16) PCI_ERROR_RESPONSE) {
>  		ctrl_info(ctrl, "%s: no response from device\n", __func__);
>  		goto out;
>  	}
> @@ -543,7 +543,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  	}
>  
>  	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
> -	if (status == (u16) ~0) {
> +	if (status == (u16) PCI_ERROR_RESPONSE) {
>  		ctrl_info(ctrl, "%s: no response from device\n", __func__);
>  		if (parent)
>  			pm_runtime_put(parent);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 29ed5ec1ac27..bfc739dc6ada 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4434,16 +4434,16 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  	 * After reset, the device should not silently discard config
>  	 * requests, but it may still indicate that it needs more time by
>  	 * responding to them with CRS completions.  The Root Port will
> -	 * generally synthesize ~0 data to complete the read (except when
> -	 * CRS SV is enabled and the read was for the Vendor ID; in that
> -	 * case it synthesizes 0x0001 data).
> +	 * generally synthesize ~0 data (PCI_ERROR_RESPONSE) to complete
> +	 * the read (except when CRS SV is enabled and the read was for the
> +	 * Vendor ID; in that case it synthesizes 0x0001 data).

There are some other areas in drivers/pci where comments also refer to ~0
and similar:

$ git grep -i ffffffff drivers/pci/ | grep \*
drivers/pci/access.c:            * have been written as 0xFFFFFFFF if hardware error happens
drivers/pci/controller/dwc/pci-keystone.c: * bus error instead of returning 0xffffffff. This handler always returns 0
drivers/pci/controller/pci-xgene.c:      * ready") instead of 0xFFFFFFFF ("device does not exist").  This
drivers/pci/controller/pcie-iproc.c:     * eventually return the wrong data (0xffffffff).
drivers/pci/pci.c: * FFFFFFFFs on the command line.)

I've removed anything in the above list that doesn't look like a good candidate
for PCI_ERROR_RESPONSE.

Perhaps there is some value for replacing "~0" with "~0 (PCI_ERROR_RESPONSE)"
in the comments too?

>  	 *
>  	 * Wait for the device to return a non-CRS completion.  Read the
>  	 * Command register instead of Vendor ID so we don't have to
>  	 * contend with the CRS SV value.
>  	 */
>  	pci_read_config_dword(dev, PCI_COMMAND, &id);
> -	while (id == ~0) {
> +	while (id == (u32) PCI_ERROR_RESPONSE) {
>  		if (delay > timeout) {
>  			pci_warn(dev, "not ready %dms after %s; giving up\n",
>  				 delay - 1, reset_type);
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index a32ec3487a8d..96b6b87a0af3 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -272,7 +272,8 @@ static irqreturn_t dpc_irq(int irq, void *context)
>  
>  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
>  
> -	if (!(status & PCI_EXP_DPC_STATUS_INTERRUPT) || status == (u16)(~0))
> +	if (!(status & PCI_EXP_DPC_STATUS_INTERRUPT) ||
> +	    status == (u16)(PCI_ERROR_RESPONSE))
>  		return IRQ_NONE;
>  
>  	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index f38e6c19dd50..3c46622e6c3f 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -224,7 +224,7 @@ static void pcie_pme_work_fn(struct work_struct *work)
>  			break;
>  
>  		pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
> -		if (rtsta == (u32) ~0)
> +		if (rtsta == (u32) PCI_ERROR_RESPONSE)
>  			break;
>  
>  		if (rtsta & PCI_EXP_RTSTA_PME) {
> @@ -274,7 +274,7 @@ static irqreturn_t pcie_pme_irq(int irq, void *context)
>  	spin_lock_irqsave(&data->lock, flags);
>  	pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
>  
> -	if (rtsta == (u32) ~0 || !(rtsta & PCI_EXP_RTSTA_PME)) {
> +	if (rtsta == (u32) PCI_ERROR_RESPONSE || !(rtsta & PCI_EXP_RTSTA_PME)) {
>  		spin_unlock_irqrestore(&data->lock, flags);
>  		return IRQ_NONE;
>  	}
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a3c7338fad86..fb953f2666b9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1549,7 +1549,7 @@ static int pci_cfg_space_size_ext(struct pci_dev *dev)
>  
>  	if (pci_read_config_dword(dev, pos, &status) != PCIBIOS_SUCCESSFUL)
>  		return PCI_CFG_SPACE_SIZE;
> -	if (status == 0xffffffff || pci_ext_cfg_is_aliased(dev))
> +	if (status == (u32) PCI_ERROR_RESPONSE || pci_ext_cfg_is_aliased(dev))
>  		return PCI_CFG_SPACE_SIZE;
>  
>  	return PCI_CFG_SPACE_EXP_SIZE;
> @@ -2488,7 +2488,7 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  		return false;
>  
>  	/* Some broken boards return 0 or ~0 if a slot is empty: */
> -	if (*l == 0xffffffff || *l == 0x00000000 ||
> +	if (*l == (u32) PCI_ERROR_RESPONSE || *l == 0x00000000 ||
>  	    *l == 0x0000ffff || *l == 0xffff0000)
>  		return false;
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 208aacf39329..3d5c92b53310 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4854,7 +4854,7 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
>  
>  		pdev->cfg_size = PCI_CFG_SPACE_EXP_SIZE;
>  		if (pci_read_config_dword(pdev, PCI_CFG_SPACE_SIZE, &status) !=
> -		    PCIBIOS_SUCCESSFUL || (status == 0xffffffff))
> +		    PCIBIOS_SUCCESSFUL || (status == (u32) PCI_ERROR_RESPONSE))

The casts are necessary but slightly annoying. Have you considered something
like:

#define SET_PCI_ERROR_RESPONSE(val)	(val = ((typeof(val))(~0ULL)))
#define RESPONSE_IS_PCI_ERROR(val)	(val == ((typeof(val))(~0ULL)))

Thanks,

Andrew Murray

>  			pdev->cfg_size = PCI_CFG_SPACE_SIZE;
>  
>  		if (pci_find_saved_cap(pdev, PCI_CAP_ID_EXP))
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9e700d9f9f28..d64fd3788061 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -123,6 +123,13 @@ enum pci_interrupt_pin {
>  /* The number of legacy PCI INTx interrupts */
>  #define PCI_NUM_INTX	4
>  
> +/*
> + * Reading from a device that doesn't respond typically returns ~0.  A
> + * successful read from a device may also return ~0, so you need additional
> + * information to reliably identify errors.
> + */
> +#define PCI_ERROR_RESPONSE		(~0ULL)
> +
>  /*
>   * pci_power_t values must match the bits in the Capabilities PME_Support
>   * and Control/Status PowerState fields in the Power Management capability.
> -- 
> 2.23.0.187.g17f5b7556c-goog
> 
