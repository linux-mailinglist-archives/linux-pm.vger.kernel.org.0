Return-Path: <linux-pm+bounces-32758-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 910AEB2E986
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 02:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213EA1BA3295
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 00:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEF020298C;
	Thu, 21 Aug 2025 00:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wvAFRxYo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F801FE455
	for <linux-pm@vger.kernel.org>; Thu, 21 Aug 2025 00:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755736984; cv=none; b=IGuEQCfszgoGkUe42UbbYtpBIG6DDpI1H952951HNuw7g1v5BuKC2WdQ9EbmlUr1kfvNW/59HaVkhKX0BQrHSGd5IXL7+4OAoYaVVJqKM0ZyDBGvh1kDEckS2rKlX+mUnk5X3PUspE+o/81eLKyUPAUNGsjJ4xdhAZeiK0WrNg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755736984; c=relaxed/simple;
	bh=oHVkF6XaV9p5B0srs5XCsOEcNNTkJUM9IoY5ou4gKBQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s9wUAp8ybLyt1vZanl+zeCciG3sUYrIYMhR+cPLHEhP+5BhK9qkG4QEbue/NtchqSpNtnwoojIyZKmHS9hbKH/jEUaPcT8DMcecM4Sy6laTzNc6d52t78ZVj1iCOWsjVLo1LnuDy4FJIPWqTJXAn5Zvv4pil5TmkLSFm14pd7uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wvAFRxYo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b473910af91so1327378a12.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 17:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755736983; x=1756341783; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3icfEzl9XxxQPBFjvKXRxo5NUjrEKeyiQj6dEJHVAvE=;
        b=wvAFRxYoEz4tkddE+z4Lx6Qs0gPovPboTB8lxhElnNVvMYFC6z3IgoPq6/RJhAIrG+
         2ez+KgXK8BYOCdakbLviLvBKFzSu3Hy4uwZ4I5nBaf9MZHnc22kKWozhH7q6LIk+2tkX
         n+2r2cZx9L93Lq866QYD+mwjZqXh/kt0ek86P44Dkm35445TGYNdbMRU9I8Cwzz+M4Zt
         /Y/wXfpISBfkAHWVdUzUD0Jivv9azISUN3xv5g6etnss27o6BSPXS70NwbYgv0HNF++/
         BW9QGqLdHprbDNes3+n0JD944gw+3b15xMV7GFTDKHHlnX602dFwBf4OSxF3kg57en3r
         bvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755736983; x=1756341783;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3icfEzl9XxxQPBFjvKXRxo5NUjrEKeyiQj6dEJHVAvE=;
        b=tJtTRdNmdMDHBqwA8slB9mqwx1rcWsG6+lCod5fbvYq9gQ0X9OGqKVmrwiU/c8SfMS
         IMHha0YMk5b/UhrlgwXZZnvNCzD4yD82iN7psNdWCZxqjB7RR0tj0pyhZvj5PV57bpka
         jJ8sx8GuuYdO2T8QTFt0dabjhW5mQx06CZbHD4h47m/KBT+sQB0Go9RzozkBsFyR23pH
         PVJKAGHynu7m+QfIYgdD+Jp9j5xglbo46TfVwahzz/YOdvM6aws/JdqsaSSLEVnrPQ9t
         yYPGYo2LncIuOKDaAH1lfv7Fv+Nxdbs7v5YQFPSuk+TslXU53deThgIrlDyoxXvY81Ry
         bK5A==
X-Forwarded-Encrypted: i=1; AJvYcCVOy58TyCrOtD/WvzKL4s5pu3rf0mfRYBZ9BlCwSHwra5nXQn9UlQlHynJfIrFekSl9xdCHlrOUyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzV/2FBXSN+Duici0BAkkWONGSPhKU2fK4/Ra7+bitbLQATJ7Zd
	ar6004Gd5RtUuqaclSCq9iz3FDcFo/jtqd3WBJdy2kR4P7GlJ98N6SuNpSdEm9Jmm14jQZL+tcL
	HlO+j9LfB9EpTzQ==
X-Google-Smtp-Source: AGHT+IEpUHU1FEQsybzictZCjKAV7ckIg2JotfswUr2POfAe/aWkVuPYr9bArQgw/0ycDrKJukG5YwtyBM690w==
X-Received: from pjgg5.prod.google.com ([2002:a17:90b:57c5:b0:321:76a2:947c])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d64b:b0:31f:2bbb:e6a8 with SMTP id 98e67ed59e1d1-324eedf1f5emr578851a91.12.1755736982896;
 Wed, 20 Aug 2025 17:43:02 -0700 (PDT)
Date: Wed, 20 Aug 2025 17:42:35 -0700
In-Reply-To: <20250821004237.2712312-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821004237.2712312-1-wusamuel@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821004237.2712312-4-wusamuel@google.com>
Subject: [PATCH v3 3/3] PM: Support abort during fs_sync of back-to-back suspends
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"

There is extra care needed to account for back-to-back suspends while
still maintaining functionality to immediately abort during the
filesystem sync stage.

This patch handles this by serializing the filesystem sync sequence with
an invariant; a subsequent suspend's filesystem sync operation will only
start when the previous suspend's filesystem sync has finished. While
waiting for the previous suspend's filesystem sync to finish, the
subsequent suspend will still abort early if a wakeup event is
triggered, solving the original issue of filesystem sync blocking abort.

Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Samuel Wu <wusamuel@google.com>
Reviewed-by: Saravana Kannan <saravanak@google.com>
---
 kernel/power/suspend.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index edacd2a4143b..514c590ec383 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -75,6 +75,8 @@ bool pm_suspend_default_s2idle(void)
 }
 EXPORT_SYMBOL_GPL(pm_suspend_default_s2idle);
 
+static bool suspend_fs_sync_queued;
+static DEFINE_SPINLOCK(suspend_fs_sync_lock);
 static DECLARE_COMPLETION(suspend_fs_sync_complete);
 
 /**
@@ -85,7 +87,9 @@ static DECLARE_COMPLETION(suspend_fs_sync_complete);
  */
 void suspend_abort_fs_sync(void)
 {
+	spin_lock(&suspend_fs_sync_lock);
 	complete(&suspend_fs_sync_complete);
+	spin_unlock(&suspend_fs_sync_lock);
 }
 
 void s2idle_set_ops(const struct platform_s2idle_ops *ops)
@@ -420,7 +424,11 @@ void __weak arch_suspend_enable_irqs(void)
 static void sync_filesystems_fn(struct work_struct *work)
 {
 	ksys_sync_helper();
+
+	spin_lock(&suspend_fs_sync_lock);
+	suspend_fs_sync_queued = false;
 	complete(&suspend_fs_sync_complete);
+	spin_unlock(&suspend_fs_sync_lock);
 }
 static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
 
@@ -432,8 +440,26 @@ static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
  */
 static int suspend_fs_sync_with_abort(void)
 {
+	bool need_suspend_fs_sync_requeue;
+
+Start_fs_sync:
+	spin_lock(&suspend_fs_sync_lock);
 	reinit_completion(&suspend_fs_sync_complete);
-	schedule_work(&sync_filesystems);
+	/*
+	 * Handle the case where a suspend immediately follows a previous
+	 * suspend that was aborted during fs_sync. In this case, wait for the
+	 * previous filesystem sync to finish. Then do another filesystem sync
+	 * so any subsequent filesystem changes are synced before suspending.
+	 */
+	if (suspend_fs_sync_queued) {
+		need_suspend_fs_sync_requeue = true;
+	} else {
+		need_suspend_fs_sync_requeue = false;
+		suspend_fs_sync_queued = true;
+		schedule_work(&sync_filesystems);
+	}
+	spin_unlock(&suspend_fs_sync_lock);
+
 	/*
 	 * Completion is triggered by fs_sync finishing or a suspend abort
 	 * signal, whichever comes first
@@ -441,6 +467,8 @@ static int suspend_fs_sync_with_abort(void)
 	wait_for_completion(&suspend_fs_sync_complete);
 	if (pm_wakeup_pending())
 		return -EBUSY;
+	if (need_suspend_fs_sync_requeue)
+		goto Start_fs_sync;
 
 	return 0;
 }
-- 
2.51.0.261.g7ce5a0a67e-goog


