Return-Path: <linux-pm+bounces-41704-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCOrC0ule2lWHgIAu9opvQ
	(envelope-from <linux-pm+bounces-41704-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:22:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A59B3852
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A50E23073DEC
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 18:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499BB2F657C;
	Thu, 29 Jan 2026 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPqCLxVV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5462F690D;
	Thu, 29 Jan 2026 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710743; cv=none; b=iUn1i9MD0d/BH6NzAcS8MFjzQChq/AqFUo5puV/8KZknmstCW/tMJZqk41W9YRkOH4/o2bgBmDu8RkTaVjJ20njGBxSzFAk4oZIwcz3T3+CHpLqvxLKX0/wofHYPhVe3OBFeY9XzhiO8NtgfIaudElAYwoPXzgmaDOzYLi9tRHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710743; c=relaxed/simple;
	bh=D+WHOGKFshiFkAf45pAICzZWD+m0dKpyCxa51cP0wQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcgizi0aAZ2l5nAzdPouliX450CsOu1M6DMAzT/eu083cQEh/YvMH+z0RsgdC68BSQYbpPj69yE1CToZtY+tDkzhzuJYoybxmsun8utl2gI33b+hJteDrUnalo6ariLu4TzV/To4W27y4i+eSJgg/H+PhucjVrwFtm8VKypKe3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPqCLxVV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769710741; x=1801246741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D+WHOGKFshiFkAf45pAICzZWD+m0dKpyCxa51cP0wQQ=;
  b=aPqCLxVV61ETKAaFpYqeApOUoVK+WFA7GeBqur7UQo0vXMVkkUw3sJjI
   RscCeyBnFzrc3kbEigsaeQ3hNGMhZeRJEL6uAQm8uzor5fKrVWmrfMODz
   hmyPflB7oNtzrEm99E4/Ql/IUuOnuTwSwDpTmmnMHJn/xhUcDfWHq0+v5
   /f1Ib0HohUCucdxbq+FLO2XNlKMRumKbJdNIeEgzNa54CKMWOIiN+gev0
   EvfotCf8+7ArkgYrOtW85TQAAJlumTDoLwDQmP1a+T236ye79EZzDrfR0
   396gIoMuzUQZygGOEhXq/w8RO+HM0HDe0L56BcJw+NQWGxgJuPLBlhv8V
   A==;
X-CSE-ConnectionGUID: ebjk5kHYQoCyijjLq/k+Xg==
X-CSE-MsgGUID: dgUvRErtTDu4QFB9YknzLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70158284"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="70158284"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:19:01 -0800
X-CSE-ConnectionGUID: EvvHSjuSTnK+KcRcB9zE4g==
X-CSE-MsgGUID: r5UZsRcyT7KSWmAKjVuHtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="208255292"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.96])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:18:59 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 3/7] i3c: master: Mark last_busy on IBI when runtime PM is allowed
Date: Thu, 29 Jan 2026 20:18:37 +0200
Message-ID: <20260129181841.130864-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129181841.130864-1-adrian.hunter@intel.com>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41704-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.hunter@intel.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: A4A59B3852
X-Rspamd-Action: no action

When an IBI can be received after the controller is
pm_runtime_put_autosuspend()'ed, the interrupt may occur just before the
device is auto‑suspended.  In such cases, the runtime PM core may not see
any recent activity and may suspend the device earlier than intended.

Mark the controller as last busy whenever an IBI is queued (when
rpm_ibi_allowed is set) so that the auto-suspend delay correctly reflects
recent bus activity and avoids premature suspension.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/i3c/master.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index bcc493dc9d04..dcc07ebc50a2 100644
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
+		pm_runtime_mark_last_busy(master->rpm_dev);
+
 	atomic_inc(&dev->ibi->pending_ibis);
 	queue_work(dev->ibi->wq, &slot->work);
 }
-- 
2.51.0


