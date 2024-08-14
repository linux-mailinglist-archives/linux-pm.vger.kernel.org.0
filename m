Return-Path: <linux-pm+bounces-12192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D1F951403
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 07:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5531F25616
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 05:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8759F136E18;
	Wed, 14 Aug 2024 05:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TS0uLLUB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143461311AC
	for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 05:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723614290; cv=none; b=UD1Z68IeDoHZmk2pnzyghPtHPEbXStuD5Qvtnl0tfcuwZuCkhe1PKK1ne7vl4L1AQIdfwvd7SDelf7ho8co0Z1wKRFZYiNOg3Dnr4ZUoNln4kY/sDX81CrQc6NxEs4wZZczS5LVU3U1L73EU88fBoh4CaCXyv8Ku+4uIldrnXv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723614290; c=relaxed/simple;
	bh=DY/EnKxUgw/t3JJe/H9FARv02RC+Lgp7w5T672pTog4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CPX3CueERzCWhMUvBkubv1iL9hamdWsx4ClSakdRPfhPRBmmCosLwMaYJX7POVtF++9mFJerj9ysu3viQ/+y/I5aTxIEIpEh6b160uNes6vc9nqBv9P+F0nmvnMxJ1J5cdZLs6nIejRwNyWGls1YVCFSZSzanD5tNf6c5Ndnh1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TS0uLLUB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7c1f480593bso4023251a12.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 22:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723614288; x=1724219088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALi80qQywvgRdU6+eXIGrdG4mei/lQM5/cjgvbw3p6w=;
        b=TS0uLLUBchswfVArE1Cn9jArUAk9pBbEq8cMliqrhu9mZK81JzTXzKB6bHYP1fOxlB
         KGfa5QJM3ewaRN4gueUI4DqZiYU6pBx+Yuz9sPssWU/+Mush5cE0FJULmNHhnIf7nWxm
         WE2kSQZ5OXCI6TMURkTdjHBwBeXFXS2Dqb8san3nt1MJZhk277nZhYO7XEc4ZCeu0KgH
         fkFMkFMcM+QKc0o06OER6jJNPA+F20AwFuIohTXFkMJelVpDB9/RortsTBDcNRU2tiKT
         U87ElhMKxpDy2hREuUouzapqLgFW9tWJvn1yrFrqmGeUW7aTUcWGM8OtcRnnn7m1Tom6
         MDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723614288; x=1724219088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALi80qQywvgRdU6+eXIGrdG4mei/lQM5/cjgvbw3p6w=;
        b=PxGzUa3swQGIY1ZLAcuBAMfvH8KizsRUAJG1yvzyA7/k3uRS01Frhk9u6qW8cg/gXZ
         +OOlysF3S24YWB/4tsJNrzWEehceMHHRbm/pr2E3hA7b763hoagql/TI2qf+0CbrCG/W
         3BJOUUYdgAw4fghzGtbzZEDJi5t2DPaEHItWNsLk6gXKwqwgcvOCx9+xVHlaJx7LDOaK
         tnDhKVbMtmqzK+KLPuwJpi4jX4dfBZ36M2zfRr6esYv0nBJ02hAAcdfhHE1igrwAUz/Q
         0QPGzMfBgvkaAEVtU63xvKrZ0ksKAWGF6RkUTQekqYJv3cTAGqUXlfkhlp2X+noaOitO
         3O3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLBcqMWohs5s5q0Fw3G1Fo23DDbgG1EL2D2zNCH7uuOoDFddU5F06swVbvGD+XALbx7sJjqdXqR33seumuGGuBkorW0Qgnt1s=
X-Gm-Message-State: AOJu0Yy/cRwHVT9wM/qouLk57UC8mm0S6dIFsZsmaCqarh+Gp7IJ7cfa
	+KaHe/iQHeoh+ytDelaHdN+om+RgvsMMxv1utyDFHb4Su2V/O5gt1km+uB9sXn8=
X-Google-Smtp-Source: AGHT+IGdGbklP55z7Stx4FlDdzAVCAAfA6mUFaLw7+5KDYOKNc1xThXBt1NMzPRtP1UnIPwA1wPDcg==
X-Received: by 2002:a05:6a21:398:b0:1c2:94ad:1c67 with SMTP id adf61e73a8af0-1c8eaed5ed2mr2299929637.30.1723614288396;
        Tue, 13 Aug 2024 22:44:48 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1ab486sm22062085ad.150.2024.08.13.22.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 22:44:48 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: anup@brainfault.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	greentime.hu@sifive.com,
	zong.li@sifive.com
Cc: Nick Hu <nick.hu@sifive.com>
Subject: [PATCH v2 2/2] cpuidle: riscv-sbi: Add cpuidle_disabled() check
Date: Wed, 14 Aug 2024 13:44:34 +0800
Message-Id: <20240814054434.3563453-3-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814054434.3563453-1-nick.hu@sifive.com>
References: <20240814054434.3563453-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The consumer devices that inside the cpu/cluster power domain may register
the genpd notifier where their power domains point to the pd nodes under
'/cpus/power-domains'. If the cpuidle.off==1, the genpd notifier will fail
due to sbi_cpuidle_pd_allow_domain_state is not set. We also need the
sbi_cpuidle_cpuhp_up/down to invoke the callbacks. Therefore adding a
cpuidle_disabled() check before cpuidle_register() to address the issue.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index 98e7751dbfe8..3c8a509288f3 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -25,6 +25,7 @@
 #include <asm/smp.h>
 #include <asm/suspend.h>
 
+#include "cpuidle.h"
 #include "dt_idle_states.h"
 #include "dt_idle_genpd.h"
 
@@ -336,6 +337,9 @@ static int sbi_cpuidle_init_cpu(struct device *dev, int cpu)
 		return ret;
 	}
 
+	if (cpuidle_disabled())
+		return 0;
+
 	ret = cpuidle_register(drv, NULL);
 	if (ret)
 		goto deinit;
@@ -548,7 +552,10 @@ static int sbi_cpuidle_probe(struct platform_device *pdev)
 	/* Setup CPU hotplut notifiers */
 	sbi_idle_init_cpuhp();
 
-	pr_info("idle driver registered for all CPUs\n");
+	if (cpuidle_disabled())
+		pr_info("cpuidle is disabled\n");
+	else
+		pr_info("idle driver registered for all CPUs\n");
 
 	return 0;
 
-- 
2.34.1


