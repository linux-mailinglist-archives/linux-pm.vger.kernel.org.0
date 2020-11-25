Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3203A2C41B1
	for <lists+linux-pm@lfdr.de>; Wed, 25 Nov 2020 15:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgKYOEW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Nov 2020 09:04:22 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46167 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgKYOEW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2020 09:04:22 -0500
Received: by mail-oi1-f196.google.com with SMTP id w15so2871518oie.13;
        Wed, 25 Nov 2020 06:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Srn5wkrK3Lk3sOTwAki0HO4VQojxWNSuf+8xPW7iPso=;
        b=atsA5Tq+4+TpClnOYO4wha+Zkv4kT2dbctrWRtrByeFR81u+Y2llytKvuN4s+zbGSI
         HSMHH7ZpKt1zZW+4iUPWg46wk/un6Vnn4xc+0DLlxodRwK/MvO0sk57ZYNe1WkAqPhHJ
         slH7tdPzRmDQFZk49WmBSg+hlaQALvcsR7/IXnB9vvP+Cd7UG8NdXsMNeu61vOTCmOM5
         M8LJ8GopAGQvnYtQNRybhX/RT9+xUl0Ar2H2Ynpn254H7VOGycryN5C/U0/cKdk0ORZr
         scAuaDHbunuzHJBczfVxNojaW2Irj7L/PFxfK4LBJNg2g3TGSXxOBD58ffAtSiIuEjHV
         xosA==
X-Gm-Message-State: AOAM533rIwsl422qyvegbqYVHPNz+2va3ENQwEkQpffHAIWRv8C9Zk8w
        FbUk+jL32K/1B0LUcwUF2F6luqzAvK9wDe51ocA=
X-Google-Smtp-Source: ABdhPJyPd2usae7HiK3dq+PtiMsygYPKMBEMqG9oGbpP/ptOAvdeDQpFFuuM9ZTWbEfboQROJ3+JEpjLKFwrILhFT1k=
X-Received: by 2002:aca:5a42:: with SMTP id o63mr2216087oib.69.1606313060295;
 Wed, 25 Nov 2020 06:04:20 -0800 (PST)
MIME-Version: 1.0
References: <20201124060202.776-1-ricky_wu@realtek.com> <20201124204915.GA585306@bjorn-Precision-5520>
In-Reply-To: <20201124204915.GA585306@bjorn-Precision-5520>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Nov 2020 15:04:07 +0100
Message-ID: <CAJZ5v0gt4aeC5S6RY2W98vmcMSs9gb_SBA8-eoq1NU3wPptL8g@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: rts5249 support runtime PM
To:     Bjorn Helgaas <helgaas@kernel.org>, ricky_wu@realtek.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, vaibhavgupta40@gmail.com,
        kdlnx@doth.eu, Doug Anderson <dianders@chromium.org>,
        rmfrfs@gmail.com, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 24, 2020 at 9:49 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rafael, linux-pm for runtime PM question below]
>
> On Tue, Nov 24, 2020 at 02:02:02PM +0800, ricky_wu@realtek.com wrote:
> > From: Ricky Wu <ricky_wu@realtek.com>
> >
> > rtsx_pci_sdmmc: add to support autosuspend when the rtd3_en is set
> >
> > rtsx_pcr: add callback functions about runtime PM
> > add delay_work(rtd3_work) to decrease usage count to 0 when staying
> > at idle over 10 sec
> >
> > rts5249: add extra flow at init function to support wakeup from d3
> > and set rtd3_en from register setting
>
> This looks like several patches that should be split up.  The ASPM
> changes should be unrelated to runtime PM.
>
> > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> > ---
> >  drivers/misc/cardreader/rts5249.c  |  25 ++++--
> >  drivers/misc/cardreader/rtsx_pcr.c | 122 +++++++++++++++++++++++++++--
> >  drivers/misc/cardreader/rtsx_pcr.h |   1 +
> >  drivers/mmc/host/rtsx_pci_sdmmc.c  |  18 ++++-
> >  include/linux/rtsx_pci.h           |   1 +
> >  5 files changed, 152 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
> > index b85279f1fc5e..1da3b1ca1121 100644
> > --- a/drivers/misc/cardreader/rts5249.c
> > +++ b/drivers/misc/cardreader/rts5249.c
> > @@ -65,7 +65,6 @@ static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
> >               pcr_dbg(pcr, "skip fetch vendor setting\n");
> >               return;
> >       }
> > -
>
> Doesn't look like an improvement to me.

+1

> >       pcr->aspm_en = rtsx_reg_to_aspm(reg);
> >       pcr->sd30_drive_sel_1v8 = rtsx_reg_to_sd30_drive_sel_1v8(reg);
> >       pcr->card_drive_sel &= 0x3F;
> > @@ -73,6 +72,8 @@ static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
> >
> >       pci_read_config_dword(pdev, PCR_SETTING_REG2, &reg);
> >       pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
> > +
> > +     pcr->rtd3_en = rtsx_reg_to_rtd3_uhsii(reg);
> >       if (rtsx_check_mmc_support(reg))
> >               pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
> >       pcr->sd30_drive_sel_3v3 = rtsx_reg_to_sd30_drive_sel_3v3(reg);
> > @@ -278,13 +279,25 @@ static int rts5249_extra_init_hw(struct rtsx_pcr *pcr)
> >
> >       rtsx_pci_send_cmd(pcr, CMD_TIMEOUT_DEF);
> >
> > -     if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A)) {
> > +     if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A))
> >               rtsx_pci_write_register(pcr, REG_VREF, PWD_SUSPND_EN, PWD_SUSPND_EN);
> > -             rtsx_pci_write_register(pcr, RTS524A_PM_CTRL3, 0x01, 0x00);
> > -             rtsx_pci_write_register(pcr, RTS524A_PME_FORCE_CTL, 0x30, 0x20);
> > +
> > +     if (pcr->rtd3_en) {
> > +             if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A)) {
> > +                     rtsx_pci_write_register(pcr, RTS524A_PM_CTRL3, 0x01, 0x01);
> > +                     rtsx_pci_write_register(pcr, RTS524A_PME_FORCE_CTL, 0x30, 0x30);
> > +             } else {
> > +                     rtsx_pci_write_register(pcr, PM_CTRL3, 0x01, 0x01);
> > +                     rtsx_pci_write_register(pcr, PME_FORCE_CTL, 0xFF, 0x33);
> > +             }
> >       } else {
> > -             rtsx_pci_write_register(pcr, PME_FORCE_CTL, 0xFF, 0x30);
> > -             rtsx_pci_write_register(pcr, PM_CTRL3, 0x01, 0x00);
> > +             if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A)) {
> > +                     rtsx_pci_write_register(pcr, RTS524A_PM_CTRL3, 0x01, 0x00);
> > +                     rtsx_pci_write_register(pcr, RTS524A_PME_FORCE_CTL, 0x30, 0x20);
> > +             } else {
> > +                     rtsx_pci_write_register(pcr, PME_FORCE_CTL, 0xFF, 0x30);
> > +                     rtsx_pci_write_register(pcr, PM_CTRL3, 0x01, 0x00);
> > +             }
> >       }
> >
> >       /*
> > diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
> > index 5d15607027e9..cb105563bde7 100644
> > --- a/drivers/misc/cardreader/rtsx_pcr.c
> > +++ b/drivers/misc/cardreader/rtsx_pcr.c
> > @@ -20,6 +20,8 @@
> >  #include <linux/rtsx_pci.h>
> >  #include <linux/mmc/card.h>
> >  #include <asm/unaligned.h>
> > +#include <linux/pm.h>
> > +#include <linux/pm_runtime.h>
> >
> >  #include "rtsx_pcr.h"
> >  #include "rts5261.h"
> > @@ -89,9 +91,16 @@ static void rtsx_comm_set_aspm(struct rtsx_pcr *pcr, bool enable)
> >       if (pcr->aspm_enabled == enable)
> >               return;
> >
> > -     pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
> > -                                        PCI_EXP_LNKCTL_ASPMC,
> > -                                        enable ? pcr->aspm_en : 0);
> > +     if (pcr->aspm_en & 0x02)
> > +             rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, FORCE_ASPM_CTL0 |
> > +                     FORCE_ASPM_CTL1, enable ? 0 : FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1);
> > +     else
> > +             rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, FORCE_ASPM_CTL0 |
> > +                     FORCE_ASPM_CTL1, FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1);
> > +
> > +     if (!enable && (pcr->aspm_en & 0x02))
> > +             mdelay(10);
>
> This is a significant change that should be in its own patch and
> explained.  Previously we did standard PCI config reads/writes to the
> PCIe Link Control register.  After this change we'll use
> rtsx_pci_write_register(), which looks like it writes to an MMIO
> register in a BAR:
>
>   rtsx_pci_probe
>     pcr->remap_addr = ioremap(base, len)
>
>   rtsx_pci_write_register
>     rtsx_pci_writel(pcr, RTSX_HAIMR, val)
>       iowrite32(val, pcr->remap_addr + reg)
>
> It's not clear that the MMIO register in the BAR is the same as the
> one in config space.  And we still write the Link Control register in
> config space below and other places.  How are these supposed to be
> coordinated?
>
> Drivers should not change ASPM configuration directly.  Especially not
> in obfuscated ways like this.

Indeed.

> >       pcr->aspm_enabled = enable;
> >  }
> > @@ -143,6 +152,9 @@ void rtsx_pci_start_run(struct rtsx_pcr *pcr)
> >       /* If pci device removed, don't queue idle work any more */
> >       if (pcr->remove_pci)
> >               return;
> > +     if (pcr->rtd3_en)
> > +             if (pcr->pci->dev.power.usage_count.counter == 0)
> > +                     pm_runtime_get(&(pcr->pci->dev));
> >
> >       if (pcr->state != PDEV_STAT_RUN) {
> >               pcr->state = PDEV_STAT_RUN;
> > @@ -1075,6 +1087,19 @@ static void rtsx_pm_power_saving(struct rtsx_pcr *pcr)
> >       rtsx_comm_pm_power_saving(pcr);
> >  }
> >
> > +static void rtsx_pci_rtd3_work(struct work_struct *work)
> > +{
> > +     struct delayed_work *dwork = to_delayed_work(work);
> > +     struct rtsx_pcr *pcr = container_of(dwork, struct rtsx_pcr, rtd3_work);
> > +
> > +     pcr_dbg(pcr, "--> %s\n", __func__);
> > +
> > +     while (pcr->pci->dev.power.usage_count.counter > 0) {
> > +             if (pm_runtime_active(&(pcr->pci->dev)))
> > +                     pm_runtime_put(&(pcr->pci->dev));
>
> I'm not a runtime PM expert, but this looks fishy.  AFAICT this is the
> only driver in the tree that uses usage_count.counter this way, which
> is a pretty big hint that this needs a closer look.  Cc'd Rafael.

You are right, this is not correct from the PM-runtime POV.

It looks like this attempts to force the PM-runtime usage counter down
to 0 and it's kind of hard to say why this is done (and it shouldn't
be done in the first place, because it destroys the usage counter
balance).

Ricky, is this an attempt to work around an issue of some sort?
