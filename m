Return-Path: <linux-pm+bounces-40043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E489FCE996A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 12:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11EDC30185C4
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 11:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77C72EAB72;
	Tue, 30 Dec 2025 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LeOYrXX1"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DBE2E9EDA
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767095789; cv=none; b=ifm4qCE/33btsdc15CdSo4gtYviPTiEOmBd/0Sr6I5LEOX6vv5VwOjRmGkkUFK/6fCMcnY8hnB5ZHNioXLWa9B/K6ffp0pGflUWFZefb5gHK3j9C2CFWiTJ8Chv42YlL2oz20acMBKaz6lDhTWSut/kJDsxQqZ5qVORkmYz2e/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767095789; c=relaxed/simple;
	bh=SiCEdssybs+3Z6oDb/8jDCJ/o7xt3WYbcfK5j1kYg1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1CbxtywgatnSKXT1iSm9z1ANDFYUzAg5tbq4PoDNtsdJ5dRTmCG70QUR9daWrZ6VEeq+A8jClr0fCjU7bnnzajNGra0H4aAX5TvP2J2L+aMJYVh3MQzaQd8Le15xy/1kupPuGO9spWHeaxmU6CeEYmHjg1BqKAhD5iHnxKJAcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LeOYrXX1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767095787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egm9ec/npY1danG7l7/ibhgiZQkW9icZioSmLCCrJ9A=;
	b=LeOYrXX158p+t2PCfZnJJnSOfR0y/ZvdKbZf+SY9zaNk1iKI8cNksgeruhuHrBenwZMekp
	Cm97qzv23SWnxHFOFVGNnyEq11nyw0m2gukm7xH9KhE5ebs5J3EeyUhYCXLKyeDKt1q235
	RYpDwFlDkvrqAkMM9w8l/94lmkWbtYE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-uao5-NfpOuK8K95BKkzANg-1; Tue,
 30 Dec 2025 06:56:23 -0500
X-MC-Unique: uao5-NfpOuK8K95BKkzANg-1
X-Mimecast-MFC-AGG-ID: uao5-NfpOuK8K95BKkzANg_1767095782
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36AB51956080;
	Tue, 30 Dec 2025 11:56:22 +0000 (UTC)
Received: from mrout-thinkpadp16vgen1.punetw6.csb (unknown [10.74.64.151])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B530B180045B;
	Tue, 30 Dec 2025 11:56:18 +0000 (UTC)
From: Malaya Kumar Rout <mrout@redhat.com>
To: rafael@kernel.org
Cc: Malaya Kumar Rout <mrout@redhat.com>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PM: hibernate: Fix crash when freeing invalid crypto compressor
Date: Tue, 30 Dec 2025 17:26:13 +0530
Message-ID: <20251230115613.64080-1-mrout@redhat.com>
In-Reply-To: <CAJZ5v0hn1E=tWVoG7nKsD3_KGygkaGpeSoQ4JsMaJNgugT_Tnw@mail.gmail.com>
References: <CAJZ5v0hn1E=tWVoG7nKsD3_KGygkaGpeSoQ4JsMaJNgugT_Tnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When crypto_alloc_acomp() fails, it returns an ERR_PTR value, not NULL.
The cleanup code in save_compressed_image() and load_compressed_image()
unconditionally calls crypto_free_acomp() without checking for ERR_PTR,
which causes crypto_acomp_tfm() to dereference an invalid pointer and
crash the kernel.

This can be triggered when the compression algorithm is unavailable
(e.g., CONFIG_CRYPTO_LZO not enabled).

Fix by adding IS_ERR_OR_NULL() checks before calling crypto_free_acomp()
and acomp_request_free(), similar to the existing kthread_stop() check.

Fixes: b03d542c3c95 ("PM: hibernate: Use crypto_acomp interface")
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
2.52.0


