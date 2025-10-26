Return-Path: <linux-pm+bounces-36833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2396C0A2CB
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 06:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C3318A1BDC
	for <lists+linux-pm@lfdr.de>; Sun, 26 Oct 2025 05:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E81269CF1;
	Sun, 26 Oct 2025 05:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsOgQSkw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2231A1F418F;
	Sun, 26 Oct 2025 05:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761455355; cv=none; b=mXF7egPQEEIRIRe5pTRVWtNlXs7p0+XFDwr5cMkbLsGBKcPoK7IkzyYgQRupRNxvKXKDZv4SewXFsRezzbv9EIyZaPbT5xf6wCjNRX3aO97s09wQTRwAwvBDRWwTjp3t3KxPNZ+J4nMYMncQcfu5axPI851kTvomEo1bcxwdsho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761455355; c=relaxed/simple;
	bh=cH+0VkXpIeqlpI+foFbYT5pUyGloKQoAnRsc1lIosuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2hVFw+hIn42cOolp7UZUnxyvU+XEG0qjQiIKea6RvBk19QSQaIBkclQryLo+Derx7XDYfkxKrpAYHRj2gXRrMuxHxyQZmLm7oMaZ8IVE7VK7Lol37/2natdEn0pmIHTwd6XlFSN5kNx9J2H8Rof22MkHhrUfTUmKT8V2kN0n20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsOgQSkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EBAC16AAE;
	Sun, 26 Oct 2025 05:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761455354;
	bh=cH+0VkXpIeqlpI+foFbYT5pUyGloKQoAnRsc1lIosuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HsOgQSkwexm63qYD6AoFGK0gLXkd8k5YQg62BfJE7uCyLmf9QQ7tY2DmT1EkETqXa
	 O2MF77+zPfMD2R5M8tIkdv9cEV8ZxvPWIyNr0pMkhejSIOMRf4x31UEYxj4wxhhKIt
	 u2g67garRHyAficwnE6YnW2De+ufSVsAez0RG8OAnkaVXJOvZxey/U0DR+lv8UA8Kl
	 p23XlIomSVbvqDU19Y6KRi6qLbrCURW1GH+c3vEDw88YxZ2GR4T8UKJr9dg0pL6yfu
	 FIjxa5QXgOa6rTbZ/1a4DgJn4I/E1uV+eOErnI/1twc2sIaMNs2Ozm2uNZPxZzo4lw
	 EW011w6xMwJ6A==
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
Subject: [PATCH v9 1/4] PM: Introduce new PMSG_POWEROFF event
Date: Sun, 26 Oct 2025 00:09:02 -0500
Message-ID: <20251026050905.764203-2-superm1@kernel.org>
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

PMSG_POWEROFF will be used for the PM core to allow differentiating between
a hibernation or shutdown sequence when re-using callbacks for common code.

Hibernation is started by writing a hibernation method (such as 'platform'
'shutdown', or 'reboot') to use into /sys/power/disk and writing 'disk' to
/sys/power/state.

Shutdown is initiated with the reboot() syscall with arguments on whether
to halt the system or power it off.

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v9:
 * Add more detail to commit message (Bjorn)
v8:
 * Break series into 3 parts
 * Drop PMSG_NO_WAKEUP change
v7:
 * Reword commit
v5:
 * Re-order and split
 * Add tags
v4:
 * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@kernel.org/
---
 drivers/base/power/main.c    | 7 +++++++
 include/linux/pm.h           | 3 +++
 include/trace/events/power.h | 3 ++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 451d54486645b..ecdd88b578a04 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -95,6 +95,8 @@ static const char *pm_verb(int event)
 		return "restore";
 	case PM_EVENT_RECOVER:
 		return "recover";
+	case PM_EVENT_POWEROFF:
+		return "poweroff";
 	default:
 		return "(unknown PM event)";
 	}
@@ -367,6 +369,7 @@ static pm_callback_t pm_op(const struct dev_pm_ops *ops, pm_message_t state)
 	case PM_EVENT_FREEZE:
 	case PM_EVENT_QUIESCE:
 		return ops->freeze;
+	case PM_EVENT_POWEROFF:
 	case PM_EVENT_HIBERNATE:
 		return ops->poweroff;
 	case PM_EVENT_THAW:
@@ -401,6 +404,7 @@ static pm_callback_t pm_late_early_op(const struct dev_pm_ops *ops,
 	case PM_EVENT_FREEZE:
 	case PM_EVENT_QUIESCE:
 		return ops->freeze_late;
+	case PM_EVENT_POWEROFF:
 	case PM_EVENT_HIBERNATE:
 		return ops->poweroff_late;
 	case PM_EVENT_THAW:
@@ -435,6 +439,7 @@ static pm_callback_t pm_noirq_op(const struct dev_pm_ops *ops, pm_message_t stat
 	case PM_EVENT_FREEZE:
 	case PM_EVENT_QUIESCE:
 		return ops->freeze_noirq;
+	case PM_EVENT_POWEROFF:
 	case PM_EVENT_HIBERNATE:
 		return ops->poweroff_noirq;
 	case PM_EVENT_THAW:
@@ -1385,6 +1390,8 @@ static pm_message_t resume_event(pm_message_t sleep_state)
 		return PMSG_RECOVER;
 	case PM_EVENT_HIBERNATE:
 		return PMSG_RESTORE;
+	case PM_EVENT_POWEROFF:
+		return PMSG_ON;
 	}
 	return PMSG_ON;
 }
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 52ee38d72aa23..564133e53f0d3 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -507,6 +507,7 @@ const struct dev_pm_ops name = { \
  * RECOVER	Creation of a hibernation image or restoration of the main
  *		memory contents from a hibernation image has failed, call
  *		->thaw() and ->complete() for all devices.
+ * POWEROFF	System will poweroff, call ->poweroff() for all devices.
  *
  * The following PM_EVENT_ messages are defined for internal use by
  * kernel subsystems.  They are never issued by the PM core.
@@ -537,6 +538,7 @@ const struct dev_pm_ops name = { \
 #define PM_EVENT_USER		0x0100
 #define PM_EVENT_REMOTE		0x0200
 #define PM_EVENT_AUTO		0x0400
+#define PM_EVENT_POWEROFF	0x0800
 
 #define PM_EVENT_SLEEP		(PM_EVENT_SUSPEND | PM_EVENT_HIBERNATE)
 #define PM_EVENT_USER_SUSPEND	(PM_EVENT_USER | PM_EVENT_SUSPEND)
@@ -551,6 +553,7 @@ const struct dev_pm_ops name = { \
 #define PMSG_QUIESCE	((struct pm_message){ .event = PM_EVENT_QUIESCE, })
 #define PMSG_SUSPEND	((struct pm_message){ .event = PM_EVENT_SUSPEND, })
 #define PMSG_HIBERNATE	((struct pm_message){ .event = PM_EVENT_HIBERNATE, })
+#define PMSG_POWEROFF	((struct pm_message){ .event = PM_EVENT_POWEROFF, })
 #define PMSG_RESUME	((struct pm_message){ .event = PM_EVENT_RESUME, })
 #define PMSG_THAW	((struct pm_message){ .event = PM_EVENT_THAW, })
 #define PMSG_RESTORE	((struct pm_message){ .event = PM_EVENT_RESTORE, })
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 82904291c2b81..370f8df2fdb4b 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -179,7 +179,8 @@ TRACE_EVENT(pstate_sample,
 		{ PM_EVENT_HIBERNATE, "hibernate" }, \
 		{ PM_EVENT_THAW, "thaw" }, \
 		{ PM_EVENT_RESTORE, "restore" }, \
-		{ PM_EVENT_RECOVER, "recover" })
+		{ PM_EVENT_RECOVER, "recover" }, \
+		{ PM_EVENT_POWEROFF, "poweroff" })
 
 DEFINE_EVENT(cpu, cpu_frequency,
 
-- 
2.43.0


