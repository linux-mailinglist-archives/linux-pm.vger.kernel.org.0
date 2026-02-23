Return-Path: <linux-pm+bounces-43010-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP37AwsdnGkZ/wMAu9opvQ
	(envelope-from <linux-pm+bounces-43010-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 10:25:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 809E4173DCD
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 10:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CADF4306D8C3
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 09:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C452B34EF11;
	Mon, 23 Feb 2026 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZH3Xf6H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9815234E777;
	Mon, 23 Feb 2026 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838456; cv=none; b=RJPyOagjHEZGNXVSE+zRVpuQQDU86MWGQNLxuParnlbvk3OgNoyyTLOncBTzy5i4G1rJn9iuz12VxQhj6YpWYWmhfx4u0ekdIKVQ+CXGGqLFPp9ukiXxUe54eARu2twzys2clPtvfpKxywLBr3KHwv46YjYELOJnsPmI8i8kStI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838456; c=relaxed/simple;
	bh=Uv3jpUhmVoyehRTPjsR3joBh7t+FveVb5u2E+JjKH+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFjqwcN4/cX0xlRv4fdkz/IVR7sd12JqIscGEbhhVVb6bP+QD2QozGNwsg6NFJ9vuYNtaj5dPaGTsCttfMKYPzv4UNbtZiMML1CxmnH2nZzE/nkz2tBe+LPc9ZGYM+W01YEBO2dppo444x2bJ0iCo6tHB9gPip7jECQBs0Ao9cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZH3Xf6H; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771838455; x=1803374455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uv3jpUhmVoyehRTPjsR3joBh7t+FveVb5u2E+JjKH+I=;
  b=MZH3Xf6HhW/xRC0e2u/5awI+bQffcEQkEqV5gNbb+pQgKU6fYdVWlZ6B
   9OKaf9Z9IR0W5ARXgYPEaugGYKho7IbAUMPW2S6lxMqHxMKJbjBd0nsdl
   w3Kk3NsOowzdkLUWDW40znptmmscrdrDZdswU1/5SZRQVzAOY8dwt63ly
   d2q5PkImXp2anPk7I+IqJTI2OEFkF66J7fFP30TDZouObNghjKozvIFbP
   JsYdNDS5EE4qlyuIkrGQvs389FsCjE+cfrw0x9h6FrYoUKmQJLTsB/MXQ
   g69KqcRQUZ4LFrlk8/RtfF6OMGsxuSGbYGMP70Spgr9Ec8K1pC0MNHvfc
   w==;
X-CSE-ConnectionGUID: RKsRUmSORi6BdqWsAmxbHw==
X-CSE-MsgGUID: zq/bY3jDRHSBZBDiTAsfrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72928682"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72928682"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 01:20:55 -0800
X-CSE-ConnectionGUID: Gr+vAtJfRF6jFyxs+DZYiA==
X-CSE-MsgGUID: UFP61TU/SyOUyuRrPR4Vdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="215346051"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.206])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 01:20:54 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V4 1/5] i3c: mipi-i3c-hci-pci: Set d3hot_delay to 0 for Intel controllers
Date: Mon, 23 Feb 2026 11:20:37 +0200
Message-ID: <20260223092041.104689-2-adrian.hunter@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43010-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 809E4173DCD
X-Rspamd-Action: no action

Set d3hot_delay to 0 for Intel controllers because a delay is not needed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---


Changes in V3 and V4:

	None

Changes in V2:

	Add Frank's Rev'd-by


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


