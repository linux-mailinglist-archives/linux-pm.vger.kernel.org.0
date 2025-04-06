Return-Path: <linux-pm+bounces-24859-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 895CAA7CFD9
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 20:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 162971888F5F
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 18:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEDD1A3142;
	Sun,  6 Apr 2025 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkUGmTC3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571461A2C0B
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743965912; cv=none; b=cbHerPNf1Asa/6dWhLhDLymvn3VH7+17h8iL4ebKm7TjMw+JT4dyTeAW3pr/XmFMC/3eAVtvP28xBx0f4PnmTqvkboL6O8Fg3uL9xAQVEeNuON9eOM4EKzOVrK04ztdT9PcSFANUfwQEbdrlwwg5f3q2EwNwQU9bigOOl8abfuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743965912; c=relaxed/simple;
	bh=17AI1he28sTOXWCZfEVtnNpkF0FtQMKiPHMrcyzxPzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2sQgVuS5YXUTfjLdrQ2FPwGTuUkgcNEPak3dJEvKaimpTPsXQsNIbZqqhpgHwMqBKyUrvW0/F78rcVCocbcfrJzLfLQy+s1edRPLAMQNSHHsI0dHtBaRMeWE2cJKKVMCkvxbG/YYRETCtZKNDniC8qSzDM/n9e2N/tq4Zlc3EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkUGmTC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B8BC4CEEA;
	Sun,  6 Apr 2025 18:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743965911;
	bh=17AI1he28sTOXWCZfEVtnNpkF0FtQMKiPHMrcyzxPzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=FkUGmTC3CkChIyL7nfasFWruyD6m37kqpO+G2Vpoa8SyQRC7nr6a18aeEbgXK1jTj
	 ruI2ijVEdXLqhd3I3u7f5h+yrh1bOe1FNslIN0pq8k4AAfTxUbT7lV9dx0jFHNzUvn
	 gVJSVM6XK0MPfW9/UrV93CG5fP4fGRi2H4x21upXyIHeE9+6PJWYHgWNznxMwKFxCX
	 f6LU3F3MwXm5GYNUkSFieu89lrXbV0+eNMR+tPnfFe78+ntitCLPLhCBNF56Qmi6NG
	 WP0qALFMsOgHaZFzPCf7nj7+YHlns5q9R4LfCa/e/jrugvxqKYahtAG2FWnXzrSnZ1
	 zQ8ASHmCBD5BQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 08/10] tools/power turbostat: Restore GFX sysfs fflush() call
Date: Sun,  6 Apr 2025 14:57:17 -0400
Message-ID: <f8b136ef2605c1bf62020462d10e35228760aa19.1743965272.git.len.brown@intel.com>
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

From: Zhang Rui <rui.zhang@intel.com>

Do fflush() to discard the buffered data, before each read of the
graphics sysfs knobs.

Fixes: ba99a4fc8c24 ("tools/power turbostat: Remove unnecessary fflush() call")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 70e17d4ad9b6..c9a34c16c7a8 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -6039,6 +6039,7 @@ int snapshot_graphics(int idx)
 	int retval;
 
 	rewind(gfx_info[idx].fp);
+	fflush(gfx_info[idx].fp);
 
 	switch (idx) {
 	case GFX_rc6:
-- 
2.45.2


