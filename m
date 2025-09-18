Return-Path: <linux-pm+bounces-34939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA84B82CA4
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 05:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEEF37ADA5E
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 03:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4013724679C;
	Thu, 18 Sep 2025 03:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLZIQHn1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A2224678E;
	Thu, 18 Sep 2025 03:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758167110; cv=none; b=SRXgAk6RAqJ29Qo8q2MWVg6oGtIt8zUojmrHAkVHBBvdSHPB38GuRQHYjlqsLqquQsZhYbZjJbg4P5/Rrgfjsq5TrYjmwHmxCqEC3JDSsBaFijzmY6kUWneWQLxSPphL6TazA7NiIrkccduNANW/HJugzB2LSMf0fddOLJIgCbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758167110; c=relaxed/simple;
	bh=CqyWhU3tHkRq5Fov18b1QL/yJGTvRoKZfd58LpXYqv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmiU1olwTtBUP0md2Zj3m4gSmV8tSF4mk4Fe4noo5Syp9ptfRqEgUNpoRVCgh3WIT/pezbw0vstpm6OxQ8HZuAFBDcmbi1rGYmgDRjgrZTav8T2i89lTEBHlvIaPMi4TnUHPoT2ECu5i6dvhdcXh5OO3GsoK76ZCIrXLVXbycwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLZIQHn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5CFC4CEFA;
	Thu, 18 Sep 2025 03:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758167109;
	bh=CqyWhU3tHkRq5Fov18b1QL/yJGTvRoKZfd58LpXYqv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OLZIQHn1fC3clUfloEQujm3FRPyqRQMVKA2Hh7L69Su2aU+Kpo7p0nTcps6q4BgxP
	 w5NB3+/QYpqoWyxVQ+kzCFF7madeRwRZ/TBiCBlnXFVzrZoUiHhiW45KEuh8rcpJUX
	 X9UUaGEt3YLtHM3QJ+ssmmdwqqT0jgxO6mRFfNl+q0JKVBUXn4XoQhKc1BjE6s5Kbp
	 KPd9mfrS0lmXs5goE9qzrppylhtraJZEgi4IuN/b10F/QNeCB8MxqOIVZOx26rHZOg
	 iZC6ljfx8DVVNR83x+7wHaz7KGe/gXTfEFp6OSbMKWGKo5B/U/1sSLm1qofDaioYF5
	 zSdgD3CxfnDvw==
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
Subject: [PATCH v8 2/4] scsi: Add PM_EVENT_POWEROFF into suspend callbacks
Date: Wed, 17 Sep 2025 22:44:25 -0500
Message-ID: <20250918034427.3226217-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918034427.3226217-1-superm1@kernel.org>
References: <20250918034427.3226217-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the ACPI core uses hibernation callbacks for shutdown drivers
will receive PM_EVENT_POWEROFF and should handle it the same as
PM_EVENT_HIBERNATE would have been used.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
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
index 1c15cac41d80..768b85eecc8f 100644
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
index 63ed7f9aaa93..ee9372e1f7f0 100644
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
2.51.0


