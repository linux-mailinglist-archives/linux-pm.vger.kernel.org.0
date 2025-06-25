Return-Path: <linux-pm+bounces-29458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAA9AE7703
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 08:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D1B3BFDA2
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jun 2025 06:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22AB1DE4D2;
	Wed, 25 Jun 2025 06:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqUmnTYS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9956037160;
	Wed, 25 Jun 2025 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750833110; cv=none; b=T/Pyu7hJl7wNaYAwjeXIPKfSLhWey/SUyzuPJpO7naK/NmpHHq9e9IVzLHwEUq65FLocb+AY7pi4AlF6YrCFByPPCur66L2MlaQZK2j85A9SRocUqgo9mAl9pl3gx3+eKdJPdaQjTSlwYiIL7+junrUEFoMbxz/xQJiognZx13s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750833110; c=relaxed/simple;
	bh=NLfLMLy3D0pv0BPkZUDbfHWUooD/CY1z9LjKKOFctvQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=p5vmYyMnk8DlbnsbUp6veVVV+UpeB/xZaS8dCr0n2e/VNPXvJiohTm3JVw+7WsB5fqIAxNsepqw7yc2ocyZY66nqPtbl5loLp85958FU74UAjR38HrmN+uPbH9qtmNgVc2OF5qfY3buj9TWtrGD3RRQA0ZoP3V+6HxXWfDjnJMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqUmnTYS; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750833109; x=1782369109;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NLfLMLy3D0pv0BPkZUDbfHWUooD/CY1z9LjKKOFctvQ=;
  b=hqUmnTYS4kTt+0jxKwFI8s1T9YVwWgYENL54p4NHDXh4CRK768SIo80M
   dgcoacQA/cPqQvu9a5FVQ7qatFKnfXgcbIf8N9uCVI5EEYn4CtH5KORO7
   2AOVfZiMLI5G3F1iAcgapIijyvBpwTYLvmFISU6eUjSNfeef6THi55UcX
   +xZD83IfR4FjuVXm2JKqodLMAae1cm4cKwUkACfrSKza5sR6BOF1qp/Ow
   b4G16iuHtWfLC2SDX77jGyFk7TMuweFiur5k/XXgHfOKNThZXXmDBgUCa
   cKFICEdM0xqEqmHJKDueOCJoflgzENPMOcd8dCfn8FWNMqzdYfTvm3Lva
   w==;
X-CSE-ConnectionGUID: bNu/ji6eRz6eHHyTUfDeQA==
X-CSE-MsgGUID: RsqF7fn5TSmXvKbgPt1QwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53187455"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="53187455"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 23:31:49 -0700
X-CSE-ConnectionGUID: J8aDqBT8RCKV/hsH+1WzOQ==
X-CSE-MsgGUID: X8O02w/OSkWGOt4qXoL2Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="152257571"
Received: from daliomra-mobl3.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.124.223.140])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 23:31:47 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 0/5] Enable SSRAM support in PTL and LNL
Date: Tue, 24 Jun 2025 23:31:37 -0700
Message-ID: <20250625063145.624585-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enables SSRAM support, including achieving PMC information
and low power mode substate requirements from telemetry region, in Lunar
Lake and Panther Lake platforms for Intel PMC Core driver.

The first patch enables SSRAM support for Lunar Lake. The next three
patches introduces a new table in telemetry region to get substate
requirement information for platforms starting from Panther Lake. The
last patch enables SSRAM support for Panther Lake.

---

v2->v1:
- Change to only check ret variable value when getting substate data in
  pmc_core_get_telem_info().
- Return immediately when devm_kcalloc() fails.
- Return 0 instead of ret when succeeding in
  pmc_core_pmt_get_blk_sub_req().
- Replace devm_kzalloc() with devm_kcalloc().
- Add telem_info field of arl_pmc_dev variable.

---

Xi Pardee (5):
  platform/x86:intel/pmc: Enable SSRAM support for Lunar Lake
  platform/x86:intel/pmc: Move telemetry endpoint register handling
  platform/x86:intel/pmc: Improve function to show substate header
  platform/x86:intel/pmc: Show substate requirement for S0ix blockers
  platform/x86:intel/pmc: Enable SSRAM support for Panther Lake

 drivers/platform/x86/intel/pmc/arl.c  |   2 +
 drivers/platform/x86/intel/pmc/core.c | 169 ++++++++++++++++++++------
 drivers/platform/x86/intel/pmc/core.h |  14 +++
 drivers/platform/x86/intel/pmc/lnl.c  |  17 +++
 drivers/platform/x86/intel/pmc/mtl.c  |   1 +
 drivers/platform/x86/intel/pmc/ptl.c  |  30 +++++
 6 files changed, 199 insertions(+), 34 deletions(-)

-- 
2.43.0


