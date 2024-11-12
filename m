Return-Path: <linux-pm+bounces-17391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B35859C545A
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 11:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2E91F22260
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 10:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14F3218594;
	Tue, 12 Nov 2024 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPp6s/xt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E3321832B;
	Tue, 12 Nov 2024 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407780; cv=none; b=f1cuCCoeW6YNv5POEtpIPHe9WgkNu76RgdXnpzNll7QT283YgX3QH/FEF9TugD/JIO+QEFkbbMw1dN6kxaQBrVP/hSi3YdFrtYAs5gdF0cnTkBZb9neFtB3nr4VrfqYE7r3GXWcozjBT88EpN0p6rQDexp5+NeHHbn9+PWPiF8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407780; c=relaxed/simple;
	bh=SIngfbNgyp3CgnmbT5g6mWOXmPipQqACCi3+jQ2nBvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEcow+pNsZ1hdqN4J5+LUrNwGhraU/ng4D5xS7pKAycd29o4Ge1R3BNHpV6zZbmOeVbyGgoQLDjde4jOaenps1mHznxj+CYJWXKj3wBdVcdnWJiFiBHsCa/T6xgC9886Wce7xbkcc5wC3RGWQXWJIrBCX/S3ihqQvY2vCEvx17U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPp6s/xt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA2FC4CECD;
	Tue, 12 Nov 2024 10:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407779;
	bh=SIngfbNgyp3CgnmbT5g6mWOXmPipQqACCi3+jQ2nBvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mPp6s/xtx05GK8yomg2qppso/Qrx9ZvUFFiUutZGqXAJ9alQv6Atm1Nnge/uiGGqp
	 eBS4wwmWqmg5v2QeOJXVldGbO72OWxh42Qm0bL1TgDKgmQy4YPKsHsMK63NsA6N/4Y
	 x6q7b3s8ngtegD67I+791KwenKCWTQG2xivTs8b1ctzTa+KybAlEKVQLvlaO8+jTmE
	 v4exoSVWEVqdEnwepvFvV9Z7Su3IrNpro8dYF6vBp3jowy/0Cl0/yvI62gVo5v3/f2
	 OfIcu1gEZIvQyNh7bXLHciag+5VV0nAshDBPa1bgD2ucdGyo1lJeJV2ylL/IVIpSlD
	 PJ6oF/dudWDtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 08/16] tools/lib/thermal: Remove the thermal.h soft link when doing make clean
Date: Tue, 12 Nov 2024 05:35:50 -0500
Message-ID: <20241112103605.1652910-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103605.1652910-1-sashal@kernel.org>
References: <20241112103605.1652910-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.7
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


