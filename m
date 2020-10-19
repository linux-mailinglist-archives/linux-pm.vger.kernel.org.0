Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DD8292C45
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 19:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbgJSRD7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 13:03:59 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:44843 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730830AbgJSRD6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 13:03:58 -0400
Received: by mail-oo1-f67.google.com with SMTP id f26so12836oou.11
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 10:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrjY3vt/K/yfQ6JxXi8383d7zXME9i3Oq+3e54gISck=;
        b=g6drHJ+EPql+vP6gD6YEees1daSeKPefLAkC0vkkLXQDjt7cParUWkMEmj0Xx1xLGC
         +VVLhIBSEfxK4XIuYq1dX7xtMFa7doqDiwoR5H/1puupFimqR6FlmBTPugvAq7ZjrbU7
         OOv3ufZSFonX7Qs9TYmKshxP4+qVsYuooiFBNQe1nCXsY+W6UhUep49QaZPbpjKSrfuC
         UEoCDDK+OD4+z3G6k9qVn6VpauchqMHZ2JUFtdcodPXi2+B5CBS6zxx/RnJ8RrEOA4CI
         h9w9MEgU0TTaV0nBQe0eDqvo+rQuUH8YGGybc+Li8rciuSxVtNmFi8szpuemw2G/8xCX
         m6fw==
X-Gm-Message-State: AOAM531FzILOOhOmNwmRKL1jP8i3qKWLSxtQqo7Xda7ff+fDmdfZtnJh
        s5cDDPirZYTRvbBIZfpFwhBwgPgNJPDmu64KXwy2rv1Bp3I=
X-Google-Smtp-Source: ABdhPJwBG8SH04sWqVrVcKpQXB4LPzF5NyakV4Wg4dL4uabRYvnzGA3VwC+UIpr4elM76OEgxNHyn8z7H3PPrQbLwXU=
X-Received: by 2002:a4a:5d84:: with SMTP id w126mr658277ooa.1.1603127037841;
 Mon, 19 Oct 2020 10:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <1600780266-155908-1-git-send-email-chenxiang66@hisilicon.com> <CAJZ5v0jXWV0ewLWbn2Fabp1HsK8oCsio3J1h7UMr5ZEcVTGjqg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jXWV0ewLWbn2Fabp1HsK8oCsio3J1h7UMr5ZEcVTGjqg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 19 Oct 2020 19:03:46 +0200
Message-ID: <CAJZ5v0h6Sf9zpKFZsmzwpOiSWnqrASEo8PQVr5rTm=pwUxM-bw@mail.gmail.com>
Subject: Re: [PATCH v2] PM:runtime:Remove the link state check in function
 rpm_get_supplier() and rpm_put_supplier()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Xiang Chen <chenxiang66@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 25, 2020 at 5:02 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Sep 22, 2020 at 3:15 PM chenxiang <chenxiang66@hisilicon.com> wrote:
> >
> > From: Xiang Chen <chenxiang66@hisilicon.com>
> >
> > To support runtime PM for hisi SAS driver (the driver is in directory
> > drivers/scsi/hisi_sas), we add device link between scsi_device->sdev_gendev
> > (consumer device) and hisi_hba->dev(supplier device) with flags
> > DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE.
> > After runtime suspended consumers and supplier, unload the dirver which
> > cause a hung. We find that it calls function device_release_driver_internal()
> > to release supplier device hisi_hba->dev, as the device link is busy,
> > it sets the device link as DL_STATE_SUPPLIER_UNBIND, and then call function
> > device_release_driver_internal() to release consumer device
> > scsi_device->sdev_gendev). Then it will try to call pm_runtime_get_sync()
> > to resume consumer device, as consumer-supplier relation exists, it will try
> > to resume supplier first,

It looks like I have overlooked one thing here.

Does it help (without the $subject patch) to move the
pm_runtime_get_sync(dev) in __device_release_driver() before the while
(device_links_busy(dev)) loop?

> > but as the link state is already set as
> > DL_STATE_SUPPLIER_UNBIND, so it skips resuming supplier and only resume
> > consumer which cause a hung (it sends IOs to resume scsi_device while
> > SAS controller is suspended). Simple flow is as follows:
> >
> > device_release_driver_internal -> (supplier device)
> >     if device_links_busy ->
> >         device_links_unbind_consumers ->
> >             ...
> >             WRITE_ONCE(link->status, DL_STATE_SUPPLIER_UNBIND)
> >             device_release_driver_internal (consumer device)
> >     pm_runtime_get_sync -> (consumer device)
> >         ...
> >         __rpm_callback ->
> >             rpm_get_suppliers ->
> >                 if link->state == DL_STATE_SUPPLIER_UNBIND -> skip the action of resuming the supplier
> >                 ...
> >     pm_runtime_clean_up_links
> >     ...
> >
> > It should guarantee correct suspend/resume ordering between a supplier
> > device and its consumer devices (resume the supplier device before resuming
> > consumer devices, and suspend consumer devices before suspending supplier
> > device) for runtime PM, but it seems the checks in rpm_get_supplier() and
> > rpm_put_supplier() break the rule, so remove them.
> >
> > Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> > ---
> >  drivers/base/power/runtime.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 8143210..6f605f7 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -291,8 +291,7 @@ static int rpm_get_suppliers(struct device *dev)
> >                                 device_links_read_lock_held()) {
> >                 int retval;
> >
> > -               if (!(link->flags & DL_FLAG_PM_RUNTIME) ||
> > -                   READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND)
> > +               if (!(link->flags & DL_FLAG_PM_RUNTIME))
> >                         continue;
> >
> >                 retval = pm_runtime_get_sync(link->supplier);
> > @@ -312,8 +311,6 @@ static void rpm_put_suppliers(struct device *dev)
> >
> >         list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
> >                                 device_links_read_lock_held()) {
> > -               if (READ_ONCE(link->status) == DL_STATE_SUPPLIER_UNBIND)
> > -                       continue;
> >
> >                 while (refcount_dec_not_one(&link->rpm_active))
> >                         pm_runtime_put(link->supplier);
> > --
>
> Applied as 5.10 material with some edits in the subject and changelog, thanks!

I may need to revert it, because it introduced a (theoretical for now)
race condition between PM-runtime and pm_runtime_clean_up_links().

Thanks!
