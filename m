Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C117437AF4A
	for <lists+linux-pm@lfdr.de>; Tue, 11 May 2021 21:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhEKTZu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 May 2021 15:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbhEKTZt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 May 2021 15:25:49 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B653FC06174A
        for <linux-pm@vger.kernel.org>; Tue, 11 May 2021 12:24:41 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 15so27849594ybc.0
        for <linux-pm@vger.kernel.org>; Tue, 11 May 2021 12:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGvENOkuPQ559q07czqF9FsW+spU/J7SZEV8cH6j+EE=;
        b=FauppU6Ec0LOUyUySrkI+Lq3o/D/R7+A7VeThEup/AQGMw3Qsbt1/l6bBzkCFCzb2v
         MCGAt1jmpFZvP9ri8RFVJ1LM53hy7+cmQe/u1eSWBDRudCKJl9W4eQkiuVNWlg6IueIu
         nX1HWwRZ1a2q6qTyc0+KbOrS/0C6u3T2dWyHcIdp6rXhRRmVERVOWTizsDdgwK6MMXnr
         ndk6pGUDfGcapol6kSFTQBL+0N/O77f8HsuBhcU8X412H0YxKhRcskQ7q3oESOAG8X2L
         9mSnv5thVKpA4V6QoqIl7dm/AzswGxQKioVIzicR+bzdPAB9q00gmujNr6XhlQSLQAMZ
         Y2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGvENOkuPQ559q07czqF9FsW+spU/J7SZEV8cH6j+EE=;
        b=CiHw1qicD15Eb0CxvFTNmiXItw12sBv+gZgDdNQFzWSCPqlqs/cQbzbxjOzvTjQUQ5
         VNMFfi+ywI+Yfh+Dcp79HBmLvUPGK5kUBBl6QWlUULy67atZKauiBUNQKVRY3aCkFnI6
         vlo4PVkKwHSOaD4E7xYqCcfFCiQ6dcarw3SILI0N7vBA5BsHWtB8yzNNjsimdaIK7Jp/
         umh0dF9+AneJtlD6RjSaVYG3E6l7/1Wpq8b4RJyf9IT7zi/XL5mjJSpHnFTt0xGQM5fG
         m1BTVHi+HkIGZvrJivjWazH3CR57Tm6Bpodwuo+foKkn7jZlCaNXyTm8iIfd+UR0YQn+
         DccA==
X-Gm-Message-State: AOAM53181nMBYWOxOpEsSV+bcnhW4XkSSu06yakXcaUyYcjW4ca8vBdJ
        3Ab0W2vlXJoF2oU8EfcSizcqZkUypNBTAG72yNLXBQ==
X-Google-Smtp-Source: ABdhPJzRmyhNrK0J72B+ihLn26S+i1IyLaH3RYB9ty1Gnx3DCEh2LBq12SpYyvLtbpUItHK7t/npmc0ziCTcdOxWdlM=
X-Received: by 2002:a5b:8cc:: with SMTP id w12mr44063557ybq.32.1620761080662;
 Tue, 11 May 2021 12:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <3c88cf35-6725-1bfa-9e1e-8e9d69147e3b@hisilicon.com>
 <d16058fc-9876-f6a3-d5e8-ff06b5193f2c@intel.com> <2149723.iZASKD2KPV@kreacher>
In-Reply-To: <2149723.iZASKD2KPV@kreacher>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 11 May 2021 12:24:04 -0700
Message-ID: <CAGETcx-tRh45ZJzmbGvHay1htnjeE-EZc3CG9P3=qFfi75owHA@mail.gmail.com>
Subject: Re: Qestion about device link
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "chenxiang (M)" <chenxiang66@hisilicon.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        John Garry <john.garry@huawei.com>, linuxarm@huawei.com,
        linux-scsi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 11, 2021 at 12:16 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, May 11, 2021 4:39:31 PM CEST Rafael J. Wysocki wrote:
> > On 5/11/2021 5:59 AM, chenxiang (M) wrote:
> > > Hi Rafael and other guys,
> > >
> > > I am trying to add a device link between scsi_host->shost_gendev and
> > > hisi_hba->dev to support runtime PM for hisi_hba driver
> > >
> > > (as it supports runtime PM for scsi host in some scenarios such as
> > > error handler etc, we can avoid to do them again if adding a
> > >
> > > device link between scsi_host->shost_gendev and hisi_hba->dev) as
> > > follows (hisi_sas driver is under directory drivers/scsi/hisi_sas):
> > >
> > > device_link_add(&shost->shost_gendev, hisi_hba->dev,
> > > DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE)
> > >
> > > We have a full test on it, and it works well except when rmmod the
> > > driver, some call trace occurs as follows:
> > >
> > > [root@localhost ~]# rmmod hisi_sas_v3_hw
> > > [  105.377944] BUG: scheduling while atomic: kworker/113:1/811/0x00000201
> > > [  105.384469] Modules linked in: bluetooth rfkill ib_isert
> > > iscsi_target_mod ib_ipoib ib_umad iptable_filter vfio_iommu_type1
> > > vfio_pci vfio_virqfd vfio rpcrdma ib_is                         er
> > > libiscsi scsi_transport_iscsi crct10dif_ce sbsa_gwdt hns_roce_hw_v2
> > > hisi_sec2 hisi_hpre hisi_zip hisi_qm uacce spi_hisi_sfc_v3xx
> > > hisi_trng_v2 rng_core hisi_uncore                         _hha_pmu
> > > hisi_uncore_ddrc_pmu hisi_uncore_l3c_pmu spi_dw_mmio hisi_uncore_pmu
> > > hns3 hclge hnae3 hisi_sas_v3_hw(-) hisi_sas_main libsas
> > > [  105.424841] CPU: 113 PID: 811 Comm: kworker/113:1 Kdump: loaded
> > > Tainted: G        W         5.12.0-rc1+ #1
> > > [  105.434454] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS
> > > 2280-V2 CS V5.B143.01 04/22/2021
> > > [  105.443287] Workqueue: rcu_gp srcu_invoke_callbacks
> > > [  105.448154] Call trace:
> > > [  105.450593]  dump_backtrace+0x0/0x1a4
> > > [  105.454245]  show_stack+0x24/0x40
> > > [  105.457548]  dump_stack+0xc8/0x104
> > > [  105.460939]  __schedule_bug+0x68/0x80
> > > [  105.464590]  __schedule+0x73c/0x77c
> > > [  105.465700] BUG: scheduling while atomic: kworker/96:1/791/0x00000201
> > > [  105.468066]  schedule+0x7c/0x110
> > > [  105.468068]  schedule_timeout+0x194/0x1d4
> > > [  105.474490] Modules linked in:
> > > [  105.477692]  wait_for_completion+0x8c/0x12c
> > > [  105.477695]  rcu_barrier+0x1e0/0x2fc
> > > [  105.477697]  scsi_host_dev_release+0x50/0xf0
> > > [  105.477701]  device_release+0x40/0xa0
> > > [  105.477704]  kobject_put+0xac/0x100
> > > [  105.477707]  __device_link_free_srcu+0x50/0x74
> > > [  105.477709]  srcu_invoke_callbacks+0x108/0x1a4
> > > [  105.484743]  process_one_work+0x1dc/0x48c
> > > [  105.492468]  worker_thread+0x7c/0x464
> > > [  105.492471]  kthread+0x168/0x16c
> > > [  105.492473]  ret_from_fork+0x10/0x18
> > > ...
> > >
> > > After analyse the process, we find that it will
> > > device_del(&shost->gendev) in function scsi_remove_host() and then
> > >
> > > put_device(&shost->shost_gendev) in function scsi_host_put() when
> > > removing the driver, if there is a link between shost and hisi_hba->dev,
> > >
> > > it will try to delete the link in device_del(), and also will
> > > call_srcu(__device_link_free_srcu) to put_device() link->consumer and
> > > supplier.
> > >
> > > But if put device() for shost_gendev in device_link_free() is later
> > > than in scsi_host_put(), it will call scsi_host_dev_release() in
> > >
> > > srcu_invoke_callbacks() while it is atomic and there are scheduling in
> > > scsi_host_dev_release(),
> > >
> > > so it reports the BUG "scheduling while atomic:...".
> > >
> > > thread 1                                                   thread2
> > > hisi_sas_v3_remove
> > >     ...
> > >     sas_remove_host()
> > >         ...
> > >         scsi_remove_host()
> > >             ...
> > >             device_del(&shost->shost_gendev)
> > >                 ...
> > >                 device_link_purge()
> > >                     __device_link_del()
> > >                         device_unregister(&link->link_dev)
> > >                             devlink_dev_release
> > > call_srcu(__device_link_free_srcu)    ----------->
> > > srcu_invoke_callbacks  (atomic)
> > >         __device_link_free_srcu
> > >     ...
> > >     scsi_host_put()
> > >         put_device(&shost->shost_gendev) (ref = 1)
> > >                 device_link_free()
> > >                               put_device(link->consumer)
> > > //shost->gendev ref = 0
> > >                                           ...
> > >                                           scsi_host_dev_release
> > >                                                       ...
> > > rcu_barrier
> > > kthread_stop()
> > >
> > >
> > > We can check kref of shost->shost_gendev to make sure scsi_host_put()
> > > to release scsi host device in LLDD driver to avoid the issue,
> > >
> > > but it seems be a common issue:  function __device_link_free_srcu
> > > calls put_device() for consumer and supplier,
> > >
> > > but if it's ref =0 at that time and there are scheduling or sleep in
> > > dev_release, it may have the issue.
> > >
> > > Do you have any idea about the issue?
> > >
> > Yes, this is a general issue.
> >
> > If I'm not mistaken, it can be addressed by further deferring the
> > device_link_free() invocation through a workqueue.
> >
> > Let me cut a patch doing this.
>
> Please test the patch below and let me know if it works for you.
>
> ---
>  drivers/base/core.c    |   18 ++++++++++++++++--
>  include/linux/device.h |    5 ++++-
>  2 files changed, 20 insertions(+), 3 deletions(-)
>
> Index: linux-pm/drivers/base/core.c
> ===================================================================
> --- linux-pm.orig/drivers/base/core.c
> +++ linux-pm/drivers/base/core.c
> @@ -455,16 +455,30 @@ static void device_link_free(struct devi
>  }
>
>  #ifdef CONFIG_SRCU
> +static void __device_link_free_fn(struct work_struct *work)
> +{
> +       device_link_free(container_of(work, struct device_link, srcu.work));
> +}
> +
>  static void __device_link_free_srcu(struct rcu_head *rhead)
>  {
> -       device_link_free(container_of(rhead, struct device_link, rcu_head));
> +       struct device_link *link = container_of(rhead, struct device_link,
> +                                               srcu.rhead);
> +       struct work_struct *work = &link->srcu.work;
> +
> +       /*
> +        * Because device_link_free() may sleep in some cases, schedule the
> +        * execution of it instead of invoking it directly.
> +        */
> +       INIT_WORK(work, __device_link_free_fn);
> +       schedule_work(work);
>  }
>
>  static void devlink_dev_release(struct device *dev)
>  {
>         struct device_link *link = to_devlink(dev);
>
> -       call_srcu(&device_links_srcu, &link->rcu_head, __device_link_free_srcu);
> +       call_srcu(&device_links_srcu, &link->srcu.rhead, __device_link_free_srcu);
>  }
>  #else
>  static void devlink_dev_release(struct device *dev)
> Index: linux-pm/include/linux/device.h
> ===================================================================
> --- linux-pm.orig/include/linux/device.h
> +++ linux-pm/include/linux/device.h
> @@ -584,7 +584,10 @@ struct device_link {
>         refcount_t rpm_active;
>         struct kref kref;
>  #ifdef CONFIG_SRCU
> -       struct rcu_head rcu_head;
> +       union {
> +               struct rcu_head rhead;
> +               struct work_struct work;
> +       } srcu;

I'll do the actual review on a more final patch? I see you are trying
to save space, but is this worth the readability reduction?

-Saravana
