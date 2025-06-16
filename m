Return-Path: <linux-pm+bounces-28782-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A498ADA803
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 08:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B903AEE9D
	for <lists+linux-pm@lfdr.de>; Mon, 16 Jun 2025 06:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D1D1DE892;
	Mon, 16 Jun 2025 06:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZnjRSKY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B51DE3BB
	for <linux-pm@vger.kernel.org>; Mon, 16 Jun 2025 06:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750054344; cv=none; b=TImIpQHL8S0U7v31XpapxqtSw+hiKI2getfKiKmHHprwyNNF2roYNY/+mb18i/qYYkNU3ZNHCUQQg6M3AwGIBQzrN8q3jlh223PneYRydvcvjhIro9/cHOTW7JLHZJpqv3th31tE30KPab5Zph2tJMh5HBF6uohLak5RKOvk0O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750054344; c=relaxed/simple;
	bh=lNNQKRTZDWocR9Mg3HhKNKxnqdf9OYtzvoNaBZG8KZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l1i7zQN9MZlCY61AZl8qxsKFfgj0a4Zx2nFcnHi0NwJcm9DZLIVwMZzL9E9HnMG3yeeaquZwYLByioFVfGA4cYKvxXykszWDs+QIOidOcSBRiRGEUBAYeywvx7bsCpEpDXFoi4PmtBu8IZRbAvMKQMBSm7EfE5Lyrs/7GLpvepk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZnjRSKY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750054343; x=1781590343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lNNQKRTZDWocR9Mg3HhKNKxnqdf9OYtzvoNaBZG8KZU=;
  b=nZnjRSKYaqfViOKLN2XH5K2iL4f3dmYAzOSKyT5bQSiiOzo0fJ42gEKf
   4anFNVOOm90Pq2zBYEC4Z8xh845w18qQ3hNx6D5Ljkl87GK3DupgBm/Ye
   2rxGSfz/Xk9kkheTrwLVB65Uj0B8XtOsUTDR6gAQp0uu8cy0N5vlr6Ak2
   BTWdXIE/TTKOW+vImy7X5YC4uTuUAJFsKo/fROKbD3ffYEjb3BpnOczpQ
   tJLDn6cNufEbfybHPznPd/zEY1pnR5KKwJHeFhzA4bEl5kzOV/M2VhEFX
   RGemuE2gqTwkaLJ0fngZdB2WFCP74lz15fhfxvuSvVvnwOKiYZg1zVhVn
   g==;
X-CSE-ConnectionGUID: QdIGE7FYRb2ax53jF625AA==
X-CSE-MsgGUID: PAUcrI6+Ry+9z8KWcTACXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52278241"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="52278241"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:12:21 -0700
X-CSE-ConnectionGUID: lpQGnc3zQ9O1ic9YEp3U5Q==
X-CSE-MsgGUID: RMWhAMLcSK+UnPQLjYnE6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="148928098"
Received: from agladkov-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.40])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 23:12:21 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 2157D122166;
	Mon, 16 Jun 2025 09:12:14 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uR34n-009atj-19;
	Mon, 16 Jun 2025 09:12:13 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 6/6] Documentation: PM: *_autosuspend() functions update last busy time
Date: Mon, 16 Jun 2025 09:12:12 +0300
Message-Id: <20250616061212.2286741-7-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250616061212.2286741-1-sakari.ailus@linux.intel.com>
References: <20250616061212.2286741-1-sakari.ailus@linux.intel.com>
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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


