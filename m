Return-Path: <linux-pm+bounces-8090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2570A8CDBF2
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 23:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A2128466F
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 21:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5D612838A;
	Thu, 23 May 2024 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5i0IpY3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551F7127E04;
	Thu, 23 May 2024 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499512; cv=none; b=pHIYm5jEYHOf+u2H634vmYlG7vnUCKkvGHkMi9waqgkbNRDKLQks57RjIQG07FCTwpHoVQaNvCYjVUhg4cgPaLAD439ZvcQlqZJyeSRW2WUIZ/XKO628oVewo1aQzBCsZJLF9aPh0/F+gAkatBfpkadD+JuCIRFfTlknFkVSohc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499512; c=relaxed/simple;
	bh=O2/sXGTtESOtbSq7nRlWfIJXUquoXPpq1fCAs0u7NWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oIxFRFfeSX9xqhkZi2WtCp3R5KxffwyqqQco0fjBKB0K5Xe6lCgCKumfewCjBzsPmzdMh878ccDs9jQtYNfge6DOgTcNZ23pJ7n9Rx4AFf8x8NcVqP+pFWcMuTA7qeBT0TkrJBrpO58We8lsAC89v9GCNx5GAFTKt2NEA7+hzLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5i0IpY3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42101a2ac2cso12899005e9.0;
        Thu, 23 May 2024 14:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716499508; x=1717104308; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2XrUpXca9802sFKQT7AfZ7CKYtJZmtjejh5XLUo9IF0=;
        b=M5i0IpY3yJTFQC00XVuvjEcpN2thROoCJ7K177uCD6RVFynYHIcxWwwz8BkuNHYWe3
         vZNkN0aAin1SVhLRgWbsCq9bTgAdhOYCFV9ZWSCUWudvDyZSHDNQ55ZcXyfGEZQomMtI
         UvZe1Q4HHbw30B9Aw7EChpHuaZ0my1e2RLUBI9xXpplUtJ0poXULFFp4UldTDyfJl61R
         GXOP/zNbM0ScHJJ5M+LspkFWxKFFEUcy3za0V7fbFlUkRRg+Wfw/Ngl/ItS3dISSLZdG
         6udRTdhcLar0B0VQmCbvySkk9dPF6CPGttjjlQMQjm7a8jVwW7VzEV5R0NUIxNiTOVUB
         dxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499508; x=1717104308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XrUpXca9802sFKQT7AfZ7CKYtJZmtjejh5XLUo9IF0=;
        b=KlQvW136KS5EqBDgoUhsKaCC7k1ldu16ydQZr9Srbu59zOInEICOQG+MbxnciTWmpW
         aRYX8r7G8Ljhvudl+YlDa+3PAi4RLAxKjI8uDXVwBn6JBmCvoRWerKdwfl2L3JqPS+aF
         p//wNz3IxnOf7sd681db2ppQrXkzawCEToQALv82nJ93xL4236sOKARNmyFYW6QgrEnu
         nEPNGlhx4whNV6fOLd8YNY/UWZhWOzMo7RDJKNwm4OyvvgrvR1wZzNmgDZYb1G936vZf
         7rrFXUSPkreuuJw6hJ0SxFUjxzWxKx6jtPfMtQU6kLim9FNH1tNgVYEg/EvITpVitPHW
         k9ng==
X-Forwarded-Encrypted: i=1; AJvYcCXQ0dHRfIzxZNCufSD+oCWahD4TSSEknM2eXIUZGUrEFArvAttKCtqMdzfpIZQBWeFqIXWAB+G/ZZzD/riCUsbbBSvql2Aa/RL/0TR02j7aN+E7epFS7AUGAyyVxVF3z+eselIK61fQFONg3AJz68+YrMW4jfKxq/Mf25syIt8=
X-Gm-Message-State: AOJu0YwFDrH52VrvY3tcS6QPR28MaJBQDBEHiv2NijyMRWG+VT1DHwgA
	AAQT5Pt7bmGpCoWmLRWkr2CxCctpyuhh4JzrwB9zxbXJgsml73Q3BtZ4nM1OcfI=
X-Google-Smtp-Source: AGHT+IE4ZF7YwPw/mWOay+kpzwUrwzKsb6QybtrfGC+O2j+H3UcZuYd1WN7BSIQJtxcLnjxWBzuU0w==
X-Received: by 2002:a05:600c:19cf:b0:416:88f9:f5ea with SMTP id 5b1f17b1804b1-42108a0b891mr2885885e9.34.1716499508043;
        Thu, 23 May 2024 14:25:08 -0700 (PDT)
Received: from [127.0.1.1] (84-115-212-250.cable.dynamic.surfer.at. [84.115.212.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae976sm2522955e9.38.2024.05.23.14.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:25:07 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 23 May 2024 23:24:59 +0200
Subject: [PATCH 1/2] cpufreq: qcom-nvmem: fix memory leaks in probe error
 paths
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-qcom-cpufreq-nvmem_memleak-v1-1-e57795c7afa7@gmail.com>
References: <20240523-qcom-cpufreq-nvmem_memleak-v1-0-e57795c7afa7@gmail.com>
In-Reply-To: <20240523-qcom-cpufreq-nvmem_memleak-v1-0-e57795c7afa7@gmail.com>
To: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716499505; l=1662;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=O2/sXGTtESOtbSq7nRlWfIJXUquoXPpq1fCAs0u7NWM=;
 b=hDXfjlz34asjTGVR3glrM/1HXdLbwypLizTciKHHFWKpI2h6eO4bLt/MURAaJw3ZInhw0nxXn
 h9HLcnCN6PqB1VB7gSJwJib40hc+bEr9Yzu0qewfbFqYyHaqIDJpaTK
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The code refactoring added new error paths between the np device node
allocation and the call to of_node_put(), which leads to memory leaks if
any of those errors occur.

Add the missing of_node_put() in the error paths that require it.

Cc: stable@vger.kernel.org
Fixes: 57f2f8b4aa0c ("cpufreq: qcom: Refactor the driver to make it easier to extend")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index ea05d9d67490..5004e1dbc752 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -480,23 +480,30 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 
 	drv = devm_kzalloc(&pdev->dev, struct_size(drv, cpus, num_possible_cpus()),
 		           GFP_KERNEL);
-	if (!drv)
+	if (!drv) {
+		of_node_put(np);
 		return -ENOMEM;
+	}
 
 	match = pdev->dev.platform_data;
 	drv->data = match->data;
-	if (!drv->data)
+	if (!drv->data) {
+		of_node_put(np);
 		return -ENODEV;
+	}
 
 	if (drv->data->get_version) {
 		speedbin_nvmem = of_nvmem_cell_get(np, NULL);
-		if (IS_ERR(speedbin_nvmem))
+		if (IS_ERR(speedbin_nvmem)) {
+			of_node_put(np);
 			return dev_err_probe(cpu_dev, PTR_ERR(speedbin_nvmem),
 					     "Could not get nvmem cell\n");
+		}
 
 		ret = drv->data->get_version(cpu_dev,
 							speedbin_nvmem, &pvs_name, drv);
 		if (ret) {
+			of_node_put(np);
 			nvmem_cell_put(speedbin_nvmem);
 			return ret;
 		}

-- 
2.40.1


