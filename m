Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC8B3BFA40
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 14:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhGHMeI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 08:34:08 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:43968 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhGHMeH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jul 2021 08:34:07 -0400
Received: by mail-ot1-f44.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso5632589otu.10;
        Thu, 08 Jul 2021 05:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NbbxqFq1+bnPl6bXmT9IRtDnEnfSxRPSocv3xOtk8g=;
        b=imrznStF9Q20u6HrXZal+4a1Do0dxHQOFgZW8qcnz0PvkyPWAXUcWoIZzqpQUiyA5b
         jDt1qC/BLGd/tA8+e8zf+2oCx1q5wuLvxDwqTHYZsRzUFgCXlnywlumTHsGf/rhfNtYa
         lnyo/ShEmU+VSOE/TDRP5MxgsWmXDOlbiCDBQsIZJ5qQfNC109IY6T0eJuf6LvViH/N/
         2jugfgUW0rIFYy8kqigrEDqt++3c19yJbbH3S+RR/UemJJb+P2x/UKn/i7MIwtoRrGj2
         0dQx6ZVm1CgG/LAUu7QyHSq63zO3JxwvfCWUhVYihQExI2R87bAeetcUSZwStKt64o+V
         vmiw==
X-Gm-Message-State: AOAM531FUyX1k2tkNjkYyoSrHdlmxrgxJiPScYoxRDE7Pr3uAS3ZmUbk
        AR69W67JriTo1JRmz19SbVsF75okzs/mdq44qA8=
X-Google-Smtp-Source: ABdhPJyj3pCWjeWLPgnpvDjaFKZ/Rjv0erHMWtpAneJA8jAWQrRGqbYu0Sk/GL8IqTWy0lp3Mu/oOKuo5z6v7jI/WxU=
X-Received: by 2002:a9d:604e:: with SMTP id v14mr23489241otj.260.1625747484877;
 Thu, 08 Jul 2021 05:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210707172948.1025-1-adrian.hunter@intel.com>
 <20210707172948.1025-3-adrian.hunter@intel.com> <YOXm4FuL/CW4lYDZ@kroah.com> <66130101-b0c5-a9a3-318a-468c6f3b380f@intel.com>
In-Reply-To: <66130101-b0c5-a9a3-318a-468c6f3b380f@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Jul 2021 14:31:13 +0200
Message-ID: <CAJZ5v0hfEE=ney1tH5MtQm0KWs4U2yzy_DqAAW7hTyxxx2-cNg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] scsi: ufshcd: Fix device links when BOOT WLUN
 fails to probe
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
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

On Wed, Jul 7, 2021 at 7:49 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 7/07/21 8:39 pm, Greg Kroah-Hartman wrote:
> > On Wed, Jul 07, 2021 at 08:29:48PM +0300, Adrian Hunter wrote:
> >> If a LUN fails to probe (e.g. absent BOOT WLUN), the device will not have
> >> been registered but can still have a device link holding a reference to the
> >> device. The unwanted device link will prevent runtime suspend indefinitely,
> >> and cause some warnings if the supplier is ever deleted (e.g. by unbinding
> >> the UFS host controller). Fix by explicitly deleting the device link when
> >> SCSI destroys the SCSI device.
> >>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  drivers/scsi/ufs/ufshcd.c | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> >> index 708b3b62fc4d..483aa74fe2c8 100644
> >> --- a/drivers/scsi/ufs/ufshcd.c
> >> +++ b/drivers/scsi/ufs/ufshcd.c
> >> @@ -5029,6 +5029,13 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
> >>              spin_lock_irqsave(hba->host->host_lock, flags);
> >>              hba->sdev_ufs_device = NULL;
> >>              spin_unlock_irqrestore(hba->host->host_lock, flags);
> >> +    } else {
> >> +            /*
> >> +             * If a LUN fails to probe (e.g. absent BOOT WLUN), the device
> >> +             * will not have been registered but can still have a device
> >> +             * link holding a reference to the device.
> >> +             */
> >> +            device_links_scrap(&sdev->sdev_gendev);
> >
> > What created that link?  And why did it do that before probe happened
> > successfully?
>
> The same driver created the link.
>
> The documentation seems to say it is allowed to, if it is the consumer.
> From Documentation/driver-api/device_link.rst
>
>   Usage
>   =====
>
>   The earliest point in time when device links can be added is after
>   :c:func:`device_add()` has been called for the supplier and
>   :c:func:`device_initialize()` has been called for the consumer.

Yes, this is allowed, but if you've added device links to a device
object that is not going to be registered after all, you are
responsible for doing the cleanup.

Why can't you call device_link_del() directly on those links?

Or device_link_remove() if you don't want to deal with link pointers?
