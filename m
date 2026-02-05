Return-Path: <linux-pm+bounces-42131-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MPaDoRshGmJ2wMAu9opvQ
	(envelope-from <linux-pm+bounces-42131-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 11:10:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC361F1333
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 11:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94FD5300566B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 10:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523C03A6418;
	Thu,  5 Feb 2026 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Co3mKq/m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02953A640F;
	Thu,  5 Feb 2026 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770286171; cv=none; b=mnoIcL032ffdQq5uwA7zkdKsV7Py95RLL1qDy6RlJRdl/Q5vsFuH3HiVLXGmuPx4jn4VERa4owTpWufwiXncmFq95OHQWG9c5Wq9WPkRYTZXEezs4XtXhVSDkuup1xgscV8SHbV0EEqbxcPzCA+rUXee+77M9CUXbDwOGng7YBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770286171; c=relaxed/simple;
	bh=6sVWynYBfbg5VjQJmoZHfVsY34MgrqfiZ91CE4YehIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGnlFFdsUIm6PhxS2JFDSFs/qInXO6AvphW+2Hv9V0BHK/Yy89vgSPi2C+37itzvs1xrGZFgs4pFPVxg9fGgEsO90bO4hZzNX1WIfyUv9QYadZOjhrLFWZ9Ul6hR/NHrbTzqMSn+KPRZVp2Imd+5CfVYsQa0NHl2FMwZYpLECzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Co3mKq/m; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770286171; x=1801822171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6sVWynYBfbg5VjQJmoZHfVsY34MgrqfiZ91CE4YehIo=;
  b=Co3mKq/mgGq3hYDyh8IeegR5RAbj829zTQTlzVyNnttJsvc4HFZ/duiZ
   KtK77DkgPkY4S5BOuwbQ6/WS9TXr3crBdV2F6wmv26PBbnLJ/oa7zgCUL
   ItD+DbmwUg/Jjjlfves5KAWw+gMkEXaUb2s369sh0wa0X+8h+LdnkZAqX
   UvqRfiXD0U6xmvrq5cH5TleoWhJF9/G++fq9AhtFCbT0/tvtBsucbrkMh
   va/yjehjvnG2efy1ChocX2eB9ojsZptmUyXxJpXZCmoeCheC+tCsEYE0a
   eMitCoUE8Tez4CPE/34rni6D81a6EkMh8Fmr/9ZZYISKNLuH8Mi0Bbol4
   g==;
X-CSE-ConnectionGUID: DNgPEB/LT2S2Tg1/EApfag==
X-CSE-MsgGUID: wFsTduDzRvOeIDEGP7P93Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71471710"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71471710"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 02:09:30 -0800
X-CSE-ConnectionGUID: Nzx2FJubSPesvGyytJc7AQ==
X-CSE-MsgGUID: JmqRk3fSTcWYU68zA5FzjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="214631173"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.58])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 02:09:28 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V3 2/5] i3c: mipi-i3c-hci: Add quirk to allow IBI while runtime suspended
Date: Thu,  5 Feb 2026 12:09:12 +0200
Message-ID: <20260205100915.19792-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260205100915.19792-1-adrian.hunter@intel.com>
References: <20260205100915.19792-1-adrian.hunter@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42131-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC361F1333
X-Rspamd-Action: no action

Some I3C controllers can be automatically runtime-resumed in order to
handle in-band interrupts (IBIs), meaning that runtime suspend does not
need to be blocked when IBIs are enabled.

For example, a PCI-attached controller in a low-power state may generate
a Power Management Event (PME) when the SDA line is pulled low to signal
the START condition of an IBI. The PCI subsystem will then runtime-resume
the device, allowing the IBI to be received without requiring the
controller to remain active.

Introduce a new quirk, HCI_QUIRK_RPM_IBI_ALLOWED, so that drivers can
opt-in to this capability via driver data.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---


Changes in V3:

	Add Frank's Rev'd-by

Changes in V2:

	None


 drivers/i3c/master/mipi-i3c-hci/core.c | 3 +++
 drivers/i3c/master/mipi-i3c-hci/hci.h  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index e925584113d1..ec4dbe64c35e 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -959,6 +959,9 @@ static int i3c_hci_probe(struct platform_device *pdev)
 	if (hci->quirks & HCI_QUIRK_RPM_ALLOWED)
 		i3c_hci_rpm_enable(&pdev->dev);
 
+	if (hci->quirks & HCI_QUIRK_RPM_IBI_ALLOWED)
+		hci->master.rpm_ibi_allowed = true;
+
 	return i3c_master_register(&hci->master, &pdev->dev, &i3c_hci_ops, false);
 }
 
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index 6035f74212db..819328a85b84 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -146,6 +146,7 @@ struct i3c_hci_dev_data {
 #define HCI_QUIRK_OD_PP_TIMING		BIT(3)  /* Set OD and PP timings for AMD platforms */
 #define HCI_QUIRK_RESP_BUF_THLD		BIT(4)  /* Set resp buf thld to 0 for AMD platforms */
 #define HCI_QUIRK_RPM_ALLOWED		BIT(5)  /* Runtime PM allowed */
+#define HCI_QUIRK_RPM_IBI_ALLOWED	BIT(6)  /* IBI and Hot-Join allowed while runtime suspended */
 
 /* global functions */
 void mipi_i3c_hci_resume(struct i3c_hci *hci);
-- 
2.51.0


