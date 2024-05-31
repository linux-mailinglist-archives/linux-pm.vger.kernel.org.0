Return-Path: <linux-pm+bounces-8444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091318D5DEA
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 11:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898D81F27221
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 09:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E14078297;
	Fri, 31 May 2024 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a69MXn73"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F395C2262B
	for <linux-pm@vger.kernel.org>; Fri, 31 May 2024 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717146794; cv=none; b=CfSgQFC2/6NNZ38+kNzBDD4kb31IYU640vEoRxuhCZcPwS5JWNu9Jl0HU6vL9T5z93O4NoQVLKRYTU3oLUzCjMY0/6Xcn0yi899cZH36neD/zd7GGM7PVQh97Qfs+FNMkEUnowG4nmWv6TiGKOcmvkiRAPgnYp88h51o/rVjyfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717146794; c=relaxed/simple;
	bh=c263vXYHiWk+Mw02i7/cpcfrzd/X0DnIqISYl7Q+chY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=W254MC+IECt6y5KxTxnEOT5ivUCD6h1c5pXC1qwGsDiHvYjr1b/9k3yj73SGAr2ZU/J5nz/bjxMX+/Olu7Q5qg5vUTH8BOugaHMyaUCAX3BvQeisfAcBIo2rODyNsQ2TBHoCgrUfurRnCWq8u1yHDZxGjcdKAXDb8XcLbTn1yzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a69MXn73; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717146794; x=1748682794;
  h=from:to:cc:subject:date:message-id;
  bh=c263vXYHiWk+Mw02i7/cpcfrzd/X0DnIqISYl7Q+chY=;
  b=a69MXn73TwIPs6H46WSKRfCVdlIH+pHWtGN5/P6dRnDxWDInAUlVFfrh
   Gnx19y00JiC1yeASbPBvyGy9TrEao2pdxXT16WFMTuOaAw4sI+9zdY5iC
   kFF8jOkb3EDr2h3iSohJ2GTnLK128VMp+TeAlSrXLrpuWJ4qQPM6aIPh1
   QnDQJM3aMIWS8xvp3HBk2Z+JkgYgjYXzS2xQpbIaCnMfPeOREPI1OAw7x
   p7Z7FoWjcWz8xTF66N2RlkUhmCQYFPWvQlCHkV4/q63a7ppoetIvyGXT1
   I+5J1yWcDKWUU5+xnmidlG94BMJboXrPo4Z+Fkjf2f3whdxNkmMsDo+VP
   w==;
X-CSE-ConnectionGUID: hdnFseelTwOlTkDs8j+fKw==
X-CSE-MsgGUID: yRKr0N8ITpyIsi/skQOHxg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13807211"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="13807211"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 02:13:13 -0700
X-CSE-ConnectionGUID: JmYjMXQsQkee7Bu6S4qrLw==
X-CSE-MsgGUID: qJEvNjWOR6mBc2bLIFwMgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="73589707"
Received: from wopr.jf.intel.com ([10.54.75.146])
  by orviesa001.jf.intel.com with ESMTP; 31 May 2024 02:13:12 -0700
From: Todd Brandt <todd.e.brandt@intel.com>
To: linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	rjw@rjwysocki.net
Cc: todd.e.brandt@linux.intel.com,
	todd.e.brandt@intel.com
Subject: [PATCH 0/2] pm-graph v5.12
Date: Fri, 31 May 2024 02:13:08 -0700
Message-Id: <cover.1717146154.git.todd.e.brandt@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

pm-graph v5.12

Code revamp for python3.12:
 sleepgraph/bootgraph function correctly in python3.12 but include a slew
 of deprecation warnings for unsupported regexes. This patch fixes up all
 the strings in the code so that it comforms with python3.12 standards.

Other updates:
- fix S3 suspend fail double run by using fp.flush to /sys/power/state
- when running turbostat print the return value
- handle case where html files have binary data
- max issues in summary-issues is now 100 (in case there are thousands)
- add backup to dmidecode, use /sys/class/dmi/id/ in case /dev/mem fails
- update summary page to use full mode (disk-platform instead of disk)

Todd Brandt (2):
  pm-graph v5.12, fixes
  pm-graph v5.12, code revamp for python3.12

 tools/power/pm-graph/bootgraph.py  |   16 +-
 tools/power/pm-graph/sleepgraph.py | 1098 ++++++++++++++--------------
 2 files changed, 571 insertions(+), 543 deletions(-)

-- 
2.17.1


