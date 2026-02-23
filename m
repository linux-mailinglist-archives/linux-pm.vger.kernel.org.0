Return-Path: <linux-pm+bounces-43011-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCG4DQ8cnGkZ/wMAu9opvQ
	(envelope-from <linux-pm+bounces-43011-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 10:21:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE126173CE3
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 10:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24AF13024083
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 09:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8C534EEFC;
	Mon, 23 Feb 2026 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rs6Y5IoK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C151ACEDE;
	Mon, 23 Feb 2026 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838460; cv=none; b=V9Upc9XgmEQVdwlKgMHLyVoS8r2No6xSH3qMz1epmYKlK1ZCYsdnw4JNRMoALPPyn45B8ASwc41Fd+sHeiHdYxS8I+XwLkqGkfL0AF5F+pZt2tPlUBzSfDJDe4GwXa0B+f9Gu6gfpyh1kXgneAwWmB3h6XeJWtasd5N6DYhB4rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838460; c=relaxed/simple;
	bh=nJoS04WRIbALpdyQ4/xt0PHkkGiWif0IWZzmhvBHJLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4ax+qbvAUabkapNZwKKcNoXoVIvn3DloXqvmE3DWOw+nw1QX5Q9gfxjAq1JxjE4FR/RPelFTchgTu5xtOP7+x/Bpf0+mdvbhBSUvDvgqW3BJ8Bpk7s4Dzw8G5Rj/1FhdnHEUtSUXhqFTEdu7L5wsVRRVGM9JtxHZV58Dum2Nk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rs6Y5IoK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771838458; x=1803374458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nJoS04WRIbALpdyQ4/xt0PHkkGiWif0IWZzmhvBHJLw=;
  b=Rs6Y5IoK9WwjanIbdhlZHQZGiDXqbY/diINHH49F0GNGwxkp0L18Jnnz
   hbkkofTPnCxe66zpcnphVqJpcHSyF29AEcfqUpHzo4Hca1jJVqrs+6Sih
   v4pSh5SjUHtjKO+E1i4rEjJYvkx1/gPLuRyhVEfjtf12LPbo2koapQmj9
   FAK/8g/XZU7wmgfYvL71+KLFMQSKyzYjaAAJW6lTtRn5ke4bQdgAEcoAC
   8YWzCjHqKo7CIL9XuBT0UFmXnDxy1W9lDrgSjtB+ufVbXQCDl/i+evHJi
   7sKdFcANTZwzDnInMAoRT885E5o400HXNGoW/khf2eX8AYF+WI7tvg1Fh
   g==;
X-CSE-ConnectionGUID: a/ezUdEXS9GdkKgycIxyqQ==
X-CSE-MsgGUID: QRy9eO/gQ6SI2Nn5L+k8CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72928693"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72928693"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 01:20:57 -0800
X-CSE-ConnectionGUID: n3u8m63KQdCeNyclllsyCw==
X-CSE-MsgGUID: SJk1sgUSQQ6KapCAuF5Guw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="215346062"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.206])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 01:20:56 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V4 2/5] i3c: mipi-i3c-hci: Add quirk to allow IBI while runtime suspended
Date: Mon, 23 Feb 2026 11:20:38 +0200
Message-ID: <20260223092041.104689-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223092041.104689-1-adrian.hunter@intel.com>
References: <20260223092041.104689-1-adrian.hunter@intel.com>
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
	TAGGED_FROM(0.00)[bounces-43011-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: CE126173CE3
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


Changes in V4:

	None

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


