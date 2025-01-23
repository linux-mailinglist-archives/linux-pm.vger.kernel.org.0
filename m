Return-Path: <linux-pm+bounces-20867-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B12A1A373
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C363A998D
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA4D218592;
	Thu, 23 Jan 2025 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JO7+CGEc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E339A217F56
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632388; cv=none; b=KCFvLI4bGLGZ0rf/C/P9iYzoLLNO2dZiG1LjE3K0m1M0Mu4Fif9OmzwTG7z4WFTb46zz2qAULUPEb5waZ88ixCKlGemhEm6nnUJIQ4cXjoYSjhdl9SkqnhrB1WpeHOlKpQYEdwPNsqcN5QDY3JXrvSMYLeOEWwY2aJyBNT7l5WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632388; c=relaxed/simple;
	bh=qdYaBq1Q1yEL+rIvhlhaYVfASvfIfTKZczb9vnsCgp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ncDTeEC9OFSE2fRgvPpkUySLcUhHgzBI1XdwU4exRVjW8AosijdFp5Sk6ibQ1EKgw795KZh7srpUiAqwJjzJPNi0CnovEe3LXIYz9Z3vR6zsPqCiplwov8oTiBFGyUC2LopMNrnVgo9ibr5Rn5zc52gFnMU2Em22GUROCH/fAwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JO7+CGEc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2156e078563so10102465ad.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632386; x=1738237186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZN744IIikaolPVQBfMUPuwC2jdu5k0xBOOUnBiu/B0=;
        b=JO7+CGEcnOHTFFWwDCWD3e8GpBvtcCB8GNiXsofXpG4oPow5l98Qlkr/h2sFZ14pM6
         VfUq0/xzalBj9JQBI8X1wz7pniYshz7A9elNoV9dklRTzx1kD0DlDZwLCbGO3xuEWqj3
         a/8MWMb5CTVVlGzbEc+tTsYS2CHLtd7rUyI2tDenKtUZ23Pf0eIMIm/+aJhnEECQAvRp
         nqgB7FwgrepKxSn6s7njdR/o95bYVu5Z0XNbJauRwtxxwQdYF+GXXstZXRGqOiG8Tpem
         YaxfbQevPWRC+6QvUGePXeH1PDWXmLGCDdSmCgSWeKl/7bzcbmYGsOZbS0GtVLOH1EZE
         HeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632386; x=1738237186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZN744IIikaolPVQBfMUPuwC2jdu5k0xBOOUnBiu/B0=;
        b=JQvIjNp//s/Jflp8HHFnszbke4Uz8SpsXq1taJuLtodtOxWoFcj+16eTFKLzZWQx+F
         mcd53sEZXOpUqxG/KYb9evdgm9mCX+49c0mpp6Ry4xazHP9jHsQxJTe6rnCkKY1+/fvB
         EJWLQPu1wEoJlx1qWKAwZGL3N95Chk9ct0zZ9gQs+z1CcmO5vLwYDLmFvi59QviSiXZx
         T/NUa/R+lVya32bLFv3J4kPZI6c0xRae+e9pmQG852BfRbsXYe3ZykOOwxPUdU2VnSAv
         Tft21NBNGjqMl/hRckDsSF4oy+tiwWPrGI+SqZaW2CUCXMt4WvnoqPhqmpkwtbt1KLVN
         JuZg==
X-Gm-Message-State: AOJu0Yw0jer6rYKOU1C/vVZjRvVdGcZ3r3MaoHzRoKZjC2xCD4e0edkD
	EoT6JKsGHG+ZdF8Q/E6QF4/bQfPsemr6Aa3T0FQhm7lU37dMaRLuvg4HcwtFxZNoAw+CDDHN7f7
	h
X-Gm-Gg: ASbGncu6AmXAFwi+NN3a5CcdOYcuMRmT8EVtCW9qKQdYvkX/InTkSEDhkqmBJ3IRtmt
	xbcjmMr74SnocdW8myMviSY4sZBPZGLpG4NJ4+e1LiLtom5XJAhGHeh0pfJwOc81RiEX/C7vWMv
	0w0QS5hZH8NGI46gADJQR5Ay7E8TWwsxXM4aVPO/uY6Ae7DLHnB4NLkfXlKZ7/rH0Z+K8S4n8G9
	pUnmguP6ZSlM8YqNugTDfSsbQjV5HY9xAJ8TGHjURSW5MspjGS1ERg4tk0IrHyqsAoASWNjBiEu
	jFYLfcs=
X-Google-Smtp-Source: AGHT+IH8bcJpDg4V5yC0nWgdxJWWOCO6JUGTm1wcRp6iDPkksvPd9U80jdnIZi+pnk1nG+wxG9yuSA==
X-Received: by 2002:a17:902:eccc:b0:20b:8a71:b5c1 with SMTP id d9443c01a7336-21c352c7d0fmr420284665ad.1.1737632386324;
        Thu, 23 Jan 2025 03:39:46 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cebaebcsm111592955ad.99.2025.01.23.03.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:39:45 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 31/33] cpufreq: virtual: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:06:07 +0530
Message-Id: <fc10f1fb7bcf3b7d760b12e59f507f8bf92197e6.1737631669.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/virtual-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-cpufreq.c
index a050b3a6737f..45becb92aa4a 100644
--- a/drivers/cpufreq/virtual-cpufreq.c
+++ b/drivers/cpufreq/virtual-cpufreq.c
@@ -265,7 +265,6 @@ static struct cpufreq_driver cpufreq_virt_driver = {
 	.verify		= virt_cpufreq_verify_policy,
 	.target		= virt_cpufreq_target,
 	.fast_switch	= virt_cpufreq_fast_switch,
-	.attr		= cpufreq_generic_attr,
 };
 
 static int virt_cpufreq_driver_probe(struct platform_device *pdev)
-- 
2.31.1.272.g89b43f80a514


