Return-Path: <linux-pm+bounces-40916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB0DD23F7B
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 11:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B584301B12C
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 10:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EA736AB6D;
	Thu, 15 Jan 2026 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQZ8s3Xu"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2832036BCF4
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768473439; cv=none; b=j8KmeJR7IUBQTVnre5LL1erDuh2gW8NpJQ/1k7pHqEW4X4MAI3PgKwg4GabzAK7jjq7G3b9eqFPSSnTUb4yguPKhQVfHiC07Kwvp7stqfyVxtqctMuf4U3vu1xdIUWWEJiwINrr5uUQ7N4SKYze7+7moIsVWGDgws1hTFvSAlAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768473439; c=relaxed/simple;
	bh=mroer21tyn+VD73El7nXuBQ45D8aT09v1u5rNLXbTnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c6Hy9I+XNze/zPBMKwL4Ui4iSgQUPzaWM7RJu8zNMWj8eK0TQnDE8CCPrxoWEebP7boxBCIKsTI57gY2gBaBpRqQ/WLCAJfUWijYDELLGF5tomBro31rDnQ5BYJ73Vmhs31dURQqtLHBrtRCBI2QxVaxLWymC9q87WaEzjgHIoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQZ8s3Xu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768473437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nxAyT8OzTNULMr7XLos5FaceRIYaialub9HWZHZwsXw=;
	b=aQZ8s3Xusr96HiWTmP+WuMLnYMeWLEg9U5k+7DlcE4YuyJvjwWQRJTIDCEXcvL8n5hv/kx
	EAYVUeCwMjFth3bNPkCLUgSPWkc5JNIGXQgpYphcU1KezEZyKCQ3AjAEzoq9wzis1fTM3t
	aWNoVIOtGkwkSI3O45IBh6X8NG4ctx0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-Rm2HCpxvM2ywjPe_ZzUfAA-1; Thu,
 15 Jan 2026 05:37:12 -0500
X-MC-Unique: Rm2HCpxvM2ywjPe_ZzUfAA-1
X-Mimecast-MFC-AGG-ID: Rm2HCpxvM2ywjPe_ZzUfAA_1768473431
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06F4218005B4;
	Thu, 15 Jan 2026 10:37:11 +0000 (UTC)
Received: from mrout-thinkpadp16vgen1.punetw6.csb (unknown [10.74.64.47])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 50AF71955F22;
	Thu, 15 Jan 2026 10:37:06 +0000 (UTC)
From: Malaya Kumar Rout <mrout@redhat.com>
To: lukasz.luba@arm.com
Cc: mrout@redhat.com,
	malayarout91@gmail.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PM: EM: Fix NULL pointer dereference in em_create_pd()
Date: Thu, 15 Jan 2026 16:07:00 +0530
Message-ID: <20260115103700.177997-1-mrout@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The get_cpu_device() function can return NULL if the CPU device is
not registered. However, the code in em_create_pd() dereferences the
returned pointer without checking for NULL, which can lead to a kernel
panic during energy model initialization.

Add a NULL check before dereferencing cpu_dev. If get_cpu_device()
returns NULL, return -ENODEV and properly clean up allocated resources
through the existing error path.

This issue was found by code inspection. The same function is correctly
handled with NULL checking in em_cpu_get() at line 555-557.

Fixes: 1bc138c62295 ("PM / EM: add support for other devices than CPUs in Energy Model")
Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
---
 kernel/power/energy_model.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 11af9f64aa82..3971743d7e67 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -466,6 +466,10 @@ static int em_create_pd(struct device *dev, int nr_states,
 	if (_is_cpu_device(dev))
 		for_each_cpu(cpu, cpus) {
 			cpu_dev = get_cpu_device(cpu);
+			if (!cpu_dev) {
+				ret = -ENODEV;
+				goto free_pd_table;
+			}
 			cpu_dev->em_pd = pd;
 		}
 
-- 
2.52.0


