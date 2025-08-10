Return-Path: <linux-pm+bounces-32102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ADCB1FD10
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 01:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6AE3B8D67
	for <lists+linux-pm@lfdr.de>; Sun, 10 Aug 2025 23:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42C72561AB;
	Sun, 10 Aug 2025 23:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VJIcqH9P"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EF1157A72;
	Sun, 10 Aug 2025 23:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754868858; cv=none; b=hME52Dn5+QF5OB/rciwsfC1IfIJJuFXq50pncLxMZ6EPWLrAM6DisMrp4A7SxXjIvcwE3fKFux3EoAVYIvdS4eYqPu01X14HoGRasQ3ZmBxqBULgJBNBAMMQQ6rj6bR2BJDf9McdWY7pKVT3TA6jI8TRnitCtJnAiKq/6GvKR+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754868858; c=relaxed/simple;
	bh=fwBfeBD3BAKG1XdYGSZgUuboIl7CVDdrTtUVguEDnF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQnLgXx2xESh4+584K1v4wImAmZWkg4XfU4TjUPDmAJ4KPK4MvpqQ0p4bXAWBlZEd2w3NSUJnnGZvl8nWKKzy3dJxgwmEi8++AjycRWwLFgpBqukTsyma9i8MWujfOuj74HHqdURr5dF9e4n52uaPKEIdmGfAWlew5wmReDNhDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VJIcqH9P; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=khCMGdKVWJOOAKC9RC16vYgD/TuMBHFFGnJ3AsYFXDk=; b=VJIcqH9PCHJYfOHtv/7P7Cmwro
	RwuETCYMvdE3/IAMqQIrXX9zroFgaatvl+9XFshRGuWgzQuLpzSwUhgi0uZq08oo69Hb8Wr3d7yj3
	c+G5beHOSxD1K6cueQJO4SlyRtF3sG1jgRtgc3hpEb3IBWt9F5Y+Vwaj2cu0PAXHNZEcYtKeqZrg4
	8d8xt0Mcx8+OwlMX2U/T1ub2g1jO1RRBKM1zDNd/ltwcZHUZIvqOvYXl2SpqYQg05CRgnPGzURhit
	xQFWSwfuBeWdn/eI3ggVZvpw8NKEUF8zKzQjs+EC+1aTKdkCSkzm7x62iFPDV+F0Y0YpiIxcYQbCh
	LYnNYtUw==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ulFY3-00CW99-1e; Mon, 11 Aug 2025 01:33:56 +0200
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
	Changwoo Min <changwoo@igalia.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH RESEND v3 00/10] PM: EM: Add netlink support for the energy model.
Date: Mon, 11 Aug 2025 08:33:37 +0900
Message-ID: <20250810233347.81957-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just rebased on Linus's master and resend it for review.

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

CC: Lukasz Luba <lukasz.luba@arm.com>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Tejun Heo <tj@kernel.org>
Signed-off-by: Changwoo Min <changwoo@igalia.com>

Changwoo Min (10):
  PM: EM: Add em.yaml and autogen files.
  PM: EM: Add a skeleton code for netlink notification.
  PM: EM: Assign a unique ID when creating a performance domain.
  PM: EM: Expose the ID of a performance domain via debugfs.
  PM: EM: Add an iterator and accessor for the performance domain.
  PM: EM: Implement em_nl_get_pds_doit().
  PM: EM: Implement em_nl_get_pd_table_doit().
  PM: EM: Implement em_notify_pd_deleted().
  PM: EM: Implement em_notify_pd_created/updated().
  PM: EM: Notify an event when the performance domain changes.

 Documentation/netlink/specs/em.yaml | 113 ++++++++++
 MAINTAINERS                         |   3 +
 include/linux/energy_model.h        |  19 ++
 include/uapi/linux/energy_model.h   |  62 ++++++
 kernel/power/Makefile               |   5 +-
 kernel/power/em_netlink.c           | 311 ++++++++++++++++++++++++++++
 kernel/power/em_netlink.h           |  34 +++
 kernel/power/em_netlink_autogen.c   |  48 +++++
 kernel/power/em_netlink_autogen.h   |  23 ++
 kernel/power/energy_model.c         |  83 +++++++-
 10 files changed, 699 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/netlink/specs/em.yaml
 create mode 100644 include/uapi/linux/energy_model.h
 create mode 100644 kernel/power/em_netlink.c
 create mode 100644 kernel/power/em_netlink.h
 create mode 100644 kernel/power/em_netlink_autogen.c
 create mode 100644 kernel/power/em_netlink_autogen.h

-- 
2.50.1


