Return-Path: <linux-pm+bounces-21579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 892BDA2D312
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2025 03:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA051188E315
	for <lists+linux-pm@lfdr.de>; Sat,  8 Feb 2025 02:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BD414F102;
	Sat,  8 Feb 2025 02:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="F04Uk0a4"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A19214A0B3;
	Sat,  8 Feb 2025 02:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738981782; cv=none; b=VxGCjQlQjgjqVryuwcAe+Z37XkA8k8dMMiLMiU8j+yBt7rxkCUZPfUkuMuloR3NKOkbxyGMd/5q6GN6iuK5Ru3IFetpp3uElQR60EXni8cgBcuTivA71/LLgoS0dgtaxxXDbiRUa2J+9hDnQ35UdkoSWHdYmsDw9c9IeIsGq4uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738981782; c=relaxed/simple;
	bh=1ayZThS4msoIvPZQgLkxwrGfGnmeet4xVbM6xGLFnSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KuPQfvQsG7Azbi/u2Kx8f+ppC3pAVVXxuQcUXKA88MeVtwoO0S5myA94KqMmhqAwftptNjlL8IMe6OXk1uusu8Nzm+biX4ioXIwKOjKwkmBHzyIIYmUUeuzJiInip3IJl79yQktg3wLu2gd8wxpnhx8L2LVzbTaStaUkwuxR7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=F04Uk0a4; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pzOuT
	ODRPxLBhorZWDPkE5VkjqDkamSBFuV/3CY9Sco=; b=F04Uk0a4O56vfW8qBD/LT
	OPGu6R6/4wD+cJ/eiXOeKUvXcGS3+axRG4uVhrRj3dDkQzZCVsJs3YM/y0Vrft7A
	b4jz1it1I7O7MxFpeUYkiWdT34M/LcBxYxTF/WD+bjjCTkW4OCzv8Kea4DEpiVXn
	3MBc+q1yArW2+buudyQXlc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgD33xL5vaZn22O9Ag--.16835S2;
	Sat, 08 Feb 2025 10:14:18 +0800 (CST)
From: pleasurefish@126.com
To: myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com,
	ansuelsmth@gmail.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pls <pleasurefish@126.com>
Subject: [PATCH] PM / devfreq: Fix a typo in trans_stat
Date: Fri,  7 Feb 2025 16:13:50 -1000
Message-Id: <20250208021350.5931-1-pleasurefish@126.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCkvCgD33xL5vaZn22O9Ag--.16835S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4UXr47uw1xGF47GFWUtwb_yoW3WFc_C3
	sF9Fs7XrW0ywnrWw1fCr4Fv34Iy3Wa9r1F9r4ag3yaqr47Z3yxArW29r98XrnrWrWUZrWD
	XrW8Xa1UAr48ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_dgA7UUUUU==
X-CM-SenderInfo: 5soht2xxuhwxlvk6ij2wof0z/1tbiFhjs4WelxH+QfwACsX

From: pls <pleasurefish@126.com>

Fixes: 4920ee6dcfaf ("PM / devfreq: Convert to use sysfs_emit_at() API")
Signed-off-by: pls <pleasurefish@126.com>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 98657d3b9435..a0223c60f4eb 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1743,7 +1743,7 @@ static ssize_t trans_stat_show(struct device *dev,
 	for (i = 0; i < max_state; i++) {
 		if (len >= PAGE_SIZE - 1)
 			break;
-		if (df->freq_table[2] == df->previous_freq)
+		if (df->freq_table[i] == df->previous_freq)
 			len += sysfs_emit_at(buf, len, "*");
 		else
 			len += sysfs_emit_at(buf, len, " ");
-- 
2.39.5


