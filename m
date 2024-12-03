Return-Path: <linux-pm+bounces-18411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 718F09E149E
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 08:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81265B22310
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 07:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E29B189F39;
	Tue,  3 Dec 2024 07:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMYLDKMj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B971BF37;
	Tue,  3 Dec 2024 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212281; cv=none; b=OFHIrKOmWKkx5W5y4mY/iGqEh7W25WaXWIz6eTY5mKzvkcDMExw4XtwC3KMyYmyW1zS1RK3MJoph8Ms1QKFozP/TOhoTS4a379WQh8/KrYB6wMyMwyXwaiOX2sagiWZe1PH/pLx015294hq+YiiIHiwBfGBKNtmIeDd95V6HLuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212281; c=relaxed/simple;
	bh=vH66bPIcMUi9dp6metIyc4TJeKJYBsYXH0aQvB+JSQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dOT/MUYb3HwSenl4q9v/cA73z4cyHnXQRYzYPmc29tjuwwLCRoWzSBq0W8ZCoSocDk0gV2Mu2798+10ZaLb75vtAMuecb7Y7NQVQL4u0VtrktMVCbzHqvtTRN5oOA/tNzzdwXPRyg/j+GdVqqMvxYqijrVTYUcunAhj98fAmzCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMYLDKMj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733212280; x=1764748280;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vH66bPIcMUi9dp6metIyc4TJeKJYBsYXH0aQvB+JSQo=;
  b=VMYLDKMjg8e4IOhyFvgwVycAFPt9YpmpTul44Wm20O3bmoallw3+eNhJ
   ePQg5PyRjMIQibQUaeApLomTiXdpYeRHri90IRIRAmKmUOwY6xfHFagSx
   tR4nyVvOneD2YZep47B4NRHONAYdBCYwYVdRlILq0PmC6jDJgM7NZxHyu
   P2BSc4HXy+cEzEICTR1pf8FnQpICKCH7jOt5EMyn0ckZSr1cJXUcKAROk
   OrxG+M9EaKST+FM+eHmJJiEQ9yCWrX11GQ4ZaHiy1/6XEs9g16qbA3pym
   66XFjtWmlP0q59MHj46SI6cNZqSlLZtuzceaJ08RfvFG2OPvoOrTJ+n12
   w==;
X-CSE-ConnectionGUID: BpdryHTdQCOdGHPJAmPJKQ==
X-CSE-MsgGUID: oYgFLpx5R7qxEUAY1HQjoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="50822842"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="50822842"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 23:51:18 -0800
X-CSE-ConnectionGUID: 1z+/LqCiTPG5CU/t2NQd+A==
X-CSE-MsgGUID: OVO1pEg2QNSoeEh/pNlCUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="124183011"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa002.jf.intel.com with ESMTP; 02 Dec 2024 23:51:17 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/4] tools/power turbostat: Improve handling for unsupported platforms
Date: Tue,  3 Dec 2024 15:51:15 +0800
Message-ID: <20241203075119.584419-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, all,

Turbostat requires per-platform enabling for different platforms due to
platform-specific features. When running on unsupported platforms,
turbostat currently operates with limited default features, which can
lead to users unknowingly using an outdated version of the tool.

Enhance turbostat to
1. exit by default when run on unsupported X86 Vendors/Intel models.
2. give a clear message to users, informing them that their CPU model is
   not supported and advising them to update to the latest version of
   turbostat for full functionality.
3. allow force loading with minimum support on unsupported platforms by
   introducing a new '--force' parameter.

With above patches, when turbostat runs
1. on supported platforms, no functional change.
2. on unsupported X86 Vendors or unsupported Intel Models without
   '--force' parameter, turbostat exits with below message:

"Unsupported platform detected.
	Use "--force" parameter to launch turbostat with minimum default support.
	To get latest turbostat support, please contact
	   lenb@kernel.org
	or pull from
	   https://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat"
	   
3. on unsupported X86 Vendors or unsupported Intel Models with '--force'
   parameter, turbostat continues but with below message
   
"Unsupported platform detected. Force running with minimum default support."

Any comments are welcome.

thanks,
rui

Zhang Rui (4):
  tools/power turbostat: Exit on unsupported Intel models
  tools/power turbostat: Exit on unsupported Vendors
  tools/power turbostat: Improve --help output
  tools/power turbostat: Introduce --force parameter

 tools/power/x86/turbostat/turbostat.c | 72 ++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 18 deletions(-)

-- 
2.43.0


