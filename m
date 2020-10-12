Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F7A28B38A
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 13:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387617AbgJLLOa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 07:14:30 -0400
Received: from mail.ispras.ru ([83.149.199.84]:53590 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387597AbgJLLOa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Oct 2020 07:14:30 -0400
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id 9227140D4004;
        Mon, 12 Oct 2020 11:14:27 +0000 (UTC)
Date:   Mon, 12 Oct 2020 14:14:27 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] intel_idle: mention assumption that wbinvd is not
 needed
In-Reply-To: <CAJZ5v0iFj0s=ZNrLnBxQ34uUnn2NQ6bH+oriyNWrFu-g8HGfUg@mail.gmail.com>
Message-ID: <alpine.LNX.2.20.13.2010121410490.15808@monopod.intra.ispras.ru>
References: <20201010221806.2106-1-amonakov@ispras.ru> <CAJZ5v0iFj0s=ZNrLnBxQ34uUnn2NQ6bH+oriyNWrFu-g8HGfUg@mail.gmail.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 12 Oct 2020, Rafael J. Wysocki wrote:

> > @@ -20,7 +20,11 @@
> >   * All CPUs have same idle states as boot CPU
> >   *
> >   * Chipset BM_STS (bus master status) bit is a NOP
> > - *     for preventing entry into deep C-stats
> > + *     for preventing entry into deep C-states
> > + *
> > + * CPU will flush caches as needed when entering a C-state via MWAIT
> 
> I would rephrase this to mention that the above actually is an assumption.

This comment block is by itself a list of assumptions. It begins with heading
"Design Assumptions" and then lists two assumptions. This patch adds a third
one.

With that clarified, do you still need me to change this hunk?

> 
> > + *     (in contrast to entering ACPI C3, where acpi_idle driver is
> 
> And mentioning acpi_idle here is not needed; it would be sufficient to
> say something like "in which case the WBINVD instruction needs to be
> executed to flush the caches".

I see, thanks, I will change this for v2 once the above is cleared up.

Thanks.
Alexander
