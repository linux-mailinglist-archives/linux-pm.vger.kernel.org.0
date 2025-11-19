Return-Path: <linux-pm+bounces-38227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83493C705DF
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 18:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3C0BF2F3BB
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 17:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CAB341045;
	Wed, 19 Nov 2025 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cEHz1Ovg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B4D33C19E
	for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572474; cv=none; b=gERRN97InYSOwKooa1HsO+lpcjyDTc6rYzFZuxIJhqq7eCOw+LEF5TVc9aWXcZzmhV3xzj4654NtTEp6FDK2B0dcR7xJE8y3Xp3yHqX+I2k65TmXT/IWA0lL24Q1PtZxsoxZMfTqsNZTO+twG5l8HVtUmTjFI+u0EcfTJrSJ1dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572474; c=relaxed/simple;
	bh=yPmHGFOy2uYG3BQnWzl3yNtEHCs+1HhVo6pZH08q1Rc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UWoZ2+X4c69fKYze2oMc9iur9ACVxl0sV7OWC+tnzIb+zXfHFTa9trkwvJTk4J0/9f2E+quTb5vlX56W4M/pN7qyKODAiGK4tEWuiyUhbZTbpgJpBbiOqS9N0QcMBWN+dcqCGZWA4/32BebT/rC5p9Hp/NEEquxIZH50mT3gN4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cEHz1Ovg; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bc09a8454b9so18583407a12.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 09:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763572470; x=1764177270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i3bgr380CSigsZfcG9KMO4vujAvKCKLk4utUC+mblmY=;
        b=cEHz1OvgKz6VbpMu6J3FIr5myzNMI6hpJjk10TPV8+0v5gFIeAvwxVvOZXdPbtGcCJ
         syYXra3g0/Gd2Ou7GYf1FLQmhX6ICNWTb/3EcuJpi42882WuSn6V/BYmSzXE2fWHOqx0
         JwkG8En5683S1wtKZ77AtUYBVgCz4SJ7J3uchW5BVNlfA8kd0KLwWrKvxIWFuqT568A5
         SNSoTShc5L2/do7t6A/J38yxMOetcwSc56Bftkl1FE57ht9SI1ZHWXWzDdhzbbAKGPU+
         E4Iryie8MBIIahgV9ylOhK9sjdj68DjX23SVnI3X+ocrVfmPaZNw/l/ilg5i5005ADBh
         tEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763572470; x=1764177270;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i3bgr380CSigsZfcG9KMO4vujAvKCKLk4utUC+mblmY=;
        b=S69+uSEfy3QBZ0f/ImuRtbSGMc3BnyE7yDuvEnQznNQ9j1PwOdfDFrNaXfyQod81wF
         zkV4N3LRosE/KZwebh3AvMJsmgAkl+7W4lvUo1xLQ6S+iWiQjCjZK8eUZMq5UJ/KzGiU
         cSnZHkrzjbIvhjPRUFqXRzQheomPKeMKcN/b7W35J+eWiqMdVqLfQ/XXEEAUUZjuuXaH
         9kVqYIcSaVAlr6HwqjiQt1O3lUYrXYopPJ7VJfnPDoplFsoKG6HKt4l+CHNnWVNzRqRs
         QUlit0osKxzADoIeqbCFjKCV9V4GINukN2HQqzPAP50rzZMA5j+YxPjZLyKE5NKjJnmi
         /Hbg==
X-Forwarded-Encrypted: i=1; AJvYcCW9RcFWqVNqnj9oeAXNG5Uedfl/V0JcrGAi3aF/8QIKX0gxRtpIuH1CLeeEli7UezDJqPeg2yqFQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9UVW7WCok9Gb5UutC5TdEYSmJgC+sdsYyjDoE852x0XAE/VDI
	U56GTNKZvcUvNhs9E3TN80gI+fAtiftNEZeuI3JPn89xbtD09cVdt/uMb3monojsgaisaquQCwz
	P3HCOv2YZ/G9Wew==
X-Google-Smtp-Source: AGHT+IGWDV8rFy7bAXXwd8vbBdw2h95iMteVHrYDXJ9T4L6/lLQrXCIbNxOaXJdyTjg3/DHAu2TKiCwv7QwCjQ==
X-Received: from dybrt7.prod.google.com ([2002:a05:7301:4707:b0:2a2:454c:f92])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:1830:b0:2a4:3592:cf7b with SMTP id 5a478bee46e88-2a4abb19918mr5787013eec.31.1763572470031;
 Wed, 19 Nov 2025 09:14:30 -0800 (PST)
Date: Wed, 19 Nov 2025 09:14:23 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251119171426.4086783-1-wusamuel@google.com>
Subject: [PATCH v7 0/2] PM: Support aborting sleep during filesystem sync
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: tuhaowen@uniontech.com, Samuel Wu <wusamuel@google.com>, 
	Saravana Kannan <saravanak@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

At the start of suspend and hibernate, filesystems will sync to save the
current state of the device. However, the long tail of the filesystem
sync can take upwards of 25 seconds. If during this filesystem sync
there is some wakeup signal, it will not be processed until the sync is
complete; from a user's perspective, this looks like the device is
unresponsive to any form of input.

This patch adds functionality to handle a sleep abort signal when in
the filesystem sync phase of suspend or hibernate. This topic was first
discussed by Saravana Kannan at LPC 2024 [1], where the general
consensus was to allow filesystem sync on a parallel thread. In case of
a wakeup signal, the suspend process will stop waiting on an in-progress
filesystem sync, and instead abort suspend before the filesystem sync is
complete.

Furthermore, in the case of the back-to-back sleeps, a subsequent
filesystem sync is enqueued to ensure the latest files are synced right
before sleep. The framework still allows for an early abort in this case.

[1]: https://lpc.events/event/18/contributions/1845/

Suggested-by: Saravana Kannan <saravanak@google.com>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Samuel Wu <wusamuel@google.com>

Samuel Wu (2):
  PM: Add framework to abort during fs_sync
  PM: Call pm_sleep_fs_sync() instead of ksys_sync_helper()

Changes in v7:
- Switched to polling for wakeup/fs_sync finishing per Rafael's patch in v6
- Added header files for wait queue and atomics (modify Rafael's patch)
- Cleaned up wq on error in pm_start_workqueues (modify Rafael's patch)
- Changed atomic_add_return(-1, cnt) == 0 to atomic_dec_and_test(cnt) (modify
  Rafael's patch)
- v6 link: https://lore.kernel.org/all/20251030210110.298612-1-wusamuel@google.com/

Changes in v6:
- Use spin_lock_irq() in thread context
- Use dedicated ordered workqueue for sync work items
- Use a counter instead of two bools for synchronization
- Queue fs_sync if it's not already pending on workqueue
- pm_wakeup_clear(0) is prequisite to this feature, so move it within function
- Updated commit text for motive of back-to-back fs syncs
- Tighter lock/unlock around setup, checks, and loop
- Fix function definitions for CONFIG_PM_SLEEP=n
- v5 link: https://lore.kernel.org/all/20251017233907.2305303-1-wusamuel@google.com/

Changes in v5:
- Update spin_lock() to spin_lock_irqsave() since abort can be in IRQ context
- Updated changelog description to be more precise regarding continuing abort
  sleep before fs_sync() is complete
- Rename abort_sleep_during_fs_sync() to pm_stop_waiting_for_fs_sync()
- Simplify from a goto to do-while in pm_sleep_fs_sync()
- v4 link: https://lore.kernel.org/all/20250911185314.2377124-1-wusamuel@google.com

Changes in v4:
- Removed patch 1/3 of v3 as it is already picked up on linux-pm
- Squashed patches 2/3 and 3/3 from v3 into this single patch
- Added abort during fs_sync functionality to hibernate in addition to suspend
- Moved variables and functions for abort from power/suspend.c to power/main.c
- Renamed suspend_fs_sync_with_abort() to pm_sleep_fs_sync()
- Renamed suspend_abort_fs_sync() to abort_sleep_during_fs_sync()
- v3 link: https://lore.kernel.org/all/20250821004237.2712312-1-wusamuel@google.com/

Changes in v3:
- Split v2 patch into 3 patches
- Moved pm_wakeup_clear() outside of if(sync_on_suspend_enabled) condition
- Updated documentation and comments within kernel/power/suspend.c
- v2 link: https://lore.kernel.org/all/20250812232126.1814253-1-wusamuel@google.com/

Changes in v2:
- Added documentation for suspend_abort_fs_sync()
- Made suspend_fs_sync_lock and suspend_fs_sync_complete declaration static
- v1 link: https://lore.kernel.org/all/20250815004635.3684650-1-wusamuel@google.com

 kernel/power/hibernate.c |  6 +++-
 kernel/power/main.c      | 77 ++++++++++++++++++++++++++++++++++++----
 kernel/power/power.h     |  1 +
 kernel/power/suspend.c   |  6 +++-
 kernel/power/user.c      |  4 ++-
 5 files changed, 84 insertions(+), 10 deletions(-)

--
2.52.0.rc1.455.g30608eb744-goog


