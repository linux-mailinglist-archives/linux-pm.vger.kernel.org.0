Return-Path: <linux-pm+bounces-28778-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70525ADA800
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 08:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D451890D8E
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 06:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB29E1DDC23;
	Mon, 16 Jun 2025 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTj1cXAy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B291C861D
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 06:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750054342; cv=none; b=HqXzvBmFICHnqLYewGGwBPyo0WUAYWiLp7g9lAjQs0WSyke/KmwT4vxzEVqRNwC3yqkwelatFcbC15D9EtMl/TdxNmCF+a/w5T+O0kNnQunE5VAt4QtnTCMjXkr6O9KD7TGakZ3sKyONseWvHuhkZD40lFhUN9TFUXB1JRWK/mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750054342; c=relaxed/simple;
	bh=dRZMztbuDZ/HyaVvMdEUmz3wkZsnTB/SO+gxzGDL6j4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UP9l1YI63fZxbO5GkYJxlm0N6cUJFdGPAwZ6DcyZyHbYKmjrfS9zWT/+YzCtGjOGAEnvaIVR182GRpbsih+Q1S69dO1eZli/GvguaeeMQ5joka+3vUGY4Ju85FgYpjP5zNVNKKB/TA4NyUp6Q5Wasa7qoT2vtOxU1NdwEpWs6Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTj1cXAy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750054341; x=1781590341;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dRZMztbuDZ/HyaVvMdEUmz3wkZsnTB/SO+gxzGDL6j4=;
  b=bTj1cXAyeXma8GJ0x8I83jLz9Tm1bj/D3okErw56zhiljeR6TzaVOJE0
   hqU2PiJvhPbE2o7fVKQLLWkxnHKgGX2DQd0Qrdt10V0OTyW1/ugNPv0mf
   cqa6zYvEgmsIGJ+DR+c+y32gARyQIpHL7PLYjj3Jn4Me/0TmIHgNWIPlV
   202pPlVzZUqZ0hZxoqIoau0kQd70gpvPvG5aG0/8xV3YjSboEIVrNtWzM
   ST+DmhJ6Y/uzEAmhTXQh7W4VMHUIoc3XInWNZGc2XC6QSdUMr2HIR2SrP
   6UwS+j3wUexxFh91aFhjF6+sdBqf+kE8kMI5B2nFSYU1WjWFeX2C5RVYs
   g==;
X-CSE-ConnectionGUID: UAalnppIRAm41JWHj9OxTw==
X-CSE-MsgGUID: 2T4X7MRoSbGQmsLsH5sWAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52278229"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="52278229"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:12:18 -0700
X-CSE-ConnectionGUID: 8kzd4GqfTDeDYoj8OeG66w==
X-CSE-MsgGUID: +KPbH6CuRa+y4IeIr/Df3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148928081"
Received: from agladkov-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.40])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:12:17 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 16ED111F94F;
	Mon, 16 Jun 2025 09:12:14 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uR34n-009atJ-0k;
	Mon, 16 Jun 2025 09:12:13 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 0/6] Update last busy timestamp in Runtime PM autosuspend callbacks
Date: Mon, 16 Jun 2025 09:12:06 +0300
Message-Id: <20250616061212.2286741-1-sakari.ailus@linux.intel.com>
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

Rafael: any thoughts on the merging? Would an immutable branch on top of
rc1 be an option? The patches apply cleanly on v6.16-rc1, v6.16-rc2 and
linux-next.

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

since v1:

- kernel-doc fix in patch "pm: runtime: Mark last busy stamp in
  pm_runtime_put_sync_autosuspend()".

- Dropped the first patch which has been merged already.

Sakari Ailus (6):
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


