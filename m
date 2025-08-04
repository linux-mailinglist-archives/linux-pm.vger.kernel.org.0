Return-Path: <linux-pm+bounces-31812-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9622CB19893
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 02:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01173ADF60
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 00:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692FF1C84B8;
	Mon,  4 Aug 2025 00:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b74H2wVZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401847261D;
	Mon,  4 Aug 2025 00:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267694; cv=none; b=c4hvMdVevskMrp9HtqwQFnhtYyqU4wj4ZS6Vg4zcOY1PsBduD83cszLFQMjTB22pFOxSa992Cs5+rxRqzqmHHjUF42lZL2iHmY6ICQ5JbhBfE7/9ekAbJbPXG+4R3UTnBWi7KXmGYL3ArfA5hgPVXokImZ0fJoGDaIrSv1Zv2pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267694; c=relaxed/simple;
	bh=jkenw2BNpnSiQdmOaCbO3klF9XpS/36FLlV6FeSn8+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D0zdVz01vKZxLUqI752n6a5PkkzD9ppuD2wdJBbcf9lpEaztXNatvE7+VHdw5o1KuzLRpQ00ghghMjzXBxk/2Sf9+E7xQHvQgmcwrOMtTtcU7N1+5A/dOrgkXv9Ek/uLG1jipG506Sl0Bag0blYrJWYANcXY+ghpfGOiN2A+exs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b74H2wVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7366C4CEF0;
	Mon,  4 Aug 2025 00:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267694;
	bh=jkenw2BNpnSiQdmOaCbO3klF9XpS/36FLlV6FeSn8+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b74H2wVZRxyHPrEm+tmgIpvyk5mQuPTYerxMKMAGwsWoNth4J08NMCY/mBP05wFGU
	 kzC+lDcVitjrP+aaANrCobGo/k2h7TWK6V3NII2GhuaRNoNQzBqmBeOjFYpgBLAK77
	 hce0aqM9WfcpVNBMyYcOUfhlngvmjcrxlwYxcJRLfZODG+8Q5Uoes5XeyeLwCCYSf9
	 IFmwzafdGPJaQ/s77Q7L7m0hVwd+beHVfYuFfW2AyfPXFsy9UQN/ngjpoPZ6iKGPYJ
	 Z4GMfL1aLrFiX6HeInjg/YhdG6LHQ6gUWngJQfcjx7C7TFuBILWyHFCkb90OOuhqys
	 EQ3zssCa8yU2g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sasha Levin <sashal@kernel.org>,
	myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 16/59] PM / devfreq: governor: Replace sscanf() with kstrtoul() in set_freq_store()
Date: Sun,  3 Aug 2025 20:33:30 -0400
Message-Id: <20250804003413.3622950-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003413.3622950-1-sashal@kernel.org>
References: <20250804003413.3622950-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.101
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


