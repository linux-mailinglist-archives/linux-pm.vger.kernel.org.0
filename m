Return-Path: <linux-pm+bounces-37888-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5A5C54BC0
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 23:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CD894E25C0
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 22:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936E32EDD50;
	Wed, 12 Nov 2025 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo9CTLJZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6687A2D5C95;
	Wed, 12 Nov 2025 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762987233; cv=none; b=J5jgXpfwxPSWT9UR63X9kmNSnbYaG/vx7AxHWqUK0cFGfQKTu0aFyfCyaSkZqhLJH8mkLKJASFBiz5ZG/2gF9DninoB86NuarvMuYGxuX1dDx7XV02Hes2VyZFkyru6/596FW6PzaSWgrDZXptt+rDSkiRalTjKeV3+rCgJlKHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762987233; c=relaxed/simple;
	bh=TVs0vUZVTSOg5CHpZtKPVlZs3JbBKuZNRNrFsZsyCdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4MUqXfEh6xjEUsxuStw4w7vw3luudON89CK45FdApQ6ArWfu4nx2rE/GlhW2qWU/j8m44IpZL9kSELwRBLjMJ29XaZxPxksaJBKLZ0dGisCLRUgCfY9d3fQEOxjfrRitW/qwQVjQdmIQjXZfFMv575XW+crQ0nT3spGOH/crLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo9CTLJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC46C2BCAF;
	Wed, 12 Nov 2025 22:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762987233;
	bh=TVs0vUZVTSOg5CHpZtKPVlZs3JbBKuZNRNrFsZsyCdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xo9CTLJZB/ai0VmTZNRGOk/vLDulLRGnAfXQa2msqKIs0eWM5B/IFcuU2Jh/t+ECl
	 gxNbK9OEZGLOi6LdoCc9HzRTIbR6QNVX2N3BQMrBA74VPA/3LZ8LS95oCRiM3ApBmP
	 EgbSFksF/5LJDmAxH6zv2bDOhm73qHsTP3kBgWXH8woTA9mBK3EbQPuem2kE+56+pE
	 TgUdN/LO7R90BC/apNwbg8OAIaVPTTV0C/XeiWK0WikQcXLS0cutSGRjnI8PcKxgAu
	 KJkgQ4piTtMu5UFjIM1P1/gBnrDcy/XO1XOd/MPDSvCx4kdAE1+0nRa8GPP0fmArIj
	 AYgmdGv1Vy5cw==
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
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v10 2/3] scsi: Add PM_EVENT_POWEROFF into suspend callbacks
Date: Wed, 12 Nov 2025 16:40:24 -0600
Message-ID: <20251112224025.2051702-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112224025.2051702-1-superm1@kernel.org>
References: <20251112224025.2051702-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the PM core uses hibernation callbacks for powering off the
system, drivers will receive PM_EVENT_POWEROFF and should handle
it the same as they previously handled PM_EVENT_HIBERNATE.

Support this case in the scsi driver.  No functional changes.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/scsi/mesh.c | 1 +
 drivers/scsi/stex.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/scsi/mesh.c b/drivers/scsi/mesh.c
index 1c15cac41d805..768b85eecc8fd 100644
--- a/drivers/scsi/mesh.c
+++ b/drivers/scsi/mesh.c
@@ -1762,6 +1762,7 @@ static int mesh_suspend(struct macio_dev *mdev, pm_message_t mesg)
 	case PM_EVENT_SUSPEND:
 	case PM_EVENT_HIBERNATE:
 	case PM_EVENT_FREEZE:
+	case PM_EVENT_POWEROFF:
 		break;
 	default:
 		return 0;
diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index d8ad02c293205..e6357bc301cb9 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -1965,6 +1965,7 @@ static int stex_choice_sleep_mic(struct st_hba *hba, pm_message_t state)
 	case PM_EVENT_SUSPEND:
 		return ST_S3;
 	case PM_EVENT_HIBERNATE:
+	case PM_EVENT_POWEROFF:
 		hba->msi_lock = 0;
 		return ST_S4;
 	default:
-- 
2.43.0


