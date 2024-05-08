Return-Path: <linux-pm+bounces-7619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCB98BF503
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 05:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6866028610B
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2024 03:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ABC17BBB;
	Wed,  8 May 2024 03:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YP1fvyxp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2FD15E8C;
	Wed,  8 May 2024 03:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715139426; cv=none; b=f2EHESiCHc9WNmKqwJfy5p7v1QjQbZChR1P1j1tpTzGmyBw4ImEB03FQHnej/P0irwd8CBsECBr8j4YjiPcLQ40OMSnQvEXNHkoXY7Cg8ChSXUxLUxOo+rEzpL//8oo/K1qWPSYgoD4I62oZbDZyvQH3ykMK4oBxBKliY9HsKg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715139426; c=relaxed/simple;
	bh=EteaDJy1TKeh8n+Vme3jSXeuit9WrXZ7u1nlAflDaYs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=r2YrAoJVQwSWdJ2KEScs4oN6h9h21YOnNv/CYZ8qBNSo8bp+/i+VUeBJPaRm5tPA9bS2tYq4Ra85sF7ZfkN0BPP6jbjB2rT8xD1DtuhpNmM+Q95/rQlIQA1h+oA3H9yHPJJZJJoGBkPMdky+n++8CL9BNkv4J3gK37Jo8B/cAOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YP1fvyxp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715139425; x=1746675425;
  h=from:to:cc:subject:date:message-id;
  bh=EteaDJy1TKeh8n+Vme3jSXeuit9WrXZ7u1nlAflDaYs=;
  b=YP1fvyxpfIruUxE+yjDdCfSEKb0OTRCsfcs5hcnyz+wElJ5AdsUn2Mvx
   mO46IvDDZX1jNAoBBbqSfIYTM5YrA7WwHUG/zRZ63dRnLJkU7qCTThF0h
   6veX/hYBGOC+Ci/VHSGayz/wJs3bx6VljT0qen8ZO1X74KHGQWPqrjkAR
   O7Qzst6VJDAZyrkFPTv2gDjOe2J107jBWt6aoZylN6E8RX8iPznlUwt7b
   sOfi0pIkCY+1fkmxji6LMhPnHO6J38M/voN58e8pUOLMDJXrdb9egtAfj
   7jfXo4Mn3oE635tT92Wzfs2SG/fFiZ/q7UkPhpw8+0GKpCwi25nxCXDOM
   A==;
X-CSE-ConnectionGUID: 3S7u5pwTQg6s9EMQBu7rsg==
X-CSE-MsgGUID: ulkPbKiUQqGE8edMgQRwag==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10820906"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="10820906"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 20:36:54 -0700
X-CSE-ConnectionGUID: f9loJq4DQEaylO/uzZecrA==
X-CSE-MsgGUID: 0w3bmhp2S2aUIEttUdlqCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="33551920"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa005.jf.intel.com with ESMTP; 07 May 2024 20:36:52 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <len.brown@intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH v2 0/4] thermal: intel: hfi: Update thermal netlink parameters
Date: Tue,  7 May 2024 20:43:48 -0700
Message-Id: <20240508034352.18414-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Hi,

This is v2 of a series previously known as "Add debugfs files for tuning"
[1].

Changes since v1:

Rui and Rafael pointed out various problems with using debugfs for tuning
how HFI uses thermal netlink. Instead, in this version I attempt to fix
the issues that motivated v1 (see the cover letter of v1 for details). I
update the two parameters that control how HFI uses thermal netlink: the
delay between an HFI interrupt and the thermal netlink event as well as the
size of the message payload.

Added Acked-by: tag from Rui on patch 1 (thanks!).

These patches apply cleanly on top of the testing branch of Rafael's
linux-pm.

Thanks and BR,
Ricardo

[1]. https://lore.kernel.org/linux-pm/20240429234152.16230-1-ricardo.neri-calderon@linux.intel.com/

Ricardo Neri (4):
  thermal: intel: hfi: Rename HFI_UPDATE_INTERVAL
  thermal: intel: hfi: Shorten the thermal netlink event delay to 100ms
  thermal: intel: hfi: Rename HFI_MAX_THERM_NOTIFY_COUNT
  thermal: intel: hfi: Increase the number of CPU capabilities per
    netlink event

 drivers/thermal/intel/intel_hfi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.34.1


