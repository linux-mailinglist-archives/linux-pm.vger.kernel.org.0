Return-Path: <linux-pm+bounces-8091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FBA8CDBF5
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 23:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E397C1C22FE6
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2024 21:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE97128377;
	Thu, 23 May 2024 21:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzaeEZ8P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8ED128375;
	Thu, 23 May 2024 21:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499513; cv=none; b=a+FsRNjBOywwzOKo1DoIbA5hv8YJCTG/Va1fEHn2aSfxyBXaTMZPtQn5U5wSHGfoOukpfxLAuuUtc2hBe0Wk1yVN33BN9vuuUrBUBbacLe7t2QlSMDi30CK1IQ6JFqlXV4bNogm1TxK//TOUO/P73n0LRx7V+IP4hdbWEhj4k0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499513; c=relaxed/simple;
	bh=6gMDag0IBE3/Dtgu37LmaX1zY0IArivgLqDHwuWD/PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HAh0csMW4tlSnAZT7+b93lGWEcir6q0Mlq4eKgVovfXmB1IxNAZzYCDGgsPsJKRd3BG8YBp3zh/kdZi1sX1pnTn6vtmaaZmz5GNhzSDxF6oOl0p7xcofWcHH5zZ6d1+l4TSyn910jBO0eoJXkMqdmXeNdudJXFbn5smFxDexNLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzaeEZ8P; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-421087b6f3fso2393425e9.1;
        Thu, 23 May 2024 14:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716499509; x=1717104309; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19nJ81IbZdMF8t0gAmZF3gea97mrAihPPznRZWLIEpI=;
        b=UzaeEZ8PXo4YI93mKHUdMI2P22CcN4PELy3TE9JQdHI9/x5qI77a/9Wn45PYOhuZU/
         VCIWuNw5i85cdJatiSmGlO8vs2QjEyVDdGODUzyRwykaXInokNX/t22d4AfsUWzuXzy4
         p/dZAgUHk/4p7AJEmBJ/VjfbqqoeYNtWlw8DKXsn/LEJQP8ST2LGfrJyWPh5OfS8Pi5Z
         gZzgRYo+Z1HYq1VN8a/OnMyD1GkTOWUB/xmcg0Nd7yFnnmJWM1FHjqbyhVQmJWz4GwCK
         Ep9pJrpTc42ufMaNtDgQcqLwhf9AOaQPcs8v89hXUIOoFMUk5sGWSVec1VnYtqS95IyH
         WJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499509; x=1717104309;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19nJ81IbZdMF8t0gAmZF3gea97mrAihPPznRZWLIEpI=;
        b=lFGK/iurrOPQ/mefXs668NCPOish1y24sdjO2tP5Zhgux+unV5McF7opwE9XPBMzuY
         vU80ZS5pHpyw2M9XaQ33u6GKF+a3KOEabmiFu/Dvq2uxXh+2TlASIJ7rHq8ITcNDX+5D
         QTWYJ0UNH02d7W+PXpMP/pkdxwc2D1YhSREXXIQ++l5Tx7bemDcDmPE9YaL7eXFJixl8
         ZyjBQDWEb3INpse9eusLMK7JR2NwdNXWXgm9oBFTaUB0Sn7xo5ieRbh+G/mow71ilM6c
         y43p6cxZsvvjoh1PPf1FERn4i1Jdg2/ul8LA+cgFJo70+5Z8sGOcT5yAp6tp4mtxe3KR
         HsZg==
X-Forwarded-Encrypted: i=1; AJvYcCWKEq8Z+WWKLoot1DqjdHQHo29X1YH26FHH2pOD8DnQPcDfX86q0aR2sz2NZDKsC6QJgSfKYniG1a2J94sR1lsumCx3kZtKWgsnuIUaTjHbMFu7zal2Da5zWOn4hhwYqnqdr9xqqjI=
X-Gm-Message-State: AOJu0YzWpJSigIV1UF1EV/c0Potw3W/a9bZZcBpT9QJ0zNAGrQWLn+TU
	cyKqCocxC5TZEiZPxJFSQ7WFTGGPzc2ruBcTZYBu4pHP1zBu7uuuFP/LXvMuAIM=
X-Google-Smtp-Source: AGHT+IENW5nPyGPQwYAj+VFP8s9e+Lia8VUh5UdAtDJ6gqFlLidE3jjeARjPRYKh6wPvYAmy4V9Uxg==
X-Received: by 2002:a7b:c055:0:b0:41b:f788:8ca6 with SMTP id 5b1f17b1804b1-421089d3a7emr3181235e9.8.1716499509277;
        Thu, 23 May 2024 14:25:09 -0700 (PDT)
Received: from [127.0.1.1] (84-115-212-250.cable.dynamic.surfer.at. [84.115.212.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae976sm2522955e9.38.2024.05.23.14.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:25:08 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 23 May 2024 23:25:00 +0200
Subject: [PATCH 2/2] cpufreq: qcom-nvmem: eliminate uses of of_node_put()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-qcom-cpufreq-nvmem_memleak-v1-2-e57795c7afa7@gmail.com>
References: <20240523-qcom-cpufreq-nvmem_memleak-v1-0-e57795c7afa7@gmail.com>
In-Reply-To: <20240523-qcom-cpufreq-nvmem_memleak-v1-0-e57795c7afa7@gmail.com>
To: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716499505; l=3086;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=6gMDag0IBE3/Dtgu37LmaX1zY0IArivgLqDHwuWD/PM=;
 b=1X14HdRwItlzvBF4/8jTH5oGmp5k0ilwAg4PmKnQ/+T+WpLTRgSj/VDrkFniAKtTf6nycg7v7
 UzNGwnTpqqeBPyUfZvaxnXV4996lfMDaGUDVVIoi2eqOhNbnNZZmWCc
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Make use of the __free() macro to automate memory deallocation when
the existing device nodes get out of scope, removing the need for
of_node_put() and therefore increasing code safety if more error paths
are added to the driver, which could miss the required of_node_put()
as it already occurred with commit '57f2f8b4aa0c ("cpufreq: qcom:
Refactor the driver to make it easier to extend")'.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 5004e1dbc752..716066423b92 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -455,7 +455,6 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 {
 	struct qcom_cpufreq_drv *drv;
 	struct nvmem_cell *speedbin_nvmem;
-	struct device_node *np;
 	struct device *cpu_dev;
 	char pvs_name_buffer[] = "speedXX-pvsXX-vXX";
 	char *pvs_name = pvs_name_buffer;
@@ -467,49 +466,40 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	if (!cpu_dev)
 		return -ENODEV;
 
-	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
+	struct device_node *np __free(device_node) =
+		dev_pm_opp_of_get_opp_desc_node(cpu_dev);
 	if (!np)
 		return -ENOENT;
 
 	ret = of_device_is_compatible(np, "operating-points-v2-kryo-cpu") ||
 	      of_device_is_compatible(np, "operating-points-v2-krait-cpu");
-	if (!ret) {
-		of_node_put(np);
+	if (!ret)
 		return -ENOENT;
-	}
 
 	drv = devm_kzalloc(&pdev->dev, struct_size(drv, cpus, num_possible_cpus()),
 		           GFP_KERNEL);
-	if (!drv) {
-		of_node_put(np);
+	if (!drv)
 		return -ENOMEM;
-	}
 
 	match = pdev->dev.platform_data;
 	drv->data = match->data;
-	if (!drv->data) {
-		of_node_put(np);
+	if (!drv->data)
 		return -ENODEV;
-	}
 
 	if (drv->data->get_version) {
 		speedbin_nvmem = of_nvmem_cell_get(np, NULL);
-		if (IS_ERR(speedbin_nvmem)) {
-			of_node_put(np);
+		if (IS_ERR(speedbin_nvmem))
 			return dev_err_probe(cpu_dev, PTR_ERR(speedbin_nvmem),
 					     "Could not get nvmem cell\n");
-		}
 
 		ret = drv->data->get_version(cpu_dev,
 							speedbin_nvmem, &pvs_name, drv);
 		if (ret) {
-			of_node_put(np);
 			nvmem_cell_put(speedbin_nvmem);
 			return ret;
 		}
 		nvmem_cell_put(speedbin_nvmem);
 	}
-	of_node_put(np);
 
 	for_each_possible_cpu(cpu) {
 		struct device **virt_devs = NULL;
@@ -645,7 +635,7 @@ MODULE_DEVICE_TABLE(of, qcom_cpufreq_match_list);
  */
 static int __init qcom_cpufreq_init(void)
 {
-	struct device_node *np = of_find_node_by_path("/");
+	struct device_node *np __free(device_node) = of_find_node_by_path("/");
 	const struct of_device_id *match;
 	int ret;
 
@@ -653,7 +643,6 @@ static int __init qcom_cpufreq_init(void)
 		return -ENODEV;
 
 	match = of_match_node(qcom_cpufreq_match_list, np);
-	of_node_put(np);
 	if (!match)
 		return -ENODEV;
 

-- 
2.40.1


