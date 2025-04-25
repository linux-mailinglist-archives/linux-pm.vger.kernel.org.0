Return-Path: <linux-pm+bounces-26252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AE8A9D265
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 21:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD1E1B618A5
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 19:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8382221F02;
	Fri, 25 Apr 2025 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LuPPHT1r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA1F21D5BB;
	Fri, 25 Apr 2025 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745610789; cv=none; b=JUVo2cL+ZgZ5IQ0HAH7MagF0HeCU+fTOC/S4S1d8Gma9vmtr94vn17PZxJrecPNKxA32ci3YLMZBuOj/cSjLweKpv+y5/PQvGVl2RBRv7XwrHolqR6VO6OE/hDQ4GeR7tvUEP7zZlITQTRuLJRh5EwCVL3KYsQXTeY36pPRxVUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745610789; c=relaxed/simple;
	bh=FXM4u1QTGVhh6FeAZsxRwVbUkGEm81xAVwIQ+cG/bII=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ji6CR6XpRfu59DwKq2Kv2zNJhM/RRIFfBwNIUGBzN1eJVjoC/W8Chiq8tBXdXK99ZqEvXKOfMk2zH7tu7Ex+S9j459NxychW/efOjs+P/iGDHG7h1X3SKdrbxmE2nxAPg0Ioie3igx/Q//7QUaP5OoLB8w+H+eSS5ESUusVrdcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LuPPHT1r; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745610788; x=1777146788;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=FXM4u1QTGVhh6FeAZsxRwVbUkGEm81xAVwIQ+cG/bII=;
  b=LuPPHT1rp4l9fR4L6EKKFjLlTwHtmk2TJMEjK1aNu2sUg39JKLi0OrCm
   jxOthxeEv+BZNG73QOStZyyc+MAlj8Fb5LdE2FXLv2a+YMqVSE+SDDWIs
   h1LV8y3MK+mYLM+kfktPGSR9lgzHI2mpIOgQVAq/RWBy42Z3mQO9NoZGU
   dfs5j3k/myjXgk3JE23hvkiODQ6+Zc/qa3YaiB3qdvaaS+KlI9OiOFAGb
   xCzwNtje5MRVLanJEOokpmoFK4bRog4WfLSxz/n5NL0osQnSdun8WTabx
   uZAxD+Kgx/X+z16g90cc7GG7o9em0No7dQZ99CCag0gOEhRjGDdOcA2vq
   w==;
X-CSE-ConnectionGUID: /SqF9kdWSnq4JeKwTe94LA==
X-CSE-MsgGUID: VKBzds1GSYSr1GE9uS2jbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="69776224"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="69776224"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 12:52:41 -0700
X-CSE-ConnectionGUID: /D3JZ9d5QHup4En5wnTF0g==
X-CSE-MsgGUID: 6Qb7FRXaTla1Oq/5XfR9Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="132897651"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.222.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 12:52:41 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 3/5] platform/x86:intel/pmc: Use devm for mutex_init
Date: Fri, 25 Apr 2025 12:52:31 -0700
Message-ID: <20250425195237.493129-4-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425195237.493129-1-xi.pardee@linux.intel.com>
References: <20250425195237.493129-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_mutex_init() to avoid accidental resource leak in the
future.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 2028a769cddb..db3fccca06fb 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1681,7 +1681,6 @@ static void pmc_core_clean_structure(struct platform_device *pdev)
 		pmt_telem_unregister_endpoint(pmcdev->punit_ep);
 
 	platform_set_drvdata(pdev, NULL);
-	mutex_destroy(&pmcdev->lock);
 }
 
 static int pmc_core_probe(struct platform_device *pdev)
@@ -1726,7 +1725,9 @@ static int pmc_core_probe(struct platform_device *pdev)
 	if (!pmcdev->pkgc_res_cnt)
 		return -ENOMEM;
 
-	mutex_init(&pmcdev->lock);
+	ret = devm_mutex_init(&pdev->dev, &pmcdev->lock);
+	if (ret)
+		return ret;
 
 	if (pmc_dev_info->init)
 		ret = pmc_dev_info->init(pmcdev, pmc_dev_info);
-- 
2.43.0


