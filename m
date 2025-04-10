Return-Path: <linux-pm+bounces-25126-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D79A847EC
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C60188975A
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F9D1CB31D;
	Thu, 10 Apr 2025 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KK2S89T/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16A91E9B38
	for <linux-pm@vger.kernel.org>; Thu, 10 Apr 2025 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299087; cv=none; b=LGkGduGAiMC8ZkhRu6S2psAmxWXCE9sS4Vr4eic1Rgf6eQldyJy+Nh93lJWcvm9BYt4Ykvh0UR5UCswJ2npfSGpuSnTFdgYm4ePyl90ppOeXruy2ZWRxJ2Ss9hMU6qkolWtvPtINxigakhAICnFedl4MkFZzO3TqdRX97eqX/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299087; c=relaxed/simple;
	bh=97YXpv+Ga08IsvhLpGZpF63VVEvQFRQJdt/ZPfIQw40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H8gilf3dZW9X3EfrHrMV9kmSP35olQJCFkzEhxpP5g/1iqkJ2/DEeiDEu+uTINTh4FuvOamAgikZW49X3htrRXFwtUAV7yZwKKILqHQjwN7VJe9VuKhRkek1prDkBCoJq1lMONZyaFdTcG22zLa7+RcIsJJ93OyWngWyRJBcfig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KK2S89T/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744299086; x=1775835086;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=97YXpv+Ga08IsvhLpGZpF63VVEvQFRQJdt/ZPfIQw40=;
  b=KK2S89T/79/RBYDJk8EAWiYPyZ3iTvbzk6PbeLuvZcj0j2R8gz/zn8/g
   MYSouZHciGyGKMVUM6bok6vI9fsEjHC9TDkpDyKGhJ2saCxZLSGvidAr0
   7cYx2HY8d7FRq+f2rbbDXAuNvmPNZEsaF1Ce0a++xzmOv9s1q3rWoatIA
   HrbDgceDGjpIsTyMBmo3j+OVhecYx/AGZrBlT35czFz6a9rMO5VUhLzcg
   41SP2rxc3hVrCcqP/Lnp6pfSYC6cP9Aw68fAN0hWJ7BIT9hbNy/279rYP
   TxHScxpVCLSG4KTvwbbTAlYV9WN34rgJME7pJU1BiwCv0UuMPso6sczeM
   Q==;
X-CSE-ConnectionGUID: TRihKoVXRuWj3vSnuFn5bQ==
X-CSE-MsgGUID: 8gFYE42kSBSBy7E1n87VRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56806959"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="56806959"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:31:22 -0700
X-CSE-ConnectionGUID: sHYl+QPrRWiOeig/+XR8Fg==
X-CSE-MsgGUID: nFnRNaw7RvOFikZsASptkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129475365"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:31:19 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 4596111F74E;
	Thu, 10 Apr 2025 18:31:16 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1u2ts4-00HOdf-0f;
	Thu, 10 Apr 2025 18:31:16 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 0/7] Update last busy timestamp in Runtime PM autosuspend callbacks
Date: Thu, 10 Apr 2025 18:30:59 +0300
Message-Id: <20250410153106.4146265-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Folks,

The original plan for adding pm_runtime_mark_last_busy() calls to
functions dealing with Runtime PM autosuspend originally included a few
intermediate steps of driver conversion, including the use of recently
added __pm_runtime_put_autosuspend(). The review of the set converting the
users first to __pm_runtime_put_autosuspend() concluded this wasn't
necessary. See
<URL:https://lore.kernel.org/all/20241004094101.113349-1-sakari.ailus@linux.intel.com/>.

This set extends the inclusion of the pm_runtime_mark_last_busy() call to
the _autosuspend() variants of the Runtime PM functions dealing with
suspending devices, i.e. pm_runtime_put_autosuspend(),
pm_runtime_put_sync_autosuspend(), pm_runtime_autosuspend() and
pm_request_autosuspend(). This will introduce, for a brief amount of time,
unnecessary calls to pm_runtime_mark_last_busy() but this wasn't seen as
an issue. Also, all users of these functions, including those that did not
call pm_runtime_mark_last_busy(), will now include that call. Presumably
in the vast majority of the cases a missing call would have been a bug.

Once this set is merged, I'll post further patches to remove the extra
pm_runtime_mark_last_busy() calls. The current set of these patches is
here
<URL:https://git.kernel.org/pub/scm/linux/kernel/git/sailus/linux-next.git/log/?h=pm-direct-on-next>.

It'd be best to have all merged within the same cycle.

The changes in the patches to remove the pm_runtime_mark_last_busy() calls
have been generated using the following Coccinelle spatch:

@@
expression E;
identifier label, rval;
@@
- pm_runtime_mark_last_busy(E);
...
(
  label:
|
)
...
(
  pm_runtime_put_autosuspend(E);
|
  pm_runtime_put_sync_autosuspend(E);
|
  pm_runtime_autosuspend(E);
|
  pm_request_autosuspend(E);
|
  (void)pm_runtime_put_autosuspend(E);
|
  (void)pm_runtime_put_sync_autosuspend(E);
|
  (void)pm_runtime_autosuspend(E);
|
  (void)pm_request_autosuspend(E);
|
  return pm_runtime_put_autosuspend(E);
|
  return pm_runtime_put_sync_autosuspend(E);
|
  return pm_runtime_autosuspend(E);
|
  return pm_request_autosuspend(E);
|
  rval = pm_runtime_put_autosuspend(E);
|
  rval = pm_runtime_put_sync_autosuspend(E);
|
  rval = pm_runtime_autosuspend(E);
|
  rval = pm_request_autosuspend(E);
)

Sakari Ailus (7):
  Documentation: pm: runtime: Fix a reference to
    pm_runtime_autosuspend()
  pm: runtime: Document return values of suspend related API functions
  pm: runtime: Mark last busy stamp in pm_runtime_put_autosuspend()
  pm: runtime: Mark last busy stamp in pm_runtime_put_sync_autosuspend()
  pm: runtime: Mark last busy stamp in pm_runtime_autosuspend()
  pm: runtime: Mark last busy stamp in pm_request_autosuspend()
  Documentation: PM: *_autosuspend() functions update last busy time

 Documentation/power/runtime_pm.rst |  50 ++++----
 include/linux/pm_runtime.h         | 187 +++++++++++++++++++++++++----
 2 files changed, 186 insertions(+), 51 deletions(-)

-- 
2.39.5


