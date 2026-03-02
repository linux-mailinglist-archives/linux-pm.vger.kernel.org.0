Return-Path: <linux-pm+bounces-43442-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJtpIEvEpWnEFgAAu9opvQ
	(envelope-from <linux-pm+bounces-43442-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 18:09:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1B81DD8EF
	for <lists+linux-pm@lfdr.de>; Mon, 02 Mar 2026 18:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB3603042966
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 17:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B623FFAB6;
	Mon,  2 Mar 2026 17:08:55 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8235421896
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772471335; cv=none; b=e1ULCuHOiPPOYTI7ZnXMM6mfgMzvyxJM7sBMR4vnOYKPovapYcqy1dY5MIczlZAobCr3fnvhXADAh152dlKS/Nk65PiHJ8DryGtOiskSR5QlVKv6X/xECtX6jNy+LloQSyonzkjbeHLSw+FYCWe9U7KBbrO5PlERhRY99+0iYzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772471335; c=relaxed/simple;
	bh=tfXW51+ANMqCAQa4c3Uk66SykB3Rz6XN668AhUnavnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q9cLQE5hNpj1sUkM4jnfiKEUkAOc4poAZcLPO1B/oKGQLHM4kgRMG7V7ZOtqqLshcCD6DHyzg09bsGDMWA5I+F41A4A+/15XIZsN0GMJhDlfME1oyFcISrHwx7ScG1Blsh8xSRgxhK0y121+PCY/zWA/lL/WogC3v4NyseRQWBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 3 Mar 2026 01:53:36 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: linux-pm@vger.kernel.org
Cc: linux-mm@kvack.org,
	rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	akpm@linux-foundation.org,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	youngjun.park@lge.com
Subject: [RFC PATCH 0/2] kernel/power: fix swap device reference handling in hibernation swap path
Date: Tue,  3 Mar 2026 01:53:32 +0900
Message-Id: <20260302165334.1278479-1-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AD1B81DD8EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43442-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,kernel.org,linux-foundation.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,linux-pm@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.521];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lge.com:mid]
X-Rspamd-Action: no action

This series addresses two issues in the hibernation swap path.

First, grabbing and releasing the swap device reference on every slot
allocation is inefficient across the entire hibernation swap path.

Second, in the uswsusp path, only the swap type value is retrieved at
lookup time without holding a reference. If swapoff races after the
type is acquired, subsequent slot allocations operate on a stale swap
device.

The fix is to hold the swap device reference from the point the swap
device is looked up, and release it once at each exit path.

  Patch 1: Release the reference immediately after each slot allocation
            as a preparatory step.
  Patch 2: Lift the reference acquisition to the lookup site and place
            put_swap_device_by_type() at all relevant cleanup paths in
            swap.c and user.c.

This series is based on mm-new.

I'm sending this as RFC because my familiarity with the kernel/power
and snapshot paths is limited. I believe the approach is reasonable,
but I'd appreciate any feedback before moving forward with proper
testing and a formal submission.

Thanks,
Youngjun Park

Youngjun Park (2):
  mm/swap: release swap reference on each hibernation slot allocation
  kernel/power: hold swap device reference across hibernation swap
    operation

 include/linux/swap.h |  1 +
 kernel/power/swap.c  | 12 +++++++---
 kernel/power/user.c  |  9 +++++++-
 mm/swapfile.c        | 55 ++++++++++++++++++++++----------------------
 4 files changed, 45 insertions(+), 32 deletions(-)

-- 
2.34.1


