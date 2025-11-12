Return-Path: <linux-pm+bounces-37887-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E48C54BA2
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 23:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85583A64FC
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 22:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FD32EC55A;
	Wed, 12 Nov 2025 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3lcLphG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0FF2EC090;
	Wed, 12 Nov 2025 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762987231; cv=none; b=BwIm3J5QiehxKkFSgmXGcJATZwJrEXamoAkOjIh3t3Kmw8eQzOWmeeq+42hYjCXuXjheT++7S1ypkUHaC2SmSW+l9Qxr68iqBgqBbUP+IAf58VyXiqqotaotGlp9i+cW35YkoUOzDyYZirLYx8eFs3O9FuiCvTZ5I45D/j7Ul/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762987231; c=relaxed/simple;
	bh=yzyDbFadQSqvRKfDq4z0ZFNSbTywoVqwZTw5svvLFBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9EEXMzEN9MQoty7jRcHtqHnhJJK13xic83DHEuiuQBxRA6gs5iRMy71RXX0cCZ3Xrk/vZlZ3ueVJHfwutZQzhV+K7G8G5s59rDA7QaZEeHVbrWFdtJbCKa7wLHdDVNS0vo5IAITWW4zJudBs4cyWQMGPzTEAmIBRscFDoq7Xqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3lcLphG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3BEC19423;
	Wed, 12 Nov 2025 22:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762987231;
	bh=yzyDbFadQSqvRKfDq4z0ZFNSbTywoVqwZTw5svvLFBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U3lcLphGrt2xiWYxXtzaT6xZGJq484j60ySp4xlIiDp1hUkMHWl542LUMYYaOdikJ
	 oPAYXuZm+irwAy9cBqx8wZ8cL+/sEeXgNByooQltSV50GJw4bl8UkRfQSkJ7I9Ttfd
	 RNWnWv0HVr+SSq76HTTJGKX+5OOP69C8eUeerW/BigEEx7Z5b36S742gxlZPQ7ogtQ
	 7kFoulpmdU5spNlDOajcAAVZasMs4UJu5kz+KG8whOFuUI8T5Lh4YFvzFK2WWae9d3
	 OlhrSTa291sDdSpmGCPz4JZ4lFsCiYP1Bofd9rTge0JMUYyWzbH/sbYMf13xnfrzBe
	 C6MwqcvaKVxpQ==
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
Subject: [PATCH v10 1/3] PM: Introduce new PMSG_POWEROFF event
Date: Wed, 12 Nov 2025 16:40:23 -0600
Message-ID: <20251112224025.2051702-2-superm1@kernel.org>
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
v10:
 * Drop resume event
---
 drivers/base/power/main.c    | 5 +++++
 include/linux/pm.h           | 3 +++
 include/trace/events/power.h | 3 ++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 7a8807ec9a5d0..38fc8a978b88c 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -96,6 +96,8 @@ static const char *pm_verb(int event)
 		return "restore";
 	case PM_EVENT_RECOVER:
 		return "recover";
+	case PM_EVENT_POWEROFF:
+		return "poweroff";
 	default:
 		return "(unknown PM event)";
 	}
@@ -368,6 +370,7 @@ static pm_callback_t pm_op(const struct dev_pm_ops *ops, pm_message_t state)
 	case PM_EVENT_FREEZE:
 	case PM_EVENT_QUIESCE:
 		return ops->freeze;
+	case PM_EVENT_POWEROFF:
 	case PM_EVENT_HIBERNATE:
 		return ops->poweroff;
 	case PM_EVENT_THAW:
@@ -402,6 +405,7 @@ static pm_callback_t pm_late_early_op(const struct dev_pm_ops *ops,
 	case PM_EVENT_FREEZE:
 	case PM_EVENT_QUIESCE:
 		return ops->freeze_late;
+	case PM_EVENT_POWEROFF:
 	case PM_EVENT_HIBERNATE:
 		return ops->poweroff_late;
 	case PM_EVENT_THAW:
@@ -436,6 +440,7 @@ static pm_callback_t pm_noirq_op(const struct dev_pm_ops *ops, pm_message_t stat
 	case PM_EVENT_FREEZE:
 	case PM_EVENT_QUIESCE:
 		return ops->freeze_noirq;
+	case PM_EVENT_POWEROFF:
 	case PM_EVENT_HIBERNATE:
 		return ops->poweroff_noirq;
 	case PM_EVENT_THAW:
diff --git a/include/linux/pm.h b/include/linux/pm.h
index a72e42eec1303..7f69f739f6130 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -508,6 +508,7 @@ const struct dev_pm_ops name = { \
  * RECOVER	Creation of a hibernation image or restoration of the main
  *		memory contents from a hibernation image has failed, call
  *		->thaw() and ->complete() for all devices.
+ * POWEROFF	System will poweroff, call ->poweroff() for all devices.
  *
  * The following PM_EVENT_ messages are defined for internal use by
  * kernel subsystems.  They are never issued by the PM core.
@@ -538,6 +539,7 @@ const struct dev_pm_ops name = { \
 #define PM_EVENT_USER		0x0100
 #define PM_EVENT_REMOTE		0x0200
 #define PM_EVENT_AUTO		0x0400
+#define PM_EVENT_POWEROFF	0x0800
 
 #define PM_EVENT_SLEEP		(PM_EVENT_SUSPEND | PM_EVENT_HIBERNATE)
 #define PM_EVENT_USER_SUSPEND	(PM_EVENT_USER | PM_EVENT_SUSPEND)
@@ -552,6 +554,7 @@ const struct dev_pm_ops name = { \
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


