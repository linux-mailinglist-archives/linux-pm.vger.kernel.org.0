Return-Path: <linux-pm+bounces-23877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B62BA5CB65
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 17:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5968E17BF4D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 16:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49D92620F5;
	Tue, 11 Mar 2025 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="3ND2VWxW"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1CC261581;
	Tue, 11 Mar 2025 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712077; cv=none; b=Pz/qnHB4Sw/4UJ/REKYj3tULdKCtx60Fg7tPCz266r+x9izY8L/Lj/2YRntkkk61yCYllXj/YmlDVAbY7QBrI7mjFw9sqnZ6wCXvjk/eMaKgR1L84q4nHMIQkUmoMuEviDQaFTjm0BMZp43DtNhqafqz1xNoGzawUEE1zE9a7XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712077; c=relaxed/simple;
	bh=57bUtWkumIaNfzhU8UUldSsAdJwVHq1f+/iMLy2KNiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhJZpOwLA2+hrQ7tTgtH2hk6tCUDGYKbaFJ4a3KDye+MqF+mAKD1nppZ82UfiGImvud+yGw8dtJWuKR4KYUfv4syT4yJxe9R4aSXD6AXKpPdikQP5aya7/mpcU0xLo6zfPiT82OKpvr2QTTx1LLe8/+XqWHpKuW2QMaMT0tIvpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=3ND2VWxW; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id D9C562E0923D;
	Tue, 11 Mar 2025 18:54:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741712074;
	bh=EFhNmT7kyNtjQ1/AmOBtMWJ+TLTwebWeSRNPwES43Z8=; h=From:To:Subject;
	b=3ND2VWxW1Hc5edx/qW56OxHoaLIh301FXEqlTrzbEPBOCf4faflZeiu6XGvvdjEA4
	 1rTU5FOxDTGCYtdjy1/Xx0pMyGC2rtpAMDtiIVFcIH4bxKcRMRw9iFxorZVD/8BtmE
	 w3IG7r83hN7/lO2kspTBz2uVqzksgcUpAfl32RjM=
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
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v4 13/13] platform/x86: oxpec: Follow reverse xmas convention
 for tt_toggle
Date: Tue, 11 Mar 2025 17:54:05 +0100
Message-ID: <20250311165406.331046-14-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311165406.331046-1-lkml@antheas.dev>
References: <20250311165406.331046-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174171207410.20431.1423246787523265302@linux1587.grserver.gr>
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
index 273589f8b2fa..a3c945c73fc5 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -294,9 +294,9 @@ static const struct dmi_system_id dmi_table[] = {
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
@@ -408,8 +408,8 @@ static ssize_t tt_toggle_store(struct device *dev,
 			       struct device_attribute *attr, const char *buf,
 			       size_t count)
 {
-	int rval;
 	bool value;
+	int rval;
 
 	rval = kstrtobool(buf, &value);
 	if (rval)
@@ -430,8 +430,8 @@ static ssize_t tt_toggle_show(struct device *dev,
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


