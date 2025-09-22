Return-Path: <linux-pm+bounces-35147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39B1B8F0EB
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 07:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A729E179AC6
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 05:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABF82405E8;
	Mon, 22 Sep 2025 05:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcZuYk8B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE69C23D7FD
	for <linux-pm@vger.kernel.org>; Mon, 22 Sep 2025 05:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758520458; cv=none; b=bnQWaTytHkOaI3LYcFR7MtjLMsyqab+wroA1zSymgvQJnLgznnOFfrZ1KPrKtJCU+LpmOHQbA7R8bnDRkFJOJTJh1LXvOGZ8RSzMZCFgI8xudH7zTFgLXlDcLhoXgh1jU2YkN/+BrQy9DVcFb1azDSUbTSdAhXJoSU5mY3KlJMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758520458; c=relaxed/simple;
	bh=VyLXFmxjQL/T7ttuWvthLSUwd6JH3dSpFJpdszk3/5U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IB4T3l7+lNVh2lt5livCD97FEEBKOmioQZl/rx58Op/WutxxzEXhUJcBdmeo1OxIw9LmDtrtL5NRU+mQZJ25VXac7+D6oTU1qsxTaCvp35E02g1Q/XJ6DtgpS6UVgLkTy2tVxYPk1RsQOH+11o9RjMfdQWfWv4aSqVQWtKDC9ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcZuYk8B; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758520456; x=1790056456;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VyLXFmxjQL/T7ttuWvthLSUwd6JH3dSpFJpdszk3/5U=;
  b=jcZuYk8BYw90eWfD3ZtQVYxjgQtUQJYDC84GyP97tMeLM+khJu4C2XHE
   7UM+zfDNrcSTmS8AG0JTCCy8FFnRFdx2eXa7xcFRJ+DuZNWaGCG2wb+5P
   GN8BNM4089c+stMuRbM1xI2qyIOdEPnx7bPSlmiUgu/7eFXmICyZc7rsL
   dmdd/CZ3rKt3NktuP8htbXrD3tgRBMBd8e/2k6A9AvnC0plFBBIP7l1Pp
   zCGphnoWqU2lRt2d7bR47Caq0HVoliJDNk1P6oY2f5xPzYsXsg9a9kqM4
   iyPqhjIWPmZOvkUfHPAA4W29vF/6I3v/zvm1ljjGZ/IfuVsA3QZl7Pf2p
   w==;
X-CSE-ConnectionGUID: vnyq65koTWGT6nhoD3/WCg==
X-CSE-MsgGUID: qxE6Qt7YTzOciAKZ5SM8+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64578788"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64578788"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2025 22:54:15 -0700
X-CSE-ConnectionGUID: dDfNFzIWSe6rmcHjj0DyNA==
X-CSE-MsgGUID: uCWl1FzTSaGLgOQ0UIpJmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="176765948"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa008.fm.intel.com with ESMTP; 21 Sep 2025 22:54:13 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: rafael@kernel.org,
	pavel@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] PM: Replace snprintf() with scnprintf() in show_trace_dev_match()
Date: Mon, 22 Sep 2025 11:22:31 +0530
Message-Id: <20250922055231.3523680-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace snprintf() with scnprintf() in show_trace_dev_match() to simplify
buffer length handling. The scnprintf() function returns the number of
characters actually written (excluding the null terminator), which
eliminates the need for manual length checking and clamping.

This change removes the redundant size check since scnprintf() guarantees
that the return value will never exceed the buffer size, making the code
cleaner and less error-prone.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/base/power/trace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index cd6e559648b2..d8da7195bb00 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -238,10 +238,8 @@ int show_trace_dev_match(char *buf, size_t size)
 		unsigned int hash = hash_string(DEVSEED, dev_name(dev),
 						DEVHASH);
 		if (hash == value) {
-			int len = snprintf(buf, size, "%s\n",
+			int len = scnprintf(buf, size, "%s\n",
 					    dev_driver_string(dev));
-			if (len > size)
-				len = size;
 			buf += len;
 			ret += len;
 			size -= len;
-- 
2.34.1


