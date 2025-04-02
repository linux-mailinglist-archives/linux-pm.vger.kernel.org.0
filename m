Return-Path: <linux-pm+bounces-24724-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FFDA78DD9
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 14:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0E63B2A33
	for <lists+linux-pm@lfdr.de>; Wed,  2 Apr 2025 12:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E911223816D;
	Wed,  2 Apr 2025 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hyA4rq+R"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C51D238D45
	for <linux-pm@vger.kernel.org>; Wed,  2 Apr 2025 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743595584; cv=none; b=JiQM6AcBGTGB2pk1Nwgbk2T/yw3smBnltcD+E4Lh2OD3BJs4p1dL5Zd5yTmmjM4s8chXSY88/d2nQREYH3vJ7JIIjC7KFbuqM28XujHwDnY57j0SDn7h6YoaRSaR8Fouh0HQSdYS5CxiekJecMgAZo9oA9pnZLc48rjyRUGQ3yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743595584; c=relaxed/simple;
	bh=NqsU/+7oxZL1YCnN3qRWYdYhLF155n2ACcMqk7+Lz9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tPDjProv3o88327IJJeQ2bkIYFLjB+UHtxxxqsZJQJ79Q4qSPCYmiuKqJW3DKWoZpwz2NsRzos1CwUsgPgX7j+1UZVe3BMX/jJvDmCkS/XIVX2b+gmdBApM8+B/ddma5MRXsc1+IaMn4zoDCYFhbtb/kzh5escZ++sXPY3elz64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hyA4rq+R; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54b10956398so953906e87.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Apr 2025 05:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743595581; x=1744200381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zEG4gecI8tD+Jl0eEYFS/WRbrree3429dPKL1Yhc7hE=;
        b=hyA4rq+Rv0BaMBUL7rFuBVDKN/CL4czjJlF/soLUu/NDqDAPgZv7p05t0Hr30tsVWq
         T24ID3iRivFwbDgPUpEvodTxPddaF4vacyV9kCTjrNfJafp+soVcxJXy2qv3+ir8diuN
         SFihR6ZvAYRQVkz+OpiMRBdCDHln368SsqzulhTau1FaP4tIcACWlqn/zHNcAItBvVjn
         wgEAminPRWgrRn5uJvR7xNqqMwEveq9TippRF3AKuOE5FXNF5m0uOsIdZOCugwWlqR75
         F/GFgfUB7SWmzbxDnoxu7x7AwrSdU4BBCbx1V3+yHPkOvZ43P81KjtxHEO2vFhpi/bcF
         jxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743595581; x=1744200381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEG4gecI8tD+Jl0eEYFS/WRbrree3429dPKL1Yhc7hE=;
        b=UrNNlLUCT0spjMSAwjsKwMZzXnBLDD7HPDtnQ/fku2VBToyAD1TeZCo9oqVUog1KV9
         9uNu5HHzg7ZX3M+fRJo7P96pzZmxowB3vrMrci8bCzI+8d4/llrTxJ9jCu/DAs5BCwD3
         69KnO93nLIMZol2uOtlCiuRHGuz66N+DzJtYa86l1mFylg4uBM6l+7ws/dj1vpXjWQwE
         rM1m9atbRWByLY84PKFOjeiEGfnMfttfWI8C679Optfi1z96dOmDS5EO+Ar0L9ELo2bK
         TELMyG7bXB/F1t0XmfxQrwtccgZTUC5w5yoIAvDpk75CZJ06M3HXCEOfTXRDYg5rSfFF
         1zYA==
X-Forwarded-Encrypted: i=1; AJvYcCX1P0RzFSVJ14HwE4qeyf0+InUG/J1fej6LDdOLAq/KJE8050/YUC8BrgzKe4+QQSVeJxpl8yc/jQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTtzwhu8NdKcAmXfHrxD2Zi45t3E8FTJxoi3pSNPqMUJA5o0Nn
	7nT85SDFZ0XoC9LYu9LrhTm5P/Y7b72LE5q/xydZvHfjZfuqOiGEvzB7lZjVNkI=
X-Gm-Gg: ASbGnctjeWB+9DWZAp2YOoIURa72zVmdbeZ/WcwPG/1ZDjv0MAEV9J2ObhsGS/cHSad
	2TDNSMzpAuotxPPybjtlSlHOsMzBeX+yF+0TuuJRIyu7bhUXl5ZUM59iY0nVTxFHgjMWh6gezIh
	mdsqehTCEYLafMULZlxBrFmvVYTfsxlFA6vCNHEl1Bf5HUqX8lWwXH2c33MGcVmvO3zy5NZ28mU
	hX7c1Jgmj+hOS1T9XZLhWdvCuV5+YsiV6lBHjg2Tpxo/jhNG2ltAM1zLdXNKsWPC3OpiPnEmoip
	GFWJVqJTFleYG5LuuAdYgx0peoZ1fuu01iRxRNS6aWxGRyDUpFy9iGbs20gRWt4ODzRPLImMLE+
	NZezE6hXqqk3Y93fBS30=
X-Google-Smtp-Source: AGHT+IHAorU5HIF63fzGnkivetyexueQYMJ3ZBC4Gy8XB0gdbMI3Klf829/ZF7PMB3Gu1bJ9VZlDzw==
X-Received: by 2002:a05:6512:3d28:b0:548:878b:ccb3 with SMTP id 2adb3069b0e04-54c1a1daf7dmr682827e87.25.1743595581025;
        Wed, 02 Apr 2025 05:06:21 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b09591bc4sm1594858e87.166.2025.04.02.05.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 05:06:20 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pmdomain: core: Reset genpd->states to avoid freeing invalid data
Date: Wed,  2 Apr 2025 14:06:13 +0200
Message-ID: <20250402120613.1116711-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If genpd_alloc_data() allocates data for the default power-states for the
genpd, let's make sure to also reset the pointer in the error path. This
makes sure a genpd provider driver doesn't end up trying to free the data
again, but using an invalid pointer.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 9b2f28b34bb5..c179464047fe 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2229,8 +2229,10 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
 	return 0;
 put:
 	put_device(&genpd->dev);
-	if (genpd->free_states == genpd_free_default_power_state)
+	if (genpd->free_states == genpd_free_default_power_state) {
 		kfree(genpd->states);
+		genpd->states = NULL;
+	}
 free:
 	if (genpd_is_cpu_domain(genpd))
 		free_cpumask_var(genpd->cpus);
-- 
2.43.0


