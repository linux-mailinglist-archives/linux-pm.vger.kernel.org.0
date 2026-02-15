Return-Path: <linux-pm+bounces-42663-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI5BDTafkWlMkgEAu9opvQ
	(envelope-from <linux-pm+bounces-42663-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 11:25:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCC613E779
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 11:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67A533011A6A
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 10:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAFB275B05;
	Sun, 15 Feb 2026 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/hggjNY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32ED271A94
	for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771151138; cv=none; b=oNEBHDz1UujpDSbJ8LoxXTRQD++kacffsxTDp7ULnPbBd6SC+NAtR7D/CJTMks/13n+xymfglLKBq1pidg7TT+Ij8xJq1hKSfQ2Rg7tVWgbNJsNcSMI2VC99G7JkQYBTFnM4aYhUNnZTUwR4FeuDkOROkAHZ4Lc4Yyyao0SD7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771151138; c=relaxed/simple;
	bh=IL0ED4azP5+tZE7VbwZD67kNLIUExaCqMw8oEUVZTjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IGkp/Mh8Yqdj8mbdl0CUYpLRmn99NvgcE2M7193Jlm4hFC3Ad4uUbRBP9RmrNL/7EqVU29Abef9hyWCWXDAWu5tETrqP4Zs2ucOa8QMgXgXWfJQa1fTH3+jre45VYb0F4nnpXGRB3Vpwp90TDx6j/KSyo8pXNbsv5cZlDfdj5SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/hggjNY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad20007c73so3068185ad.2
        for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 02:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771151136; x=1771755936; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M5ZfG29FZ8wVjzGY2sY5PX3vPhnOYrCYILyRw0LteQc=;
        b=c/hggjNYp7cEK7LSVVDr0yLHz8XAvcmeE5tOSF6P1yznDsvdVwKAhi8rD8/bKNtxjU
         AyvEI5yYEMEgHZB6XgBSPdIgljFzW4CbNT4kdPf1ER4PjWCH4dUT0XR/EML0GiRY47G7
         KbMn4plJh5YkfbM3Fuf329SkFpZJAQDsW7l+pNDj95X4lUuKi1I52rP1raN0ksBOpSQW
         C3NYXpfH/cmRS8xFM83E2LNjrzv7H2R8s0eggKZCp2xblHq7I2BvqiqY/+Yvnk9EF/st
         SgiQO5qgPiXYM6ROrpxoYpncmA5c+YyZlZVC4jVkBdG/AQG9Raq0l2VIXgSw0WOMfAht
         GM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771151136; x=1771755936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M5ZfG29FZ8wVjzGY2sY5PX3vPhnOYrCYILyRw0LteQc=;
        b=ATRMZq/9dxbeiOVZiK/g4EnjS0PgKdh8ALeLCUrXs+A2N6ULyiiHgwomUuwdwXD9KC
         dPCqB88qFL5Swf0EGPHLBrZ8/tHO6fKZdq0V5EaeJeRmsxdU6UAb7ypNYn0ZERq7vvQ1
         4V1yn7yAO/qCPwrEaS+m6Xm14XhEnY3d6l/+UgaJRUEymu9vQEwhcQrePTpIblXznIuM
         O+vtW+C+PNWgCC8nvnL156ClS2/J8/dnM6XcKnHs2g61Ex3dP4yBmlt+WcUOxVejxdsn
         89zNSLewVK0EQeSsnbqgMo+23PVOjh9gGpSkT4ZpF3a+3XJ7OPkLM3TZsiRfzYiQ1g62
         X+3g==
X-Forwarded-Encrypted: i=1; AJvYcCVlcG1cBjBevhkWxbFE4tGHpm+Xnu3CLkENZwpeAXD1IGaUWfZjFbH5Yr2nTuP0En7YGXv8tHC3+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRGjeze6vHWQPGqPROa8KnLRG3gsCdl0I29BIdUlO9LsQtEGlV
	bXXz5CJStQONQbb1w5GvnZNAnmIM+U/NckHqvr8oTr12bm1RF7Wh1RSO
X-Gm-Gg: AZuq6aKfDDoZv6pvuzn8f4ksVD8LUz5vroJHgU3DMVCzkR+tXJTnkjedpUMI0rrHwRz
	Q+5JxBjTQzMNSiDBlI/FnNUcRb+UCeN2nBQgOEsfQBi3vtnJdBpjusIIwhMuoQANZfEZMHo8kJx
	rc1ZLOMTomCAyDLaE52izs/rCzIvOiwAffGWO4XtGodJkDN+dvrgvjE/0ed5S8T8ll96xfcebUv
	FfVygkBfWEUkm6uhs2WKEMOm+hUDoMl6McU3hDROxgFnUpB/rE8MmCjbQ85fvEp1ybhj64QiU2F
	iNggHRrnvz8VSjHWTxqq4ImzpbmpLMbdi+y0L195QqO6bFrMbMuKLAjEDcUDGYkxe2YnVTpexJu
	dymLMiJICet99yKL81PPClpZ2DQZSebBDmnyA1XkP7Rphw3mdh3GHI3ZZ82NvLqcQysNcAjldCt
	McbDe0lMzHbMTRDnYbK8TIdWLTOyXlEJlQ/cMTLqTlfJnKj8agrdaMAHrT1sSG
X-Received: by 2002:a17:903:1c2:b0:2a7:7872:8f52 with SMTP id d9443c01a7336-2ad174a9143mr58528075ad.26.1771151136229;
        Sun, 15 Feb 2026 02:25:36 -0800 (PST)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a714786sm41862045ad.31.2026.02.15.02.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 02:25:35 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 15 Feb 2026 18:25:10 +0800
Subject: [PATCH 2/2] mm, swap: merge common convention and simplify
 allocation helper
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260215-hibernate-perf-v1-2-f55ee9ee67db@tencent.com>
References: <20260215-hibernate-perf-v1-0-f55ee9ee67db@tencent.com>
In-Reply-To: <20260215-hibernate-perf-v1-0-f55ee9ee67db@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Carsten Grohmann <carstengrohmann@gmx.de>, linux-kernel@vger.kernel.org, 
 "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, 
 Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771151125; l=2753;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=+lKDO9BRU6kc51T9mv3KyI+WElk31bKrGwbPt/FiL4w=;
 b=mc8fhlhZndV1qntjOVtm5dnTc05MQRd1xhCwdQbwILalsMpHVxJCLtTKLY8kHpgNXluNOsPei
 GAN9PELyjVmC94zru8UxwPQxV9dNA8wexNL6GEtskSPCreFXRwSc4/4
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42663-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,huaweicloud.com,gmail.com,redhat.com,gmx.de,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tencent.com:mid,tencent.com:email]
X-Rspamd-Queue-Id: 9FCC613E779
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

almost all callers of the cluster scan helper require the: lock -> check
usefulness/emptiness -> unlock routine. So merge them into the same
helper to simplify the code.

This should also improve the scan slightly, as a few callers didn't
check the emptiness, which might help reduce fragmentation in rare
cases.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index bcac10d96fb5..03cc0ff4dc8c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -923,11 +923,14 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 	bool need_reclaim, ret, usable;
 
 	lockdep_assert_held(&ci->lock);
-	VM_WARN_ON(!cluster_is_usable(ci, order));
 
-	if (end < nr_pages || ci->count + nr_pages > SWAPFILE_CLUSTER)
+	if (!cluster_is_usable(ci, order) || end < nr_pages ||
+	    ci->count + nr_pages > SWAPFILE_CLUSTER)
 		goto out;
 
+	if (cluster_is_empty(ci))
+		offset = cluster_offset(si, ci);
+
 	for (end -= nr_pages; offset <= end; offset += nr_pages) {
 		need_reclaim = false;
 		if (!cluster_scan_range(si, ci, offset, nr_pages, &need_reclaim))
@@ -1060,14 +1063,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
 			goto new_cluster;
 
 		ci = swap_cluster_lock(si, offset);
-		/* Cluster could have been used by another order */
-		if (cluster_is_usable(ci, order)) {
-			if (cluster_is_empty(ci))
-				offset = cluster_offset(si, ci);
-			found = alloc_swap_scan_cluster(si, ci, folio, offset);
-		} else {
-			swap_cluster_unlock(ci);
-		}
+		found = alloc_swap_scan_cluster(si, ci, folio, offset);
 		if (found)
 			goto done;
 	}
@@ -1332,14 +1328,7 @@ static bool swap_alloc_fast(struct folio *folio)
 		return false;
 
 	ci = swap_cluster_lock(si, offset);
-	if (cluster_is_usable(ci, order)) {
-		if (cluster_is_empty(ci))
-			offset = cluster_offset(si, ci);
-		alloc_swap_scan_cluster(si, ci, folio, offset);
-	} else {
-		swap_cluster_unlock(ci);
-	}
-
+	alloc_swap_scan_cluster(si, ci, folio, offset);
 	put_swap_device(si);
 	return folio_test_swapcache(folio);
 }
@@ -1945,10 +1934,7 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
 		pcp_offset = this_cpu_read(percpu_swap_cluster.offset[0]);
 		if (pcp_si == si && pcp_offset) {
 			ci = swap_cluster_lock(si, pcp_offset);
-			if (cluster_is_usable(ci, 0))
-				offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
-			else
-				swap_cluster_unlock(ci);
+			offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
 		}
 		if (!offset)
 			offset = cluster_alloc_swap_entry(si, NULL);

-- 
2.52.0


