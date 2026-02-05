Return-Path: <linux-pm+bounces-42129-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNABM1xshGmJ2wMAu9opvQ
	(envelope-from <linux-pm+bounces-42129-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 11:09:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAB4F130E
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 11:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C598A30055B5
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 10:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A1D3A4F32;
	Thu,  5 Feb 2026 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YO+yHU/9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3D133B6F3;
	Thu,  5 Feb 2026 10:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770286168; cv=none; b=kVLXDJpQxplInWXQd8nKj/UQ7rWQMJnjMaRFKuaKwI/mYognLpNe82r58zln4xbLAwyxw/A80YVNik4yVi+EBMiTh5YRWucn7s7qoNvN/tVIUHyZLN4wwr7orc2po57QgJUuwtMso5PfIcZJ3TL58bQyS0GyQs5RZBuwqj4ffPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770286168; c=relaxed/simple;
	bh=XfWKoqjkA9uI4Mdp8SJQYUFk/IKkOiHu9o0rYwwYGdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Amq7TNNujgl3HSGxPibcZdCSUiLfLRjrldSxFvnnf9SQM0PPcsAmZnx4bP+GAzMrwx61V5qU2EiuOWGPcr4SKnf9fZ2ukAXe8F0k7e+iaXrUP/rKnI3jEQHjGfcJHd9vaPvzF7jDTPRQjwYRBoiiSMROPw7mH3MC8IeUZbcH0Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YO+yHU/9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770286167; x=1801822167;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XfWKoqjkA9uI4Mdp8SJQYUFk/IKkOiHu9o0rYwwYGdY=;
  b=YO+yHU/9dPDJo0pmIdCVD9zEV1xLUHikq5+Ln6gKnr4W2F1kPM2sH++R
   gRIGSk2tW+IAjDJd+LZ6GtrHVoNsKEvcnG/oU1FH4im7i2SZ4jGe3tTbo
   pYukqMEE8VRtOGrl+d1EzZeoo34cFMJq+XbtfOIR2Yae4vP32Uexqe37w
   Op2CFvOGwYDWO4SbxIjDjGDVyunWS/brLz2fbqUtzQBT46RbrTScZ57EK
   +/IDRAKxg5atBvfpjMP+w4DJkrrGbpmm+cmVh7bq7gjFAnH/qDDNBZFhN
   UiEOt++hDiGpJh+mzdiVY8YyDim0mVF2FxsEPkZQGM9mxKiJlMh+kif/p
   g==;
X-CSE-ConnectionGUID: UySBy7pDRy+WJtbkvwvzfg==
X-CSE-MsgGUID: a7D344CvTVSL1ton/3USAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71471697"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71471697"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 02:09:26 -0800
X-CSE-ConnectionGUID: i+dFWLDXSrqBpr+9/Xu0sw==
X-CSE-MsgGUID: 2P0HLyCFRgO4auRlhad9ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="214631167"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.58])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 02:09:24 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V3 0/5] i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers
Date: Thu,  5 Feb 2026 12:09:10 +0200
Message-ID: <20260205100915.19792-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42129-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DAB4F130E
X-Rspamd-Action: no action

Hi

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

