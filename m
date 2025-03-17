Return-Path: <linux-pm+bounces-24173-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE06A651E8
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 14:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5301887D42
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 13:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F9523F422;
	Mon, 17 Mar 2025 13:55:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A0523ED62
	for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219745; cv=none; b=Zgeu8dfwI2ZgTGrTjikZRrYQkC0JingfvDSnkbe+dQ/cguVMHlXqdue3tPjFx74Mo3NMVn9kYq9h2o9wAId4wlOh2WvK6dPff6i3+3Mp2HHvDHymq2m3Ctbls2myfVxVfwnbfZ9q04V9vEzaW484ju9g+lzLgoD6ZQ9PfJw92xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219745; c=relaxed/simple;
	bh=f2LkCMAjYjukFHB5Xam9gpVa8FG3c3gJ8ZTt4MYXskk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H4lcaIaIeD7c1DbWnoCK52EpY+X9Bu6quDwiD1cgRFdV4A7GHWH39QZg7fXbMYst0bh2QWCTKNlnXqjn6mHjasR3Xj+m0175UHMcTk92cDit+w0FmBHp6hjX65Kh2AkiICEk9NI9j6v7NAypV4HwKRVAOahtUTOTsuiHqc0JrNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: 07FHpGO4Q3S652yfktvp/w==
X-CSE-MsgGUID: YiErTxHLTJ6fFpPOUMwx6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43515479"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="43515479"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 06:55:44 -0700
X-CSE-ConnectionGUID: tnSzsexbQL2VFjhVg+rciA==
X-CSE-MsgGUID: ZJEusLZMQyy4tBBFLZhKxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="127115520"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by orviesa005.jf.intel.com with ESMTP; 17 Mar 2025 06:55:42 -0700
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH v3 0/3]  intel_idle: Add C1 demotion on/off sysfs knob
Date: Mon, 17 Mar 2025 15:55:38 +0200
Message-ID: <20250317135541.1471754-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Version 3 of the patch-set.

Changelog

v2->v3:
  * Address comments from Rafael Wysocki:
    1. Instead of passing a pointer to a bool value to intel_c1_demotion_toggle(),
       cast the bool value to "void *. This removes a need for pointer dereferencing
       in intel_c1_demotion_toggle().
    2. Use reverse Xmass tree ordering for local variable definitions.
    3. A spelling fix.
v1->v2:
  * Address comments from Rafael Wysocki:
    1. Rename the sysfs file from 'c1_demotion' to 'intel_c1_demotion'
    2. Add a commentary about reading the feature only for 1 CPU.
    3. Update Documentation/API (new patch 3/3).


Artem Bityutskiy (3):
  intel_idle: Add C1 demotion on/off sysfs knob
  Documentation: admin-guide: pm: Document intel_idle C1 demotion
  Documentation: ABI: testing: document the new cpuidle sysfs file

 .../ABI/testing/sysfs-devices-system-cpu      |   7 +-
 Documentation/admin-guide/pm/intel_idle.rst   |  21 ++++
 drivers/idle/intel_idle.c                     | 102 ++++++++++++++++++
 3 files changed, 129 insertions(+), 1 deletion(-)

-- 
2.48.1


