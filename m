Return-Path: <linux-pm+bounces-36592-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF03BBF7F8F
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 19:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B3854E343E
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 17:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C697F34B69C;
	Tue, 21 Oct 2025 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukGtqBiE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20473557F1
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761069150; cv=none; b=pUXFJbPKT/Ybhg5EgUFQiZx7Mf4UkZMdVPKI07f8JMOvt++8HqGfX+KlNddzKVW+Akq909vUhiCV6Tpo2cepmv/TApHV9fvhdqT2xkrtl/EWY0skN3ixN1fHp4gguo3ZwtA4antW3ryheH9JLAlOX1fXPLi3kLr0Zm30UHVxgAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761069150; c=relaxed/simple;
	bh=ndfCxg4M63xn2nqUZ2Ayh9FKf+NUQ5blADXKYxyxxf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hunOnfpzxMOfoe+6t5tjuGDvhD+/zl5kQHmLj7EAg7Z47jQ7yxAyjqwQCiPYr0BgU70eOxVkY7TUEuoo1pM+v32GbjOWe16HYpG7uZx/+0IYlKkOqMxH0l8C4zivG2KFgczvFDfzL6IU/QHVdlVRnsk7vSytKU3Opqb8E9TtlpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukGtqBiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CE5C116B1
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 17:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761069150;
	bh=ndfCxg4M63xn2nqUZ2Ayh9FKf+NUQ5blADXKYxyxxf4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ukGtqBiES93R3iz1DWMY1Pj9Y1eWR1jip8/DOJ9D9v2/2MgPFtWPncPoQPgcIjQYl
	 4XX3hmJS75XRzMIFjQGNGeohA4wTuVToDnFXMhwoqjT3dMa018BzbcfhPwCDxGKEA+
	 v9JOJsg9tuYODIQgDVSmFj2cx3Bh6aaKozxI7tiZDzOok+fq0SRZB8PDILnnIgT+dM
	 x6nfxmcb9vHMvoEFMCDUtS2FKQIJWso/BUhjTiWC9WK15CrF+FtzuoEbFrrp7/qKV8
	 UB1S/Goe1e0bBZYIqb0JFcOwuVCxiUWISlV6N9ZlCBbunnlgVmA/GtYRxLQvBEs7Td
	 gTxUdQbASInHw==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c284d4867eso1469565a34.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 10:52:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3GAnUsqViwEp9QHO+/4yemKuU14TYVvetLoMFHf9cxGJCAyKm8FyuvZ2Pn1PoI2HXEZqF3J8nOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOTvQ6sos7sPA0y0nInbY6rrMk2ZwzPnHdv3yKRqw0/m95TGCH
	yyWX2Gd/zZIsPhiWdPxjfLSbgUj5gvX9mPdeQk/HSxCQUFq4cgEv+lqVxZ98a3UaakozMQmhGr6
	I5pYn+z2DpbOncYa/5bfQOOcVdC5IkeY=
X-Google-Smtp-Source: AGHT+IGPKl3GQ9sdtZoYyLsrJBzwYizXgcnSpczdZWQwaAv3rUzoD9WeKdfE/wLYE6wyyaaHLp86bkCftKiteQeGZFk=
X-Received: by 2002:a05:6808:2444:b0:441:8f74:f48 with SMTP id
 5614622812f47-443a31bd4d4mr8372621b6e.66.1761069149581; Tue, 21 Oct 2025
 10:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020220914.320832-1-changwoo@igalia.com>
In-Reply-To: <20251020220914.320832-1-changwoo@igalia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Oct 2025 19:52:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jy3gztTTfR_UOv_yX5w9Uj2ZqEmhmNZ63WVnFHM2rRcw@mail.gmail.com>
X-Gm-Features: AS18NWCGY90SiFbX5qje6-fmqgpchXM6x_TukWYEclLqBmorwEojmFOe7VXcsV4
Message-ID: <CAJZ5v0jy3gztTTfR_UOv_yX5w9Uj2ZqEmhmNZ63WVnFHM2rRcw@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] PM: EM: Add netlink support for the energy model
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, len.brown@intel.com, 
	pavel@kernel.org, christian.loehle@arm.com, tj@kernel.org, 
	kernel-dev@igalia.com, linux-pm@vger.kernel.org, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 12:09=E2=80=AFAM Changwoo Min <changwoo@igalia.com>=
 wrote:
>
> Addressed all the comments from Lukasz and rebased the code to the head
> of the linus tree.
>
> There is a need to access the energy model from the userspace. One such
> example is the sched_ext schedulers [1]. The userspace part of the
> sched_ext schedules could feed the (post-processed) energy-model
> information to the BPF part of the scheduler.
>
> Currently, debugfs is the only way to read the energy model from userspac=
e;
> however, it lacks proper notification mechanisms when a performance domai=
n
> and its associated energy model change.
>
> This patch set introduces a generic netlink for the energy model, as
> discussed in [2]. It allows a userspace program to read the performance
> domain and its energy model. It notifies the userspace program when a
> performance domain is created or deleted or its energy model is updated
> through a multicast interface.
>
> Specifically, it supports two commands:
>   - EM_CMD_GET_PDS: Get the list of information for all performance
>     domains.
>   - EM_CMD_GET_PD_TABLE: Get the energy model table of a performance
>     domain.
>
> Also, it supports three notification events:
>   - EM_CMD_PD_CREATED: When a performance domain is created.
>   - EM_CMD_PD_DELETED: When a performance domain is deleted.
>   - EM_CMD_PD_UPDATED: When the energy model table of a performance domai=
n
>     is updated.
>
> This can be tested using the tool, tools/net/ynl/pyynl/cli.py, for exampl=
e,
> with the following commands:
>
>   $> tools/net/ynl/pyynl/cli.py \
>      --spec Documentation/netlink/specs/em.yaml \
>      --do get-pds
>   $> tools/net/ynl/pyynl/cli.py \
>      --spec Documentation/netlink/specs/em.yaml \
>      --do get-pd-table --json '{"pd-id": 0}'
>   $> tools/net/ynl/pyynl/cli.py \
>      --spec Documentation/netlink/specs/em.yaml \
>      --subscribe event  --sleep 10
>
> [1] https://lwn.net/Articles/922405/
> [2] https://lore.kernel.org/lkml/a82423bc-8c38-4d57-93da-c4f20011cc92@arm=
.com/
> [3] https://lore.kernel.org/lkml/202506140306.tuIoz8rN-lkp@intel.com/#t
>
> ChangeLog v5 -> v6:
>   - Fix two problems reported by the kernel test robot.
>   - Conditionally include the iterator/accessor code for the performance
>     domain when both CONFIG_ENERGY_MODEL and CONFIG_NET are set to avoid
>     the compilation errors (patch 5).
>   - Remove an unused variable, `ret`, in em_notify_pd_deleted() to avoid
>     a warning (patch 8).
>
> ChangeLog v4 -> v5:
>   - Rebase the code to the head of the linus tree.
>   - Remove the redundant em_check_capacity_update() call from
>     em_dev_register_pd_no_update().
>   - Move patch 3 ("PM: EM: Add an iterator and accessor for the
>     performance domain") after patch 5 ("PM: EM: Add a skeleton code for
>     netlink notification").
>   - Move the declaration of for_each_em_perf_domain() and
>     em_perf_domain_get_by_id() from energy_model.h to em_netlink.h.
>   - Fix a typo in patch 7 ("PM: EM: Implement
>     em_nl_get_pd_table_doit()") and change the variable declaration
>     order in em_nl_get_pd_table_doit() following the reverse Christmas
>     tree order.
>   - Remove the empty skeleton code of em_notify_pd_created/updated() from
>     patch 8 ("PM: EM: Implement em_notify_pd_deleted()") and introduce
>     them later where they are actually implemented.
>   - Change the return type of em_notify_pd_created/updated/deleted()
>     from int to void, since we don't check it anyway.
>
> ChangeLog v3 -> v4:
>   - Move patches [3-5] to the first.
>   - Remove the ending period (".") from all of the patch subjects.
>   - Rebase the code to v6.17-rc4.
>
> ChangeLog v2 -> v3:
>   - Properly initialize a return variable in
>     em_notify_pd_created/updated() at an error path (09/10), reported by
>     the kernel test robot [3].
>   - Remove redundant initialization of a return variable in
>     em_notify_pd_deleted() at an error path (08/10).
>
> ChangeLog v1 -> v2:
>   - Use YNL to generate boilerplate code. Overhaul the naming conventions
>     (command, event, notification, attribute) to follow the typical
>     conventions of other YNL-based netlink implementations.
>   - Calculate the exact message size instead of using NLMSG_GOODSIZE
>     when allocating a message (genlmsg_new). This avoids the reallocation
>     of a message.
>   - Remove an unnecessary function, em_netlink_exit(), and initialize the
>     netlink (em_netlink_init) at em_netlink.c without touching energy_mod=
el.c.
>
> Changwoo Min (10):
>   PM: EM: Assign a unique ID when creating a performance domain
>   PM: EM: Expose the ID of a performance domain via debugfs
>   PM: EM: Add em.yaml and autogen files
>   PM: EM: Add a skeleton code for netlink notification
>   PM: EM: Add an iterator and accessor for the performance domain
>   PM: EM: Implement em_nl_get_pds_doit()
>   PM: EM: Implement em_nl_get_pd_table_doit()
>   PM: EM: Implement em_notify_pd_deleted()
>   PM: EM: Implement em_notify_pd_created/updated()
>   PM: EM: Notify an event when the performance domain changes
>
>  Documentation/netlink/specs/em.yaml | 113 ++++++++++
>  MAINTAINERS                         |   3 +
>  include/linux/energy_model.h        |   4 +
>  include/uapi/linux/energy_model.h   |  62 ++++++
>  kernel/power/Makefile               |   5 +-
>  kernel/power/em_netlink.c           | 309 ++++++++++++++++++++++++++++
>  kernel/power/em_netlink.h           |  39 ++++
>  kernel/power/em_netlink_autogen.c   |  48 +++++
>  kernel/power/em_netlink_autogen.h   |  23 +++
>  kernel/power/energy_model.c         |  85 +++++++-
>  10 files changed, 689 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/netlink/specs/em.yaml
>  create mode 100644 include/uapi/linux/energy_model.h
>  create mode 100644 kernel/power/em_netlink.c
>  create mode 100644 kernel/power/em_netlink.h
>  create mode 100644 kernel/power/em_netlink_autogen.c
>  create mode 100644 kernel/power/em_netlink_autogen.h
>
> --

Is there any particular reason why you have not picked up the tags
received by the previous iteration?

