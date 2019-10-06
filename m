Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7ABCD264
	for <lists+linux-pm@lfdr.de>; Sun,  6 Oct 2019 17:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfJFPIt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Oct 2019 11:08:49 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39935 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJFPIt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Oct 2019 11:08:49 -0400
Received: by mail-oi1-f193.google.com with SMTP id w144so9601655oia.6;
        Sun, 06 Oct 2019 08:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nqvbMIqcq67/i2yVAL0YTUW6apJz4THEkuKthWl5fgE=;
        b=HyuJR8DjoVRp3FQ/QPDhQ8MWC1olcnGcpYbztk9CrqxZsP36w3DsfPimCpoYbhYxzw
         gEFmfDsx6EVn2Q3r6FO9wXlWi47XGbuaeKC9B1ZNLTC+4tAaRzaSxUtWAIviov9R6Zhc
         lnub7hyvPqV5LF0xZH1T5VpS77nuLRAtRVNIWvTyd/4+JndLsdceolILatucNytVd25r
         XY/FaW+Nv9117xLbyyvN78vw67Adjz+Dp91ntFwoGtAy2jpEvOqyvyA28piRnnd7slkl
         YP9fuA8H+pho/BdnjlHM5b3no2jMFCtFVdc/H54Lzv9SdA5zhkCWfIv9OvHDc1uEZACa
         ivRA==
X-Gm-Message-State: APjAAAVc5B10z/TQwCLK6B1U+/4TDn5tKhGxu1lexambBi+YRuURW1H3
        Hv0tDKOqSlE+FEPJ5ayEI452liOP72f96Neu8Mw=
X-Google-Smtp-Source: APXvYqwq60LmDn6AGtgdwDclNIdBSotjYjNaDAYj0L2DIdw3d2KLe0BdN5/cm86sCM6ESSLo3pGS2cGtZt9GawUo8cM=
X-Received: by 2002:aca:50ca:: with SMTP id e193mr15226415oib.110.1570374526444;
 Sun, 06 Oct 2019 08:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191004100025.70798-1-mika.westerberg@linux.intel.com> <0002b2f3-d17c-0d49-52f4-b2ce31832e6c@kernel.dk>
In-Reply-To: <0002b2f3-d17c-0d49-52f4-b2ce31832e6c@kernel.dk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 6 Oct 2019 17:08:31 +0200
Message-ID: <CAJZ5v0i=rc6DiZfch6J8ZOyj8ksK-2Dyb+qH_o=NQxtSntfnOw@mail.gmail.com>
Subject: Re: [PATCH 1/2] bdi: Do not use freezable workqueue
To:     Jens Axboe <axboe@kernel.dk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Jan Kara <jack@suse.cz>,
        Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        AceLan Kao <acelan.kao@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 4, 2019 at 3:22 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/4/19 4:00 AM, Mika Westerberg wrote:
> > A removable block device, such as NVMe or SSD connected over Thunderbolt
> > can be hot-removed any time including when the system is suspended. When
> > device is hot-removed during suspend and the system gets resumed, kernel
> > first resumes devices and then thaws the userspace including freezable
> > workqueues. What happens in that case is that the NVMe driver notices
> > that the device is unplugged and removes it from the system. This ends
> > up calling bdi_unregister() for the gendisk which then schedules
> > wb_workfn() to be run one more time.
> >
> > However, since the bdi_wq is still frozen flush_delayed_work() call in
> > wb_shutdown() blocks forever halting system resume process. User sees
> > this as hang as nothing is happening anymore.
> >
> > Triggering sysrq-w reveals this:
> >
> >    Workqueue: nvme-wq nvme_remove_dead_ctrl_work [nvme]
> >    Call Trace:
> >     ? __schedule+0x2c5/0x630
> >     ? wait_for_completion+0xa4/0x120
> >     schedule+0x3e/0xc0
> >     schedule_timeout+0x1c9/0x320
> >     ? resched_curr+0x1f/0xd0
> >     ? wait_for_completion+0xa4/0x120
> >     wait_for_completion+0xc3/0x120
> >     ? wake_up_q+0x60/0x60
> >     __flush_work+0x131/0x1e0
> >     ? flush_workqueue_prep_pwqs+0x130/0x130
> >     bdi_unregister+0xb9/0x130
> >     del_gendisk+0x2d2/0x2e0
> >     nvme_ns_remove+0xed/0x110 [nvme_core]
> >     nvme_remove_namespaces+0x96/0xd0 [nvme_core]
> >     nvme_remove+0x5b/0x160 [nvme]
> >     pci_device_remove+0x36/0x90
> >     device_release_driver_internal+0xdf/0x1c0
> >     nvme_remove_dead_ctrl_work+0x14/0x30 [nvme]
> >     process_one_work+0x1c2/0x3f0
> >     worker_thread+0x48/0x3e0
> >     kthread+0x100/0x140
> >     ? current_work+0x30/0x30
> >     ? kthread_park+0x80/0x80
> >     ret_from_fork+0x35/0x40
> >
> > This is not limited to NVMes so exactly same issue can be reproduced by
> > hot-removing SSD (over Thunderbolt) while the system is suspended.
> >
> > Prevent this from happening by removing WQ_FREEZABLE from bdi_wq.
>
> This series looks good for me, I don't think there's a reason for
> the workers to be marked freezable.

I was a bit concerned that the original idea might be to prevent
writes to the persistent storage from occurring after creating an
image during hibernation, but if that's not the case, the series is
fine from the general power management standpoint, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for both patches.
