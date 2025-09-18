Return-Path: <linux-pm+bounces-34937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5554FB82C95
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 05:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D9B2A5469
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 03:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B996E244679;
	Thu, 18 Sep 2025 03:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAbxWxUD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8768223CF12;
	Thu, 18 Sep 2025 03:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758167106; cv=none; b=VFfIhgpSH+AO2fFY0gPyG0PDqjkmPWfFoTtELKcSSFtVXEGB9MlUL3ejslIT9tGHShAAkEJYkHuP93Iv6u9gznrXiB24bt8EgtNfGvQ3ONI2LqLZA6tZBNA3ID/NPzOoVhkGl+aUOngKKRYr/91nVeDkzMldOHw7rMQ79kAv29Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758167106; c=relaxed/simple;
	bh=m7rgZLpeSgEmveLrF8Ska/jFP1xW3PKkJJXRlRl9hps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WzH/icEhjSme6zHQhaasXKL0nmomRoGNwXt0GsB0DPC6Af9eXiQp1kukfZt2qBAgZzaY7PD3xldiDGgxQnfB9QCo+K6WQnfxtd6gEIgnb5JPc8fMVc200OBOLtvlrsStUlnerSmM0jrp1wj+su0AowptB1f8RPM5wBnDTgoeF9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAbxWxUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10E9C4CEE7;
	Thu, 18 Sep 2025 03:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758167106;
	bh=m7rgZLpeSgEmveLrF8Ska/jFP1xW3PKkJJXRlRl9hps=;
	h=From:To:Cc:Subject:Date:From;
	b=DAbxWxUDg6CUED38KOp4D3IqP0/F6J37xhZ0HzMw9eX7hXyrKGvn9NFV6OZZgu06j
	 n3/Wt2tP47pRw6qx83iEV55dgbuf+bXOcFwTwGD+d4ZIjelbK1MIygk6tDwY8hzsGN
	 qYQUcRTVPfJtreH1TXFIxtC7WdUso5sq+AP5ebRDo7/wW2Wrm6TndkowXKIuJ6Ajfu
	 nKZvDAmhpSjQSsJ3rMjUBDcO8TOjMblAVuqjlePYJNwNrRqPA6/81I+VLBTiNIKTiB
	 hJwrOgp5t1n6Ub2o0Zc1OYXG7HevVAPkl0YEMY0+ydy1uBv+8ZiLByG+ebwC6N8xFF
	 ZQ7JuZXeC9QMQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Merthan=20Karaka=C5=9F?= <m3rthn.k@gmail.com>,
	Eric Naim <dnaim@cachyos.org>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v8 0/4] Introduce and plumb PMSG_POWEROFF
Date: Wed, 17 Sep 2025 22:44:23 -0500
Message-ID: <20250918034427.3226217-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've been working on a series that uses the hibernate flows (S4)
during shutdown (S5) [1], but it's a bit risky because it has changes
all around the kernel.  To mitigate risk Rafael suggested [2] to split
the series into 3 parts across different kernel cycles.

Here is the first part, which just introduces a PMSG_POWEROFF event
and uses it in any driver that manipulates PM events.

There are no functional changes for these changes and this series is
intended for 6.18.

Link: https://lore.kernel.org/linux-pm/20250909191619.2580169-1-superm1@kernel.org/ [1]
Link: https://lore.kernel.org/linux-pm/CAJZ5v0jHKp7c7dSQMZr5tmQOV6=fHOygTf-YG6Gx9YmurA9cTA@mail.gmail.com/ [2]
Mario Limonciello (AMD) (4):
  PM: Introduce new PMSG_POWEROFF event
  scsi: Add PM_EVENT_POWEROFF into suspend callbacks
  usb: sl811-hcd: Add PM_EVENT_POWEROFF into suspend callbacks
  USB: Pass PMSG_POWEROFF event to suspend_common()

 drivers/base/power/main.c    |  7 +++++++
 drivers/scsi/mesh.c          |  1 +
 drivers/scsi/stex.c          |  1 +
 drivers/usb/core/hcd-pci.c   | 11 ++++++++++-
 drivers/usb/host/sl811-hcd.c |  1 +
 include/linux/pm.h           |  3 +++
 include/trace/events/power.h |  3 ++-
 7 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.51.0


