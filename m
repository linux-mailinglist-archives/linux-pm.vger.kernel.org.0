Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE991879C
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 11:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbfEIJTt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 9 May 2019 05:19:49 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39656 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfEIJTt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 May 2019 05:19:49 -0400
Received: by mail-oi1-f195.google.com with SMTP id x16so1368672oic.6;
        Thu, 09 May 2019 02:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4keILsDdqaPQc14jyFTpZX6LIK4odMSSe93jLxQHABU=;
        b=W/XbgC50ALdwluJg8m1rzMozunxBIpTUeZbRPKhhgiDg1S1AU+MvbVsXsAkrVGNi1t
         pvgyT9rSbhHEHQQUKrbnW407KD7h2u6gcZTXp/oPHSvGDOp5IzmFdAW0RSwTyjctqdhl
         X8wyCJdQDWR/wIRpgBZWcQ0F9uepetkkSUwhxilL+um7KqtDWPiCdP+CGvuVWY+CP/eV
         72K2dCXFCu/cTGnWh4/4cIdUXZ9XV9iNjcFwGyOacM0SvcpRjBiP00YDTOxxsmePvl/F
         dkWvf5zKSBgorncu5wkgACPcqjsBVBeJlOZ4yE75/AX0XJvalJhcXS1l9/PFSdJ4OR4i
         YZYg==
X-Gm-Message-State: APjAAAXDK50venox4rqDpyXyK/J05ryQeHj23XYLjG/s0+JYvCu7yE8o
        81jMfuW3/EpLUUL97YzuSV8g7wCzWbrh9X91H7I=
X-Google-Smtp-Source: APXvYqzINNimXp/wssQDr1dHiM1zCcFSUTOXnE+YF/EMLzLVAtAUB+htJwxgffMl8EOF4ySMIiljSIyv+JYs/ghVU6M=
X-Received: by 2002:aca:f444:: with SMTP id s65mr777412oih.115.1557393588629;
 Thu, 09 May 2019 02:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190508185955.11406-1-kai.heng.feng@canonical.com>
 <20190508191624.GA8365@localhost.localdomain> <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com>
 <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM>
 <20190508195159.GA1530@lst.de> <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM>
 <20190509061237.GA15229@lst.de> <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <20190509065223.GA15984@lst.de>
In-Reply-To: <20190509065223.GA15984@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 May 2019 11:19:37 +0200
Message-ID: <CAJZ5v0h51nMCte4yL76nMWaYrrXDPrOK=CeUpc50=r2Pp_icPw@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Keith Busch <kbusch@kernel.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 9, 2019 at 8:52 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, May 09, 2019 at 02:48:59PM +0800, Kai-Heng Feng wrote:
> > Not really, for hibernation pm_suspend_via_s2idle() evaluates to false so
> > the old code path will be taken.
> >
> >>
> >> And more to the points - if these "modern MS standby" systems are
> >> becoming common, which it looks they are, we need support in the PM core
> >> for those instead of working around the decisions in low-level drivers.
> >
> > Rafael, what do you think about this?
> > Including this patch, there are five drivers that use
> > pm_suspend_via_{firmware,s2idle}() to differentiate between S2I and S3.
> > So I think maybe it’s time to introduce a new suspend callback for S2I?
>
> We also really need something like that to avoid the PCI_DEV_FLAGS_NO_D3
> abuse - that flag is a quirk statically set on a device at probe time
> to prevent any entering of D3 state.

I agree that PCI_DEV_FLAGS_NO_D3 has to be avoided.

However, IMO introducing a new set of suspend (and resume) callbacks
for S2I would not be practical, because

(a) the only difference between S2I and S2R from a driver perspective
is that it may be expected to do something "special" about setting the
device power state in the S2I case (the rest of what needs to be done
during system-wide suspend/resume remains the same in both cases),

(b) the new callbacks would only be really useful for a handful of drivers.

> >> per definition, although they might not be too useful.  I suspect checking
> >> APSTA might be safer, but if we don't want to rely on APST we should
> >> check for a power state supporting the condition that the MS document
> >> quoted in the original document supports.
> >
> > If Modern Standby or Connected Standby is not supported by servers, I
> > don’t think the design documents mean much here.
> > We probably should check if the platform firmware really supports S2I
> > instead.
>
> That too.  As said this really is a platform decision, and needs to
> be managed by the platform code through the PM core.

I'm not what you mean by "platform decision" here.

>  Individual drivers like nvme can just implement the behavior, but are the absolute wrong
> place to make decisions on what kinds of suspend to enter.

Right, the choice of the target system state has already been made
when their callbacks get invoked (and it has been made by user space,
not by the platform).
