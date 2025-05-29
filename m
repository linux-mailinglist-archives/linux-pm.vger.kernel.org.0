Return-Path: <linux-pm+bounces-27772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F89AC74D9
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 02:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00811BC0E16
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 00:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8297AD2FF;
	Thu, 29 May 2025 00:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DZt0xvdX"
X-Original-To: linux-pm@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDC0B67A;
	Thu, 29 May 2025 00:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748477631; cv=none; b=kJvI/ZXy3kOCmBW41PBRHv2kYje3+/YQ0S4GPC9M43wNJkSe69BCo7B+GYGwj3N1JyO3nW4t663H42d9OjGCeubhfrIsDN120U+ZjxUl7jBKRsB9FOr7bIWnPpIU2AnjxuqgJHumE9dG5HwSGQgilTP39ge8bTMjh+UpAH3u/tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748477631; c=relaxed/simple;
	bh=pfoihrmJaBwob8Uxd4IBwrStoIpAw40dXmyPLPV6VkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qwlw3SN3y0Q1CcQEcankv/SQLPVTMSVR4L1co3uGgy/xOzlyn7su76QWFVTdio5mEHUlingEW2bHYhonl8FjzW01CP/f1Up8Hd5ocXxhi/7/VoDD5WsQzUCDtj52pWubcAUGfSajiPA7aceQ9n/4QdvljcUMGRyegTlJWW5KB3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DZt0xvdX; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GAuvo8PIxtiaaRlvQH9XX/+Yf1c/3eZM6pxfqz02uJ0=; b=DZt0xvdX8CGGevbizc3aQo4yzr
	9BOZbNXdzve41rNDgGo0vulfXu3heM4ejeeWhqDSUKJ4HK37D5uJofAFt2znKciaNfRPew577gAZf
	Dut9UkQk6JJIgNlGoCJQVFPPjKmokWBS0xsw+mImO1Cvyv69XcMXk5DwaNyrp9GlOn66UsMzEBDQ7
	wQWIDa1j/e+BXJSmft32FOHEWcpx9uuVCPYT2ckycvlxfsYWsKi/X8M1b73ACUteCpwvDqmaVm5Ds
	cFeIZSNbHNM6QQS1/DE1JlYbzlmp60LvHlsf5PHCjQaODnMH8djqk90Z5oXpbd1236CvmvtSKHgCE
	lqPQRH2Q==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uKQti-00EZvY-05; Thu, 29 May 2025 02:13:27 +0200
From: Changwoo Min <changwoo@igalia.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org
Cc: christian.loehle@arm.com,
	tj@kernel.org,
	kernel-dev@igalia.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 00/11] PM: EM: Add netlink support for the energy model.
Date: Thu, 29 May 2025 09:13:04 +0900
Message-ID: <20250529001315.233492-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.49.0
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
  - EM_GENL_CMD_PD_GET_ID: Get the list of information for all performance domains.
  - EM_GENL_CMD_PD_GET_TBL: Get the energy model table of a performance domain.

Also, it supports three notification events:
  - EM_GENL_EVENT_PD_CREATE: When a performance domain is created.
  - EM_GENL_EVENT_PD_DELETE: When a performance domain is deleted.
  - EM_GENL_EVENT_PD_UPDATE: When the energy model table of a performance domain is updated.

The userspace code example using the EM netlink interface is at [3].

[1] https://lwn.net/Articles/922405/
[2] https://lore.kernel.org/lkml/a82423bc-8c38-4d57-93da-c4f20011cc92@arm.com/
[3] https://github.com/multics69/em-netlink/tree/patch-v1

CC: Lukasz Luba <lukasz.luba@arm.com>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Tejun Heo <tj@kernel.org>
Signed-off-by: Changwoo Min <changwoo@igalia.com>

Changwoo Min (11):
  PM: EM: Add ENERGY_MODEL_NETLINK Kconfig.
  PM: EM: Add a skeleton code for netlink notification.
  PM: EM: Initialize the netlink notification during booting.
  PM: EM: Add the infrastructure for command processing.
  PM: EM: Assign a unique ID when creating a performance domain.
  PM: EM: Expose the ID of a performance domain via debugfs.
  PM: EM: Add an iterator and accessor for the performance domain.
  PM: EM: Implement EM_GENL_CMD_PD_GET_ID.
  PM: EM: Implement EM_GENL_CMD_PD_GET_TBL.
  PM: EM: Implement event notification.
  PM: EM: Notify an event when the performance domain changes.

 include/linux/energy_model.h      |  20 +-
 include/uapi/linux/energy_model.h |  89 ++++++++
 kernel/power/Kconfig              |  10 +
 kernel/power/Makefile             |   1 +
 kernel/power/em_netlink.c         | 324 ++++++++++++++++++++++++++++++
 kernel/power/em_netlink.h         |  45 +++++
 kernel/power/energy_model.c       |  99 ++++++++-
 7 files changed, 586 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/linux/energy_model.h
 create mode 100644 kernel/power/em_netlink.c
 create mode 100644 kernel/power/em_netlink.h

-- 
2.49.0


