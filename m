Return-Path: <linux-pm+bounces-12164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BA795080B
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 16:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111481F218CB
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 14:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6BB19F475;
	Tue, 13 Aug 2024 14:44:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAAE19EEDF;
	Tue, 13 Aug 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560243; cv=none; b=BLiWAuE3zqPHjOqIneMpWQUSdnWeXKewn13XX7Y+066jatBUNr76v4egFYBLBSSzDB1r+L0Yl+bAxbX3BRAUZG2hBBdxSCW68aVKxFE9uSzuRXORWGmgzLtlocLuncWjIF6hHRbHFzInQxNcf4orFJgOTLSKEsf7kBPDlrnF2F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560243; c=relaxed/simple;
	bh=IZkUOEj+ynT1cgZSlkqf7jexEJo9g6ns6R0oSMRUXb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BwBXpZfPJRU2L4trZr+2QibiLDSiFwGGzfjxQosTZCjH9BjT3gQgJ+hQhSkfz4oSIzdcelJYGHtGMt95neogPcXxaMZ95aLDmO+5ODBQ71FbFlCHxyNlufgx+Rl4tSWgzlTER+3yaCeBSFFrYQBkO23BP7JuDL3X83sxgMFxpYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAE8D1596;
	Tue, 13 Aug 2024 07:44:26 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.84.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6BE453F58B;
	Tue, 13 Aug 2024 07:43:58 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org
Cc: vincent.guittot@linaro.org,
	qyousef@layalina.io,
	peterz@infradead.org,
	daniel.lezcano@linaro.org,
	rostedt@goodmis.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 1/4] sched/deadline: Convert schedtool example to chrt
Date: Tue, 13 Aug 2024 15:43:45 +0100
Message-Id: <20240813144348.1180344-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813144348.1180344-1-christian.loehle@arm.com>
References: <20240813144348.1180344-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

chrt has SCHED_DEADLINE support so convert the example instead of
relying on a schedtool fork. While at it fix the wrong mentioning
of microseconds, it was nanoseconds for both schedtool and chrt.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 Documentation/scheduler/sched-deadline.rst | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/scheduler/sched-deadline.rst b/Documentation/scheduler/sched-deadline.rst
index 9fe4846079bb..22838ed8e13a 100644
--- a/Documentation/scheduler/sched-deadline.rst
+++ b/Documentation/scheduler/sched-deadline.rst
@@ -749,21 +749,19 @@ Appendix A. Test suite
  of the command line options. Please refer to rt-app documentation for more
  details (`<rt-app-sources>/doc/*.json`).
 
- The second testing application is a modification of schedtool, called
- schedtool-dl, which can be used to setup SCHED_DEADLINE parameters for a
- certain pid/application. schedtool-dl is available at:
- https://github.com/scheduler-tools/schedtool-dl.git.
+ The second testing application is done using chrt which has support
+ for SCHED_DEADLINE.
 
  The usage is straightforward::
 
-  # schedtool -E -t 10000000:100000000 -e ./my_cpuhog_app
+  # chrt -d -T 10000000 -D 100000000 0 ./my_cpuhog_app
 
  With this, my_cpuhog_app is put to run inside a SCHED_DEADLINE reservation
- of 10ms every 100ms (note that parameters are expressed in microseconds).
- You can also use schedtool to create a reservation for an already running
+ of 10ms every 100ms (note that parameters are expressed in nanoseconds).
+ You can also use chrt to create a reservation for an already running
  application, given that you know its pid::
 
-  # schedtool -E -t 10000000:100000000 my_app_pid
+  # chrt -d -T 10000000 -D 100000000 -p 0 my_app_pid
 
 Appendix B. Minimal main()
 ==========================
-- 
2.34.1


