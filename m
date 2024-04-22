Return-Path: <linux-pm+bounces-6748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A868AC307
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 05:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35011C20A06
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 03:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E48412E7E;
	Mon, 22 Apr 2024 03:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Er5qu7FT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF263DDC3
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713756684; cv=none; b=WdQhuJ76YDIcv/KGmmHhnhyvZ78NakmAfUzhi5hP/zCOrW+8MCyfCIRGCBDOcqSW1s9Fufd5pPnDxaKSyUtA5MerSHkx9R9OvA4BrTH/E1MfL+Z5X7VUkTN7SF2ZgtuaKOljQbRov3ezHi8wMDC58xJFZkMfDJba5w47oVAERkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713756684; c=relaxed/simple;
	bh=WgJQBh8J1Waa7dt3AUnqHF0bETc6Ofj/zz3UpXYRizY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZAFBrIvAeF9ATegh9wHApCz0OvTaicx32oSmSwlQXjSNLzPcJ3swwEz1ty9mi3L7igjPflIGsOcxKjXskRBUWLp1XVLWY3zZS4lBOvtsG30X7Q22oY+vHNk/m7p/OwH2gw8OjIuhw5f/JbYq4CHH4slrJNGvMWpNYVzLIqhgkUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Er5qu7FT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e8fce77bb2so15058675ad.0
        for <linux-pm@vger.kernel.org>; Sun, 21 Apr 2024 20:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713756681; x=1714361481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Li3+1Ghj2slvXiv+/E7e/F9kDJtZLuXuC3BIKi+jfUc=;
        b=Er5qu7FTKrIPEWR48uAEX1DLYS3VrpieX1PAzPUN2S1jtCYeQcEqGhZymduJGj6U+t
         avDkS3SfYje394nnAdXeQX9DD86J8sH2kAd0D1+HfnuqL41j/NULtAJF/IOyrCTFSox2
         ftmMIQfgnDacyeH+vaHHqdWo2A1t+bRxe5UZhG/zO8bGNRKPjMuOYpUUiZVFCD74ZFua
         cNfatV6U+bwdYUHaTqJ6d07qjLw9/Y6X1UvoajhziCHJiemYdgFquIkaKqhzdlMcz2Me
         z84rjr7izdmwmlucBWp7PTsmCKwHRe/mByVCEso/21+FovunMHfQa0vnyomYhkZrVOdY
         eVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713756681; x=1714361481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Li3+1Ghj2slvXiv+/E7e/F9kDJtZLuXuC3BIKi+jfUc=;
        b=fld32zsUrXF7PcQkuOlhwylQu8Nfv6pjh+J9xeFvpZSVLCn4EHLQXyEsBtYU5HAz3j
         FZCGklU5uBeeRpQVheWA16hxq+YPdBHQoXutQcyoaG3V/wmUJ6aPXJSmnKUKKnme9Lns
         L7EWUel7HGZvnnUmFa5TbtWUqT3eSP12l3aU/oEPB2EpboIkX0nN1sLkCXAipvy+aJnV
         EJU8uOKyylSNotE1cUdZx2fILGweedfNbDd80/pYngPI8fK7QHZiAYQtkvjokgQv288S
         0mYP85b5ddHDzPsXRD4sP5p3fPblRcPipRvmOQKs97Rmszo6VFNtgHzJgGcVIamfe7f+
         pc5A==
X-Gm-Message-State: AOJu0Yz7VbOMwMGQU0fo9eES1yYRz6OMAsVvVtBe29meTLhppsT8G3xG
	1d+IGftw3/EQcisM2jCRYDxPprenAvVrofTia09EaO2vsnXjnU7cDiYm51SCCXY=
X-Google-Smtp-Source: AGHT+IEGPELzo18c9HmsXyfk6vYoiNKnZbbOrQi5Dlekvq6DhkR5uumMN7p3RYSBJx4+oqieaxGcdQ==
X-Received: by 2002:a17:903:244b:b0:1e5:5041:b18a with SMTP id l11-20020a170903244b00b001e55041b18amr11845236pls.40.1713756680930;
        Sun, 21 Apr 2024 20:31:20 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b001e435350a7bsm6981020plp.259.2024.04.21.20.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 20:31:20 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	kernel test robot <lkp@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: sun50i: Fix build warning around snprint()
Date: Mon, 22 Apr 2024 09:01:09 +0530
Message-Id: <285de20a187f3e4baeb28f639b5bf55e914a3821.1713756666.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Sun50i driver generates a warning with W=1:

warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]

Fix it by allocating a big enough array to print an integer.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404191715.LDwMm2gP-lkp@intel.com/
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 30e5c337611c..cd50cea16a87 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -19,8 +19,6 @@
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
 
-#define MAX_NAME_LEN	7
-
 #define NVMEM_MASK	0x7
 #define NVMEM_SHIFT	5
 
@@ -208,7 +206,7 @@ static int sun50i_cpufreq_get_efuse(void)
 static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 {
 	int *opp_tokens;
-	char name[MAX_NAME_LEN];
+	char name[] = "speedXXXXXXXXXXX"; /* Integers can take 11 chars max */
 	unsigned int cpu, supported_hw;
 	struct dev_pm_opp_config config = {};
 	int speed;
@@ -235,7 +233,7 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 		config.supported_hw_count = 1;
 	}
 
-	snprintf(name, MAX_NAME_LEN, "speed%d", speed);
+	snprintf(name, sizeof(name), "speed%d", speed);
 	config.prop_name = name;
 
 	for_each_possible_cpu(cpu) {
-- 
2.31.1.272.g89b43f80a514


