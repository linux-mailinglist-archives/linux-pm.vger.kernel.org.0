Return-Path: <linux-pm+bounces-14924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F60E989C84
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 10:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16AF81F218D4
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 08:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BB817AE1C;
	Mon, 30 Sep 2024 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4h8bmgY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E6917332C;
	Mon, 30 Sep 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684388; cv=none; b=ALDvQEeN9NkDsDPSiUA6LNDNuprYkMDh4nxvki9NIuCuTr01NAvaNnQllQv3du5o37CpWwQ5pJTgJOAr+TOGQlQ774E3eozD/+pun8crb0QfdijdpAeVFmIY9scZG2znR6esL0trDftlR9O6vHCmtLlnEplnn+U9NdgU/tEfpZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684388; c=relaxed/simple;
	bh=4/kv4xuuAssiaJWp3aR7UmCyBAmTbEbnR7t2qfrVUmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ep/29htPSyLa6i9f6qQISdyz9T0BKObBNYQCO3c5YNehBZ+xWOvuJbegtQmKAu2/5dQr+Jc6Mx/bvsKFLfUUiFI9WCg3zP0TZ+D4xObSdwc2p2k2jbqXkbGx0UFG6vZJItd3cvkMv2oaHlrMfrd3t2V66gAoA6MBlNm1JJd8wE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4h8bmgY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727684387; x=1759220387;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4/kv4xuuAssiaJWp3aR7UmCyBAmTbEbnR7t2qfrVUmQ=;
  b=U4h8bmgYJ5YehK0piyKvGt2sBELZ+rcRS1fzoQLneWPP5pNhw7E0F66P
   1HwwuN9YcZTNK05R+z5Qy03V4fB4giqZ6oIFPmokykWZvDMQxqSkWdZTG
   1+MOFiIm+h2bmAJODqxbE5E6IUZM7HeBRLC/vWa+biZZNBLnvjPCvH7fJ
   8u+jikG2+nn3FnuuCoEczhXd+NRLHqFUPasWiGfNCoCGiEUsdhSwckme9
   buAmPJ2jNhPO+/zz2zDCX6YideZB1fxwAXcul727l97IrWYbp7KhX9/nh
   Qzb8xRoYZd8hUUuC+Aj0sdLyPX4R37dwAwzo1SGbIS4+2XbLN2bGE0+le
   A==;
X-CSE-ConnectionGUID: N7CaCnrLRnan/BpedeLm+Q==
X-CSE-MsgGUID: GSq2MjvESV2hfiHmNOcUPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26638952"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26638952"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 01:18:22 -0700
X-CSE-ConnectionGUID: UyTa7iUkTKmstZT0ZbJnDA==
X-CSE-MsgGUID: tV0t+r7VSW2/AVzSjaf9Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="96549403"
Received: from unknown (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.245.243.126])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 01:18:20 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@intel.com
Subject: [PATCH 0/6] thermal/rapl: fixes, improvements and cleanups
Date: Mon, 30 Sep 2024 16:17:55 +0800
Message-Id: <20240930081801.28502-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patches in this series are independent of each other. Keep them in
one series just for easy review and tracking.

Patch 1/6 fixes a bug introduced recently. In my test, reading the
domain info at a bogus address returns all 'f'. So the psys domain is
always probed both before and after the broke commit and there should be
no visible impact.

Patch 2/6 fixes a WARNING since 6.11-rc1. But the underlying problem is
there since the proc thermal driver was introduced. Lastest code still
handles it but with an extra WARNING. So I'm not sure if this should be
considered as -stable material or not.

Patch 3 - 6 are general improvements and cleanups.

thanks,
rui

Sumeet Pawnikar (1):
  powercap: intel_rapl_msr: Add PL4 support for Arrowlake-U

Zhang Rui (5):
  powercap: intel_rapl_tpmi: Fix bogus register reading
  thermal: proc_thermal: Fix WARNING during module unload
  powercap: intel_rapl_tpmi: Ignore minor version change
  thermal: proc_thermal: Remove MMIO RAPL cpu hotplug support
  thermal: proc_thermal: Add MMIO RAPL PL4 support

 drivers/powercap/intel_rapl_msr.c             |  1 +
 drivers/powercap/intel_rapl_tpmi.c            | 19 +++--
 .../processor_thermal_device_pci.c            |  2 -
 .../int340x_thermal/processor_thermal_rapl.c  | 70 +++++++------------
 4 files changed, 40 insertions(+), 52 deletions(-)

-- 
2.34.1


