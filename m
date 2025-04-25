Return-Path: <linux-pm+bounces-26206-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158A4A9C744
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 13:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE1E4E0A59
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 11:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC981257ACA;
	Fri, 25 Apr 2025 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="PTMou2Km"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DA1256C8D;
	Fri, 25 Apr 2025 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579927; cv=none; b=msBMxDLaH+OTHLDUfTYod8jbFuqwc4Kgpqe3592nNGkvq0F3razYwuE09kLwAORHiVh/XT2VR8abAIHKN6mLO8BXPxksijgWd+LYp26DpQYRSno9vlY8FrKJ99RSe6VBbWT1oH/fZlQuwVvOQhUj/6n2cDSt8urylGJBHT3MGz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579927; c=relaxed/simple;
	bh=9oV0RAXjgZPgX4bJl0iXP3AyceiTlXZbI6u/9AcEd34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLingKbqVbnzhJPtq3KgL2nn4V0fCwONDc3ZKtgMNFEJy5i9LHoFOnO7HhGyoMIFWq19YISotbIj6LbzBxNH+O7gJ1liwV+NSYOJMHPZ+iPWpzu7gve4D1IXguYd9SyWrdh6lcweR8Y+/GFCHcMuR4v8dPbwHt49lU3zRWmV8JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=PTMou2Km; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a02:2149:8a3b:5a00:3490:6581:3910:8337])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 826992E08D31;
	Fri, 25 Apr 2025 14:18:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1745579923;
	bh=gXOg+mPEJn+J6EYJM9On4ifLChbXUraaMbSMCOiL9l0=; h=From:To:Subject;
	b=PTMou2KmxZkao9KQpoPxkTwmy9G4/O7+iOk0TGMijNP7XCqVLkOoH0bwWcSm5a6uW
	 GeeiafRYBGwLWcvgxr64FDBh1GecS57lUqMXRdmCc4GIHYEhmLT35x9lRBYNgn3v9I
	 TuKCmgokD8I7x9XQ7tzp1/7rrNEOkKb7zWyauD3c=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a02:2149:8a3b:5a00:3490:6581:3910:8337) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
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
Subject: [PATCH v10 12/16] platform/x86: oxpec: Follow reverse xmas convention
 for tt_toggle
Date: Fri, 25 Apr 2025 13:18:17 +0200
Message-ID: <20250425111821.88746-13-lkml@antheas.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425111821.88746-1-lkml@antheas.dev>
References: <20250425111821.88746-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174557992239.22999.6367353196272731325@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Since the rest of the driver follows this convention, apply it to the
tt_toggle attribute as well.

Suggested-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index 45dfe0a7578b7..96e9b7205be42 100644
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
2.49.0


