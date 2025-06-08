Return-Path: <linux-pm+bounces-28242-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F03DAD13B8
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 20:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E34E3A7FBF
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 18:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEB61DA61B;
	Sun,  8 Jun 2025 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYw5U9eI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95FC1D9A5D
	for <linux-pm@vger.kernel.org>; Sun,  8 Jun 2025 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749406743; cv=none; b=RR5oQyep1OTJQX8e4K1PaYG+Ds5QSGNQotT0khlGgy5UCETQ+u5pjonJf9K0qaDzSdO/5xSetKmuR6LsQZOC7B+zw6nCTNHYFqyyOTRzajoD781Rv+NdUslyMgnbHE2w8TZ4o5uX9M18+dFWUVhU63blcrWH0IBFvRe5LfOIyU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749406743; c=relaxed/simple;
	bh=UG9+2LpGLG2Ywjpn/vl3/n89afhl/r8oY39E6RZm1Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNbuYNqURtdujiv2nD/kWJMlULtfXUofPWZHog5tMF+DGKc0FhUPJOGLO/dfJ1Ss/o0PptyjByttHT1G5SIfeqr4yVF3oalfP2/RciFzjlLJM780SXPGn0EMX4Ta1vR9+sk7zqsswBdjkWmoye3NC/P0WevAIn+fF8wbj3UKEx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYw5U9eI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6C7C4CEEE;
	Sun,  8 Jun 2025 18:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749406743;
	bh=UG9+2LpGLG2Ywjpn/vl3/n89afhl/r8oY39E6RZm1Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=nYw5U9eIM/q4RNWvDKjIqyrO4JZ626lZe3P2RrVaMJ9L5ZK6YHlhb/7gRt4jvNKa8
	 Yk1u0Ne95bZKVwAlvSLUdU4DRadH1yIItIGVwFPdEnlnC3ZJvhTy8aOb8vkEIxDVDn
	 4yqS48dm+hd84WCjTRmjWVu7nJXkX+mYopjBwB0yjijl6A1pNvEaDz88i8Ak6PmkKw
	 1w2Sd97n8qN6J0U9xeXiplLE0ow08RHboV5Xfkul9uN7j9PybNfG6937XMu/R+FcMw
	 anybIK+3d0DhzZaTKt5aL5+WgzFmPDcrBIlFve5adGQWI1u9H/WiYQfZauSKd9eZIk
	 0dBTmR4xAJ9IA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 17/18] tools/power turbostat: Add initial support for BartlettLake
Date: Sun,  8 Jun 2025 14:17:16 -0400
Message-ID: <58a669953404405e72551357c0e9431d0b1df0af.1749406068.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
References: <780da8a9557f2d114aaffda0eb0a517fe6a244c8.1749406068.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

Add initial support for BartlettLake.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index dca0753a76fb..db0134adc8ce 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1052,6 +1052,7 @@ static const struct platform_data turbostat_pdata[] = {
 	{ INTEL_RAPTORLAKE, &adl_features },
 	{ INTEL_RAPTORLAKE_P, &adl_features },
 	{ INTEL_RAPTORLAKE_S, &adl_features },
+	{ INTEL_BARTLETTLAKE, &adl_features },
 	{ INTEL_METEORLAKE, &adl_features },
 	{ INTEL_METEORLAKE_L, &adl_features },
 	{ INTEL_ARROWLAKE_H, &adl_features },
-- 
2.45.2


