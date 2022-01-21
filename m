Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0F5495F17
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jan 2022 13:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380390AbiAUMjc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jan 2022 07:39:32 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40654
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234816AbiAUMjb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jan 2022 07:39:31 -0500
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 003154000F
        for <linux-pm@vger.kernel.org>; Fri, 21 Jan 2022 12:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642768769;
        bh=Ve0vmxejPhjvt08aaHaCMhDn2Ck4ojr7xG91ddvyNHU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=vUsDEp+2GCka28dB5pGt6QfSi7Ovy5xMUUHXWeiPHn01eWZhdAbif3jWKhy0nbxTl
         MzoYN1Q7bdVTWw9ZYIpDfd3vP8UM7mbdrdaiC09Y+BB6EhWFtYCQsiyQ6tCt07AiAS
         hnmcd2Qk1VJ6+XSc6/w9/ejh41bEQjmWRqadMWPkdAT5hmyzc7qXq3KZqxI0/v0/Gx
         wIKKGEp7P0uxZrxycupaiTJbwibfPuhpU0tmWG0u7x3moOnErQ1I/VpL+O9uLqI15Y
         7ETUHcyFn32O7GXiRM6Mfbt0azlWI8/a123gbzGL4AptkruEQo1dEQXjR2PNCtMvqJ
         SGxW6WUTGR+uQ==
Received: by mail-oo1-f69.google.com with SMTP id l24-20020a4ae2d8000000b002e16d58c8a0so2430803oot.11
        for <linux-pm@vger.kernel.org>; Fri, 21 Jan 2022 04:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ve0vmxejPhjvt08aaHaCMhDn2Ck4ojr7xG91ddvyNHU=;
        b=eVq78ex4mG9EnSWGLgWTfLQLoboFONKHAfsJeFvvMLrowR8laBRB/ytuHiR8r75P0O
         DbWzpABPudF0kAYF0QiGnUPZdERk22KC7LPFyF9ch5wik0qUtLIifKVZFFAHQ57pzlOm
         zNQop0li/IGHxQvMSVzVAmFe8BFR9vLBVjmXAVejYwdJuKEo1CKHxrokwvs/K53FkZ45
         FKf94t6lc9anhbzJOmSlJGd4LeHE4uQ67yKK/UvicQNap8Izzb6nigcVEIpCr+Lv+Wbm
         xyYM8BOs1SL5H2D7Qms++MoQrPCv8DgEfUXV52s4mBSMjEFvhNc8p4S8t8Vjwt9HCmKt
         RkbA==
X-Gm-Message-State: AOAM533RgJXr2+3+WlLPJ5JwP61k6FMcoMugBjvwSq5n6GUr57O0k56B
        zTFXToNI6cLtsiNCF+DPTLpeN1TLSlTAcpGT1nu9Q6Y2S8wa/tecZ0DWrsKNJ9ohKZyFKS3TjCW
        S95WGh3DftLmxvjsky+H8AShIXyFZ8BJ1nHUA+jseCGAHrwSPyRN9
X-Received: by 2002:a05:6808:30a0:: with SMTP id bl32mr387827oib.41.1642768767843;
        Fri, 21 Jan 2022 04:39:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxC8f89EYcR07ZH+mZLGeaEWzWA0xrJR5fyZS/okMF8WGHWXetRgzHyFCstYt0lVOGZTfdfwSjWHzgMt1IPBV0=
X-Received: by 2002:a05:6808:30a0:: with SMTP id bl32mr387807oib.41.1642768767330;
 Fri, 21 Jan 2022 04:39:27 -0800 (PST)
MIME-Version: 1.0
References: <20220121014039.1693208-1-kai.heng.feng@canonical.com>
 <20220121063138.1723616-1-kai.heng.feng@canonical.com> <3616f18533d34481a994d3450ecd8d85@realtek.com>
In-Reply-To: <3616f18533d34481a994d3450ecd8d85@realtek.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 21 Jan 2022 20:39:16 +0800
Message-ID: <CAAd53p7eJFjEv8TmR+HRUFDfueQ1z_E-8beXkaUk7cMaaaWP2w@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] misc: rtsx: Rework runtime power management flow
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yang Li <yang.lee@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 21, 2022 at 5:59 PM Ricky WU <ricky_wu@realtek.com> wrote:
>
> > -----Original Message-----
> > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Sent: Friday, January 21, 2022 2:32 PM
> > To: arnd@arndb.de; gregkh@linuxfoundation.org; ulf.hansson@linaro.org
> > Cc: linux-pm@vger.kernel.org; Kai-Heng Feng <kai.heng.feng@canonical.com>;
> > Ricky WU <ricky_wu@realtek.com>; Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr>; Yang Li <yang.lee@linux.alibaba.com>;
> > linux-kernel@vger.kernel.org
> > Subject: [PATCH v3 2/4] misc: rtsx: Rework runtime power management flow
> >
> > Commit 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM") uses
> > "rtd3_work" and "idle_work" to manage it's own runtime PM state machine.
> >
> > When its child device, rtsx_pci_sdmmc, uses runtime PM refcount correctly, all
> > the additional works can be managed by generic runtime PM helpers.
> >
> > So consolidate "idle_work" and "rtd3_work" into generic runtime idle callback
> > and runtime suspend callback, respectively.
>
>
> Original idle_work is for aspm delay time is 200 msec, because Aspm can quick in and out to save more power
> Now this patch need to wait 5 sec because set autosuspend time set to 5 sec in sdmmc,... this time need to set to 200 msec.

OK, will change it to 200ms.

>
> But it will get another question, the question is the host(sdmmc) caps has set MMC_CAP_AGGRESSIVE_PM when rtd3_en is set,
> It will make card power off when sdmmc go to suspend, 200 msec will cause card power off and on frequently
>
> Need to remove this flag in caps, and then change card power off to rtsx_pci_runtime_suspend()....

You are right, since rtsx_pci_sdmmc behaves like a virtual device of
rtsx_pci, so we should let the latter handle all the PM work.
Will drop MMC_CAP_AGGRESSIVE_PM in next iteration.

>
> What do you think?

Thanks for your testing and review.

One question though, regarding to the memstick virtual driver. The
memstick support was silently dropped by "misc: rtsx: Add support for
RTS5261", as RTSX_MS_CARD was removed from MFD cells.

Is there any memstick device in the wild? If there is, we should add
it back to the MFD cells to avoid regression.
And I guess starting from rts5261, only MMC is supported?

Kai-Heng

>
> Ricky
>
> >
> > Fixes: 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM")
> > Cc: Ricky WU <ricky_wu@realtek.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v3:
> >  - Allow runtime PM for all devices, but only schedule runtime suspend
> >    for devices with rtd3_en flagged.
> >
> > v2:
> >  - Remove unused idle_work and rtd3_work from rtsx_pcr.
> >
> >  drivers/misc/cardreader/rtsx_pcr.c | 118 ++++++++++-------------------
> >  include/linux/rtsx_pci.h           |   3 -
> >  2 files changed, 39 insertions(+), 82 deletions(-)
> >
> > diff --git a/drivers/misc/cardreader/rtsx_pcr.c
> > b/drivers/misc/cardreader/rtsx_pcr.c
> > index 6ac509c1821c9..f919290f01192 100644
> > --- a/drivers/misc/cardreader/rtsx_pcr.c
> > +++ b/drivers/misc/cardreader/rtsx_pcr.c
> > @@ -152,20 +152,12 @@ void rtsx_pci_start_run(struct rtsx_pcr *pcr)
> >       if (pcr->remove_pci)
> >               return;
> >
> > -     if (pcr->rtd3_en)
> > -             if (pcr->is_runtime_suspended) {
> > -                     pm_runtime_get(&(pcr->pci->dev));
> > -                     pcr->is_runtime_suspended = false;
> > -             }
> > -
> >       if (pcr->state != PDEV_STAT_RUN) {
> >               pcr->state = PDEV_STAT_RUN;
> >               if (pcr->ops->enable_auto_blink)
> >                       pcr->ops->enable_auto_blink(pcr);
> >               rtsx_pm_full_on(pcr);
> >       }
> > -
> > -     mod_delayed_work(system_wq, &pcr->idle_work, msecs_to_jiffies(200));
> >  }
> >  EXPORT_SYMBOL_GPL(rtsx_pci_start_run);
> >
> > @@ -1094,40 +1086,6 @@ static void rtsx_pm_power_saving(struct rtsx_pcr
> > *pcr)
> >       rtsx_comm_pm_power_saving(pcr);
> >  }
> >
> > -static void rtsx_pci_rtd3_work(struct work_struct *work) -{
> > -     struct delayed_work *dwork = to_delayed_work(work);
> > -     struct rtsx_pcr *pcr = container_of(dwork, struct rtsx_pcr, rtd3_work);
> > -
> > -     pcr_dbg(pcr, "--> %s\n", __func__);
> > -     if (!pcr->is_runtime_suspended)
> > -             pm_runtime_put(&(pcr->pci->dev));
> > -}
> > -
> > -static void rtsx_pci_idle_work(struct work_struct *work) -{
> > -     struct delayed_work *dwork = to_delayed_work(work);
> > -     struct rtsx_pcr *pcr = container_of(dwork, struct rtsx_pcr, idle_work);
> > -
> > -     pcr_dbg(pcr, "--> %s\n", __func__);
> > -
> > -     mutex_lock(&pcr->pcr_mutex);
> > -
> > -     pcr->state = PDEV_STAT_IDLE;
> > -
> > -     if (pcr->ops->disable_auto_blink)
> > -             pcr->ops->disable_auto_blink(pcr);
> > -     if (pcr->ops->turn_off_led)
> > -             pcr->ops->turn_off_led(pcr);
> > -
> > -     rtsx_pm_power_saving(pcr);
> > -
> > -     mutex_unlock(&pcr->pcr_mutex);
> > -
> > -     if (pcr->rtd3_en)
> > -             mod_delayed_work(system_wq, &pcr->rtd3_work,
> > msecs_to_jiffies(10000));
> > -}
> > -
> >  static void rtsx_base_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
> > {
> >       /* Set relink_time to 0 */
> > @@ -1598,7 +1556,6 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
> >       pcr->card_inserted = 0;
> >       pcr->card_removed = 0;
> >       INIT_DELAYED_WORK(&pcr->carddet_work, rtsx_pci_card_detect);
> > -     INIT_DELAYED_WORK(&pcr->idle_work, rtsx_pci_idle_work);
> >
> >       pcr->msi_en = msi_en;
> >       if (pcr->msi_en) {
> > @@ -1623,20 +1580,14 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
> >               rtsx_pcr_cells[i].pdata_size = sizeof(*handle);
> >       }
> >
> > -     if (pcr->rtd3_en) {
> > -             INIT_DELAYED_WORK(&pcr->rtd3_work, rtsx_pci_rtd3_work);
> > -             pm_runtime_allow(&pcidev->dev);
> > -             pm_runtime_enable(&pcidev->dev);
> > -             pcr->is_runtime_suspended = false;
> > -     }
> > -
> >
> >       ret = mfd_add_devices(&pcidev->dev, pcr->id, rtsx_pcr_cells,
> >                       ARRAY_SIZE(rtsx_pcr_cells), NULL, 0, NULL);
> >       if (ret < 0)
> >               goto free_slots;
> >
> > -     schedule_delayed_work(&pcr->idle_work, msecs_to_jiffies(200));
> > +     pm_runtime_allow(&pcidev->dev);
> > +     pm_runtime_put(&pcidev->dev);
> >
> >       return 0;
> >
> > @@ -1668,11 +1619,11 @@ static void rtsx_pci_remove(struct pci_dev
> > *pcidev)
> >       struct pcr_handle *handle = pci_get_drvdata(pcidev);
> >       struct rtsx_pcr *pcr = handle->pcr;
> >
> > -     if (pcr->rtd3_en)
> > -             pm_runtime_get_noresume(&pcr->pci->dev);
> > -
> >       pcr->remove_pci = true;
> >
> > +     pm_runtime_get_sync(&pcidev->dev);
> > +     pm_runtime_forbid(&pcidev->dev);
> > +
> >       /* Disable interrupts at the pcr level */
> >       spin_lock_irq(&pcr->lock);
> >       rtsx_pci_writel(pcr, RTSX_BIER, 0);
> > @@ -1680,9 +1631,6 @@ static void rtsx_pci_remove(struct pci_dev *pcidev)
> >       spin_unlock_irq(&pcr->lock);
> >
> >       cancel_delayed_work_sync(&pcr->carddet_work);
> > -     cancel_delayed_work_sync(&pcr->idle_work);
> > -     if (pcr->rtd3_en)
> > -             cancel_delayed_work_sync(&pcr->rtd3_work);
> >
> >       mfd_remove_devices(&pcidev->dev);
> >
> > @@ -1700,11 +1648,6 @@ static void rtsx_pci_remove(struct pci_dev
> > *pcidev)
> >       idr_remove(&rtsx_pci_idr, pcr->id);
> >       spin_unlock(&rtsx_pci_lock);
> >
> > -     if (pcr->rtd3_en) {
> > -             pm_runtime_disable(&pcr->pci->dev);
> > -             pm_runtime_put_noidle(&pcr->pci->dev);
> > -     }
> > -
> >       kfree(pcr->slots);
> >       kfree(pcr);
> >       kfree(handle);
> > @@ -1726,7 +1669,6 @@ static int __maybe_unused rtsx_pci_suspend(struct
> > device *dev_d)
> >       pcr = handle->pcr;
> >
> >       cancel_delayed_work(&pcr->carddet_work);
> > -     cancel_delayed_work(&pcr->idle_work);
> >
> >       mutex_lock(&pcr->pcr_mutex);
> >
> > @@ -1760,8 +1702,6 @@ static int __maybe_unused rtsx_pci_resume(struct
> > device *dev_d)
> >       if (ret)
> >               goto out;
> >
> > -     schedule_delayed_work(&pcr->idle_work, msecs_to_jiffies(200));
> > -
> >  out:
> >       mutex_unlock(&pcr->pcr_mutex);
> >       return ret;
> > @@ -1786,6 +1726,33 @@ static void rtsx_pci_shutdown(struct pci_dev
> > *pcidev)
> >               pci_disable_msi(pcr->pci);
> >  }
> >
> > +static int rtsx_pci_runtime_idle(struct device *device) {
> > +     struct pci_dev *pcidev = to_pci_dev(device);
> > +     struct pcr_handle *handle = pci_get_drvdata(pcidev);
> > +     struct rtsx_pcr *pcr = handle->pcr;
> > +
> > +     dev_dbg(device, "--> %s\n", __func__);
> > +
> > +     mutex_lock(&pcr->pcr_mutex);
> > +
> > +     pcr->state = PDEV_STAT_IDLE;
> > +
> > +     if (pcr->ops->disable_auto_blink)
> > +             pcr->ops->disable_auto_blink(pcr);
> > +     if (pcr->ops->turn_off_led)
> > +             pcr->ops->turn_off_led(pcr);
> > +
> > +     rtsx_pm_power_saving(pcr);
> > +
> > +     mutex_unlock(&pcr->pcr_mutex);
> > +
> > +     if (pcr->rtd3_en)
> > +             pm_schedule_suspend(device, 5000);
> > +
> > +     return -EBUSY;
> > +}
> > +
> >  static int rtsx_pci_runtime_suspend(struct device *device)  {
> >       struct pci_dev *pcidev = to_pci_dev(device); @@ -1794,31 +1761,26 @@
> > static int rtsx_pci_runtime_suspend(struct device *device)
> >
> >       handle = pci_get_drvdata(pcidev);
> >       pcr = handle->pcr;
> > -     dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
> >
> > -     cancel_delayed_work(&pcr->carddet_work);
> > -     cancel_delayed_work(&pcr->rtd3_work);
> > -     cancel_delayed_work(&pcr->idle_work);
> > +     dev_dbg(device, "--> %s\n", __func__);
> > +
> > +     cancel_delayed_work_sync(&pcr->carddet_work);
> >
> >       mutex_lock(&pcr->pcr_mutex);
> >       rtsx_pci_power_off(pcr, HOST_ENTER_S3);
> >
> >       mutex_unlock(&pcr->pcr_mutex);
> >
> > -     pcr->is_runtime_suspended = true;
> > -
> >       return 0;
> >  }
> >
> >  static int rtsx_pci_runtime_resume(struct device *device)  {
> >       struct pci_dev *pcidev = to_pci_dev(device);
> > -     struct pcr_handle *handle;
> > -     struct rtsx_pcr *pcr;
> > +     struct pcr_handle *handle = pci_get_drvdata(pcidev);
> > +     struct rtsx_pcr *pcr = handle->pcr;
> >
> > -     handle = pci_get_drvdata(pcidev);
> > -     pcr = handle->pcr;
> > -     dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
> > +     dev_dbg(device, "--> %s\n", __func__);
> >
> >       mutex_lock(&pcr->pcr_mutex);
> >
> > @@ -1834,8 +1796,6 @@ static int rtsx_pci_runtime_resume(struct device
> > *device)
> >                               pcr->slots[RTSX_SD_CARD].p_dev);
> >       }
> >
> > -     schedule_delayed_work(&pcr->idle_work, msecs_to_jiffies(200));
> > -
> >       mutex_unlock(&pcr->pcr_mutex);
> >       return 0;
> >  }
> > @@ -1850,7 +1810,7 @@ static int rtsx_pci_runtime_resume(struct device
> > *device)
> >
> >  static const struct dev_pm_ops rtsx_pci_pm_ops = {
> >       SET_SYSTEM_SLEEP_PM_OPS(rtsx_pci_suspend, rtsx_pci_resume)
> > -     SET_RUNTIME_PM_OPS(rtsx_pci_runtime_suspend,
> > rtsx_pci_runtime_resume, NULL)
> > +     SET_RUNTIME_PM_OPS(rtsx_pci_runtime_suspend,
> > rtsx_pci_runtime_resume,
> > +rtsx_pci_runtime_idle)
> >  };
> >
> >  static struct pci_driver rtsx_pci_driver = { diff --git a/include/linux/rtsx_pci.h
> > b/include/linux/rtsx_pci.h index 4ab7bfc675f11..89b7d34e25b63 100644
> > --- a/include/linux/rtsx_pci.h
> > +++ b/include/linux/rtsx_pci.h
> > @@ -1201,8 +1201,6 @@ struct rtsx_pcr {
> >       unsigned int                    card_exist;
> >
> >       struct delayed_work             carddet_work;
> > -     struct delayed_work             idle_work;
> > -     struct delayed_work             rtd3_work;
> >
> >       spinlock_t                      lock;
> >       struct mutex                    pcr_mutex;
> > @@ -1212,7 +1210,6 @@ struct rtsx_pcr {
> >       unsigned int                    cur_clock;
> >       bool                            remove_pci;
> >       bool                            msi_en;
> > -     bool                            is_runtime_suspended;
> >
> >  #define EXTRA_CAPS_SD_SDR50          (1 << 0)
> >  #define EXTRA_CAPS_SD_SDR104         (1 << 1)
> > --
> > 2.33.1
>
