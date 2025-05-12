Return-Path: <linux-pm+bounces-27062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D618AB4639
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 23:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F1819E6C26
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 21:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17A029B20E;
	Mon, 12 May 2025 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ke/5ibqI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C53299AA4;
	Mon, 12 May 2025 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747085351; cv=none; b=gDzKdUhlkLGi8E1wfx6sVJIzBPHzuz9ATH+ifXBWppTew/YbNkMTxSuIyFQsGEpqBHwA693zv4mDnOZXOmMQognFTm/+/RxYw4Gi/5s2s//MmVveLprvCQRTBrm7MR04W8NcxdCxnowgqAvcbC/3qR+4pwYXgwn3EWJFNqHfzNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747085351; c=relaxed/simple;
	bh=awwXn2TAbBoaYGo+e+KQV3s1Vl5rprM8b1Qcv70cHOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LI04Uu38G4/utUrdlCvfaABq4wK0MmoI94UYCRCPIKSCryL5S9/VORuToj0iHTLFD26NOIVBbdxjEikrlrCCION1OsdBqkK9P+PAInmBaGP9FBqvZ8GFXXXHIq4zIB/5e+knIwUjd+1sbufTnFioRhkMca/Q8BWlUdmHa5+B5hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ke/5ibqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFB8C4CEF4;
	Mon, 12 May 2025 21:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747085351;
	bh=awwXn2TAbBoaYGo+e+KQV3s1Vl5rprM8b1Qcv70cHOc=;
	h=From:Date:Subject:To:Cc:From;
	b=ke/5ibqIxWZIGCfnstPdWuLJxGt6VqLdV8S7+5X6WU/w7r27Y8KBN0COjW3baioVk
	 Z7ENjzNHG5U01R5BRxaA1sHeFzAl7IU3HZqRJLanE357WZ/1v9Xl+EuH3Sjj/Uncsu
	 cfWS7GCGlRjtItjKVGmZ9FxgnHU3wwOdQxwPODB9ZDx4tXbmq+os8i8+tk87wzqOUU
	 URUdK2ggwfgWZmaDZy7x/0ASlyIVSctQL84AZ7xnpPSqsb5AOUB8TB8taFtY5SrpAN
	 JuJrLtxl54sILH7N9vCsgjDREL5fljH1ko7dhcByEu+eew3wpW2FhFapjh79UCu06W
	 IA/J6wAnJbXlQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 12 May 2025 23:28:55 +0200
Subject: [PATCH] cpufreq/amd-pstate: Avoid shadowing ret in
 amd_pstate_ut_check_driver()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-amd-pstate-ut-uninit-ret-v1-1-fcb4104f502e@kernel.org>
X-B4-Tracking: v=1; b=H4sIABZoImgC/x3MQQ4CIQxA0auQrqcJoKDOVSYuGqnahTiBYkwId
 5e4fIv/O1QuwhVW06HwR6q884RbDNyelB+MkqbBWx9scB7plXCvSsrYFFuWLIqFFY+R/IHcJcT
 zCWa+F77L97/ermP8ACZKtfdqAAAA
X-Change-ID: 20250512-amd-pstate-ut-uninit-ret-46a23a195687
To: Huang Rui <ray.huang@amd.com>, 
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, kernel test robot <lkp@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; i=nathan@kernel.org;
 h=from:subject:message-id; bh=awwXn2TAbBoaYGo+e+KQV3s1Vl5rprM8b1Qcv70cHOc=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBlKGSq/J7pqtxw/uqaAVcJYSjhjpztfTHfd3ya2WcZbr
 18MOfqro5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEyk8BbD/wIxRt+1yqsWee5c
 UDw363DGh3tLEudPf/d6lp336xXzzm1h+F+4o8ZLzbf/I7dz6iz59F9RSl/fhIVwbDwh0R2p3tl
 2hQcA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Clang warns (or errors with CONFIG_WERROR=y):

  drivers/cpufreq/amd-pstate-ut.c:262:6: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
    262 |         if (ret)
        |             ^~~

ret is declared at the top of the function and in the for loop so the
initialization of ret is local to the loop. Remove the declaration in
the for loop so that ret is always used initialized.

Fixes: d26d16438bc5 ("amd-pstate-ut: Reset amd-pstate driver mode after running selftests")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505072226.g2QclhaR-lkp@intel.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/cpufreq/amd-pstate-ut.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 30835d0e4994..65f9d2bae2d3 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -246,7 +246,7 @@ static int amd_pstate_ut_check_driver(u32 index)
 	int ret;
 
 	for (mode1 = AMD_PSTATE_DISABLE; mode1 < AMD_PSTATE_MAX; mode1++) {
-		int ret = amd_pstate_set_mode(mode1);
+		ret = amd_pstate_set_mode(mode1);
 		if (ret)
 			return ret;
 		for (mode2 = AMD_PSTATE_DISABLE; mode2 < AMD_PSTATE_MAX; mode2++) {

---
base-commit: b01fc4eca73cbd7946181255a95dbe64ff83bc5f
change-id: 20250512-amd-pstate-ut-uninit-ret-46a23a195687

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


