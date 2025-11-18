Return-Path: <linux-pm+bounces-38186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40395C6A740
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 16:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 2C0CF2BED9
	for <lists+linux-pm@lfdr.de>; Tue, 18 Nov 2025 15:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99FC368288;
	Tue, 18 Nov 2025 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JzfCOeR7"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A9E366561
	for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481523; cv=none; b=RQ3ExIfseit+cVVP3elXZk4XlTeOP+C8h3ZzGTVJ6O1nsYAl/Wl9nvLeiey0Ov6ck1S14C4C0/cPZO7w67PLwyMbPc9RRyPYiG4A4qTEopVc2kqmLkb1mhZqXlf8zps+9Z9mWdfNoCGvtyuetps8TzFaorOHOYZkw9wenCIaux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481523; c=relaxed/simple;
	bh=wIUoNUCEuvQTrUQzeUDqqXYnIdaQhe00Yf7UiH84tro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTKhb0iMKI/jGcWoJXwgB2IMPRT0HI2eeKO9y8jd5nswGKsvJ3ITaCzncRPQvCmtJ+oCjwpHJ4mHcfA1scP+e14D1mqWEYbqG4mhZmg2v4jbBUCtbrGB95qyC+J0IZCzAlp5OflIQxu+CTS5uIj5BWkI/WoYd6s/2qLapPg8xE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JzfCOeR7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763481520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GjDlL6LfBuoQ9QHJ2vIOgbDqD00HSi6hGNS6MkE8ovE=;
	b=JzfCOeR7xNfm1ZYD0Yn8SDhP16fnAnc08HFdIbie5/7Htabwx27x6RezCah0Jy+YTXRpXX
	W8NveG4BtDRUzS+U9nEWMB+/Rrczn820KhDJ0gFwolLyzgSC898Rf9KT5pglaWHqQ6QoSJ
	1pB9yP/tcgiuYKrMrMh0BB0/c5wXNNE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-oi6_SwwPMdeaklMth0AJnQ-1; Tue,
 18 Nov 2025 10:58:34 -0500
X-MC-Unique: oi6_SwwPMdeaklMth0AJnQ-1
X-Mimecast-MFC-AGG-ID: oi6_SwwPMdeaklMth0AJnQ_1763481512
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F6EA18002F4;
	Tue, 18 Nov 2025 15:58:32 +0000 (UTC)
Received: from darcari-thinkpadt14sgen1.bos.com (unknown [10.22.64.106])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 17C5C19560B0;
	Tue, 18 Nov 2025 15:58:30 +0000 (UTC)
From: David Arcari <darcari@redhat.com>
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Arcari <darcari@redhat.com>
Subject: [PATCH 1/3] tools/power turbostat: avoid segfault referencing fd_instr_count_percpu
Date: Tue, 18 Nov 2025 10:58:11 -0500
Message-ID: <20251118155813.533424-2-darcari@redhat.com>
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

The problem is that fd_instr_count_percpu is allocated based on
the value of has_aperf. If has_aperf=0 then fd_instr_count_percpu
remains NULL. However, get_instr_count_fd() is called from
turbostat_init() based on the value of has_aperf_access.

On some VM systems has_aperf can be 0, while has_aperf_access can be
1.  In order to resolve the issue simply check for to see if
fd_instr_count_percpu is NULL and return -1 if it is.  Accordingly,
the has_aperf_access check can be removed from turbostat_init.

Signed-off-by: David Arcari <darcari@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 tools/power/x86/turbostat/turbostat.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f2512d78bcbd..584b0f7f9067 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2463,6 +2463,9 @@ static long open_perf_counter(int cpu, unsigned int type, unsigned int config, i
 
 int get_instr_count_fd(int cpu)
 {
+	if (!fd_instr_count_percpu)
+		return -1;
+
 	if (fd_instr_count_percpu[cpu])
 		return fd_instr_count_percpu[cpu];
 
@@ -10027,7 +10030,7 @@ void turbostat_init()
 	for_all_cpus(get_cpu_type, ODD_COUNTERS);
 	for_all_cpus(get_cpu_type, EVEN_COUNTERS);
 
-	if (BIC_IS_ENABLED(BIC_IPC) && has_aperf_access && get_instr_count_fd(base_cpu) != -1)
+	if (BIC_IS_ENABLED(BIC_IPC) && get_instr_count_fd(base_cpu) != -1)
 		BIC_PRESENT(BIC_IPC);
 
 	/*
-- 
2.51.0


