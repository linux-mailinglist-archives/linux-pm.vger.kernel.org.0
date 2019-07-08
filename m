Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 970DD61ACE
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 08:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbfGHGxt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 02:53:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:51328 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfGHGxs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jul 2019 02:53:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jul 2019 23:53:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,465,1557212400"; 
   d="scan'208";a="248724243"
Received: from conghuic-mobl.ccr.corp.intel.com ([10.249.172.41])
  by orsmga001.jf.intel.com with ESMTP; 07 Jul 2019 23:53:46 -0700
Message-ID: <1562568815.2810.18.camel@intel.com>
Subject: Re: [PATCH V2 00/13] intel_rapl: RAPL abstraction and MMIO RAPL
 support
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Date:   Mon, 08 Jul 2019 14:53:35 +0800
In-Reply-To: <CAJZ5v0ixFF-_5yYZhWBJLUaE6oreaGY1BELGTsYfqYw3M9sDcQ@mail.gmail.com>
References: <1562258085-3165-1-git-send-email-rui.zhang@intel.com>
         <CAJZ5v0jZEcSpGqeccZwOw6a_QMXKdcx4K2GBeC8P0Vn-9E6vyQ@mail.gmail.com>
         <97215b43ce11766f83847531b05def8d94f645f0.camel@intel.com>
         <CAJZ5v0ixFF-_5yYZhWBJLUaE6oreaGY1BELGTsYfqYw3M9sDcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 六, 2019-07-06 at 10:19 +0200, Rafael J. Wysocki wrote:
> On Fri, Jul 5, 2019 at 4:59 PM Pandruvada, Srinivas
> <srinivas.pandruvada@intel.com> wrote:
> > 
> > 
> > On Fri, 2019-07-05 at 10:57 +0200, Rafael J. Wysocki wrote:
> > > 
> > > On Thu, Jul 4, 2019 at 6:34 PM Zhang Rui <rui.zhang@intel.com>
> > > wrote:
> > > > 
> > > > 
> > > > Besideis MSR interface, RAPL can also be controlled via the
> > > > MMIO
> > > > interface,
> > > > by accessing the MCHBar registers exposed by the processor
> > > > thermal
> > > > device.
> > > > 
> > > > Currently, we only have RAPL MSR interface in Linux kernel,
> > > > this
> > > > brings
> > > > problems on some platforms that BIOS performs a low power
> > > > limits
> > > > via the
> > > > MMIO interface by default. This results in poor system
> > > > performance,
> > > > and there is no way for us to change the MMIO MSR setting in
> > > > Linux.
> > > > 
> > > > To fix this, RAPL MMIO interface support is introduced in this
> > > > patch set.
> > > > 
> > > > Patch 1/13 to patch 11/13 abstract the RAPL code, and move all
> > > > the
> > > > shared
> > > > code into a separate file, intel_rapl_common.c, so that it can
> > > > be
> > > > used
> > > > by both MSR and MMIO interfaces.
> > > > Patch 12/13 introduced RAPL support via MMIO registers, exposed
> > > > by
> > > > the
> > > > processor thermal devices.
> > > > Patch 13/13 fixes a module autoloading issue found later.
> > > > 
> > > > The patch series has been tested on Dell XPS 9360, a SKL
> > > > platform.
> > > > 
> > > > Note that this patch series are based on the -tip tree, which
> > > > contains the
> > > > latest RAPL changes for multi-die support.
> > > > 
> > > > Changes in V2:
> > > >    - add kerneldoc for struct rapl_if_priv.
> > > >    - use intel_rapl_msr.c for RAPL MSR I/F driver, instead of
> > > > intel_rapl.c.
> > > >    - changelog and coding style update.
> > > What tree is the series against?
> > > 
> > > It doesn't apply either on top of my powercap branch or on top of
> > > 5.2-rc7 for me.
> > This needs linux tip tree. There are some package/die changes in
> > tip
> > tree, which this patch depends on.
> OK, so the changes in -tip need to go in first.
> 
exactly.
BTW, this patch set also conflicts with the RAPL support patches for
icelake platforms. Thus IMO, having a separate rapl branch, and apply
the icl rapl patches on top of this patch set will be much easier.

thanks,
rui
