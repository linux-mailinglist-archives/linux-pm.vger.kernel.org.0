Return-Path: <linux-pm+bounces-3478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AF984B687
	for <lists+linux-pm@lfdr.de>; Tue,  6 Feb 2024 14:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765261C24335
	for <lists+linux-pm@lfdr.de>; Tue,  6 Feb 2024 13:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9437131721;
	Tue,  6 Feb 2024 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0T7x79O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF9A130E44;
	Tue,  6 Feb 2024 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226574; cv=none; b=t6+VVYBy9F9bzs1GSOXpVWi4crznS+Kew5rb9R6009qZ0g2MoQtECM5o+jLtivR3dJImtL2mNegqLfsY2nhg4uhPTxP16vJhfKYAA+WI82SPHXwZXZg9sRolUJDAe5ssNNzYNcn075ZWVmtltKxpcsDag1uuQFmS1ftwCCGF/oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226574; c=relaxed/simple;
	bh=4oU3LUHNrs8jLGbT1E6XO3a3ua+p8aFuNmYBj3lq8DQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KK1bmKMrNEQBMQP+usuiq8ssOW3BxtTXu+D0GkKER9Il/DeQZzscr1A1epdhO7i8BLjd7B3AsS24Q9CrsYzB9xqNJEReaXG07FL0LL206VBETjYnMAlPrsgM3aa/dKJWHRY23eP+2i34xZZJtn20tlxmgrWvBJxNqZfrVd51AO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X0T7x79O; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707226572; x=1738762572;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4oU3LUHNrs8jLGbT1E6XO3a3ua+p8aFuNmYBj3lq8DQ=;
  b=X0T7x79O6kyRRxJbxXbTd+9sjqmKHBcQOWjnfoYj5voED8EOkhnOyKSQ
   FgWACiKofBkQ9PJgA8ZoL9AScmEk1MWjmqayuu77eJ0MhrJTMMXRoi+T2
   bnY7R86JU+nsbqojTYwoLqGYSb37wN7UZMWafgJ3Zh/sMpcn1bubFVBZT
   V+n+emZ/FI7kBi8cBNOoZOw6MIMf6NsuLMSV9JWQ5ugxGwgPZa5+/fLmE
   9Z0mJe71rqr5lT7yCEDMJbzC8Rwiy5l7ZotrGQZbj27sGveDfTNVvD7gM
   FZcHKWGuYplA+0Icp4wbbaVOrNOq2jpRiKYxNf2Uj6ytRIh2oz8qEspQT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="630528"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="630528"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:36:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="5788654"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.60.196])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:36:08 -0800
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
Subject: [PATCH v2 0/3] thermal/netlink/intel_hfi: Enable HFI feature only when required
Date: Tue,  6 Feb 2024 14:36:02 +0100
Message-Id: <20240206133605.1518373-1-stanislaw.gruszka@linux.intel.com>
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

v1: https://lore.kernel.org/linux-pm/Zb48Z408e18QgsAr@nanopsycho/#r

Stanislaw Gruszka (3):
  genetlink: Add per family bind/unbind callbacks
  thermal: netlink: Add genetlink bind/unbind notifications
  thermal: intel: hfi: Enable interface only when required

 drivers/thermal/intel/intel_hfi.c | 96 +++++++++++++++++++++++++++----
 drivers/thermal/thermal_netlink.c | 40 +++++++++++--
 drivers/thermal/thermal_netlink.h | 25 ++++++++
 include/net/genetlink.h           |  4 ++
 net/netlink/genetlink.c           | 33 +++++++++++
 5 files changed, 183 insertions(+), 15 deletions(-)


base-commit: bd0e3c391ff3c3c5c9b41227d6b7433fcf4d9c61
-- 
2.34.1


