Return-Path: <linux-pm+bounces-26916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F6AAB0FA5
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 11:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6AD171260
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 09:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93A527FD6C;
	Fri,  9 May 2025 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuMSYjjm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED7A26FD8E;
	Fri,  9 May 2025 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746784490; cv=none; b=I7QkEsi5GTv2KuKcj7ocwu7XFOofv8OL17kdIxjZbLU/fGe7cWv8j3K5cp1hUM+rCTOM9Cs0mnP2VHpQgS+Ot9+rXN/LV1zJuZaSeRZYRPU7ArO3VA9yxaCKcg3/ROZfGSkT+0nwagNaEFPhDHQCdHjHpm+OEsKHD8MiCvQ1BnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746784490; c=relaxed/simple;
	bh=RLo6QQ/VJ9BOpLwmJae2INlKH3o9h57EyL9afSfmOQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgKNEXZRWfUdPKxZB/t9/TH6se862ofB4yqdRAPeIgdxEMsgsaMe2MsY7PMfAKBA91Zq4ta+LZrcD3BHoTwWTrRenbI8JC04aemNfTsug+/JAQ68ES3Eynh1SWcYIOZzkIWMUKjCaaJ3CZzfMcLcd3/hSbj+H9fJ/I49kweq1uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuMSYjjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13ACAC4CEE9;
	Fri,  9 May 2025 09:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746784490;
	bh=RLo6QQ/VJ9BOpLwmJae2INlKH3o9h57EyL9afSfmOQw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NuMSYjjmxYpZ+j012S8qDSKxHuW6gclB6gXXsha54voq5jC0DroRuhdFDuIIXUITC
	 DTPHLA04QhptNUhevc0sU72yXpvXzMlLEkRi9K34bEOJpI6vKY70KZP8KcH2h+Cr+a
	 CwP3MsLA84pV7RFOuOGVA/X8HNLkewEGvbdfFHWQT5GiU0jmMf+xFjOOXga/SQ5W00
	 qMNh5NYmcvix5aiXgT4kT96IxKSQKIxk1jpYlLkU1Dq4MaDfF0XDt/6lx/6aKjmRDL
	 MiMgtZO8IdUXwWr5+6it5QHG0xGZPkiNBcEYci4onaU+NzbGXJ6VICcuxJWrkenRqc
	 dH2Jb099dhnpw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2cc82edcf49so686819fac.1;
        Fri, 09 May 2025 02:54:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3KUc62N1NvIqp5qUNqsdcKz+dpBmo1bzvTAnnKs5dJbEsC/CczpoD896JtMfGpK5gv3+NGEltSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSbytsvNHbLAKkTQ/M00GaDBQww/yyHZjBIuozPskiFyBZLaKY
	1BQXId1buQir1qNsc9AG2gGu2h7Md+mWpzSlpblw/oXxk0K5mY4BrvWnPjRoacq1H5Z5Byhr3vG
	j9OGJIO3UIWExE5438npHWt+ZFQc=
X-Google-Smtp-Source: AGHT+IHEdjAf5Lbw/CuPGZ73Byzk71q8eLZoc9rbF9oNBZ7eK8UKq8KRhcLVQBoLsVyIFEZwxX9j3uQo5dWTLpEt40U=
X-Received: by 2002:a05:6871:b14:b0:2d4:d07c:7cb2 with SMTP id
 586e51a60fabf-2dba42af6b6mr1427874fac.11.1746784489048; Fri, 09 May 2025
 02:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505161928.475030-1-daniel.lezcano@linaro.org> <CAJZ5v0g_32_0QgsWBfK0YJ30EimqUu66W89OCditxpjHKO5+OA@mail.gmail.com>
In-Reply-To: <CAJZ5v0g_32_0QgsWBfK0YJ30EimqUu66W89OCditxpjHKO5+OA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 11:54:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j5Ar3s5RGCxqEdAzJrt1GUnnezVYA+fzK_D8Lfrdrm-Q@mail.gmail.com>
X-Gm-Features: ATxdqUG3DqSe83-43elsDydUyeFXOi8ud2AHo1fwKgxt2rOyb8rFSF48iRz13TQ
Message-ID: <CAJZ5v0j5Ar3s5RGCxqEdAzJrt1GUnnezVYA+fzK_D8Lfrdrm-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] power: Userspace performance QoS
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	ulf.hansson@linaro.org, arnd@linaro.org, saravanak@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 11:05=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, May 5, 2025 at 6:19=E2=80=AFPM Daniel Lezcano <daniel.lezcano@lin=
aro.org> wrote:
> >
> > In the embedded ecosystem, the Linux kernel is modified to integrate
> > fake thermal cooling devices for the sake of the ABI exported in the
> > sysfs.
> >
> > While investigating those different devices, it appears most of them
> > could fall under a performance QoS feature.
> >
> > As discussed at the Linux Plumber Conference 2024, we want to let the
> > userspace to access the device performance knob via a char device
> > which would be created by the backend drivers and controlled with an
> > ioctl.
> >
> > A performance constraint is a minimal or a maximal limit applied to a
> > device performance state. A process can only set one constraint per
> > limit, in other words a minimal performance and/or a maximal
> > performance constraint. A new value will change the current
> > constraint, not create a new one.
>
> So how does this work for the constraints where
> perf_qos_constraint_find() has returned a valid pointer in
> perf_qos_set()?  Is someone else's constraint updated without
> notifying the original owner?
>
> > If another constraint must be
> > stacked with the current one, then the char device file must be opened
> > again and the resulting new file descriptor must be used to create a
> > new constraint.
> >
> > Constraint life cycle:
> >
> > The userspace can be a place where buggy programs with root privileges
> > can tamper with the device performance. In order to prevent some dumb
> > logics to set a device performance state and then go away, thus
> > messing with the global system performance consistency, there is a
> > particular care of the constraint life cycles. These ones are directly
> > tied with the opened file descriptor of the char device. When it is
> > released, then the constraint is removed but only if its refcount
> > reaches zero.
>
> So I'm totally unconvinced about the refcount thing.
>
> I personally don't think that sharing constraints is a good idea at
> all.  In principle, it doesn't matter that the current constraint
> value is the same as somebody else's constraint value: they are
> different constraints because they have been set by different
> entities.  It should be possible to update any of them independently
> at any time and the involved complexity is not worth the memory usage
> reduction achieved by sharing constraints.
>
> As an optimization, it is premature at best IMV.
>
> > This situation exists if only process sets the
> > constraint and then closes the file descriptor (manually or at exit
> > time). If the process forks multiple time and the children inherit the
> > file descriptor, the constraint will be removed when all the children
> > close the file descriptor.
> >
> > However, if another process opens the char device and sets a
> > constraint which already exists then that results in incrementing the
> > refcount of the constraint. The constraint is then removed when all
> > the processes have closed their file descriptor pointing to the char
> > device.
> >
> > At creation time:
> >
> >  - if another process asked for the same limit of performance, then
> >    the refcount constraint is incremented
> >
> >  - if there is an existing constraint with a higher priority, then the
> >    requested constraint is queued in the ordered list of constraints
> >
> >  - if there is an existing constraint with a lower limit, then the
> >    requested constrained is applied and the current constraint is
> >    queued in the ordered list of constraints
> >
> > At removal time:
> >
> >  - if the removed constraint is the current one, then the next
> >    constraint in the ordered list is applied
> >
> >  - if the removed constraint is not the current one, then it is simply
> >    removed from the ordered list
> >
> > The changes allows the userspace to set a performance constraint for a
> > specific device but the kernel may also want to apply a performance
> > constraint. The in-kernel API is not yet implemented as it represents
> > a significant amount of work depending on the direction of this patch.
>
> Apart from the above, I'm not sure if the locking is sufficient and
> there are a few minor nits below.
>
> However, at the general level, an in-kernel user of this is missing
> which is needed to illustrate how this is going to be integrated with
> the existing code.  That is, what happens when user space sets a
> constraint for a specific device, where that constraint is applied and
> how exactly.
>
> Also, in the cooling device interface, the user space agent chooses
> the state to put the device into, which is not a constraint, but a
> representation of the desired performance (or thermal pressure if you
> will).  This QoS interface instead operates min and max limits, so how
> are the users supposed to know what to do with it?  Is setting the max
> limit equivalent to setting a specific cooling state?  If so, then
> what's the role of the min limit?  And what about the soft limit
> values?  How are they supposed to be used?
>
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >  include/linux/perf_qos.h            |  45 ++
> >  include/uapi/linux/perf_qos_ioctl.h |  47 ++
> >  kernel/power/Makefile               |   2 +-
> >  kernel/power/perf_qos.c             | 652 ++++++++++++++++++++++++++++
> >  4 files changed, 745 insertions(+), 1 deletion(-)
> >  create mode 100644 include/linux/perf_qos.h
> >  create mode 100644 include/uapi/linux/perf_qos_ioctl.h
> >  create mode 100644 kernel/power/perf_qos.c
> >
> > diff --git a/include/linux/perf_qos.h b/include/linux/perf_qos.h
> > new file mode 100644
> > index 000000000000..57529c40be4d
> > --- /dev/null
> > +++ b/include/linux/perf_qos.h
> > @@ -0,0 +1,45 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Performance QoS device abstraction
> > + *
> > + * Copyright (2024) Linaro Ltd
> > + *
> > + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> > + *
> > + */
> > +#ifndef __PERF_QOS_H
> > +#define __PERF_QOS_H
> > +
> > +#include <uapi/linux/perf_qos_ioctl.h>
> > +
> > +struct perf_qos;
> > +
> > +/**
> > + * struct perf_qos_value_descr - Performance constraint description
> > + *
> > + * @unit: the unit used for the constraint (normalized, throughput, ..=
.)
> > + * @limit_min: the minimal constraint limit to be set
> > + * @limit_max: the maximal constraint limit to be set
> > + */
> > +struct perf_qos_value_descr {
> > +       perf_qos_unit_t unit;
>
> "enum perf_qos_unit" would be better IMV.
>
> Also, why is this enum needed at all?
>
> > +       int limit_min;
> > +       int limit_max;
>
> Why not just min and max?
>
> > +};
> > +
> > +typedef int (*set_perf_limit_cb_t)(int);
> > +
> > +struct perf_qos_ops {
> > +       set_perf_limit_cb_t set_perf_limit_max;
> > +       set_perf_limit_cb_t set_perf_limit_min;
> > +};
> > +
> > +extern struct perf_qos *perf_qos_device_create(const char *name,
> > +                                              struct perf_qos_ops *ops=
,
> > +                                              struct perf_qos_value_de=
scr *descr);
> > +
> > +extern int perf_qos_is_allowed(struct perf_qos *pq, int performance);
> > +
> > +extern void perf_qos_device_destroy(struct perf_qos *pq);
> > +
> > +#endif
> > diff --git a/include/uapi/linux/perf_qos_ioctl.h b/include/uapi/linux/p=
erf_qos_ioctl.h
> > new file mode 100644
> > index 000000000000..a9fb8940c175
> > --- /dev/null
> > +++ b/include/uapi/linux/perf_qos_ioctl.h
> > @@ -0,0 +1,47 @@
> > +/* SPDX-License-Identifier: LGPL-2.0+ WITH Linux-syscall-note */
> > +/*
> > + * Performance QoS device abstraction
> > + *
> > + * Copyright (2024) Linaro Ltd
> > + *
> > + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> > + *
> > + */
> > +#ifndef __PERF_QOS_IOCTL_H
> > +#define __PERF_QOS_IOCTL_H
> > +
> > +#include <linux/types.h>
> > +
> > +enum {
> > +       PERF_QOS_IOC_SET_MIN_CMD,
> > +       PERF_QOS_IOC_GET_MIN_CMD,
> > +       PERF_QOS_IOC_SET_MAX_CMD,
> > +       PERF_QOS_IOC_GET_MAX_CMD,
> > +       PERF_QOS_IOC_GET_UNIT_CMD,
> > +       PERF_QOS_IOC_GET_LIMITS_CMD,
>
> What's this one for?
>
> > +       PERF_QOS_IOC_MAX_CMD,
> > +};
>
> It would be nice to document this interface somehow, so it is not
> necessary to reverse-engineer the code to find out how it is expected
> to work.
>
> > +
> > +typedef enum {
> > +       PERF_QOS_UNIT_NORMAL,
> > +       PERF_QOS_UNIT_KBPS,
> > +       PERF_QOS_UNIT_MAX
> > +} perf_qos_unit_t;
>
> This is just an enum type.  What's the typedef for?
>
> > +
> > +struct perf_qos_ioctl_arg {
> > +       int value;
> > +       int limit_min;
> > +       int limit_max;
>
> Again, why not min and max?
>
> > +       perf_qos_unit_t unit;
> > +};
> > +
> > +#define PERF_QOS_IOCTL_TYPE 'P'
> > +
> > +#define PERF_QOS_IOC_SET_MIN   _IOW(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_=
SET_MIN_CMD,     struct perf_qos_ioctl_arg *)
> > +#define PERF_QOS_IOC_GET_MIN   _IOR(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_=
GET_MIN_CMD,     struct perf_qos_ioctl_arg *)
> > +#define PERF_QOS_IOC_SET_MAX   _IOW(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_=
SET_MAX_CMD,     struct perf_qos_ioctl_arg *)
> > +#define PERF_QOS_IOC_GET_MAX   _IOR(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_=
GET_MAX_CMD,     struct perf_qos_ioctl_arg *)
> > +#define PERF_QOS_IOC_GET_UNIT  _IOR(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_=
GET_UNIT_CMD,    struct perf_qos_ioctl_arg *)
> > +#define PERF_QOS_IOC_GET_LIMITS        _IOR(PERF_QOS_IOCTL_TYPE, PERF_=
QOS_IOC_GET_LIMITS_CMD,  struct perf_qos_ioctl_arg *)
> > +
> > +#endif
> > diff --git a/kernel/power/Makefile b/kernel/power/Makefile
> > index 874ad834dc8d..e2e4d707ab6e 100644
> > --- a/kernel/power/Makefile
> > +++ b/kernel/power/Makefile
> > @@ -8,7 +8,7 @@ endif
> >
> >  KASAN_SANITIZE_snapshot.o      :=3D n
> >
> > -obj-y                          +=3D qos.o
> > +obj-y                          +=3D qos.o perf_qos.o
> >  obj-$(CONFIG_PM)               +=3D main.o
> >  obj-$(CONFIG_VT_CONSOLE_SLEEP) +=3D console.o
> >  obj-$(CONFIG_FREEZER)          +=3D process.o
> > diff --git a/kernel/power/perf_qos.c b/kernel/power/perf_qos.c
> > new file mode 100644
> > index 000000000000..ca0619b07ae5
> > --- /dev/null
> > +++ b/kernel/power/perf_qos.c
> > @@ -0,0 +1,652 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Performance Quality of Service (Perf QoS) support base.
> > + *
> > + * Copyright (C) 2024 Linaro Ltd
> > + *
> > + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> > + *
>
> I would expect some description of what the code in this file is for here=
.
>
> > + */
> > +#include <linux/cdev.h>
> > +#include <linux/perf_qos.h>
> > +#include <linux/list_sort.h>
> > +
> > +#define DEVNAME "perf_qos"
> > +#define NUM_PERF_QOS_MINORS 128
> > +
> > +static DEFINE_IDR(perf_qos_minors);
> > +static struct class *perf_qos_class;
> > +static dev_t perf_qos_devt;
> > +
> > +typedef enum {
> > +       PERF_QOS_LIMIT_MAX,
> > +       PERF_QOS_LIMIT_MIN,
>
> PERF_QOS_MAX/MIN?
>
> > +} perf_qos_limit_t;
>
> Why would "enum perf_qos_type" be insufficient?
>
> > +
> > +/**
> > + * struct perf_qos_constraint - structure holding a constraint informa=
tion
> > + *
> > + * @soft_limit: an integer corresponding of the limit value set
> > + * @hard_limit: an integer corresponding to the limit value allowed by=
 the driver
> > + * @kref: a refcount to the constraint responsible of its life cycle
> > + * @set_perf_limit_cb: a callback to notify the backend driver about t=
he limit change
> > + * @node: the list node to attach this constraint with the list of con=
straints
> > + * @head: the list of constraints the @node
> > + *
> > + * This structure has a couple of instanciation per perf QoS file
> > + * opened by a process. The process can apply one or two constraints
> > + * to the device.
> > + *
> > + * Other processes will allocate their own constraints which will be
> > + * added in the list of constraints.
>
> In the absence of general documentation, this comment doesn't help too
> much I'm afraid.
>
> > + */
> > +struct perf_qos_constraint {
> > +       int soft_limit;
> > +       int hard_limit;
> > +       set_perf_limit_cb_t set_perf_limit_cb;
> > +       struct kref kref;
> > +       struct list_head node;
> > +       struct list_head *head;
> > +};
> > +
> > +/**
> > + * struct perf_qos - structure owning the constraint information for
> > + *                     the device
> > + *
> > + * @lock: lock to protect the actions on the list of constraints
> > + * @perf_qos_cdev: a struct cdev used for the device destruction
> > + * @ops: the ops given by the backend driver to notify the change of c=
onstraint
> > + * @descr: a constraint descriptor giving the units and the boundaries
>
> The meaning of this is kind of unclear.
>
> > + * @perf_min: the list of the minimal performance constraints
> > + * @perf_max: the list of the maximal performance constraints
>
> s/maximal/maximum/
>
> > + */
> > +struct perf_qos {
> > +       spinlock_t lock;
>
> Why spinlock?
>
> > +       struct cdev perf_qos_cdev;
>
> Why not just cdev?
>
> > +       struct perf_qos_ops *ops;
> > +       struct perf_qos_value_descr *descr;
> > +       struct list_head perf_min;
> > +       struct list_head perf_max;
>
> I would prefer constraiints_min and constraints_max.
>
> > +};
> > +
> > +/**
> > + * struct perf_qos_data - structure with the requested constraints
> > + *
> > + * @pqc_min: the requested performance constraint giving the minimal v=
alue
> > + * @pqc_max: the requested performance constraint giving the maximal v=
alue
> > + */
> > +struct perf_qos_data {
> > +       struct perf_qos_constraint *pqc_min;
> > +       struct perf_qos_constraint *pqc_max;
> > +};
> > +
> > +static struct perf_qos_constraint *perf_qos_constraint_find(struct lis=
t_head *list, int value)
> > +{
> > +       struct perf_qos_constraint *pcq;
> > +
> > +       list_for_each_entry(pcq, list, node) {
> > +               if (pcq->soft_limit =3D=3D value)
> > +                       return pcq;
>
> Why does this check soft_limit and not hard_limit?
>
> > +       }
> > +
> > +       return NULL;
> > +}
> > +
> > +static int perf_qos_constraint_cmp(void *data,
> > +                                  const struct list_head *l1,
> > +                                  const struct list_head *l2)
> > +{
> > +       struct perf_qos_constraint *pqc1 =3D container_of(l1, struct pe=
rf_qos_constraint, node);
> > +       struct perf_qos_constraint *pqc2 =3D container_of(l2, struct pe=
rf_qos_constraint, node);
> > +
> > +       /*
> > +        * The comparison will depend if we apply a max or min
> > +        * performance constraint. If the soft limit is lesser than
>
> "less than"
>
> > +        * the hard limit, that means it is a maximum limitation.
> > +        */
> > +       if (pqc1->soft_limit < pqc1->hard_limit)
> > +               return pqc1->soft_limit - pqc2->soft_limit;
> > +
> > +       return pqc2->soft_limit - pqc1->soft_limit;
>
> Again, why is this only comparing the soft limits?
>
> > +}
> > +
> > +static int perf_qos_del(struct perf_qos_constraint *pcq)
> > +{
> > +       const struct perf_qos_constraint *first;
> > +       int new_limit;
> > +
>
> I gather that this runs under a perf_qos lock.
>
> > +       first =3D list_first_entry(pcq->head, struct perf_qos_constrain=
t, node);
> > +
> > +       list_del(&pcq->node);
> > +
> > +       /*
> > +        * The active constraint is not the one we removed, so there
> > +        * is nothing more to do
> > +        */
> > +       if (first !=3D pcq)
> > +               return 0;
> > +
> > +       /*
> > +        * As we remove the first entry, then get the new first entry
> > +        * to apply the next constraint. If there is no more
> > +        * constraint set, reset to the original limit. Otherwise, use
> > +        * the new constraint value.
> > +        */
> > +       if (list_empty(pcq->head))
> > +               new_limit =3D pcq->hard_limit;
>
> I don't quite get it, sorry.  Shouldn't the new limit be a "no limit" her=
e?
>
> > +       else {
> > +               first =3D list_first_entry(pcq->head, struct perf_qos_c=
onstraint, node);
> > +               new_limit =3D first->soft_limit;
> > +       };
> > +
> > +       /*
> > +        * Notify the backend driver to update its performance level
> > +        * if needed. If the performance level is currently inside the
> > +        * new limits, nothing will happen. Otherwise it must be
> > +        * adjust the current performance level to be inside the
> > +        * authorized limits
> > +        */
> > +       pcq->set_perf_limit_cb(new_limit);
>
> So how's the provider of this callback supposed to know if this is the
> min or the max limit?
>
> > +
> > +       return 1;
> > +}
> > +
> > +static int perf_qos_add(struct perf_qos_constraint *pcq)
> > +{
> > +       const struct perf_qos_constraint *first;
> > +
>
> I gather that this runs under a perf_qos lock.
>
> > +       list_add(&pcq->node, pcq->head);
> > +
> > +       list_sort(NULL, pcq->head, perf_qos_constraint_cmp);
>
> And this may take some time in principle, so running it under a
> spinlock may not be a good idea.

This sorting is actually not necessary at all AFAICS.

If the list is always sorted, an element can be added to it at the
right spot: just iterate over elements until you find the place.  This
takes at most 1 list iteration, reads only and just a few writes to
update the next/prev pointers at the insertion time.

Moreover, the list can always be sorted in the same order regardless
of the constraint type ("min" or "max").  If the order is ascending,
then for the "min" constraint type the effective value is in the last
element and for the "max" constraint type it is in the first element.
This observation can be used to simplify the code quite a bit I think
(the "compare" function is not really needed for one).

And there are a few additional general observations that can be made.

First, the interface need not care about the units.  Since user space
needs to know exactly which driver it is going to interact with
through this interface, it also knows the perf units used by that
driver, so it doesn't need to be told what the unit is.

Second, the hard limits are not necessary.  The backend can deal with
any values that are passed to it and user space doesn't need to know
the device limits (and even if it does, there can be an ioctl to get
them, but they need to appear anywhere else in the interface because
the backend will observe them anyway).

Next, the backend should always be told the current effective min and
max limits when notified of a limit change.  Otherwise it will need to
figure out which limit has been updated and so on.

Finally, I would call this whole thing "perf clamp" rather than "perf
QoS", because it really is a clamp type of an interface.

There is one more thing that if user space updates the limits faster
than the backend is able to set them, the device may end up running
too slow or too fast all the time.  Maybe this is not a problem in
practice, but it may be worth taking care of in the future.

Thanks!

