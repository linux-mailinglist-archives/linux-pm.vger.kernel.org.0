Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3A73C22D8
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 13:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhGILbr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 07:31:47 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:45811 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhGILbr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 07:31:47 -0400
Received: by mail-ot1-f50.google.com with SMTP id 75-20020a9d08510000b02904acfe6bcccaso9069597oty.12;
        Fri, 09 Jul 2021 04:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wTbGnuKSf0w+U6qJZrDRBkicmtkQO5iEcPQTwx3qaD4=;
        b=g+pXASeIk/rftnhIDz/+W5VwMm47ZSEgt7QRqZT99iqzTxlxQvyuCjQYqEAWqrCNtA
         OtxJwgtYDXSeJ9RXv2rQBRaEdBaNGr1JCfdE0KgRlZRhkOfILn6E2uthPFeTB9URlMAT
         dyFpL05Wfqyqn9mYkIFwupEC6bUd+JtwZO5xCPm7gfcUiQFpP+JahsiIRt7s7HPIJ2SR
         q1yrrKwXGnBmAARkD458C/fWUSP+7+bdddzagECa8OFbZXXudqk06rc004kMCSPGWU/6
         de9s+x5JwQZ8JACqj8vND3NWaqnS2cHN7jkht8+xqxvcz4SR6UXtEwb/a3tOdFj4ZQAm
         KLOw==
X-Gm-Message-State: AOAM531mcy/fSgz2TfwIh6rtef+A/kx6XQuUjQQcMinfDx6LVQ/llNv1
        0IrvNSxHtEUEMCrPTAf8HGOzymazJ9ORCAUnEVY=
X-Google-Smtp-Source: ABdhPJxRrDnsyXfBCbIopMe49y/55+/91kNnjIJF/raODSrHZaDjB3utSk3RL9J128t/aHvwHyXxNafx7GlVEVJFLEc=
X-Received: by 2002:a9d:5f19:: with SMTP id f25mr15787861oti.206.1625830141429;
 Fri, 09 Jul 2021 04:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210709064341.6206-1-adrian.hunter@intel.com> <20210709064341.6206-2-adrian.hunter@intel.com>
In-Reply-To: <20210709064341.6206-2-adrian.hunter@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 9 Jul 2021 13:28:49 +0200
Message-ID: <CAJZ5v0hZCUruTc9U64Kx0EO8iky34AR+=QeNcSafQEvcGWapLw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] driver core: Add ability to delete device links of
 unregistered devices
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "open list:TARGET SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 9, 2021 at 8:43 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Managed device links are deleted by device_del(). However it is possible to
> add a device link to a consumer before device_add(), and then discover an
> error prevents the device from being used. In that case normally references
> to the device would be dropped and the device would be deleted. However the
> device link holds a reference to the device, so the device link and device
> remain indefinitely.
>
> Amend device link removal to accept removal of a link with an
> unregistered consumer device.
>
> To make that work nicely, the devlink_remove_symlinks() function must be
> amended to cope with the absence of the consumer's sysfs presence,
> otherwise sysfs_remove_link() will generate a warning.
>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Fixes: b294ff3e34490 ("scsi: ufs: core: Enable power management for wlun")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/base/core.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index ea5b85354526..24bacdb315c6 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -562,7 +562,8 @@ static void devlink_remove_symlinks(struct device *dev,
>         struct device *con = link->consumer;
>         char *buf;
>
> -       sysfs_remove_link(&link->link_dev.kobj, "consumer");
> +       if (device_is_registered(con))
> +               sysfs_remove_link(&link->link_dev.kobj, "consumer");

I think that this is needed regardless of the changes in
device_link_put_kref(), because if somebody decides to delete a
stateless device link before registering the consumer device,
sysfs_remove_link() will still complain, won't it?

>         sysfs_remove_link(&link->link_dev.kobj, "supplier");
>
>         len = max(strlen(dev_bus_name(sup)) + strlen(dev_name(sup)),
> @@ -575,8 +576,10 @@ static void devlink_remove_symlinks(struct device *dev,
>                 return;
>         }
>
> -       snprintf(buf, len, "supplier:%s:%s", dev_bus_name(sup), dev_name(sup));
> -       sysfs_remove_link(&con->kobj, buf);
> +       if (device_is_registered(con)) {
> +               snprintf(buf, len, "supplier:%s:%s", dev_bus_name(sup), dev_name(sup));
> +               sysfs_remove_link(&con->kobj, buf);
> +       }

And here too, if I'm not mistaken.

So in that case it would be better to put the above changes into a
separate patch and add a Fixes tag to it.

>         snprintf(buf, len, "consumer:%s:%s", dev_bus_name(con), dev_name(con));
>         sysfs_remove_link(&sup->kobj, buf);
>         kfree(buf);
> @@ -885,6 +888,8 @@ static void device_link_put_kref(struct device_link *link)
>  {
>         if (link->flags & DL_FLAG_STATELESS)
>                 kref_put(&link->kref, __device_link_del);
> +       else if (!device_is_registered(link->consumer))
> +               __device_link_del(&link->kref);
>         else
>                 WARN(1, "Unable to drop a managed device link reference\n");
>  }
> --
> 2.17.1
>
