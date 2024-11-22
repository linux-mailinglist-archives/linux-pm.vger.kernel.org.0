Return-Path: <linux-pm+bounces-17959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E279D5FD2
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 14:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1271B233D8
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2024 13:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D47428E37;
	Fri, 22 Nov 2024 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sEL4n2zv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B431F19BBA
	for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 13:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732282937; cv=none; b=E+IgbSMQpOKxpxueZj0tro0TiJ4Y4NtNYdlw7VyzTR5CAG/JVWQPyVAAAHuaVf5N49mMurjk7OCiyuW0Sw6uK88IjeJX5Z+CUdCkaNN6kiMhBZ/9cYYJK05A1b8yag79RwPf+jRJt+Z411hfgjQiurFq+zF29wpWkUQ8YAPgH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732282937; c=relaxed/simple;
	bh=7rpxTCbAovNOOaSE5QqV66Aj2XvYh1HPcKPEvedvnPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIWnxLRUtzJPJDtMKkNeHUtPCnmURn1l3aIf4wTUtLOiv9GlLy01aWB3VS7+aGzucOFLDVQFOcrHSKb9dkMt7d5tz/7Ptk+OgYpH+kDjh9rlWv6Jji3y1hbBjHUI/fobg7fbwZxqUGS9lYzJmQQQA83DEy/CM7Mirskom7JAsPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sEL4n2zv; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53d9ff92edaso2468965e87.1
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2024 05:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732282933; x=1732887733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hR6Bt9wGJi7TnVA8wmi9rRKI8kqmYyf5TPLbM4hQqZU=;
        b=sEL4n2zvxEzzGCp/hRVpZ7udi7krOdjTeN96A96SYVR7j0zgpdrRjPxJH44Jj41hYk
         /S6CMByFPaf6M15/0fDC2ECv4jZGpEODQ4bnyALeLP+eNng5eVm6K7wGAVVOqMA497+u
         rtop/DjDkb9Nn9Pf3NkrHLEi+nQxBhBfRn4MlIndhGmjvLUD1t6h+Y20jvN7j6N1NdeK
         qdwj2G/vDjQZVGTwsykzT2EKUZtvSsKM4sPng4zgczZd6qtwsfOFWbwcW5EuCpEjS0+l
         aKmV1smSPRsYroSH63aKdSgujnvn9Ad+RQH0bdU/74bfJgGPWc5cnym4O1XtKaPJduP0
         sqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732282933; x=1732887733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hR6Bt9wGJi7TnVA8wmi9rRKI8kqmYyf5TPLbM4hQqZU=;
        b=amQqcjA+7AW0/j+bkdQOckQ6rGyKAmwX3n7P5odHvJop7UnwlfZmFL0hw+W+WgG2Nj
         47jKsvleITR14fILQx01s4mO2EhiT0FXhQN+4Rud3ZAmyLoZ1qN4pCxQsIoqDGdCBl57
         UfW5Nz8Ixwi+RgiHLZhtwFDvVTOlumqMPdpGw/tKgmoHCbT2KmikkIxj+DTnvfEhPag2
         v9s8Tom1It3R5AEK6k4NrgYDEon/aWiJP4QLDN01kzOmFGhuX7HJ+azjUQWO7piej6Jn
         YsUVTUbhQvLMnVtTEa6vml3UZ8/vbtUmxbJ57+giZWKJJhibcB/uQerjFwvKT3Zbrg8U
         90DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfoMj0LGdNAS6hXEDzX38VxwjYDV/dAg5/pQudwtSJK2O55QkPeneo0h10PfuPT2/MObkmQRUdGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQO9YICzA1+ylFZqvOIlAprZBHFdbCbEqjLpopJqjgu84XCYHN
	JWbF8n6JcsjwqOVtmvt7Zry0irQDA+bIoyR7sjiZrLOi4xkt+8f6hp/rQhf+gtM=
X-Gm-Gg: ASbGncspLyqS75L5qvfwkMr6WMZhdlLktZRKBhCbc+xTH+4HnVgwSZIpF7pGCfJR/jW
	pI5MymUdcerVf/hV0W7VEcTljrFKUjSwwAt+htpRcjYiQ6HBWv7E1mRfhoZegpM7KxO4gBSEpr6
	O9TZfmrPAbMDs4IacAoF3+nWaGDcmyBgUiweR9siJrt5+EoJGyczvduBkR08zMyC7ewMk75Oz0P
	9CLdJIiomg0deS5mNLM2JOEphVVNbSx6A5h3pDFMdiIhfBRVhSo0FijjkLPuEtnXTnOW2wkLrOw
	fODmu5ejAfOQ2ti+vzgLpVfQ
X-Google-Smtp-Source: AGHT+IHyw3GH8RrHFNfGtL+1PQD/slLLct9YZQoWaph6bHJlpew+jBHD6XIcc07hIt3G/uvpFcVtsw==
X-Received: by 2002:ac2:4f11:0:b0:539:e1c6:9d7f with SMTP id 2adb3069b0e04-53dd389d698mr1582840e87.25.1732282932796;
        Fri, 22 Nov 2024 05:42:12 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2481e73sm376432e87.120.2024.11.22.05.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 05:42:12 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] pmdomain: core: Add missing put_device()
Date: Fri, 22 Nov 2024 14:42:02 +0100
Message-ID: <20241122134207.157283-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122134207.157283-1-ulf.hansson@linaro.org>
References: <20241122134207.157283-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When removing a genpd we don't clean up the genpd->dev correctly. Let's add
the missing put_device() in genpd_free_data() to fix this.

Fixes: 401ea1572de9 ("PM / Domain: Add struct device to genpd")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index a6c8b85dd024..4d8b0d18bb4a 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2183,6 +2183,7 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
 
 static void genpd_free_data(struct generic_pm_domain *genpd)
 {
+	put_device(&genpd->dev);
 	if (genpd_is_cpu_domain(genpd))
 		free_cpumask_var(genpd->cpus);
 	if (genpd->free_states)
-- 
2.43.0


