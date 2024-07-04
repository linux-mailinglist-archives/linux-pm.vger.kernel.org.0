Return-Path: <linux-pm+bounces-10577-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABF3927013
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 08:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05733285B13
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 06:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F811A256A;
	Thu,  4 Jul 2024 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wX98WCi6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7711A2558
	for <linux-pm@vger.kernel.org>; Thu,  4 Jul 2024 06:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720076059; cv=none; b=G3ZiQT49qtDjUzMLx1IZMq0SdMksjL2Y20DIfVeK7Z9JGzQ0dc+oWL4AFLMVsc3clxEqnmwAQ5sHPjLNYYEBEbcLVG9SZpe0UCcT7PFRS4EbbBt7jY5nrgsejsqijo+xJHa54MK6kEJwBFaOjFIJh5IyVKjqWrBf9c4XvUDTleg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720076059; c=relaxed/simple;
	bh=rvmbprnMHM6RuihnA3iI8+faiVS/K3OKoDAAx/cTilc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KvCIMrsoSfkr134l/wLYPheqTfAp9Cz0rrmIbH45yntPMLBCfbJi6JN4YhlFAuIvMM/k26kLa1WLVKKo3YNtBVdAPAlMmevgbnA4RB/9u94hSHD7WACjPlQkiXr5cpLFDRzqpmd4BCprn+POMi2sTQzIfxCfGnF88IzeIeOWhdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wX98WCi6; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c97aceb6e4so226590a91.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 23:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720076057; x=1720680857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqt2bqXZTu+jtLjs9BXsNPr4gZaqVWVCViCBOTfKtXs=;
        b=wX98WCi66wvL9ePxOdfS4OnbQRyI/c0FgklI6XAqYMeWTSYJI9wvkDc4tbLNK+A1OI
         yLMVzJqwrNHu6pGKzqfymgYL0DFOJCFeQ9h7uaGAHUcynbWP+KEzTCBjAgRMpgGF61xV
         NFvoYL70Af6sfdWub3ODW6qZi5SbkI8bsHalsjjJQKB3GTZ33ABxNpdzGOOdi7Mm2qmM
         EfbP6hZQh+MpznRkdzuBWBCdt9YvGEZepyUCO3HS+U+qtbXdqj0iuGPhlzVgB0Wwicwo
         0I5rYG4E3hVC/2rMVvpYj+Rx9mSjwdZ9Bc5xbKvd7nHidr26Cy2O+YVZv9UjY9KJw3M3
         FHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720076057; x=1720680857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqt2bqXZTu+jtLjs9BXsNPr4gZaqVWVCViCBOTfKtXs=;
        b=rYqbuN362H5EpKjzffRpP/iABWlBDUBnx2nog/oOpWGh7xldiX3f6acwIPTW9yhk1V
         tIiJ8hs66rLoRKDbRlXDHYWuJTeBcq+WuCR/lnxovJWqXg08p7itrLID442eFeS7vR7R
         6PA/rddMW0uD2N7FLFfwWItjy+RmJDGPYj20RjP6EQuAn+lmKClGmkkO33yD5OO58NBL
         DltOsKZPR2+WhwTyg4WA0CpWaWD9WkwI71FK/DYRLCAO6MySnBnRjFxdWZwpsyhgnE0R
         6ggP4T3me0dd22sad60Jor5oWihUE+dC4m8QuI/cHaQmZMon30Vbxay6hH6IIuKTWFeC
         uGmg==
X-Gm-Message-State: AOJu0YzV/L0zAT+j1A0qsI+V5f+79q4SrdmYqrembRKsTVMlHAj9wSJU
	udfwQYeUWy5xdu/To+PVKdcOFZkXVF9k7Jh8iZ76vRx5A66WV8jBNEHICBEoyCA=
X-Google-Smtp-Source: AGHT+IE6fNB2yrW6RNftQOsnBHViWmextONFWbrX8jTlqq5TSpm4UeSlu7EdPmVmpu6y90sy4DvlNg==
X-Received: by 2002:a17:90b:4b04:b0:2c9:6791:a752 with SMTP id 98e67ed59e1d1-2c99c6d0948mr487823a91.44.1720076057304;
        Wed, 03 Jul 2024 23:54:17 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a947485sm706021a91.4.2024.07.03.23.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:54:16 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] cpufreq: loongson2: Remove empty exit() callback
Date: Thu,  4 Jul 2024 12:23:53 +0530
Message-Id: <f09ee1fa731db0c1565b5d4b919d54d5f258957b.1720075640.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1720075640.git.viresh.kumar@linaro.org>
References: <cover.1720075640.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exit() callback is optional, remove the empty one.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/loongson2_cpufreq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index afc59b292153..6a8e97896d38 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -85,18 +85,12 @@ static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int loongson2_cpufreq_exit(struct cpufreq_policy *policy)
-{
-	return 0;
-}
-
 static struct cpufreq_driver loongson2_cpufreq_driver = {
 	.name = "loongson2",
 	.init = loongson2_cpufreq_cpu_init,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = loongson2_cpufreq_target,
 	.get = cpufreq_generic_get,
-	.exit = loongson2_cpufreq_exit,
 	.attr = cpufreq_generic_attr,
 };
 
-- 
2.31.1.272.g89b43f80a514


