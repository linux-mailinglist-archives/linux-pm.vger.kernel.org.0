Return-Path: <linux-pm+bounces-25123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D9DA847E8
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687647B1203
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EC91E9900;
	Thu, 10 Apr 2025 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VPvxZyd/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36272193077
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299084; cv=none; b=ZUdqt0pNELesiXtuSExnypRiq9Dc75e+oJZxv5toBrPeiWDEIcuDGQ8ehIbCQa3KLqsPiPOgUDQmEbMXhwyb3u61QBH5X3TwD+Z1vmOmtKnbZX0nC4flpy0Zf3oG09aYlDB03mcXPK2LjOkXqQJnC7+tsOBFtjYqRUH72LoreaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299084; c=relaxed/simple;
	bh=W8crODUB8xrSpQVtSCP9b1nV0htDp1pQSBDRemQY/0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uh6KiiAHmyxu2ekfhGNF8LwioWgxvOV/ddvmLBl17qwe82GrgRxlg5eTfrRaG9CcgA+4ch7UY63bxiUxEJW2NhmWgbfpVfJhYKULOhniw7rjAAbvkl7eJi5VKGbf1SSqUawvtE0pvf8wfpf4esTVCK8UWxUT2p3zpmrDujA7F0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VPvxZyd/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744299082; x=1775835082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W8crODUB8xrSpQVtSCP9b1nV0htDp1pQSBDRemQY/0k=;
  b=VPvxZyd/iIdnCVU2TDLcPeFVUg4StaTCpF0yIr8496b0fgOhn1qlWxJW
   WIRvQGpfU9wwmJayj2lb0yr6Xxj9tYATlez2RoV19B1o9linVrK5okq1J
   sS+L5zmJK8zmoiUI6Hjeaxw4fQoko425ax943AG8mzQWvR03dxXF7mrBG
   rV2SvcO4EyjVvcc81O37E/v7U3GIn++YklKq+Z/NTHdGfxQcVSuXsNaf1
   6dR7YMtHzYtMFPqPCBlwxLe58sPUDLzWTcoKwxHBIF18EV2ug/RyTj966
   M6b9XM/Mzf1qQ/iR+mLkhfM5xXaFlf3E1Lz8NRm87pz5bkc6ixFaZVoY1
   w==;
X-CSE-ConnectionGUID: eH9V0DItTXaxy8I6RZN8TQ==
X-CSE-MsgGUID: /rcg6Yc9R7C4LTa8tdy+ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56806945"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="56806945"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:31:22 -0700
X-CSE-ConnectionGUID: X87sOONnRXSQf2OLAe4lZQ==
X-CSE-MsgGUID: eYN/pWflRNWMnoxY9vGsPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129475363"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:31:19 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 4673811FA2F;
	Thu, 10 Apr 2025 18:31:16 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1u2ts4-00HOdi-0n;
	Thu, 10 Apr 2025 18:31:16 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 1/7] Documentation: pm: runtime: Fix a reference to pm_runtime_autosuspend()
Date: Thu, 10 Apr 2025 18:31:00 +0300
Message-Id: <20250410153106.4146265-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410153106.4146265-1-sakari.ailus@linux.intel.com>
References: <20250410153106.4146265-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_autosuspend() got accidentally renamed as
__pm_runtime_autosuspend() whereas the intention in the patch was to
rename pm_runtime_put_autosuspend() only. Fix it.

Fixes: b7d46644e554 ("PM: runtime: Add pm_runtime_put_autosuspend() replacement")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 Documentation/power/runtime_pm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 12f429359a82..63344bea8393 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -154,7 +154,7 @@ suspending the device are satisfied) and to queue up a suspend request for the
 device in that case.  If there is no idle callback, or if the callback returns
 0, then the PM core will attempt to carry out a runtime suspend of the device,
 also respecting devices configured for autosuspend.  In essence this means a
-call to __pm_runtime_autosuspend() (do note that drivers needs to update the
+call to pm_runtime_autosuspend() (do note that drivers needs to update the
 device last busy mark, pm_runtime_mark_last_busy(), to control the delay under
 this circumstance).  To prevent this (for example, if the callback routine has
 started a delayed suspend), the routine must return a non-zero value.  Negative
-- 
2.39.5


