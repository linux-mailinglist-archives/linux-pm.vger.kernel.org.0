Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA933C175F
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 18:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhGHQvm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 12:51:42 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:39704 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhGHQvm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jul 2021 12:51:42 -0400
Received: by mail-ot1-f45.google.com with SMTP id w15-20020a056830144fb02904af2a0d96f3so6477428otp.6;
        Thu, 08 Jul 2021 09:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQK96t76fu/viRfS7rLob+VMQvsI00nK8s2Auj7HOsQ=;
        b=SGaL5D8KDYE3S3BRd3+WX/pjWCjI8IyQ6lNHMdXt4nkSAKfloueEoYA7hjGomUJbg0
         LAjN6tpQkgG45xxlZuIe5yhUgNrb8D7BiMUiYWwlLuhE+cqb4lBFN4wjxsVQ9cSq1Cj0
         dhul73F5Wciqqq4BByxWT7MizswKECQ8xHvq12ADfHopftZBnM3H3mBLx2qvOaWHhiwU
         cKoBMm/yXwu74P13qk9klOGX7BjtTB+iNhyc/uzDZqgYFeXoA+kre4sO3EepyUVdoC6P
         nCoOkqe3QQKiA3GV3RWyHHmQF2S+ULmlJgZk67lMnZ3H3ceDCnL1iuBuzksJi2tK2k3w
         +edA==
X-Gm-Message-State: AOAM533vS/42WKQU5rl6EZNEcvaj8uvGK99GJ2PdwmeYgrxFBbILtpJH
        nyWKQVoXK7IKRcvo/Bo1VU0NYdrRLowufN0XdVs=
X-Google-Smtp-Source: ABdhPJyIlh9xB+6VLvmszP6WGsbjnMfmlePYhY/UBVQ8Y263rHJ+3utwsYldHN/2ciIg8RVEndHMJg+6Qb5tlA2JvOo=
X-Received: by 2002:a9d:22a5:: with SMTP id y34mr13919681ota.321.1625762939894;
 Thu, 08 Jul 2021 09:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210707172948.1025-1-adrian.hunter@intel.com>
 <20210707172948.1025-3-adrian.hunter@intel.com> <YOXm4FuL/CW4lYDZ@kroah.com>
 <66130101-b0c5-a9a3-318a-468c6f3b380f@intel.com> <CAJZ5v0hfEE=ney1tH5MtQm0KWs4U2yzy_DqAAW7hTyxxx2-cNg@mail.gmail.com>
 <c3ec3ca2-220f-9e5a-e2ce-b1c2be86c97c@intel.com> <CAGETcx_D9KvxEK689ggF6xViiC_yXaCWdL0KoW8uJwiNPhxy8w@mail.gmail.com>
In-Reply-To: <CAGETcx_D9KvxEK689ggF6xViiC_yXaCWdL0KoW8uJwiNPhxy8w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Jul 2021 18:48:48 +0200
Message-ID: <CAJZ5v0jnWWLyCFub=-ETr7d_ck=roVexTj8M0NRLi-svfjJy3Q@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] scsi: ufshcd: Fix device links when BOOT WLUN
 fails to probe
To:     Saravana Kannan <saravanak@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Thu, Jul 8, 2021 at 6:46 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Jul 8, 2021 at 7:17 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
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
> Is there a reason you can't use DL_FLAG_STATELESS? It doesn't preclude
> you from using RPM_ACTIVE as far as I can tell.

Perhaps he wants the links to be managed if they are used after all.

Anyway, this is a valid use case that is not covered right now.
