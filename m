Return-Path: <linux-pm+bounces-3803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEFE8518C7
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 17:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B261F214AE
	for <lists+linux-pm@lfdr.de>; Mon, 12 Feb 2024 16:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E42D3D0C2;
	Mon, 12 Feb 2024 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YdyawAx8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C613D0B6;
	Mon, 12 Feb 2024 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754591; cv=none; b=UxrZbF8xdLcp/3efcZc9Hpyuoe/FBNH0AfoVMD2rAMl7bD+DRdusNABTFqDxL7uuEGRVD7jmbNUISb8T6oG98VRwdhvLDZyEThFIHHyHz+GrwUykS3Jl3LXDEZaLGwozmEeyFF8Ci7qTwIN9dv5LoVhKPG22xIkmMqIyvg+j2TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754591; c=relaxed/simple;
	bh=w8bJqm2zLHqXeQjNSSGkAO8dL3idyJusrSEDubesOA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EzHUGVS6z7a/oaLYRKXSKuwmol/7fxBSKrATHla4z6/z1QmC6ncCosMK+O177JXKWgsgmWgrGN4NYT+P0WHJLowJ2ILwzeNhNskC0sf/shHXEL3EpjkdHJdsJUKCc4Yrp/Q1CUFAB/VSD20116OO0+TmhedihnKYIC+wg8gOKco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YdyawAx8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707754590; x=1739290590;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w8bJqm2zLHqXeQjNSSGkAO8dL3idyJusrSEDubesOA0=;
  b=YdyawAx8wE/IlnWympBBgxIYEDTFnQPu9oL4DDacg+5dvMZm6w1d1ePX
   3SsTa27um+w9ucFg4F85rV2L29olTEWL590zK6EDGKCv/pRVWFkFTFtkG
   cBReZzljgEanHjmn806mqexb5fMJSUjmW0ot8JOFyZAUOdlAEMAklmUMw
   oVCGEL8VdWgNfgpwdxdNY3p6cayv/Nd/rIYeVmakTPtPduF4wlpeh675J
   rdKLj/w1RZuiWjdcDiNyX3g2uv2g07QYqN1U8HDOJdlcaL1KYJGN53tlq
   /Z/zVnagWlJM+EwzG+oASLjwxxnEqkBFqLeYskF/miJlWa4FMB0RLug+i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5551549"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="5551549"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:16:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="33417890"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.44.2])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 08:16:25 -0800
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes@sipsolutions.net>,
	Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org
Subject: [PATCH v4 0/3] thermal/netlink/intel_hfi: Enable HFI feature only when required
Date: Mon, 12 Feb 2024 17:16:12 +0100
Message-Id: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patchset introduces a new genetlink family bind/unbind callbacks
and thermal/netlink notifications, which allow drivers to send netlink
multicast events based on the presence of actual user-space consumers.
This functionality optimizes resource usage by allowing disabling
of features when not needed.

Then implement the notification mechanism in the intel_hif driver,
it is utilized to disable the Hardware Feedback Interface (HFI)
dynamically. By implementing a thermal genl notify callback, the driver
can now enable or disable the HFI based on actual demand, particularly
when user-space applications like intel-speed-select or Intel Low Power
daemon utilize events related to performance and energy efficiency
capabilities.

On machines where Intel HFI is present, but there are no user-space
components installed, we can save tons of CPU cycles.

Changes v3 -> v4:

- Add 'static inline' in patch2

Changes v2 -> v3:

- Fix unused variable compilation warning
- Add missed Suggested by tag to patch2
 
Changes v1 -> v2:

- Rewrite using netlink_bind/netlink_unbind callbacks.

- Minor changelog tweaks.

- Add missing check in intel hfi syscore resume (had it on my testing,
but somehow missed in post).

- Do not use netlink_has_listeners() any longer, use custom counter instead.
To keep using netlink_has_listners() would be required to rearrange 
netlink_setsockopt() and possibly netlink_bind() functions, to call 
nlk->netlink_bind() after listeners are updated. So I decided to custom
counter. This have potential issue as thermal netlink registers before
intel_hif, so theoretically intel_hif can miss events. But since both
are required to be kernel build-in (if CONFIG_INTEL_HFI_THERMAL is
configured), they start before any user-space.

v1: https://lore.kernel.org/linux-pm/20240131120535.933424-1-stanislaw.gruszka@linux.intel.com//
v2: https://lore.kernel.org/linux-pm/20240206133605.1518373-1-stanislaw.gruszka@linux.intel.com/
v3: https://lore.kernel.org/linux-pm/20240209120625.1775017-1-stanislaw.gruszka@linux.intel.com/

Stanislaw Gruszka (3):
  genetlink: Add per family bind/unbind callbacks
  thermal: netlink: Add genetlink bind/unbind notifications
  thermal: intel: hfi: Enable interface only when required

 drivers/thermal/intel/intel_hfi.c | 95 +++++++++++++++++++++++++++----
 drivers/thermal/thermal_netlink.c | 40 +++++++++++--
 drivers/thermal/thermal_netlink.h | 26 +++++++++
 include/net/genetlink.h           |  4 ++
 net/netlink/genetlink.c           | 30 ++++++++++
 5 files changed, 180 insertions(+), 15 deletions(-)

-- 
2.34.1


