Return-Path: <linux-pm+bounces-17535-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647BA9C847C
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 09:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2F9285211
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 08:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3601F26FE;
	Thu, 14 Nov 2024 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SE+aiGs1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6389E22611
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571408; cv=none; b=k4mi5F+7CfrghjgfdS87EV3Ldb7bFbYs6tE+dvuGWIBPlhHdGWOrTosI2SxE1ZS+kJK1AAwXMCPfg98ZHz70zQfQysFLXqd1i+2HErWvFo5nlKGBS3R4gR0iYaZbkwZ8UPfaoE7TAh/dC3lgxupjHePVtUBTfrJ7m48wt6FYHJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571408; c=relaxed/simple;
	bh=mqq16BB3dav1v6eYCRi3tewiK5s984dApyqhmuEXKSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFUb9CNNAa36IrFyM+b+JXuWxEhzw28fnb/Gos7x6fTh4F8fWOQ6w2WH7eqm0H5mwU4DkHJn6YmVA4+20Ee1db2Qv8CCY3GlEq/J2vu9d1xnbxPPR6NkRThvtQXIXc92GCSvkjz01OViK8VE7Ox8Kq4jmMMeBICiQCl+1dWmLOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SE+aiGs1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731571406; x=1763107406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mqq16BB3dav1v6eYCRi3tewiK5s984dApyqhmuEXKSA=;
  b=SE+aiGs1xZnc3ejMySa1hC0JuAT+fHEY9ugqKF9xM3gTyg+IIhZcYkhK
   DBpSy8x28v1fAmqAwfJ15wUrtSZmdJAtDvEdbl5eOl78JP35TQLVlDms4
   lshZ/b72TGdPLxfJOqQGWU/78YvHBIqBYXjt95F6U3lwyQxBzYFlDCjSF
   4ZjS6iUPmA8MNFCizsMhxqKIeHuefCKRtqXlXjlYMuGxbVnkxA2Jwu+4h
   uJUUSX3aUfJjw08EP2e9GGcYKL5asayWheBRbZxQDXOz5F4WfPwgOALih
   y3ThIVIKrL6n/VaVyAjMGD272N91jc28aynAiqnu6dgkBWktfHmedQKbT
   w==;
X-CSE-ConnectionGUID: xksjIXlJQC2Qq37ExUIROQ==
X-CSE-MsgGUID: q3RBJxTZQqKyz+2UmC9Xow==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="31600435"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="31600435"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 00:03:18 -0800
X-CSE-ConnectionGUID: 182Bm0bFT8q35gPv6L6eLg==
X-CSE-MsgGUID: FCgBtD4ET8mbbw6a/c9MLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="125627458"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa001.jf.intel.com with ESMTP; 14 Nov 2024 00:03:17 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 03/10] tools/power turbostat: Rename arl_features to lnl_features
Date: Thu, 14 Nov 2024 15:59:39 +0800
Message-ID: <20241114075946.118577-4-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114075946.118577-1-rui.zhang@intel.com>
References: <20241114075946.118577-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As ARL shares the same features with ADL/RPL/MTL, now 'arl_features' is
used by Lunarlake platform only.

Rename 'arl_features' to 'lnl_features'.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index b35f63c2b206..3d59718516df 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -746,7 +746,7 @@ static const struct platform_features adl_features = {
 	.enable_tsc_tweak = 1,
 };
 
-static const struct platform_features arl_features = {
+static const struct platform_features lnl_features = {
 	.has_msr_misc_feature_control = 1,
 	.has_msr_misc_pwr_mgmt = 1,
 	.has_nhm_msrs = 1,
@@ -1008,7 +1008,7 @@ static const struct platform_data turbostat_pdata[] = {
 	{ INTEL_ARROWLAKE_H, &adl_features },
 	{ INTEL_ARROWLAKE_U, &adl_features },
 	{ INTEL_ARROWLAKE, &adl_features },
-	{ INTEL_LUNARLAKE_M, &arl_features },
+	{ INTEL_LUNARLAKE_M, &lnl_features },
 	{ INTEL_ATOM_SILVERMONT, &slv_features },
 	{ INTEL_ATOM_SILVERMONT_D, &slvd_features },
 	{ INTEL_ATOM_AIRMONT, &amt_features },
-- 
2.43.0


