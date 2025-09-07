Return-Path: <linux-pm+bounces-34104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D3AB47B01
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 13:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E173B74BF
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 11:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF32262D0C;
	Sun,  7 Sep 2025 11:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7p7aB5Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7061DF26A
	for <linux-pm@vger.kernel.org>; Sun,  7 Sep 2025 11:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757244879; cv=none; b=AMA8CFGKEDf/J7m0GcdNgy7yDA4g48UBU5XIWtmsxdguvq6nOXpRcvTFjreNsNZhpyqPXV+MzCrr13CSkDF3bWAWnJyw+wG2wGxLib+advwP1omPaJAZFkpdpU+icJ1hEoSgmeEWxlIBANo02sxsC79FtIukCqKrrazpzIwL7d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757244879; c=relaxed/simple;
	bh=rJbZOTRsaEUpakw39IRu09gmMwLRuwdon6ZJcnGjHo4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O57pMVJSS8u5SydoAqpj2Qj6GTNVPuA1p16SdOg/GtxhSqHsFak74R2qircANqK4tZZk2/hByl8tG+18pFbRrdikADYW6OjSM9LzBbkYuSzY85dIvSWz5lToMcloBTwIlmYrefFXmn2PESbUY2rwmlOeFOeBXNo18CAbsNMuP/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7p7aB5Q; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757244878; x=1788780878;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rJbZOTRsaEUpakw39IRu09gmMwLRuwdon6ZJcnGjHo4=;
  b=Y7p7aB5QBU+csfqFYSHsDWG24hHWFPijGHFpA9eIq3ODh2Xye957eD6N
   48cvM7RE5aSi0z8E7bJzrGQY7LvwMQDZQUmz3jOyQV4aGSjyTxr/0WXvT
   JfHHYrODVnPE2DUq7CC/QLIBOxBPres1NhWIEnQ7VCslK9u5xDFmHeZFt
   5Ptj5qcFeG+HawYcVliELEAlLMC9gIU+IfwhGy6xWIS6IdsdUugl8J18s
   3EmV3MqlH0P3pOJqNY94q6o10ohPVip3ocXNcGHDZeplTTNeezaRYB73i
   XqSmH3GeXO/ExBl0CzMBifygSVtPfgGGWD2J5jo6+qXp3agk2uaHAbG87
   Q==;
X-CSE-ConnectionGUID: SO0JnCS5TXS3TJ9o3ryRSw==
X-CSE-MsgGUID: dcQDdpcDQNOr+I+UolcBpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="58561049"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="58561049"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 04:34:37 -0700
X-CSE-ConnectionGUID: 88fktzqnSA+RiH9aL/t7ew==
X-CSE-MsgGUID: 9UokLOQKTUKdmq7ffplS6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="203343193"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by orviesa002.jf.intel.com with ESMTP; 07 Sep 2025 04:34:36 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH v2] PM / devfreq: Fix memory leak in devfreq_event_add_edev()
Date: Sun,  7 Sep 2025 17:03:02 +0530
Message-Id: <20250907113302.3353584-1-kaushlendra.kumar@intel.com>
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
Changes in v2:
- moved kfree after put_device based on review feedback
---
 drivers/devfreq/devfreq-event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 70219099c604..34406c52b845 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -328,6 +328,7 @@ struct devfreq_event_dev *devfreq_event_add_edev(struct device *dev,
 	ret = device_register(&edev->dev);
 	if (ret < 0) {
 		put_device(&edev->dev);
+		kfree(edev);
 		return ERR_PTR(ret);
 	}
 	dev_set_drvdata(&edev->dev, edev);
-- 
2.34.1


