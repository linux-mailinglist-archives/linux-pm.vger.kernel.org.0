Return-Path: <linux-pm+bounces-14537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C3C97E2B9
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 19:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB111F217AC
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 17:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A3F37703;
	Sun, 22 Sep 2024 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="zgRT4K3t"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF38EEED6;
	Sun, 22 Sep 2024 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727025874; cv=none; b=tXlnk/ZJKSuDQQJ9AXqxH5TSBbHtvsOGie4Xnt+enf/Gj0pC6M6q+6CNVNlVAnaMHIF2d+qilDFOCTQWC0iW+Yqoo4zgcX25PEnYKBp4buctEdjmZ5PJ4rmFZYMhMSR7fpsGyqKM5kvRJko4fDhLb9kLw5Bn3Ne5GjvXLiWtPQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727025874; c=relaxed/simple;
	bh=pbGp2Upa1tQfV5lGSqqMjjJH0EyD9UJ0tLujZepVKxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCh9Cqbf1yr71lYt9CqKA1+H25TVXxwSUk2AxeYyKYcf0S0DTWjdXT8R+g0StRFtxhuaBE322patrK7UQNWPU5C5azHp5sxCH1Az44z9bhSDv3QhN2oGr17xyJz6s+19XXO6YJ0H9vcJsct/VktMMzi2dkcwYAWOXmCPdqqDAVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=zgRT4K3t; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 6BA512E096FE;
	Sun, 22 Sep 2024 20:24:27 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727025868;
	bh=PYi9JePA/C7PKQyom8rQqDAAGKRyFKQnDmgNqq6n+Ro=; h=From:To:Subject;
	b=zgRT4K3tSoy8ud67EFbuSr1gzZUJ7YOFdctMI4cYRp1A511GiGUCWH0PXLovc337M
	 fyvArEsP0KXs1Pew1iXlEvRLQVanV2A18JcQ2sjDuucfhviLh3ba4En58lMds2Ekg+
	 5UONPjKWwZswcnA7qT12ZBftJND69MOj2qCsVrbQ=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:cbc0:999f:73ad:33bd) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-pm@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	luke@ljones.dev,
	me@kylegospodneti.ch,
	Denis Benato <benato.denis96@gmail.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v2 2/5] acpi/x86: s2idle: handle Display On/Off calls outside
 of suspend sequence
Date: Sun, 22 Sep 2024 19:22:55 +0200
Message-ID: <20240922172258.48435-3-lkml@antheas.dev>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240922172258.48435-1-lkml@antheas.dev>
References: <20240922172258.48435-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <172702586826.19559.10852927881081473431@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Currently, the Display On/Off calls are handled within the suspend
sequence, which is a deviation from Windows. This causes issues with
certain devices, where the notification interacts with a USB device
that expects the kernel to be fully awake.

This patch calls the Display On/Off callbacks before entering the suspend
sequence, which fixes this issue. In addition, it opens the possibility
of modelling a state such as "Screen Off" that mirrors Windows, as the
callbacks will be accessible and validated to work outside of the
suspend sequence.

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 kernel/power/suspend.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index c527dc0ae5ae..610f8ecaeebd 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -589,6 +589,13 @@ static int enter_state(suspend_state_t state)
 	if (state == PM_SUSPEND_TO_IDLE)
 		s2idle_begin();
 
+	/*
+	 * Linux does not have the concept of a "Screen Off" state, so call
+	 * the platform functions for Display On/Off prior to the suspend
+	 * sequence, mirroring Windows which calls them outside of it as well.
+	 */
+	platform_suspend_display_off();
+
 	if (sync_on_suspend_enabled) {
 		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
 		ksys_sync_helper();
@@ -616,6 +623,8 @@ static int enter_state(suspend_state_t state)
 	suspend_finish();
  Unlock:
 	mutex_unlock(&system_transition_mutex);
+
+	platform_suspend_display_on();
 	return error;
 }
 
-- 
2.46.1


