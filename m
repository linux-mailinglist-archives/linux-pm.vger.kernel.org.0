Return-Path: <linux-pm+bounces-17880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5827B9D51C7
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8650B2273B
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4901CB9F4;
	Thu, 21 Nov 2024 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ROQ8fEeb"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B940D1C304F;
	Thu, 21 Nov 2024 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210094; cv=none; b=uucumFNFBIEwDPbC9GzQlPu6Svgk4hbAYaAksC6vdhUvHyAqtom4IZ7cLmCeHDtqrOCYG9s5E4OoChEE/QMBiMMzFD2F2LtMw7//s3JECc39FgaWvkXRGuFlMavsPWKS8CPgf1vHjCVeqw3Sjy7IppIJz8+EwFI1FfbrULENQ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210094; c=relaxed/simple;
	bh=DkK6FKerYQ5Jj6C78QVHSiDhwQ1VrPm0mSRsM0u0Vzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvK7mfettNHQdGnq/jtkdjGhB0bcTDRvxw6DNqlrnCUq0/cU1sGWVQMkjyuLwcqkZJ+46UFoYc8FTsS5e2RklTunfLiP0AhNI8kR5UXtW123woWdIHUDnAwfI7GiWw6463Jmn9f6CAc6bTXslQARmuYSo2XS8rVOTd3otdoXOqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ROQ8fEeb; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 173172E09589;
	Thu, 21 Nov 2024 19:22:49 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1732209771;
	bh=0YVrjraYiMF7JFRMsGzYGi+DLsnhBUH9lwvrGzQx40s=; h=From:To:Subject;
	b=ROQ8fEeb/FgQIikIPcPmun/aLlgmlG34bO+t6bLBdiOpL6ZctiSfIAi2FS8iOqXM/
	 yKOtdEBqwRB5pvdIb54XUmubFTnXqG18OM/Ln8ct/FIrZcLanIMujuoDsUeVPDv+ZW
	 +d/+BSb87c/h9WXka00b/m8MR1ESpBOLQ5Fjkzuc=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:cbc0:999f:73ad:33bd) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-pm@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Kyle Gospodnetich <me@kylegospodneti.ch>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [RFC 02/13] acpi/x86: s2idle: add support for Display Off and Display
 On callbacks
Date: Thu, 21 Nov 2024 18:22:27 +0100
Message-ID: <20241121172239.119590-3-lkml@antheas.dev>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241121172239.119590-1-lkml@antheas.dev>
References: <20241121172239.119590-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <173220977021.4257.7217008257458970692@linux1587.grserver.gr>
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
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 include/linux/suspend.h |  2 ++
 kernel/power/suspend.c  | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index da6ebca3ff77..57c083754e8b 100644
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
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 09f8397bae15..cded6b9b439b 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -254,6 +254,16 @@ static bool sleep_state_supported(suspend_state_t state)
 	       (valid_state(state) && !cxl_mem_active());
 }
 
+static int platform_standby_display_off(void)
+{
+	return s2idle_ops && s2idle_ops->display_off ? s2idle_ops->display_off() : 0;
+}
+
+static int platform_standby_display_on(void)
+{
+	return s2idle_ops && s2idle_ops->display_on ? s2idle_ops->display_on() : 0;
+}
+
 static int platform_suspend_prepare(suspend_state_t state)
 {
 	return state != PM_SUSPEND_TO_IDLE && suspend_ops->prepare ?
-- 
2.47.0


