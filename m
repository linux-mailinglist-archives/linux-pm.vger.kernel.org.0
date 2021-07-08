Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791853C15A4
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 17:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhGHPGB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 11:06:01 -0400
Received: from mail-oo1-f48.google.com ([209.85.161.48]:40878 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhGHPGA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jul 2021 11:06:00 -0400
Received: by mail-oo1-f48.google.com with SMTP id j4-20020a4ac5440000b029025992521cf0so1439097ooq.7;
        Thu, 08 Jul 2021 08:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fRsjb6ixRhrvN3TM5YwQx/rG19O2SMWtEg9Q+v6fqM=;
        b=RZcVw6UVkCfkoNzRdLXsQ/xzOsilWpKp2jKa90VknW060g9lqzmf8yO2BfQs3q0e3W
         HwYXdqWs3B8hIMzXraZO8KF3i4gwCw4km6+gHcd64+2+GOGzpK5HD+Ybcp29EjziZUqB
         uAEGsVGwcD5Z8rxnXq9u2KJ+QuEetxsgOSLXkGg2k8TOULZXRNU0iCw3RabazC08T0P0
         wR5nQtodsic9DUeyN4yZtAv1sAwtLacEOA5B3357fQ0b1e4Xgg620IybKRCkE3JfFjgj
         9JHwCUmBtdGLafSFSwqEIOteIon48Ve9QEgpP9XI9NDSJi7EJBCG3yI/47qXebCa3QOi
         kvWA==
X-Gm-Message-State: AOAM532rVi4e+PharUK+s3zBulFGDdE8xMrKEo5HgP/L5FDb+0/qeBqR
        ln9Ih1y4217z+PKQvwgFvWDE8hv0isd4rztHLNM=
X-Google-Smtp-Source: ABdhPJw6rRUj1eTPCAv1/80AGJMjw6lgLatnsz92iWe8QDTP7Wr4l6gE3Ui3oQXimZNb02HlGgqmJ+koMz7JDPGIVuE=
X-Received: by 2002:a4a:5dc6:: with SMTP id w189mr22866611ooa.1.1625756598703;
 Thu, 08 Jul 2021 08:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210707172948.1025-1-adrian.hunter@intel.com>
 <20210707172948.1025-3-adrian.hunter@intel.com> <YOXm4FuL/CW4lYDZ@kroah.com>
 <66130101-b0c5-a9a3-318a-468c6f3b380f@intel.com> <CAJZ5v0hfEE=ney1tH5MtQm0KWs4U2yzy_DqAAW7hTyxxx2-cNg@mail.gmail.com>
 <c3ec3ca2-220f-9e5a-e2ce-b1c2be86c97c@intel.com>
In-Reply-To: <c3ec3ca2-220f-9e5a-e2ce-b1c2be86c97c@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Jul 2021 17:03:07 +0200
Message-ID: <CAJZ5v0hXR+ZsjKP1BUrOEXDFfD3ha=w90bExrx5qhTrOG16Ksw@mail.gmail.com>
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

On Thu, Jul 8, 2021 at 4:17 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 8/07/21 3:31 pm, Rafael J. Wysocki wrote:
> > On Wed, Jul 7, 2021 at 7:49 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 7/07/21 8:39 pm, Greg Kroah-Hartman wrote:
> >>> On Wed, Jul 07, 2021 at 08:29:48PM +0300, Adrian Hunter wrote:
> >>>> If a LUN fails to probe (e.g. absent BOOT WLUN), the device will not have
> >>>> been registered but can still have a device link holding a reference to the
> >>>> device. The unwanted device link will prevent runtime suspend indefinitely,
> >>>> and cause some warnings if the supplier is ever deleted (e.g. by unbinding
> >>>> the UFS host controller). Fix by explicitly deleting the device link when
> >>>> SCSI destroys the SCSI device.
> >>>>
> >>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >>>> ---
> >>>>  drivers/scsi/ufs/ufshcd.c | 7 +++++++
> >>>>  1 file changed, 7 insertions(+)
> >>>>
> >>>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> >>>> index 708b3b62fc4d..483aa74fe2c8 100644
> >>>> --- a/drivers/scsi/ufs/ufshcd.c
> >>>> +++ b/drivers/scsi/ufs/ufshcd.c
> >>>> @@ -5029,6 +5029,13 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
> >>>>              spin_lock_irqsave(hba->host->host_lock, flags);
> >>>>              hba->sdev_ufs_device = NULL;
> >>>>              spin_unlock_irqrestore(hba->host->host_lock, flags);
> >>>> +    } else {
> >>>> +            /*
> >>>> +             * If a LUN fails to probe (e.g. absent BOOT WLUN), the device
> >>>> +             * will not have been registered but can still have a device
> >>>> +             * link holding a reference to the device.
> >>>> +             */
> >>>> +            device_links_scrap(&sdev->sdev_gendev);
> >>>
> >>> What created that link?  And why did it do that before probe happened
> >>> successfully?
> >>
> >> The same driver created the link.
> >>
> >> The documentation seems to say it is allowed to, if it is the consumer.
> >> From Documentation/driver-api/device_link.rst
> >>
> >>   Usage
> >>   =====
> >>
> >>   The earliest point in time when device links can be added is after
> >>   :c:func:`device_add()` has been called for the supplier and
> >>   :c:func:`device_initialize()` has been called for the consumer.
> >
> > Yes, this is allowed, but if you've added device links to a device
> > object that is not going to be registered after all, you are
> > responsible for doing the cleanup.
> >
> > Why can't you call device_link_del() directly on those links?
> >
> > Or device_link_remove() if you don't want to deal with link pointers?
> >
>
> Those only work for DL_FLAG_STATELESS device links, but we use only
> DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE flags.

So I'd probably modify device_link_remove() to check if the consumer
device has been registered and run __device_link_del() directly
instead of device_link_put_kref() if it hasn't.

Or add an argument to it to force the removal.
