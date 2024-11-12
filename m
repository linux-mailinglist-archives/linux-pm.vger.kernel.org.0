Return-Path: <linux-pm+bounces-17393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D3A9C54C4
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 11:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8C91F214E8
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2024 10:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0815F2229F2;
	Tue, 12 Nov 2024 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4GvkONx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FFB2229EB;
	Tue, 12 Nov 2024 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407847; cv=none; b=Tj9/a5qxnOOQJdDG0Z1Ns5/KYkSJtf2IBBRF9zuzyZsXi0SdJv6sw0Mq0Ld+hIlen8/DgwMudy1txwtwXrSME2VOuJrdUdYI0mSWX1tl4Tlc/rv0JeXl8fxumuVY+xo1s55719bjGnWR4U50wWeTBou6rycJ9NsaJ1HDezIc5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407847; c=relaxed/simple;
	bh=SIngfbNgyp3CgnmbT5g6mWOXmPipQqACCi3+jQ2nBvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjz7PKzyqDI4RnpPGlrLhBXlkAcKW0Z8zCRpLRHcTKSZZNhreQ1P+JjGf/n1iAJwx3BZXHBFoQO4a8kPCdzteR6ARkz337Gn9Ak1hv3UcpAEluIdIdLTodQWf/sVMgQvNo+GGLus/WGfFZ2QY7nkwPo8AC063vXBgPCgrYn8eDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4GvkONx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0293C4CECD;
	Tue, 12 Nov 2024 10:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407847;
	bh=SIngfbNgyp3CgnmbT5g6mWOXmPipQqACCi3+jQ2nBvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4GvkONxJexo+CJHLUyZi1GexesrJ48pSgdaS7G/qSiU+hgUFEA8ZS+5ZotYjzrBn
	 8+462oPnWZXUiBrBiIe499KRhEv1O+H7ephaeHqvdFwfYA6TTpFuNJ/kXqkutkUcGO
	 dW7PQvlkjYpqa/OfZsfrIWxfgwkZm0WUERyXQCQ6ZdgDaCRmkjXWkYPZPENf+OTE5Y
	 y6XNddiWzU+1vPazrfWWC0oojiNB71WDySNzP8YK6Kz5pMRebFZIudtwXHcrhzTd52
	 UPrBHL/UFD+Kzpr7Rg4cQXlrEE5nRlQsF7IfDgkJgB24jgoj3DjRpt36eUGfjsdJ3g
	 5laJKrKeoMyJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/12] tools/lib/thermal: Remove the thermal.h soft link when doing make clean
Date: Tue, 12 Nov 2024 05:37:07 -0500
Message-ID: <20241112103718.1653723-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103718.1653723-1-sashal@kernel.org>
References: <20241112103718.1653723-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.116
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


