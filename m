Return-Path: <linux-pm+bounces-31017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D5CB08EE8
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 16:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCB61C25709
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A932F6F9B;
	Thu, 17 Jul 2025 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5oZPJKS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF12027A448;
	Thu, 17 Jul 2025 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752761622; cv=none; b=XJZLnyADfpkwLEgSpYDrNi06x/JxS6+BTNqrJpvlVoqF3TtehSrYhUB2A7j6NqAMOmP/0XHVKEu+AclN4IVZHR83DVUwi6rnSdORzvA/yAGJ4CV612WHMsHVXdK6wsOHkUAWHlzeXMlJhe2zt3CBpIVfQhdNClHLpKn4VF9iMhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752761622; c=relaxed/simple;
	bh=ixTarqeqejac41PWZorCK+piEbuwQFHdq8Neteuk/3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXCYqKwljK4+rSkSOL8dp6VmBBWIOnSMWieohigBmTLYh1dlI9uVlc45Vyuy8uo6KmX3/EX2ImH1Fdxl8np9gFvlANxqe8q2XYV2BNBStXtcWsttsa6SjMgMVRehWkK3zi0wb3JQ5ILo0nd+Y3M3zU+ENdio2fGqEuB2C7r17As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5oZPJKS; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752761621; x=1784297621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ixTarqeqejac41PWZorCK+piEbuwQFHdq8Neteuk/3g=;
  b=V5oZPJKS4A4VF6FcmdBd1d+luulgptA+/0HdYGafeYdx60Ly4B9PHIwq
   597TEEn/i6lsiWXo+Ez6IHmapl71UzPYfcAQdHWhaeN9q7N2ru6E/TW2s
   CjEkHr5eQUrRm6GetXM71lpxmhD6OVIssI71nG9TiQMJKZ8rZtQeaP6/a
   BluhV4P51A/bgJudJ12EUduBwQxEqIIUhNKN4E5sEKrQ8UboPYSEI9/6n
   hRxzflfkW3VSl0NbI4Ydj/ZWci7oyLWVmbPzUCHRPE416vQeId6XqEkUn
   o56z4xnzuPHuoOiZVHueABCSDBy7artd4/7VU6/Rqc5teRHWnA9f4c+r9
   g==;
X-CSE-ConnectionGUID: m5cF1hdxQYyUeYUr+wD6zA==
X-CSE-MsgGUID: uaU/yPrTS/K5lKurATKzkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="72492811"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="72492811"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 07:13:40 -0700
X-CSE-ConnectionGUID: c0SEBkQLQ3ifnSFgFsCsxQ==
X-CSE-MsgGUID: l71rYqsoSICoEFkTeH+eRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="158268797"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO localhost) ([10.124.220.193])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 07:13:40 -0700
Date: Thu, 17 Jul 2025 07:13:38 -0700
From: David Box <david.e.box@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, mani@kernel.org
Cc: bhelgaas@google.com, vicamo.yang@canonical.com, kenny@panix.com, 
	ilpo.jarvinen@linux.intel.com, nirmal.patel@linux.intel.com, linux-pm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/2] PCI/ASPM: Allow controller-defined default link state
Message-ID: <tbj67d2j4bzf3em5nw73w354lqji3baurajbseyouls53odjxq@4edjrxtdaeum>
References: <20250717004034.2998443-1-david.e.box@linux.intel.com>
 <4xcwba3d4slmz5gfuwypavxqreobnigzyu4vib6powtbibytyp@mmqcns27vlyr>
 <CAJZ5v0h+v5pUP39vTWpNNK2D8=X2UdjUTtZ7yQHCQ2k=r2kkMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0h+v5pUP39vTWpNNK2D8=X2UdjUTtZ7yQHCQ2k=r2kkMg@mail.gmail.com>

Hi Mani, Rafael,

On Thu, Jul 17, 2025 at 12:03:32PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jul 17, 2025 at 8:55 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Wed, Jul 16, 2025 at 05:40:24PM GMT, David E. Box wrote:
> > > Hi all,
> > >
> > > This RFC series addresses a limitation in the PCIe ASPM subsystem where
> > > devices on synthetic PCIe hierarchies, such as those created by Intel’s
> > > Volume Management Device (VMD), do not receive default ASPM settings
> > > because they are not visible to firmware. As a result, ASPM remains
> > > disabled on these devices unless explicitly enabled later by the driver,
> > > contrary to platform power-saving expectations.
> > >
> > > Problem with Current Behavior
> > >
> > > Today, ASPM default policy is set in pcie_aspm_cap_init() based on values
> > > provided by BIOS. For devices under VMD, BIOS has no visibility into the
> > > hierarchy, and therefore no ASPM defaults are applied. The VMD driver can
> > > attempt to walk the bus hierarchy and enable ASPM post-init using runtime
> > > mechanisms, but this fails when aspm_disabled is set because the kernel
> > > intentionally blocks runtime ASPM changes under ACPI’s FADT_NO_ASPM flag.
> > > However, this flag does not apply to VMD, which controls its domain
> > > independently of firmware.
> > >
> > > Goal
> > >
> > > The ideal solution is to allow VMD or any controller driver managing a
> > > synthetic hierarchy to provide a default ASPM link state at the same time
> > > it's set for BIOS, in pcie_aspm_cap_init().
> > >
> >
> > I like the idea and would like to use it to address the similar limitation on
> > Qcom SoCs where the BIOS doesn't configure ASPM settings for any devices and
> > sometimes there is no BIOS at all (typical for SoCs used in embedded usecases).
> > So I was using pci_walk_bus() in the controller driver to enable ASPM for all
> > devices, but that obviously has issues with hotplugged devices.
> >
> > > Solution
> > >
> > > 1. A new bus flag, PCI_BUS_FLAGS_ASPM_DEFAULT_OVERRIDE, based on Rafael's
> > > suggestion, to signal that the driver intends to override the default ASPM
> > > setting. 2. A new field, aspm_bus_link_state, in 'struct pci_bus' to supply
> > > the desired default link state using the existing PCIE_LINK_STATE_XXX
> > > bitmask.
> > >
> >
> > Why would you need to make it the 'bus' specific flag? It is clear that the
> > controller driver is providing the default ASPM setting. So pcie_aspm_cap_init()
> > should be able to use the value provided by it for all busses.
> >
> > Like:
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 2ad1852ac9b2..830496e556af 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -791,6 +791,7 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
> >  static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
> >  {
> >         struct pci_dev *child = link->downstream, *parent = link->pdev;
> > +       struct pci_host_bridge *host = pci_find_host_bridge(parent->bus);

I see. This is better. I'll make this change.

> >         u32 parent_lnkcap, child_lnkcap;
> >         u16 parent_lnkctl, child_lnkctl;
> >         struct pci_bus *linkbus = parent->subordinate;
> > @@ -866,8 +867,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
> >         }
> >
> >         /* Save default state */
> > -       if (parent->bus->bus_flags & PCI_BUS_FLAGS_NO_ASPM_DEFAULT)
> > -               link->aspm_default = parent->bus->aspm_bus_link_state;
> > +       if (host && host->aspm_bus_link_state)
> > +               link->aspm_default = host->aspm_bus_link_state;
> >         else
> >                 link->aspm_default = link->aspm_enabled;
> >
> > This avoids the usage of the bus flag (which your series is not at all making
> > use of) and allows setting the 'host_bridge::aspm_bus_link_state' easily by the
> > controller drivers.
> 
> This is very similar to what I have just suggested and I like this one.

I considered this. But 0 could technically mean that the controller wants
ASPM to be disabled. The VMD driver doesn't need to do this though and if
others don't currently need this than I can drop the flag.

David

