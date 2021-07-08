Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650AD3C15B8
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 17:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhGHPPN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 11:15:13 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:34717 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhGHPPN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jul 2021 11:15:13 -0400
Received: by mail-ot1-f45.google.com with SMTP id w8-20020a0568304108b02904b3da3d49e5so2132025ott.1;
        Thu, 08 Jul 2021 08:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHkFWAI46E+RSb2XZ10M/xDZvWjRWEurjhsODZuJHjc=;
        b=U1VHhIvISmOuh5EEB0gIXeSpSvYR6qzVCJv02hWVpQyzu+81QC4zebDOhqjHzLXd+d
         nn/4WJSNCtX7i8mGXzFOu86lSi3gQmrJ8CNObSDbdUd/54UpnWgpkeGmVHng0L6BS+W6
         JHy2M0ChATV3gFsMzSmZ8i56TXttOE8NPvmVAY/F0mq5+pi25Eivrq3WXy7YvE3I9NkE
         BRsJGbs5hGPUu6X98NL3HyUNKdOn3XekGVQzJ0dz70w0qE4dkdkio4Sdg60ImHzhkqXk
         zC0RbIGMrbcTVZ12uyZkC0Mg9RgVqunKoU6Y29J5LKzKTBvuC9RxoSaJJpSJKx/kLkFF
         nGlw==
X-Gm-Message-State: AOAM5307XKKRmnuVJP1d7MDCS2QREyPvquN3zi192E2HtgGXUGSUbhcX
        VwhNizFpv7KigI/geybtKzwKs43xJT1VHobP9dk=
X-Google-Smtp-Source: ABdhPJwWtvD1dy8XmFCerRnLCI+5IhOQi32NO6ZlcK5C3WdV7WQt22Qnox4uBIYWWPdHccyyCbJOQlUIxRgHttRoUuo=
X-Received: by 2002:a9d:604e:: with SMTP id v14mr24087786otj.260.1625757151210;
 Thu, 08 Jul 2021 08:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210707172948.1025-1-adrian.hunter@intel.com>
 <20210707172948.1025-3-adrian.hunter@intel.com> <YOXm4FuL/CW4lYDZ@kroah.com>
 <66130101-b0c5-a9a3-318a-468c6f3b380f@intel.com> <CAJZ5v0hfEE=ney1tH5MtQm0KWs4U2yzy_DqAAW7hTyxxx2-cNg@mail.gmail.com>
 <c3ec3ca2-220f-9e5a-e2ce-b1c2be86c97c@intel.com> <CAJZ5v0hXR+ZsjKP1BUrOEXDFfD3ha=w90bExrx5qhTrOG16Ksw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hXR+ZsjKP1BUrOEXDFfD3ha=w90bExrx5qhTrOG16Ksw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Jul 2021 17:12:20 +0200
Message-ID: <CAJZ5v0igHZ+cj7F-pMZEtNjG+UkRE-jUNC7m7e2vsZfasZLY5A@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] scsi: ufshcd: Fix device links when BOOT WLUN
 fails to probe
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Thu, Jul 8, 2021 at 5:03 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jul 8, 2021 at 4:17 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > On 8/07/21 3:31 pm, Rafael J. Wysocki wrote:
> > > On Wed, Jul 7, 2021 at 7:49 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > >>
> > >> On 7/07/21 8:39 pm, Greg Kroah-Hartman wrote:
> > >>> On Wed, Jul 07, 2021 at 08:29:48PM +0300, Adrian Hunter wrote:
> > >>>> If a LUN fails to probe (e.g. absent BOOT WLUN), the device will not have
> > >>>> been registered but can still have a device link holding a reference to the
> > >>>> device. The unwanted device link will prevent runtime suspend indefinitely,
> > >>>> and cause some warnings if the supplier is ever deleted (e.g. by unbinding
> > >>>> the UFS host controller). Fix by explicitly deleting the device link when
> > >>>> SCSI destroys the SCSI device.
> > >>>>
> > >>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > >>>> ---
> > >>>>  drivers/scsi/ufs/ufshcd.c | 7 +++++++
> > >>>>  1 file changed, 7 insertions(+)
> > >>>>
> > >>>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> > >>>> index 708b3b62fc4d..483aa74fe2c8 100644
> > >>>> --- a/drivers/scsi/ufs/ufshcd.c
> > >>>> +++ b/drivers/scsi/ufs/ufshcd.c
> > >>>> @@ -5029,6 +5029,13 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
> > >>>>              spin_lock_irqsave(hba->host->host_lock, flags);
> > >>>>              hba->sdev_ufs_device = NULL;
> > >>>>              spin_unlock_irqrestore(hba->host->host_lock, flags);
> > >>>> +    } else {
> > >>>> +            /*
> > >>>> +             * If a LUN fails to probe (e.g. absent BOOT WLUN), the device
> > >>>> +             * will not have been registered but can still have a device
> > >>>> +             * link holding a reference to the device.
> > >>>> +             */
> > >>>> +            device_links_scrap(&sdev->sdev_gendev);
> > >>>
> > >>> What created that link?  And why did it do that before probe happened
> > >>> successfully?
> > >>
> > >> The same driver created the link.
> > >>
> > >> The documentation seems to say it is allowed to, if it is the consumer.
> > >> From Documentation/driver-api/device_link.rst
> > >>
> > >>   Usage
> > >>   =====
> > >>
> > >>   The earliest point in time when device links can be added is after
> > >>   :c:func:`device_add()` has been called for the supplier and
> > >>   :c:func:`device_initialize()` has been called for the consumer.
> > >
> > > Yes, this is allowed, but if you've added device links to a device
> > > object that is not going to be registered after all, you are
> > > responsible for doing the cleanup.
> > >
> > > Why can't you call device_link_del() directly on those links?
> > >
> > > Or device_link_remove() if you don't want to deal with link pointers?
> > >
> >
> > Those only work for DL_FLAG_STATELESS device links, but we use only
> > DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE flags.
>
> So I'd probably modify device_link_remove() to check if the consumer
> device has been registered and run __device_link_del() directly
> instead of device_link_put_kref() if it hasn't.
>
> Or add an argument to it to force the removal.

Or even modify device_link_put_kref() like this:

 static void device_link_put_kref(struct device_link *link)
 {
          if (link->flags & DL_FLAG_STATELESS)
                  kref_put(&link->kref, __device_link_del);
+        else if (!device_is_registered(link->consumer))
+                __device_link_del(link);
          else
                 WARN(1, "Unable to drop a managed device link reference\n");
 }
