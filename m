Return-Path: <linux-pm+bounces-1992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FCF828733
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 14:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3FE286C1D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 13:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A0D2206B;
	Tue,  9 Jan 2024 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kx430XlC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364E138F9F
	for <linux-pm@vger.kernel.org>; Tue,  9 Jan 2024 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704807406; x=1736343406;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yFr9KGJx5XgPRln7KCPF/VRWVciagJnId5d0hywVu7I=;
  b=kx430XlC4lo2i9CjYAEj1HtTYz7MV+hMv/S0iW9uR1SLkrYEPJ/EUQcL
   vCVEQA8VwCNm8CkIFVkpLEp1qnW92EkaVBAvO36Wo5Z46lm9I7mY51Afo
   9mSYMA3GKtJV6Nfn6KKm10Gn2D0QEn03AwYQ/9xiDr4/5gRhs0yoDzjsk
   GmjIDL/Fe3FxX7HY/K81CBU66BU6qxqPeW0er3N5pXet5xx/heLJmno9K
   94qK0Tpj54mMhxwTp1MUzP3DarlcfuXFK3mu9vis5tW1o4cSBZJBlghdD
   JmCMG0ES70uCwIK2L5pRgP7+gwDIXfaOcL1+07NlULpdPTmP7GeU+4SfY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5550663"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="5550663"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 05:36:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="872245173"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="872245173"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 05:36:43 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 69C6711F913;
	Tue,  9 Jan 2024 15:36:40 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	laurent.pinchart@ideasonboard.com
Subject: [PATCH 0/2] Small runtime PM API changes
Date: Tue,  9 Jan 2024 15:36:38 +0200
Message-Id: <20240109133639.111210-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

Here's a small but a different set of patches for making two relatively
minor changes to runtime PM API. I restarted version numbering as this is
meaningfully different from the previous set.

pm_runtime_get_if_active() loses its second argument as it only made sense
to have ign_usage_count argument true.

The other change is also small but it has an effect on callers:
pm_runtime_put_autosuspend() will, in the future, be re-purposed to
include a call to pm_runtime_mark_last_busy() as well. Before this,
current users of the function are moved to __pm_runtime_put_autosuspend()
(added by this patchset) which will continue to have the current
behaviour.

I haven't included the conversion patches in this set as I only want to do
that once this set has been approved and merged. The tree specific patches
can be found here, on linux-next master (there are some V4L2 patches
there, too, please ignore them for now):
<URL:https://git.kernel.org/pub/scm/linux/kernel/git/sailus/linux-next.git/log/?h=pm>

Later on, users calling pm_runtime_mark_last_busy() immediately followed
by __pm_runtime_put_autosuspend() will be switched back to
pm_runtime_put_autosuspend() once its behaviour change has been done (a
patch near top of that branch). I'll provide these once the preceding ones
have been merged.

Comments are welcome.

Sakari Ailus (2):
  pm: runtime: Simplify pm_runtime_get_if_active() usage
  pm: runtime: Add pm_runtime_put_autosuspend() replacement

 Documentation/power/runtime_pm.rst      | 22 ++++++++-----
 drivers/accel/ivpu/ivpu_pm.c            |  2 +-
 drivers/base/power/runtime.c            |  9 +++--
 drivers/gpu/drm/i915/intel_runtime_pm.c |  2 +-
 drivers/gpu/drm/xe/xe_pm.c              |  2 +-
 drivers/media/i2c/ccs/ccs-core.c        |  2 +-
 drivers/media/i2c/ov64a40.c             |  2 +-
 drivers/media/i2c/thp7312.c             |  2 +-
 drivers/net/ipa/ipa_smp2p.c             |  2 +-
 drivers/pci/pci.c                       |  2 +-
 include/linux/pm_runtime.h              | 44 ++++++++++++++++++++++---
 sound/hda/hdac_device.c                 |  2 +-
 12 files changed, 67 insertions(+), 26 deletions(-)

-- 
2.39.2


