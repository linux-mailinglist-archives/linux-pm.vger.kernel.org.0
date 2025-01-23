Return-Path: <linux-pm+bounces-20843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4123A1A32C
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA793188AAC8
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC7720E71B;
	Thu, 23 Jan 2025 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vx3QtFar"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CF421128D
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632306; cv=none; b=qFQmcmbSrxKYrkESx8y3BQZVrZk9l6sdHwYgMuv0d8pOtpyrfZxVPHrOCXLftGz08c5opBObFbPgnoLDsNnd4dZH30MhqM96pLcJj1C1JjSP6ar0ifljyQdvVAIC7K7CrF9w0TvWODUUP6w2t2N/KZlphPkFZ3LQAYWkl/a8IJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632306; c=relaxed/simple;
	bh=ZueQfCMECx+kI05WZhaPypKs9tljAe9z2E4ejICVPJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jnYTEJJYepNAkWoNTFk6o1vXOq1WobJY5MbIf/8WxUvCG3P4P7+HWU49NZ1KJWJczMytTTg9fTVTXG/m3ead+JWrVk+LoVSNHR6/tNYTwVA64+gwMW8iIAcFrf5deUtsukaQ6gmY7mppGGj9RBH5zA/6Fb2ZELoi0uIU+XNtuOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vx3QtFar; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f42992f608so1245540a91.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632304; x=1738237104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vWStfdhwz/DXffVrkvPN3mnj9RUVL7HlMAJE5ve61A=;
        b=Vx3QtFarjBLP2vmXCBdeRZZUkxLNnuAg60Bv9dTUXAxqebR8DJSOIIJ8fXer9A3gMl
         jN95pchUF2tDRocF+X5rQC8xV+PcU82/rRTdvcizMwHJupvCmPsh7t/fjsLPtIi3XmbS
         JOkH+cODrQlMqobBf3RjYlTBZqUMzZJJimJfW/c7ktqu4XJQG15Ds7rWMqs2XZrQp3Yt
         UgQsTRrQ18xZpa2/V9exhiSePTIScz72/DhGzSilRswUS2G2FKtA4qDbCQVSOi+s3JG+
         Aq/5RfdZVxwtc8ft8mgZ+BmrJ26DOjW2oaUOG0/JhSTHjEBY4ctLQlPdhq/vIzUTdEhR
         vxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632304; x=1738237104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vWStfdhwz/DXffVrkvPN3mnj9RUVL7HlMAJE5ve61A=;
        b=rSWjlpQlqq1UAdEwsrHFjZJV+kP0pCpxQfAvSHbfWWroC+tEwWgjCuSeOu568HINWO
         C2cihQlQpBTtHEwESTwflEIGMN7PlpHGYCK1nb4/AZpEFYLK0FKoaABN3XlC03wVNryi
         rBKaauc8FNCrMLLZC8UtINs3uMm+qTeB4YsgZKw7SAaGTGiyryvdgPiN7Rz9n8EUqSon
         iwQnyF+c8izgnBc04FHMjbWMeIju2PbYUQkItRpJfVHe55LYC19EvYaoZnPN7bL564Op
         HzfBPl1lrEFKqleH6j3ATB8TChneeyrToKRWnz4bXDjc3FsyuYcwnVWREK2u0z6UwIp4
         CgGA==
X-Gm-Message-State: AOJu0Yzv5IRS0Ster1c6SJGIdAgTBHE93FkQMcgd9f99N55CQaMCg7Na
	csKj/X97ASoP5MpHbQtD8OYHMd4Ur3/Sg8TYaRfvCe361ky99JEzRQWwSTyTTjs=
X-Gm-Gg: ASbGncuLj2iNSOTMDJufaKlXkiKVjc/hFu1DKzImyJsTEhRyWKb2YZUw1NIg4jikQlp
	yagC508+rnVzDa614bO/X1NjTDJYTBlhfAFjFxEXfY1Mk8LSb8F1nZRKT7q6Bm0/LOmjgE1ATde
	drmHwjuswEdz7t8cWKciTiX0Sze9X21FZbJGGfMbHfv17ehABC+yU1P7RnJ2dx780bPW4rIMCFU
	PwZF50P3RD6E05yOcqxQH3l8N04JWyFJMeMx9KeS7+vDxATGuQOOC/Is6xNJMFatzObvwAuEac6
	32Dx8zU=
X-Google-Smtp-Source: AGHT+IFuDqxjxxazYMnLc94WXF9eSOvTNEROLXLZgmXpoclSdt9+o3HboHu3L6335uB7BMgfmBgY2A==
X-Received: by 2002:a17:90b:4d0e:b0:2ee:bf84:4fe8 with SMTP id 98e67ed59e1d1-2f782d69fc6mr36897321a91.30.1737632304537;
        Thu, 23 Jan 2025 03:38:24 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6a7df25sm4029815a91.14.2025.01.23.03.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:38:24 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/33] cpufreq: davinci: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:05:43 +0530
Message-Id: <98e575271e22d7386b9e1e9858ff2000776b50e0.1737631669.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1737631669.git.viresh.kumar@linaro.org>
References: <cover.1737631669.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpufreq core handles this for basic attributes now, the driver can skip
setting them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/davinci-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index 8736be3a06ce..2c277eb3795a 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -101,7 +101,6 @@ static struct cpufreq_driver davinci_driver = {
 	.get		= cpufreq_generic_get,
 	.init		= davinci_cpu_init,
 	.name		= "davinci",
-	.attr		= cpufreq_generic_attr,
 };
 
 static int __init davinci_cpufreq_probe(struct platform_device *pdev)
-- 
2.31.1.272.g89b43f80a514


