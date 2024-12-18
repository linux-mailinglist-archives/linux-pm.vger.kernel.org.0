Return-Path: <linux-pm+bounces-19447-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 658EF9F6DD9
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 20:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68E8169D04
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2B91FBEAC;
	Wed, 18 Dec 2024 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbPTFGvW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D2A1FAC40
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734549125; cv=none; b=gQs2v+Fvgj05j3o6irprZPlWlK031QHp0JBKkUESf8px/xOiu4+8q8NOqeQTE8XDlKKYbFGB3Nfu1DBgzatPZc1ufmhspThsWYy9BqUR9BGn1vvjPvIJVmTgF/vljDgJ/L+JZlkXF+O8iOxc5wxZHwttfrJkbm0NHuuYWbuZiJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734549125; c=relaxed/simple;
	bh=nMOaexMm3AD0X9zJdec41KmxIJRAJkYJSkmyOr+Dd+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bg2PO1MLSaI5wWHV3RXPsanqSOh1/Aftunv3+Cse+hlVOB9bDb7c+ZRGdm1cWEqMVpX/kTp7dQWVu9oT/Uh5t71cFf8fEb5e46uS90AufAxHQeLpkUtyguaB/Su8bBSteYTL49s0qf2NRKGLQqqkABSbJO4E2Ud5UHi67hkCJos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbPTFGvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B007DC4CEDC;
	Wed, 18 Dec 2024 19:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734549125;
	bh=nMOaexMm3AD0X9zJdec41KmxIJRAJkYJSkmyOr+Dd+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bbPTFGvWFDCCMlDm3Pee3ukM5MmsrlC9/1OCOajcJLAbp0Ew66iBR1C98eN6B6XUI
	 Cf+SWwn0rjsZXTGwuBCAcB4GdjjP1SSW9y81S+RWxhS+VU4f+hQ+wRsbSAKwyYDu2q
	 lxXVLKUlY5egTLlxJE6S+fdncIz2fvcDEmtuPPmQeQ7ZXuyi2oPM13HYDu1zntMMb+
	 NoLFb4pBzZ02SGw0oldlmphHdMW/4fZP6KdcsS0L9ctvOXxyYD3lfI60nSh8NklYtT
	 JpTO5EoAEdfiwkI4MYwTHbCu4VQ0OmQ26sMeD1JP9FGfav7Eh9tsqDvhrtJhyh8DTJ
	 q3bKwEAAKDJfA==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 1/7] cpupower: Remove spurious return statement
Date: Wed, 18 Dec 2024 13:09:50 -0600
Message-ID: <20241218191144.3440854-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218191144.3440854-1-superm1@kernel.org>
References: <20241218191144.3440854-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

print_duration() has a return; statement at the end of the function
that is not necessary as it's a void function.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 tools/power/cpupower/utils/cpufreq-info.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index c96b77365c637..5f092f3c729e7 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -120,7 +120,6 @@ static void print_duration(unsigned long duration)
 		} else
 			printf("%lu ns", duration);
 	}
-	return;
 }
 
 static int get_boost_mode_x86(unsigned int cpu)
-- 
2.43.0


