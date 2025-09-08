Return-Path: <linux-pm+bounces-34121-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BCCB48340
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 06:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5540017873A
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 04:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5D5214228;
	Mon,  8 Sep 2025 04:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rd5gvOsv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FCF155389
	for <linux-pm@vger.kernel.org>; Mon,  8 Sep 2025 04:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757305539; cv=none; b=pl4GoQNm8yX4JKPACkEeAbIy1IJsVs6A6mW2AObG1RW4OElh4dUYhTLAZf4H+5SOtvejj0lVFQPxyRc0OA7STlB847hwuz+X3hIo7LcZLxqhnfEcSHHPb5hst0jgn2qizdWPtezTr/sZP6DkOd1qaDzWDLBnPHFP3tF8xHEYOdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757305539; c=relaxed/simple;
	bh=JJY+81scHQDcFtsyZt373VhbFQrp10HPkYPme3UNHdU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WtwK6dWv0DHiWXzku6pr6o7AcVVPFW3LJ9VaH8zcwonO3xbSlq0fE8Ao5Kz+umvM3vGmXWskqcdEH97uqMI6VoL2C8jf2piFR4mdRkyw4mkDcA2FklmUsq3RhgyBy7+cAD533eccVUTf2A889kAy7sHGGJVxoq8IXw4q3vbM+pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rd5gvOsv; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757305537; x=1788841537;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JJY+81scHQDcFtsyZt373VhbFQrp10HPkYPme3UNHdU=;
  b=Rd5gvOsv2x/+Ar5lX2jT100RCQGgoXeT+G40CMQl63sM+7Y8imp7m1rU
   5zSSqSWSdzsd6k4lQ4aMJVO++qzwLLCGd+lyvWzi6T4/3ysaRa0scmx9x
   LyBJLEX1nUqBzuArQ2PYXMXsgK4UWlj1EvZDNEcaLVwV7JtpyuraPLZo5
   ZBfhkhId2VnjEHe2/+YduWDVDsoUOMlJSOrlyVMY7kc6W0Z7TqbgJnYnl
   gIpo5AxCOopK7HG0C3NeppO3CIOVCtZw6T5whGasS6wivW9M8SISXSfpf
   P/oUZZAtPgdvZhXsypRdCrdms3iqMWhckOydbn94gIfeikBRMDTSH5ZQ3
   g==;
X-CSE-ConnectionGUID: BjEQ1irKRHCvN75sp2WxdA==
X-CSE-MsgGUID: y3Uzv8/XQnq3FZrvn1PzNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="70173789"
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="70173789"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 21:25:36 -0700
X-CSE-ConnectionGUID: FJX2hoVdRMqPP8pHa0Mv3Q==
X-CSE-MsgGUID: WlhpJ7KUTx+jaqQ+EvvbFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="203642121"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa001.fm.intel.com with ESMTP; 07 Sep 2025 21:25:35 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] PM / devfreq: Fix error code propagation in devm_devfreq_event_add_edev()
Date: Mon,  8 Sep 2025 09:54:02 +0530
Message-Id: <20250908042402.3404408-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect error code return in devm_devfreq_event_add_edev() when
devfreq_event_add_edev() fails. The function was unconditionally
returning -ENOMEM regardless of the actual error returned by
devfreq_event_add_edev().

The devfreq_event_add_edev() function can fail for various reasons:
- Invalid parameters (-EINVAL)
- Memory allocation failure (-ENOMEM)
- Device registration failure (various error codes)

This change ensures that callers receive the accurate error information,
improving error handling and debugging capabilities in the devfreq
event subsystem.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/devfreq/devfreq-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 70219099c604..32194c60dfc7 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -403,7 +403,7 @@ struct devfreq_event_dev *devm_devfreq_event_add_edev(struct device *dev,
 	edev = devfreq_event_add_edev(dev, desc);
 	if (IS_ERR(edev)) {
 		devres_free(ptr);
-		return ERR_PTR(-ENOMEM);
+		return edev;
 	}
 
 	*ptr = edev;
-- 
2.34.1


