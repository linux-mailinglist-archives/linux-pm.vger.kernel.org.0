Return-Path: <linux-pm+bounces-29438-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B443BAE68F9
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 16:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D995916D4BA
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 14:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529FC2D3A93;
	Tue, 24 Jun 2025 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LMMPD4nf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A92291894
	for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775552; cv=none; b=CGX/1KLeM/kuSOg+HYusOG/0Qzaot631EN7BvCgYXCuxSJNVZFRbrxYLlUN5Sn32rFY8Hox1IoSo1S/UYqaCioe5XH6WyE7yJa/jlSPObkoVcXeS2JY3aDX4jl5gCMTGuSHavsvbspkVbaiEtlju0QUIWD2iT+/4iPngCrKBUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775552; c=relaxed/simple;
	bh=ETdCBVd9dlKlAmlrVMybF4vKOHUekbdvIvNdfOPZpVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JqJbWkxHsxe8GTGIF8FyzNbRK4Oa8a6YuDdSL2PCE5OzfMNQW0Kv15mg7ybekMzgTX8jVppFCGmMEzZ2qIWZK4qNPQWJU3gJbBpY2/4Iuox06nX6FnCvzBAvDsUFMSGzac2U9nfzfhwuHXUaHOPrUcX3TmqXO0Ejq1f6pW4QXu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LMMPD4nf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-453608ed113so48017815e9.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 07:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750775549; x=1751380349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFxv+CSVT1JduUoBwXVfn9STkVHcaXwFmqXMPaWFmWg=;
        b=LMMPD4nfWmfdt3oxavht3kP9icuM4VZ/jIaW4KZA6XWc1bvgtK1b2P07rsc+zoF7ld
         pwc3Mph3yYPdAEVlzDzaWA6U+Jre07n2zfPdLlPrav9nJQwSd/VvCpzGwo7dnjAlK5VZ
         QdUHO5lZdnEi6gU6evxcrZET7MEpwCjE05BHwCOrObyf7wp8Fmdy/F1fKFUVyQa1TIt0
         H8vp756+bFX5/fkLz7RsR7YTBBgtxHMDBwDjLnq083xyukgD0GUE6ob2ntRCrgWJZHS/
         bTMaKmbF5IuOuaty+HzI155cUX6KP4iJXuyuYk/JhAC9xb2janfZv18LKuC8HiHrKExj
         Ts4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750775549; x=1751380349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFxv+CSVT1JduUoBwXVfn9STkVHcaXwFmqXMPaWFmWg=;
        b=IZs2vVPW4H9l7A8y8xK1uHqGg4sxhtvdNODLm8IMLcFwUDkSkiJwAzLhuxwBx8LlzH
         dN4bKaDzSc50qONnrQV95NMbMQSumH/2snj3JgBW71y8LOPTD+2QDAahYVA9g+k//IHf
         RpOuH5vtQGK90iNjzH0tzRYE53zg/FPTwQ5nsYwDGj7IKW40SM7yE9ABJJe3Rz5YrIfj
         Y6D4DwPKpblhe+GFvNL1vMmwz1SQ4kG1L4kVd/wIJi4txhWKXMklsLBF8O/psnqWNEdZ
         +kZHQd+rd/xa1pNb71ljnJCpcyB5JWA/rog9CHgFILngTQf/r8GPwi/V36qSewMVmDrW
         wJMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh9pkzx32pGkEunt5Y7G+H4Q1ounneatToglTvvKraSoIw4tv62EmkvA3HfIb8C5x8qMpxjXgiiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGU08Nv/FtOk4uUb/MmlKUXzO0oErNM/AOuBR92FdkaG7G8UB
	LLfKPuP5zLteXnqGnaSBxaECKTFAmPyTeWfloPaMRkPlJDkcxHmmUm+6FV0LwGmZ+Fkv+dqowyB
	DKmIpxxs=
X-Gm-Gg: ASbGncsXUzKvnPIKnqVF/U1Nxbu9Kr6udmdUH/EjuOT1FOsJzCdSNIMjxpFvIpKLUo7
	Mn1BJIvHjzWERAsra4dB7FBYxz0eTcQWNWudtn6QPbHOe6TrauvCb2uai0OFFk97uSfeaXnXeKU
	dgHt41sZ8Q9OGTbgAlb/8Mij+aJqGlpgE9FsCfT3p9Gdy83rnZrGbOZZQI0qAWiYgLdAeOq1s8L
	FiwJx60cbxqdP1/Zm+JVFKEebSc3g+bFPN2BNQZ2O5olPws7+v84wHnyzELnOp9c2rDDgnfZQjH
	6CAZMoelE2g0RtfZSpmwZEZgyo/h0U2vB2lC1OoFHq/1IkDtCve8BA74
X-Google-Smtp-Source: AGHT+IHD4d2ak9CVpp5Gb3Vl//bTvUG78qxypokPSA3JfLjuNCjdx/+p/2yyT5p37+Ky+IXsejzn0Q==
X-Received: by 2002:a05:600c:3489:b0:453:b44:eb69 with SMTP id 5b1f17b1804b1-4537dfbbd31mr26524705e9.13.1750775548638;
        Tue, 24 Jun 2025 07:32:28 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:34d2:109c:3293:19e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ead2a84sm178512935e9.32.2025.06.24.07.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:32:28 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 24 Jun 2025 16:32:18 +0200
Subject: [PATCH 1/5] pwrseq: thead-gpu: add missing header
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250624-pwrseq-match-defines-v1-1-a59d90a951f1@linaro.org>
References: <20250624-pwrseq-match-defines-v1-0-a59d90a951f1@linaro.org>
In-Reply-To: <20250624-pwrseq-match-defines-v1-0-a59d90a951f1@linaro.org>
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=kuQ4uO8LOxmEAAqs0l/C6pNUD/i2/y1K+eYCkH9r2oE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoWrb5hTVaHLse7YY4Z8fJIQZKJ3AQgAUmHNQv0
 VwZwM91+1SJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaFq2+QAKCRARpy6gFHHX
 cujsEADPF8KCWrxiSt3p+cb4oVKfu3+XmlPa8P9/B3GoYcQRJeLWaTiMykmZYCWqLqquF996s5Z
 wmdFKfXPHda6dYr0UrL6AjoMDT3E2vi7vhx8XCENm0S3SU2IPnmUC6ZoSrRxq4j+pVYbchBLpi6
 usUAgi/RwAJ+oG36mYWYewQdGX7+2dpMjje5y1awCGwzcscsyg6IxSJDp0puslMfIYTfsh/cfRA
 fBJIzMW/dlVZW0QZVjXoZHWG6dlQbkAmUEiVURqPeKnia6SAvivPg8D+vyYv4etq5Clv18wCJRI
 lonF0OYTo0XxK3SAtUTgyuyYbiZr2uUAJDyOvzVgTjaJ+kbz2q7s+ykgusXxpBrhfsx0hxTOsh+
 Gznzh9pKDozRA9R8QOBdLmHbzqoVvWojoURYiul1T/q/06+CbC7rXfj8z6rH8kaRSBzPE37AIf6
 V8CKI/Uqz0B7JZCC1rtmFnWW7fFIkZGLD5DPG+rxIJ7y9IZnAtj3sk1vCRM1rHgnX4+1KajRx0H
 OXe6HlBsNJCmMzP446DYdvuj+DWhCghrCxIRQLl2EQm5vjiYzGhM27jt2ofnYPFw2G+hob+VbSa
 LmG1m17inHqLh1uVc/ypB5241VTSoK05UHHf8YR9GurlLl5qGyloHhTHqZdiO9zDc/llKFs77po
 z9GnVX4voR6m3Jw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

When using kcalloc(), kfree() etc., we need to include linux/slab.h.
While on some architectures it may work fine because the header is
pulled in implicitly, on others it triggers the following errors:

drivers/power/sequencing/pwrseq-thead-gpu.c: In function ‘pwrseq_thead_gpu_match’:
drivers/power/sequencing/pwrseq-thead-gpu.c:147:21: error: implicit declaration of function ‘kcalloc’ [-Wimplicit-function-declaration]
  147 |         ctx->clks = kcalloc(ctx->num_clks, sizeof(*ctx->clks), GFP_KERNEL);

Fixes: d4c2d9b5b7ce ("power: sequencing: Add T-HEAD TH1520 GPU power sequencer driver")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/pwrseq-thead-gpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/sequencing/pwrseq-thead-gpu.c b/drivers/power/sequencing/pwrseq-thead-gpu.c
index 3dd27c32020a6d3b551eeaff2859456fed679814..855c6cc4f3b5bd1aa6e93305af0417d5791b092d 100644
--- a/drivers/power/sequencing/pwrseq-thead-gpu.c
+++ b/drivers/power/sequencing/pwrseq-thead-gpu.c
@@ -21,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/pwrseq/provider.h>
 #include <linux/reset.h>
+#include <linux/slab.h>
 
 #include <dt-bindings/power/thead,th1520-power.h>
 

-- 
2.48.1


