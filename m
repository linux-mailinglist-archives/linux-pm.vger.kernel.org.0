Return-Path: <linux-pm+bounces-17536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5659C847E
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 09:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6233DB22C03
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 08:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CC41F584F;
	Thu, 14 Nov 2024 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eevRHBWu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29291E8857
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571409; cv=none; b=dKeJH5FDssuFUVz+g7RF85jQZksfH/rbbq0xEOy2CL0TCscKftz0NFNI43hhJfaL5j74imbJ8eQD+dfBWSO/O7hRXZvIQiNURE7YIX9jrpHmMbbMYkE8jyCpOiy8xoHsEjfpxEUiXu6PsTK20e0TzyiaflZvI+oD+tPPkzxmzgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571409; c=relaxed/simple;
	bh=IQjSfD8xjGG2y6k7Z3sum460fevHAohcPX5rFtkmUQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbRbWb/1OWxImt2xF8QqEE5rMyljKJih+xQ5i/plp2lerJh6Lt1Y7sk1N75JIkh0efERHe1PBYCWDk6Vjzj1Devu48lXFeAb+pjcn5GtP9o53RrgCtUrD9zzVHlXoqadIg5NpMJXxRmy5iEDne+c1L29HxQHrCX0GApHValfToo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eevRHBWu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731571408; x=1763107408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IQjSfD8xjGG2y6k7Z3sum460fevHAohcPX5rFtkmUQw=;
  b=eevRHBWuN/cLiZWvnbTax8mm5L376e+WuVK6Vusw8ID1flDjrlh6/FAU
   VX6BsLlB1SulCJ2SP7NTHxbgFIvNtwH+A9BVuki8iVxmBn1lf2m6kVnWM
   Ufg6oUGNTM5QO6YTh5HOZ89CEIZPKgMeExgQjAT9/Ow7bhC4YlsTLfwnE
   b2IPXUEJPPQ0XMjn1OJE8oyZea2w03W47eFT2uI3ll1JxaJd2Jk7HXU3+
   DdgNbLDMX3OiXAYa+TV3YW0Wp/U8p/KA3dKpapgabHZhoBJIk6gjsnQR3
   HdNerembGBxAXIws3JM8cvGmBTz5gW52lp/KUsBX8uy1mq/tR3EbnID6Q
   g==;
X-CSE-ConnectionGUID: brB03X7/TVy2XZpbNbuvSg==
X-CSE-MsgGUID: ZVTYpCCETRmgbs9Nu+TnLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="31600437"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="31600437"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 00:03:19 -0800
X-CSE-ConnectionGUID: gQ1k/PmrRkSdJmHudPPOfA==
X-CSE-MsgGUID: FxZ5mvL+SIamuUa/7s/nuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="125627463"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa001.jf.intel.com with ESMTP; 14 Nov 2024 00:03:18 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 04/10] tools/power turbostat: Remove PC3 support on Lunarlake
Date: Thu, 14 Nov 2024 15:59:40 +0800
Message-ID: <20241114075946.118577-5-rui.zhang@intel.com>
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

Lunarlake supports CC1/CC6/CC7/PC2/PC6/PC10.

Remove PC3 support on Lunarlake.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 3d59718516df..9d76329e108f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -752,7 +752,7 @@ static const struct platform_features lnl_features = {
 	.has_nhm_msrs = 1,
 	.has_config_tdp = 1,
 	.bclk_freq = BCLK_100MHZ,
-	.supported_cstates = CC1 | CC6 | CC7 | PC2 | PC3 | PC6 | PC10,
+	.supported_cstates = CC1 | CC6 | CC7 | PC2 | PC6 | PC10,
 	.cst_limit = CST_LIMIT_HSW,
 	.has_irtl_msrs = 1,
 	.has_msr_core_c1_res = 1,
-- 
2.43.0


