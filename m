Return-Path: <linux-pm+bounces-20996-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3355CA20533
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 08:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E2F01668DB
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 07:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A691DDC0B;
	Tue, 28 Jan 2025 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cUmCqDAd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E091DC197
	for <linux-pm@vger.kernel.org>; Tue, 28 Jan 2025 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738050691; cv=none; b=Oz8e/k64lDOktKSKvYLRMdU/44+AGoKDBYV+SwaE4PHxUVzefR8yA8xQ0dhnLHDklla0stlSwu0q/PQghTJ8KAIK2wLSeDHnfA/+6UnP1JDmLxnf81SXE5nNmdxE6To5TUr8oYniZWzlsfbg8s14sgNQyZnBvqyUljoIOkZWtyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738050691; c=relaxed/simple;
	bh=PHOD84SGxrl0YCUe1ySTQU8FqXCkUuZlvAP74ivlqLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nWnCD1bQRzMdVHwo3hCBu/BHbFwKJ92zYD6X0GtaIhn1f3kqlgbynTQQRhptgYMXynIjLUjIjx4kztsimYSu7vv7bE7nA2mis24BLyw1iWzE+tYlc1M2a8G9d4SfBSH4iEpVmztZqE/VmDIcRCuiMA4ZaJnwTJbNhOLyzq+/X7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cUmCqDAd; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so7362413a91.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Jan 2025 23:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738050689; x=1738655489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FFq+pfJMrWvJBJzSdwI0O+X3QRozQl2nIXxquspTaWs=;
        b=cUmCqDAdgvLG+CDfvGVzExTVpxU1AgOos/twaZ62F5PiqRMxlzMAPFbkVBie2kKlWq
         Sl2gkh4+kIoY5f4y+zg3y+iRCVm2gqvdwr7wunVM/pN7AGO++MFSKljiKeFixAT4xt4O
         FQI7N3Hj3NT+21E3Xh/M60i/soyCJklv99ykb3Y9i+Y55/pMocc5CvI2TTCK+X9Rn/Nl
         h3GyceeO5VYofqP2lI4rQOyVxAhOxPNwlhRBL8uI3QqdOUjZTbKnkFK0cooqvCkCIFqc
         /cSwULO08TGjo9Vs/Ii3x0MvSy2ldOKrWCc5Cin7jq+o9pzAMS6KZAbGwhlNdcROVxR/
         xvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738050689; x=1738655489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FFq+pfJMrWvJBJzSdwI0O+X3QRozQl2nIXxquspTaWs=;
        b=laHKi15q46xkMp6uZhpZSzsWteGXhBgYNIg6FCGozdGXBpouiS4nqbFWeTThfkeeZd
         kWmWQ/jhXwW+EXW6sVAAZo2HQk3t4mcY7NmcCgikTSLCOsE74DzMCZh9ycnG6FHzXPi7
         u7CuF3+qV1kY6MrPridct1kg+yX5+2UIOkOuMkyMyMh8gIrAs4P9d9khHECkTNvbtJTF
         11yfBDJIGooPlAi7q8oZzE8UqyuiJlV4/lUm+JXre7HEF7Jqx7v3Je1/XZwGC8J9d67S
         9gqij74yeAge7TYn9gkS3MzgT5mfP28JbksecO8Ep0lJnHaNYu70namYz4SA0BtXQjgr
         wRpQ==
X-Gm-Message-State: AOJu0YyGzx00ZbeeZrLJY5/ArcMd+p1IyQeBQTt1HnUCD2bb7v1NnlcT
	W5F/URf/7NQGH72r4IEjIWygF5d2Pp6pUcHYnNpzcskh0/3UPizsb/V8mdtKd34=
X-Gm-Gg: ASbGncu2/pB0MJDpgZzlb6Bg4b/ljsGJwWlE9YZf94eRBADT9gcqKc0TkYgfnupFgh9
	yDElbmw01pX5ufuOEZ5mKQoV1rtnjqiG7uVHYeTKarS4W6W9thHBxWw1nqlpI4h8xhqSRx5Yd0o
	rZy//D1HuZMkH2g56QjQo9UvOJ6WKTVk3m+HsQVY2VOaa1g4ErjqBw9vnXLTXAZVEdMlPN6AGnz
	cqpVAdlsYHuShSg2EG+eHjbXDZdY3V+FJnWN/ttWQBR9ovWqh50I7WLulH4uc9+LLyf2B4GXTLY
	swXyqOV2u0DhgLEK9Q==
X-Google-Smtp-Source: AGHT+IE8O239cr/w8ci94TjALxeoFFo6r9SPqh/N1r6LdpvOafxq7u9sWs8c+PdHAFY7JCKTVSoIdA==
X-Received: by 2002:a17:90b:4b8d:b0:2ee:7a4f:9265 with SMTP id 98e67ed59e1d1-2f782c976f5mr63876736a91.15.1738050688694;
        Mon, 27 Jan 2025 23:51:28 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa5ab06sm8587098a91.18.2025.01.27.23.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 23:51:28 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: airoha: Depends on OF
Date: Tue, 28 Jan 2025 13:21:23 +0530
Message-Id: <455e18c947bd9529701a2f1c796f0f934d1354d7.1738050679.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Airoha cpufreq depends on OF and must be marked as such. With the
kernel compiled without OF support, we get following warning:

drivers/cpufreq/airoha-cpufreq.c:109:34: warning: 'airoha_cpufreq_match_list' defined but not used [-Wunused-const-variable=]
    109 | static const struct of_device_id airoha_cpufreq_match_list[] __initconst = {
        |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501251941.0fXlcd1D-lkp@intel.com/
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 704e84d00639..0ee5c691fb36 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -17,7 +17,7 @@ config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
 
 config ARM_AIROHA_SOC_CPUFREQ
 	tristate "Airoha EN7581 SoC CPUFreq support"
-	depends on ARCH_AIROHA || COMPILE_TEST
+	depends on (ARCH_AIROHA && OF) || COMPILE_TEST
 	select PM_OPP
 	default ARCH_AIROHA
 	help
-- 
2.31.1.272.g89b43f80a514


