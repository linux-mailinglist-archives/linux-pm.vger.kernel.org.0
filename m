Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FDD37EE39
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 00:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbhELVNX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 May 2021 17:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377943AbhELTJs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 May 2021 15:09:48 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F202C061288
        for <linux-pm@vger.kernel.org>; Wed, 12 May 2021 12:05:45 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id m9so32067552ybm.3
        for <linux-pm@vger.kernel.org>; Wed, 12 May 2021 12:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/t6C991YEpCJg7yb08JKknk8hM8glqnvNP2TBCIwnrg=;
        b=qYN6Ec5g/QLERkoenpzJMku8QDzrBKMXMzp+at1CxAxdt2n49RZxy05s/ObPmSnDv/
         wZAikOLIZuiwiApi4lsfuuUnXDGoHrIfkzmmMjqmAM7wIeczj0GhSHsa97ziWqA48KSF
         sMieiSe1iRDmkE5HHj364IBRzvok/MNV+/D3Yr5CkedBffHNAsYCcg9iDzfzxLqmXI0k
         ooe4ZlX8biRGqZoSaCeCmZA/lYAOtSRleucxvy8kGtksY49QefaC28SrJcRehbSUMgUD
         kpIdBLVFjA5SVsI2uhcXiYB+3cSSO3ZCmWVbiPgIWlM2hhzp53CaCBpr3kG3mH8U7TjV
         k0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/t6C991YEpCJg7yb08JKknk8hM8glqnvNP2TBCIwnrg=;
        b=HGNgJUd1xLEdYnDf4PlflvAlD2rCZB3KuEd9lh0h2vUkvuiHtwZv0bj5NeVjVHAan5
         TgBTBnZwgWvmn29AHsVdaADD3D7qvHZXVSLvJSwqxfJbunZvegOeH/VmdBQOD0iuVmQj
         1M8ourhSONFV4v5y0BohNDzoyQZ/G6noFa5/r37/0bKEA1NZy4WmeuvuhnIIqHzgVr7I
         IS5m78a9FUSG/lz/mD5guNLsRNl/SLNigd31gH7pPKideMa9MSS4HIiKb0RKBEDEDXr8
         KpszkIJWr1gPCJYcLeub3x2cL9T/JSUoWrv7ukRASbimN+tozfC2XAxw0mMCVrvM+pGs
         6Skw==
X-Gm-Message-State: AOAM531c4smqytCSjZCyJu06uCASl6fQe57zBdmWfqucRjykeZeEZlJ5
        waCs9Qn9asLFP1q42yOL2BNPQqJlUVKwzOiC8FTkZA==
X-Google-Smtp-Source: ABdhPJyX5xjLUHTMo13Ck2r000u3cDyPpP/JLHuwv0mahv7iA4U8f8fcsJkps8aN1jOKOuzUtPgQM25yO400rfL545w=
X-Received: by 2002:a25:5:: with SMTP id 5mr5715896yba.96.1620846344510; Wed,
 12 May 2021 12:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <3c88cf35-6725-1bfa-9e1e-8e9d69147e3b@hisilicon.com>
 <2149723.iZASKD2KPV@kreacher> <1c1cd889-7e6f-79f7-2650-cd181abc56b2@hisilicon.com>
 <11764789.O9o76ZdvQC@kreacher>
In-Reply-To: <11764789.O9o76ZdvQC@kreacher>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 12 May 2021 12:05:08 -0700
Message-ID: <CAGETcx8=VuwW0-GXDEbyt7qGrZJvUw=eyVXXJQxzOn9KszxhMQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 12, 2021 at 7:04 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote=
:
>
> On Wednesday, May 12, 2021 5:24:53 AM CEST chenxiang (M) wrote:
> > Hi Rafael,
> >
> >
> > =E5=9C=A8 2021/5/12 3:16, Rafael J. Wysocki =E5=86=99=E9=81=93:
> > > On Tuesday, May 11, 2021 4:39:31 PM CEST Rafael J. Wysocki wrote:
> > >> On 5/11/2021 5:59 AM, chenxiang (M) wrote:
> > >>> Hi Rafael and other guys,
> > >>>
> > >>> I am trying to add a device link between scsi_host->shost_gendev an=
d
> > >>> hisi_hba->dev to support runtime PM for hisi_hba driver
> > >>>
> > >>> (as it supports runtime PM for scsi host in some scenarios such as
> > >>> error handler etc, we can avoid to do them again if adding a
> > >>>
> > >>> device link between scsi_host->shost_gendev and hisi_hba->dev) as
> > >>> follows (hisi_sas driver is under directory drivers/scsi/hisi_sas):
> > >>>
> > >>> device_link_add(&shost->shost_gendev, hisi_hba->dev,
> > >>> DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE)
> > >>>
> > >>> We have a full test on it, and it works well except when rmmod the
> > >>> driver, some call trace occurs as follows:
> > >>>
> > >>> [root@localhost ~]# rmmod hisi_sas_v3_hw
> > >>> [  105.377944] BUG: scheduling while atomic: kworker/113:1/811/0x00=
000201
> > >>> [  105.384469] Modules linked in: bluetooth rfkill ib_isert
> > >>> iscsi_target_mod ib_ipoib ib_umad iptable_filter vfio_iommu_type1
> > >>> vfio_pci vfio_virqfd vfio rpcrdma ib_is                         er
> > >>> libiscsi scsi_transport_iscsi crct10dif_ce sbsa_gwdt hns_roce_hw_v2
> > >>> hisi_sec2 hisi_hpre hisi_zip hisi_qm uacce spi_hisi_sfc_v3xx
> > >>> hisi_trng_v2 rng_core hisi_uncore                         _hha_pmu
> > >>> hisi_uncore_ddrc_pmu hisi_uncore_l3c_pmu spi_dw_mmio hisi_uncore_pm=
u
> > >>> hns3 hclge hnae3 hisi_sas_v3_hw(-) hisi_sas_main libsas
> > >>> [  105.424841] CPU: 113 PID: 811 Comm: kworker/113:1 Kdump: loaded
> > >>> Tainted: G        W         5.12.0-rc1+ #1
> > >>> [  105.434454] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS
> > >>> 2280-V2 CS V5.B143.01 04/22/2021
> > >>> [  105.443287] Workqueue: rcu_gp srcu_invoke_callbacks
> > >>> [  105.448154] Call trace:
> > >>> [  105.450593]  dump_backtrace+0x0/0x1a4
> > >>> [  105.454245]  show_stack+0x24/0x40
> > >>> [  105.457548]  dump_stack+0xc8/0x104
> > >>> [  105.460939]  __schedule_bug+0x68/0x80
> > >>> [  105.464590]  __schedule+0x73c/0x77c
> > >>> [  105.465700] BUG: scheduling while atomic: kworker/96:1/791/0x000=
00201
> > >>> [  105.468066]  schedule+0x7c/0x110
> > >>> [  105.468068]  schedule_timeout+0x194/0x1d4
> > >>> [  105.474490] Modules linked in:
> > >>> [  105.477692]  wait_for_completion+0x8c/0x12c
> > >>> [  105.477695]  rcu_barrier+0x1e0/0x2fc
> > >>> [  105.477697]  scsi_host_dev_release+0x50/0xf0
> > >>> [  105.477701]  device_release+0x40/0xa0
> > >>> [  105.477704]  kobject_put+0xac/0x100
> > >>> [  105.477707]  __device_link_free_srcu+0x50/0x74
> > >>> [  105.477709]  srcu_invoke_callbacks+0x108/0x1a4
> > >>> [  105.484743]  process_one_work+0x1dc/0x48c
> > >>> [  105.492468]  worker_thread+0x7c/0x464
> > >>> [  105.492471]  kthread+0x168/0x16c
> > >>> [  105.492473]  ret_from_fork+0x10/0x18
> > >>> ...
> > >>>
> > >>> After analyse the process, we find that it will
> > >>> device_del(&shost->gendev) in function scsi_remove_host() and then
> > >>>
> > >>> put_device(&shost->shost_gendev) in function scsi_host_put() when
> > >>> removing the driver, if there is a link between shost and hisi_hba-=
>dev,
> > >>>
> > >>> it will try to delete the link in device_del(), and also will
> > >>> call_srcu(__device_link_free_srcu) to put_device() link->consumer a=
nd
> > >>> supplier.
> > >>>
> > >>> But if put device() for shost_gendev in device_link_free() is later
> > >>> than in scsi_host_put(), it will call scsi_host_dev_release() in
> > >>>
> > >>> srcu_invoke_callbacks() while it is atomic and there are scheduling=
 in
> > >>> scsi_host_dev_release(),
> > >>>
> > >>> so it reports the BUG "scheduling while atomic:...".
> > >>>
> > >>> thread 1                                                   thread2
> > >>> hisi_sas_v3_remove
> > >>>      ...
> > >>>      sas_remove_host()
> > >>>          ...
> > >>>          scsi_remove_host()
> > >>>              ...
> > >>>              device_del(&shost->shost_gendev)
> > >>>                  ...
> > >>>                  device_link_purge()
> > >>>                      __device_link_del()
> > >>>                          device_unregister(&link->link_dev)
> > >>>                              devlink_dev_release
> > >>> call_srcu(__device_link_free_srcu)    ----------->
> > >>> srcu_invoke_callbacks  (atomic)
> > >>>          __device_link_free_srcu
> > >>>      ...
> > >>>      scsi_host_put()
> > >>>          put_device(&shost->shost_gendev) (ref =3D 1)
> > >>>                  device_link_free()
> > >>>                                put_device(link->consumer)
> > >>> //shost->gendev ref =3D 0
> > >>>                                            ...
> > >>>                                            scsi_host_dev_release
> > >>>                                                        ...
> > >>> rcu_barrier
> > >>> kthread_stop()
> > >>>
> > >>>
> > >>> We can check kref of shost->shost_gendev to make sure scsi_host_put=
()
> > >>> to release scsi host device in LLDD driver to avoid the issue,
> > >>>
> > >>> but it seems be a common issue:  function __device_link_free_srcu
> > >>> calls put_device() for consumer and supplier,
> > >>>
> > >>> but if it's ref =3D0 at that time and there are scheduling or sleep=
 in
> > >>> dev_release, it may have the issue.
> > >>>
> > >>> Do you have any idea about the issue?
> > >>>
> > >> Yes, this is a general issue.
> > >>
> > >> If I'm not mistaken, it can be addressed by further deferring the
> > >> device_link_free() invocation through a workqueue.
> > >>
> > >> Let me cut a patch doing this.
> > > Please test the patch below and let me know if it works for you.
> >
> > I have a test on the patch, and it solves my issue.
>
> Great, thanks!
>
> Please also test the patch appended below (it uses a slightly different a=
pproach).
>
> ---
>  drivers/base/core.c    |   37 +++++++++++++++++++++++--------------
>  include/linux/device.h |    6 ++----
>  2 files changed, 25 insertions(+), 18 deletions(-)
>
> Index: linux-pm/drivers/base/core.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/base/core.c
> +++ linux-pm/drivers/base/core.c
> @@ -193,6 +193,11 @@ int device_links_read_lock_held(void)
>  {
>         return srcu_read_lock_held(&device_links_srcu);
>  }
> +
> +void device_link_synchronize_removal(void)
> +{
> +       synchronize_srcu(&device_links_srcu);
> +}
>  #else /* !CONFIG_SRCU */
>  static DECLARE_RWSEM(device_links_lock);
>
> @@ -223,6 +228,10 @@ int device_links_read_lock_held(void)
>         return lockdep_is_held(&device_links_lock);
>  }
>  #endif
> +
> +static inline void device_link_synchronize_removal(void)
> +{
> +}
>  #endif /* !CONFIG_SRCU */
>
>  static bool device_is_ancestor(struct device *dev, struct device *target=
)
> @@ -444,8 +453,13 @@ static struct attribute *devlink_attrs[]
>  };
>  ATTRIBUTE_GROUPS(devlink);
>
> -static void device_link_free(struct device_link *link)
> +static void device_link_release_fn(struct work_struct *work)
>  {
> +       struct device_link *link =3D container_of(work, struct device_lin=
k, rm_work);
> +
> +       /* Ensure that all references to the link object have been droppe=
d. */
> +       device_link_synchronize_removal();
> +
>         while (refcount_dec_not_one(&link->rpm_active))
>                 pm_runtime_put(link->supplier);
>
> @@ -454,24 +468,19 @@ static void device_link_free(struct devi
>         kfree(link);
>  }
>
> -#ifdef CONFIG_SRCU
> -static void __device_link_free_srcu(struct rcu_head *rhead)
> -{
> -       device_link_free(container_of(rhead, struct device_link, rcu_head=
));
> -}
> -
>  static void devlink_dev_release(struct device *dev)
>  {
>         struct device_link *link =3D to_devlink(dev);
>
> -       call_srcu(&device_links_srcu, &link->rcu_head, __device_link_free=
_srcu);
> -}
> -#else
> -static void devlink_dev_release(struct device *dev)
> -{
> -       device_link_free(to_devlink(dev));
> +       INIT_WORK(&link->rm_work, device_link_release_fn);
> +       /*
> +        * It may take a while to complete this work because of the SRCU
> +        * synchronization in device_link_release_fn() and if the consume=
r or
> +        * supplier devices get deleted when it runs, so put it into the =
"long"
> +        * workqueue.
> +        */
> +       queue_work(system_long_wq, &link->rm_work);

Not too strong of an opinion, but this seems like an unnecessary work
queue when SRCUs aren't enabled. We could just leave this part as is
and limit your changes to the SRCU implementation?

For the SRCU implementation, yes, this is a lot cleaner/nicer than
kicking off another work from the SRCU callback.

-Saravana

>  }
> -#endif
>
>  static struct class devlink_class =3D {
>         .name =3D "devlink",
> Index: linux-pm/include/linux/device.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/include/linux/device.h
> +++ linux-pm/include/linux/device.h
> @@ -570,7 +570,7 @@ struct device {
>   * @flags: Link flags.
>   * @rpm_active: Whether or not the consumer device is runtime-PM-active.
>   * @kref: Count repeated addition of the same link.
> - * @rcu_head: An RCU head to use for deferred execution of SRCU callback=
s.
> + * @rm_work: Work structure used for removing the link.
>   * @supplier_preactivated: Supplier has been made active before consumer=
 probe.
>   */
>  struct device_link {
> @@ -583,9 +583,7 @@ struct device_link {
>         u32 flags;
>         refcount_t rpm_active;
>         struct kref kref;
> -#ifdef CONFIG_SRCU
> -       struct rcu_head rcu_head;
> -#endif
> +       struct work_struct rm_work;
>         bool supplier_preactivated; /* Owned by consumer probe. */
>  };
>
