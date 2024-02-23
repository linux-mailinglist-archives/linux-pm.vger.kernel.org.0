Return-Path: <linux-pm+bounces-4332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5178A8616A7
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 17:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069DB1F26D04
	for <lists+linux-pm@lfdr.de>; Fri, 23 Feb 2024 16:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F201083CA6;
	Fri, 23 Feb 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MoWXeuE2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700A883A13
	for <linux-pm@vger.kernel.org>; Fri, 23 Feb 2024 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703988; cv=none; b=UDs5alFCTpZlMQyQw0UI4VWuvJU15z66LUgnCQpaf7DNU9jENYpoWxDIIfUEbKZW0a4Wx784siaDmmeJ7NMCwo5COegpQzo+A0m9xiE44JoN10GIXhEjFwcd123l98owdj8HOnjOQoZ7vs8MNoChRg2EAxLr+gfLNpZRP7OC9Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703988; c=relaxed/simple;
	bh=n8DxKro/kGIk0S9amVzX8pD35nJCbCAtU87NF6BUyTc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sh/jSoWBxUB3eMAjjwU1z23RliOqkltdOLTTVqm1jG8PsC3toAdrlD2WjypJDzq/Ajky2ZdXij9vv9vGro60RnGFYHs59JE5E6dNVIDvZO1ctydjorOWCN/4ny/NLCp3e+/4ZAFNZuEV3OfEZFYBF4mCVIlcQVKXw2gZnbS9KJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MoWXeuE2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708703987; x=1740239987;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n8DxKro/kGIk0S9amVzX8pD35nJCbCAtU87NF6BUyTc=;
  b=MoWXeuE20HiZH5rzX1ExUh6nW7PrZgPZbpvJkWSOnKSN0A4MbpcHsuFu
   SEK/cshkAoOeUH2ZBnedCtExezzFulsYY4P1tFY51MvQgXBdNbCZPAIeJ
   w9NfDghmtXfIaSsk060Uy6zcoz2UzSfeZAE70vBVTx5UM0peKDJlIEzfg
   5N88cIkxPrfJd56TQZTTKBGZYdjbcfUGi4Eh1Bl565ELVCEldO3t3gXgz
   HDxSO5eYhVkqhHOyehQgOKbZZptW+Pec8hImX5LYcS2hTOsFaIDFmTzwo
   yqnxYH9/cllZ6A/vNj3KYTXzgDgGU7HdrKWiyEpSqHxG4fxXmW7f2Jbx4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3179277"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3179277"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:59:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="36956492"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.47.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:59:45 -0800
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v4 0/3] thermal/netlink/intel_hfi: Enable HFI feature only when required
Date: Fri, 23 Feb 2024 16:59:39 +0100
Message-Id: <20240223155942.60813-1-stanislaw.gruszka@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patchset is based on

 https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git
 for-thermal-genetlink-family-bind-unbind-callbacks

and implement genetlink family bind/unbind callbacks in thermal-netlink and
add notifications to thermal subdrivers. Those willh allow drivers to send
netlink multicast events based on the presence of actual user-space consumers.
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

Changes v4 -> v5:

- Fix hif vs. hfi in the changelog
- Rename thermal_gnl_chain
- Add new patch with rename of thermal_gnl_family
- Fix syscore concurrency comment
- Remove unneeded hfi_instance variable
- Rename hfi_do_enable/disable
- Avoid multiple enabling 
- Add comment about registering for events before they can be generated
- Rename hfi_thermal_clients_num since later there will be KVM clients

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
v4: https://lore.kernel.org/linux-pm/20240212161615.161935-1-stanislaw.gruszka@linux.intel.com/


*** BLURB HERE ***

Stanislaw Gruszka (3):
  thermal: netlink: Add genetlink bind/unbind notifications
  thermal: netlink: Rename thermal_gnl_family
  thermal: intel: hfi: Enable interface only when required

 drivers/thermal/intel/intel_hfi.c | 97 ++++++++++++++++++++++++++++---
 drivers/thermal/thermal_netlink.c | 62 +++++++++++++++-----
 drivers/thermal/thermal_netlink.h | 26 +++++++++
 3 files changed, 161 insertions(+), 24 deletions(-)

-- 
2.34.1


