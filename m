Return-Path: <linux-pm+bounces-13447-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552F496A561
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 19:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE861F244DA
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 17:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5442018DF6F;
	Tue,  3 Sep 2024 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0lhd9he"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A59C18BC3A;
	Tue,  3 Sep 2024 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384335; cv=none; b=MAK6mZpa+78Ic0NPowZKD0AD0EGmvcEolwUtV4CxV8ypyBrclJ8Yhm6OuiNPbyr9YdpTSndmCUH3uqHnqsUpXpjdvOPstp16L8ure+EhJcb4UDF8sLzWT/7ZsSMMlwJhr39Ft8QOiKomR6OBPWZyVorwfiCgxDNGShut/EORYGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384335; c=relaxed/simple;
	bh=3MF2YxDittRbFJxu2gHEoTOrMjXoYxLQH8bfqtJ612Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O93CMsu0mkg81FktpQyjgZRUZdLytjUOiVjsFXAaow9UW0krJoctCynazRgYbPkn+B5NVFncoUH26kipc+Y3Kop+kP19i7BW0eKD5adLJ2T/C+JfSpxHraJFI9LD5nnt3XSOWRKvysg3Md1TU53nC4+zrie7ufXQKWZCZUpaPqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0lhd9he; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725384333; x=1756920333;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3MF2YxDittRbFJxu2gHEoTOrMjXoYxLQH8bfqtJ612Y=;
  b=W0lhd9hekMvooVyrirT8zcO9ltJ6PFs29gLgWSFqr03+IECuTDxnCq+k
   do8JGMXgBF+D0I/w2Q91slHPh4V1s388KON+jxj+er+pwt/+9MeLvMxK+
   MMMjYMorDsLIKny/Tt4Bmjuk8QpRgzQ76We6NFSEZquFNRjwwlHqOAxK7
   9w7nmridJdOTmwrKlD0TXTQrvy+xKjnVV4RleSr+NeDdaWlp/iDwTad3e
   fBrA/9YpL+p7IH5a+E7mAPznni4j75o7nPkRtbsQWNI7peXkmLdWEDfL2
   C/ITfBNQJLA5TePdhbGSsReVySg2TxX/v9T9EeKIIl3urQ4HKHa+vJwy5
   g==;
X-CSE-ConnectionGUID: 8gBXwDGKTLW5QXLCg/nxeA==
X-CSE-MsgGUID: c2Yrjp13TWeEfA7jkoxc7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24189789"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="24189789"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 10:25:33 -0700
X-CSE-ConnectionGUID: 7mSEzJnBT8eg+NVyC8SVRw==
X-CSE-MsgGUID: fI4eDd62RQWzXg0Tobs2Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="65493874"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 03 Sep 2024 10:25:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9A15A48D; Tue, 03 Sep 2024 20:25:29 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v1 1/1] Documentation: PM: Discourage use of deprecated macros
Date: Tue,  3 Sep 2024 20:25:20 +0300
Message-ID: <20240903172520.3568731-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Documentation refers to some deprecated macros.
Update those parts accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/power/pci.rst        | 11 +++++------
 Documentation/power/runtime_pm.rst |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
index e2c1fb8a569a..9ebecb7b00b2 100644
--- a/Documentation/power/pci.rst
+++ b/Documentation/power/pci.rst
@@ -979,18 +979,17 @@ subsections can be defined as a separate function, it often is convenient to
 point two or more members of struct dev_pm_ops to the same routine.  There are
 a few convenience macros that can be used for this purpose.
 
-The SIMPLE_DEV_PM_OPS macro declares a struct dev_pm_ops object with one
+The DEFINE_SIMPLE_DEV_PM_OPS() declares a struct dev_pm_ops object with one
 suspend routine pointed to by the .suspend(), .freeze(), and .poweroff()
 members and one resume routine pointed to by the .resume(), .thaw(), and
 .restore() members.  The other function pointers in this struct dev_pm_ops are
 unset.
 
-The UNIVERSAL_DEV_PM_OPS macro is similar to SIMPLE_DEV_PM_OPS, but it
-additionally sets the .runtime_resume() pointer to the same value as
-.resume() (and .thaw(), and .restore()) and the .runtime_suspend() pointer to
-the same value as .suspend() (and .freeze() and .poweroff()).
+The DEFINE_RUNTIME_DEV_PM_OPS() is similar to DEFINE_SIMPLE_DEV_PM_OPS(), but it
+additionally sets the .runtime_resume() pointer to pm_runtime_force_resume()
+and the .runtime_suspend() pointer to pm_runtime_force_suspend().
 
-The SET_SYSTEM_SLEEP_PM_OPS can be used inside of a declaration of struct
+The SYSTEM_SLEEP_PM_OPS() can be used inside of a declaration of struct
 dev_pm_ops to indicate that one suspend routine is to be pointed to by the
 .suspend(), .freeze(), and .poweroff() members and one resume routine is to
 be pointed to by the .resume(), .thaw(), and .restore() members.
diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 5c4e730f38d0..53d1996460ab 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -811,8 +811,8 @@ subsystem-level dev_pm_ops structure.
 
 Device drivers that wish to use the same function as a system suspend, freeze,
 poweroff and runtime suspend callback, and similarly for system resume, thaw,
-restore, and runtime resume, can achieve this with the help of the
-UNIVERSAL_DEV_PM_OPS macro defined in include/linux/pm.h (possibly setting its
+restore, and runtime resume, can achieve similar behaviour with the help of the
+DEFINE_RUNTIME_DEV_PM_OPS() defined in include/linux/pm_runtime.h (possibly setting its
 last argument to NULL).
 
 8. "No-Callback" Devices
-- 
2.43.0.rc1.1336.g36b5255a03ac


