Return-Path: <linux-pm+bounces-25127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB69A847F9
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601224C83BE
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D079F1EB1A2;
	Thu, 10 Apr 2025 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HkvIGeOB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2BD1EA7F1
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299087; cv=none; b=H3HAp5u/JK72S0xFILJByjOil0a6lpZt5wVF8C151MLMqK+Xnl6tiZuEOvwHVrIQ40dMKvQ42Kex4luh99ON9X8Hs8Azncmgcc/SvJ7iwhGFM5ef9OL6dJipK+BWZygnp5UJ8uBUlqPRmHycpBfxHpg3GUZfTKv6sNrMgxPt79I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299087; c=relaxed/simple;
	bh=r3JTRn7aV4blg2a2YgRoIRk3Um3EVfph1TuyxH1KW2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QcMgiL414aN5aImiJucNiMRmA6nCSrPAKjI2DKyJ4nCrz9yhs+4YCbzqghrf6LB4AU5rGdB6Kd/Mehx6frALT6HNbQmGOp+5ZlAxKrtN11tb5VXPy9W+8lWued5Zkw8rrV7fjdC7tro0WEuG4yq+OuU+9HsGS7JToobC9cUoYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HkvIGeOB; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744299086; x=1775835086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r3JTRn7aV4blg2a2YgRoIRk3Um3EVfph1TuyxH1KW2I=;
  b=HkvIGeOB6vXTw2v3ACFGNgPx6B/hHRL3vWO/2CckruMCSsux/gcEVicT
   UtUSRE1eOFZxXOay94LsOuyCXbMvDO9FhVtLxhzxQBImCOyr6V9Rj0Ynz
   xjqUoIHbGTrnhxrpTcOJKUpXqxigAjTUBsgimGYEklvmh1Qd6oDNuMJWR
   kh4WQiu37NJU6JMGwy/u/JFnibm0Ve8Q+F/FSKE83C//iTZm48KJTrb36
   dd0qdiOeRZKUbMTsly7HJSS+ahAnciMOVO28S/fsT2gsCNVnagVZcgzM4
   s0myPA+oRC5iJ+Oxb4Sk/mBoE1ofL2uYbyPOFRKd9C6PjkN71q6qFovjZ
   w==;
X-CSE-ConnectionGUID: eIDtsrLxRaC+AiPht+4ohg==
X-CSE-MsgGUID: d5A+KR+wRbCPieOdG2fkfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56806970"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="56806970"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:31:24 -0700
X-CSE-ConnectionGUID: NRPbCnWaSfGxN5jR51laYA==
X-CSE-MsgGUID: p9XtM2HOSeSoykbzahdcLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129475387"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:31:22 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 614B3120B56;
	Thu, 10 Apr 2025 18:31:16 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1u2ts4-00HOeC-1C;
	Thu, 10 Apr 2025 18:31:16 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 7/7] Documentation: PM: *_autosuspend() functions update last busy time
Date: Thu, 10 Apr 2025 18:31:06 +0300
Message-Id: <20250410153106.4146265-8-sakari.ailus@linux.intel.com>
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

Document that the *_autosuspend() variants of the Runtime PM functions
update the last busy timestamp.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 Documentation/power/runtime_pm.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 91bc93422262..c8dbdb8595e5 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -887,7 +887,8 @@ instead of the non-autosuspend counterparts::
 
 Drivers may also continue to use the non-autosuspend helper functions; they
 will behave normally, which means sometimes taking the autosuspend delay into
-account (see pm_runtime_idle).
+account (see pm_runtime_idle). The autosuspend variants of the functions also
+call pm_runtime_mark_last_busy().
 
 Under some circumstances a driver or subsystem may want to prevent a device
 from autosuspending immediately, even though the usage counter is zero and the
-- 
2.39.5


