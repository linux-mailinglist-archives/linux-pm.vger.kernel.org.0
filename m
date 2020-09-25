Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F8D278BFC
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 17:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgIYPDD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 11:03:03 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39466 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbgIYPDD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 11:03:03 -0400
Received: by mail-oi1-f193.google.com with SMTP id c13so3079747oiy.6
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2020 08:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AlhuTku16C7kKO9E6mmqcV3j3YRp6wf5TkC/4nnix8k=;
        b=JLA4zC8IyD3MCqYuOXvvOAPG6UKt+s0/iv36a/NnhQYI0+2YQN7a4j1vq3b/qGqwFJ
         nHgq+I+qnX5Q0wE0fUxWkC84Xr9WiKKU0QdFvZ0KAo33kHZvpmSyDCc/7vs5lzr56Cav
         iVUz9vu3GraMTKcHesZWYzpa32cJn28x3im33/1qbC9Wfp15IcGIlkXSOHJCfOZV4i68
         02SabkJ12lDYILg7fPXKYLEN9hvCy9SbS8mSOMQZb2T4lmzxvJ7ZKmf1yEMCkznGPoSv
         NiO3G+qt6qBTnIxvaOoDJz0/l08GGwA2uJwOAmfTNo2gR0UlwSSSnOhkbo47MJavY2qJ
         eEeQ==
X-Gm-Message-State: AOAM531qKKB+9NKxsKnKjK+bZA6JZUiujtRn0rX1Zu+6j0bzX6mEHUQ5
        B5HOehR2Dk4RrBsuKMY84moQOtspb1h0B0PSYaNNCjmx
X-Google-Smtp-Source: ABdhPJy7iLjNcT7fAkqBR8UyKE8PoB1gJGxJhDN3nj/6IdnNvJXITOJ3Tz5I/YHZotG0pWzEG9WMQWI+mIKvDJ8VcVQ=
X-Received: by 2002:a05:6808:491:: with SMTP id z17mr520937oid.110.1601046182278;
 Fri, 25 Sep 2020 08:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <1600780266-155908-1-git-send-email-chenxiang66@hisilicon.com>
In-Reply-To: <1600780266-155908-1-git-send-email-chenxiang66@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 17:02:51 +0200
Message-ID: <CAJZ5v0jXWV0ewLWbn2Fabp1HsK8oCsio3J1h7UMr5ZEcVTGjqg@mail.gmail.com>
Subject: Re: [PATCH v2] PM:runtime:Remove the link state check in function
 rpm_get_supplier() and rpm_put_supplier()
To:     chenxiang <chenxiang66@hisilicon.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 22, 2020 at 3:15 PM chenxiang <chenxiang66@hisilicon.com> wrote:
>
> From: Xiang Chen <chenxiang66@hisilicon.com>
>
> To support runtime PM for hisi SAS driver (the driver is in directory
> drivers/scsi/hisi_sas), we add device link between scsi_device->sdev_gendev
> (consumer device) and hisi_hba->dev(supplier device) with flags
> DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE.
> After runtime suspended consumers and supplier, unload the dirver which
> cause a hung. We find that it calls function device_release_driver_internal()
> to release supplier device hisi_hba->dev, as the device link is busy,
> it sets the device link as DL_STATE_SUPPLIER_UNBIND, and then call function
> device_release_driver_internal() to release consumer device
> scsi_device->sdev_gendev). Then it will try to call pm_runtime_get_sync()
> to resume consumer device, as consumer-supplier relation exists, it will try
> to resume supplier first, but as the link state is already set as
> DL_STATE_SUPPLIER_UNBIND, so it skips resuming supplier and only resume
> consumer which cause a hung (it sends IOs to resume scsi_device while
> SAS controller is suspended). Simple flow is as follows:
>
> device_release_driver_internal -> (supplier device)
>     if device_links_busy ->
>         device_links_unbind_consumers ->
>             ...
>             WRITE_ONCE(link->status, DL_STATE_SUPPLIER_UNBIND)
>             device_release_driver_internal (consumer device)
>     pm_runtime_get_sync -> (consumer device)
>         ...
>         __rpm_callback ->
>             rpm_get_suppliers ->
>                 if link->state == DL_STATE_SUPPLIER_UNBIND -> skip the action of resuming the supplier
>                 ...
>     pm_runtime_clean_up_links
>     ...
>
> It should guarantee correct suspend/resume ordering between a supplier
> device and its consumer devices (resume the supplier device before resuming
> consumer devices, and suspend consumer devices before suspending supplier
> device) for runtime PM, but it seems the checks in rpm_get_supplier() and
> rpm_put_supplier() break the rule, so remove them.
>
> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> ---
>  drivers/base/power/runtime.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 8143210..6f605f7 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -291,8 +291,7 @@ static int rpm_get_suppliers(struct device *dev)
>                                 device_links_read_lock_held()) {
>                 int retval;
>
> -               if (!(link->flags & DL_FLAG_PM_RUNTIME) ||
> -                   READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND)
> +               if (!(link->flags & DL_FLAG_PM_RUNTIME))
>                         continue;
>
>                 retval = pm_runtime_get_sync(link->supplier);
> @@ -312,8 +311,6 @@ static void rpm_put_suppliers(struct device *dev)
>
>         list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
>                                 device_links_read_lock_held()) {
> -               if (READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND)
> -                       continue;
>
>                 while (refcount_dec_not_one(&link->rpm_active))
>                         pm_runtime_put(link->supplier);
> --

Applied as 5.10 material with some edits in the subject and changelog, thanks!
