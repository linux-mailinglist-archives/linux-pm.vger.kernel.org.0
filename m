Return-Path: <linux-pm+bounces-38185-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F51AC6A77C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 17:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88AB34F21E6
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 15:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B32368283;
	Tue, 18 Nov 2025 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJFrI7LF"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9492368288
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481522; cv=none; b=h/3uRh8b8L6KECE20gs5nRrJ/5X0KV0LNNdSX3eNOSkmz3w0i6gcLkiFfLoKSHMHyHMdeAOs0eDWJqh2egvsGme2CXM8csRw6QRp0ckExbhuUrzKi7sqqKtrs/nBVuckhwXFMjr1mGhJb1wMyD7QnKSSfOPCzuymHze/AyrQk9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481522; c=relaxed/simple;
	bh=k2FbFcd0nL4y984F/1vM+kZdevZalF76kgkmobPrCBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcSPWpm6xvw1LA2gAdrax5cBQKXfbwPRsVf5Eoe5NrGnDTTbtuSSZB/RR/fn36r/stb6MWX75aCgr6tITs24H14N6ZcpzhAUfiib+TlhOwa1EtHuYD6ASwgKFB239IkDhQhZjdK6EUty/Td+CH0CrrnEy201kjqxrbeODeQZLTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EJFrI7LF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763481519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g7baWOeqXS427/Tvfn93lfXLCFO4X6y/YXuAu6Og1xw=;
	b=EJFrI7LFkglTPJfyEhJ83KeFvYdKzUdXBLvkDGH0zOuEMlgbaVsRM9d9k6bTTXDqNrYQHl
	eCE07pZg9CRyvLbS+r6lTvlDFM2IVizI1bsLHEJDTqa3efqcdZ3WYhLoYwohlSOGazcpXf
	3HiZ+kjll9N7Bc/DoA1vMd0cBuGQuIM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-jWROcCY4Oe6khJJXesY2IA-1; Tue,
 18 Nov 2025 10:58:36 -0500
X-MC-Unique: jWROcCY4Oe6khJJXesY2IA-1
X-Mimecast-MFC-AGG-ID: jWROcCY4Oe6khJJXesY2IA_1763481515
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CA94180034D;
	Tue, 18 Nov 2025 15:58:35 +0000 (UTC)
Received: from darcari-thinkpadt14sgen1.bos.com (unknown [10.22.64.106])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A02E19560B0;
	Tue, 18 Nov 2025 15:58:34 +0000 (UTC)
From: David Arcari <darcari@redhat.com>
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Arcari <darcari@redhat.com>
Subject: [PATCH 2/3] tools/power turbostat: avoid an infinite loop of restarts
Date: Tue, 18 Nov 2025 10:58:12 -0500
Message-ID: <20251118155813.533424-3-darcari@redhat.com>
In-Reply-To: <20251118155813.533424-1-darcari@redhat.com>
References: <20251118155813.533424-1-darcari@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

There are some error cases where turbostat will attempt to reinitialize
by calling the re_initialize() function.  The code attempts to avoid
an infinite loop by checking the value of 'restarted' in one case, but
not others. It should be checked in all cases of restart.  Additonally,
the 'restarted' is reset to zero at the start of the loop which also
needs to be removed.

Signed-off-by: David Arcari <darcari@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 tools/power/x86/turbostat/turbostat.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 584b0f7f9067..5567b9ecd516 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -6722,7 +6722,11 @@ void turbostat_loop()
 	set_my_sched_priority(-20);
 
 restart:
-	restarted++;
+	if (restarted++ > 10) {
+		if (!retval)
+			retval = -1;
+		exit(retval);
+	}
 
 	snapshot_proc_sysfs_files();
 	retval = for_all_cpus(get_counters, EVEN_COUNTERS);
@@ -6730,13 +6734,9 @@ void turbostat_loop()
 	if (retval < -1) {
 		exit(retval);
 	} else if (retval == -1) {
-		if (restarted > 10) {
-			exit(retval);
-		}
 		re_initialize();
 		goto restart;
 	}
-	restarted = 0;
 	done_iters = 0;
 	gettimeofday(&tv_even, (struct timezone *)NULL);
 
-- 
2.51.0


