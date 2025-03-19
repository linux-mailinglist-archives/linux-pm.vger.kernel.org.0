Return-Path: <linux-pm+bounces-24318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02590A697D0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 19:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C178A510A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 18:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEDA21ABDC;
	Wed, 19 Mar 2025 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="3zi6N9X2"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C07321A44D;
	Wed, 19 Mar 2025 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407911; cv=none; b=umE80rJzCMeWfwLbav2HwqYAsYzESnB9aAOeqTuYcUuNtuzjwzvkzDXgWDz1aRKOGUCNHRRyWN6y022Ez9bg4W0dF7Cj8dYKqrL55scBHDjIzIQiXKTQGqD/vliqtTclee/tNC4MHngm1xhRtZxGMSs5ExIOnlGGqjZIx01BAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407911; c=relaxed/simple;
	bh=4oBqDRz1b/hZCjb2rMlYW8j4Kr9COzceI9oiCHijD/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lw8qjPkUw+n4cWdqZW3zRS0VwfJbaiQRJ1dZDZw3aI7orpd6WYl5hPPtX0XyMhVK6WQGbiU3TO8ayQmTe4V/Bi7Og1mSDyhRSSMQzW4VlnQe/2quNj2hWnSJ1aNzvdGKhqqbgJiu4v5NVh4ZJsQbyISQVr6jYEKboRkllnFBIdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=3zi6N9X2; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 0F3952E095CF;
	Wed, 19 Mar 2025 20:11:44 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742407905;
	bh=cuUfNiaF2vgwpYa2Ey2t9IbxbchjhS3g8DIswxK5794=; h=From:To:Subject;
	b=3zi6N9X2G7hqEsN9z5S1MRqUNqZc3TXSOZDP+1QN9wWS+eMmCgMLHJrnTLYL8fOBO
	 JiiQ0lq3RnRQP+CQ+Kn6WXmkHMu+4teJ1zNPeTRAjLw5Y77ftwWUZTsaGO3LtoLrfY
	 hEEo68ly1pmsUjLDSSGwfDXFmz5RYS8jJAQgQrjE=
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
Subject: [PATCH v7 12/14] platform/x86: oxpec: Follow reverse xmas convention
 for tt_toggle
Date: Wed, 19 Mar 2025 19:10:39 +0100
Message-ID: <20250319181044.392235-13-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319181044.392235-1-lkml@antheas.dev>
References: <20250319181044.392235-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174240790562.3462.6522108493530506182@linux1587.grserver.gr>
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
index 97085ea9e8d77..2e4c7e6188f08 100644
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


