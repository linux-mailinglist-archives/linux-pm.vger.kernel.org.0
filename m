Return-Path: <linux-pm+bounces-41932-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GF1AdKZgWl/HAMAu9opvQ
	(envelope-from <linux-pm+bounces-41932-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 07:46:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D347FD56FA
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 07:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9823F30C5334
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 06:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C5F37B415;
	Tue,  3 Feb 2026 06:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="tLoj5Eh/"
X-Original-To: linux-pm@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157282E8B64
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 06:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100604; cv=none; b=mVFecp/ZxZBK1ah/wumCrIsMdfgMRprh+2YklZThSr3k6+9nwhrt2R4TL+mdoc8vCInVYDpcUexULajTH99Ogzh0dCoXv+H0J+Q+QqWjf3Jd8kITcpDQoV/x27+IPbVlOCL8hhEfc+tW33edAGVa+dnDAzWo3gB62E6ZQwIM5Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100604; c=relaxed/simple;
	bh=Y5eVcF/kprlwyaB72zcGUK0YkIWKS/geT/OC2MDm4aI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B/J/c/cY/JzjbqFS1pSmDgUitmjy/Y3TDWBBKwrBZ/RZ/cIsDiVoh0sqoRd+1f0tZubWO8QiGDT5cBsHm76RjF/AlMNPtQ88+nkmDmOibY76U2on2vcpaMCWKX1Lpmzh8ptxNZ2aSqE+yEssjqvuoamsSurhjgyLna0Wj2tbGAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=tLoj5Eh/; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 6136aaXH095609
	for <linux-pm@vger.kernel.org>; Tue, 3 Feb 2026 14:36:36 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 6136ZE9H077900;
	Tue, 3 Feb 2026 14:35:14 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4f4tyS1n7mz2MZGh2;
	Tue,  3 Feb 2026 14:35:12 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 3 Feb 2026 14:35:12 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <pavel@kernel.org>,
        <gregkh@linuxfoundation.org>, <dakr@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ke.wang@unisoc.com>, <di.shen@unisoc.com>, <xuewen.yan94@gmail.com>
Subject: [PATCH] PM: sleep: core: Fix sync issues between work_in_progress and must_resume
Date: Tue, 3 Feb 2026 14:34:59 +0800
Message-ID: <20260203063459.12808-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 6136ZE9H077900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1770100540;
	bh=friVGGYZGjT3EFdufZzfyfrOF2gSvrj8FbnJIrYeQm0=;
	h=From:To:CC:Subject:Date;
	b=tLoj5Eh/iCMczwVRTDjZeSM117KubD7XWSIVqFBsQEBoCKZveCm5gS1UBd5HVY3CX
	 1oYiOQ3mNcKlkI7jgcVaDUuwMSIIVDodxWmkZu4TZibTJWfa6uz2/CnEUsranEqEpj
	 Xwc879ggW+7qzKV2vmJhJaN0I5ILJM6WHmPfEbbBDNItq5QUz5DmcT+WHvF1WB9O8s
	 JRPYhQ8t9QTbkXZl07e6u8VB7fVK8DHQ8B93iXlm9Hs50GTUbETvyFbaZv336LhNTA
	 INJV3kKOykdM5xka3hO6QoRTN/r7arTLwbCA1FFQc6TOxp3emfwwS/xWR76HxlUsNX
	 XmUmItfPbOL6w==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[unisoc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[unisoc.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[unisoc.com:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,unisoc.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-41932-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,unisoc.com:email,unisoc.com:dkim,unisoc.com:mid];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuewen.yan@unisoc.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D347FD56FA
X-Rspamd-Action: no action

There is a synchronization issue when suspend async:

     suspend-task:                           async-child-kworker
dpm_noirq_suspend_devices
 mutex_lock(dpm_list_mtx)                   async_suspend_noirq
 list_for_each(dpm_late_early_list)         device_suspend_noirq
  dpm_clear_async_state(parent);             dpm_run_callback()
   reinit_completion()                       dpm_superior_set_must_resume(dev)
   parent->power.work_in_progress = false;     dev->parent->power.must_resume = true;

Because the power.work_in_progress and power.must_resume use the
same byte:
struct dev_pm_info {
   ....
  [56] struct completion completion;
  [104] struct wakeup_source *wakeup;
  [112] bool wakeup_path : 1;
  [112] bool syscore : 1;
  [112] bool no_pm_callbacks : 1;
  [112] bool work_in_progress : 1;
  [112] bool smart_suspend : 1;
  [112] bool must_resume : 1;
  [112] bool may_skip_resume : 1;
  [112] bool strict_midlayer : 1;
  ...
}

So, if suspend-task and child-kworker modify these two variables
simultaneously, it will cause mutual overwriting issues.
More severely, this may result in the work_in_progress variable
not being set to false, preventing the __dpm_async() function from
queuing work to execute the parent’s suspend function.
Consequently, the completion event will never be finalized,
ultimately causing the suspend process to be blocked.

To resolve the aforementioned issue, the must_resume variable
should be protected using dpm_list_mtx.

Fixes: aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending children")
Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronous")
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 drivers/base/power/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 97a8b4fcf471..7ab42e065074 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1407,8 +1407,11 @@ static void dpm_superior_set_must_resume(struct device *dev)
 	struct device_link *link;
 	int idx;
 
-	if (dev->parent)
+	if (dev->parent) {
+		mutex_lock(&dpm_list_mtx);
 		dev->parent->power.must_resume = true;
+		mutex_unlock(&dpm_list_mtx);
+	}
 
 	idx = device_links_read_lock();
 
-- 
2.25.1


