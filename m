Return-Path: <linux-pm+bounces-37886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E96AC54BB4
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 23:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17D574E0F75
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 22:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032282EA159;
	Wed, 12 Nov 2025 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQw2t12o"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC352E0418;
	Wed, 12 Nov 2025 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762987229; cv=none; b=HD07nSevCZgR3YDyBhTJG/PE70vG4nMezSbIE4B1OW+SazcM1Fdkg8XxHF7X6RBVZdwvHeojXxnIocbweIyb5af9Ju6V8jE4Ia/ZvsD8H3BEHn8/jfc6KEm1nOOzdE+x2Dzet0QtJYIWlmvMZMfKBBh5okwuE24/khaH+xWx+lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762987229; c=relaxed/simple;
	bh=s7rgWamhDP9TNGTpjEAdR/v/XV8sc372kYVkF6gK0Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e/CTH7oWt24jPidTe473S4/wrzEamJTclx+DHCMBtQlhBcVhsqzlt9u8fJi0gWQco4BcSlu9roO9bIgI2lD9kz2h7/MHYKGvZjDPLDyypXR/b9yHdu6KZiJ/ZMVoEQJyAtTY3lzYTA65dvk4zkpoRrQc+zEZFNGI2PWb5ZTvg3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQw2t12o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA2EC4CEF1;
	Wed, 12 Nov 2025 22:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762987229;
	bh=s7rgWamhDP9TNGTpjEAdR/v/XV8sc372kYVkF6gK0Ps=;
	h=From:To:Cc:Subject:Date:From;
	b=kQw2t12oYrBDLw7iE54TLNdRzWDCrmFPRJ0DgE3H/GS9Pmq6V9RKd8dfq/HYr6SCm
	 /UWgKPcaTLn5bCzukmqZA1KskMS7cU/hg6ALfczKwB50TUfufpn9fEXFCypI8zKDBn
	 E1N5kjoYe5ELKOHqWqKQKu19ZN3bzxUdGAmS5pUl2pDoEsrWkzPhNRZ2RCZSRitPiS
	 VrsZHYx5tsSi58CKnfaFuN9D6fl7FMnKmw5MoY6rK61tXtPyA9d2EpJ19YVyxBulRL
	 zXbtQg1aVPVlYiIPA4NHt//NmEONqwil5JXxCD0DLn/x0EqqlNY7ezMaFQN+usBr0I
	 NbzJOKwlDZXJQ==
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
Subject: [PATCH v10 0/3] Introduce and plumb PMSG_POWEROFF
Date: Wed, 12 Nov 2025 16:40:22 -0600
Message-ID: <20251112224025.2051702-1-superm1@kernel.org>
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

v10:
 * Drop resume_event changes
 * Drop patch 4 (will come in later phase)

Mario Limonciello (AMD) (3):
  PM: Introduce new PMSG_POWEROFF event
  scsi: Add PM_EVENT_POWEROFF into suspend callbacks
  usb: sl811-hcd: Add PM_EVENT_POWEROFF into suspend callbacks

 drivers/base/power/main.c    | 5 +++++
 drivers/scsi/mesh.c          | 1 +
 drivers/scsi/stex.c          | 1 +
 drivers/usb/host/sl811-hcd.c | 1 +
 include/linux/pm.h           | 3 +++
 include/trace/events/power.h | 3 ++-
 6 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.43.0


