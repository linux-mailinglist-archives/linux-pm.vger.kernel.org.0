Return-Path: <linux-pm+bounces-28228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CC6AD13AA
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32AB57A19E6
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD76A1AAE28;
	Sun,  8 Jun 2025 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ic6SRrMD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B843E1A3BD7
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749406735; cv=none; b=ZnkvdlG4t1o6M9RXW5J4cWl2lrhBB8+u21jkpDVWTsL3A/1crJhBRbuGgLfsMp8lCVILZ5x7Z+5xbTAAwS/U5dI4TAmof74URNtV+NAajhbkRiWIlLgWzLY0V+WGvpoRXQmlGgbYgifiTMUnVKrZnhrvdyRSOmZCbf/njfqTo4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749406735; c=relaxed/simple;
	bh=sajditXnCPs+3uQBec4lKwW6Skn+itKP2dzDmzLL/Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+8M2dZ2fbHdJpOfDB7G3VSjCRMfUy1i8QZelaN2X/OvQxKwyfd38QGojNLfN6vHR9GWkG1FpxwtrgoyK3xF/gmvjvpS7ZtxWGSeaibrT/DLVZ9KFppvtryTEGM/3lNfiT4w3AWiaSmt4GbZ188K+gOPYhsWNynx5xrtjuU0+So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ic6SRrMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE20EC4CEF1;
	Sun,  8 Jun 2025 18:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749406735;
	bh=sajditXnCPs+3uQBec4lKwW6Skn+itKP2dzDmzLL/Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=ic6SRrMD1BnTyP3GxOwBqUaBYTnEK+CngeRoCk/yhftNVmf+dFncLTjCllRBob0Cv
	 /kViJ4idyFt6+xTmuI+R0TWc2vzHTYDQx87fa7cOj38Psgn3LOf098ZewG8+QbYAR6
	 hN/pdjuGNdtKEzSsb8OsrYOFVKfWD/b++PWILFN3oCLYwdXUjVahMmaiq/joDUmOYj
	 xLu6TtzOXGQGFf6kp4GMxoTBCEZZiOGSmz5kC8s/89TDg/eG6G/B/iJJTVySZYKA/V
	 OY0wmaR9m8JrWbe5cW0GRna0bDDz3elDX3xz+Vk8xTsg+CezB4hGThIRIw4surKIym
	 gYmxraE6ICZLQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 03/18] tools/power turbostat: Add Android support for MSR device handling
Date: Sun,  8 Jun 2025 14:17:02 -0400
Message-ID: <63c94bab88575b5ca0eb87c89f8120a9b777551b.1749406068.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
References: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

It uses /dev/msrN device paths on Android instead of /dev/cpu/N/msr,
updates error messages and permission checks to reflect the Android
device path, and wraps platform-specific code with #if defined(ANDROID)
to ensure correct behavior on both Android and non-Android systems.
These changes improve compatibility and usability of turbostat on
Android devices.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 0170d3cc6819..3b418cae8812 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2140,13 +2140,20 @@ int get_msr_fd(int cpu)
 
 	if (fd)
 		return fd;
-
+#if defined(ANDROID)
+	sprintf(pathname, "/dev/msr%d", cpu);
+#else
 	sprintf(pathname, "/dev/cpu/%d/msr", cpu);
+#endif
 	fd = open(pathname, O_RDONLY);
 	if (fd < 0)
+#if defined(ANDROID)
+		err(-1, "%s open failed, try chown or chmod +r /dev/msr*, "
+		    "or run with --no-msr, or run as root", pathname);
+#else
 		err(-1, "%s open failed, try chown or chmod +r /dev/cpu/*/msr, "
 		    "or run with --no-msr, or run as root", pathname);
-
+#endif
 	fd_percpu[cpu] = fd;
 
 	return fd;
@@ -6476,8 +6483,11 @@ void check_dev_msr()
 
 	if (no_msr)
 		return;
-
+#if defined(ANDROID)
+	sprintf(pathname, "/dev/msr%d", base_cpu);
+#else
 	sprintf(pathname, "/dev/cpu/%d/msr", base_cpu);
+#endif
 	if (stat(pathname, &sb))
 		if (system("/sbin/modprobe msr > /dev/null 2>&1"))
 			no_msr = 1;
@@ -6527,7 +6537,11 @@ void check_msr_permission(void)
 	failed += check_for_cap_sys_rawio();
 
 	/* test file permissions */
+#if defined(ANDROID)
+	sprintf(pathname, "/dev/msr%d", base_cpu);
+#else
 	sprintf(pathname, "/dev/cpu/%d/msr", base_cpu);
+#endif
 	if (euidaccess(pathname, R_OK)) {
 		failed++;
 	}
-- 
2.45.2


