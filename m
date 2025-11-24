Return-Path: <linux-pm+bounces-38439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 317AFC7FF82
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0817E342397
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 10:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C0E2FAC1C;
	Mon, 24 Nov 2025 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9Gy9F7O"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747C72FABE7
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763981058; cv=none; b=JYXYRmiTjkFqogkHXPDWVxtcgjdnVfWP5nicj6eJVK9RNY7tszVlTa4tbsei62oLI/PhiP4/XdiTomApzZXDTlDpv7HqoxC17lv/zVHQ2Q5udeay44o38B0br7Xzuz9EHixcJT+KDHYItGH9I/gkdiQw8gcoVwk9czzIybJBNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763981058; c=relaxed/simple;
	bh=Pd98VXZ1q1pppKX1bFYCl+NX0+rlK2GD1sF5+pU8drk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hl5Sb5lPHygjquCT3r9W0fsUWeb/9bHZJ86D+NbP8frGzLTPgBsYYWv3cUc2RehB5FvZugIZx1OtAtxIo0PrH/L4xBte3wVmPDJ94V+45i1Ta8E8VPSr9+mhnhphJ2bkYvaR+IJZr/UH+vOl7rnVEbuzrBRvlK2bkULtC/8wHQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E9Gy9F7O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763981055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IldZn1VTxK1huNPOq3jaziyKHC3bd6rJfT/3qVnd2ug=;
	b=E9Gy9F7OSwIuxd7r/tqm/RjOLpU4lV7dxOZMMTEc8azryzQTcUJnUDhjIjxTklfSsU+ygj
	5nDjeUeUOoZE1zRQQ0X4auL7hK6w8fyQHIc83y4/r9WOwxWCNgqdt4CaaNSiymHsQ8kX3b
	3mgaeUVEDswa1wJmSFObRkJLR1SwjOE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-EhJuVRNsP4eozoNZ4lBXxw-1; Mon,
 24 Nov 2025 05:44:11 -0500
X-MC-Unique: EhJuVRNsP4eozoNZ4lBXxw-1
X-Mimecast-MFC-AGG-ID: EhJuVRNsP4eozoNZ4lBXxw_1763981049
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74E1919560AD;
	Mon, 24 Nov 2025 10:44:09 +0000 (UTC)
Received: from mrout-thinkpadp16vgen1.punetw6.csb (unknown [10.74.65.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A84A51940EAA;
	Mon, 24 Nov 2025 10:44:05 +0000 (UTC)
From: Malaya Kumar Rout <mrout@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: mrout@redhat.com,
	malayarout91@gmail.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org
Subject: [PATCH] tools/thermal/thermal-engine: Fix format string bug in thermal-engine
Date: Mon, 24 Nov 2025 16:13:58 +0530
Message-ID: <20251124104401.374856-1-mrout@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The error message in the daemon() failure path uses %p format specifier
without providing a corresponding pointer argument, resulting in undefined
behavior and printing garbage values.

Replace %p with %m to properly print the errno error message, which is
the intended behavior when daemon() fails.

This fix ensures proper error reporting when daemonization fails.

Signed-off-by: Malaya Kumar Rout <mrout@redhat.com>
---
 tools/thermal/thermal-engine/thermal-engine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/thermal/thermal-engine/thermal-engine.c b/tools/thermal/thermal-engine/thermal-engine.c
index 0764dc754771..66b0ba1fcd23 100644
--- a/tools/thermal/thermal-engine/thermal-engine.c
+++ b/tools/thermal/thermal-engine/thermal-engine.c
@@ -374,7 +374,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (options.daemonize && daemon(0, 0)) {
-		ERROR("Failed to daemonize: %p\n");
+		ERROR("Failed to daemonize: %m\n");
 		return THERMAL_ENGINE_DAEMON_ERROR;
 	}
 
-- 
2.51.0


