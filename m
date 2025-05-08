Return-Path: <linux-pm+bounces-26903-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD44AB052C
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 23:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363484C124E
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 21:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641F921CFF6;
	Thu,  8 May 2025 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIkZg4F2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E332040A8;
	Thu,  8 May 2025 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746738323; cv=none; b=PIUI0ozr57xmIQbhKkbgTXb28xgAd9vTJMzMF5zlfP87TE2T7r4DIZ+fKoV/lUl1USZcyXuU5Nly61L3HwxQExA92AcSJRwhMZ8u1dko5VdWGe0+R4TPpwnvDzp82wnAEZLu7Co+y7/E2LbLcS6tjrFHU4+G3a83w3omMP4I4Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746738323; c=relaxed/simple;
	bh=hxDrD9XXiuc197OdbktDfozZwv2NdkCkSv27yz+7wEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TchZLcy9550yTX23HsWy9BfWlYQm1f1Q15+ozJzQEAZ2j2f3T1Zd/Im/Bb/iokXiU/XX48UeXMcp9E1q1hANePmDBmoq5pFBqTJx41oP4ooqSX9oq2W0Xh2Tme3FTX3SlNK+m/BcbvFho3mIlbMOV+yOrzNdj4CEtlAmZjnsi4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIkZg4F2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D1FC4CEEE;
	Thu,  8 May 2025 21:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746738322;
	bh=hxDrD9XXiuc197OdbktDfozZwv2NdkCkSv27yz+7wEY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UIkZg4F25nnhQ0q+/Xv7Vz5EHsfLYK5m4v/n/1RMU1JRBRIFGgS4hw2zNKuIw4z5A
	 8iHWEjkBycXyvwFkU3/BfhP/8PP3vod5elXSLUX32VCyMEHbDz3lFMhreun/OO7pVc
	 WGQE/KZaSWVdmV7e779FOtlHtlZD70DBTMjCQ9Pr0LPInNzob3swGVmBgekunwUXx1
	 iHGd60GcjtyW3OfJ6IZKXxqIRY7OqALjw1kjxDbDbX8q803WUOvXKDDFdYlZpqKNoO
	 h5R1VqwR7Td6AVgtOUcjMCIUJ2ZdDYTo8lBAv9NaXZIGZLxepo0vo8ltHOOHpSiMqd
	 mj+Lohyi4kuGw==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3fcfc85f1f5so488610b6e.2;
        Thu, 08 May 2025 14:05:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFzopZuOG+9x6nwQnaLv59x95IbaTu5fK9+dpErOghczGhSZ8YR9F9q2Yiitry/vQhLMWvLDZT0Z4=@vger.kernel.org, AJvYcCXi119RvZgY148y0SIedYwNQT7GAGgcYL2mMRbzuHfGDSMe/BFxvEyOIHDHCJ3ICeQGxYj33n51VB/zEs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzBRw6qQZ0o8rmISHQ/MjTLz4EoetPTFkIFBAENafckk0BDDgO
	dJLQMTRH1Qde5yII4OxfcLvbx9DISGVwtU6i3beTUsvwcOwrxIED6169mn38H+/dNLH82Q2KGJi
	EFOTY6VhlC6nR4B/ZdSxo67CIC/8=
X-Google-Smtp-Source: AGHT+IHxLW3pRBRucAOA2TzDVsFD0kqAYuqacXMsJqEOC9LLlReXLPcusRlC99HFPBbAs7MSK1MKNKfOlIGMoRtA82U=
X-Received: by 2002:a05:6808:2f0a:b0:403:25bd:ca6c with SMTP id
 5614622812f47-4038005b46cmr774927b6e.14.1746738321740; Thu, 08 May 2025
 14:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505161928.475030-1-daniel.lezcano@linaro.org>
In-Reply-To: <20250505161928.475030-1-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 8 May 2025 23:05:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g_32_0QgsWBfK0YJ30EimqUu66W89OCditxpjHKO5+OA@mail.gmail.com>
X-Gm-Features: ATxdqUFZKLK8dSafIHq5xA8TsErLqnerBfsEpvfGBBWxa_89mNS2OHrklrNS6RY
Message-ID: <CAJZ5v0g_32_0QgsWBfK0YJ30EimqUu66W89OCditxpjHKO5+OA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] power: Userspace performance QoS
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	ulf.hansson@linaro.org, arnd@linaro.org, saravanak@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 6:19=E2=80=AFPM Daniel Lezcano <daniel.lezcano@linar=
o.org> wrote:
>
> In the embedded ecosystem, the Linux kernel is modified to integrate
> fake thermal cooling devices for the sake of the ABI exported in the
> sysfs.
>
> While investigating those different devices, it appears most of them
> could fall under a performance QoS feature.
>
> As discussed at the Linux Plumber Conference 2024, we want to let the
> userspace to access the device performance knob via a char device
> which would be created by the backend drivers and controlled with an
> ioctl.
>
> A performance constraint is a minimal or a maximal limit applied to a
> device performance state. A process can only set one constraint per
> limit, in other words a minimal performance and/or a maximal
> performance constraint. A new value will change the current
> constraint, not create a new one.

So how does this work for the constraints where
perf_qos_constraint_find() has returned a valid pointer in
perf_qos_set()?  Is someone else's constraint updated without
notifying the original owner?

> If another constraint must be
> stacked with the current one, then the char device file must be opened
> again and the resulting new file descriptor must be used to create a
> new constraint.
>
> Constraint life cycle:
>
> The userspace can be a place where buggy programs with root privileges
> can tamper with the device performance. In order to prevent some dumb
> logics to set a device performance state and then go away, thus
> messing with the global system performance consistency, there is a
> particular care of the constraint life cycles. These ones are directly
> tied with the opened file descriptor of the char device. When it is
> released, then the constraint is removed but only if its refcount
> reaches zero.

So I'm totally unconvinced about the refcount thing.

I personally don't think that sharing constraints is a good idea at
all.  In principle, it doesn't matter that the current constraint
value is the same as somebody else's constraint value: they are
different constraints because they have been set by different
entities.  It should be possible to update any of them independently
at any time and the involved complexity is not worth the memory usage
reduction achieved by sharing constraints.

As an optimization, it is premature at best IMV.

> This situation exists if only process sets the
> constraint and then closes the file descriptor (manually or at exit
> time). If the process forks multiple time and the children inherit the
> file descriptor, the constraint will be removed when all the children
> close the file descriptor.
>
> However, if another process opens the char device and sets a
> constraint which already exists then that results in incrementing the
> refcount of the constraint. The constraint is then removed when all
> the processes have closed their file descriptor pointing to the char
> device.
>
> At creation time:
>
>  - if another process asked for the same limit of performance, then
>    the refcount constraint is incremented
>
>  - if there is an existing constraint with a higher priority, then the
>    requested constraint is queued in the ordered list of constraints
>
>  - if there is an existing constraint with a lower limit, then the
>    requested constrained is applied and the current constraint is
>    queued in the ordered list of constraints
>
> At removal time:
>
>  - if the removed constraint is the current one, then the next
>    constraint in the ordered list is applied
>
>  - if the removed constraint is not the current one, then it is simply
>    removed from the ordered list
>
> The changes allows the userspace to set a performance constraint for a
> specific device but the kernel may also want to apply a performance
> constraint. The in-kernel API is not yet implemented as it represents
> a significant amount of work depending on the direction of this patch.

Apart from the above, I'm not sure if the locking is sufficient and
there are a few minor nits below.

However, at the general level, an in-kernel user of this is missing
which is needed to illustrate how this is going to be integrated with
the existing code.  That is, what happens when user space sets a
constraint for a specific device, where that constraint is applied and
how exactly.

Also, in the cooling device interface, the user space agent chooses
the state to put the device into, which is not a constraint, but a
representation of the desired performance (or thermal pressure if you
will).  This QoS interface instead operates min and max limits, so how
are the users supposed to know what to do with it?  Is setting the max
limit equivalent to setting a specific cooling state?  If so, then
what's the role of the min limit?  And what about the soft limit
values?  How are they supposed to be used?

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  include/linux/perf_qos.h            |  45 ++
>  include/uapi/linux/perf_qos_ioctl.h |  47 ++
>  kernel/power/Makefile               |   2 +-
>  kernel/power/perf_qos.c             | 652 ++++++++++++++++++++++++++++
>  4 files changed, 745 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/perf_qos.h
>  create mode 100644 include/uapi/linux/perf_qos_ioctl.h
>  create mode 100644 kernel/power/perf_qos.c
>
> diff --git a/include/linux/perf_qos.h b/include/linux/perf_qos.h
> new file mode 100644
> index 000000000000..57529c40be4d
> --- /dev/null
> +++ b/include/linux/perf_qos.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Performance QoS device abstraction
> + *
> + * Copyright (2024) Linaro Ltd
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + */
> +#ifndef __PERF_QOS_H
> +#define __PERF_QOS_H
> +
> +#include <uapi/linux/perf_qos_ioctl.h>
> +
> +struct perf_qos;
> +
> +/**
> + * struct perf_qos_value_descr - Performance constraint description
> + *
> + * @unit: the unit used for the constraint (normalized, throughput, ...)
> + * @limit_min: the minimal constraint limit to be set
> + * @limit_max: the maximal constraint limit to be set
> + */
> +struct perf_qos_value_descr {
> +       perf_qos_unit_t unit;

"enum perf_qos_unit" would be better IMV.

Also, why is this enum needed at all?

> +       int limit_min;
> +       int limit_max;

Why not just min and max?

> +};
> +
> +typedef int (*set_perf_limit_cb_t)(int);
> +
> +struct perf_qos_ops {
> +       set_perf_limit_cb_t set_perf_limit_max;
> +       set_perf_limit_cb_t set_perf_limit_min;
> +};
> +
> +extern struct perf_qos *perf_qos_device_create(const char *name,
> +                                              struct perf_qos_ops *ops,
> +                                              struct perf_qos_value_desc=
r *descr);
> +
> +extern int perf_qos_is_allowed(struct perf_qos *pq, int performance);
> +
> +extern void perf_qos_device_destroy(struct perf_qos *pq);
> +
> +#endif
> diff --git a/include/uapi/linux/perf_qos_ioctl.h b/include/uapi/linux/per=
f_qos_ioctl.h
> new file mode 100644
> index 000000000000..a9fb8940c175
> --- /dev/null
> +++ b/include/uapi/linux/perf_qos_ioctl.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: LGPL-2.0+ WITH Linux-syscall-note */
> +/*
> + * Performance QoS device abstraction
> + *
> + * Copyright (2024) Linaro Ltd
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + */
> +#ifndef __PERF_QOS_IOCTL_H
> +#define __PERF_QOS_IOCTL_H
> +
> +#include <linux/types.h>
> +
> +enum {
> +       PERF_QOS_IOC_SET_MIN_CMD,
> +       PERF_QOS_IOC_GET_MIN_CMD,
> +       PERF_QOS_IOC_SET_MAX_CMD,
> +       PERF_QOS_IOC_GET_MAX_CMD,
> +       PERF_QOS_IOC_GET_UNIT_CMD,
> +       PERF_QOS_IOC_GET_LIMITS_CMD,

What's this one for?

> +       PERF_QOS_IOC_MAX_CMD,
> +};

It would be nice to document this interface somehow, so it is not
necessary to reverse-engineer the code to find out how it is expected
to work.

> +
> +typedef enum {
> +       PERF_QOS_UNIT_NORMAL,
> +       PERF_QOS_UNIT_KBPS,
> +       PERF_QOS_UNIT_MAX
> +} perf_qos_unit_t;

This is just an enum type.  What's the typedef for?

> +
> +struct perf_qos_ioctl_arg {
> +       int value;
> +       int limit_min;
> +       int limit_max;

Again, why not min and max?

> +       perf_qos_unit_t unit;
> +};
> +
> +#define PERF_QOS_IOCTL_TYPE 'P'
> +
> +#define PERF_QOS_IOC_SET_MIN   _IOW(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_SE=
T_MIN_CMD,     struct perf_qos_ioctl_arg *)
> +#define PERF_QOS_IOC_GET_MIN   _IOR(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_GE=
T_MIN_CMD,     struct perf_qos_ioctl_arg *)
> +#define PERF_QOS_IOC_SET_MAX   _IOW(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_SE=
T_MAX_CMD,     struct perf_qos_ioctl_arg *)
> +#define PERF_QOS_IOC_GET_MAX   _IOR(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_GE=
T_MAX_CMD,     struct perf_qos_ioctl_arg *)
> +#define PERF_QOS_IOC_GET_UNIT  _IOR(PERF_QOS_IOCTL_TYPE, PERF_QOS_IOC_GE=
T_UNIT_CMD,    struct perf_qos_ioctl_arg *)
> +#define PERF_QOS_IOC_GET_LIMITS        _IOR(PERF_QOS_IOCTL_TYPE, PERF_QO=
S_IOC_GET_LIMITS_CMD,  struct perf_qos_ioctl_arg *)
> +
> +#endif
> diff --git a/kernel/power/Makefile b/kernel/power/Makefile
> index 874ad834dc8d..e2e4d707ab6e 100644
> --- a/kernel/power/Makefile
> +++ b/kernel/power/Makefile
> @@ -8,7 +8,7 @@ endif
>
>  KASAN_SANITIZE_snapshot.o      :=3D n
>
> -obj-y                          +=3D qos.o
> +obj-y                          +=3D qos.o perf_qos.o
>  obj-$(CONFIG_PM)               +=3D main.o
>  obj-$(CONFIG_VT_CONSOLE_SLEEP) +=3D console.o
>  obj-$(CONFIG_FREEZER)          +=3D process.o
> diff --git a/kernel/power/perf_qos.c b/kernel/power/perf_qos.c
> new file mode 100644
> index 000000000000..ca0619b07ae5
> --- /dev/null
> +++ b/kernel/power/perf_qos.c
> @@ -0,0 +1,652 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Performance Quality of Service (Perf QoS) support base.
> + *
> + * Copyright (C) 2024 Linaro Ltd
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *

I would expect some description of what the code in this file is for here.

> + */
> +#include <linux/cdev.h>
> +#include <linux/perf_qos.h>
> +#include <linux/list_sort.h>
> +
> +#define DEVNAME "perf_qos"
> +#define NUM_PERF_QOS_MINORS 128
> +
> +static DEFINE_IDR(perf_qos_minors);
> +static struct class *perf_qos_class;
> +static dev_t perf_qos_devt;
> +
> +typedef enum {
> +       PERF_QOS_LIMIT_MAX,
> +       PERF_QOS_LIMIT_MIN,

PERF_QOS_MAX/MIN?

> +} perf_qos_limit_t;

Why would "enum perf_qos_type" be insufficient?

> +
> +/**
> + * struct perf_qos_constraint - structure holding a constraint informati=
on
> + *
> + * @soft_limit: an integer corresponding of the limit value set
> + * @hard_limit: an integer corresponding to the limit value allowed by t=
he driver
> + * @kref: a refcount to the constraint responsible of its life cycle
> + * @set_perf_limit_cb: a callback to notify the backend driver about the=
 limit change
> + * @node: the list node to attach this constraint with the list of const=
raints
> + * @head: the list of constraints the @node
> + *
> + * This structure has a couple of instanciation per perf QoS file
> + * opened by a process. The process can apply one or two constraints
> + * to the device.
> + *
> + * Other processes will allocate their own constraints which will be
> + * added in the list of constraints.

In the absence of general documentation, this comment doesn't help too
much I'm afraid.

> + */
> +struct perf_qos_constraint {
> +       int soft_limit;
> +       int hard_limit;
> +       set_perf_limit_cb_t set_perf_limit_cb;
> +       struct kref kref;
> +       struct list_head node;
> +       struct list_head *head;
> +};
> +
> +/**
> + * struct perf_qos - structure owning the constraint information for
> + *                     the device
> + *
> + * @lock: lock to protect the actions on the list of constraints
> + * @perf_qos_cdev: a struct cdev used for the device destruction
> + * @ops: the ops given by the backend driver to notify the change of con=
straint
> + * @descr: a constraint descriptor giving the units and the boundaries

The meaning of this is kind of unclear.

> + * @perf_min: the list of the minimal performance constraints
> + * @perf_max: the list of the maximal performance constraints

s/maximal/maximum/

> + */
> +struct perf_qos {
> +       spinlock_t lock;

Why spinlock?

> +       struct cdev perf_qos_cdev;

Why not just cdev?

> +       struct perf_qos_ops *ops;
> +       struct perf_qos_value_descr *descr;
> +       struct list_head perf_min;
> +       struct list_head perf_max;

I would prefer constraiints_min and constraints_max.

> +};
> +
> +/**
> + * struct perf_qos_data - structure with the requested constraints
> + *
> + * @pqc_min: the requested performance constraint giving the minimal val=
ue
> + * @pqc_max: the requested performance constraint giving the maximal val=
ue
> + */
> +struct perf_qos_data {
> +       struct perf_qos_constraint *pqc_min;
> +       struct perf_qos_constraint *pqc_max;
> +};
> +
> +static struct perf_qos_constraint *perf_qos_constraint_find(struct list_=
head *list, int value)
> +{
> +       struct perf_qos_constraint *pcq;
> +
> +       list_for_each_entry(pcq, list, node) {
> +               if (pcq->soft_limit =3D=3D value)
> +                       return pcq;

Why does this check soft_limit and not hard_limit?

> +       }
> +
> +       return NULL;
> +}
> +
> +static int perf_qos_constraint_cmp(void *data,
> +                                  const struct list_head *l1,
> +                                  const struct list_head *l2)
> +{
> +       struct perf_qos_constraint *pqc1 =3D container_of(l1, struct perf=
_qos_constraint, node);
> +       struct perf_qos_constraint *pqc2 =3D container_of(l2, struct perf=
_qos_constraint, node);
> +
> +       /*
> +        * The comparison will depend if we apply a max or min
> +        * performance constraint. If the soft limit is lesser than

"less than"

> +        * the hard limit, that means it is a maximum limitation.
> +        */
> +       if (pqc1->soft_limit < pqc1->hard_limit)
> +               return pqc1->soft_limit - pqc2->soft_limit;
> +
> +       return pqc2->soft_limit - pqc1->soft_limit;

Again, why is this only comparing the soft limits?

> +}
> +
> +static int perf_qos_del(struct perf_qos_constraint *pcq)
> +{
> +       const struct perf_qos_constraint *first;
> +       int new_limit;
> +

I gather that this runs under a perf_qos lock.

> +       first =3D list_first_entry(pcq->head, struct perf_qos_constraint,=
 node);
> +
> +       list_del(&pcq->node);
> +
> +       /*
> +        * The active constraint is not the one we removed, so there
> +        * is nothing more to do
> +        */
> +       if (first !=3D pcq)
> +               return 0;
> +
> +       /*
> +        * As we remove the first entry, then get the new first entry
> +        * to apply the next constraint. If there is no more
> +        * constraint set, reset to the original limit. Otherwise, use
> +        * the new constraint value.
> +        */
> +       if (list_empty(pcq->head))
> +               new_limit =3D pcq->hard_limit;

I don't quite get it, sorry.  Shouldn't the new limit be a "no limit" here?

> +       else {
> +               first =3D list_first_entry(pcq->head, struct perf_qos_con=
straint, node);
> +               new_limit =3D first->soft_limit;
> +       };
> +
> +       /*
> +        * Notify the backend driver to update its performance level
> +        * if needed. If the performance level is currently inside the
> +        * new limits, nothing will happen. Otherwise it must be
> +        * adjust the current performance level to be inside the
> +        * authorized limits
> +        */
> +       pcq->set_perf_limit_cb(new_limit);

So how's the provider of this callback supposed to know if this is the
min or the max limit?

> +
> +       return 1;
> +}
> +
> +static int perf_qos_add(struct perf_qos_constraint *pcq)
> +{
> +       const struct perf_qos_constraint *first;
> +

I gather that this runs under a perf_qos lock.

> +       list_add(&pcq->node, pcq->head);
> +
> +       list_sort(NULL, pcq->head, perf_qos_constraint_cmp);

And this may take some time in principle, so running it under a
spinlock may not be a good idea.

> +
> +       /*
> +        * A sort happened resulting in a different constraint at the hea=
d
> +        */
> +       first =3D list_first_entry(pcq->head, struct perf_qos_constraint,=
 node);
> +
> +       /*
> +        * The inserted constraint did not become the active one, so
> +        * we can bail out
> +        */
> +       if (pcq !=3D first)
> +               return 0;
> +
> +       /*
> +        * Notify the backend driver to update its performance level
> +        * if needed. If the performance level is currently inside the
> +        * new limits, nothing will happen. Otherwise it must be
> +        * adjust the current performance level to be inside the
> +        * authorized limits
> +        */
> +       pcq->set_perf_limit_cb(first->soft_limit);

Again, how's the backend going to know which limit this is?

> +
> +       return 1;
> +}
> +
> +static void perf_qos_constraint_release(struct kref *kref)
> +{
> +       struct perf_qos_constraint *pcq;
> +
> +       pcq =3D container_of(kref, struct perf_qos_constraint, kref);
> +
> +       /*
> +        * The removal of the constraint results in the change of the
> +        * first entry of the list which means it was the active
> +        * one. We need to apply the next constraint of the list
> +        */
> +       if (perf_qos_del(pcq)) {
> +               /* Something to do */

Missing code?

> +       }
> +
> +       kfree(pcq);
> +}
> +
> +static void perf_qos_constraint_put(struct perf_qos_constraint *pcq)
> +{
> +       kref_put(&pcq->kref, perf_qos_constraint_release);
> +}
> +
> +static void perf_qos_constraint_get(struct perf_qos_constraint *pcq)
> +{
> +       kref_get(&pcq->kref);
> +}
> +
> +static struct perf_qos_constraint *perf_qos_constraint_alloc(struct perf=
_qos *pq, int soft_limit,
> +                                                            struct list_=
head *perf, perf_qos_limit_t limit)
> +{
> +       struct perf_qos_constraint *pqc;
> +
> +       pqc =3D kzalloc(sizeof(*pqc), GFP_KERNEL);
> +       if (!pqc)
> +               return NULL;
> +
> +       kref_init(&pqc->kref);
> +       INIT_LIST_HEAD(&pqc->node);
> +
> +       if (limit =3D=3D PERF_QOS_LIMIT_MAX) {
> +               pqc->set_perf_limit_cb =3D pq->ops->set_perf_limit_max;
> +               pqc->hard_limit =3D pq->descr->limit_max;

Oh, I see where the hard limits come from.  Well, this is not
particularly straightforward.

> +       } else {
> +               pqc->set_perf_limit_cb =3D pq->ops->set_perf_limit_min;
> +               pqc->hard_limit =3D pq->descr->limit_min;
> +       }
> +
> +       pqc->head =3D perf;
> +       pqc->soft_limit =3D soft_limit;
> +
> +       return pqc;
> +}
> +
> +static int perf_qos_open(struct inode *inode, struct file *file)
> +{
> +       struct perf_qos_data *pqd;
> +       struct perf_qos *pq;
> +
> +       pq =3D idr_find(&perf_qos_minors, iminor(inode));
> +       if (!pq)
> +               return -ENODEV;
> +
> +       inode->i_private =3D pq;
> +
> +       pqd =3D kzalloc(sizeof(*pqd), GFP_KERNEL);
> +       if (!pqd)
> +               return -ENOMEM;
> +
> +       file->private_data =3D pqd;
> +
> +       return 0;
> +}
> +
> +static int perf_qos_release(struct inode *inode, struct file *file)
> +{
> +       struct perf_qos *pq =3D inode->i_private;
> +       struct perf_qos_data *pqd =3D file->private_data;
> +
> +       spin_lock(&pq->lock);
> +
> +       if (pqd->pqc_min)
> +               perf_qos_constraint_put(pqd->pqc_min);
> +
> +       if (pqd->pqc_max)
> +               perf_qos_constraint_put(pqd->pqc_max);
> +
> +       spin_unlock(&pq->lock);
> +
> +       kfree(pqd);
> +
> +       return 0;
> +}
> +
> +static int perf_qos_unset(struct perf_qos_constraint **cur_pqc,
> +                         perf_qos_limit_t limit, struct list_head *perf,=
 int value)
> +{
> +       /*
> +        * Removing a constraint:
> +        *
> +        * - if it exists then *current_pqc is set. We decrement the
> +         *   refcount and update the current constraint by setting it
> +         *   to NULL
> +        *
> +        * - if the current constraint does not exist then, it is an
> +         *   error and we should exit with an error
> +        */
> +       if (!(*cur_pqc))
> +               return -EINVAL;
> +
> +       perf_qos_constraint_put(*cur_pqc);
> +       *cur_pqc =3D NULL;
> +
> +       return 0;
> +}
> +
> +static int perf_qos_set(struct perf_qos *pq, struct perf_qos_constraint =
**cur_pqc,
> +                       perf_qos_limit_t limit, struct list_head *perf, i=
nt value)
> +{
> +       struct perf_qos_constraint *pqc;
> +       int ret =3D 0;
> +
> +       /*
> +        * We are trying to set the same constraint.
> +        */
> +       if (*cur_pqc && ((*cur_pqc)->soft_limit =3D=3D value)) {
> +               ret =3D -EALREADY;
> +               goto out;
> +       }
> +
> +       /*
> +        * Case 2 : Adding a constraint:
> +        *
> +        * - it already exists because it was created by another
> +        *   process, we increment the refcount
> +        *
> +        * - it already exists because we created it before, we
> +        *   return an error
> +        *
> +        * - it does not exist but there is a previous different
> +         *   constraint we set before. It is a constraint change. We
> +         *   must release the previous constraint and create a new
> +         *   one. However, we apply the new constraint and then we
> +         *   remove the old one in order to not have the backend
> +         *   driver with a window where there is no constraint at all
> +        *
> +        * - it does not exist and there is no previous constraint. It
> +         *   is a new constraint. We allocate the constraint, apply it
> +         *   and set it as the current constraint
> +        */
> +       pqc =3D perf_qos_constraint_find(perf, value);
> +       if (pqc) {
> +               perf_qos_constraint_get(pqc);

This is the part I'm not a fan of.

> +       } else {
> +               pqc =3D perf_qos_constraint_alloc(pq, value, perf, limit)=
;
> +               if (!pqc) {
> +                       ret =3D -ENOMEM;
> +                       goto out;
> +               }
> +
> +               /*
> +                * The new constraint has to be applied because it
> +                * results in a change of the first entry of the list
> +                * of constraints
> +                */
> +               if (perf_qos_add(pqc)) {
> +                       /* Something to do */
> +               }
> +       }
> +
> +       /*
> +        * We previously set a constraint, let's release the refcount
> +        * as we change it. The constraint can be freed if we are the
> +        * last one having a reference to it or if we are the creator
> +        * and no other process held a refcount on it.
> +        */
> +       if ((*cur_pqc))
> +               perf_qos_constraint_put(*cur_pqc);
> +
> +       *cur_pqc =3D pqc;
> +out:
> +       return ret;
> +}
> +
> +static int ioctl_perf_qos_set_max(struct perf_qos *pq,
> +                                 struct perf_qos_data *pqd,
> +                                 struct perf_qos_ioctl_arg *pqia)
> +{
> +       if (pqia->value > pq->descr->limit_max)
> +               return -EINVAL;
> +
> +       if (pqia->value =3D=3D pq->descr->limit_max)
> +               return perf_qos_unset(&pqd->pqc_max, PERF_QOS_LIMIT_MAX,
> +                                   &pq->perf_max, pqia->value);
> +       else
> +               return perf_qos_set(pq, &pqd->pqc_max, PERF_QOS_LIMIT_MAX=
,
> +                                   &pq->perf_max, pqia->value);
> +}
> +
> +static int ioctl_perf_qos_set_min(struct perf_qos *pq,
> +                                 struct perf_qos_data *pqd,
> +                                 struct perf_qos_ioctl_arg *pqia)
> +{
> +       if (pqia->value < pq->descr->limit_min)
> +               return -EINVAL;
> +
> +       if (pqia->value =3D=3D pq->descr->limit_min)
> +               return perf_qos_unset(&pqd->pqc_min, PERF_QOS_LIMIT_MIN,
> +                                   &pq->perf_min, pqia->value);
> +       else
> +               return perf_qos_set(pq, &pqd->pqc_min, PERF_QOS_LIMIT_MIN=
,
> +                                   &pq->perf_min, pqia->value);
> +}
> +
> +static int perf_qos_get(struct list_head *perf, int *value)
> +{
> +       struct perf_qos_constraint *pqc;
> +
> +       /*
> +        * We may not have set any performance constraint yet but
> +        * another process may have set one, so we get the head of
> +        * performance constraint list
> +        */
> +       if (list_empty(perf))
> +               return -ENODATA;
> +
> +       pqc =3D list_first_entry(perf, struct perf_qos_constraint, node);
> +
> +       *value =3D pqc->soft_limit;
> +
> +       return 0;
> +}
> +
> +static int ioctl_perf_qos_get_min(struct perf_qos *pq,
> +                                 struct perf_qos_data *pqd,
> +                                 struct perf_qos_ioctl_arg *pqia)
> +{
> +       return perf_qos_get(&pq->perf_min, &pqia->value);
> +}
> +
> +static int ioctl_perf_qos_get_max(struct perf_qos *pq,
> +                                 struct perf_qos_data *pqd,
> +                                 struct perf_qos_ioctl_arg *pqia)
> +{
> +       return perf_qos_get(&pq->perf_max, &pqia->value);
> +}
> +
> +static int ioctl_perf_qos_get_unit(struct perf_qos *pq,
> +                                  struct perf_qos_data *pqd,
> +                                  struct perf_qos_ioctl_arg *pqia)
> +{
> +       pqia->unit =3D pq->descr->unit;
> +
> +       return 0;
> +}
> +
> +static int ioctl_perf_qos_get_limits(struct perf_qos *pq,
> +                                    struct perf_qos_data *pqd,
> +                                    struct perf_qos_ioctl_arg *pqia)
> +{
> +       pqia->limit_min =3D pq->descr->limit_min;
> +       pqia->limit_max =3D pq->descr->limit_max;
> +
> +       return 0;
> +}
> +
> +typedef int (*perf_qos_ioctl_ops_t)(struct perf_qos *pq,
> +                                   struct perf_qos_data *pqd,
> +                                   struct perf_qos_ioctl_arg *pqia);
> +
> +static long perf_qos_ioctl(struct file *file, unsigned int ucmd,
> +                          unsigned long arg)
> +{
> +       struct perf_qos_data *pqd =3D file->private_data;
> +       struct perf_qos *pq =3D file->f_inode->i_private;
> +       struct perf_qos_ioctl_arg pqia;
> +       int cmd =3D _IOC_NR(ucmd);
> +       int dir =3D _IOC_DIR(ucmd);
> +       int type =3D _IOC_TYPE(ucmd);
> +       int ret;
> +
> +       perf_qos_ioctl_ops_t perf_qos_ioctl_ops[] =3D {
> +               [PERF_QOS_IOC_SET_MAX_CMD]      =3D ioctl_perf_qos_set_ma=
x,
> +               [PERF_QOS_IOC_SET_MIN_CMD]      =3D ioctl_perf_qos_set_mi=
n,
> +               [PERF_QOS_IOC_GET_MAX_CMD]      =3D ioctl_perf_qos_get_ma=
x,
> +               [PERF_QOS_IOC_GET_MIN_CMD]      =3D ioctl_perf_qos_get_mi=
n,
> +               [PERF_QOS_IOC_GET_UNIT_CMD]     =3D ioctl_perf_qos_get_un=
it,
> +               [PERF_QOS_IOC_GET_LIMITS_CMD]   =3D ioctl_perf_qos_get_li=
mits,
> +       };
> +
> +       if (type !=3D PERF_QOS_IOCTL_TYPE)
> +               return -EINVAL;
> +
> +       if (cmd < 0 || cmd >=3D PERF_QOS_IOC_MAX_CMD)
> +               return -EINVAL;
> +
> +       if (dir & _IOC_WRITE) {
> +               if (copy_from_user(&pqia, (typeof(pqia) *)arg, sizeof(pqi=
a)))
> +                       return -EACCES;
> +       }
> +
> +       spin_lock(&pq->lock);
> +       ret =3D perf_qos_ioctl_ops[cmd](pq, pqd, &pqia);
> +       spin_unlock(&pq->lock);
> +
> +       if (ret)
> +               goto out;
> +
> +       if (dir & _IOC_READ) {
> +               if (copy_to_user((typeof(pqia) *)arg, &pqia, sizeof(pqia)=
))
> +                       return -EACCES;
> +       }
> +out:
> +       return ret;
> +}
> +
> +static const struct file_operations perf_qos_fops =3D {
> +       .owner          =3D THIS_MODULE,
> +       .open           =3D perf_qos_open,
> +       .release        =3D perf_qos_release,
> +       .unlocked_ioctl =3D perf_qos_ioctl,
> +#ifdef CONFIG_COMPAT
> +       .compat_ioctl   =3D perf_qos_ioctl,
> +#endif
> +};
> +

Missing kerneldoc.

> +void perf_qos_device_destroy(struct perf_qos *pq)
> +{
> +       idr_remove(&perf_qos_minors, MINOR(pq->perf_qos_cdev.dev));
> +       device_destroy(perf_qos_class, pq->perf_qos_cdev.dev);
> +       cdev_del(&pq->perf_qos_cdev);
> +       kfree(pq->descr);
> +       kfree(pq->ops);
> +       kfree(pq);
> +}
> +EXPORT_SYMBOL_GPL(perf_qos_device_destroy);
> +

Missing kerneldoc.

> +int perf_qos_is_allowed(struct perf_qos *pq, int performance)
> +{
> +       const struct perf_qos_constraint *first;
> +       int allowed =3D 1;
> +
> +       spin_lock(&pq->lock);
> +
> +       first =3D list_first_entry(&pq->perf_min, struct perf_qos_constra=
int, node);
> +       if (performance < first->soft_limit)
> +               allowed =3D 0;
> +
> +       first =3D list_first_entry(&pq->perf_max, struct perf_qos_constra=
int, node);
> +       if (performance > first->soft_limit)
> +               allowed =3D 0;
> +
> +       spin_unlock(&pq->lock);
> +
> +       return allowed;
> +}
> +EXPORT_SYMBOL_GPL(perf_qos_is_allowed);
> +

Missing kerneldoc.

> +struct perf_qos *perf_qos_device_create(const char *name,
> +                                       struct perf_qos_ops *ops,
> +                                       struct perf_qos_value_descr *desc=
r)
> +{
> +       struct device *dev;
> +       struct perf_qos *pq;
> +       dev_t devt;
> +       int minor;
> +       int ret;
> +
> +       if (!ops->set_perf_limit_max || !ops->set_perf_limit_min)
> +               return ERR_PTR(-EINVAL);
> +
> +       if (descr->unit < 0 || descr->unit >=3D PERF_QOS_UNIT_MAX)
> +               return ERR_PTR(-EINVAL);
> +
> +       if (descr->limit_min > descr->limit_max)
> +               return ERR_PTR(-EINVAL);
> +
> +       if (descr->unit =3D=3D PERF_QOS_UNIT_NORMAL) {
> +               if (descr->limit_min < 0 || descr->limit_max > 1024)
> +                       return ERR_PTR(-EINVAL);
> +       }
> +
> +       pq =3D kzalloc(sizeof(*pq), GFP_KERNEL);
> +       if (!pq)
> +               return ERR_PTR(-ENOMEM);
> +
> +       INIT_LIST_HEAD(&pq->perf_min);
> +       INIT_LIST_HEAD(&pq->perf_max);
> +       spin_lock_init(&pq->lock);
> +
> +       pq->ops =3D kmemdup(ops, sizeof(*ops), GFP_KERNEL);
> +       if (!pq->ops) {
> +               ret =3D -ENOMEM;
> +               goto out_kfree_pq;
> +       }
> +
> +       pq->descr =3D kmemdup(descr, sizeof(*descr), GFP_KERNEL);
> +       if (!pq->descr) {
> +               ret =3D -ENOMEM;
> +               goto out_kfree_pq_ops;
> +       }
> +
> +       minor =3D idr_alloc(&perf_qos_minors, pq, 0,
> +                         NUM_PERF_QOS_MINORS, GFP_KERNEL);
> +       if (minor < 0)
> +               goto out_kfree_pq_descr;
> +
> +       devt =3D MKDEV(MAJOR(perf_qos_devt), minor);
> +
> +       cdev_init(&pq->perf_qos_cdev, &perf_qos_fops);
> +
> +       ret =3D cdev_add(&pq->perf_qos_cdev, devt, 1);
> +       if (ret < 0)
> +               goto out_idr_remove;
> +
> +       dev =3D device_create(perf_qos_class, NULL, devt, NULL, name);
> +       if (IS_ERR(dev)) {
> +               ret =3D PTR_ERR(dev);
> +               goto out_cdev_del;
> +       }
> +
> +       return pq;
> +
> +out_cdev_del:
> +       cdev_del(&pq->perf_qos_cdev);
> +
> +out_idr_remove:
> +       idr_remove(&perf_qos_minors, minor);
> +
> +out_kfree_pq_descr:
> +       kfree(pq->descr);
> +
> +out_kfree_pq_ops:
> +       kfree(pq->ops);
> +
> +out_kfree_pq:
> +       kfree(pq);
> +
> +       return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(perf_qos_device_create);
> +
> +static char *perf_qos_devnode(const struct device *dev, umode_t *mode)
> +{
> +       return kasprintf(GFP_KERNEL, "%s/%s", DEVNAME, dev_name(dev));
> +}
> +
> +static int perf_qos_init(void)
> +{
> +       int ret;
> +
> +       ret =3D alloc_chrdev_region(&perf_qos_devt, 0,
> +                                 NUM_PERF_QOS_MINORS, DEVNAME);
> +       if (ret)
> +               return ret;
> +
> +       perf_qos_class =3D class_create(DEVNAME);
> +       if (IS_ERR(perf_qos_class)) {
> +               unregister_chrdev_region(perf_qos_devt, NUM_PERF_QOS_MINO=
RS);
> +               return PTR_ERR(perf_qos_class);
> +       }
> +       perf_qos_class->devnode =3D perf_qos_devnode;
> +
> +       return 0;
> +}
> +
> +subsys_initcall(perf_qos_init);
> --

