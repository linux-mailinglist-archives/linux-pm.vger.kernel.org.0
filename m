Return-Path: <linux-pm+bounces-26316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B185A9E908
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 09:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BADA87AA010
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 07:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9B41D5143;
	Mon, 28 Apr 2025 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K62NR+gB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334D62629C;
	Mon, 28 Apr 2025 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745824768; cv=none; b=LHP/2+wnUNsAirUkewHDcAN7Ly+zYmnACTXLUyTKAmF+oeuMVT7vJRubelmHppqMj+eT2kjtVtlt53cR2G64deNnNiMeNqjNvYo/HhGg0V1VnSMf2PEhFqvQHgz4sW9NG6WoowzE3OOAkcFngO6/02QWrBRnafnpHA9INjffES0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745824768; c=relaxed/simple;
	bh=kjJuCVb1OXyTVHk1tpMHkJNi+LXk9y6inCZx8XGo6dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SYG01jy3fTnqca9mK+fqZ7etoHIWx7PLlP9DENWFr4k4od2OtNjMMri0POitJDDS5qUZP6FRIm9yaNzU6RGiZQFaEwR6numoQvcOBUOBXIS34EtIGu90jXLjpNgcJHNEcUwZAFvSWtdWqf/rbH0gvFBXr/HVAscNT+9o4tYbEhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K62NR+gB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745824767; x=1777360767;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kjJuCVb1OXyTVHk1tpMHkJNi+LXk9y6inCZx8XGo6dQ=;
  b=K62NR+gBzpW6YPvVoyqg8hqNj0Byw8ZCPRw+oVlpK5SUGzt5zNtJ/I5v
   ZUwgh7TtiYKbejPZAgtiOjEXZFmz5RUT+09cP2afphR2pEPS4SgxWwnNI
   6LoYzjCKBVPRqfAZ8t7WSwJjp3FcR3GQ1JCECSrc/Ut3Asyo+aEK+tk8L
   1YB2rC6gR8+arGos0VOAwevOSruTfEpUl6owUw+88k38OVLttwugu64P8
   rE3U6A2V/bS91CahzSycjgP/8uR5fQ0eQW8fS0xtCI33jjiILBYEuOV92
   MsSPkc0qiOW746cUeTuQcOS12/DPae79ZXAMdInTtErePsQZ/nCFHf4VC
   w==;
X-CSE-ConnectionGUID: V6yODKmtT6azDcqXkssFSg==
X-CSE-MsgGUID: 3f4AeNPKQ5Wf7R+MZJg6pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="64936152"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="64936152"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 00:19:27 -0700
X-CSE-ConnectionGUID: QkXzL+kaQZ6XQwXB0iynMA==
X-CSE-MsgGUID: CZ8nBzBPRYSoVkuPkb3Z4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="137485721"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 28 Apr 2025 00:19:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D14B51BC; Mon, 28 Apr 2025 10:19:23 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [rft, PATCH v1 1/1] PM: Don't use "proxy" headers
Date: Mon, 28 Apr 2025 10:18:10 +0300
Message-ID: <20250428071922.3264455-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

It may fail some builds, let's wait for CIs to report any issues before
applying this. But I also encourage to test it locally as much as possible.

 include/linux/pm.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index f0bd8fbae4f2..8e1c37d40a90 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -8,14 +8,14 @@
 #ifndef _LINUX_PM_H
 #define _LINUX_PM_H
 
-#include <linux/export.h>
-#include <linux/list.h>
-#include <linux/workqueue.h>
-#include <linux/spinlock.h>
-#include <linux/wait.h>
-#include <linux/timer.h>
-#include <linux/hrtimer.h>
 #include <linux/completion.h>
+#include <linux/export.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/util_macros.h>
+#include <linux/wait.h>
+#include <linux/workqueue_types.h>
 
 /*
  * Callbacks for platform drivers to implement.
-- 
2.47.2


