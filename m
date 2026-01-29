Return-Path: <linux-pm+bounces-41701-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OTYA/2ke2lWHgIAu9opvQ
	(envelope-from <linux-pm+bounces-41701-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:20:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F858B3825
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 569843047079
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 18:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4691D9A54;
	Thu, 29 Jan 2026 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzauM3JQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD6323A984;
	Thu, 29 Jan 2026 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710737; cv=none; b=mvqueqLlgIZAdk/VPFeobcyMvUIecccn4Jih5nU5pi/mKDiJAGdjx1YbeRge5R6Pf/NiwV09BXzzQFM7WCNFXzl4GgcZr51mN08WPKR5+zmu3PSPwaup57KpD8siVdVMJ0vVdez/vw4gh60fsc+coVy+STDECi7TbLHLmNh1aQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710737; c=relaxed/simple;
	bh=k2kV1md/c6oz+3Vmgv89T8BHEt7KRo1xA7RQ1bJVq8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MPLdqK4nKUoHSjTv3hRokOop5PtVkP1sFuz1ctXccWJ0AXUCZJbUnpLDpCmEY+4KOYy4v89qJKvFipbbyrOLfrMpgblk/F7PTO2A55UFnEVhSR8MTIldxoumY+4M6r3J08aVw/w8f3M3HTZ/u1PCaN/OaRDI4W1y4mSx2RpgTfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzauM3JQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769710736; x=1801246736;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k2kV1md/c6oz+3Vmgv89T8BHEt7KRo1xA7RQ1bJVq8k=;
  b=PzauM3JQcKLm3Y01cGnlGegQQl5bR6fF3tt0IX5ErngnjJhnHwNgq9Eq
   Eku+JSYWT+L0Wif8xaAVw3whsMllBwAY/HbCVGvVs71GkGhaq7fTzb3qB
   La1Vs700mtFlEXjLL71VEKlOQJSvWT8zSj+nlHshOWVPeCa18kNYABiVW
   Bq42OtEDOGLKh1hUTES66F1RD88kWTaRfKYKA4js9XtZtmpsE+L00KXJR
   SE+McRAkwuAVm8cQZor2v+wGYBEDswZr4xdZzBpsOleVUnOzHeo99gZES
   L08fGKsV2fESGY7C0sptsb4omhDF/mbonUvhQmYgdJXGMneU4sywAeuky
   A==;
X-CSE-ConnectionGUID: dQ0BNf63RFynR4ifKc4Vng==
X-CSE-MsgGUID: LGziwY2lT2St+og4Id4WEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70158271"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="70158271"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:18:55 -0800
X-CSE-ConnectionGUID: dtscTdSNTGWESIdqmkfSuw==
X-CSE-MsgGUID: FgYPC/z8Qw6Ktlwcx4w5ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="208255170"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.96])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:18:53 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/7] i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers
Date: Thu, 29 Jan 2026 20:18:34 +0200
Message-ID: <20260129181841.130864-1-adrian.hunter@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41701-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 6F858B3825
X-Rspamd-Action: no action

Hi

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


Adrian Hunter (7):
      i3c: mipi-i3c-hci-pci: Set d3hot_delay to 0 for Intel controllers
      i3c: master: Allow controller drivers to select runtime PM device
      i3c: master: Mark last_busy on IBI when runtime PM is allowed
      i3c: mipi-i3c-hci: Add quirk to allow IBI while runtime suspended
      i3c: mipi-i3c-hci: Allow parent to manage runtime PM
      i3c: mipi-i3c-hci-pci: Add optional ability to manage child runtime PM
      i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers

 drivers/i3c/master.c                               |  14 +-
 drivers/i3c/master/mipi-i3c-hci/core.c             |  30 ++--
 drivers/i3c/master/mipi-i3c-hci/hci.h              |   7 +
 drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c | 158 ++++++++++++++++++++-
 include/linux/i3c/master.h                         |   2 +
 5 files changed, 194 insertions(+), 17 deletions(-)


Regards
Adrian

