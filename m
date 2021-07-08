Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C175B3C1789
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 18:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhGHRAV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 13:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhGHRAT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jul 2021 13:00:19 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D66C061574
        for <linux-pm@vger.kernel.org>; Thu,  8 Jul 2021 09:57:37 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id r135so10109648ybc.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jul 2021 09:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2CS38GY8uch1zA08SQ4xz6CBM44J4uI/8FoF/YQIRvg=;
        b=m8XywZ2+S9UOWKZmzx/D8unKfUc0zQgMFZMupUXrfvQ1W7WhFP6Q2bXBW2DvqTJNDF
         sWvhuUlLRlanBWYnkusi47QZxNLB3oHqqzFG2OEBkbSj74/lknP4zAdzSwClyWiTuvZ4
         PWDnFFv8AsiqZbSJkpEH+H07F66xB2yqu8T1GwqJhxTItaJCauQXY1Y+nIxioLFmQQL1
         OYvrW1QQxi9VBCf8ocG+lkouQDEPYkKtrxZcQ+OA/S6reyIV8LY9sGNH7zo1uNl3usMB
         UI9k1YuR8ov+3FJdH5uJyLdVL5mLZ2WX3+Cb4NqXQBZlnxQmds5KMR8avZBsK4FwUUVC
         NpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2CS38GY8uch1zA08SQ4xz6CBM44J4uI/8FoF/YQIRvg=;
        b=WZuZ8U3LBFkAtHb5/s9EUB2vUSaZPajXeO2neOt/qc4LwUEV97Qj0wTQA/E96psKfq
         SrTiJr2auHw9eBqBdKOKtdn/YtJdPc5kD5BW55q1MN+z+z8V+XRf9Rx+lAe5p0oa9vWr
         Cmr9XBkYLf/TkebQzmwjYOgrgol1o/MK3JLRBD2xjANUCARE+Gm6CZp8I9OEKozYsSz0
         5bID5wOsvtM/DGObMBME16iiqlYD6Nz67fwIF/0u3qapdGMrI3p7gHonxIn0OLAdPJVW
         QRY5RjnMR6QkHJC4ceOIAgQ81hQW9t1z87e3uDi2OUndaQZdWzAdVR5tPBmZ2NlH9CtX
         LhCA==
X-Gm-Message-State: AOAM533Y6Z78y6aIYu4yUezHBvAPHW94kZkGO9XOBJe1wdp/bx47iE+W
        6cTWJ3MkS+8KZ8w34o7CVy+sZPDrUERYxPVGyPDNGg==
X-Google-Smtp-Source: ABdhPJw6/bLzCbNz7a/bzlL5qOwxd5fOQUAlJIesmKG3Pe/ypoTsBSGwviPm8Ci/f6WK9I/+/2J5+2ES3XYM4LJuryk=
X-Received: by 2002:a25:8b91:: with SMTP id j17mr38884530ybl.228.1625763456939;
 Thu, 08 Jul 2021 09:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210707172948.1025-1-adrian.hunter@intel.com>
 <20210707172948.1025-3-adrian.hunter@intel.com> <YOXm4FuL/CW4lYDZ@kroah.com>
 <66130101-b0c5-a9a3-318a-468c6f3b380f@intel.com> <CAJZ5v0hfEE=ney1tH5MtQm0KWs4U2yzy_DqAAW7hTyxxx2-cNg@mail.gmail.com>
 <c3ec3ca2-220f-9e5a-e2ce-b1c2be86c97c@intel.com> <CAGETcx_D9KvxEK689ggF6xViiC_yXaCWdL0KoW8uJwiNPhxy8w@mail.gmail.com>
 <CAJZ5v0jnWWLyCFub=-ETr7d_ck=roVexTj8M0NRLi-svfjJy3Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0jnWWLyCFub=-ETr7d_ck=roVexTj8M0NRLi-svfjJy3Q@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 8 Jul 2021 09:57:01 -0700
Message-ID: <CAGETcx9hYu-n+tGOnEspWOckvgVQG+QcZPoR-DwesPh1qfrnXA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] scsi: ufshcd: Fix device links when BOOT WLUN
 fails to probe
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Thu, Jul 8, 2021 at 9:49 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jul 8, 2021 at 6:46 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Thu, Jul 8, 2021 at 7:17 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > >
> > > On 8/07/21 3:31 pm, Rafael J. Wysocki wrote:
> > > > On Wed, Jul 7, 2021 at 7:49 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > > >>
> > > >> On 7/07/21 8:39 pm, Greg Kroah-Hartman wrote:
> > > >>> On Wed, Jul 07, 2021 at 08:29:48PM +0300, Adrian Hunter wrote:
> > > >>>> If a LUN fails to probe (e.g. absent BOOT WLUN), the device will not have
> > > >>>> been registered but can still have a device link holding a reference to the
> > > >>>> device. The unwanted device link will prevent runtime suspend indefinitely,
> > > >>>> and cause some warnings if the supplier is ever deleted (e.g. by unbinding
> > > >>>> the UFS host controller). Fix by explicitly deleting the device link when
> > > >>>> SCSI destroys the SCSI device.
> > > >>>>
> > > >>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > > >>>> ---
> > > >>>>  drivers/scsi/ufs/ufshcd.c | 7 +++++++
> > > >>>>  1 file changed, 7 insertions(+)
> > > >>>>
> > > >>>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> > > >>>> index 708b3b62fc4d..483aa74fe2c8 100644
> > > >>>> --- a/drivers/scsi/ufs/ufshcd.c
> > > >>>> +++ b/drivers/scsi/ufs/ufshcd.c
> > > >>>> @@ -5029,6 +5029,13 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
> > > >>>>              spin_lock_irqsave(hba->host->host_lock, flags);
> > > >>>>              hba->sdev_ufs_device = NULL;
> > > >>>>              spin_unlock_irqrestore(hba->host->host_lock, flags);
> > > >>>> +    } else {
> > > >>>> +            /*
> > > >>>> +             * If a LUN fails to probe (e.g. absent BOOT WLUN), the device
> > > >>>> +             * will not have been registered but can still have a device
> > > >>>> +             * link holding a reference to the device.
> > > >>>> +             */
> > > >>>> +            device_links_scrap(&sdev->sdev_gendev);
> > > >>>
> > > >>> What created that link?  And why did it do that before probe happened
> > > >>> successfully?
> > > >>
> > > >> The same driver created the link.
> > > >>
> > > >> The documentation seems to say it is allowed to, if it is the consumer.
> > > >> From Documentation/driver-api/device_link.rst
> > > >>
> > > >>   Usage
> > > >>   =====
> > > >>
> > > >>   The earliest point in time when device links can be added is after
> > > >>   :c:func:`device_add()` has been called for the supplier and
> > > >>   :c:func:`device_initialize()` has been called for the consumer.
> > > >
> > > > Yes, this is allowed, but if you've added device links to a device
> > > > object that is not going to be registered after all, you are
> > > > responsible for doing the cleanup.
> > > >
> > > > Why can't you call device_link_del() directly on those links?
> > > >
> > > > Or device_link_remove() if you don't want to deal with link pointers?
> > > >
> > >
> > > Those only work for DL_FLAG_STATELESS device links, but we use only
> > > DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE flags.
> >
> > Is there a reason you can't use DL_FLAG_STATELESS? It doesn't preclude
> > you from using RPM_ACTIVE as far as I can tell.
>
> Perhaps he wants the links to be managed if they are used after all.
>
> Anyway, this is a valid use case that is not covered right now.

Maybe. But the suggested patch is certainly risky.

There is no requirement the consumer is registered before the links
are added though. So, randomly deleting a managed link when
device_link_put_kref() is called on a stateless refcount (they are
still the same link still) isn't right. The entity that created the
managed device link might still want it there. Also, if two entities
create a managed link and one of them calls device_link_put_kref()
before the device is registered, we have a UAF problem because managed
links aren't refcounted (more than once).

-Saravana
