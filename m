Return-Path: <linux-pm+bounces-36834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF5CC0A2E9
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 06:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 076194E6725
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 05:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1374126CE2D;
	Sun, 26 Oct 2025 05:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+I0Xk/9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90991F418F;
	Sun, 26 Oct 2025 05:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761455357; cv=none; b=RKVDdSFRINJ1vhbNwj6oHVpMoT+Qzl91aDpxugFVGRg+Bdcp8YUiuof8RTNlB4u8MZO6iBbBthdu86f3YRVbydhXzrwlBWAFg3Jf+9wWvEMytdzXyNCSMpQC5NDQFYY5bDoZPnnVZ2ilJVPcL9wzadbmwQ67YimtM+TuNilvjhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761455357; c=relaxed/simple;
	bh=+a3NIZ5LBAuFIjWG0tOX3YbHmV3EX8mnFBVq58cXdRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbAyReHwxMCqCm36sgJG1Doy/sV2XBsmYxHMAxODmo37PJfUHJQNeBE7U9njqc3ngZ26E1I/tNrabxVVpecOsMR5id/MD3GE59dewrGRdJOYq9R6HxcwjZlUXd4iV7e3YUEQpzWqunVQBH/W3IyrWIddPDHQ1xTcCMMQV8bqEhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+I0Xk/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FA9C4CEE7;
	Sun, 26 Oct 2025 05:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761455356;
	bh=+a3NIZ5LBAuFIjWG0tOX3YbHmV3EX8mnFBVq58cXdRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+I0Xk/9wQUo8wUURv4QbIcIRjdT2XJYaxgr8cam4lCHQVlmC//J6HUEEdnJghnoJ
	 KRnQrKNiji0lO6acG7iIgcAKzaDoh9lM970pzkQ+MTerH4npEQd2FLCNRGJDYdddu3
	 SbzO1LlST1n6gTi7F+37AkUotZKPk7UYXOp7R7gRF7tMiWDXphUoBjCBMqLJuFjDyf
	 yoKIb8hGhKJPb+FmhImZqWOKlsXfg1A8Ogeykzo4RX8bBRrBlbh/ThLOQ12KBnMnOh
	 edeVnIQY8a3cokSjWfavMORzvjSBmqu+aKPuVCh+iLJli01fa/sWJyzBeeE7UAvrgA
	 Xzwg8q7dq2jZw==
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
Subject: [PATCH v9 2/4] scsi: Add PM_EVENT_POWEROFF into suspend callbacks
Date: Sun, 26 Oct 2025 00:09:03 -0500
Message-ID: <20251026050905.764203-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026050905.764203-1-superm1@kernel.org>
References: <20251026050905.764203-1-superm1@kernel.org>
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
v9:
 * Reword commit (Bjorn)
v8:
 * Break up series to 3 parts
 * Pick up tag
v5:
 * Re-order
v4:
 * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@kernel.org/
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


