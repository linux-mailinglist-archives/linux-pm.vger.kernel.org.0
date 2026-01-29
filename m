Return-Path: <linux-pm+bounces-41702-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AODeNhGle2lWHgIAu9opvQ
	(envelope-from <linux-pm+bounces-41702-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:21:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C902B3833
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57CA3305615F
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 18:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295CF2F5A36;
	Thu, 29 Jan 2026 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTy11+8b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F05F2E7F39;
	Thu, 29 Jan 2026 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710739; cv=none; b=X2+mCF6L2dvo+AF7A91BRjN91TrMdCsyYkDf9wr41QMo0lD2FBMBPyJ0pFZoJ2lEXwFSXA6VVT0qMCL4fxawI8z1SdXLfARcDmRWJQL9sBz+ILzTpp/ywO2haeMU2hUzlFmMJgB6IVykWqoJRIDj71coXS4BNSXbnuwVe4QDzWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710739; c=relaxed/simple;
	bh=QGA7s2M35n/1FOK4su0sUXCzqna1KL1Zl+xDOLqoMB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p06jgOuN2OrvzHcBzmoWHaPbEsHqNHoXTwR+mkDoJGMkHsMNEmq7dUKQNR1K/vKZ8fIperf/H0UklNIjL3ILjdH+wNjfldGHVuQL8ghwTQAcFo1AYAFYb+/4XN5jnDQQ2RhYP0NxUCtOfdg99Q4sINlAblgHGoehQByC+hSVvbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTy11+8b; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769710738; x=1801246738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QGA7s2M35n/1FOK4su0sUXCzqna1KL1Zl+xDOLqoMB4=;
  b=NTy11+8bHTcsFEN6WNDyhHbSLE29tx7KJfYPtDaoPA/O/Ume8cbXv9zf
   vloT110BhUl93NFS/WaS34CKInLusHavlh9v8NOzRbVjL+0iMp+pLHlEX
   SSNiOhegQE9QcZzk8YUDtA5RqenLjN6zA9vTL3cMCwfwzCkJx/QmNYLuR
   vr6ceIfHWFgK0TzwUEQI+c2c+zCN6bPyHY4AtpSx9NjdcvGP/obM/Mj8U
   lU3qejKWD5J67O9ZnYLVry+VfNlyQDDS6v2Kq1f7NBAfdTkJ0lBwScYGD
   Zo7h5vVO+ywXz5y6efTxs9RiWZcSQN/lqG53cqkYzDSdPh2e1TqhSkmzr
   Q==;
X-CSE-ConnectionGUID: ErQhjZ9uTWOVbK9mWAQCWA==
X-CSE-MsgGUID: gRgpUM4sRrGD9Uv7qBhsnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70158275"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="70158275"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:18:57 -0800
X-CSE-ConnectionGUID: zEFqbPbfRa+kk3Nk8tUvvA==
X-CSE-MsgGUID: wf2kJr/yTf+2bXraxa8fpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="208255266"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.96])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:18:55 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/7] i3c: mipi-i3c-hci-pci: Set d3hot_delay to 0 for Intel controllers
Date: Thu, 29 Jan 2026 20:18:35 +0200
Message-ID: <20260129181841.130864-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129181841.130864-1-adrian.hunter@intel.com>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41702-lists,linux-pm=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 4C902B3833
X-Rspamd-Action: no action

Set d3hot_delay to 0 for Intel controllers because a delay is not needed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
index 0f05a15c14c7..bc83caad4197 100644
--- a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
+++ b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
@@ -164,6 +164,7 @@ static int intel_i3c_init(struct mipi_i3c_hci_pci *hci)
 	dma_set_mask_and_coherent(&hci->pci->dev, DMA_BIT_MASK(64));
 
 	hci->pci->d3cold_delay = 0;
+	hci->pci->d3hot_delay = 0;
 
 	hci->private = host;
 	host->priv = priv;
-- 
2.51.0


