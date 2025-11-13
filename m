Return-Path: <linux-pm+bounces-37985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA97C59BB7
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B24C4E8AB6
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 19:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AD1316902;
	Thu, 13 Nov 2025 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="dfY/KGIc"
X-Original-To: linux-pm@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8D230AD1B;
	Thu, 13 Nov 2025 19:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061409; cv=none; b=YRVIOr34LWgTejm8IIfWE5wKCuTTfBY1wII9i8kGVx47p0rZ1qERuZSymZnedwvB6r2+zufGUjx2ZxV0M3tySvbaj/TBsmtttxxENyIjx7N+VMbwIWROOFijhhEa5gFde8s7AQFYcXoSUoowG7bMrOkVCMGeb5AYkLMU8bvF8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061409; c=relaxed/simple;
	bh=gAvp6lB9gtNM3vGtuHTGlG2ukv4hXwbuw6rayhm50nc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VCQxXNBYO9RrcRdOD6+/sN6Qnv+L3yx26U5jIX+bQ+8Hv0UvWhnT49D/rQVwP5Oep65kdn1Cq2EjSfRjwIS6KtFk6/Uy5PHm0ZElmg7PL1vKBLYis5pOt8EYNBsZik0OzJIqOBDC8uAe/3IbhqugKKtXeV7iRPjqbLFAlsJkPxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=dfY/KGIc; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1763061407; x=1794597407;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1lCiM2nDyPG/eVQuAcY78mfwNPrpTSnz0BBhB4fBRA4=;
  b=dfY/KGIcoCnjHo3h4chv83m3+ZuC6VUAr2FrOZER0zYvd00uhyf5M3Ce
   TxU3c5OOi0LPGkFgIdL1qQfACUVY7lZgwHFKP79MYv6WQghKkpThVleKO
   1LAbeZSq3vmnIe8XppcFD3PPdTNuTVjgF//tGOQGS7m4rfNJ9jTjJN2GT
   gOm/iDYgNf6kTr2nCuSiCnz2aR7w83bcHSIiVf2Eml/y7P/LjSKnBzz+y
   hTHD8mTdLNzXR0wynqahA9fqhYQtjZ56Kqd8WivOA1rMVjvx+nkp9BhQ/
   guU5HJZGrEsPqssk1TQSIDYiLYeirIKSY1WdI0YqcO/URL7yWYkcCyUWO
   g==;
X-CSE-ConnectionGUID: +jEAMczTRqaWhbRqar34jw==
X-CSE-MsgGUID: 9DuieOWpQo63YW4Q9sX72Q==
X-IronPort-AV: E=Sophos;i="6.19,302,1754956800"; 
   d="scan'208";a="7056653"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 19:16:44 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:6334]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.78:2525] with esmtp (Farcaster)
 id 3389326d-49c5-4d92-b1da-b1e33c25fd37; Thu, 13 Nov 2025 19:16:44 +0000 (UTC)
X-Farcaster-Flow-ID: 3389326d-49c5-4d92-b1da-b1e33c25fd37
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 13 Nov 2025 19:16:43 +0000
Received: from dev-dsk-ehemily-1c-401a2257.eu-west-1.amazon.com
 (10.253.103.254) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Thu, 13 Nov 2025
 19:16:42 +0000
From: Emily Ehlert <ehemily@amazon.de>
To: <lenb@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Emily Ehlert
	<ehemily@amazon.com>
Subject: [PATCH 1/2] tools/power/turbostat: Set per_cpu_msr_sum to NULL after free
Date: Thu, 13 Nov 2025 19:16:08 +0000
Message-ID: <20251113191609.28574-1-ehemily@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Emily Ehlert <ehemily@amazon.com>

Set per_cpu_msr_sum to NULL after freeing it in the error path
of msr_sum_record() to prevent potential use-after-free issues.

Signed-off-by: Emily Ehlert <ehemily@amazon.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 72a280e7a9d5..9a2be201a3a6 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -6673,6 +6673,7 @@ void msr_sum_record(void)
 	timer_delete(timerid);
 release_msr:
 	free(per_cpu_msr_sum);
+	per_cpu_msr_sum = NULL;
 }
 
 /*
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


