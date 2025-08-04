Return-Path: <linux-pm+bounces-31826-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77800B19908
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 02:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D0E177029
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 00:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7914B1FF1A1;
	Mon,  4 Aug 2025 00:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ez9R3hGk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501531DE4E5;
	Mon,  4 Aug 2025 00:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267959; cv=none; b=WTzFnySUTf3ZI1xvM2KCMEV5XAdXsvXSedoxdYyaP2FiZreRgfnYmcxg6p3HL4VoIHwejIUe0SXHJXvmuRj+TSN1YVqidEDPD8bhOc1Qkgw8N70UIuLRFt2ze1DBSwcCv6cj4/n/0F+rtg6yWSAv22uYsN1d1sHtI4UTquEoMjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267959; c=relaxed/simple;
	bh=jkenw2BNpnSiQdmOaCbO3klF9XpS/36FLlV6FeSn8+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jfP8tYYgIG2M9ZjL02Wz84TTgAlROPSe8iUA5tWgKWA7NYf3T3iQzGux/ruEjA9Z6Ihcx6EL25EK4Ii8QA5+uGCZ4b6011uoPsatyyLbFzj95xLiRLmeEs8ySbxFt9+Ljk0BK92G9umfevhTAk3OyJazy0Er9XXazfvTeOzvhEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ez9R3hGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE357C4CEF0;
	Mon,  4 Aug 2025 00:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267959;
	bh=jkenw2BNpnSiQdmOaCbO3klF9XpS/36FLlV6FeSn8+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ez9R3hGkcooYAlcFGA5USDXQo6Cz42WX+H+eeaSZIQnOWPX7ImRT4SuWln/j/DkMY
	 rpVHsT0hTI4UM7GyXTknu48KtQ8Nqz8sHtwnKbg6irlN0CM9m+5OfNCOEDJnzZyQuC
	 62GrdeJHshIM/D+tg4+jkXqw3cvhBy+g9lpSPpefkAlc6Ym4Dvm1N+1cZyCXvwSH8l
	 vkvx+EhXLWb+TW4eLtdVYcZp+/mmZujplMtrG+V49tPJuFYCva/DVLq5hXk8Gl5wdM
	 ARpLXKjzwkywmEBLfYGoqAqLZFBs8MYcIpsWVbkGZxwfBeB1uN9AS8NYJeV5kP8xR1
	 GBonqR1Qc7+0Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sasha Levin <sashal@kernel.org>,
	myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 12/44] PM / devfreq: governor: Replace sscanf() with kstrtoul() in set_freq_store()
Date: Sun,  3 Aug 2025 20:38:17 -0400
Message-Id: <20250804003849.3627024-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003849.3627024-1-sashal@kernel.org>
References: <20250804003849.3627024-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.189
Content-Transfer-Encoding: 8bit

From: Lifeng Zheng <zhenglifeng1@huawei.com>

[ Upstream commit 914cc799b28f17d369d5b4db3b941957d18157e8 ]

Replace sscanf() with kstrtoul() in set_freq_store() and check the result
to avoid invalid input.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Link: https://lore.kernel.org/lkml/20250421030020.3108405-2-zhenglifeng1@huawei.com/
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Backport Status: YES

This commit should be backported to stable kernel trees for the
following reasons:

1. **Security Issue - Input Validation Bug**: The original code uses
   `sscanf(buf, "%lu", &wanted)` at line 45 without checking the return
   value. This is a security vulnerability because:
   - `sscanf()` returns the number of successfully parsed items
   - If the input is malformed or contains invalid characters,
     `sscanf()` may return 0 but leave `wanted` uninitialized
   - The code then proceeds to use this potentially uninitialized value
     in `data->user_frequency = wanted`
   - This could lead to setting arbitrary frequency values from
     uninitialized stack data

2. **Real User Impact**: The devfreq userspace governor allows users to
   manually set device frequencies through sysfs. Invalid input handling
   could cause:
   - Setting incorrect frequencies based on uninitialized memory
   - Potential system instability if invalid frequencies are applied to
     hardware
   - Security implications as uninitialized stack data could be used

3. **Small and Contained Fix**: The change is minimal and low-risk:
   - Replaces `sscanf()` with `kstrtoul()` which has proper error
     checking
   - Adds explicit error handling that returns early on invalid input
   - The change is confined to a single function (`set_freq_store()`)
   - No architectural changes or new features added

4. **Follows Kernel Best Practices**: The kernel has been systematically
   replacing `sscanf()` with `kstrto*()` functions for better input
   validation. This is evident from similar commits found in the git log
   (e.g., commit a5556fa1107d for asus-wmi).

5. **Critical Subsystem**: While devfreq might not be as critical as
   core memory management, it controls device frequency scaling which
   can affect:
   - Power management
   - System performance
   - Hardware stability

6. **No Negative Side Effects**: The change only adds proper validation
   and doesn't modify the core functionality. Valid inputs will continue
   to work exactly as before.

The commit fixes a clear bug (missing input validation) that could lead
to undefined behavior and potential security issues, making it an
excellent candidate for stable backporting according to stable tree
rules.

 drivers/devfreq/governor_userspace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index d69672ccacc4..8d057cea09d5 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/devfreq.h>
+#include <linux/kstrtox.h>
 #include <linux/pm.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
@@ -39,10 +40,13 @@ static ssize_t set_freq_store(struct device *dev, struct device_attribute *attr,
 	unsigned long wanted;
 	int err = 0;
 
+	err = kstrtoul(buf, 0, &wanted);
+	if (err)
+		return err;
+
 	mutex_lock(&devfreq->lock);
 	data = devfreq->governor_data;
 
-	sscanf(buf, "%lu", &wanted);
 	data->user_frequency = wanted;
 	data->valid = true;
 	err = update_devfreq(devfreq);
-- 
2.39.5


