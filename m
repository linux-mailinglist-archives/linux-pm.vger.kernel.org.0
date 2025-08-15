Return-Path: <linux-pm+bounces-32456-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49761B2887B
	for <lists+linux-pm@lfdr.de>; Sat, 16 Aug 2025 00:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC07AE7B25
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 22:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABC3212570;
	Fri, 15 Aug 2025 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwzpB1jr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D399460;
	Fri, 15 Aug 2025 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755297977; cv=none; b=tSIPsPce6uEx6So0Cdd1bzHNEbbem0AN9++IwRTZ3LOH7777kslpInJ5uPTq8iCfJBNtvQhCLlrt7lK6A2AwRr5RGcsh/1AaMSExlzdNbtaxm7J4IB98vymePjgCEjh92a48NqFB+8eWKyXlhsR5UeBIrnyp8iB9Yxwl54NUj/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755297977; c=relaxed/simple;
	bh=DwnHfjsNSuqkv7vEqHhGefwSZvXSDUBugQ+2/AV7oTo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=br5bs/8fvGBEdYe8hCTHe8y3bqsBuhff9WI/lNJ9jb/ZCx1wWBi9h02/quWynSEFU48A/BX4/ixvgogtJ33mA2bcQjFl55i2c4Dhl5eEv8mK9BrZKbSST9o4qAtJ/VNZIEZOFJKyKIIZ70fVfn3ezIugeemEk5jukH96C9q/GuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwzpB1jr; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755297976; x=1786833976;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DwnHfjsNSuqkv7vEqHhGefwSZvXSDUBugQ+2/AV7oTo=;
  b=CwzpB1jrijlyQdgQvR3xRZcxhYr3ayDBLFF8XriFm+21Q4vpJ0i4LGK0
   YSZK5L8BDeDdWu0S2BTBA5K18yl1lhfNDsVeNci6Lw8bLJhra2Rukitgl
   poFheCatUiksUmKxaGT/nTSeJZFsWP+k3Jw55xDZr2WvvdeD0OiMWpPYE
   OzXwE7BOW34zSWpr7v4oXNj7NWzK38PQc5BoRsarC2Y6oVP7f0lqkbaQ0
   yyFmdcz9D7PmYDTboBhnlkSc5o6xVSan1orEutmfj9PXu7Nb3QvrcRQuj
   dphXULAsT8q7awFOlV89O5FFSUrTEwi+IO2k4VzWbL3N3bFBB8BGwQ4F0
   g==;
X-CSE-ConnectionGUID: jL27qhqVSrGRM2GIl36Lcw==
X-CSE-MsgGUID: 2AORZqhuR6ipQLmcj3BP5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57724931"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57724931"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 15:46:14 -0700
X-CSE-ConnectionGUID: pwU5jkpORaCrITHgjSgR7A==
X-CSE-MsgGUID: 9pfTBbsmRN+k9406Q8B9Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166734406"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.124.223.173])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 15:46:14 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 0/6] Enable SSRAM support in PTL and LNL
Date: Fri, 15 Aug 2025 15:45:58 -0700
Message-ID: <20250815224611.2460255-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series enables SSRAM support, including achieving PMC information,
low power mode substate requirements, and device and function
information for S0ix blockers from telemetry region, in Lunar Lake
and Panther Lake platforms for Intel PMC Core driver.

The first patch enables SSRAM support for Lunar Lake platforms. The next
three patches introduces a new table in telemetry region to get substate
requirement information for platforms starting from Panther Lake. The
fifth patch enable PMC Core driver to show device and function number
associated to a subset of S0ix blockers. The last patch enables SSRAM
support for Panther Lake platforms.

---
v3->v2:
- Add a patch to show device and function number.
- Use function pointer in struct pmc_dev_info to determine which
  substate requirement table to achieve and which show operation to use.
- Fix alignment.
- Move variable declarations to appropriate locations.
- Replace char pointer with enum as function parameter.

v2->v1:
- Change to only check ret variable value when getting substate data in
  pmc_core_get_telem_info().
- Return immediately when devm_kcalloc() fails.
- Return 0 instead of ret when succeeding in
  pmc_core_pmt_get_blk_sub_req().
- Replace devm_kzalloc() with devm_kcalloc().
- Add telem_info field of arl_pmc_dev variable.

Xi Pardee (6):
  platform/x86:intel/pmc: Enable SSRAM support for Lunar Lake
  platform/x86:intel/pmc: Move telemetry endpoint register handling
  platform/x86:intel/pmc: Improve function to show substate header
  platform/x86:intel/pmc: Show substate requirement for S0ix blockers
  platform/x86:intel/pmc: Show device and function number
  platform/x86:intel/pmc: Enable SSRAM support for Panther Lake

 drivers/platform/x86/intel/pmc/arl.c  |   4 +
 drivers/platform/x86/intel/pmc/core.c | 367 +++++++++++++++++++++++---
 drivers/platform/x86/intel/pmc/core.h |  39 +++
 drivers/platform/x86/intel/pmc/lnl.c  |  18 ++
 drivers/platform/x86/intel/pmc/mtl.c  |   2 +
 drivers/platform/x86/intel/pmc/ptl.c  |  33 +++
 6 files changed, 427 insertions(+), 36 deletions(-)

-- 
2.43.0


