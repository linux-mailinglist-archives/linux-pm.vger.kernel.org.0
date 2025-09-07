Return-Path: <linux-pm+bounces-34102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5B4B479EE
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 11:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DD03A40CD
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 09:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075151E47C5;
	Sun,  7 Sep 2025 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYc2PJyr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7816763B9
	for <linux-pm@vger.kernel.org>; Sun,  7 Sep 2025 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757235680; cv=none; b=bSU4hKmMhePlhaUPMsQcgOEwmmZS/PMxliQ9HUQi+4f+cBfXEr91P6XsziuXr/H/ASSfd3FgKXPmwmDooQv0Lr+eYS5N4320zhj+96+zeNvwrI3vhXxQSCKJxbf0HOqpJDe5ffbFpLjKqXhpi+6m9qHtgcQrUX234We8sP+Bx+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757235680; c=relaxed/simple;
	bh=s1e29xJIgh8+0XFpjLHLQNBIFbgjLtA+CfZlV1psxi4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ktn9H4OULuIjzLTMowoKw4ZRitqBl3VFI1GZ4PqoWyG5KXmdz4OVkwKrKPt+kI9w9c05w3oNnVfJAnbIZBYZGu5aRUHEJM2UlGUdeIEDpGu7GaSnYsqpv0YyjZNSrS3xjf4T3jQ52QMPl6bZSMCFmtdGKm2mDnwvryxLdidgH6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYc2PJyr; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757235679; x=1788771679;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s1e29xJIgh8+0XFpjLHLQNBIFbgjLtA+CfZlV1psxi4=;
  b=ZYc2PJyrEfLVrPcsOtz2/e+ansq0SOrpqVFe5+IL/RYsvFeku0ZD9j1y
   ntXHVhJnsKblCF3xN2ks66aqXx1z5FFwLAcKSk6K7isljiYHDiwY1nQ9U
   vSe2K6GasG5Vobu1E/b/QcTxeU6IDsJuChKjH0+Ap9hWrkcJhV1YJNQn+
   7dFLknvztg6P26NHikp5Ilx0rGjdZ5wWlF2N20Ma0q8tilCJIueZA2ST4
   /k/OlZPnP+nhUmmojW37xzAHnJtW0QyeiAwWzCwlv1XN7qAgnQ8LT6CFr
   zZms9eYpg93VWq2//lNGujZWeN0vC9WLBrElIr8o/G+fpnm+7hVCGLXKe
   w==;
X-CSE-ConnectionGUID: UwpC4ujsSoy/MkVroRtCbA==
X-CSE-MsgGUID: zkxd6KnRRCq1Vg1V08/c7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="63346753"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="63346753"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 02:01:19 -0700
X-CSE-ConnectionGUID: u81vSBzxQwSmo+MsTq6h9w==
X-CSE-MsgGUID: 0CS6culnQPaf+w8Q5ZJK3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="171716234"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa006.jf.intel.com with ESMTP; 07 Sep 2025 02:01:16 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] PM / devfreq: Fix memory leak in devfreq_event_add_edev()
Date: Sun,  7 Sep 2025 14:29:42 +0530
Message-Id: <20250907085942.3278910-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing kfree() call to prevent memory leak when device_register()
fails in devfreq_event_add_edev(). The allocated edev structure was not
being freed in the error path, causing a memory leak.

When device_register() fails, the edev structure allocated earlier in
the function needs to be freed before calling put_device() to avoid
leaking memory.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/devfreq/devfreq-event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 70219099c604..f0e7c31fac5e 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -327,6 +327,7 @@ struct devfreq_event_dev *devfreq_event_add_edev(struct device *dev,
 	dev_set_name(&edev->dev, "event%d", atomic_inc_return(&event_no));
 	ret = device_register(&edev->dev);
 	if (ret < 0) {
+		kfree(edev);
 		put_device(&edev->dev);
 		return ERR_PTR(ret);
 	}
-- 
2.34.1


