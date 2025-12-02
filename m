Return-Path: <linux-pm+bounces-39108-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01940C9D0C2
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 22:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1FD9234A6B9
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 21:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FA22FB09C;
	Tue,  2 Dec 2025 21:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dL0dIQcy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435872F90E9
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710313; cv=none; b=IibihC21mNnmp/kTfCzqfaglQv6M2/Am252MEHvMHwMHTnFBOuBii6o1bWLq/Z+NDVoD+VhIs8QTrlMTjGEIulCGzeuabdpdO0PZET3HUxBDQeRD3TlIaeJUjOGWgrOY9tmTtUht2yWBPmYb/Rsorsn6LH9QzUF6uVr/ffUqHn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710313; c=relaxed/simple;
	bh=ukvl7NB9QRrNqVAjfgVYGls9gG0n714WiCxOcDj3xTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s41G4y9RoH6xRcwPiII1UNz9PVouH4XZSO9PdEL0ht6OE+f3qaRUdiGz5OItdkVdff3YdBOV/Mth0MiRArgsvFBRBiV1ZHdO3GjzRDHURIRO9svkmEtLWg0v/Et0tB57h6+FrajOS7ksjUT7VlQIEnvrap6R+2fqa3JpTu7kvRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dL0dIQcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D88C16AAE;
	Tue,  2 Dec 2025 21:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710312;
	bh=ukvl7NB9QRrNqVAjfgVYGls9gG0n714WiCxOcDj3xTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=dL0dIQcyU3CTUTCW0BVCmsphZzfCLO+RYC6JAEiYLJYFzk2mHp26SxxPqn/dN4ovS
	 6aa4zlngvUofhZlW8ihaXnVMkt+ucVzzAu/tr+H7HZ9QHlxxkyAeQaQlB0rXqi88eG
	 1tXheSb/SJ2RLObxucH0t9wymxRJ0R3Ykvtqtm0jmfPssGcs67WQL1uJXfA4bNpagC
	 /Al5Xjb/2QLb1xkW+D85bivkPuskL4D7vfP9Aua+kuGoQBIPyGHqOBW4kqzy4LXIyh
	 hoS2BA5nhSo4i8VoFle28TVFOWdo2Y05ca+vzvfTXR9qHYI19TRi63UuWi1g6Q6CA+
	 gjurQZiLG+PYQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 02/21] tools/power turbostat: Add Wildcat Lake and Nova Lake support
Date: Tue,  2 Dec 2025 16:13:20 -0500
Message-ID: <4e35847d7b08e62e73b1636207f8c9074b4a4893.1764710012.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1764710012.git.len.brown@intel.com>
References: <92664f2e6ab2228a3330734fc72dabeaf8a49ee1.1764710012.git.len.brown@intel.com>
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


