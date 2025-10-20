Return-Path: <linux-pm+bounces-36523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4E5BF3D48
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 00:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2FFED350080
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 22:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE5D2EF677;
	Mon, 20 Oct 2025 22:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KN46Cddf"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB3C1EDA3C;
	Mon, 20 Oct 2025 22:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760998176; cv=none; b=pcSw64/LJ8xGfWV7OVIXidqJSArUwInWiz4JaaYyMyh7MrXppKqQNPYfPHLjCq6AhQ+fxHJ+gXQHR+dtKr0gzN0wjF4Yb83zBwkjZjDl1aSBbt+mDXGPIRzqELRCGywpUAASDXwtkcnXd9Tv1aH5mixZBs5oRWvQmgcG7hWYV8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760998176; c=relaxed/simple;
	bh=BaAQfwR7hnH39Re+w1xoI7JlwBZnbgG3v+okkJt2oLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJpDSyKGKKzv5Dto3LEZk77+pMGLJaK5QlTwm1QFvV9z+d0Oi5n7KxyfaZO5rWLTnnlF8wCrb/YMfV4OVaop641E9Vs1DoYL4CtuBZIerOl8b5bP8fFAx0pRe64sAthbM8UpYx1MKl54YOorBHe1bws5KugC6N2s8sQlChyLh54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KN46Cddf; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hmGZIc4OcZcwXFs14bVJjp426YqngqKJft4i67JF6J4=; b=KN46Cddfsxbxx4ptkXd3IlJ10t
	pGgrL32AUVDk9PXHZ6cB2qcBIWcDVxclcGLiLWvzz0ObioKOqBRaILTuz1yS4dncZV7GBJ0/2S+da
	QQeR8G2R1eD8leOVeSoESJ4AR9uBRMigPtbtHcNsQp+LMor3c9uoARlW5xvaFb7e27XkJ4JZ0m9Fz
	Vy8HpEDSZaRH/Lu1czda8d9N5DRNAtX0Okj0m4522a03p6kdTrd2oPSLqV1Opt8KNEuFnY3rQVB6g
	/p8Qr7PEj+XActQ7ZaQDa1CYfGG5s3gz1wv+idnw5szN7AKyBpxYn2ADeakVpyIQN3z4KsfVjrW0i
	6ug+BLWg==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vAy48-00CHWW-TF; Tue, 21 Oct 2025 00:09:22 +0200
From: Changwoo Min <changwoo@igalia.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: christian.loehle@arm.com,
	tj@kernel.org,
	kernel-dev@igalia.com,
	linux-pm@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH v6 00/10] PM: EM: Add netlink support for the energy model
Date: Tue, 21 Oct 2025 07:09:04 +0900
Message-ID: <20251020220914.320832-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Addressed all the comments from Lukasz and rebased the code to the head
of the linus tree.

There is a need to access the energy model from the userspace. One such
example is the sched_ext schedulers [1]. The userspace part of the
sched_ext schedules could feed the (post-processed) energy-model
information to the BPF part of the scheduler.

Currently, debugfs is the only way to read the energy model from userspace;
however, it lacks proper notification mechanisms when a performance domain
and its associated energy model change.

This patch set introduces a generic netlink for the energy model, as
discussed in [2]. It allows a userspace program to read the performance
domain and its energy model. It notifies the userspace program when a
performance domain is created or deleted or its energy model is updated
through a multicast interface.

Specifically, it supports two commands:
  - EM_CMD_GET_PDS: Get the list of information for all performance
    domains.
  - EM_CMD_GET_PD_TABLE: Get the energy model table of a performance
    domain.

Also, it supports three notification events:
  - EM_CMD_PD_CREATED: When a performance domain is created.
  - EM_CMD_PD_DELETED: When a performance domain is deleted.
  - EM_CMD_PD_UPDATED: When the energy model table of a performance domain
    is updated.

This can be tested using the tool, tools/net/ynl/pyynl/cli.py, for example,
with the following commands:

  $> tools/net/ynl/pyynl/cli.py \
     --spec Documentation/netlink/specs/em.yaml \
     --do get-pds
  $> tools/net/ynl/pyynl/cli.py \
     --spec Documentation/netlink/specs/em.yaml \
     --do get-pd-table --json '{"pd-id": 0}'
  $> tools/net/ynl/pyynl/cli.py \
     --spec Documentation/netlink/specs/em.yaml \
     --subscribe event  --sleep 10

[1] https://lwn.net/Articles/922405/
[2] https://lore.kernel.org/lkml/a82423bc-8c38-4d57-93da-c4f20011cc92@arm.com/
[3] https://lore.kernel.org/lkml/202506140306.tuIoz8rN-lkp@intel.com/#t

ChangeLog v5 -> v6:
  - Fix two problems reported by the kernel test robot.
  - Conditionally include the iterator/accessor code for the performance
    domain when both CONFIG_ENERGY_MODEL and CONFIG_NET are set to avoid
    the compilation errors (patch 5).
  - Remove an unused variable, `ret`, in em_notify_pd_deleted() to avoid
    a warning (patch 8).

ChangeLog v4 -> v5:
  - Rebase the code to the head of the linus tree.
  - Remove the redundant em_check_capacity_update() call from
    em_dev_register_pd_no_update().
  - Move patch 3 ("PM: EM: Add an iterator and accessor for the
    performance domain") after patch 5 ("PM: EM: Add a skeleton code for
    netlink notification").
  - Move the declaration of for_each_em_perf_domain() and
    em_perf_domain_get_by_id() from energy_model.h to em_netlink.h.
  - Fix a typo in patch 7 ("PM: EM: Implement
    em_nl_get_pd_table_doit()") and change the variable declaration
    order in em_nl_get_pd_table_doit() following the reverse Christmas
    tree order.
  - Remove the empty skeleton code of em_notify_pd_created/updated() from
    patch 8 ("PM: EM: Implement em_notify_pd_deleted()") and introduce
    them later where they are actually implemented.
  - Change the return type of em_notify_pd_created/updated/deleted()
    from int to void, since we don't check it anyway.

ChangeLog v3 -> v4:
  - Move patches [3-5] to the first.
  - Remove the ending period (".") from all of the patch subjects.
  - Rebase the code to v6.17-rc4.

ChangeLog v2 -> v3:
  - Properly initialize a return variable in
    em_notify_pd_created/updated() at an error path (09/10), reported by
    the kernel test robot [3].
  - Remove redundant initialization of a return variable in
    em_notify_pd_deleted() at an error path (08/10).

ChangeLog v1 -> v2:
  - Use YNL to generate boilerplate code. Overhaul the naming conventions
    (command, event, notification, attribute) to follow the typical
    conventions of other YNL-based netlink implementations.
  - Calculate the exact message size instead of using NLMSG_GOODSIZE
    when allocating a message (genlmsg_new). This avoids the reallocation
    of a message.
  - Remove an unnecessary function, em_netlink_exit(), and initialize the
    netlink (em_netlink_init) at em_netlink.c without touching energy_model.c.

Changwoo Min (10):
  PM: EM: Assign a unique ID when creating a performance domain
  PM: EM: Expose the ID of a performance domain via debugfs
  PM: EM: Add em.yaml and autogen files
  PM: EM: Add a skeleton code for netlink notification
  PM: EM: Add an iterator and accessor for the performance domain
  PM: EM: Implement em_nl_get_pds_doit()
  PM: EM: Implement em_nl_get_pd_table_doit()
  PM: EM: Implement em_notify_pd_deleted()
  PM: EM: Implement em_notify_pd_created/updated()
  PM: EM: Notify an event when the performance domain changes

 Documentation/netlink/specs/em.yaml | 113 ++++++++++
 MAINTAINERS                         |   3 +
 include/linux/energy_model.h        |   4 +
 include/uapi/linux/energy_model.h   |  62 ++++++
 kernel/power/Makefile               |   5 +-
 kernel/power/em_netlink.c           | 309 ++++++++++++++++++++++++++++
 kernel/power/em_netlink.h           |  39 ++++
 kernel/power/em_netlink_autogen.c   |  48 +++++
 kernel/power/em_netlink_autogen.h   |  23 +++
 kernel/power/energy_model.c         |  85 +++++++-
 10 files changed, 689 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/netlink/specs/em.yaml
 create mode 100644 include/uapi/linux/energy_model.h
 create mode 100644 kernel/power/em_netlink.c
 create mode 100644 kernel/power/em_netlink.h
 create mode 100644 kernel/power/em_netlink_autogen.c
 create mode 100644 kernel/power/em_netlink_autogen.h

-- 
2.51.1.dirty


