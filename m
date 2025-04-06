Return-Path: <linux-pm+bounces-24854-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C610A7CFDB
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 20:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E42B3ACA36
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 18:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02E21A315F;
	Sun,  6 Apr 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNrVMoXY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB2D1A3035
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743965907; cv=none; b=lXWpKXCxegR5SovSHmHThh6YgHqKTWoRG8k9Elfy0bR2KUYOQv76jS0O1jP9g7i5Yy4WPDVkboryGZF2sQPlBmYcuxO1Tv+AlOrlenAVS2pQ3wRpFgB0E2gZwlxJzShjPk9D4uZGeRwt9KmaX8Mn9+3/nK5Aker+2VvASmmkGoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743965907; c=relaxed/simple;
	bh=wBO/5+umzeemOp0ZULiDGgLQSXqdzNYBKrRf86ilEK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBYfb7+a7M2l2JAFnlas4Jq/Qx3lhka7WJEOf8wklQU9CDIBesjIQo9VnBMJFIG4WwgzfGskmkeCviwic+oQI96aBTo9zZ1E8FWCzvbvwnqY47cKOULOCMldzu/JN/ZBIkjL0a6J9EQsuan/GKsvoiC/jS+bmfkGCGczXgU/of4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNrVMoXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE715C4CEE7;
	Sun,  6 Apr 2025 18:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743965907;
	bh=wBO/5+umzeemOp0ZULiDGgLQSXqdzNYBKrRf86ilEK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=YNrVMoXYlRWzqnktyKopiMBZ+fkoHYmLAbAzedNn91GoiUJFiVUQqa3uPXwVkOLeN
	 2EVg4heru8rSo21HPYaosD9IW2L2OZR3hcUpU0zIorpCVhiA3Oii2w7kKAqZjPb36m
	 ModOAqqvtXJK1BcNY4nAc2pSXRlN5THL2/uVRuniFjN5lt5jU6bq2Fh85d064B3TeY
	 uopYA2mtOLj/P4EicRRlzHKlnKmZV/cg63F2yfzAltTvK6X1z3bOHECKAtWM3XcJmm
	 BiEX0EipJfzfjDh2kBvikb+LI6q3kBu3vgUCxa35q1kyH8CvgG0ajL2qLE2YUqW/9+
	 JI32ncf9eq/Fw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 03/10] tools/power turbostat: Fix names matching
Date: Sun,  6 Apr 2025 14:57:12 -0400
Message-ID: <5132681dcd96b2a8c357b6e5d93e9876924bb80b.1743965272.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <1c7c7388e6c31f46b26a884d80b45efbad8237b2.1743965272.git.len.brown@intel.com>
References: <1c7c7388e6c31f46b26a884d80b45efbad8237b2.1743965272.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Fix the 'find_msrp_by_name()' function which returns incorrect matches for
cases like this:

s1 = "C1-";
find_msrp_by_name(head, s1);

Inside 'find_msrp_by_name()':
...
s2 = "C1"
if !(strcnmp(s1, s2, len(s2)))
	// Incorrect match!
	return mp;

Full strings should be match istead. Switch to 'strcmp()' to fix the problem.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index d26008f37a2c..d3af2bf307e1 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -9612,7 +9612,7 @@ struct msr_counter *find_msrp_by_name(struct msr_counter *head, char *name)
 	for (mp = head; mp; mp = mp->next) {
 		if (debug)
 			fprintf(stderr, "%s: %s %s\n", __func__, name, mp->name);
-		if (!strncmp(name, mp->name, strlen(mp->name)))
+		if (!strcmp(name, mp->name))
 			return mp;
 	}
 	return NULL;
-- 
2.45.2


