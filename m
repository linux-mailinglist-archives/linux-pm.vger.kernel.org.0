Return-Path: <linux-pm+bounces-14480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D7A97CD09
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 19:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C4E7B22473
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 17:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69BE199944;
	Thu, 19 Sep 2024 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="oluZlcDi"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC831A2863;
	Thu, 19 Sep 2024 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726766797; cv=none; b=KpvNsknVyx3cPIAS/5739ssk+QZeF6rvFCresXBCgONnfIZNGAzAY1vpgnmz2D3dSs8SL4wjbUhhpJGJXQf6cqCEXAhDOSUApx/BXz9u1ddx1jbeNVnZyWl/W3wqs5lh1JJQNp+rjdo9dCXMVDAvN2bTyC73HdMdoPSuQI27edg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726766797; c=relaxed/simple;
	bh=c1Ki3+zG7/5wotWeiw2IG0TgqkK2cVncFVi63km7PEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMc3vxWpL4iPFlJJGCDIR2wlZXlAPut9n4DGOCzaExGpThMCiTIXs3X1EoqKUuwWTgKUfwaz7REYG5o/cgEuF0xl9rjI2OS9Ike5D+a1DWwQCQOUQYrEWWSca+XdXMOk1HuqueUjg1FzroAz5k1pcCyftV9s3Qwy3aOKxh8ciuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=oluZlcDi; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:6813:1156:549c:fa23])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id BABCD2E09C24;
	Thu, 19 Sep 2024 20:20:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1726766420;
	bh=95gmiwyDCGwbw7Fjy10AvGErlGkNmq4ZiD1FeYxAWMA=; h=From:To:Subject;
	b=oluZlcDiiSMuS08jZRhYod6Y6+h3NDQSUCMV1XNur++/x9zUIUCuqiGq6P/7NOoN+
	 v49x1ThJLeFgtaQkwiKzHaxZOi57oavHbIzQ5Xmh5/5d+umiz5t1m3xsfSKvEXjevU
	 YPJtqn5ieBGVQBexrLTJTcroewzE0OQc316SpfsY=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:6813:1156:549c:fa23) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-pm@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	Mario.Limonciello@amd.com,
	luke@ljones.dev,
	me@kylegospodneti.ch
Subject: [PATCH v1 2/4] acpi/x86: s2idle: handle screen off/on calls outside
 of suspend sequence
Date: Thu, 19 Sep 2024 19:19:50 +0200
Message-ID: <20240919171952.403745-3-lkml@antheas.dev>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919171952.403745-1-lkml@antheas.dev>
References: <20240919171952.403745-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <172676641764.26701.13590723372717455783@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Currently, the screen off/on calls are handled within the suspend
sequence, which is a deviation from Windows. This causes issues with
certain devices, such as the ROG Ally, which expects this call to be
executed with the kernel fully awake. The subsequent half-suspended
state makes the controller of the device to fail to suspend properly.

This patch calls the screen off/on callbacks before entering the suspend
sequence, which fixes this issue. In addition, it opens the possibility
of modelling a state such as "Screen Off" that mirrors Windows, as the
callbacks will be accessible and validated to work outside of the
suspend sequence.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 kernel/power/suspend.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 19734b297527..afa95271ef00 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -507,6 +507,19 @@ int suspend_devices_and_enter(suspend_state_t state)
 
 	pm_suspend_target_state = state;
 
+	/*
+	 * Linux does not have the concept of a "Screen Off" state, so call
+	 * the platform functions for screen off prior to beginning the suspend
+	 * sequence, mirroring Windows which calls them outside of it as well.
+	 *
+	 * If Linux ever gains a "Screen Off" state, the following callbacks can
+	 * be replaced with a call that checks if we are in "Screen Off", in which
+	 * case they will NOOP and if not call them as a fallback.
+	 */
+	error = platform_suspend_screen_off();
+	if (error)
+		goto Screen_on;
+
 	if (state == PM_SUSPEND_TO_IDLE)
 		pm_set_suspend_no_platform();
 
@@ -540,6 +553,9 @@ int suspend_devices_and_enter(suspend_state_t state)
  Close:
 	platform_resume_end(state);
 	pm_suspend_target_state = PM_SUSPEND_ON;
+
+ Screen_on:
+	platform_suspend_screen_on();
 	return error;
 
  Recover_platform:
-- 
2.46.1


