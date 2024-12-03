Return-Path: <linux-pm+bounces-18417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEDD9E14D0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 09:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5075E16467C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 07:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7CF1D6190;
	Tue,  3 Dec 2024 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQdEiLJv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C592F1BF37;
	Tue,  3 Dec 2024 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212684; cv=none; b=kBrItB2BhcDm8WKQHSYEIXyRwVzC+FRU1GEqOU1+I1X7QSQDB8Tize7b1csBgUDgtqHy4W1Z1pn0iN3i09AHxEZcEKLMjP9EMeiCVYmUyFDJX10PfTBYpj6ZG5y2QUFgYveZKBiKgOGg/6cD06W8YZT0V9yNn1HmCB+FK2sWq3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212684; c=relaxed/simple;
	bh=AYhzktHIpN0H0i3c0KwBUtebGe4o5ems8V+u+KsIEwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxTjIL8hQmOc+4uNdmmlznadqX0jLQezqcSPDzdKmudF0Qagz7zB420bP4Y2V0Ac+wOlo9nSv3t52VlhzG+uz+IrniVeml6ZzMEnR5nmV7J0XoXYSNENQlSugegL+WdBAnRXySyj8SQNGkfUkpdqcrUPPK5YNVSwElxERnjOD1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQdEiLJv; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733212683; x=1764748683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AYhzktHIpN0H0i3c0KwBUtebGe4o5ems8V+u+KsIEwI=;
  b=lQdEiLJvCVy8m+XgAdLa7RUIRlGgKWC8uBrxcVEUzCt3pNNQYLLNLC67
   QVFk/D26ufLi0eW2kUQAl/qvL4AW6K/8s9YhSqWi8gaQ6UrHqnxJg0Mya
   cf0YNrZ00OxLzsB73Zm+UaP5knN3OGDuNlcG40LbGP9mfYLZfgR6FFlpq
   3Yyh+rpr3lTaZL11rKKfZ82PZjSIiRKbwsrm0KL0CTSCcYjslNnt6q6Dr
   vinIyvFYICfs8MZGEV2ix80GJeMxcaOzRaGnaHHOIaPQ10l2PkOECJ2wC
   ZWJ8sZsEGAo2qLxwcGZixnSAr0qD8wmCTM1Fbgya05NITu0i1nddD3gz1
   Q==;
X-CSE-ConnectionGUID: lsSALG79Q3S1P0UIWGheZQ==
X-CSE-MsgGUID: ivK3Qd7eQiWOrnDn65f4xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="32758207"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="32758207"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 23:58:02 -0800
X-CSE-ConnectionGUID: st5EKtuAQiySUMqP5AYKgw==
X-CSE-MsgGUID: 8hbzFvEITnmz6ObIg2wZow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93759602"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa007.jf.intel.com with ESMTP; 02 Dec 2024 23:58:01 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@intel.com
Subject: [PATCH 1/3] powercap: intel_rapl: Add support for PantherLake platform
Date: Tue,  3 Dec 2024 15:58:00 +0800
Message-ID: <20241203075802.584741-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203075802.584741-1-rui.zhang@intel.com>
References: <20241203075802.584741-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for PantherLake platform to the RAPL common driver.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 5e793b80fd6b..77d75e1f14a9 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1265,6 +1265,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&rapl_defaults_spr_server),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_ARROWLAKE,		&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&rapl_defaults_core),
-- 
2.43.0


