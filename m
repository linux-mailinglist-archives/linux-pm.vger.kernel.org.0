Return-Path: <linux-pm+bounces-21227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB98A24F1A
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C8E07A22D1
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC621F9F73;
	Sun,  2 Feb 2025 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5rAOCbH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A6F1FB3
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516381; cv=none; b=mL4ivmLq4jBCQHjoXb2DbFX3JfN13MYp3qtYo5ptcTNJ8pOdiP0TDwDD7vte+WWO0HC4i1bCSc7gasQYmBZo7bGQbLHDtmrZC/IdpXDo95rzCQ66W0EDUK9GTt4KMxpiQvrUS6MGZTGGRB+QDNp7nlf9eHgvvOa7zQb5j4YYkBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516381; c=relaxed/simple;
	bh=TEUaU05jxt59+KeEFDC6WN9ihOzyeYXXFs4+57aIEhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuiPP6Df99ZBRru2cWheMHrHg4mP81cUX7ijnMZuFOPTjhia+MxX7QrLd0DpNa/Vl7eGn2RXYT6ho1kvDM7QcuQbFAW64s6mBHrmgfj/Va0mLMYfXItuWGVZ1OSlWHFWBfw9w5f4/SJ8IVbgwdmgQKTUGV4mucUjZS6XG8/Csuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5rAOCbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A000BC4CEE1;
	Sun,  2 Feb 2025 17:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516380;
	bh=TEUaU05jxt59+KeEFDC6WN9ihOzyeYXXFs4+57aIEhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=b5rAOCbHL9YlFQU4W/YmGdaMLuf4fbHbuQUrjP4Jes5NZWyHaipB5xilckqTPfFuq
	 asFMKyHhH3rbGQGuQus4c+QqVyhvvyqXnkNc7BMuDeIHJZIEpBDgsGXxxyfJU7i697
	 8gb3ZvFtv9Iw865Ax+c/9TYuDp326ulnBS5IjyavkQp9jXlZ1en9GOf6g4Pvun/JJ9
	 SS1qTjhWt7zbcKNG4qO3N8dH6wqKZMPWByuQeULmsJweovqlbaWrKxC0aSJj5f0pdv
	 bxO0blKDa4fvsV0QBxakNmcvCcFqfzfM7Kh7L8qcz2tjYfuGN57LcCT8LsKOW3SxQl
	 M5R1whWjTOvhw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 04/25] tools/power turbostat: Exit on unsupported Intel models
Date: Sun,  2 Feb 2025 11:09:20 -0600
Message-ID: <4133be39e216130a86382fb5cfbaf6851a6f7a45.1738515889.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
References: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
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

Turbostat requires per-platform enabling for Intel CPU models due to
platform-specific features. When running on unsupported Intel CPU
models, turbostat currently operates with limited default features,
which can lead to users unknowingly using an outdated version of the
tool.

Enhance turbostat to exit by default when run on unsupported Intel CPU
models, with a clear message to users, informing them that their CPU
model is not supported and advising them to update to the latest version
of turbostat for full functionality.

[lenb: updated error message wording]

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index e203f109dd2e..5e894b71003c 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1079,6 +1079,10 @@ void probe_platform_features(unsigned int family, unsigned int model)
 			return;
 		}
 	}
+
+	fprintf(stderr, "Unsupported platform detected.\n"
+		"\tSee RUN THE LATEST VERSION on turbostat(8)\n");
+	exit(1);
 }
 
 /* Model specific support End */
-- 
2.43.0


