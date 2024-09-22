Return-Path: <linux-pm+bounces-14535-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBCD97E2B4
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 19:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB69E281353
	for <lists+linux-pm@lfdr.de>; Sun, 22 Sep 2024 17:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBDD2B9DD;
	Sun, 22 Sep 2024 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="WlvJjWun"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958D2AEFC;
	Sun, 22 Sep 2024 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727025873; cv=none; b=XPj2OTVOfM/Y89m0+XBs3hL/LoS5mlzSV+MxZRaFwC3AOu6ESi5H+1N7NtkvIdanVsfYoH/wz9QYKXpLjABJtrQmNB06Mvbwepkb2GlynCwa3wZ5bf5n1CfPb8J3I6Eo4gO+w2JPZVyH2OV7Ph47sCYbEYAcglgWPTEDWAcbODs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727025873; c=relaxed/simple;
	bh=nBKbezGU8tCj+w5KktCCaXSUYra/fTFZnmGI3X7dqYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1E4eqSK4ofxu3n5bxbVycEbt/nEzbJ7vMPKGp2MplphVyu9xVyXXXXXi4j/XC0RkUeJ7umpvQlNUxo3zmw++xSRw8a/f4QnKGYi4PxsYtHvt+hVH1YHJRhF5OU2AgF6uafz9jBoZJj0QD6yj83F/aGB88+fiBNyKwCK16R4vvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=WlvJjWun; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 3B10E2E096FD;
	Sun, 22 Sep 2024 20:24:26 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727025867;
	bh=iWGWg+HqOzVyWBplL1Ejrl1AsmTfFMNkEylcKF88Ny4=; h=From:To:Subject;
	b=WlvJjWunpd7xINvl5r1mGCtvbIdtnbvYmGUyCGx5xOKjC3kMyGNH+xLQgb0G5vtqd
	 Gr+/XJb5ZBYX9IOEl19+ORUzujlSehhFQ6BjCJSlgg8cQNkxW5w8E+PtGeusCW/1ga
	 6D+f2Qy9PuwDSnPjy/+yTSd1enxgGA6mCTE+NzTE=
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
Subject: [PATCH v2 1/5] acpi/x86: s2idle: add support for Display Off and
 Display On callbacks
Date: Sun, 22 Sep 2024 19:22:54 +0200
Message-ID: <20240922172258.48435-2-lkml@antheas.dev>
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
 <172702586706.19493.3873523492503629555@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

The Display Off and Display On firmware notifications are meant to signify
the system entering a state where the user is not actively interacting
with it (i.e., in Windows this state is called "Screen Off" and the
system enters it once it turns the screen off e.g., due to inactivity).

Currently, these functions are called within the suspend sequence, which
causes issues when these notifications interact with e.g., a USB device
and makes them unable to be called as part of the screen turning off.

This patch adds a set of callbacks to allow calling the Display On/Off
notifications outside of the suspend/resume path.

Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 include/linux/suspend.h |  5 +++++
 kernel/power/suspend.c  | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index da6ebca3ff77..8f33249cc067 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -132,6 +132,7 @@ struct platform_suspend_ops {
 };
 
 struct platform_s2idle_ops {
+	int (*display_off)(void);
 	int (*begin)(void);
 	int (*prepare)(void);
 	int (*prepare_late)(void);
@@ -140,6 +141,7 @@ struct platform_s2idle_ops {
 	void (*restore_early)(void);
 	void (*restore)(void);
 	void (*end)(void);
+	int (*display_on)(void);
 };
 
 #ifdef CONFIG_SUSPEND
@@ -160,6 +162,9 @@ extern unsigned int pm_suspend_global_flags;
 #define PM_SUSPEND_FLAG_FW_RESUME	BIT(1)
 #define PM_SUSPEND_FLAG_NO_PLATFORM	BIT(2)
 
+int platform_suspend_display_off(void);
+int platform_suspend_display_on(void);
+
 static inline void pm_suspend_clear_flags(void)
 {
 	pm_suspend_global_flags = 0;
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 09f8397bae15..c527dc0ae5ae 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -254,6 +254,18 @@ static bool sleep_state_supported(suspend_state_t state)
 	       (valid_state(state) && !cxl_mem_active());
 }
 
+int platform_suspend_display_off(void)
+{
+	return s2idle_ops && s2idle_ops->display_off ? s2idle_ops->display_off() : 0;
+}
+EXPORT_SYMBOL_GPL(platform_suspend_display_off);
+
+int platform_suspend_display_on(void)
+{
+	return s2idle_ops && s2idle_ops->display_on ? s2idle_ops->display_on() : 0;
+}
+EXPORT_SYMBOL_GPL(platform_suspend_display_on);
+
 static int platform_suspend_prepare(suspend_state_t state)
 {
 	return state != PM_SUSPEND_TO_IDLE && suspend_ops->prepare ?
-- 
2.46.1


