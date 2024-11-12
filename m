Return-Path: <linux-pm+bounces-17392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9F59C5498
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 11:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0311F228DA
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 10:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E3021D22B;
	Tue, 12 Nov 2024 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UT2IQqvj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D346821D227;
	Tue, 12 Nov 2024 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407816; cv=none; b=bb0Yo2mjWGeQKulHqGAAYaF3NQNwvuLNwPusOl0MHsHl/i3xSbZVvr5fG6V2H5PrRKN6xlqQL+w+gkxM1SXzkGN0dp8nu+F359Nfdvii6XctMNS/OwEftgr00KWYaQ6R6MD+/PnV0iUek7aWZZuTuxVPZbVG9e4U/mSz0fkh3as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407816; c=relaxed/simple;
	bh=SIngfbNgyp3CgnmbT5g6mWOXmPipQqACCi3+jQ2nBvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4zs4eRLJilO+uDD4/0HfTelR9HPkBVnVWupP7/RVrdbMvO+zDVmZDlEKK8vXDUjbx+i1GTqhen4RgwPyzAgyX2Rfp2mvO5eppsarnauVlvaVCVbz0upgFg46eUGql+TrkK9H5l8+8tAcpufZOr+RBm/YX5+KJQTw0Iet720tzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UT2IQqvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D06C4CECD;
	Tue, 12 Nov 2024 10:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407816;
	bh=SIngfbNgyp3CgnmbT5g6mWOXmPipQqACCi3+jQ2nBvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UT2IQqvjm5tW67olTnm6YU0ybuQSbMROLZERcD1slnq3gDUz9W/yeM5CBSheAlY3B
	 5qo0wYogtp5oYjwaDF1sce55Vu8yp1RBBt+TJw6VOZ3UYG9AVRO3xVJ6mFcn2VgJC6
	 h3lnyyqrvSLcX14U2lxr4+ChOz2KWvf55vYfL4zYsfOkrZeccfsqhq7dbRZvb3JGIp
	 33jFtAZW34/3sb7Owzw3rOzmLU13fqnoaHnVFcM9jGpEgKtdIeb++qyse17JZ3usp4
	 5fftDlcH1wOTN0egDHfjnJdZD5eWqJTtOojhTX6g+gXohdxiuAU59cxg5vBIt/8PF6
	 iI47lzcCS01eA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/15] tools/lib/thermal: Remove the thermal.h soft link when doing make clean
Date: Tue, 12 Nov 2024 05:36:28 -0500
Message-ID: <20241112103643.1653381-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103643.1653381-1-sashal@kernel.org>
References: <20241112103643.1653381-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.60
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

[ Upstream commit c5426dcc5a3a064bbd2de383e29035a14fe933e0 ]

Run "make -C tools thermal" can create a soft link for thermal.h in
tools/include/uapi/linux.  Just rm it when make clean.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
Link: https://lore.kernel.org/r/20240912045031.18426-1-zhangjiao2@cmss.chinamobile.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/thermal/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/thermal/Makefile b/tools/lib/thermal/Makefile
index 2d0d255fd0e1c..8890fd57b110c 100644
--- a/tools/lib/thermal/Makefile
+++ b/tools/lib/thermal/Makefile
@@ -121,7 +121,9 @@ all: fixdep
 
 clean:
 	$(call QUIET_CLEAN, libthermal) $(RM) $(LIBTHERMAL_A) \
-                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBTHERMAL_VERSION) .*.d .*.cmd LIBTHERMAL-CFLAGS $(LIBTHERMAL_PC)
+                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBTHERMAL_VERSION) \
+                .*.d .*.cmd LIBTHERMAL-CFLAGS $(LIBTHERMAL_PC) \
+                $(srctree)/tools/$(THERMAL_UAPI)
 
 $(LIBTHERMAL_PC):
 	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
-- 
2.43.0


