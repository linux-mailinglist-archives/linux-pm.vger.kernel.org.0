Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D8620D71D
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 22:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgF2T1J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 15:27:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27190 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732299AbgF2T1G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 15:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593458825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ULeTr0SB55lWnRLDf1wo07nelEQfKeugCaPGmgEHj60=;
        b=iF0bpywfWzf8RTRacdQLshD4hN/fw13VX8Vqbn8g0UaeFjaBLOSSbYi1MQQ237M7xfGIBs
        S9J07UlNrOdJiWrAT7aics8y/7MDD+gelEWWAagwn8Yv8Nk3GFqAg2gFy4rmnYhAho9wBi
        7Wxi+xbwi7QJwRctru4M6in1T4n3OZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-5TlJu8U2Nl6yNclv8OYdGQ-1; Mon, 29 Jun 2020 15:27:00 -0400
X-MC-Unique: 5TlJu8U2Nl6yNclv8OYdGQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FFDBA0C01;
        Mon, 29 Jun 2020 19:26:59 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC68C19C71;
        Mon, 29 Jun 2020 19:26:58 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] turbostat: Use sched_getcpu() instead of hardcoded cpu 0
Date:   Mon, 29 Jun 2020 15:26:57 -0400
Message-Id: <20200629192657.34045-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Disabling cpu 0 results in an error

turbostat: /sys/devices/system/cpu/cpu0/topology/thread_siblings: open failed: No such file or directory

Use sched_getcpu() instead of a hardcoded cpu 0 to get the max cpu number.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 33b370865d16..2d3a3012f2f8 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2769,12 +2769,19 @@ void re_initialize(void)
 void set_max_cpu_num(void)
 {
 	FILE *filep;
+	int base_cpu;
 	unsigned long dummy;
+	char pathname[64];
 
+	base_cpu = sched_getcpu();
+	if (base_cpu < 0)
+		err(1, "cannot find calling cpu ID");
+	sprintf(pathname,
+		"/sys/devices/system/cpu/cpu%d/topology/thread_siblings",
+		base_cpu);
+
+	filep = fopen_or_die(pathname, "r");
 	topo.max_cpu_num = 0;
-	filep = fopen_or_die(
-			"/sys/devices/system/cpu/cpu0/topology/thread_siblings",
-			"r");
 	while (fscanf(filep, "%lx,", &dummy) == 1)
 		topo.max_cpu_num += BITMASK_SIZE;
 	fclose(filep);
-- 
2.21.3

