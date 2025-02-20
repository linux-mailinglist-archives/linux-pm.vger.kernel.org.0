Return-Path: <linux-pm+bounces-22553-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DDAA3DF0C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 16:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B438173F51
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 15:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6F61F3B8A;
	Thu, 20 Feb 2025 15:43:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C321DF754
	for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066191; cv=none; b=IN4Yz2mRCZp2NUbNWWa4+DDpzOo1VmzgX1WqLopc5/UxONYq0i5Gqv+EG84Jzw2Q4EBE/iHch3j41I7dFyhQKGXNkNNANBh0z1L7TF1hCoi9hhlRYrO4j4/2kclEtFU/kfSDpFqpfbKYV4lSygEZPg0gKMsz1W7jXygAcRNbl3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066191; c=relaxed/simple;
	bh=TErIgVBIfS3+0uQn6yLtH31m8P6kCxh4lr3WvXD/+lI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bstMgf5Uw50wW9v0gmj5ChQGYAdVSeGqE+u03l4Hoc6o28uRMlL1riVYkWTFHKPgKjCxrxU2KFezVRnkIHBdMGLfQxIo8UpvQiRn6WpmhtyjlcKrvExuPHkhuNm/RyEOgkCr03BQ6XTz7XPRP2QcHdr7twPK9UYu7JK3cmttzjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: 74gXIxEmSAOIdxQMFhHBVQ==
X-CSE-MsgGUID: 9KtNBZNgQbyzS8OHffSBzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40775674"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="40775674"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 07:43:09 -0800
X-CSE-ConnectionGUID: WxLD+e5yTTCSECL+aAbfHQ==
X-CSE-MsgGUID: bszZSfO+SYa8sCcpY7/DKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="120173927"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmviesa004.fm.intel.com with ESMTP; 20 Feb 2025 07:43:07 -0800
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [RFC PATCH 0/1] x86: msr: add new 'msr_pkg_cst_config_control.h' header
Date: Thu, 20 Feb 2025 17:43:05 +0200
Message-ID: <20250220154306.2166129-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

In this patch I am trying to implement the suggestion from Rafael Wysocki
that can be found here:
https://patches.linaro.org/project/linux-pm/patch/20250212084232.2349984-1-dedekind1@gmail.com/

The suggestion is basically to have common wrappers for accessing
MSR_PKG_CST_CONFIG_CONTROL in order to make it clear there are multiple
users of the MSR.

I was not sure how to implement this, and here is what came to mind. Just
an RFC to demonstate the approach, please comment/criticize.

Just to linux-pm at this point, also avoid splitting on multiple patches for now.

This patch applies on top of the following patch-set that I sent to linux-pm
a bit earlier today:
"[PATCH v2 0/3] intel_idle: Add C1 demotion on/off sysfs knob"
https://lore.kernel.org/linux-pm/20250220151702.2153579-1-dedekind1@gmail.com/T/#t


Artem Bityutskiy (1):
  x86: msr: add new 'msr_pkg_cst_config_control.h' header

 .../include/asm/msr_pkg_cst_config_control.h  | 28 +++++++++++++++++++
 drivers/idle/intel_idle.c                     | 17 +++++------
 drivers/platform/x86/intel/pmc/cnp.c          | 13 +++++----
 3 files changed, 44 insertions(+), 14 deletions(-)
 create mode 100644 arch/x86/include/asm/msr_pkg_cst_config_control.h

-- 
2.47.1


