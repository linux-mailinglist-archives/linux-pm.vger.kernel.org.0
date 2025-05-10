Return-Path: <linux-pm+bounces-26986-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E363FAB23D4
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 14:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459864A81FE
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 12:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADD51D7E37;
	Sat, 10 May 2025 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sccGKrNw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E49F79FD;
	Sat, 10 May 2025 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746880701; cv=none; b=MauL24V+g+geG7axIj7EH8TwsdYrc64Sch7vG9G4vIOufTF4gcG8xfew+kdoOh20krzHw4jJNCnJg7LRzaOZl4Sd3Mxxg/tZX0T7jbyDnKAKByhLPxefX6aD9hCvxr5dso2pIDsZo9ah0Cx/L/dY2/Ctnx3BUqA5ISQ8/fOYMok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746880701; c=relaxed/simple;
	bh=XmgwEudNnplR0I4BpHQp+B8votIewe3NUxBQ13NZKiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnK+lG6G2cIFGzKhGcc5/8uCmZSRdFYACHiK01qSKvm3BzREgqLVy1G15LUMDUJ6DYx1rC++ltpHvroRPF2g/dYn+DNEs//z5dTSX4uM+UluYlqfh+wsBpFakg8RvwtN3wUEKUgYAwH3JaAyAxICrNkAOaLPe9JjdB2v0y7C694=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sccGKrNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AE9C4CEE7;
	Sat, 10 May 2025 12:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746880700;
	bh=XmgwEudNnplR0I4BpHQp+B8votIewe3NUxBQ13NZKiw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sccGKrNwWuM97sk1ZNhTY2H168wi4Aropf1thBlBIFEFhFSNKcXMlniiBSBimytha
	 7DwZq6Kj8P2oqwqZ5bOORAF+RrKcQ2Fgg7xXgqdup6UlW3egAvamwBT9pD7AH+orMX
	 +5xFW7QGqw9/BQPXFPAbGMClXqiCGnohm1RBYJtF7hANhrK5nkXjJSrlJXGokCnynU
	 xkJaReDtV9ia1HYB7showg2rnqpqZG0aD/5P1Oz3bESXGmMzIS/6DGtHVuVOjCB6ls
	 HGFraA9I/1oJ9VZXLFximho+DNNp2BvwCFaC2yLpJlETmlds+Zgr2plW/GVNsNSNE6
	 6XURYKQb84IVQ==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3fa6c54cc1aso2015440b6e.1;
        Sat, 10 May 2025 05:38:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXt7LwpJUVIGRWF7+6aed0JFOJ8s3hLOLQKZEnAFY1c7AmU2LPlMTK4ctYhLX4Xf2tJFLYapAEpEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YypYnM/jZKi7T0IyU2nVEbK+xtB8EKD3nfTFoxhW6HU2oEZigGS
	CCM/Rznzq657mL6Ety55o31xyldvdmXpexFOinTntFhicMpOBJ9RCpcOWH3yJCYth3En/l+VpWG
	gJ66X1SWxTQXurkYh0oXpNxN7viE=
X-Google-Smtp-Source: AGHT+IHevHp00vnZVMvMTOQqdr0ze2rFMKjXZFm15S+Rgn2oi24VHgaR5oyeVL2/XTLDjJw8/lXLz1i2RlHKxQcZYII=
X-Received: by 2002:a05:6808:3a1b:b0:402:9a5:a9d2 with SMTP id
 5614622812f47-4037fe149dbmr4862202b6e.17.1746880699958; Sat, 10 May 2025
 05:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505161928.475030-1-daniel.lezcano@linaro.org>
 <CAJZ5v0g_32_0QgsWBfK0YJ30EimqUu66W89OCditxpjHKO5+OA@mail.gmail.com> <CAJZ5v0j5Ar3s5RGCxqEdAzJrt1GUnnezVYA+fzK_D8Lfrdrm-Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0j5Ar3s5RGCxqEdAzJrt1GUnnezVYA+fzK_D8Lfrdrm-Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 10 May 2025 14:38:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gdBe=oOccT7ys3+sc24xS1-fqFkQizVShGJc7L0xZfFQ@mail.gmail.com>
X-Gm-Features: AX0GCFvoLQZAHTdF-3nEp8Oj18CZOt73hLX1FvqsJH5aNwG3tXft1MkPVn5KuYE
Message-ID: <CAJZ5v0gdBe=oOccT7ys3+sc24xS1-fqFkQizVShGJc7L0xZfFQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] power: Userspace performance QoS
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	ulf.hansson@linaro.org, arnd@linaro.org, saravanak@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 11:54=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, May 8, 2025 at 11:05=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Mon, May 5, 2025 at 6:19=E2=80=AFPM Daniel Lezcano <daniel.lezcano@l=
inaro.org> wrote:
> > >
> > > In the embedded ecosystem, the Linux kernel is modified to integrate
> > > fake thermal cooling devices for the sake of the ABI exported in the
> > > sysfs.
> > >
> > > While investigating those different devices, it appears most of them
> > > could fall under a performance QoS feature.
> > >
> > > As discussed at the Linux Plumber Conference 2024, we want to let the
> > > userspace to access the device performance knob via a char device
> > > which would be created by the backend drivers and controlled with an
> > > ioctl.
> > >
> > > A performance constraint is a minimal or a maximal limit applied to a
> > > device performance state. A process can only set one constraint per
> > > limit, in other words a minimal performance and/or a maximal
> > > performance constraint. A new value will change the current
> > > constraint, not create a new one.
> >
> > So how does this work for the constraints where
> > perf_qos_constraint_find() has returned a valid pointer in
> > perf_qos_set()?  Is someone else's constraint updated without
> > notifying the original owner?
> >
> > > If another constraint must be
> > > stacked with the current one, then the char device file must be opene=
d
> > > again and the resulting new file descriptor must be used to create a
> > > new constraint.
> > >
> > > Constraint life cycle:
> > >
> > > The userspace can be a place where buggy programs with root privilege=
s
> > > can tamper with the device performance. In order to prevent some dumb
> > > logics to set a device performance state and then go away, thus
> > > messing with the global system performance consistency, there is a
> > > particular care of the constraint life cycles. These ones are directl=
y
> > > tied with the opened file descriptor of the char device. When it is
> > > released, then the constraint is removed but only if its refcount
> > > reaches zero.
> >
> > So I'm totally unconvinced about the refcount thing.
> >
> > I personally don't think that sharing constraints is a good idea at
> > all.  In principle, it doesn't matter that the current constraint
> > value is the same as somebody else's constraint value: they are
> > different constraints because they have been set by different
> > entities.  It should be possible to update any of them independently
> > at any time and the involved complexity is not worth the memory usage
> > reduction achieved by sharing constraints.
> >
> > As an optimization, it is premature at best IMV.
> >
> > > This situation exists if only process sets the
> > > constraint and then closes the file descriptor (manually or at exit
> > > time). If the process forks multiple time and the children inherit th=
e
> > > file descriptor, the constraint will be removed when all the children
> > > close the file descriptor.
> > >
> > > However, if another process opens the char device and sets a
> > > constraint which already exists then that results in incrementing the
> > > refcount of the constraint. The constraint is then removed when all
> > > the processes have closed their file descriptor pointing to the char
> > > device.
> > >
> > > At creation time:
> > >
> > >  - if another process asked for the same limit of performance, then
> > >    the refcount constraint is incremented
> > >
> > >  - if there is an existing constraint with a higher priority, then th=
e
> > >    requested constraint is queued in the ordered list of constraints
> > >
> > >  - if there is an existing constraint with a lower limit, then the
> > >    requested constrained is applied and the current constraint is
> > >    queued in the ordered list of constraints
> > >
> > > At removal time:
> > >
> > >  - if the removed constraint is the current one, then the next
> > >    constraint in the ordered list is applied
> > >
> > >  - if the removed constraint is not the current one, then it is simpl=
y
> > >    removed from the ordered list
> > >
> > > The changes allows the userspace to set a performance constraint for =
a
> > > specific device but the kernel may also want to apply a performance
> > > constraint. The in-kernel API is not yet implemented as it represents
> > > a significant amount of work depending on the direction of this patch=
.
> >
> > Apart from the above, I'm not sure if the locking is sufficient and
> > there are a few minor nits below.
> >
> > However, at the general level, an in-kernel user of this is missing
> > which is needed to illustrate how this is going to be integrated with
> > the existing code.  That is, what happens when user space sets a
> > constraint for a specific device, where that constraint is applied and
> > how exactly.
> >
> > Also, in the cooling device interface, the user space agent chooses
> > the state to put the device into, which is not a constraint, but a
> > representation of the desired performance (or thermal pressure if you
> > will).  This QoS interface instead operates min and max limits, so how
> > are the users supposed to know what to do with it?  Is setting the max
> > limit equivalent to setting a specific cooling state?  If so, then
> > what's the role of the min limit?  And what about the soft limit
> > values?  How are they supposed to be used?
> >
> > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > ---
> > >  include/linux/perf_qos.h            |  45 ++
> > >  include/uapi/linux/perf_qos_ioctl.h |  47 ++
> > >  kernel/power/Makefile               |   2 +-
> > >  kernel/power/perf_qos.c             | 652 ++++++++++++++++++++++++++=
++
> > >  4 files changed, 745 insertions(+), 1 deletion(-)
> > >  create mode 100644 include/linux/perf_qos.h
> > >  create mode 100644 include/uapi/linux/perf_qos_ioctl.h
> > >  create mode 100644 kernel/power/perf_qos.c
> > >
> > > diff --git a/include/linux/perf_qos.h b/include/linux/perf_qos.h
> > > new file mode 100644
> > > index 000000000000..57529c40be4d
> > > --- /dev/null
> > > +++ b/include/linux/perf_qos.h
> > > @@ -0,0 +1,45 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Performance QoS device abstraction
> > > + *
> > > + * Copyright (2024) Linaro Ltd
> > > + *
> > > + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > + *
> > > + */
> > > +#ifndef __PERF_QOS_H
> > > +#define __PERF_QOS_H
> > > +
> > > +#include <uapi/linux/perf_qos_ioctl.h>
> > > +
> > > +struct perf_qos;
> > > +
> > > +/**
> > > + * struct perf_qos_value_descr - Performance constraint description
> > > + *
> > > + * @unit: the unit used for the constraint (normalized, throughput, =
...)
> > > + * @limit_min: the minimal constraint limit to be set
> > > + * @limit_max: the maximal constraint limit to be set
> > > + */
> > > +struct perf_qos_value_descr {
> > > +       perf_qos_unit_t unit;
> >
> > "enum perf_qos_unit" would be better IMV.
> >
> > Also, why is this enum needed at all?
> >
> > > +       int limit_min;
> > > +       int limit_max;
> >
> > Why not just min and max?
> >
> > > +};
> > > +
> > > +typedef int (*set_perf_limit_cb_t)(int);
> > > +
> > > +struct perf_qos_ops {
> > > +       set_perf_limit_cb_t set_perf_limit_max;
> > > +       set_perf_limit_cb_t set_perf_limit_min;
> > > +};
> > > +
> > > +extern struct perf_qos *perf_qos_device_create(const char *name,
> > > +                                              struct perf_qos_ops *o=
ps,
> > > +                                              struct perf_qos_value_=
descr *descr);
> > > +
> > > +extern int perf_qos_is_allowed(struct perf_qos *pq, int performance)=
;
> > > +
> > > +extern void perf_qos_device_destroy(struct perf_qos *pq);
> > > +
> > > +#endif
> > > diff --git a/include/uapi/linux/perf_qos_ioctl.h b/include/uapi/linux=
/perf_qos_ioctl.h
> > > new file mode 100644
> > > index 000000000000..a9fb8940c175
> > > --- /dev/null
> > > +++ b/include/uapi/linux/perf_qos_ioctl.h
> > > @@ -0,0 +1,47 @@
> > > +/* SPDX-License-Identifier: LGPL-2.0+ WITH Linux-syscall-note */
> > > +/*
> > > + * Performance QoS device abstraction
> > > + *
> > > + * Copyright (2024) Linaro Ltd
> > > + *
> > > + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > + *
> > > + */
> > > +#ifndef __PERF_QOS_IOCTL_H
> > > +#define __PERF_QOS_IOCTL_H
> > > +
> > > +#include <linux/types.h>
> > > +
> > > +enum {
> > > +       PERF_QOS_IOC_SET_MIN_CMD,
> > > +       PERF_QOS_IOC_GET_MIN_CMD,
> > > +       PERF_QOS_IOC_SET_MAX_CMD,
> > > +       PERF_QOS_IOC_GET_MAX_CMD,
> > > +       PERF_QOS_IOC_GET_UNIT_CMD,
> > > +       PERF_QOS_IOC_GET_LIMITS_CMD,
> >
> > What's this one for?
> >
> > > +       PERF_QOS_IOC_MAX_CMD,
> > > +};
> >
> > It would be nice to document this interface somehow, so it is not
> > necessary to reverse-engineer the code to find out how it is expected
> > to work.
> >
> > > +
> > > +typedef enum {
> > > +       PERF_QOS_UNIT_NORMAL,
> > > +       PERF_QOS_UNIT_KBPS,
> > > +       PERF_QOS_UNIT_MAX
> > > +} perf_qos_unit_t;
> >
> > This is just an enum type.  What's the typedef for?
> >
> > > +
> > > +struct perf_qos_ioctl_arg {
> > > +       int value;
> > > +       int limit_min;
> > > +       int limit_max;
> >
> > Again, why not min and max?
> >
> > > +       perf_qos_unit_t unit;
> > > +};
> > > +
> > > +#define PERF_QOS_IOCTL_TYPE 'P'
> > > +
> > > +#define PERF_QOS_IOC_SET_MIN   _IOW(PERF_QOS_IOCTL_TYPE, PERF_QOS_IO=
C_SET_MIN_CMD,     struct perf_qos_ioctl_arg *)
> > > +#define PERF_QOS_IOC_GET_MIN   _IOR(PERF_QOS_IOCTL_TYPE, PERF_QOS_IO=
C_GET_MIN_CMD,     struct perf_qos_ioctl_arg *)
> > > +#define PERF_QOS_IOC_SET_MAX   _IOW(PERF_QOS_IOCTL_TYPE, PERF_QOS_IO=
C_SET_MAX_CMD,     struct perf_qos_ioctl_arg *)
> > > +#define PERF_QOS_IOC_GET_MAX   _IOR(PERF_QOS_IOCTL_TYPE, PERF_QOS_IO=
C_GET_MAX_CMD,     struct perf_qos_ioctl_arg *)
> > > +#define PERF_QOS_IOC_GET_UNIT  _IOR(PERF_QOS_IOCTL_TYPE, PERF_QOS_IO=
C_GET_UNIT_CMD,    struct perf_qos_ioctl_arg *)
> > > +#define PERF_QOS_IOC_GET_LIMITS        _IOR(PERF_QOS_IOCTL_TYPE, PER=
F_QOS_IOC_GET_LIMITS_CMD,  struct perf_qos_ioctl_arg *)
> > > +
> > > +#endif
> > > diff --git a/kernel/power/Makefile b/kernel/power/Makefile
> > > index 874ad834dc8d..e2e4d707ab6e 100644
> > > --- a/kernel/power/Makefile
> > > +++ b/kernel/power/Makefile
> > > @@ -8,7 +8,7 @@ endif
> > >
> > >  KASAN_SANITIZE_snapshot.o      :=3D n
> > >
> > > -obj-y                          +=3D qos.o
> > > +obj-y                          +=3D qos.o perf_qos.o
> > >  obj-$(CONFIG_PM)               +=3D main.o
> > >  obj-$(CONFIG_VT_CONSOLE_SLEEP) +=3D console.o
> > >  obj-$(CONFIG_FREEZER)          +=3D process.o
> > > diff --git a/kernel/power/perf_qos.c b/kernel/power/perf_qos.c
> > > new file mode 100644
> > > index 000000000000..ca0619b07ae5
> > > --- /dev/null
> > > +++ b/kernel/power/perf_qos.c
> > > @@ -0,0 +1,652 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Performance Quality of Service (Perf QoS) support base.
> > > + *
> > > + * Copyright (C) 2024 Linaro Ltd
> > > + *
> > > + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > + *
> >
> > I would expect some description of what the code in this file is for he=
re.
> >
> > > + */
> > > +#include <linux/cdev.h>
> > > +#include <linux/perf_qos.h>
> > > +#include <linux/list_sort.h>
> > > +
> > > +#define DEVNAME "perf_qos"
> > > +#define NUM_PERF_QOS_MINORS 128
> > > +
> > > +static DEFINE_IDR(perf_qos_minors);
> > > +static struct class *perf_qos_class;
> > > +static dev_t perf_qos_devt;
> > > +
> > > +typedef enum {
> > > +       PERF_QOS_LIMIT_MAX,
> > > +       PERF_QOS_LIMIT_MIN,
> >
> > PERF_QOS_MAX/MIN?
> >
> > > +} perf_qos_limit_t;
> >
> > Why would "enum perf_qos_type" be insufficient?
> >
> > > +
> > > +/**
> > > + * struct perf_qos_constraint - structure holding a constraint infor=
mation
> > > + *
> > > + * @soft_limit: an integer corresponding of the limit value set
> > > + * @hard_limit: an integer corresponding to the limit value allowed =
by the driver
> > > + * @kref: a refcount to the constraint responsible of its life cycle
> > > + * @set_perf_limit_cb: a callback to notify the backend driver about=
 the limit change
> > > + * @node: the list node to attach this constraint with the list of c=
onstraints
> > > + * @head: the list of constraints the @node
> > > + *
> > > + * This structure has a couple of instanciation per perf QoS file
> > > + * opened by a process. The process can apply one or two constraints
> > > + * to the device.
> > > + *
> > > + * Other processes will allocate their own constraints which will be
> > > + * added in the list of constraints.
> >
> > In the absence of general documentation, this comment doesn't help too
> > much I'm afraid.
> >
> > > + */
> > > +struct perf_qos_constraint {
> > > +       int soft_limit;
> > > +       int hard_limit;
> > > +       set_perf_limit_cb_t set_perf_limit_cb;
> > > +       struct kref kref;
> > > +       struct list_head node;
> > > +       struct list_head *head;
> > > +};
> > > +
> > > +/**
> > > + * struct perf_qos - structure owning the constraint information for
> > > + *                     the device
> > > + *
> > > + * @lock: lock to protect the actions on the list of constraints
> > > + * @perf_qos_cdev: a struct cdev used for the device destruction
> > > + * @ops: the ops given by the backend driver to notify the change of=
 constraint
> > > + * @descr: a constraint descriptor giving the units and the boundari=
es
> >
> > The meaning of this is kind of unclear.
> >
> > > + * @perf_min: the list of the minimal performance constraints
> > > + * @perf_max: the list of the maximal performance constraints
> >
> > s/maximal/maximum/
> >
> > > + */
> > > +struct perf_qos {
> > > +       spinlock_t lock;
> >
> > Why spinlock?
> >
> > > +       struct cdev perf_qos_cdev;
> >
> > Why not just cdev?
> >
> > > +       struct perf_qos_ops *ops;
> > > +       struct perf_qos_value_descr *descr;
> > > +       struct list_head perf_min;
> > > +       struct list_head perf_max;
> >
> > I would prefer constraiints_min and constraints_max.
> >
> > > +};
> > > +
> > > +/**
> > > + * struct perf_qos_data - structure with the requested constraints
> > > + *
> > > + * @pqc_min: the requested performance constraint giving the minimal=
 value
> > > + * @pqc_max: the requested performance constraint giving the maximal=
 value
> > > + */
> > > +struct perf_qos_data {
> > > +       struct perf_qos_constraint *pqc_min;
> > > +       struct perf_qos_constraint *pqc_max;
> > > +};
> > > +
> > > +static struct perf_qos_constraint *perf_qos_constraint_find(struct l=
ist_head *list, int value)
> > > +{
> > > +       struct perf_qos_constraint *pcq;
> > > +
> > > +       list_for_each_entry(pcq, list, node) {
> > > +               if (pcq->soft_limit =3D=3D value)
> > > +                       return pcq;
> >
> > Why does this check soft_limit and not hard_limit?
> >
> > > +       }
> > > +
> > > +       return NULL;
> > > +}
> > > +
> > > +static int perf_qos_constraint_cmp(void *data,
> > > +                                  const struct list_head *l1,
> > > +                                  const struct list_head *l2)
> > > +{
> > > +       struct perf_qos_constraint *pqc1 =3D container_of(l1, struct =
perf_qos_constraint, node);
> > > +       struct perf_qos_constraint *pqc2 =3D container_of(l2, struct =
perf_qos_constraint, node);
> > > +
> > > +       /*
> > > +        * The comparison will depend if we apply a max or min
> > > +        * performance constraint. If the soft limit is lesser than
> >
> > "less than"
> >
> > > +        * the hard limit, that means it is a maximum limitation.
> > > +        */
> > > +       if (pqc1->soft_limit < pqc1->hard_limit)
> > > +               return pqc1->soft_limit - pqc2->soft_limit;
> > > +
> > > +       return pqc2->soft_limit - pqc1->soft_limit;
> >
> > Again, why is this only comparing the soft limits?
> >
> > > +}
> > > +
> > > +static int perf_qos_del(struct perf_qos_constraint *pcq)
> > > +{
> > > +       const struct perf_qos_constraint *first;
> > > +       int new_limit;
> > > +
> >
> > I gather that this runs under a perf_qos lock.
> >
> > > +       first =3D list_first_entry(pcq->head, struct perf_qos_constra=
int, node);
> > > +
> > > +       list_del(&pcq->node);
> > > +
> > > +       /*
> > > +        * The active constraint is not the one we removed, so there
> > > +        * is nothing more to do
> > > +        */
> > > +       if (first !=3D pcq)
> > > +               return 0;
> > > +
> > > +       /*
> > > +        * As we remove the first entry, then get the new first entry
> > > +        * to apply the next constraint. If there is no more
> > > +        * constraint set, reset to the original limit. Otherwise, us=
e
> > > +        * the new constraint value.
> > > +        */
> > > +       if (list_empty(pcq->head))
> > > +               new_limit =3D pcq->hard_limit;
> >
> > I don't quite get it, sorry.  Shouldn't the new limit be a "no limit" h=
ere?
> >
> > > +       else {
> > > +               first =3D list_first_entry(pcq->head, struct perf_qos=
_constraint, node);
> > > +               new_limit =3D first->soft_limit;
> > > +       };
> > > +
> > > +       /*
> > > +        * Notify the backend driver to update its performance level
> > > +        * if needed. If the performance level is currently inside th=
e
> > > +        * new limits, nothing will happen. Otherwise it must be
> > > +        * adjust the current performance level to be inside the
> > > +        * authorized limits
> > > +        */
> > > +       pcq->set_perf_limit_cb(new_limit);
> >
> > So how's the provider of this callback supposed to know if this is the
> > min or the max limit?
> >
> > > +
> > > +       return 1;
> > > +}
> > > +
> > > +static int perf_qos_add(struct perf_qos_constraint *pcq)
> > > +{
> > > +       const struct perf_qos_constraint *first;
> > > +
> >
> > I gather that this runs under a perf_qos lock.
> >
> > > +       list_add(&pcq->node, pcq->head);
> > > +
> > > +       list_sort(NULL, pcq->head, perf_qos_constraint_cmp);
> >
> > And this may take some time in principle, so running it under a
> > spinlock may not be a good idea.
>
> This sorting is actually not necessary at all AFAICS.
>
> If the list is always sorted, an element can be added to it at the
> right spot: just iterate over elements until you find the place.  This
> takes at most 1 list iteration, reads only and just a few writes to
> update the next/prev pointers at the insertion time.
>
> Moreover, the list can always be sorted in the same order regardless
> of the constraint type ("min" or "max").  If the order is ascending,
> then for the "min" constraint type the effective value is in the last
> element and for the "max" constraint type it is in the first element.
> This observation can be used to simplify the code quite a bit I think
> (the "compare" function is not really needed for one).
>
> And there are a few additional general observations that can be made.
>
> First, the interface need not care about the units.  Since user space
> needs to know exactly which driver it is going to interact with
> through this interface, it also knows the perf units used by that
> driver, so it doesn't need to be told what the unit is.
>
> Second, the hard limits are not necessary.  The backend can deal with
> any values that are passed to it and user space doesn't need to know
> the device limits (and even if it does, there can be an ioctl to get
> them, but they need to appear anywhere else in the interface because
> the backend will observe them anyway).
>
> Next, the backend should always be told the current effective min and
> max limits when notified of a limit change.  Otherwise it will need to
> figure out which limit has been updated and so on.
>
> Finally, I would call this whole thing "perf clamp" rather than "perf
> QoS", because it really is a clamp type of an interface.
>
> There is one more thing that if user space updates the limits faster
> than the backend is able to set them, the device may end up running
> too slow or too fast all the time.  Maybe this is not a problem in
> practice, but it may be worth taking care of in the future.

FWIW, my design of this would be as follows (I'll stick to the
clamping terminology if you will).

If a kernel entity (eg. a driver) wants to respond to perf clamping,
it calls perf_clamp_create() to create a special device file for the
interface.  That will also cause a perf_clamp object associated with
that file to be created.

The perf_clamp object contains two list_head fields, clamp_min and
clamp_max, holding the min and max clamp lists, respectively, a
backend callback pointer, and a lock.  Both clamp_min and clamp_max
lists are always sorted in ascending order.

When a task in user space wants to set a perf clamp, it will open the
device special file.  That will cause a perf_clamp_instance object to
be created and associated with the open file descriptor.

A perf_clamp_instance object contains a pointer to the "parent"
perf_clamp object (associated with the opened device special file) and
two perf_clamp_limit fields, min and max.

A perf_clamp_limit consists of an unsigned integer value (val), a
list_head (node), and a type indicator (a bool value to distinguish
between the min and max limits).

Initially, the min perf_clamp_limit in a perf_clamp_instance becomes
the last element of the clamp_min list in the parent perf_clamp, and
the max perf_clamp_limit in a perf_clamp_instance becomes the first
element of the clamp_max list in the parent perf_clamp.  val is set to
UINT_MAX and 0 (which means "no limit" in both cases) for them,
respectively.

To set a limit, the holder of a file descriptor associated with a
perf_clamp_instance uses a _SET ioctl() that will remove the target
perf_clamp_limit from the list, set the new value for it, and add it
back to the same list in a different place, in accordance with the
ascending order.  If this causes the new value to become the new
effective clamp limit (that is, the first instance with a value
different from "no limit" in the "max" list or the last instance with
a value different from "no limit" in the "min" list), the backend
callback is invoked and both the min and max effective limits are
passed to it.  All of this takes place under the parent perf_clamp
lock.

To get the min or max value from a perf_clamp_instance, its holder
uses a _GET ioctl() (this doesn't require the parent lock).

Overall, there are two _SET and two _GET ioctl()s (for the min and max
values in both cases).

In addition, there can be two _GET_EFFECTIVE ioctl()s returning the
effective clamp values (for the effective min and max).

Closing a previously opened file descriptor removes the
perf_clamp_instance associated with it from both the min and max lists
(under the parent lock) and if that causes the effective limits to
change, the backend callback is invoked.  Next, the
perf_clamp_instance is deleted.

It would be good to also provide perf_clamp_destroy() for removing the
entire perf_clamp along with the special device file associated with
it, but that needs care because user space may be still using it.

I don't think that anything else is needed at this point and I hope this he=
lps.

