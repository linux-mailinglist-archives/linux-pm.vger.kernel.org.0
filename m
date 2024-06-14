Return-Path: <linux-pm+bounces-9213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1945F909397
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 23:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BEA281837
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 21:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE65145A05;
	Fri, 14 Jun 2024 21:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3tf/jKJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236E219D8A2;
	Fri, 14 Jun 2024 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718399425; cv=none; b=OpSSw7H7j/e9L4HULgB6GXPsNzh91Aohtlcj7csuV8zFiYRFd/REKCwvKIQvH2txYqZuulJ28RXQvB2yvVHn+tfBqUAztcNbEQRKAoB9PJxOyt5cW60+DN1aH67XrMdK54OMrGn9Ov9/JnzX9ZTQDaoL57wnIjTH8xzlbtCVgQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718399425; c=relaxed/simple;
	bh=4mjMC/xDz9CA4GaT7S07dgppyXWHHGmuedBGK3qo/Ss=;
	h=From:To:Cc:Subject:Date:Message-Id; b=JKldWAA7j2nevFxyVdWDPlWj4PH+BZ3/ijch+1LCAoms1weAewi4w9sxTdYjKlVjCyWk48ZDhWUcYLCwE91or/213ItH5J1LJsBtWDxiSMKwEOthcUhchiUwTff3v7lRhKFsSfwt9ms9UlVt1HZ4vwF0/z+x4U9+xIzPKYsi9D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3tf/jKJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718399424; x=1749935424;
  h=from:to:cc:subject:date:message-id;
  bh=4mjMC/xDz9CA4GaT7S07dgppyXWHHGmuedBGK3qo/Ss=;
  b=i3tf/jKJFB1J/KKHpZ7caLpbMAcIxm9VCBlQ+KsUlv759VJlzGemo9p9
   D2PIZsnJ7S3NogT4rLFs/W+kQp2sMBR10NAFj0Yuai5JZWQE5FklvpjP8
   XrG7HLqPIvoXeXcYzZB0XEqEpiXwX34z2dE/tUvcDNmZe2H1xiiKGVGDb
   0y8h1ke5xVNb4RupJYvJhixlEGOPLRtJ4wK0fckEjjJCFbdF5SRIplBiK
   b9kljmB4w2CPy9FjTtYIDdmKAlDjYjG2BNcBcQGh6891OzoMSjMy7ItOO
   HJB7aaUfJGTWvW1RUpnt67gYo51+HLzhZ320xduOZPhBucO4LzkK3c+2R
   Q==;
X-CSE-ConnectionGUID: nAlgoZLBQpqZ6qmf11vqCQ==
X-CSE-MsgGUID: 9o5V90u5T/ONh/dtX3ohYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="18230024"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="18230024"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 14:10:23 -0700
X-CSE-ConnectionGUID: o/AQPzhzQWq3ekGEt7+Euw==
X-CSE-MsgGUID: SRqBPx19QreJiw5BDTlpSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="44992970"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa003.fm.intel.com with ESMTP; 14 Jun 2024 14:10:23 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zhang Rui <rui.zhang@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH v3 0/2] drivers: thermal: intel: Use model-specific bitmasks for temperature registers
Date: Fri, 14 Jun 2024 14:16:04 -0700
Message-Id: <20240614211606.5896-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Hi,

Here is v3 of the patchset to use model-specific bitmasks to read TCC
offset and the digital temperature readout of IA32_[PACKAGE]_THERM_STATUS.

You can read the details and motivation in the cover letter of v1[1]. V2
is here [2].

Changes since v2:
 * Dropped patch 3/3 ("hwmon: (coretemp) Extend the bitmask to read
   temperature to 0xff") as it has been merged in v6.10-rc1.
 * Used the new X86_MATCH_VFM() macro. (Rafael)
 * Added Reviewed-by tags from Rui. Thanks!
 * Rebased on Rafael's testing branch (based on v6.10-rc3).

I have tested these patches on Alder Lake, Meteor Lake, and Grand Ridge
systems.

These patches apply cleanly on top of the `testing` branch of the linux-pm
repository.

Thanks and BR,
Ricardo

[1]. https://lore.kernel.org/linux-pm/20240406010416.4821-1-ricardo.neri-calderon@linux.intel.com/
[2]. https://lore.kernel.org/all/20240425171311.19519-1-ricardo.neri-calderon@linux.intel.com/

Ricardo Neri (2):
  thermal: intel: intel_tcc: Add model checks for temperature registers
  thermal: intel: intel_tcc_cooling: Use a model-specific bitmask for
    TCC offset

 drivers/thermal/intel/intel_tcc.c         | 177 +++++++++++++++++++++-
 drivers/thermal/intel/intel_tcc_cooling.c |   2 +-
 include/linux/intel_tcc.h                 |   1 +
 3 files changed, 174 insertions(+), 6 deletions(-)

-- 
2.34.1


