Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 731D5193C2
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 22:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfEIUsO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 16:48:14 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39649 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfEIUsO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 May 2019 16:48:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id o39so3595226ota.6;
        Thu, 09 May 2019 13:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AiG+7IgefHphLK8dn9WkopmkK9DUfiTtLgzlRRlQQW8=;
        b=afTM4Rrdhe4hTZNPgFAFR/iy5oJwPdpXq13/NxteSjuTnyC/H8fAYd2oKC2o63o9Wu
         4Bx3tZjDPl4icctaNlW0V7RyR044tH5eUkp7rfg2BOEryQ6o1XTXyzQOkITzVT/3cIya
         rWb6FzdMg3Qdp4LvipI5t+akxRDptwue5CQEWbI188emv7rF/IgN3bfdTqCFPDy0tUpn
         e1rAW6bQvRwlsuyvNx/n0Wg4vORvnIaMstwIHpt0hY3GtssoSVvlrFc3qhvv6r+r2rEB
         HAMsHhL2b252g+45CumVXPJYM2tgx1ZqECU/zllfcP/iMJ5QjC+ooJQSNCQw8iTQlG/b
         HOjw==
X-Gm-Message-State: APjAAAWj2AA5DGpxTGKV56v6ZE7psmdI3ABQGNt623h8rNWf61fadIUv
        eAu3NmcgMSG759HP/qY77QqB5NCpBd9ziHjS6L0=
X-Google-Smtp-Source: APXvYqw+d5l5cm+UleUITr7HOyQ8ACwu67ZrRwR26Gg+fWAICc7KH+nf1I7TKDGAfD/yUtQCQd3BgNFEbbV4owdKkYQ=
X-Received: by 2002:a05:6830:1251:: with SMTP id s17mr4294953otp.186.1557434893575;
 Thu, 09 May 2019 13:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190508185955.11406-1-kai.heng.feng@canonical.com>
 <20190508191624.GA8365@localhost.localdomain> <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com>
 <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM>
 <20190508195159.GA1530@lst.de> <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM>
 <20190509061237.GA15229@lst.de> <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <20190509065223.GA15984@lst.de> <CAJZ5v0h51nMCte4yL76nMWaYrrXDPrOK=CeUpc50=r2Pp_icPw@mail.gmail.com>
 <20190509092514.GA18598@lst.de>
In-Reply-To: <20190509092514.GA18598@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 May 2019 22:48:00 +0200
Message-ID: <CAJZ5v0iezuuXeHAuEPbJ2fAcbmaySCAofU+yZ-j-WuN6O+yq0A@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Keith Busch <kbusch@kernel.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 9, 2019 at 11:25 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, May 09, 2019 at 11:19:37AM +0200, Rafael J. Wysocki wrote:
> > Right, the choice of the target system state has already been made
> > when their callbacks get invoked (and it has been made by user space,
> > not by the platform).
>
> From a previous discussion I remember the main problem here is that
> a lot of consumer NVMe use more power when put into D3hot than just
> letting the device itself manage the power state transitions themselves.
> Based on this patch there also might be some other device that want
> an explicit power state transition from the host, but still not be
> put into D3hot.
>
> The avoid D3hot at all cost thing seems to be based on the Windows
> broken^H^H^H^H^H^Hmodern standby principles.  So for platforms that
> follow the modern standby model we need to avoid putting NVMe devices
> that support power management into D3hot somehow.  This patch doesa a
> few more things, but at least for the device where I was involved in
> the earlier discussion those are not needed, and from the Linux
> point of view many of them seem wrong too.
>
> How do you think we best make that distinction?  Are the pm_ops
> enough if we don't use the simple version?

First, I think that it is instructive to look at what happens without
the patch: nvme_suspend() gets called by pci_pm_suspend() (which
basically causes the device to be "stopped" IIUC) and then
pci_pm_suspend_noirq() is expected to put the device into the right
power state through pci_prepare_to_sleep().  In theory, this should
work for both S2R and S2I as long as the standard PCIe PM plus
possibly ACPI PM is sufficient for the device.  [Of course, the
platform firmware invoked at the last stage of S2R can "fix up" things
to reduce power further, but that should not be necessary if all is
handled properly up to this point.]

The claim in the patch changelog is that one design choice in Windows
related to "Modern Standby" has caused our default PCI PM to not apply
to NVMe devices in general (or to apply to them, but without much
effect, which is practically equivalent IMO).  This is not about a
"different paradigm" (as Mario put it) or a different type of system
suspend, but about the default PCI PM being basically useless for
those devices at least in some configurations.

And BTW, the same problem would have affected PM-runtime, had it been
supported by the nvme driver, because Linux uses the combination of
the standard PCIe PM and ACPI PM for PM-runtime too, and the
"paradigm" in there is pretty much the same as for S2I, so let's not
confuse things, pretty please.

All of this means that the driver needs to override the default PCI PM
like in the patch that Keith has just posted.  Unfortunately, it looks
like the "suspend via firmware" check needs to be there, because the
platform firmware doing S3 on some platforms may get confused by the
custom PM in the driver.
