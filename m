Return-Path: <linux-pm+bounces-17864-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7109D5193
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 18:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41292824DE
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D5B1AB51B;
	Thu, 21 Nov 2024 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="aVltbebO"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FBC1A01C6;
	Thu, 21 Nov 2024 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732209780; cv=none; b=ZrJ/FDiH8mskYu2lFt1sw4sPNK37ZAG/dBziXIC+dhpL4+PuG/VmoMNSSle1GlXIeiR6Uayju3Qi8/4f+Dk96nJTyF1Ou9oG9ZiZT24rV8frEHlmJConfJKKbzKQypKc2bhFyr/abYW7YhEIT+YP2cUNJsdnS853lRZYJrojLbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732209780; c=relaxed/simple;
	bh=zcXvvFF+HpwUBmxtDFrw3rBWYXzLDCzPByRJTtZcqPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8Thvu+M9TG3wv4VFOGFHSKTYNLQEsmYz73oAuOXJmnoinzODAvc9dGIhqHVHFjRN/H5B++QzUW7ix6MLg/LOMg6XsZQ4UTjhDedGunfxhqrHCXC9GVg0xrZQsjfk5RX00FCexDT9FqxJFQBDm/32bTK41ttcd3NhBiTxT31uzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=aVltbebO; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 46D7A2E09693;
	Thu, 21 Nov 2024 19:22:52 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1732209773;
	bh=OzkxDuIjq0abCpdesqahg7f+ZtZjUSV0EPiXaxqA5VM=; h=From:To:Subject;
	b=aVltbebOkEG9DDsFxDdM93qXN7uF78NYPGeAv7E+f2COeGR61G5yHUhqRrBfwFHLx
	 1d4w25h8wJAPy8kinDX4F7hzoQTtEIpt+Be1S2DZEXgXfERClk9GowWUac5hcO9OXr
	 w0rKHDmLYDkeyPnAv89RLNamlt7FanVgmuW+icNk=
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
Subject: [RFC 03/13] acpi/x86: s2idle: add support for Sleep Entry and Sleep
 Exit callbacks
Date: Thu, 21 Nov 2024 18:22:28 +0100
Message-ID: <20241121172239.119590-4-lkml@antheas.dev>
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
 <173220977334.4697.4549620138605508037@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

The Sleep Entry and Sleep Exit firmware notifications allow the platform
to enter Modern Standby. In this state, if supported, the platform turns
off auxiliary USB devices (e.g., the controllers of the Legion Go),
makes the power light of the device flash, and lowers the power envelope
to a minimum that still allows for software activity without affecting
battery life.

Allow for entering this state prior to initiating the suspend sequence.
This fixes issues where the EC or the USB of the device need time to
power down before entering the suspend sequence, and allows for entering
this power state without suspending the device.

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 include/linux/suspend.h |  2 ++
 kernel/power/suspend.c  | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 57c083754e8b..733dffb09b28 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -133,6 +133,7 @@ struct platform_suspend_ops {
 
 struct platform_s2idle_ops {
 	int (*display_off)(void);
+	int (*sleep_entry)(void);
 	int (*begin)(void);
 	int (*prepare)(void);
 	int (*prepare_late)(void);
@@ -141,6 +142,7 @@ struct platform_s2idle_ops {
 	void (*restore_early)(void);
 	void (*restore)(void);
 	void (*end)(void);
+	int (*sleep_exit)(void);
 	int (*display_on)(void);
 };
 
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index cded6b9b439b..3f4bbefa9b82 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -259,6 +259,16 @@ static int platform_standby_display_off(void)
 	return s2idle_ops && s2idle_ops->display_off ? s2idle_ops->display_off() : 0;
 }
 
+static int platform_standby_sleep_entry(void)
+{
+	return s2idle_ops && s2idle_ops->sleep_entry ? s2idle_ops->sleep_entry() : 0;
+}
+
+static int platform_standby_sleep_exit(void)
+{
+	return s2idle_ops && s2idle_ops->sleep_exit ? s2idle_ops->sleep_exit() : 0;
+}
+
 static int platform_standby_display_on(void)
 {
 	return s2idle_ops && s2idle_ops->display_on ? s2idle_ops->display_on() : 0;
-- 
2.47.0


