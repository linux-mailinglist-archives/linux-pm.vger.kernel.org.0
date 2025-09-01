Return-Path: <linux-pm+bounces-33494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A09B3D669
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 04:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64E83B8972
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 02:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8C1202F9C;
	Mon,  1 Sep 2025 02:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="d1Jb4qng"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C824594A;
	Mon,  1 Sep 2025 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692038; cv=none; b=bpThQ6teSFIvw4bAOExuM2A8mfgYuHabzJ6u/3sF7Sc9kHGt5XfZ8HuxGo27mR6bl30AhB4Sb5YUv68ctSjkutGDi2mxvoRZVBe7SBHcK7G15hp2JIqbJzdAb5e27HHSFSbd9jDXPE+N8JJ5mkUT6wj/4iqdfFr75pHct4FPemk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692038; c=relaxed/simple;
	bh=nRRnwR58Lb8s7xVey++Zi2Gf24x6aenEUr/+NLJMfXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pb8SZ4PT09qxQGLdMK7bmTXDSavLe6T7Gtn38GB2cMLFkvm349NVtl7jBps/EOYfPJz8WONyrjkjLuZmg3yRHMB+6zR3bDQuHN3Oohr3svaU1BfZxd97hwRp7geNpw/oFW5IN8zHSxtI8klaxbxxgZFgn+UEANT94i99m3gU75o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=d1Jb4qng; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dfC/sbPqzBxAF4dHy41NI9u7OtAgW89rbIODyM5kWuM=; b=d1Jb4qngJcb6xzn3L35lsY4+iW
	gx+HIlYdtXk1C1dkeV8xqwzb+tyEQ9lJvJ49oE+iZL9UI25o6UMsZFcRo51SvVJQIgfmjoqwia+3n
	bzrPwVEIfRbMi6dTtpIGXHU69ff+5pq2uCsb8Z2No9QwirsiCg7nDP3s4/TapC5bX3Rbzv96Hghsq
	kzkWBhAuyhStNmBafPhdO+7E9OUnIQx9o/RvvfmbQSKgF3r0h7LY3rO9FpwKtvJ35Ky3LKbm8CKGE
	eMvoIDitG1nE/tAj2Jn0ng3NrZlxZKpZvDw0zNyVeBjjy2exOeP7k3yhMmN0yE2DpsMXTEKOTtPse
	Zw06Zrmw==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ustq7-0054TK-QA; Mon, 01 Sep 2025 04:00:13 +0200
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
Subject: [PATCH v4 00/10] PM: EM: Add netlink support for the energy model.
Date: Mon,  1 Sep 2025 10:59:53 +0900
Message-ID: <20250901020003.86415-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Addressed all of Rafael's feedback and rebased to v6.17-rc4.

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
  PM: EM: Add an iterator and accessor for the performance domain
  PM: EM: Add em.yaml and autogen files
  PM: EM: Add a skeleton code for netlink notification
  PM: EM: Implement em_nl_get_pds_doit()
  PM: EM: Implement em_nl_get_pd_table_doit()
  PM: EM: Implement em_notify_pd_deleted()
  PM: EM: Implement em_notify_pd_created/updated()
  PM: EM: Notify an event when the performance domain changes

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
2.51.0


