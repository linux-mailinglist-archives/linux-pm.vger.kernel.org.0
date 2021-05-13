Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D5637F7A5
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 14:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbhEMMPw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 13 May 2021 08:15:52 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:38569 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhEMMPY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 May 2021 08:15:24 -0400
Received: by mail-oi1-f172.google.com with SMTP id z3so23906086oib.5;
        Thu, 13 May 2021 05:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oOheMdP06lbk6PH6ouSDQAu641Bt26U4eryxHdqKkwI=;
        b=eNHq9h0hG0ZK9CG/TDDXhlQEqDBvFOa9IJOUYloEUka29cyp1hqVVv6FL9nmYfh/ZZ
         Kky3QJEXz1vqGSUIHCAoozwZCvf+IyK2BMDEERPj2ymgn3bnFvcJKybt8WdJ0qidFVWR
         SM9ZIlrjWwRTWqRaBMEHV5oK/ygBT5N3o97m4nXwyqwC3SK4UCV/pHwa+jVl/eI4QCVb
         QTxMPIoskbKhEdvHrNmf5qvWHgA1BAM4HC9eLXMnrIzJxyQli4SUdVw5F5ZvvZbhd6Yg
         Wk7Wm9pTyedaULlLg7Ky2FD94FQtbleO9K1710aflYO2KeHbz9zJrQ26e2O4N6Ilmh5t
         ulaA==
X-Gm-Message-State: AOAM532jSqsx5acOCUace8GJhQy8E6FQNFh1Jo+7Xy5BBR6Mj0TBSOqa
        142d+hZ7WG+hjIObSltbJo+/PgV+5KQCAenQb0U=
X-Google-Smtp-Source: ABdhPJxyMcOmoHWyMGTE7GSmhokIQFSARhAhM6o9hTNUe4CuK7eQddbAzn1L0Ls9SRTQILpf6RGSaHFUmJd+puaaN5s=
X-Received: by 2002:a05:6808:90d:: with SMTP id w13mr15376922oih.71.1620908054342;
 Thu, 13 May 2021 05:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <3c88cf35-6725-1bfa-9e1e-8e9d69147e3b@hisilicon.com>
 <2149723.iZASKD2KPV@kreacher> <1c1cd889-7e6f-79f7-2650-cd181abc56b2@hisilicon.com>
 <11764789.O9o76ZdvQC@kreacher> <0de9b48f-0d62-9413-943f-cd130bae8335@hisilicon.com>
In-Reply-To: <0de9b48f-0d62-9413-943f-cd130bae8335@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 May 2021 14:14:02 +0200
Message-ID: <CAJZ5v0gK-Z5a++70nsqEuDBMpXoGZJg52j_0-ps+cp+mHWzfxA@mail.gmail.com>
Subject: Re: Qestion about device link
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        John Garry <john.garry@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 13, 2021 at 5:00 AM chenxiang (M) <chenxiang66@hisilicon.com> wrote:
>
> Hi Rafael,
>
>
> 在 2021/5/12 22:04, Rafael J. Wysocki 写道:
> > On Wednesday, May 12, 2021 5:24:53 AM CEST chenxiang (M) wrote:
> >> Hi Rafael,
> >>
> >>
> >> 在 2021/5/12 3:16, Rafael J. Wysocki 写道:
> >>> On Tuesday, May 11, 2021 4:39:31 PM CEST Rafael J. Wysocki wrote:
> >>>> On 5/11/2021 5:59 AM, chenxiang (M) wrote:
> >>>>> Hi Rafael and other guys,
> >>>>>
> >>>>> I am trying to add a device link between scsi_host->shost_gendev and
> >>>>> hisi_hba->dev to support runtime PM for hisi_hba driver
> >>>>>
> >>>>> (as it supports runtime PM for scsi host in some scenarios such as
> >>>>> error handler etc, we can avoid to do them again if adding a
> >>>>>
> >>>>> device link between scsi_host->shost_gendev and hisi_hba->dev) as
> >>>>> follows (hisi_sas driver is under directory drivers/scsi/hisi_sas):
> >>>>>
> >>>>> device_link_add(&shost->shost_gendev, hisi_hba->dev,
> >>>>> DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE)
> >>>>>
> >>>>> We have a full test on it, and it works well except when rmmod the
> >>>>> driver, some call trace occurs as follows:
> >>>>>
> >>>>> [root@localhost ~]# rmmod hisi_sas_v3_hw
> >>>>> [  105.377944] BUG: scheduling while atomic: kworker/113:1/811/0x00000201
> >>>>> [  105.384469] Modules linked in: bluetooth rfkill ib_isert
> >>>>> iscsi_target_mod ib_ipoib ib_umad iptable_filter vfio_iommu_type1
> >>>>> vfio_pci vfio_virqfd vfio rpcrdma ib_is                         er
> >>>>> libiscsi scsi_transport_iscsi crct10dif_ce sbsa_gwdt hns_roce_hw_v2
> >>>>> hisi_sec2 hisi_hpre hisi_zip hisi_qm uacce spi_hisi_sfc_v3xx
> >>>>> hisi_trng_v2 rng_core hisi_uncore                         _hha_pmu
> >>>>> hisi_uncore_ddrc_pmu hisi_uncore_l3c_pmu spi_dw_mmio hisi_uncore_pmu
> >>>>> hns3 hclge hnae3 hisi_sas_v3_hw(-) hisi_sas_main libsas
> >>>>> [  105.424841] CPU: 113 PID: 811 Comm: kworker/113:1 Kdump: loaded
> >>>>> Tainted: G        W         5.12.0-rc1+ #1
> >>>>> [  105.434454] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS
> >>>>> 2280-V2 CS V5.B143.01 04/22/2021
> >>>>> [  105.443287] Workqueue: rcu_gp srcu_invoke_callbacks
> >>>>> [  105.448154] Call trace:
> >>>>> [  105.450593]  dump_backtrace+0x0/0x1a4
> >>>>> [  105.454245]  show_stack+0x24/0x40
> >>>>> [  105.457548]  dump_stack+0xc8/0x104
> >>>>> [  105.460939]  __schedule_bug+0x68/0x80
> >>>>> [  105.464590]  __schedule+0x73c/0x77c
> >>>>> [  105.465700] BUG: scheduling while atomic: kworker/96:1/791/0x00000201
> >>>>> [  105.468066]  schedule+0x7c/0x110
> >>>>> [  105.468068]  schedule_timeout+0x194/0x1d4
> >>>>> [  105.474490] Modules linked in:
> >>>>> [  105.477692]  wait_for_completion+0x8c/0x12c
> >>>>> [  105.477695]  rcu_barrier+0x1e0/0x2fc
> >>>>> [  105.477697]  scsi_host_dev_release+0x50/0xf0
> >>>>> [  105.477701]  device_release+0x40/0xa0
> >>>>> [  105.477704]  kobject_put+0xac/0x100
> >>>>> [  105.477707]  __device_link_free_srcu+0x50/0x74
> >>>>> [  105.477709]  srcu_invoke_callbacks+0x108/0x1a4
> >>>>> [  105.484743]  process_one_work+0x1dc/0x48c
> >>>>> [  105.492468]  worker_thread+0x7c/0x464
> >>>>> [  105.492471]  kthread+0x168/0x16c
> >>>>> [  105.492473]  ret_from_fork+0x10/0x18
> >>>>> ...
> >>>>>
> >>>>> After analyse the process, we find that it will
> >>>>> device_del(&shost->gendev) in function scsi_remove_host() and then
> >>>>>
> >>>>> put_device(&shost->shost_gendev) in function scsi_host_put() when
> >>>>> removing the driver, if there is a link between shost and hisi_hba->dev,
> >>>>>
> >>>>> it will try to delete the link in device_del(), and also will
> >>>>> call_srcu(__device_link_free_srcu) to put_device() link->consumer and
> >>>>> supplier.
> >>>>>
> >>>>> But if put device() for shost_gendev in device_link_free() is later
> >>>>> than in scsi_host_put(), it will call scsi_host_dev_release() in
> >>>>>
> >>>>> srcu_invoke_callbacks() while it is atomic and there are scheduling in
> >>>>> scsi_host_dev_release(),
> >>>>>
> >>>>> so it reports the BUG "scheduling while atomic:...".
> >>>>>
> >>>>> thread 1                                                   thread2
> >>>>> hisi_sas_v3_remove
> >>>>>       ...
> >>>>>       sas_remove_host()
> >>>>>           ...
> >>>>>           scsi_remove_host()
> >>>>>               ...
> >>>>>               device_del(&shost->shost_gendev)
> >>>>>                   ...
> >>>>>                   device_link_purge()
> >>>>>                       __device_link_del()
> >>>>>                           device_unregister(&link->link_dev)
> >>>>>                               devlink_dev_release
> >>>>> call_srcu(__device_link_free_srcu)    ----------->
> >>>>> srcu_invoke_callbacks  (atomic)
> >>>>>           __device_link_free_srcu
> >>>>>       ...
> >>>>>       scsi_host_put()
> >>>>>           put_device(&shost->shost_gendev) (ref = 1)
> >>>>>                   device_link_free()
> >>>>>                                 put_device(link->consumer)
> >>>>> //shost->gendev ref = 0
> >>>>>                                             ...
> >>>>>                                             scsi_host_dev_release
> >>>>>                                                         ...
> >>>>> rcu_barrier
> >>>>> kthread_stop()
> >>>>>
> >>>>>
> >>>>> We can check kref of shost->shost_gendev to make sure scsi_host_put()
> >>>>> to release scsi host device in LLDD driver to avoid the issue,
> >>>>>
> >>>>> but it seems be a common issue:  function __device_link_free_srcu
> >>>>> calls put_device() for consumer and supplier,
> >>>>>
> >>>>> but if it's ref =0 at that time and there are scheduling or sleep in
> >>>>> dev_release, it may have the issue.
> >>>>>
> >>>>> Do you have any idea about the issue?
> >>>>>
> >>>> Yes, this is a general issue.
> >>>>
> >>>> If I'm not mistaken, it can be addressed by further deferring the
> >>>> device_link_free() invocation through a workqueue.
> >>>>
> >>>> Let me cut a patch doing this.
> >>> Please test the patch below and let me know if it works for you.
> >> I have a test on the patch, and it solves my issue.
> > Great, thanks!
> >
> > Please also test the patch appended below (it uses a slightly different approach).
>
> I have a test on this change, and it also solves my issue.

Awesome, thanks!

> >
> > ---
> >   drivers/base/core.c    |   37 +++++++++++++++++++++++--------------
> >   include/linux/device.h |    6 ++----
> >   2 files changed, 25 insertions(+), 18 deletions(-)
> >
> > Index: linux-pm/drivers/base/core.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/core.c
> > +++ linux-pm/drivers/base/core.c
> > @@ -193,6 +193,11 @@ int device_links_read_lock_held(void)
> >   {
> >       return srcu_read_lock_held(&device_links_srcu);
> >   }
> > +
> > +void device_link_synchronize_removal(void)
> > +{
> > +     synchronize_srcu(&device_links_srcu);
> > +}
> >   #else /* !CONFIG_SRCU */
> >   static DECLARE_RWSEM(device_links_lock);
> >
> > @@ -223,6 +228,10 @@ int device_links_read_lock_held(void)
> >       return lockdep_is_held(&device_links_lock);
> >   }
> >   #endif
> > +
> > +static inline void device_link_synchronize_removal(void)
> > +{
> > +}
> >   #endif /* !CONFIG_SRCU */
> >
> >   static bool device_is_ancestor(struct device *dev, struct device *target)
> > @@ -444,8 +453,13 @@ static struct attribute *devlink_attrs[]
> >   };
> >   ATTRIBUTE_GROUPS(devlink);
> >
> > -static void device_link_free(struct device_link *link)
> > +static void device_link_release_fn(struct work_struct *work)
> >   {
> > +     struct device_link *link = container_of(work, struct device_link, rm_work);
> > +
> > +     /* Ensure that all references to the link object have been dropped. */
> > +     device_link_synchronize_removal();
> > +
> >       while (refcount_dec_not_one(&link->rpm_active))
> >               pm_runtime_put(link->supplier);
> >
> > @@ -454,24 +468,19 @@ static void device_link_free(struct devi
> >       kfree(link);
> >   }
> >
> > -#ifdef CONFIG_SRCU
> > -static void __device_link_free_srcu(struct rcu_head *rhead)
> > -{
> > -     device_link_free(container_of(rhead, struct device_link, rcu_head));
> > -}
> > -
> >   static void devlink_dev_release(struct device *dev)
> >   {
> >       struct device_link *link = to_devlink(dev);
> >
> > -     call_srcu(&device_links_srcu, &link->rcu_head, __device_link_free_srcu);
> > -}
> > -#else
> > -static void devlink_dev_release(struct device *dev)
> > -{
> > -     device_link_free(to_devlink(dev));
> > +     INIT_WORK(&link->rm_work, device_link_release_fn);
> > +     /*
> > +      * It may take a while to complete this work because of the SRCU
> > +      * synchronization in device_link_release_fn() and if the consumer or
> > +      * supplier devices get deleted when it runs, so put it into the "long"
> > +      * workqueue.
> > +      */
> > +     queue_work(system_long_wq, &link->rm_work);
> >   }
> > -#endif
> >
> >   static struct class devlink_class = {
> >       .name = "devlink",
> > Index: linux-pm/include/linux/device.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/device.h
> > +++ linux-pm/include/linux/device.h
> > @@ -570,7 +570,7 @@ struct device {
> >    * @flags: Link flags.
> >    * @rpm_active: Whether or not the consumer device is runtime-PM-active.
> >    * @kref: Count repeated addition of the same link.
> > - * @rcu_head: An RCU head to use for deferred execution of SRCU callbacks.
> > + * @rm_work: Work structure used for removing the link.
> >    * @supplier_preactivated: Supplier has been made active before consumer probe.
> >    */
> >   struct device_link {
> > @@ -583,9 +583,7 @@ struct device_link {
> >       u32 flags;
> >       refcount_t rpm_active;
> >       struct kref kref;
> > -#ifdef CONFIG_SRCU
> > -     struct rcu_head rcu_head;
> > -#endif
> > +     struct work_struct rm_work;
> >       bool supplier_preactivated; /* Owned by consumer probe. */
> >   };
> >
> >
> >
> >
> >
> > .
> >
>
>
