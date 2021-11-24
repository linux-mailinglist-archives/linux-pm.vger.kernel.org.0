Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D173845CABA
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 18:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbhKXRSZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 12:18:25 -0500
Received: from vie01a-dmta-pe02-3.mx.upcmail.net ([62.179.121.159]:42883 "EHLO
        vie01a-dmta-pe02-3.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236112AbhKXRSV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 12:18:21 -0500
Received: from [172.31.216.234] (helo=vie01a-pemc-psmtp-pe11.mail.upcmail.net)
        by vie01a-dmta-pe02.mx.upcmail.net with esmtp (Exim 4.92)
        (envelope-from <thomas.zeitlhofer+lkml@ze-it.at>)
        id 1mpvrR-005iZV-KW
        for linux-pm@vger.kernel.org; Wed, 24 Nov 2021 18:15:09 +0100
Received: from mr2 ([80.108.17.71])
        by vie01a-pemc-psmtp-pe11.mail.upcmail.net with ESMTP
        id pvrQmBDCy2A4vpvrRmAeQ3; Wed, 24 Nov 2021 18:15:09 +0100
X-Env-Mailfrom: thomas.zeitlhofer+lkml@ze-it.at
X-Env-Rcptto: linux-pm@vger.kernel.org
X-SourceIP: 80.108.17.71
X-CNFS-Analysis: v=2.3 cv=bNRo382Z c=1 sm=1 tr=0
 a=dwg5kdmUixIXdJRX1f/MsQ==:117 a=dwg5kdmUixIXdJRX1f/MsQ==:17
 a=kj9zAlcOel0A:10 a=2PhUSsPvBtUAQ8QcbhUA:9 a=CjuIK1q_8ugA:10
Date:   Wed, 24 Nov 2021 18:15:05 +0100
From:   Thomas Zeitlhofer <thomas.zeitlhofer+lkml@ze-it.at>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] PM: hibernate: use correct mode for swsusp_close()
Message-ID: <YZ5zGXJbSsmV3xHJ@x1.ze-it.at>
References: <YZ0+k4Vy7SJ1D8kH@x1.ze-it.at>
 <CAJZ5v0i9RR2wEx2ktKLzt2ZaAWTVqWJwf+tO0c99CzcLD9Th0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i9RR2wEx2ktKLzt2ZaAWTVqWJwf+tO0c99CzcLD9Th0g@mail.gmail.com>
X-CMAE-Envelope: MS4wfD6cXk6+l71k+UqT1HXsfBwLkvL4a8SMxkGpUMm3AHZaAFFcTHIrEsCP0yA3/R4i+Wte9cQANS6bzxBZn3IXwgY2ZJtyw6E3XGLGsHVrKVD3vAFDi3qx
 8fAx9ALtQX9SWsEKaTZk9KE8kcg3LBsw1VYo5CkUIVUXRz2ZtrTO2Gb6tm/e2GsDhHQ1qoqFkaK5xBYIw/Q7iOt4vPczukpfwulkl5rZCvAK1exGYJpJms28
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Rafael,

On Wed, Nov 24, 2021 at 01:46:42PM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 23, 2021 at 8:18 PM Thomas Zeitlhofer
> <thomas.zeitlhofer+lkml@ze-it.at> wrote:
> >
> > Commit 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in
> > swsusp_check()") changed the opening mode of the block device to
> > (FMODE_READ | FMODE_EXCL).
> >
> > In the corresponding calls to swsusp_close(), the mode is still just
> > FMODE_READ which triggers the warning in blkdev_flush_mapping() on resume
> > from hibernate.
> >
> > So, use the mode (FMODE_READ | FMODE_EXCL) also when closing the device.
> >
> > Fixes: 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> > Signed-off-by: Thomas Zeitlhofer <thomas.zeitlhofer+lkml@ze-it.at>
> >
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index 559acef3fddb..b0888e9224da 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -691,7 +691,7 @@ static int load_image_and_restore(void)
> >                 goto Unlock;
> >
> >         error = swsusp_read(&flags);
> > -       swsusp_close(FMODE_READ);
> > +       swsusp_close(FMODE_READ | FMODE_EXCL);
> >         if (!error)
> >                 error = hibernation_restore(flags & SF_PLATFORM_MODE);
> >
> > @@ -981,7 +981,7 @@ static int software_resume(void)
> >         /* The snapshot device should not be opened while we're running */
> >         if (!hibernate_acquire()) {
> >                 error = -EBUSY;
> > -               swsusp_close(FMODE_READ);
> > +               swsusp_close(FMODE_READ | FMODE_EXCL);
> >                 goto Unlock;
> >         }
> >
> > @@ -1016,7 +1016,7 @@ static int software_resume(void)
> >         pm_pr_dbg("Hibernation image not present or could not be loaded.\n");
> >         return error;
> >   Close_Finish:
> > -       swsusp_close(FMODE_READ);
> > +       swsusp_close(FMODE_READ | FMODE_EXCL);
> >         goto Finish;
> >  }
> 
> Applied as 5.16-rc material, thanks!

it might also be useful for v5-stable kernels, as the mentioned commit
also entered e.g. v5.15.3, which is where I noticed the warning.

Thanks,

Thomas
