Return-Path: <linux-pm+bounces-30651-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A445B01061
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 02:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43AE54A2670
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 00:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CDC182D0;
	Fri, 11 Jul 2025 00:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gNosl8vv"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B22320F;
	Fri, 11 Jul 2025 00:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195215; cv=none; b=iGuNagbvjnU39McSvMv3O3ovtbh1281ltf7OSjFKou/12aUf9/zSFRDwbnwq05bAjJuJ28aC0ngBSODUohOuZYNS9XiY706PE55mj7FlETvnH2jNotVaRUDvW6caII+KIQv0bAWzjgjiQEdpSmxk2YbW6g72y53JapUH5ufOtW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195215; c=relaxed/simple;
	bh=Slj8ovwrtJoxHMJtyZwD5KGnAhVL7zfKcsAIKbM231o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jb6EDndASvyz/NYpHlkPZ4cyzvzjuDwPALo1mxNIL9bcLJbgVCEh3zjUAN3DNJdhDGIt3waAfrlNNzF8hSyp0qvsIC6t74ahujhgrnaDWrdMIsmqsD50pHKaHELSU3q2GxrsZ44Bclf62IQX10E613ti2D05+cjtmfY8P6QGSFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gNosl8vv; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LRnv8m5dG+/sfazhZsc0JD2Xbfv61sfuQUBJUodIOKE=; b=gNosl8vv0l2/tfjpG2uwbMM/j0
	qHKyquDGPnIrohfl3teA0Ntk1cuW66Sxq2BhG6EEZH38v0IbwOTNaPwhkloxlnSezLIEETKm+peHw
	GqLI0l+NMMM8J/W9NlmBFXf+YlHZW9B8Y2C+wg40XOpsPkKZxKNcWE99PRjCgcs3QlKFvM7o4cWfo
	87QMJ7UQkJ0IW3Hh2kpi9I23995pZV984RJdZDiVS0p5tEUSe1tKboWWj30bi5NP+0GQRfW1Srvpj
	OT7ezG2s8OyyERrVYFr2Hq7rMdZ4hEbqj3QOkid0O/+iO1C6HAhU3n1DcK4inEugkALgTf5aX0RYz
	TudC095g==;
Received: from [59.10.240.225] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ua20t-00FAmH-MU; Fri, 11 Jul 2025 02:53:20 +0200
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
Subject: [PATCH v3 0/10] PM: EM: Add netlink support for the energy model.
Date: Fri, 11 Jul 2025 09:53:00 +0900
Message-ID: <20250711005310.20740-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 kernel/power/em_netlink.c           | 309 ++++++++++++++++++++++++++++
 kernel/power/em_netlink.h           |  34 +++
 kernel/power/em_netlink_autogen.c   |  48 +++++
 kernel/power/em_netlink_autogen.h   |  23 +++
 kernel/power/energy_model.c         |  83 +++++++-
 10 files changed, 697 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/netlink/specs/em.yaml
 create mode 100644 include/uapi/linux/energy_model.h
 create mode 100644 kernel/power/em_netlink.c
 create mode 100644 kernel/power/em_netlink.h
 create mode 100644 kernel/power/em_netlink_autogen.c
 create mode 100644 kernel/power/em_netlink_autogen.h

-- 
2.50.0


