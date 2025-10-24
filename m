Return-Path: <linux-pm+bounces-36787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABAAC070DD
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 17:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96F33A97A4
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 15:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EE432E695;
	Fri, 24 Oct 2025 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTPAWsJY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5B332C303
	for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2025 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320806; cv=none; b=QkxpGjf28JQY5wey1m1+YVblyo++skW98j/6PW8qXDl8O4tITr3q8OM/AP7OjkR+3NNbFn21KQLmBhO4P0TqKVeyU9ClXO/Y56g3O/IDyGDvxHXIMdzJSnbwFb5Dq+XrzvcTCAmajGeR/jDt+shiT+2aKt4yzKIB3fyAt+QNI94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320806; c=relaxed/simple;
	bh=ukvl7NB9QRrNqVAjfgVYGls9gG0n714WiCxOcDj3xTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgXkH5fZfK0FeT6qj9knvx1dbZ0e/EZ9SHoF1/9sFcaqYGj8/OXz9Q+bypZybeMotU1Q48E2eFr6fJzQk4BhrZF/tTjzeodJMf1D4w2hcz8eC/aiYvrvY+51fudx9J5xgieHFobD8fXM4ak3pG9TN+1WtG9CncFMU29s+QWecks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTPAWsJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DF1C4CEF1;
	Fri, 24 Oct 2025 15:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761320806;
	bh=ukvl7NB9QRrNqVAjfgVYGls9gG0n714WiCxOcDj3xTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=qTPAWsJYvhJc9MsO72k94wRVlf+gr5NoPF72jgP9GxqghDpS6YREkBWZT3wBt/8SQ
	 KijX0gctqnw5suYO66WPH+u5fVNuUYiMfrVUwSL0AzyOHIOJw7f+W/GyHhBbXuI2GV
	 uQwiekhTB0KyYVMuCvbqyJS1gkmyBSodNNU/hTpulUSsFtD+6co2BNrlxp5WepfKwY
	 V44TTp6D+idop41UoAnjhbBooIgFwjcl/3vwgaoJ8vUBiHJ67cCdK2kui/nt9HnkSu
	 4SzJOeBLNwG+eHF8ZVNp1mpg7YZ4p5Nt6fmqOs2okoJK7VNvgb6e0MDNfbL1OcClGi
	 zlC/G9kILLMzQ==
From: Len Brown <lenb@kernel.org>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 2/8] tools/power turbostat: Add Wildcat Lake and Nova Lake support
Date: Fri, 24 Oct 2025 12:38:12 -0300
Message-ID: <4e35847d7b08e62e73b1636207f8c9074b4a4893.1761320252.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1761320252.git.len.brown@intel.com>
References: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1761320252.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Treat Wildcat Lake and Nova Lake (and Panther Lake)
the same as Lunar Lake, for now.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 1b5ca2f4e92f..7c24c2f9a075 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1210,6 +1210,9 @@ static const struct platform_data turbostat_pdata[] = {
 	{ INTEL_ARROWLAKE, &adl_features },
 	{ INTEL_LUNARLAKE_M, &lnl_features },
 	{ INTEL_PANTHERLAKE_L, &lnl_features },
+	{ INTEL_NOVALAKE, &lnl_features },
+	{ INTEL_NOVALAKE_L, &lnl_features },
+	{ INTEL_WILDCATLAKE_L, &lnl_features },
 	{ INTEL_ATOM_SILVERMONT, &slv_features },
 	{ INTEL_ATOM_SILVERMONT_D, &slvd_features },
 	{ INTEL_ATOM_AIRMONT, &amt_features },
@@ -10126,7 +10129,7 @@ int get_and_dump_counters(void)
 
 void print_version()
 {
-	fprintf(outf, "turbostat version 2025.09.09 - Len Brown <lenb@kernel.org>\n");
+	fprintf(outf, "turbostat version 2025.10.18 - Len Brown <lenb@kernel.org>\n");
 }
 
 #define COMMAND_LINE_SIZE 2048
-- 
2.45.2


