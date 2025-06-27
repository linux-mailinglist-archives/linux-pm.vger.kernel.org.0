Return-Path: <linux-pm+bounces-29629-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECA9AEAD59
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 05:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D529189A224
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 03:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025A2199252;
	Fri, 27 Jun 2025 03:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ovGvLsNg"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2E318FDA5;
	Fri, 27 Jun 2025 03:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750995488; cv=none; b=S/YYglB4i5JbAm8ZNmOh+rKYchO2L6mfFDwjP6cJ8+D2MOxeAYUhOJo0QQ8V6uNsldTpm1aB5Q8UJsjjvZlxNQVq10b6pqhAtsP6k5DEBqO05bhKtQQED+EBN8ehsnVWw4UfvA17tg5n7HIq5vgQDU3u8mqXEa/6KEfRBE1H0F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750995488; c=relaxed/simple;
	bh=vIwQvESFQL3sMXcIqPq2w/7GLahXqsMOC7GJdypTPcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjmbSJCxvjZT149SDRp8a7diIlT8J7tsmm3B/U/SKrvSUNKtDnjukAsYKhP/e5U4f4vyRMUf6b9L0Pni42RVsj3wb30gnmx8H/oqg9zwZqau0hpfIS/xffJ0WwdiVqH899iDFa9uPcd8hJx5bs21dLmHOqzZr4+oTdhMxLuxz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ovGvLsNg; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3z7DVek5PQALlWeukz2QC/IvVFBYSVxtsPML/WlhtTc=; b=ovGvLsNgeLeELIVOWqnyuqLgem
	5ACWK/SyHp8pGnrZ7UdrOQJ1R8Sx9STUfSsMfFCke5Qydpyt+c6psDYp5hLxecnqyVOfS/Plo6H5d
	4pFYDZfHNQm/6BmUsLfDkIo6EzuN+iw9BLH5idYK+rBIoaqjBe+vPInN77q1565BBqbJQtbBwOohf
	FJ7eum8bX2oZ6J/C5php6h5rQ1cWhrN1+lZPp08215+z/8a7v0nx/cg+c9DZHiODl+Mldw7hAk2Xp
	riHkSnhUPHQJuHKUxEOSFfdzD/nuwwNVY66dnqGq+VDbdTTBzP2Sl5e+G2bg0ZbvuuXH7uTSeLCxD
	Qf323JUA==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uUzuS-009EpM-BY; Fri, 27 Jun 2025 05:37:52 +0200
Message-ID: <b74f6484-dd16-430a-bad9-4dca6384d1dc@igalia.com>
Date: Fri, 27 Jun 2025 12:37:45 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] PM: EM: Add netlink support for the energy
 model.
To: lukasz.luba@arm.com, rafael@kernel.org, len.brown@intel.com,
 pavel@kernel.org
Cc: christian.loehle@arm.com, tj@kernel.org, kernel-dev@igalia.com,
 linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>
References: <20250613094428.267791-1-changwoo@igalia.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20250613094428.267791-1-changwoo@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Gentle ping as it reaches 2-weeks.

@Lukasz, @Rafael -- I have a question related to the energy model
in general. As far as I understand, the energy model describes
the performance-energy consumption tradeoff when a single CPU in
a performance domain is running. However, in reality, SoCs may
have thermal constraints, which would result in additional
constraints. For example, running all CPUs with the highest
frequency may not be possible. My question is this: does kernel
maintain and use such (thermal?) constraints?

Regards,
Changwoo Min

On 6/13/25 18:44, Changwoo Min wrote:
> There is a need to access the energy model from the userspace. One such
> example is the sched_ext schedulers [1]. The userspace part of the
> sched_ext schedules could feed the (post-processed) energy-model
> information to the BPF part of the scheduler.
> 
> Currently, debugfs is the only way to read the energy model from userspace;
> however, it lacks proper notification mechanisms when a performance domain
> and its associated energy model change.
> 
> This patch set introduces a generic netlink for the energy model, as
> discussed in [2]. It allows a userspace program to read the performance
> domain and its energy model. It notifies the userspace program when a
> performance domain is created or deleted or its energy model is updated
> through a multicast interface.
> 
> Specifically, it supports two commands:
>    - EM_CMD_GET_PDS: Get the list of information for all performance
>      domains.
>    - EM_CMD_GET_PD_TABLE: Get the energy model table of a performance
>      domain.
> 
> Also, it supports three notification events:
>    - EM_CMD_PD_CREATED: When a performance domain is created.
>    - EM_CMD_PD_DELETED: When a performance domain is deleted.
>    - EM_CMD_PD_UPDATED: When the energy model table of a performance domain
>      is updated.
> 
> This can be tested using the tool, tools/net/ynl/pyynl/cli.py, for example,
> with the following commands:
> 
>    $> tools/net/ynl/pyynl/cli.py \
>       --spec Documentation/netlink/specs/em.yaml \
>       --do get-pds
>    $> tools/net/ynl/pyynl/cli.py \
>       --spec Documentation/netlink/specs/em.yaml \
>       --do get-pd-table --json '{"pd-id": 0}'
>    $> tools/net/ynl/pyynl/cli.py \
>       --spec Documentation/netlink/specs/em.yaml \
>       --subscribe event  --sleep 10
> 
> [1] https://lwn.net/Articles/922405/
> [2] https://lore.kernel.org/lkml/a82423bc-8c38-4d57-93da-c4f20011cc92@arm.com/
> 
> ChangeLog v1 -> v2:
>    - Use YNL to generate boilerplate code. Overhaul the naming conventions
>      (command, event, notification, attribute) to follow the typical
>      conventions of other YNL-based netlink implementations.
>    - Calculate the exact message size instead of using NLMSG_GOODSIZE
>      when allocating a message (genlmsg_new). This avoids the reallocation
>      of a message.
>    - Remove an unnecessary function, em_netlink_exit(), and initialize the
>      netlink (em_netlink_init) at em_netlink.c without touching energy_model.c.
> 
> CC: Lukasz Luba <lukasz.luba@arm.com>
> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> CC: Tejun Heo <tj@kernel.org>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> 
> Changwoo Min (10):
>    PM: EM: Add em.yaml and autogen files.
>    PM: EM: Add a skeleton code for netlink notification.
>    PM: EM: Assign a unique ID when creating a performance domain.
>    PM: EM: Expose the ID of a performance domain via debugfs.
>    PM: EM: Add an iterator and accessor for the performance domain.
>    PM: EM: Implement em_nl_get_pds_doit().
>    PM: EM: Implement em_nl_get_pd_table_doit().
>    PM: EM: Implement em_notify_pd_deleted().
>    PM: EM: Implement em_notify_pd_created/updated().
>    PM: EM: Notify an event when the performance domain changes.
> 
>   Documentation/netlink/specs/em.yaml | 113 ++++++++++
>   MAINTAINERS                         |   3 +
>   include/linux/energy_model.h        |  19 ++
>   include/uapi/linux/energy_model.h   |  62 ++++++
>   kernel/power/Makefile               |   5 +-
>   kernel/power/em_netlink.c           | 311 ++++++++++++++++++++++++++++
>   kernel/power/em_netlink.h           |  34 +++
>   kernel/power/em_netlink_autogen.c   |  48 +++++
>   kernel/power/em_netlink_autogen.h   |  23 ++
>   kernel/power/energy_model.c         |  83 +++++++-
>   10 files changed, 699 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/netlink/specs/em.yaml
>   create mode 100644 include/uapi/linux/energy_model.h
>   create mode 100644 kernel/power/em_netlink.c
>   create mode 100644 kernel/power/em_netlink.h
>   create mode 100644 kernel/power/em_netlink_autogen.c
>   create mode 100644 kernel/power/em_netlink_autogen.h
> 

