Return-Path: <linux-pm+bounces-42591-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J7TAbBijmn1BwEAu9opvQ
	(envelope-from <linux-pm+bounces-42591-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:30:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7197C131BA8
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 546083045E0E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 23:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE9F2E0916;
	Thu, 12 Feb 2026 23:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqdCDwLH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922D32C11EF;
	Thu, 12 Feb 2026 23:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770939050; cv=none; b=hv9dMG+LWyqipscEU9VY+ipj+xxgVgPwEg7pz//ZKPeilfmpcAb00jqwzw/mzf9u6dG5Dl+539oQ/K0yjcU0zO8s2O1Civ7moQM709wexorhFokB/tpFqq43+sU1afephgOMRrVksiaBIqi635+/+KurmSZsSPb+5MToDtoPLUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770939050; c=relaxed/simple;
	bh=Yf29YFnAlYnNy/MoHWcrCx2boAmxrKkF4z9UIlckSzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hVv1x442801N+t5+ecr01djg6nxNKaTpYm7GeDfnNJP+ZQV+dmwqtOHfjwfNcq+Q9JrJPxKx/sGeJRzRYahtWENMYca2n6zjEoeftOq4ECb7gWRdXEsU3Fulc9RQcVE6V7a2yZGhdpN9Ls3F50ZsP8mtOXpJ0l7+UFMqo2CNon4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jqdCDwLH; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770939050; x=1802475050;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yf29YFnAlYnNy/MoHWcrCx2boAmxrKkF4z9UIlckSzo=;
  b=jqdCDwLHH40O7lsy845y5FLI3qDSvqZMJlrIz0V4fQlqnO49gBF6CzXK
   9jT/LO2NfGtvs1rettyLxbGZtHi684omWcfUJkLI/kbJFHVGl5zf0b3Oo
   PmCeFe+oaMJFoxo/0OYrUV9rPqWZdWgKkylCc3kIzMKg9bZqgypNqujmQ
   boh3MA2joKdsxXwiytFAgqmrWWFO6ae0ZprCr85smUtnOZma1R4J9dokR
   Do2iPpKVz42vG7bZBVZwK+egVe+E1BL9j9oCVSIJPkEvjc5WcPWflcqlO
   UwM5YHU6mXg7KTm1yoIU07InJ8SH8x1+rtT6ezHRxPaQ+viWQ0dnEyW5c
   Q==;
X-CSE-ConnectionGUID: FnkUcJZtReWICPxv752+Bg==
X-CSE-MsgGUID: XWroyQlQTCGSEaYSq5AgNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72017406"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="72017406"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:30:47 -0800
X-CSE-ConnectionGUID: eiY6EGVHSbWsquYiw1Lf3g==
X-CSE-MsgGUID: SuW9PUyAToucV+XQD9lfog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="211845373"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:30:45 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/12] Move RAPL defaults to interface drivers
Date: Thu, 12 Feb 2026 15:30:32 -0800
Message-ID: <20260212233044.329790-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42591-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sathyanarayanan.kuppuswamy@linux.intel.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 7197C131BA8
X-Rspamd-Action: no action

Hi All,

The Intel RAPL common driver has accumulated a significant amount of
interface-specific logic over time. There is very little common code
shared across the MSR, TPMI, and MMIO interface-specific defaults.
Keeping these interface-specific defaults in the common layer therefore
provides no real benefit and instead increases complexity and
maintenance burden.

As a first step toward cleaning this up, this series moves
rapl_defaults ownership from the common driver into the individual
interface drivers and allows each interface to provide its own defaults
directly. Additional interface-specific cleanups in the RAPL common
driver will be addressed in follow-up work. This series is a
continuation of the earlier cleanup and refactoring effort initiated
by Zhang Rui.

Patch Summary:

Patch 1-7/12: Preparatory patches that do code cleanups in intel_rapl_common
             driver.
Patch 8/12: Preparatory patch that renames/declares the common functions.
Patch 9/12: Move TPMI default settings from the common driver into the
           TPMI interface driver.

Patch 10/12: Move MMIO default settings from the common driver into the
           MMIO interface driver.

Patch 11/12: Register the PM notifier only when a RAPL package exists.

Patch 12/12: Move MSR default settings from the common driver into the MSR
           interface driver.

No functional changes are intended across the series. This is strictly a
structural refactoring to simplify the common RAPL code and prepare it
for further cleanups.

Changes since v1:
 * Removed BIT(val) usage in divisions (David Laight).
 * Divided the cleanup patch into 4 patches for clarity.
 * Added Acked-by tag from Srinivas.

Kuppuswamy Sathyanarayanan (12):
  powercap: intel_rapl: Add a symbol namespace for intel_rapl exports
  powercap: intel_rapl: Cleanup coding style
  powercap: intel_rapl: Remove unused TIME_WINDOW macros
  powercap: intel_rapl: Simplify rapl_compute_time_window_atom()
  powercap: intel_rapl: Use shifts for power-of-2 operations
  powercap: intel_rapl: Use GENMASK() and BIT() macros
  powercap: intel_rapl: Use unit conversion macros from units.h
  powercap: intel_rapl: Allow interface drivers to configure
    rapl_defaults
  powercap: intel_rapl: Move TPMI default settings into TPMI interface
    driver
  thermal: intel: int340x: processor: Move RAPL defaults to MMIO driver
  powercap: intel_rapl: Register PM notifier only when RAPL package
    exists
  powercap: intel_rapl: Move MSR default settings into MSR interface
    driver

 drivers/powercap/intel_rapl_common.c          | 757 ++++++------------
 drivers/powercap/intel_rapl_msr.c             | 251 +++++-
 drivers/powercap/intel_rapl_tpmi.c            |  48 ++
 .../int340x_thermal/processor_thermal_rapl.c  |   9 +
 include/linux/intel_rapl.h                    |  17 +-
 include/linux/units.h                         |   3 +
 6 files changed, 562 insertions(+), 523 deletions(-)

-- 
2.43.0


