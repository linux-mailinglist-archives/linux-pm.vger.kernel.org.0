Return-Path: <linux-pm+bounces-3065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E69844025
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 14:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D25297F8F
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jan 2024 13:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA447BAEC;
	Wed, 31 Jan 2024 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gvDlT928"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C989E7D403;
	Wed, 31 Jan 2024 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706582; cv=none; b=oVvrn/x00GZ2+akyNgzQioytkN8NVcSCJt2dkmm9W62GdipdoT9D38fM0qoFuMT9+H5odQ0JIO0Ct1tF+lXIrMRmWVoembXN6h6rEohS0r8s8l+4Rmts1vjjj/2DE/mq278NRGAp/uU+YdI1GR4Ykr4vOECVRslQ8GWJlRLNXXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706582; c=relaxed/simple;
	bh=AtaaNaDVSVp1qgefliVmsQbCeAhN8VRIRGY8S25G6hQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Vppx93kype4PSUXoMuvt7HGymUtHBb1WHQjac6JJXAevuG5GBHwrpoXd1MO7+/f/dLQlYvtvOlPMdsWshcUgUOHEPlrEacc8dGugrjLsYQ/yHdkUC3gFpf7hQ5tqfzT5w8PjJPC+8dEEjVcMc0e6/o7+z2y5RfY7ZTM+2Rd61ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gvDlT928; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706706580; x=1738242580;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AtaaNaDVSVp1qgefliVmsQbCeAhN8VRIRGY8S25G6hQ=;
  b=gvDlT928BgdxntfCyN8F+5vMX0XUYDkG67+biYeQ5p+RJizh7fNtn/Le
   xHwwe3mbNojMFNDwaM/vuw7jyPf59Ajy29+i0B6y8B+15RMYSbTeAX8Iw
   wSwPrj2B4rSjz6KvTeZl0TwZHiys+5pP0KioW1isWSSvj1KFwzHSGxtS9
   VAs++g6RJBMSyTw7Tax3o5DkbF+F2QHhHe4Ci7+C6TsKatYcIjWJI02ah
   skFqbaSSnp5s46U6V6TX98nvbtNjXaJCDmb4p0doN3Xch9RGuVHS5uouu
   5wzlj8hGZiOICqOia5QER+uU44yl6IKs6XgBa6gGNemZbtPMSuwJSB8aH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="400734628"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="400734628"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:09:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="911783179"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="911783179"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.19])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:09:36 -0800
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
	netdev@vger.kernel.org
Subject: [PATCH 0/3] thermal/netlink/intel_hfi: Enable HFI feature only when required
Date: Wed, 31 Jan 2024 13:05:32 +0100
Message-Id: <20240131120535.933424-1-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patchset introduces a netlink notification, which together with
netlink_has_listners() check, allow drivers to send netlink multicast
events based on the presence of actual user-space consumers.
This functionality optimizes resource usage by allowing disabling
of features when not needed.

Then implement the notification mechanism in the intel_hif driver,
it is utilized to disable the Hardware Feedback Interface (HFI)
dynamically. By implementing a netlink notify callback, the driver
can now enable or disable the HFI based on actual demand, particularly
when user-space applications like intel-speed-select or Intel Low Power
daemon utilize events related to performance and energy efficiency
capabilities.

On machines where Intel HFI is present, but there are no user-space
components installed, we can save tons of CPU cycles.

Stanislaw Gruszka (3):
  netlink: Add notifier when changing netlink socket membership
  thermal: netlink: Export thermal_group_has_listeners()
  thermal: intel: hfi: Enable interface only when required

 drivers/thermal/intel/intel_hfi.c | 82 +++++++++++++++++++++++++++----
 drivers/thermal/thermal_netlink.c |  7 +--
 drivers/thermal/thermal_netlink.h | 11 +++++
 include/linux/notifier.h          |  1 +
 net/netlink/af_netlink.c          |  6 +++
 5 files changed, 92 insertions(+), 15 deletions(-)

-- 
2.34.1


