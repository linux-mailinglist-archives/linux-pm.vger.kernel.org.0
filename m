Return-Path: <linux-pm+bounces-39917-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBADCDCFEA
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 19:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8FCA30141EB
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 18:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C46329C4F;
	Wed, 24 Dec 2025 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcKH+yzV"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2728145A1F
	for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766600470; cv=none; b=VQI5otKsimJMXfsuSUYJRDtoHC0qsQSX11EGkZmwEWapTe0IwS1Jpn5RxR968ZGMULpJR76rHt6Oj3BEH46oDdO62YJNEjQts5R1FEUd4sL4w7tKgvZ6mZgqeuigSeKuRjyu76YZc8ieTlzWpwm6BYdgfcS8xj+m8LU7QjviLns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766600470; c=relaxed/simple;
	bh=kUEtGZexwuxWvBBaH3Bt8qhV0BzOV87ZgQoNucqqOoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jgXrFzmWzaxbsZ4yscNwwRreZLIo5Q1StPryy5MD5+WysncepvgYI6UdM8/CQlHkZvq34lhBhZeW9GCpnWVO5OmpHzxotX3EYMpJJavTbMPmvii/W7I8MuxAmcSEVZ9dkvh8bsFWOVj/4Zx8LM041S9ehdnRqJ+RaV+j7mnGLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WcKH+yzV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766600467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FMDaQlrjaLe9XjxVldJhVnRL6bKjLFnfMBk3tnqVZUo=;
	b=WcKH+yzVec6Ul9MIAi+Q2Zg9he4s1w8R06NyafTGj5X7EcjLdGu+JdOPdRpazQ7jtYsCui
	qGylf0L4mNtu+GxSFZqcAeK2NKViFHNfVRv7LKct6FVPdS4BmWqsIX9JDRycXkDzJvIJ/P
	KzZuoY/wHoD/MJFBeh0acKZYfi1r0pU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-iF84iMlRNH6skcQMwTbYoQ-1; Wed,
 24 Dec 2025 13:21:04 -0500
X-MC-Unique: iF84iMlRNH6skcQMwTbYoQ-1
X-Mimecast-MFC-AGG-ID: iF84iMlRNH6skcQMwTbYoQ_1766600463
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 345ED1955F3F;
	Wed, 24 Dec 2025 18:21:03 +0000 (UTC)
Received: from mrout-thinkpadp16vgen1.punetw6.csb (unknown [10.74.64.11])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B78A519560A7;
	Wed, 24 Dec 2025 18:20:59 +0000 (UTC)
From: Malaya Kumar Rout <mrout@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: mrout@redhat.com,
	malayarout91@gmail.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH] PM: hibernate: Fix crash when freeing invalid crypto compressor
Date: Wed, 24 Dec 2025 23:50:54 +0530
Message-ID: <20251224182055.124020-1-mrout@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

When crypto_alloc_acomp() fails, it returns an ERR_PTR value, not NULL.
The cleanup code in save_compressed_image() and load_compressed_image()
unconditionally calls crypto_free_acomp() without checking for ERR_PTR,
which causes crypto_acomp_tfm() to dereference an invalid pointer and
crash the kernel.

This can be triggered when the compression algorithm is unavailable
(e.g., CONFIG_CRYPTO_LZO not enabled).

Fix by adding IS_ERR_OR_NULL() checks before calling crypto_free_acomp()
and acomp_request_free(), similar to the existing kthread_stop() check.

Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
---
 kernel/power/swap.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 33a186373bef..8ee2fa995580 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -902,8 +902,10 @@ static int save_compressed_image(struct swap_map_handle *handle,
 		for (thr = 0; thr < nr_threads; thr++) {
 			if (data[thr].thr)
 				kthread_stop(data[thr].thr);
-			acomp_request_free(data[thr].cr);
-			crypto_free_acomp(data[thr].cc);
+			if (data[thr].cr)
+				acomp_request_free(data[thr].cr);
+			if (!IS_ERR_OR_NULL(data[thr].cc))
+				crypto_free_acomp(data[thr].cc);
 		}
 		vfree(data);
 	}
@@ -1499,8 +1501,10 @@ static int load_compressed_image(struct swap_map_handle *handle,
 		for (thr = 0; thr < nr_threads; thr++) {
 			if (data[thr].thr)
 				kthread_stop(data[thr].thr);
-			acomp_request_free(data[thr].cr);
-			crypto_free_acomp(data[thr].cc);
+			if (data[thr].cr)
+				acomp_request_free(data[thr].cr);
+			if (!IS_ERR_OR_NULL(data[thr].cc))
+				crypto_free_acomp(data[thr].cc);
 		}
 		vfree(data);
 	}
-- 
2.51.0


