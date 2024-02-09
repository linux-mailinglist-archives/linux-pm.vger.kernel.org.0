Return-Path: <linux-pm+bounces-3683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D624484F509
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 13:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B4F1C25DFB
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 12:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE412E64F;
	Fri,  9 Feb 2024 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UaXe09hy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6AF3172D;
	Fri,  9 Feb 2024 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707480484; cv=none; b=KfzSZAQM6daXShH5JVHT0P+KOwIwSDj/9d0pqiiPGcwAm+GMZdcSg6IJojnf3ztbDmZ1Y1jt3RpBdv4LpVpwoIpmhPz64vAAUNP4QpDV+Ydl5QxY78g32mIdU3y0peNb/x2DHCMdN7E9c6Zl7bQB2Zcn1xVTBlTbor8kHXhgZKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707480484; c=relaxed/simple;
	bh=YLHK8/bVQoyOEqOenfxMz+qOr0jROe6pgZvlLFa0Htg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=trbwN70j1IoyHI7gpjdXWW8+LJMC+1SFrh0Gv4ko/gxSXIHHyAeT3TBsVnzhtmnOBI3oXJ05+jVvBVYpsTnKi+93trg0uhKp+AEAvExa+28d8CTXHfS7waOz8fzKyFceWSXZLoL7FxtvSMr0HNZfHCWQR3wEydo8OeYHuR79DXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UaXe09hy; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707480479; x=1739016479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YLHK8/bVQoyOEqOenfxMz+qOr0jROe6pgZvlLFa0Htg=;
  b=UaXe09hyAr/TTdU6k8p53mM0LJNaVs7WoWvABDs8fbS6aS84Qz7gsjHA
   IjN2uL+Odyx4ZfuoYrOZlx0uDqnCs8XJVSA6nwxP9NiGrRWvlMSRhuzj/
   cwtOvf9RKwRBLetPalXYKjXFne22029gtOvZ2A44leIfGYjrpC03pZphT
   1yk94cqjiOldAeL3C3xV9B1g1SmA8YF6uscYNLCHi4HzIKm9JsjQatj4W
   drQlpKdBrGau45CCggtPQWY11vls0ViYL+ZJkWceTEv3eOIAZzNTc5dJ6
   EiqvCiUvISqOodVGlD+X1DcHYHZUlqAi1EpKjGpgFl3hCGHSnqswb3QPx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1726833"
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="1726833"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 04:06:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,256,1701158400"; 
   d="scan'208";a="32707702"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.96])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 04:06:28 -0800
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
Subject: [PATCH v3 0/3] thermal/netlink/intel_hfi: Enable HFI feature only when required
Date: Fri,  9 Feb 2024 13:06:22 +0100
Message-Id: <20240209120625.1775017-1-stanislaw.gruszka@linux.intel.com>
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

Stanislaw Gruszka (3):
  genetlink: Add per family bind/unbind callbacks
  thermal: netlink: Add genetlink bind/unbind notifications
  thermal: intel: hfi: Enable interface only when required

 drivers/thermal/intel/intel_hfi.c | 95 +++++++++++++++++++++++++++----
 drivers/thermal/thermal_netlink.c | 40 +++++++++++--
 drivers/thermal/thermal_netlink.h | 25 ++++++++
 include/net/genetlink.h           |  4 ++
 net/netlink/genetlink.c           | 30 ++++++++++
 5 files changed, 179 insertions(+), 15 deletions(-)

-- 
2.34.1


