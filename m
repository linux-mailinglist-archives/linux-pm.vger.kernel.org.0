Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A173D645C
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jul 2021 18:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbhGZP5D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 26 Jul 2021 11:57:03 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:38868 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239440AbhGZP45 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jul 2021 11:56:57 -0400
Received: by mail-ot1-f48.google.com with SMTP id 19-20020a9d08930000b02904b98d90c82cso10562217otf.5;
        Mon, 26 Jul 2021 09:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7eA3rP3aWeS+yKeUdalJiZZ3+MRB3dmDKKblxGisnlw=;
        b=Qt2qqovpOvfWSk5fe3sLZjup+ZjzfZ7OKzvl4Zd2WVDdJDkD2XC8kPc00KZzr6rWrq
         xORQYz+DqN9BznrPteIqPFmqES1fpuqtJJB9O227OIzQw6+c4amxIe1kbERpcgi/Gp3o
         08QLr9BYO/04EjIb+uYolygELwjX1UD0G1PBxwFxZUxPAT0CvRPeAWzVRiFq6AGuwTA+
         C3ir1ALLzjEoWr5OdicBXCm/36BiOfKmJQ/x/ORDusvFC34bZkmz7Xz+MUEV7VkI59oy
         MrtVdT4scY9QlEMEvbEvV+08MhA26zOM9xl0n4aHvF3yo313bZqArUOlzci0HuuR/v/L
         +nmg==
X-Gm-Message-State: AOAM531SokQeQMtaoC+SKRiRDRmaVkgzk10zMIbvzlqqUUc1k7uNXGt/
        zSYaK7ZMBbqFGJ17hSSyXgLaH34xwA5fssCdtkQ=
X-Google-Smtp-Source: ABdhPJx5k6Wln1bzY8Oi4eCitpGpORwmKPZ8bqs2YffzycATwB2RqMeEuPCjlxvSObMYzzHxoeWLw1jLujkzVW/AGvY=
X-Received: by 2002:a9d:2968:: with SMTP id d95mr12468577otb.321.1627317444886;
 Mon, 26 Jul 2021 09:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210713161906.457857-1-stefanha@redhat.com> <1008dee4-fce1-2462-1520-f5432bc89a07@redhat.com>
 <YPfryV7qZVRbjNgP@stefanha-x1.localdomain> <869a993d-a1b0-1c39-d081-4cdd2b71041f@redhat.com>
 <YP7SEkDEIBOch9U8@stefanha-x1.localdomain> <CAJZ5v0h+RrRP-3MtV8dgxmba0rDfqoOw54DsFh0yx3YGUAVRqw@mail.gmail.com>
 <YP7cTjrfipfsJe9O@stefanha-x1.localdomain>
In-Reply-To: <YP7cTjrfipfsJe9O@stefanha-x1.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Jul 2021 18:37:13 +0200
Message-ID: <CAJZ5v0i4+2xda4Z6=JwRQf4ZzM2_agiyCwhMDRzAC-yz39fGzg@mail.gmail.com>
Subject: Re: [RFC 0/3] cpuidle: add poll_source API and virtio vq polling
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        virtualization@lists.linux-foundation.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 26, 2021 at 6:04 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Mon, Jul 26, 2021 at 05:47:19PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jul 26, 2021 at 5:17 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >
> > > On Thu, Jul 22, 2021 at 05:04:57PM +0800, Jason Wang wrote:
> > > >
> > > > 在 2021/7/21 下午5:41, Stefan Hajnoczi 写道:
> > > > > On Wed, Jul 21, 2021 at 11:29:55AM +0800, Jason Wang wrote:
> > > > > > 在 2021/7/14 上午12:19, Stefan Hajnoczi 写道:
> > > > > > > These patches are not polished yet but I would like request feedback on this
> > > > > > > approach and share performance results with you.
> > > > > > >
> > > > > > > Idle CPUs tentatively enter a busy wait loop before halting when the cpuidle
> > > > > > > haltpoll driver is enabled inside a virtual machine. This reduces wakeup
> > > > > > > latency for events that occur soon after the vCPU becomes idle.
> > > > > > >
> > > > > > > This patch series extends the cpuidle busy wait loop with the new poll_source
> > > > > > > API so drivers can participate in polling. Such polling-aware drivers disable
> > > > > > > their device's irq during the busy wait loop to avoid the cost of interrupts.
> > > > > > > This reduces latency further than regular cpuidle haltpoll, which still relies
> > > > > > > on irqs.
> > > > > > >
> > > > > > > Virtio drivers are modified to use the poll_source API so all virtio device
> > > > > > > types get this feature. The following virtio-blk fio benchmark results show the
> > > > > > > improvement:
> > > > > > >
> > > > > > >                IOPS (numjobs=4, iodepth=1, 4 virtqueues)
> > > > > > >                  before   poll_source      io_poll
> > > > > > > 4k randread    167102  186049 (+11%)  186654 (+11%)
> > > > > > > 4k randwrite   162204  181214 (+11%)  181850 (+12%)
> > > > > > > 4k randrw      159520  177071 (+11%)  177928 (+11%)
> > > > > > >
> > > > > > > The comparison against io_poll shows that cpuidle poll_source achieves
> > > > > > > equivalent performance to the block layer's io_poll feature (which I
> > > > > > > implemented in a separate patch series [1]).
> > > > > > >
> > > > > > > The advantage of poll_source is that applications do not need to explicitly set
> > > > > > > the RWF_HIPRI I/O request flag. The poll_source approach is attractive because
> > > > > > > few applications actually use RWF_HIPRI and it takes advantage of CPU cycles we
> > > > > > > would have spent in cpuidle haltpoll anyway.
> > > > > > >
> > > > > > > The current series does not improve virtio-net. I haven't investigated deeply,
> > > > > > > but it is possible that NAPI and poll_source do not combine. See the final
> > > > > > > patch for a starting point on making the two work together.
> > > > > > >
> > > > > > > I have not tried this on bare metal but it might help there too. The cost of
> > > > > > > disabling a device's irq must be less than the savings from avoiding irq
> > > > > > > handling for this optimization to make sense.
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/linux-block/20210520141305.355961-1-stefanha@redhat.com/
> > > > > >
> > > > > > Hi Stefan:
> > > > > >
> > > > > > Some questions:
> > > > > >
> > > > > > 1) What's the advantages of introducing polling at virtio level instead of
> > > > > > doing it at each subsystems? Polling in virtio level may only work well if
> > > > > > all (or most) of the devices are virtio
> > > > > I'm not sure I understand the question. cpuidle haltpoll benefits all
> > > > > devices today, except it incurs interrupt latency. The poll_source API
> > > > > eliminates the interrupt latency for drivers that can disable device
> > > > > interrupts cheaply.
> > > > >
> > > > > This patch adds poll_source to core virtio code so that all virtio
> > > > > drivers get this feature for free. No driver-specific changes are
> > > > > needed.
> > > > >
> > > > > If you mean networking, block layer, etc by "subsystems" then there's
> > > > > nothing those subsystems can do to help. Whether poll_source can be used
> > > > > depends on the specific driver, not the subsystem. If you consider
> > > > > drivers/virtio/ a subsystem, then that's exactly what the patch series
> > > > > is doing.
> > > >
> > > >
> > > > I meant, if we choose to use idle poll, we have some several choices:
> > > >
> > > > 1) bus level (e.g the virtio)
> > > > 2) subsystem level (e.g the networking and block)
> > > >
> > > > I'm not sure which one is better.
> > >
> > > This API is intended to be driver- or bus-level. I don't think
> > > subsystems can do very much since they don't know the hardware
> > > capabilities (cheap interrupt disabling) and in most cases there's no
> > > advantage of plumbing it through subsystems when drivers can call the
> > > API directly.
> > >
> > > > > > 2) What's the advantages of using cpuidle instead of using a thread (and
> > > > > > leverage the scheduler)?
> > > > > In order to combine with the existing cpuidle infrastructure. No new
> > > > > polling loop is introduced and no additional CPU cycles are spent on
> > > > > polling.
> > > > >
> > > > > If cpuidle itself is converted to threads then poll_source would
> > > > > automatically operate in a thread too, but this patch series doesn't
> > > > > change how the core cpuidle code works.
> > > >
> > > >
> > > > So networking subsystem can use NAPI busy polling in the process context
> > > > which means it can be leveraged by the scheduler.
> > > >
> > > > I'm not sure it's a good idea to poll drivers for a specific bus in the
> > > > general cpu idle layer.
> > >
> > > Why? Maybe because the cpuidle execution environment is a little special?
> >
> > Well, this would be prone to abuse.
> >
> > The time spent in that driver callback counts as CPU idle time while
> > it really is the driver running and there is not limit on how much
> > time the callback can take, while doing costly things in the idle loop
> > is generally avoided, because on wakeup the CPU needs to be available
> > to the task needing it as soon as possible.  IOW, the callback
> > potentially add unbounded latency to the CPU wakeup path.
>
> How is this different from driver interrupt handlers running during
> cpuidle?

The time spent on handling interrupts does not count as CPU idle time.
