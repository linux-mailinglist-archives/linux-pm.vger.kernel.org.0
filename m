Return-Path: <linux-pm+bounces-28524-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD15AD671C
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 07:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 806EA7A8F22
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 05:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65611DA60D;
	Thu, 12 Jun 2025 05:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iHvdsVAK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E442C1624EA;
	Thu, 12 Jun 2025 05:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749705149; cv=none; b=IJjfbwEvpBx+ysMWhQvXVgzeIXTkbDV8U+PUtXf6m1YEjXsLWV5SHU6dO6XP+rPxymnbgIuooUfGpx3Lk5wkMbCgeYqMXrwyCLH85Liep8wlZ6SHFzptHQ6altLsSwn/8EZvUU0Tuw092iLWq3Vbyf54rJBmnsjjrFxErdMyRPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749705149; c=relaxed/simple;
	bh=Uk8NoJXMqKCQMySusUG8IkaskY8HP0DNCxqK77i8ox8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HC0qcinrj/XPFSfZ6w4JRGzJs+dAPqGI/AYjZT+QoYzJ9t7m3+/a1v2CMd2I7uWEc525ONKQeUPMI5/YKEpUa6rwwt2ISm2Uur90yLYcNedhPVGXyNv2letBoSJ4holaVNxPJBqwrxk6DqEhlCWYHvoZdA5QNVgWKr+KJhY7gWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iHvdsVAK; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749705148; x=1781241148;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Uk8NoJXMqKCQMySusUG8IkaskY8HP0DNCxqK77i8ox8=;
  b=iHvdsVAKLXDzCtbKrTw3alEI/R7O4x1eo3Q+9llS2UgoWwIPpmqBILkt
   j78EAs6MnqKykDyVYZsnSVniuSlZDs9AUZBYX7Q1KDbgpGbkldyLCeeb3
   9ujdRYa1prq97IC52cns+nE0WryR/Zhs3FIiLpM0R1i77ZJnM2dwgTuTK
   tzVZaHUjJCk2bjwA34RkTIlwkvgdEWK22KdCJ8A+HrmHqPeGcvP1EmbRS
   ax1lC1s7Lc+rFrXFeV1Tve2lCcDxqnHwaEbc4/NQjGp1DA0lr7XSctokG
   QkZDfN7g3xRtlGShRjZTCz33QdYMyNidYYxdOoFu6OQqLbvdQDb8yh2/N
   g==;
X-CSE-ConnectionGUID: Ddgagn96Q0yieImEy6i2Yw==
X-CSE-MsgGUID: MNCJ5OfAR4SfNb/rsGec5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51087453"
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="51087453"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 22:12:27 -0700
X-CSE-ConnectionGUID: G1DwcKiNSP6bUW3bbdKbyQ==
X-CSE-MsgGUID: an/NkHhmRcKOY5ZIpStM4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="178366806"
Received: from wqiao.bj.intel.com ([10.238.158.145])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 22:12:24 -0700
From: Qiao Wei <wei.qiao@intel.com>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rui.zhang@intel.com,
	xiange.pi@intel.com,
	lili.li@intel.com,
	furong.zhou@intel.com,
	Qiao Wei <wei.qiao@intel.com>
Subject: [linux-drivers-review]  [PATCH] powercap: intel_rapl: Add support for Bartlett Lake platform
Date: Thu, 12 Jun 2025 12:45:38 +0800
Message-Id: <20250612044538.2970661-1-wei.qiao@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Bartlett Lake platform to the RAPL common driver.

Signed-off-by: Qiao Wei <wei.qiao@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index e3be40adc0d7a..c0789df34b2f7 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1261,6 +1261,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	X86_MATCH_VFM(INTEL_RAPTORLAKE,		&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,        &rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BARTLETTLAKE,	&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_METEORLAKE,		&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
-- 
2.34.1


