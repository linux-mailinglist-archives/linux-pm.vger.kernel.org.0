Return-Path: <linux-pm+bounces-24208-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63707A6571B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 17:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573071885CB0
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 15:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586EE1E1E02;
	Mon, 17 Mar 2025 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="tdjonn+Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54BA1DEFEB;
	Mon, 17 Mar 2025 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226865; cv=none; b=roLFHenQRhLI9PRzPH7m+cLJnm+vw9zq0EQc5Cvsx/f81CD+RDKTA4MQ0QL0C5nKtzwV1+jI6necmXVEMS/qFfXhxdhOJ6/2yAuhAzu7Q4M4e354LDgkpRv1mBN7QqR3EAxoc26z1ikQ/CzAdpq2M9qDgekIV6A2tYrIOd0sT/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226865; c=relaxed/simple;
	bh=HcsJpujgZY7mO6VKp9SoPFrQvWWUshutuHAMYSvfDGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kmo2xAN9d/8CK2z7ZZKgZxxg3tLKijCZX6M0Ega3kDyYXQXSGNK8ku8QpDISJRO04yI6fQKDVeDQXFJeuEq3sArEansmphsMxMdGhfFXvkDSZRUH3K5mMtVhikgScclp2Vchbij65BwRYpEMVq8IZgHbdggSejEFvWO1M+kcEds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=tdjonn+Q; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id B63CF2E09474;
	Mon, 17 Mar 2025 17:54:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742226861;
	bh=YJycPDX/cjvicqrkGk+zll68e9CXw3i6IlVAGb9QQdQ=; h=From:To:Subject;
	b=tdjonn+Qjy546va6bpVsO06NYXkhes7cd6IflTkeON8DYBxyYmQpAJk+gZQE+qHPO
	 i8MMKnN+WJOqk1a2jvG7GtrZeriWll2/Bnv6KBNVshZV4xgeVJhCamX3tj6UPQcaHb
	 4Y/DbH7PUDlJ6fUa9ERxdcQ4wBEOJE2GBft1hka8=
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
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v5 11/13] platform/x86: oxpec: Follow reverse xmas convention
 for tt_toggle
Date: Mon, 17 Mar 2025 16:53:47 +0100
Message-ID: <20250317155349.1236188-12-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317155349.1236188-1-lkml@antheas.dev>
References: <20250317155349.1236188-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174222686128.25675.16028193768684724029@linux1587.grserver.gr>
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
index 14fa70652087b..39a29295f9cfe 100644
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


