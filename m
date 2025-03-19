Return-Path: <linux-pm+bounces-24303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EEEA69748
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 19:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A3C171A22
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 17:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCBB21A440;
	Wed, 19 Mar 2025 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="AeLKR1c6"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE780219A81;
	Wed, 19 Mar 2025 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406953; cv=none; b=MfDnbvP4RdVR2XqRRBTJeNgx79UFH/784vTiKDCUYxGDAVFeqwhA4mt6WIh1yW4+M9/1aVtF6HIn6I0mAhrtwoALjUVPS1V4R5o0K07x0W39kGLytbFPRToyj3UbBjMTd27x7WdbvghmNp+HD6eUZ6tZOfjDrpblgfKkFdxqnt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406953; c=relaxed/simple;
	bh=qByfQQZj6BRxFXhLMnSy75GdfBvZiLRkUWNulXrJx+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJCQd8l3PP6P/PxSo5Umlp98PhQGgE2OTrnuY6z5YkDxNyT4xpEt9+4+uESzMrRVJ02tBdxG6lfdPqMVmAs98W7cSkvpTMvoxt0ChyxG3rWU2VVTd1VVbm7NxNYsjaBl6kBlXWePu0hW2jnjvYVD4Z+1axwBF8AxlJeOjrsy7mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=AeLKR1c6; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 9A1FC2E094D2;
	Wed, 19 Mar 2025 19:55:47 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742406949;
	bh=lWKVAMClccLlCZLg9L9akPGeETS++Qy85TP5txpCcIk=; h=From:To:Subject;
	b=AeLKR1c6RzcNHmknUVpAXfGL9vymmTS8jmsD4EOIXjRRoc1lor4rnEKtY/n/xh4ES
	 fOmbv1QS3wnZ0E3W6LwV5RruunNs1cWnPPmyI9asy7mJIV/g+mabALB13JlmUA4Uwu
	 M+ehr2SiB8nxNwZsjQbieozOTN1N5lh8gNOtjy2A=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:cbc0:999f:73ad:33bd) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
	Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>,
	linux-kernel@vger.kernel.org,
	sre@kernel.org,
	linux@weissschuh.net,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	mario.limonciello@amd.com,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v6 12/14] platform/x86: oxpec: Follow reverse xmas convention
 for tt_toggle
Date: Wed, 19 Mar 2025 18:55:07 +0100
Message-ID: <20250319175512.27059-13-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319175512.27059-1-lkml@antheas.dev>
References: <20250319175512.27059-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174240694923.25354.17136943352112583359@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Since the rest of the driver follows this convention, apply it to the
tt_toggle attribute as well.

Suggested-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index 680fa537babf6..fe76973fa0c2c 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -275,9 +275,9 @@ static const struct dmi_system_id dmi_table[] = {
 /* Helper functions to handle EC read/write */
 static int read_from_ec(u8 reg, int size, long *val)
 {
-	int i;
-	int ret;
 	u8 buffer;
+	int ret;
+	int i;
 
 	if (!lock_global_acpi_lock())
 		return -EBUSY;
@@ -389,8 +389,8 @@ static ssize_t tt_toggle_store(struct device *dev,
 			       struct device_attribute *attr, const char *buf,
 			       size_t count)
 {
-	int rval;
 	bool value;
+	int rval;
 
 	rval = kstrtobool(buf, &value);
 	if (rval)
@@ -411,8 +411,8 @@ static ssize_t tt_toggle_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
 	int retval;
-	u8 reg;
 	long val;
+	u8 reg;
 
 	switch (board) {
 	case oxp_mini_amd_a07:
-- 
2.48.1


