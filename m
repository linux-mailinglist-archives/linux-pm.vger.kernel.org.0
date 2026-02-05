Return-Path: <linux-pm+bounces-42150-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ+lCJqThGk43gMAu9opvQ
	(envelope-from <linux-pm+bounces-42150-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 13:56:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6FBF2DDB
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 13:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43749301BCE1
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9FA3D4125;
	Thu,  5 Feb 2026 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5STCCSt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472903BFE25
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296044; cv=none; b=kSrZFjW0bykiSaD104Ij2CrnSDMDU6tSluNCGO0rdweqHKFboodU3Q+sJdnzf+kXrnIySun5bXJrmX+bzMmKVpwOZolLxzeHTaTt2c0opXC9hi/aPXg6MRgbJUA1xyQ8YUbjPWtB3seuPvnDth1SfOCuj1g4wgsnVVqTLWZ6CtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296044; c=relaxed/simple;
	bh=45Hdvp14TR+rp/B2za20RDYQwuj22FkfbJJBsn7soII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYKRAYNdbkeWNtHSm7tnk+2ub3ve0NhlR7hLT6GE69anOquPosB3VXJl42keuqCViJdM3zqomGXF0hcv96pexpUNYpXzHsefpvncLkG3kDwP/bJcQr7HqRQskGnrE5yXzUp7B9u1H+Ooy4j+u/rt5LzKbJNXggw6i+BxmyoHb/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5STCCSt; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770296044; x=1801832044;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=45Hdvp14TR+rp/B2za20RDYQwuj22FkfbJJBsn7soII=;
  b=A5STCCSt928YaoK8LQJGQPZ1QRt2lJVjSfl8+DRzFWJMBSkknO32at6m
   e1PPw1SMKf2PLIbLpNQ4o269O/Beqddg84ijK2LmvCmxzTN8uaFxZSmZj
   C8LH0jHEazhNv3VDWtoqmGabJpahmg8hotCokH/Wqs7rdL1ZbstJpXQBX
   nbcw9QVVZXWI8wd80X9UnrGGSKtA+jGPdNEYdmaasfxW8Fme1XBz9PPBY
   za1YjlWHO/srfUrlTKlMwxiOwgW5ngG0PMa1TN4yYzeQSp4VYXtNv6bRQ
   IqSnJMIeFyPtffiDMnM3vykBYc51fCDZnGnCf407tt6xhMdQnokFI27F1
   Q==;
X-CSE-ConnectionGUID: 8XAunZt+SuaZqF8ddQf1Ag==
X-CSE-MsgGUID: xbrdKy7fQGyuk9nGAN1Hwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="70690482"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="70690482"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 04:54:03 -0800
X-CSE-ConnectionGUID: ccpvsAi4SN+cIEtYZU+xrQ==
X-CSE-MsgGUID: XY4EmFgWSA69XolV7BqLgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="210549895"
Received: from powerlab.igk.intel.com ([10.102.73.240])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 04:54:02 -0800
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>,
	Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH] Documentation: admin-guide: PM: Document intel_idle.table cmdl option
Date: Thu,  5 Feb 2026 12:53:54 +0000
Message-ID: <20260205125354.632891-1-artem.bityutskiy@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42150-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[artem.bityutskiy@linux.intel.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F6FBF2DDB
X-Rspamd-Action: no action

Add the 'intel_idle.table' command line option documentation.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 Documentation/admin-guide/pm/intel_idle.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/pm/intel_idle.rst b/Documentation/admin-guide/pm/intel_idle.rst
index ed6f055d4b14..188d52cd26e8 100644
--- a/Documentation/admin-guide/pm/intel_idle.rst
+++ b/Documentation/admin-guide/pm/intel_idle.rst
@@ -260,6 +260,17 @@ mode to off when the CPU is in any one of the available idle states.  This may
 help performance of a sibling CPU at the expense of a slightly higher wakeup
 latency for the idle CPU.
 
+The ``table`` argument allows customization of idle state latency and target
+residency. The syntax is a comma-separated list of ``name:latency:residency``
+entries, where ``name`` is the idle state name, ``latency`` is the exit latency
+in microseconds, and ``residency`` is the target residency in microseconds. It
+is not necessary to specify all idle states; only those to be customized. For
+example, ``C1:1:3,C6:50:100`` sets the exit latency and target residency for
+C1 and C6 to 1/3 and 50/100 microseconds, respectively. Remaining idle states
+keep their default values. The driver verifies that deeper idle states have
+higher latency and target residency than shallower ones. Also, target
+residency cannot be smaller than exit latency. If any of these conditions is
+not met, the driver ignores the entire ``table`` parameter.
 
 .. _intel-idle-core-and-package-idle-states:
 
-- 
2.52.0


