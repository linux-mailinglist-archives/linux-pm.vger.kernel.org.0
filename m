Return-Path: <linux-pm+bounces-27575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3E2AC244B
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 15:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A669189024E
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 13:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D61296D10;
	Fri, 23 May 2025 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tgp1GeKJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D511A29671F
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007666; cv=none; b=sJrk2+azRQdB9vqejjgHqctA/segC3sDdurnT1mJk8xxi5GtzYLr5vGUs0SGyH8ZEMa7XNyBjfrRrNxCd6pXyLdegcAtf3FpYAQZFfUIe7dzqss5nPYeFZSWm0XvNs9b7ELJ8e5bL0MSOfXUop13EfmtExiu3ig992JH4PepkSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007666; c=relaxed/simple;
	bh=k1WDqYJlMC23mNs1HIwLVzoqt5ssM4IDpkVZTQA6i3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHErfDLjmzmqCa8xM2zK5QTfRgr5ekJjdA6xV6uRB8V6AGoDCajg1TGS3EqbAXBvA4GGgesKfzkNuvdnsy9gkSYMmCbxooY4lR/Mvp9RJ2WAuEvmhSZ1HlCyo4vrfDGSRWE7bg3nesdQnS2A7i6o5lJ4oH2LKY1zI7F2UE+Y9iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tgp1GeKJ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad5740dd20eso942369566b.0
        for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748007663; x=1748612463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUC/L//rK2/TTSf1Dzin38jZuZ6dxi7JPqJ0cw7AoiA=;
        b=Tgp1GeKJ1hwGxWrxPdgkBnuQAc7yT/F1x3yfA3W3tiKHaxn9LrcRBS4MWETWkzRfV6
         +LhpPvtMZGR8qAiN8hWYWyGCAnAxLmgniiou0N/R8gEjKzpdlUIb/VVTfYt64FYcAH6N
         PYZOLhNjF36ypV/K73pRCH+cti50Dcb2k6KunRxSHj6QIv6NoM0rMIdGG1K+uneyeJ9m
         47QbZrtS8QkG0W3q40cgMSCtj/8+qADF54PAb6S4rFj6MpCz/1gyBZ2nFHPAIJQt4qQj
         JgcIGKqDJSyDiKALg3gh8v0tl/6k396ZUImHCc5oXMTJ/Iv0fdKG4CbEzoO+Qp31fLd1
         2NXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007663; x=1748612463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUC/L//rK2/TTSf1Dzin38jZuZ6dxi7JPqJ0cw7AoiA=;
        b=cGRrszWSbf4DlSPXPipwG+tgvndE/iQ4UElhOF690GgyruLKkgKgGMZmvpJwSSVBsV
         WSQree52DwDGLIjZNz2omEWlnc+Soz7ZCRRKGYTmF/TOCAJ09Urn5W9bUbKtHtHpe9Xz
         quW514bc6SPdqaeJLwIRcqvDDVDTc6X1Es9Ua1w4xmMo1AheZITXiH5QCub/INmkcTZ1
         E54JPjHz/awc724JzjzSvGayS/WYoaU5idbTO4kGTTkjhLkleUIXtPmsjKXjE+LKYAkl
         if4OraWooEgdKSaxLrCN0rQn02tTHHROKwGNUmsU6g2BOO+59m+REqY7YjuE3PNmBAzx
         fHeg==
X-Forwarded-Encrypted: i=1; AJvYcCUewvyDSg1ZHb015eGvi1NKiRx5B2rc4Dkr9o5dCMKyvBTxHehauXxDhaul4LJsTxdlTwGERjhhuA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1dul1EVGFP4f3KYS3tsPK5bazIlIwJGCk3A/z7Z9cRESU/r2C
	JSMFqXuzarrm6HnGW81W3ptApxHhG0gixNquOsg6qsEcQYu31oBWm17TQErdiMDyEfshPsbFNqK
	2DnrNWXw=
X-Gm-Gg: ASbGncsNAG2/VeaI+o2chZzdeeheC9HFmfMSKSCVhUza6+sofSi2hidjp5CJwhbYXIj
	cuLQ5QLQQM9QLhDKXtkRFc32p+n6gcL02V+k4Ar0gUI3t/bRdTfJimiXMD6ZeoKseiCqQwnpjvT
	45aPxsMTC77V8orU33ebFkNLvQwqBSil9mnImjmmM3oMh0p9IjO8O5RO76PYBypsTskBALXeNvQ
	n/9+N69NpwYtk56O20FtFR4rbfN9v7G2aPGiFH5Zy8Op44fOSyq8N0U25b6FCeIzx7mOPPP0P+s
	WzJRch24dQij8cKCzfQU1LSFksyYD4pa5oA0piY9lRyjG7IdxQFW5Le4/qzHZlIR6ylEX/FHpZ+
	n2d8Ut4QK4jUGuwkoAeehjrLiVg==
X-Google-Smtp-Source: AGHT+IEHCYkYuWzR0+7rN1lJlnWJY9YunsWGOeHigvX1kOvGZwTPmtXZLbWPxdIRTzInet0tBxzveg==
X-Received: by 2002:a05:6512:3d1d:b0:54e:90ce:3c34 with SMTP id 2adb3069b0e04-55216ebe5a0mr842172e87.55.1748007652469;
        Fri, 23 May 2025 06:40:52 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-551fc0d473bsm1950609e87.244.2025.05.23.06.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:40:51 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 08/21] cpuidle: riscv-sbi: Opt-out from genpd's common ->sync_state() support
Date: Fri, 23 May 2025 15:40:05 +0200
Message-ID: <20250523134025.75130-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523134025.75130-1-ulf.hansson@linaro.org>
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The riscv-sbi-domain implements its own specific ->sync_state() callback.
Let's set the GENPD_FLAG_NO_SYNC_STATE to inform genpd about it.

Moreover, let's call of_genpd_sync_state() to make sure genpd tries to
power off unused PM domains.

Cc: Anup Patel <anup@brainfault.org>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index 0fe1ece9fbdc..83d58d00872f 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -347,11 +347,16 @@ static int sbi_cpuidle_init_cpu(struct device *dev, int cpu)
 
 static void sbi_cpuidle_domain_sync_state(struct device *dev)
 {
+	struct sbi_pd_provider *pd_provider;
+
 	/*
 	 * All devices have now been attached/probed to the PM domain
 	 * topology, hence it's fine to allow domain states to be picked.
 	 */
 	sbi_cpuidle_pd_allow_domain_state = true;
+
+	list_for_each_entry(pd_provider, &sbi_pd_providers, link)
+		of_genpd_sync_state(pd_provider->node);
 }
 
 #ifdef CONFIG_DT_IDLE_GENPD
@@ -396,7 +401,8 @@ static int sbi_pd_init(struct device_node *np)
 	if (!pd_provider)
 		goto free_pd;
 
-	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
+	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN |
+		     GENPD_FLAG_NO_SYNC_STATE;
 
 	/* Allow power off when OSI is available. */
 	if (sbi_cpuidle_use_osi)
-- 
2.43.0


