Return-Path: <linux-pm+bounces-17537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECF09C847D
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 09:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D4A2851F6
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 08:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275D21F6662;
	Thu, 14 Nov 2024 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdYQ8RmZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B811F472D
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571410; cv=none; b=AoEkvbX8QRmQMCAT/QXInykI2fSy/RLD5e6ASjor7tYYUg3cneL/kuwr4bOdp6ndm4V8c8u2BFyaqwRoE3agc1PimrkXAv3nOYDxYHRZqV6fv4muI3e+KDNpeHuxNeOAk9HtlCn2CA4xg8Pdze4kAF/RjL//H77lINhOTUvHydk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571410; c=relaxed/simple;
	bh=GOCLKdncHdxnmohDO1t6GgVGXQThOeaTrP17w3aGSBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QnjPvbmqt+PtnKQpJoufSqplr65uqanwHlTJyj2L5zMEBmMdQDsf8QSeYG3AMSgzZ4iOHW6TwquQxAHFxrlO8jbwoSvt79Iu0WAadgC8nfj/ImwsXN4H8A+SiIo6yVX6DNcMPJHAk/4JyWSYzTWGrLgxGrO++ORWCJHcSWGjQg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdYQ8RmZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731571409; x=1763107409;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GOCLKdncHdxnmohDO1t6GgVGXQThOeaTrP17w3aGSBo=;
  b=PdYQ8RmZ+N2/Gsye0J1+RqEHv5GVsWuVs3RHmPJ9M2jiYB0SjCwbnbR9
   QMAEkQknf1ZBh9GEFCltMAfiIX+TBV6GOAt6MQnFC9rbcKnK26/Ot+Uzm
   1MMn6Bpauhkv9DTww0Dp1LgbZvsCCTY8vPys9pA0LMD4bi7jIIHVr39rj
   8uSloZ0x38OzCgNhyAyI4G85GQQ3oGlYX5Y7R1mxHkPVW/KrI9adQjVj9
   ZJ3HjDzIPRn6gQArReFkl7+aKgF6sRFQLpQi5OENYzugoX9MD2pOUmjtk
   +BA9YDKs/ckvie9wUVmXkOrhm2CH5yuGJJx7DOUPoWufzuQxsENMUyQ7f
   g==;
X-CSE-ConnectionGUID: vscJDR9MROG491Pe52s9lg==
X-CSE-MsgGUID: 0ZuqCCy8RWW5a3ONTBhWUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="31600430"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="31600430"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 00:03:15 -0800
X-CSE-ConnectionGUID: u71eb2LwRFiZr44Qrqpz2A==
X-CSE-MsgGUID: r+CivyTqT8mbWLzymtbN7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="125627439"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa001.jf.intel.com with ESMTP; 14 Nov 2024 00:03:13 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 00/10] tools/power turbostat: Fixes, enabling and enhancements
Date: Thu, 14 Nov 2024 15:59:36 +0800
Message-ID: <20241114075946.118577-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patches in this patch series can be splitted into four parts, I sent
them in one series for easier tracking and review.

Patch 1/10 - 4/10	: Fix package cstate support for MTL/ARL/LNL.
Patch 5/10		: Enable turbostat support for GNR-D.
Patch 6/10		: Introduce a new approach to enhance platform
			  divergence description.
Patch 7/10 - 10/10	: Fix graphics support for some platforms that
			  enumerate GFX device as /sys/class/drm/card1

Zhang Rui (10):
  tools/power turbostat: Remove PC7/PC9 support on MTL
  tools/power turbostat: Add back PC8 support on Arrowlake
  tools/power turbostat: Rename arl_features to lnl_features
  tools/power turbostat: Remove PC3 support on Lunarlake
  tools/power turbostat: Add initial support for GraniteRapids-D
  tools/power turbostat: Enhance platform divergence description
  tools/power turbostat: Remove unnecessary fflush() call
  tools/power turbostat: Consolidate graphics sysfs access
  tools/power turbostat: Cache graphics sysfs file descriptors during probe
  tools/power turbostat: Add support for /sys/class/drm/card1

 tools/power/x86/turbostat/turbostat.c | 189 +++++++++++++-------------
 1 file changed, 95 insertions(+), 94 deletions(-)

-- 
2.43.0


