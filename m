Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA2AEA601
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 23:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfJ3WOl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 18:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfJ3WOk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Oct 2019 18:14:40 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F5822083E;
        Wed, 30 Oct 2019 22:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572473679;
        bh=jZI/FXKfbqv9Ga9+lgH+eslmJ6dwwmvbb60jHX9+xF0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kUIVedaXNCpW7h6o6+TG8ZlyRVFBUfFWi5EMxFY0ByFPcZNjyKmUAO4lYJss7uy06
         o40AOBGZ9ruMLMzUbuKp5XXiFOhs39cyESitVnc0VxiSmjRYGraANRBREo47HdtQIL
         ah+bEH8XGGTVy7LPClfV5OUPIvpcL6HqUNiG+yx0=
Date:   Wed, 30 Oct 2019 17:14:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     Andrew Murray <andrew.murray@arm.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Rajat Jain <rajatja@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v4 3/3] pci: intel: Add sysfs attributes to configure
 pcie link
Message-ID: <20191030221436.GA261632@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1aadeea-7904-1455-5393-c4998fbd8037@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[+cc Heiner, Rajat]

On Tue, Oct 29, 2019 at 05:31:18PM +0800, Dilip Kota wrote:
> On 10/22/2019 8:59 PM, Bjorn Helgaas wrote:
> > [+cc Rafael, linux-pm, beginning of discussion at
> > https://lore.kernel.org/r/d8574605f8e70f41ce1e88ccfb56b63c8f85e4df.1571638827.git.eswara.kota@linux.intel.com]
> > 
> > On Tue, Oct 22, 2019 at 05:27:38PM +0800, Dilip Kota wrote:
> > > On 10/22/2019 1:18 AM, Bjorn Helgaas wrote:
> > > > On Mon, Oct 21, 2019 at 02:38:50PM +0100, Andrew Murray wrote:
> > > > > On Mon, Oct 21, 2019 at 02:39:20PM +0800, Dilip Kota wrote:
> > > > > > PCIe RC driver on Intel Gateway SoCs have a requirement
> > > > > > of changing link width and speed on the fly.
> > > > Please add more details about why this is needed.  Since you're adding
> > > > sysfs files, it sounds like it's not actually the *driver* that needs
> > > > this; it's something in userspace?
> > > We have use cases to change the link speed and width on the fly.
> > > One is EMI check and other is power saving.  Some battery backed
> > > applications have to switch PCIe link from higher GEN to GEN1 and
> > > width to x1. During the cases like external power supply got
> > > disconnected or broken. Once external power supply is connected then
> > > switch PCIe link to higher GEN and width.
> > That sounds plausible, but of course nothing there is specific to the
> > Intel Gateway, so we should implement this generically so it would
> > work on all hardware.
> Agree.
> > 
> > I'm not sure what the interface should look like -- should it be a
> > low-level interface as you propose where userspace would have to
> > identify each link of interest, or is there some system-wide
> > power/performance knob that could tune all links?  Cc'd Rafael and
> > linux-pm in case they have ideas.
> 
> To my knowledge sysfs is the appropriate way to go.
> If there are any other best possible knobs, will be helpful.

I agree sysfs is the right place for it; my question was whether we
should have files like:

  /sys/.../0000:00:1f.3/pcie_speed
  /sys/.../0000:00:1f.3/pcie_width

as I think this patch would add (BTW, please include sample paths like
the above in the commit log), or whether there should be a more global
thing that would affect all the links in the system.

I think the low-level files like you propose would be better because
one might want to tune link performance differently for different
types of devices and workloads.

We also have to decide if these files should be associated with the
device at the upstream or downstream end of the link.  For ASPM, the
current proposal [1] has the files at the downstream end on the theory
that the GPU, NIC, NVMe device, etc is the user-recognizable one.
Also, neither ASPM nor link speed/width make any sense unless there
*is* a device at the downstream end, so putting them there
automatically makes them visible only when they're useful.

Rafael had some concerns about the proposed ASPM interface [2], but I
don't know what they are yet.

For ASPM we added a "link_pm" directory, and maybe that's too
specific.  Maybe it should be a generic "link_mgt" or even "pcie"
directory that could contain both the ASPM and width/speed files.

There's also a change coming to put AER stats in something like this:

  /sys/.../0000:00:1f.3/aer_stats/correctable_rx_err
  /sys/.../0000:00:1f.3/aer_stats/correctable_timeout
  /sys/.../0000:00:1f.3/aer_stats/fatal_TLP
  ...

It would certainly be good to have some organizational scheme or we'll
end up with a real hodge-podge.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/aspm&id=ad46fe1c733656611788e2cd59793e891ed7ded7
[2] https://lore.kernel.org/r/CAJZ5v0jdxR4roEUC_Hs3puCzGY4ThdLsi_XcxfBUUxqruP4z7A@mail.gmail.com
