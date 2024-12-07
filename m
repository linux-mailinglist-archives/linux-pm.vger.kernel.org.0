Return-Path: <linux-pm+bounces-18731-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574489E7E5B
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 06:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267BE1886971
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 05:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3115D3B2BB;
	Sat,  7 Dec 2024 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cAYtLiMW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7515417591;
	Sat,  7 Dec 2024 05:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733549775; cv=none; b=J2+x2N6o28zw1O1Lx7Si7SczJdlJCdg/crAmrVCRkqOq/AQ9iNqm8EEcE8BlAyjRFQsmF2LrzH8zHireX1Wtf1MrKBkwrHTDme8ajT1hgBCT/qZeOvWHqLISs0JKMH0xmLu0+1qRP6CZy1Vb8J0M+DFNISE4A20E6ty1tbOuNh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733549775; c=relaxed/simple;
	bh=+yRSj6GRFOWxoWuK3Il3KSTjNFZjPfYyI1wc9bDf4iI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fuTj85kRkasa8JHb7IVo9VLb2jsr7esMtDz4B6UgOLHtHK0mIuH1XSJRiDMDrFsx1OZoDfOx6dv3D/Y8C0bAzXm7+GRE7on2Wfcs/csLSfycIFcnedIKcDCxKingUehkz0iqHgSN292YgitOsK0cWa4KgeAdnOqLPRgsFu1/NeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cAYtLiMW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733549774; x=1765085774;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+yRSj6GRFOWxoWuK3Il3KSTjNFZjPfYyI1wc9bDf4iI=;
  b=cAYtLiMWB6gtxkDKpyaUqFoKPHGoeQ21IpDgQK4UBf9ld+1lsEfGHupj
   lTleFUyyNTfqOyuvkrfrsKUTCAMbnmZg8rjncHMweQAjjuOfvBVE8yTsX
   GIqdFGekSf7PlT8ry7pC5PCammPBA7DHdlZviocMbpjzFnfLjCJgxcFFp
   lA466xqGDzBSFPK7p7yOtu2bceF9LDiT+1u3i5GEMyvzATd4M6+EQqrIH
   OmrbbIgJFX9umyVH0fctW+imYFozoKIb9WouW1k9qqkb/pFJltaK9N5yy
   rRriTkfH9Z2QBOJ07g2A59KW6aQ9yiRlngEELiFqnjfikbkMGB8MaN+9H
   w==;
X-CSE-ConnectionGUID: q6NC12xnQNil4rz/yV0gjA==
X-CSE-MsgGUID: cRpeP/DnSCO5Ro0YDO45CA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="37590259"
X-IronPort-AV: E=Sophos;i="6.12,215,1728975600"; 
   d="scan'208";a="37590259"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 21:36:13 -0800
X-CSE-ConnectionGUID: c9vjnAEHSLCvnh8rsHnhnA==
X-CSE-MsgGUID: X6kS6u4eRh65sjcOjZebdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,215,1728975600"; 
   d="scan'208";a="99543367"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.221.37])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 21:36:11 -0800
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	rajvi0912@gmail.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/3] Add Arrow Lake U/H support
Date: Fri,  6 Dec 2024 21:35:50 -0800
Message-ID: <20241207053607.14806-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series contains three patches to add Arrow Lake
U/H support in intel_pmc_core driver. The first two patches
are preparation patches.

v2->v1:
- Create an info structure for platform variation information
- Make generic init function to static in tgl.c
- Fix typo

Xi Pardee (3):
  platform/x86:intel/pmc: Make tgl_core_generic_init() static
  platform/x86:intel/pmc: Create info structure for pmc device
  platform/x86/intel/pmc: Add Arrow Lake U/H support to intel_pmc_core
    driver

 drivers/platform/x86/intel/pmc/arl.c  | 64 +++++++++++++++++++++++----
 drivers/platform/x86/intel/pmc/core.c |  2 +
 drivers/platform/x86/intel/pmc/core.h | 17 ++++++-
 drivers/platform/x86/intel/pmc/tgl.c  | 45 ++++++++++---------
 4 files changed, 98 insertions(+), 30 deletions(-)

-- 
2.43.0


