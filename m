Return-Path: <linux-pm+bounces-40181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E702CF303E
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 11:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 705AC30039D9
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 10:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820C3316185;
	Mon,  5 Jan 2026 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcSa4BcZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E386313E00
	for <linux-pm@vger.kernel.org>; Mon,  5 Jan 2026 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609471; cv=none; b=Cc5AtfRFFu42xEnpkjOBK+ocdtWQ93EgbZfRON0BILWZ3Xcn8zb4IHsgaPHia1jzV2A9Brgl6Z+PgYNfX9gYMFmGufoUWSMNmxUyrec982bOgzVFCuTijFO78MGyR8x5ZEyUlnfbjR6frEkaG2UFBdWyZtYmad0/YJs4/ZOdmGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609471; c=relaxed/simple;
	bh=wXjYCJBvOZhStUq5+4QiketDUitlpvp5MjWaZtBKM+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k7K3Cz1ETxVhl0LGxbBnJVjEuet3tQIgGmglJeUItydFeI2LqWs+QoMcOIrwGJD5iShGaKvqp5DmWE2VvNW74CKrAc4D45IRbc3DCVLzKoHQBQ+BXi0Ts25RTj5AsETDcTPEAwDoNe5530F1FOGOyyl+hjsBzPDys7MuVtRL12w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WcSa4BcZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767609467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9nHpy5jbivDnbEg5odYYdL9Pd8vhtyOjv88OCtDGS5U=;
	b=WcSa4BcZAob9IbnstlTVQqK+Bzo+/Qq1CvQjfepKRL5BohuIZZYomoucxRVzO4W14KPyI9
	9s+PnS+i0mMOusDaMP8WrT6B6oGyAqr/8vjkKb0PPJ+U2j3PAYIAA0fhMP5kc47l67MWKv
	ynjqGcEAsGtn3C17ubhWWVdUr7FAuy8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-TJ2SErVWM7ed5WJXw1W73A-1; Mon,
 05 Jan 2026 05:37:42 -0500
X-MC-Unique: TJ2SErVWM7ed5WJXw1W73A-1
X-Mimecast-MFC-AGG-ID: TJ2SErVWM7ed5WJXw1W73A_1767609461
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDE671956089;
	Mon,  5 Jan 2026 10:37:39 +0000 (UTC)
Received: from mrout-thinkpadp16vgen1.punetw6.csb (unknown [10.74.64.191])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E2FC180045B;
	Mon,  5 Jan 2026 10:37:35 +0000 (UTC)
From: Malaya Kumar Rout <mrout@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: mrout@redhat.com,
	malayarout91@gmail.com,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Changwoo Min <changwoo@igalia.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH] PM: EM: Fix memory leak in em_create_pd() error path
Date: Mon,  5 Jan 2026 16:07:29 +0530
Message-ID: <20260105103730.65626-1-mrout@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When ida_alloc() fails in em_create_pd(), the function returns without
freeing the previously allocated 'pd' structure, leading to a memory leak.
The 'pd' pointer is allocated either at line 436 (for CPU devices with
cpumask) or line 442 (for other devices) using kzalloc().

Additionally, the function incorrectly returns -ENOMEM when ida_alloc()
fails, ignoring the actual error code returned by ida_alloc(), which can
fail for reasons other than memory exhaustion.

Fix both issues by:
1. Freeing the 'pd' structure with kfree() when ida_alloc() fails
2. Returning the actual error code from ida_alloc() instead of -ENOMEM

This ensures proper cleanup on the error path and accurate error reporting.

Fixes: cbe5aeedecc7 ("PM: EM: Assign a unique ID when creating a performance domain")
Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
---
 kernel/power/energy_model.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 11af9f64aa82..5b055cbe5341 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -449,8 +449,10 @@ static int em_create_pd(struct device *dev, int nr_states,
 	INIT_LIST_HEAD(&pd->node);
 
 	id = ida_alloc(&em_pd_ida, GFP_KERNEL);
-	if (id < 0)
-		return -ENOMEM;
+	if (id < 0) {
+		kfree(pd);
+		return id;
+	}
 	pd->id = id;
 
 	em_table = em_table_alloc(pd);
-- 
2.52.0


