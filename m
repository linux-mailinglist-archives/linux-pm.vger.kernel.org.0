Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4263C1886
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 19:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhGHRmk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 13:42:40 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:34530 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhGHRmk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jul 2021 13:42:40 -0400
Received: by mail-ot1-f50.google.com with SMTP id w8-20020a0568304108b02904b3da3d49e5so2618152ott.1;
        Thu, 08 Jul 2021 10:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWxAkUDPROT9OQdmZgcR2azQpGWf/ojz84EqfWmUJ+s=;
        b=eVHHUh4s3RPlk52oudODzeCE5kNPTRj8sCa+B2P0NivMIVszI66AeiywPNI1qrRHJf
         M2+6eyQfNIMYe5P2H0zwfa3DOGTrebUos0RS2EDipVzhbdOt8UqkcKtNAFusI6T520SM
         Y31t5Yt//li+VJLUAor3zweeVFG8/CBnc8PpsQ1epITOQclo3bJyPzeOc8JeXPm31gKY
         IJRM7NliN6+hHm3KTSKSLEt8yCUsWnAi7yb7J9GcaeOZ/Ddv50QW+9wGHUILvtWizyRZ
         pOODgCtTLg62sjJVCWVqs2o3S6CY4yBOQDX1WRW29fNvodwheLGsqQ9xuLrkNhTdurL1
         Du+A==
X-Gm-Message-State: AOAM532zkDTSV8HEo5c2Z+P52rwjlm0ycde7Oha3dv/G+KMpdfnurvQg
        Q9Oa5rVkty+xj9u/HQf07zXoYkDDWuyiHw/pgnk=
X-Google-Smtp-Source: ABdhPJw7nO6n5J5JgUGjAeA/V6Pjv2e64JRPVijORIUp2w/oc4dE8/NlBs17yulf3H4tG9/0t2A9gyjNX1h5VOxkgQE=
X-Received: by 2002:a9d:5f19:: with SMTP id f25mr12190282oti.206.1625765997136;
 Thu, 08 Jul 2021 10:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210707172948.1025-1-adrian.hunter@intel.com>
 <20210707172948.1025-3-adrian.hunter@intel.com> <YOXm4FuL/CW4lYDZ@kroah.com>
 <66130101-b0c5-a9a3-318a-468c6f3b380f@intel.com> <CAJZ5v0hfEE=ney1tH5MtQm0KWs4U2yzy_DqAAW7hTyxxx2-cNg@mail.gmail.com>
 <c3ec3ca2-220f-9e5a-e2ce-b1c2be86c97c@intel.com> <CAGETcx_D9KvxEK689ggF6xViiC_yXaCWdL0KoW8uJwiNPhxy8w@mail.gmail.com>
 <CAJZ5v0jnWWLyCFub=-ETr7d_ck=roVexTj8M0NRLi-svfjJy3Q@mail.gmail.com> <CAGETcx9hYu-n+tGOnEspWOckvgVQG+QcZPoR-DwesPh1qfrnXA@mail.gmail.com>
In-Reply-To: <CAGETcx9hYu-n+tGOnEspWOckvgVQG+QcZPoR-DwesPh1qfrnXA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Jul 2021 19:39:46 +0200
Message-ID: <CAJZ5v0inT1BWYrfQEMufgmCATXFE5XqMyjKoardtPpkowKm-nA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] scsi: ufshcd: Fix device links when BOOT WLUN
 fails to probe
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
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

On Thu, Jul 8, 2021 at 6:57 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Jul 8, 2021 at 9:49 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Jul 8, 2021 at 6:46 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > On Thu, Jul 8, 2021 at 7:17 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > > >
> > > > On 8/07/21 3:31 pm, Rafael J. Wysocki wrote:
> > > > > On Wed, Jul 7, 2021 at 7:49 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > > > >>
> > > > >> On 7/07/21 8:39 pm, Greg Kroah-Hartman wrote:
> > > > >>> On Wed, Jul 07, 2021 at 08:29:48PM +0300, Adrian Hunter wrote:
> > > > >>>> If a LUN fails to probe (e.g. absent BOOT WLUN), the device will not have
> > > > >>>> been registered but can still have a device link holding a reference to the
> > > > >>>> device. The unwanted device link will prevent runtime suspend indefinitely,
> > > > >>>> and cause some warnings if the supplier is ever deleted (e.g. by unbinding
> > > > >>>> the UFS host controller). Fix by explicitly deleting the device link when
> > > > >>>> SCSI destroys the SCSI device.
> > > > >>>>
> > > > >>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > > > >>>> ---
> > > > >>>>  drivers/scsi/ufs/ufshcd.c | 7 +++++++
> > > > >>>>  1 file changed, 7 insertions(+)
> > > > >>>>
> > > > >>>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> > > > >>>> index 708b3b62fc4d..483aa74fe2c8 100644
> > > > >>>> --- a/drivers/scsi/ufs/ufshcd.c
> > > > >>>> +++ b/drivers/scsi/ufs/ufshcd.c
> > > > >>>> @@ -5029,6 +5029,13 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
> > > > >>>>              spin_lock_irqsave(hba->host->host_lock, flags);
> > > > >>>>              hba->sdev_ufs_device = NULL;
> > > > >>>>              spin_unlock_irqrestore(hba->host->host_lock, flags);
> > > > >>>> +    } else {
> > > > >>>> +            /*
> > > > >>>> +             * If a LUN fails to probe (e.g. absent BOOT WLUN), the device
> > > > >>>> +             * will not have been registered but can still have a device
> > > > >>>> +             * link holding a reference to the device.
> > > > >>>> +             */
> > > > >>>> +            device_links_scrap(&sdev->sdev_gendev);
> > > > >>>
> > > > >>> What created that link?  And why did it do that before probe happened
> > > > >>> successfully?
> > > > >>
> > > > >> The same driver created the link.
> > > > >>
> > > > >> The documentation seems to say it is allowed to, if it is the consumer.
> > > > >> From Documentation/driver-api/device_link.rst
> > > > >>
> > > > >>   Usage
> > > > >>   =====
> > > > >>
> > > > >>   The earliest point in time when device links can be added is after
> > > > >>   :c:func:`device_add()` has been called for the supplier and
> > > > >>   :c:func:`device_initialize()` has been called for the consumer.
> > > > >
> > > > > Yes, this is allowed, but if you've added device links to a device
> > > > > object that is not going to be registered after all, you are
> > > > > responsible for doing the cleanup.
> > > > >
> > > > > Why can't you call device_link_del() directly on those links?
> > > > >
> > > > > Or device_link_remove() if you don't want to deal with link pointers?
> > > > >
> > > >
> > > > Those only work for DL_FLAG_STATELESS device links, but we use only
> > > > DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE flags.
> > >
> > > Is there a reason you can't use DL_FLAG_STATELESS? It doesn't preclude
> > > you from using RPM_ACTIVE as far as I can tell.
> >
> > Perhaps he wants the links to be managed if they are used after all.
> >
> > Anyway, this is a valid use case that is not covered right now.
>
> Maybe. But the suggested patch is certainly risky.
>
> There is no requirement the consumer is registered before the links
> are added though. So, randomly deleting a managed link when
> device_link_put_kref() is called on a stateless refcount (they are
> still the same link still) isn't right.

Device pointers are needed in order to create a device link and it is
quite unlikely that a pointer to an unregistered device will be shared
between two different pieces of code.

> The entity that created the
> managed device link might still want it there.

So the stateless kref is going to be put first.

> Also, if two entities
> create a managed link and one of them calls device_link_put_kref()
> before the device is registered, we have a UAF problem because managed
> links aren't refcounted (more than once).

IMO until a device object is registered, its creator should be allowed
to do the cleanup in the case when it gets released without
registration, including the removal of any device links to it that
have been added so far.

Messing up with a device object created by someone else that may still
go away without registration is a risky business regardless.
