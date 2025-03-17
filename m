Return-Path: <linux-pm+bounces-24187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF46A6545E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 15:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA7E1891C82
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 14:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221382405F8;
	Mon, 17 Mar 2025 14:54:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BDB1C861C
	for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223274; cv=none; b=odQ66dr3WXWRN/R54gaHBNDKfZZHJjHawO8vNoYaShe6wFEq3S4vBcA5DYI/mbiCzikVRHQlYFucH1nWcKiD1wsNn0h6fKrEV3HkKtQoaK9d6vuwQ9jmt/ENa83mMYrYYgHf/MT3iLsNf87HPfEjtRtiyyeY307mxd9HMUJ3IPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223274; c=relaxed/simple;
	bh=SMdfojPdC+WWjxgfc5tO1ZAAMB55YjJ8tIY4qjK1aro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SPg7VkZaHXrmCR53yljLbtLtWMrpyUwFwsPP7qE1lYd9zogr91bCioyoL/oE0qKbmETv92A/4r0IVlDpPfk9gCN8Rq28N5KK2e7GCRO/5aU+LiBaAXlUldtljI/9vvoNfzrG4tGlkEvqsILirI2nIktvXxdxVEzf6BUOxqgWEcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: Q5lrX2KyTXSlhXA2MPSjew==
X-CSE-MsgGUID: OhZTWXCvTHybu/kM+ET/iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="60711785"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="60711785"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 07:54:32 -0700
X-CSE-ConnectionGUID: zQr1KsKvR+eRXuOLop4aPg==
X-CSE-MsgGUID: L2pYiJd5TLSs/vW/dx2fGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="121682631"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by orviesa009.jf.intel.com with ESMTP; 17 Mar 2025 07:54:31 -0700
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [RFC PATCH v2 0/1] Add a header for MSR_PKG_CST_CONFIG_CONTROL
Date: Mon, 17 Mar 2025 16:54:29 +0200
Message-ID: <20250317145430.2153013-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Implement a suggestion from Rafael Wysocki. Previous version of the RFC:
https://lore.kernel.org/linux-pm/20250220154306.2166129-1-dedekind1@gmail.com/T/#t

The suggestion is to add a common helper for switching the C1 demotion feature
on/off via MSR_PKG_CST_CONFIG_CONTROL.

Still RFC because I feel like the common helper is not universal enough, because
the bit number was different on the Lincroft platform, and the MSR is not
architectural, so may change from platform to platform.

Therefore, just to linux-pm as RFC so far, and as a single patch.

This patch applies on top of the following patch-set that I sent to linux-pm
a bit earlier today:

Subject: [PATCH v3 0/3] intel_idle: Add C1 demotion on/off sysfs knob
Link: https://lore.kernel.org/linux-pm/20250317135541.1471754-1-dedekind1@gmail.com/T/#t


Artem Bityutskiy (1):
  x86: msr: add 'msr_pkg_cst_config_control.h' header

 .../include/asm/msr_pkg_cst_config_control.h  | 41 +++++++++++++++++++
 drivers/idle/intel_idle.c                     | 10 +----
 drivers/platform/x86/intel/pmc/cnp.c          |  7 ++--
 3 files changed, 46 insertions(+), 12 deletions(-)
 create mode 100644 arch/x86/include/asm/msr_pkg_cst_config_control.h

-- 
2.48.1


