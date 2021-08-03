Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DE33DEFF9
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 16:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbhHCORc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 10:17:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57198 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbhHCOR0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Aug 2021 10:17:26 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gWoZ8VMjI9XOXCUXMxpbGRXjBl8AYyLz6obVucNbUhk=;
        b=FcMAlKjns7BfJQH1d/WJLl9lLRwjIX1a8wcxWxN2xJFXjHQ1JmES99kk68REO+YbBeX3pN
        ASY+BUrhK19OnqK4Rowa5DksECtui5rWQwaOsyrPRUxsAoU3YA6nH2xE/OKbKNI8A5SgOy
        xNv+vghKKfyrp5caHDuqCoF19Bu8gEDdtkZIqHRx1pebgTx06cnIlyF08lFexWMavTJG1h
        lKfVCNFDlXi1Uz73m1UycVVhIAR45i7Lx4SGl3bX/E0Syx1tI2f2KwW1q9DTUtHz+qNLVI
        QVRsgjyzrfI48q03vZfIxAKQs1/5p30p88ZeHtiNVwB+JW+8aU9PqWAZ9gLyPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gWoZ8VMjI9XOXCUXMxpbGRXjBl8AYyLz6obVucNbUhk=;
        b=ETDk/yxdeTKtrJ2yOSNPR6I3iql5x2sfifnK174w7HWmzVSadD5STKgV3lQqXDOtU8jJhp
        z/PcuzC57YOnk1BA==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH 30/38] ACPI: PM: s2idle: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:16:13 +0200
Message-Id: <20210803141621.780504-31-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-1-bigeasy@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/power/suspend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index d8cae434f9eb5..eb75f394a0590 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -96,7 +96,7 @@ static void s2idle_enter(void)
 	s2idle_state =3D S2IDLE_STATE_ENTER;
 	raw_spin_unlock_irq(&s2idle_lock);
=20
-	get_online_cpus();
+	cpus_read_lock();
 	cpuidle_resume();
=20
 	/* Push all the CPUs into the idle loop. */
@@ -106,7 +106,7 @@ static void s2idle_enter(void)
 		    s2idle_state =3D=3D S2IDLE_STATE_WAKE);
=20
 	cpuidle_pause();
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	raw_spin_lock_irq(&s2idle_lock);
=20
--=20
2.32.0

