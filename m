Return-Path: <linux-pm+bounces-38229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6F3C705EE
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 18:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C3F4028E51
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 17:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942B6352929;
	Wed, 19 Nov 2025 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8Su3zRY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2716C34575A
	for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572482; cv=none; b=ZAY0qU2SipoAsnPdAgTkMHs4WFe49Fcs+q3nbO4vvv38BE1icCVtL/zOhCazHQU143fEdmgzQBTG5ihfpb0YMFKMgFr2wsemhIgzjzBsaVc4rtkplVEMWdtSDqWIDECRoE1ZWIGMrxG/kIOVXw+R0Q5/O1Yfa8cd8TZnXyTO/uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572482; c=relaxed/simple;
	bh=uQDldX9XG+qGRX0YlPxhmUz0f5fVzex/PC5c2OnnqD8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=prD6KPH46Rz2CXxiyNiTXoycWlS8ZNGuddiXH0clzwT6a/MUAvKVswMGIPQwHZHo52OIomwnb7FoU+i9mlzmUp72EvjoXFIzo9jsoVSO6j+Iz3tDSHsHGjerupeaOUtHKbxnTK88F5vKKC/9B/SOSHJzmFAo5VVUSKiGHRWJN/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8Su3zRY; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b99f6516262so22122020a12.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 09:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763572479; x=1764177279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6126D4hNlxSLngUWFJIL+pyRlCYrRkd1GbDL09+PJs=;
        b=I8Su3zRY8Is9d1JHre5AYXQhh4N4htJyFdRxEs8ewxXvtT0dsBFsl8LMPRm7+cdsUG
         ORwysIaCo4Knpkerf902ixcNKxQcUp6QyUN4S4XncfxdxdXF+557LbUNy1bl78Wm6UPv
         elhz6Z2vwoMnXBsVhWHy5Ffq0b9hkJw2xaCKMM3JubkxluHWNvAm9FPYAKWLGXpESE0U
         2DlAZwYcPJfCvWHzvWrVFlvu+4WiKgVMlJi5sDy8uju1CC5mHuoEaMjwwpLsKaX0Ft2v
         nZruVPaJwculQnXJx8QAyFVS/5ezbty0iGilRyTIlieLJ80o/c2xtU3zUrzrWdTI1wdv
         8aHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763572479; x=1764177279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6126D4hNlxSLngUWFJIL+pyRlCYrRkd1GbDL09+PJs=;
        b=DoG2RX7xVy61FgEJW9cPxqBstZkgu0s8txuaZXZec6j2+uHUlULgdSAyDZCCYESlZw
         XfJvvLLfRgNG3/j4/szhhU7f1H756GHTBgL3hlIL6LdAEtcWaAkGXvcX1Ewq2V2Ef2b+
         ldMnVfop4bdNEhPsc0W++ImrxoF6uxnIqNLWILyvpifZ3OdemSobDjEWxBzKLd59mBP+
         Cb+e38FN6ubPheEjylowRMEpzH3jovNdcbnx9hLqb+VTZT/aOAIsnX6ggoswEC/Qcfol
         yXXLkuMhDvWjdM21JBAwS7f2PCc+UyWT+VBuBbAEYMuBCY5UqS4UeIQxA1HvUMZUJyzd
         kZMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9dHN/Pr8teLJxX/U4UR8W7Rk/9m4XvLov9MayxG/tTyuVhPcP46X40lq21LTqiGHuigDWJqICyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw61LM7I5qHzP+dZ7fa+dwXWEYa1glOY0YAJlMdrHM/kiMr/Vaa
	SaF43Rwid4qV30X9uGdIRLN0enuTH59qjSx5QFAz77OLrlUWCGNpyWNedM3CK95bN3wfZ2j/heY
	TQoBjS3PCAi0n8g==
X-Google-Smtp-Source: AGHT+IFjwX5vb9bGInL8052l+zRJKFhSXZ/kfdETPLlambCVPAjWDs7+TheNNhwqS+CFrq6JLBnbh33rbZbESA==
X-Received: from dlbvg5.prod.google.com ([2002:a05:7022:7f05:b0:11b:1a9a:d2e8])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:3c89:b0:11a:4525:5361 with SMTP id a92af1059eb24-11c937f6882mr34711c88.6.1763572479237;
 Wed, 19 Nov 2025 09:14:39 -0800 (PST)
Date: Wed, 19 Nov 2025 09:14:25 -0800
In-Reply-To: <20251119171426.4086783-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251119171426.4086783-1-wusamuel@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251119171426.4086783-3-wusamuel@google.com>
Subject: [PATCH v7 2/2] PM: Call pm_sleep_fs_sync() instead of ksys_sync_helper()
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: tuhaowen@uniontech.com, Samuel Wu <wusamuel@google.com>, 
	Saravana Kannan <saravanak@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Replace the direct calls to ksys_sync_helper() with the new
pm_sleep_fs_sync() in suspend, hibernation, and snapshot code paths.
This enables the new polling mechanism that allows for the filesystem
sync phase to be interrupted.

Suggested-by: Saravana Kannan <saravanak@google.com>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 kernel/power/hibernate.c | 6 +++++-
 kernel/power/suspend.c   | 6 +++++-
 kernel/power/user.c      | 4 +++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 26e45f86b955..af8d07bafe02 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -820,7 +820,10 @@ int hibernate(void)
 	if (error)
 		goto Restore;
 
-	ksys_sync_helper();
+	error = pm_sleep_fs_sync();
+	if (error)
+		goto Notify;
+
 	filesystems_freeze(filesystem_freeze_enabled);
 
 	error = freeze_processes();
@@ -891,6 +894,7 @@ int hibernate(void)
 	freezer_test_done = false;
  Exit:
 	filesystems_thaw();
+ Notify:
 	pm_notifier_call_chain(PM_POST_HIBERNATION);
  Restore:
 	pm_restore_console();
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index d9461447e37b..2da4482bb6eb 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -593,7 +593,11 @@ static int enter_state(suspend_state_t state)
 
 	if (sync_on_suspend_enabled) {
 		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
-		ksys_sync_helper();
+
+		error = pm_sleep_fs_sync();
+		if (error)
+			goto Unlock;
+
 		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
 	}
 
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 3f9e3efb9f6e..4401cfe26e5c 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -278,7 +278,9 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		if (data->frozen)
 			break;
 
-		ksys_sync_helper();
+		error = pm_sleep_fs_sync();
+		if (error)
+			break;
 
 		error = freeze_processes();
 		if (error)
-- 
2.52.0.rc1.455.g30608eb744-goog


