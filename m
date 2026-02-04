Return-Path: <linux-pm+bounces-42056-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFiqOcwqg2kxigMAu9opvQ
	(envelope-from <linux-pm+bounces-42056-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 12:17:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52534E4FE0
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 12:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A7FB3043D2F
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 11:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15513E9F6F;
	Wed,  4 Feb 2026 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOHqvE7f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541ED3DA7E3;
	Wed,  4 Feb 2026 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203726; cv=none; b=MZqqaYHhw+RZQ9SXa+g8AdkVLtu2vUHw3L+ZEAYJ57ssnodNvTZiKSlfRz+58271qMOfSBK/Ozc1asQB4waz48ohyB8z9OCjF0tEvfzvLLZ7XYUKv8FkSzMCX07FUep6Glxfshppl0zOhgms4BHkuObmn3ZYc4+QwI2qdN+MqC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203726; c=relaxed/simple;
	bh=w4uBEMnFw6IU1yfNVWzXyJJ/IeAOyUbFqbRawZssQ2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RT2Jzs2nGwVjemN0Ayh5ug9GdgU+QeFpHh5xhri+KVDMIyKD6yCuilbP6wdG1/oodhaTxXZbYun1N93PRwoyRHF0eHxS+bSPgAvU2JY59TGEbmpVVu+UTw3/sQZ7Z4LaQ3V7w7HNq5hKhcpA2Pajnt9JdmZVyGeLMXlO7frVzYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOHqvE7f; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770203726; x=1801739726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w4uBEMnFw6IU1yfNVWzXyJJ/IeAOyUbFqbRawZssQ2M=;
  b=EOHqvE7fm/YR0EWID9rA8WUIw+yqFB5adbtHt8iQyXLMPenSFqfD5ZRG
   lHbHF0YzzNJ/JI3RTtdNFBZTEVltpa5T3EZfUL88bnTsLbJTK/7IEM6/R
   r63t1DfukU2OqWwv0mezZ5O4VbSgwHO3Xgc6wL4Cb0W7cJd2Euxkgq8yi
   R5BTD9zlEV7pv037EQn6ACIPppoKPYGhLLcxjGMFn9x7efEkFkZ0ZaRPL
   O8nKHBCq0GJpDHpApMw53/0gwmexYKDkHx9X9z+GbYKoihfVyGdqReVQ+
   20ZdlHAriqNw7FudP7iEWfK1PlVs1BPgXEyPWsLI+T3d+9uKTryLCn+Lm
   g==;
X-CSE-ConnectionGUID: MINL0cSRQ+S2ulttXUU4XQ==
X-CSE-MsgGUID: CtG8pCIlSQ+I1mAf1wKmPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="70406048"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="70406048"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 03:15:26 -0800
X-CSE-ConnectionGUID: JGyTMG6ERISRZye3oPZ/fQ==
X-CSE-MsgGUID: jwXsVocsRmmwRB30PvlIIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="209739278"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.181])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 03:15:24 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V2 2/6] i3c: master: Mark last_busy on IBI when runtime PM is allowed
Date: Wed,  4 Feb 2026 13:15:07 +0200
Message-ID: <20260204111511.78626-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204111511.78626-1-adrian.hunter@intel.com>
References: <20260204111511.78626-1-adrian.hunter@intel.com>
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
	TAGGED_FROM(0.00)[bounces-42056-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 52534E4FE0
X-Rspamd-Action: no action

When an IBI can be received after the controller is
pm_runtime_put_autosuspend()'ed, the interrupt may occur just before the
device is auto-suspended.  In such cases, the runtime PM core may not see
any recent activity and may suspend the device earlier than intended.

Mark the controller as last busy whenever an IBI is queued (when
rpm_ibi_allowed is set) so that the auto-suspend delay correctly reflects
recent bus activity and avoids premature suspension.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V2:

	Adjusted slightly for earlier changes


 drivers/i3c/master.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 49fb6e30a68e..48d1b1256290 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2721,9 +2721,14 @@ static void i3c_master_unregister_i3c_devs(struct i3c_master_controller *master)
  */
 void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot)
 {
+	struct i3c_master_controller *master = i3c_dev_get_master(dev);
+
 	if (!dev->ibi || !slot)
 		return;
 
+	if (master->rpm_ibi_allowed)
+		pm_runtime_mark_last_busy(master->dev.parent);
+
 	atomic_inc(&dev->ibi->pending_ibis);
 	queue_work(dev->ibi->wq, &slot->work);
 }
-- 
2.51.0


