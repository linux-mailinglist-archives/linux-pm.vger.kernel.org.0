Return-Path: <linux-pm+bounces-43757-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJpnNEqXqmmIUAEAu9opvQ
	(envelope-from <linux-pm+bounces-43757-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 09:58:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7DE21D883
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 09:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0121D30817EA
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 08:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924EA376486;
	Fri,  6 Mar 2026 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGnMerkv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC04221540;
	Fri,  6 Mar 2026 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787238; cv=none; b=lXJcccVDB3HZhndAOfZqhr0Z00tmqR5C0Z6hILEtjwGuzHhtGMrwd5SFYXn5Ai6bTCIeDM0LaqmNMxILYBznQGOMB044YyhYGXmuOczVWB4PQ5e2ACcfirhFMRMA6FS99/giNnyS9lMfaN4ItRXTMH5/2PUR2zNOyIsnsgA7Uf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787238; c=relaxed/simple;
	bh=/i85oLSnCj5qMGi6p222uU20/vuUbnPx0CH1tfyzfPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZZxdwo62chPrq3trrSKoOBxwFslXbDinBIAtH/wvGxNTLz7ChGqdlBn4mATES1q5U7fKRkNvXjFy2U7L++uvzIOQelVy9Ot9+eDvkwOvQbK5XuxzTQU00CCw6WxIqNYN6Vb8K6tloIfqsrktAf9ckdiUBgWMZC2Wc4oyFupIpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGnMerkv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772787233; x=1804323233;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/i85oLSnCj5qMGi6p222uU20/vuUbnPx0CH1tfyzfPQ=;
  b=mGnMerkvE9y3aRcDoFES0rODY5ODlPKa9vd/tHd+tq1wGEb6TQ8XsEow
   ewmr7e27oYAB2pO9WEosvOCdBpchonbbiIz2odxrRHgJlYXI0+hnzh2ww
   mK5Ebpka5c3wyiBX5deK2EQ+8TTItw6aC7VOn5KHrCOrs0iZtU/icd98z
   hDBy781klyQ+/HAdmu71qnQ9Zo3z1XAoydwA0unj8uHTNSTwNzfmjpsX3
   4l47sb77WLvzk/GOCgs4PwtbVUDRSRZAUvYOVsPaiG56tSMlpEpRKlB8Z
   7uvL9qVtNXkL6ZdGcGKdqzwNNmK5a1GG77ud++PA9wBgm857aR47p8AlU
   g==;
X-CSE-ConnectionGUID: Jhcj141DT1KKMIQZ3RZ5Ew==
X-CSE-MsgGUID: sf3J42j1TZeD6xHLByu9Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="91467202"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="91467202"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 00:53:52 -0800
X-CSE-ConnectionGUID: /2+tIvBWQWakgOLOGX7Oxg==
X-CSE-MsgGUID: hwsKx16sRymtXFP8XZoAMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="223641463"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.171])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 00:53:50 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V5 0/5] i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers
Date: Fri,  6 Mar 2026 10:53:33 +0200
Message-ID: <20260306085338.62955-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4F7DE21D883
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43757-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi


	Please note all patches have Frank's Rev'd-by.


Changes in V5:

	Re-base on top of v7.0 fixes series:
		https://lore.kernel.org/linux-i3c/20260306072451.11131-1-adrian.hunter@intel.com/T

Changes in V4:

    i3c: mipi-i3c-hci: Allow parent to manage runtime PM
	Add Frank's Rev'd-by

    i3c: mipi-i3c-hci-pci: Add optional ability to manage child runtime PM
	Add Frank's Rev'd-by


Changes in V3:

    i3c: master: Mark last_busy on IBI when runtime PM is allowed
	Patch dropped

    i3c: mipi-i3c-hci: Add quirk to allow IBI while runtime suspended
	Add Frank's Rev'd-by

    i3c: mipi-i3c-hci-pci: Add optional ability to manage child runtime PM
	Remove unnecessary pm_runtime_mark_last_busy()

    i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers
	Add Frank's Rev'd-by


Changes in V2:

    i3c: mipi-i3c-hci-pci: Set d3hot_delay to 0 for Intel controllers
	Add Frank's Rev'd-by

    i3c: master: Allow controller drivers to select runtime PM device
	Patch dropped

    i3c: master: Mark last_busy on IBI when runtime PM is allowed
	Adjusted slightly for earlier changes

    i3c: mipi-i3c-hci: Allow parent to manage runtime PM
	For HCI_QUIRK_RPM_PARENT_MANAGED case, change from
	disabling runtime PM to instead causing the runtime PM
	callbacks to do nothing

    i3c: mipi-i3c-hci-pci: Add optional ability to manage child runtime PM
	Do not enable autosuspend.
	Callbacks for parent-managed invocation were renamed
	from i3c_hci_runtime_suspend to i3c_hci_rpm_suspend and
	from i3c_hci_runtime_resume to i3c_hci_rpm_resume.
	Amend commit message slightly.

    i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers
	Retain HCI_QUIRK_RPM_ALLOWED
	Amend commit message accordingly


Here are patches related to enabling IBI while runtime suspended for Intel
controllers.

Intel LPSS I3C controllers can wake from runtime suspend to receive
in-band interrupts (IBIs).

It is non-trivial to implement because the parent PCI device has 2 I3C bus
instances (MIPI I3C HCI Multi-Bus Instance capability) represented by
platform devices with a separate driver, but the IBI-wakeup is shared by
both, which means runtime PM has to be managed by the parent PCI driver.

To make that work, the PCI driver handles runtime PM, but leverages the
mipi-i3c-hci platform driver's functionality for saving and restoring
controller state.


Adrian Hunter (5):
      i3c: mipi-i3c-hci-pci: Set d3hot_delay to 0 for Intel controllers
      i3c: mipi-i3c-hci: Add quirk to allow IBI while runtime suspended
      i3c: mipi-i3c-hci: Allow parent to manage runtime PM
      i3c: mipi-i3c-hci-pci: Add optional ability to manage child runtime PM
      i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers

 drivers/i3c/master/mipi-i3c-hci/core.c             |  35 +++++-
 drivers/i3c/master/mipi-i3c-hci/hci.h              |   7 ++
 drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c | 135 +++++++++++++++++++++
 3 files changed, 172 insertions(+), 5 deletions(-)

Regards
Adrian

