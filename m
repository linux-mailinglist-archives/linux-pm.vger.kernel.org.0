Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6923D061E
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jul 2021 02:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhGTXcE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jul 2021 19:32:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231765AbhGTXcB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Jul 2021 19:32:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F19266101B;
        Wed, 21 Jul 2021 00:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626826359;
        bh=lYXkX3S8CqeBNBxz55FI+vEABUN7e84q0v25YCXZZBo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=e7xYcm5OiSAtCgBJ1qa025M+AK2LwAiCsPvYKn3YRJr+nHuQUzKmDRiVhSFBMV2Pq
         dCq6WtI4SueU/mhACB9slwpzSqgsEld/13OFoZVjMIifnk0UqX4rgqx12pt+zGVIF/
         BbWkY+wWfCRujX2WzLx5zQar7xv6+IpJq2qeZR26rWoSGZ2MmfEYf1rxKv5i3G5SVN
         G2JsxPbjg+YEr6yUKHCbcLf9lJuey/yuXwbw+TDGQBc/pKVEaTVW5sP2DZppCSsjVv
         ntGhFKgEbrIvr+V9Mmb/20uQDlq3Z7uSs6UWP+0OO+6DW4T18t1MbhLOz/gJsTF4a6
         IGPJreV/BIlYg==
Date:   Tue, 20 Jul 2021 19:12:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Nikolai Zhubr <zhubr.2@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] x86: PIRQ/ELCR-related fixes and updates
Message-ID: <20210721001237.GA144325@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2107171813230.9461@angie.orcam.me.uk>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 20, 2021 at 05:27:43AM +0200, Maciej W. Rozycki wrote:
> Hi,
> 
>  In the course of adding PIRQ routing support for Nikolai's FinALi system 
> I realised we need to have some infrastructure for the indirectly accessed
> configuration space implemented by some chipsets as well as Cyrix CPUs and 
> also included with the Intel MP spec for the IMCR register via port I/O 
> space locations 0x22/0x23.  With that in place I implemented PIRQ support 
> for the Intel PCEB/ESC combined EISA southbridge using the same scheme to 
> access the relevant registers and for the final remaining Intel chipset of 
> the era, that is the i420EX.
> 
>  While at it I chose to rewrite ELCR register accesses to avoid using 
> magic numbers scattered across our code and use proper macros like with 
> the remaining PIC registers, and while at it again I noticed and fixed a 
> number of typos: s/ECLR/ELCR/.
> 
>  Since there are mechanical dependencies between the patches (except for 
> typo fixes) I chose to send them as a series rather than individually, 
> though 3/6 depends on: <https://lore.kernel.org/patchwork/patch/1452772/> 
> necessarily as well, the fate of which is currently unclear to me.
> 
>  See individual change descriptions for details.
> 
>  Nikolai: for your system only 1/6 and 2/6 are required, though you are 
> free to experiment with all the patches.  Mind that 3/6 mechanically 
> depends on the earlier change for the SIO PIRQ router referred above.  In 
> any case please use the debug patch for PCI code as well as the earlier 
> patches for your other system and send the resulting bootstrap log for 
> confirmation.
> 
>  Ideally this would be verified with PCI interrupt sharing, but for that 
> you'd have to track down one or more multifunction option cards (USB 2.0 
> interfaces with legacy 1.1 functions or serial/parallel multi-I/O cards 
> are good candidates, but of course there are more) or option devices with 
> PCI-to-PCI bridges, and then actually use some of these devices as well.  
> Any interrupt sharing will be reported, e.g.:
> 
> pci 0000:00:07.0: SIO/PIIX/ICH IRQ router [8086:7000]
> pci 0000:00:11.0: PCI INT A -> PIRQ 63, mask deb8, excl 0c20
> pci 0000:00:11.0: PCI INT A -> newirq 0
> PCI: setting IRQ 11 as level-triggered
> pci 0000:00:11.0: found PCI INT A -> IRQ 11
> pci 0000:00:11.0: sharing IRQ 11 with 0000:00:07.2
> pci 0000:02:00.0: using bridge 0000:00:11.0 INT A to get INT A
> pci 0000:00:11.0: sharing IRQ 11 with 0000:02:00.0
> pci 0000:02:01.0: using bridge 0000:00:11.0 INT B to get INT A
> pci 0000:02:02.0: using bridge 0000:00:11.0 INT C to get INT A
> pci 0000:03:00.0: using bridge 0000:00:11.0 INT A to get INT A
> pci 0000:00:11.0: sharing IRQ 11 with 0000:03:00.0
> pci 0000:04:00.0: using bridge 0000:00:11.0 INT B to get INT A
> pci 0000:04:00.3: using bridge 0000:00:11.0 INT A to get INT D
> pci 0000:00:11.0: sharing IRQ 11 with 0000:04:00.3
> pci 0000:06:05.0: using bridge 0000:00:11.0 INT D to get INT A
> pci 0000:06:08.0: using bridge 0000:00:11.0 INT C to get INT A
> pci 0000:06:08.1: using bridge 0000:00:11.0 INT D to get INT B
> pci 0000:06:08.2: using bridge 0000:00:11.0 INT A to get INT C
> pci 0000:00:11.0: sharing IRQ 11 with 0000:06:08.2
> 
> -- a lot of sharing and swizzling here. :)  You'd most definitely need: 
> <https://lore.kernel.org/patchwork/patch/1454747/> for that though, as I 
> can't imagine PCI BIOS 2.1 PIRQ routers to commonly enumerate devices 
> behind PCI-to-PCI bridges, given that they fail to cope with more complex 
> bus topologies created by option devices in the first place.

Looks nicely done but I have no ability to review or test, so I assume
the x86 folks will take care of this.

Bjorn
