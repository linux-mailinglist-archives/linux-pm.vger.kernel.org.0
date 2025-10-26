Return-Path: <linux-pm+bounces-36832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DE2C0A2C8
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 06:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D4D3A9D15
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 05:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A454B238C0A;
	Sun, 26 Oct 2025 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIvihrQ8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DD61F418F;
	Sun, 26 Oct 2025 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761455353; cv=none; b=CKOQVzMuoka+aIr3d+Wk0COQO9cMBb8LUbqdyrnSVJ5Z3pYvLWBq/5nreNVXFUO3lpFZkuC86JkNZ1vF7FW3HgJIc1kt0CSycVwXwTdqN6YmxOwcZPJLxCvGnJ7Z4w77vQWQc+atwGIZMgMU39X24m8V2JE+ZDjyPIK5ejfruss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761455353; c=relaxed/simple;
	bh=p0DuC0Tv4/qRF1AukIaOZxQa1x0y6FnUMyajKVqm+l0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qws13x42TSyUKObRZXdSJZXNFdCduDX56hjpBQii7ojeCvVBZpFZxK0lkQQ8lD7Sx1uz8iQkAkUcqp2CT1Lhay9cCpmgYyGtEfXz+SmF34kwKXDAM3upniZ19KYOeddHUiCUm1h4T7VPs86L4ilsdIuh5OIQwn06CWZ4DPz4FQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIvihrQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C95C4CEE7;
	Sun, 26 Oct 2025 05:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761455353;
	bh=p0DuC0Tv4/qRF1AukIaOZxQa1x0y6FnUMyajKVqm+l0=;
	h=From:To:Cc:Subject:Date:From;
	b=SIvihrQ8DoupRFx57SA2hauQ11QW1jeh5RROBf3c7kz4sEF35cRCnct1c6ufDSqCR
	 85e3SEDwoNIZ3igCU+e0TVPBokqILeHNVvdNSRW9wTuPmyHQ+ADgOUS4RlU6sQlSDp
	 pqX0yccXHGjNmB+xP8DA/YqwY4xM/GPd+jJ16GQ5uCBwI0lHxCWG6wMRup+p0j+Bsq
	 4CZslaawJ+8Sms4cmzY4K6YEJLUHuUGgQGu5aK3kviB5odB2YKYJex0C184zi/1D0q
	 N0a3/V9J1poGhOfumTEFS0KC8eMjhjcMgUrvOh4jsXokd4r5p/Z2KjwqRkPxpAahtk
	 WTSerqiv+K4gg==
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
Subject: [PATCH v9 0/4] Introduce and plumb PMSG_POWEROFF
Date: Sun, 26 Oct 2025 00:09:01 -0500
Message-ID: <20251026050905.764203-1-superm1@kernel.org>
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
the series into at least 3 parts across different kernel cycles.

Here is the first part, which just introduces a PMSG_POWEROFF event
and uses it in any driver that manipulates PM events.

There are no functional changes for these changes and this series is
intended for 6.19.

v8->v9:
 * Reword commit messages (Bjorn)
 * Apply on top of 6.18-rc2 kernel base

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
2.43.0


