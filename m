Return-Path: <linux-pm+bounces-14925-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76826989C85
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 10:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ECC4B236B5
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 08:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E0417B516;
	Mon, 30 Sep 2024 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EuPmUaFo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822E4175D4A;
	Mon, 30 Sep 2024 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684389; cv=none; b=ajTdsaXiMK5UCr+x3/rbC7s3b87MXlfSiCu6/7jEQnPLSs1MP78zmEO/CvzkX/2FtRA0NBDxyFjvgXv8SOJFrjrmb84Fk1dy5AicR2SW5Q4qcjhsbnAfS5OyJm3uRFL7y1Kdi9/nqIe+PBd27ZWLCE8XCyrvxqjnzGtlphVSM+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684389; c=relaxed/simple;
	bh=djrjqBdvWXVCFCoBhXiXbyrgzobGegM7KrS14RHA7AI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S+/Ebql5YviYjduSETUsSYQvzsB9n5zpbyO3EDp+uP5DFfJI5ziuBqgUtLFG+/tAWIZhy2hIKV6yAW94sp0jX3aeNjd+3o8kw08CI/cIkecGl9p2P2Rz0ULswHgJjGygcajhT4SFdQLXTsf0gKZns7AV13YrFk3JkofB+r6aaLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EuPmUaFo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727684387; x=1759220387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=djrjqBdvWXVCFCoBhXiXbyrgzobGegM7KrS14RHA7AI=;
  b=EuPmUaFoK9Jld9Td35G89oxSWtFAX9HibyIlqkrD8Ps37SvCSr8Ju4D4
   fzQhEZP9b1DH3J3z2rx9GIOAJwVA3VDswf0Ky3blQjGEN7DOCWOpqL2fa
   O9NcIvlQX2X7RP7d0sUC3bFE0ke+sbS1BV2/Z2gyKpon2m5iAAy/Kzn3/
   KsxP9aVyfpUiRNM09ckMsJsZ6kiPheGNNHjyGDripLW8lwFS9Mo857lak
   Az/98vhblBdqryPakKSALsa9qv4kbPdkpba2lkj5/txlAsBP2+uBKZyVD
   x0dfOjzYNNrcqbf+zMpN48qkgIqUU358KSAO98dpejTOnQVr+ILJNFW+C
   Q==;
X-CSE-ConnectionGUID: E+pJvgO5RFKpMhNqdmqY0w==
X-CSE-MsgGUID: XiePO0aUR/KUgrON6RMqvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26638957"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26638957"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 01:18:23 -0700
X-CSE-ConnectionGUID: oXsdmYS0TnOnvbYUIi0iZw==
X-CSE-MsgGUID: NKR/R/eCSlSb2rB9uIfSqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="96549416"
Received: from unknown (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.245.243.126])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 01:18:22 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@intel.com
Subject: [PATCH 1/6] powercap: intel_rapl_tpmi: Fix bogus register reading
Date: Mon, 30 Sep 2024 16:17:56 +0800
Message-Id: <20240930081801.28502-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930081801.28502-1-rui.zhang@intel.com>
References: <20240930081801.28502-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix bogus reading of the TPMI_RAPL_REG_DOMAIN_INFO register.

Cc: stable@vger.kernel.org
Fixes: 903eb9fb85e3 ("powercap: intel_rapl_tpmi: Fix System Domain probing")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_tpmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
index 947544e4d229..7435df083ea4 100644
--- a/drivers/powercap/intel_rapl_tpmi.c
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -181,7 +181,7 @@ static int parse_one_domain(struct tpmi_rapl_package *trp, u32 offset)
 			pr_warn(FW_BUG "System domain must support Domain Info register\n");
 			return -ENODEV;
 		}
-		tpmi_domain_info = readq(trp->base + offset + TPMI_RAPL_REG_DOMAIN_INFO);
+		tpmi_domain_info = readq(trp->base + offset + TPMI_RAPL_REG_DOMAIN_INFO * 8);
 		if (!(tpmi_domain_info & TPMI_RAPL_DOMAIN_ROOT))
 			return 0;
 		domain_type = RAPL_DOMAIN_PLATFORM;
-- 
2.34.1


