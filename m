Return-Path: <linux-pm+bounces-24945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A52A80F51
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 17:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8D787B8FF3
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 15:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B74C22B8A0;
	Tue,  8 Apr 2025 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kti8LqJJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5B51EB194;
	Tue,  8 Apr 2025 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124666; cv=none; b=smOkkuvSwcVpjXsqELiVO5B79R+ZtKSdX2pjK0ZgmwNjZMvjhredsWbojilLxfwnKVCQVwg+/a786ZG0Q6Az5G5WAwiy+a0rWAzUkwUurIX2gwN6qsQdCr1cltXjmmRHVOoUL6zcah9V5gkvyI99/xVWq3X5c4IKjs+qyMcwCZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124666; c=relaxed/simple;
	bh=0idBfCTzKenTxIiSwgSu/KdenyNnfTy6Efd7dSG2ssA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YO5rqUwwPAfNx/7IwFva8lsOM2WU2r96iZJ5+CEcyRPDaEoZxxR50n9Y623iAEgpSVbRcTM/i0dtXUYbWhivKK6UI3Ti70vCheDsOCVsonN7roT881lGJyJBzJ7UffktSM2fC5iVrjQ31n4xGk8W0tU/+8uK5vIlPtSBuz2gQBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kti8LqJJ; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7399838db7fso5134960b3a.0;
        Tue, 08 Apr 2025 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744124663; x=1744729463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hW0uMB23s6rTN+79K6wuOhxoVdGvng8abYobjgd2dY0=;
        b=Kti8LqJJze+WRxQ1rmG31G9KAtsEOF2oSivBpKHgAsE8cnV16wdW1tw6QTyUkc4npZ
         UN65CsEkICj6nR+s5l1XhYbx1CEgV9a3SsddDg1bEML6t63R3VcPQac2rehXVVuizGdQ
         MBkMCpyFp/CJRKN+D0y1i/fS5yigH/NENkupU7+EtgTfVsnLR1J0bkkKowD1rDTPbvJk
         2utHrp8+iju1Wq/3Nb9hCLq+lVnMD5yIY44NgTHnJ3ejSJUotvN0gAOLfYZ0gamX+wQ/
         5Z2JyIKUdnJyF27x1V/hAMcaXhlG077nWme9TXYkKLtwYj5Dzhn+xuWDAqs9IyZM/Me1
         R5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744124663; x=1744729463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hW0uMB23s6rTN+79K6wuOhxoVdGvng8abYobjgd2dY0=;
        b=OwK/vTDCp5x1kFskCkQkZMt2IufC8yssXszTjuhslWFJ7gG1SNtcpJkKraIs3Wgq2g
         oAUzn1/770WhfpjhRZBg9LcLLYYY0hIEUMCV3DdjGBmyLSVza6LhcVpS9jqr3zWJxtX7
         TE4qw5cfBu/1fltqqM9hR/xHiQR0wU7zepif5IooR21gMHKgo6X6lN8B04U9gzT2RcTX
         0/Zqkhg26eOvLgFgHebevpBq95U30jSvxCQAN6bwQdTn8q6ULokzMrRw+mwkib+1Btdv
         PKgH94FFmivUWZNC+LY8iJPnC4fmaikuk8DvuiBtzh4kpjc2/eHTa0EkYs8OQ+I13nmG
         cvVg==
X-Forwarded-Encrypted: i=1; AJvYcCW/88P7nQzSZd7eAmRGIxUoM0JiKv6y8MK4uRKpqSQcK0d+JUNnzEKY+kLtniqLq+en4KvlpiiYQxfu2JA=@vger.kernel.org, AJvYcCW7ZwFfrLCdE9mhSowBw4NFdSp8Vci6GlIhK+PLGxSNRUQG5BjuwusybuM+gPY+sl4P9tunuBsbDZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+UznuYE/FZwCkMnbWpIhwAeBC5RmGsnvAiQbJepYv0Moby2Qp
	lZohrCSoeHOnYvGO2g/SvRY7gBVP1Z+cjNrNT4EuUxfmI07rlzuF
X-Gm-Gg: ASbGnctl/X6bN/IIbiTchp2Oo6O753pdvVWAAx5ApNXkDzPQRdFc572Z0Q2FcZciCSJ
	UGxAhT4RPK5Nlmuma9KfQLo5khQ7ubXu3SLRYJfWIoTQjK+j+mWM+9axFRVZXpl4rTsWRitgwn+
	tfol3sox6B6CdZAK8O88YjcwKfgo5TSxJuRxPTT5Xl8/e4PSKxK4bWy2Dqmj4AgZP3FeNlXVj+r
	IrV9ocb0c4A9X190zZZXrKMXqbn1JsEXWMS8Q//fczU0aZeBnsls18ALck1p+1Jioym9QTM7UMi
	9YYSttmwll19KgPtp85Z9KwIukqNoA6Ou1FkhTzBL0IaGEHu8mOfLJ6RHkLkhaKH+zcFCZ45xFC
	mwdzWhw==
X-Google-Smtp-Source: AGHT+IFcrw32IadEZbTZ2yTefdbGLJ4deVn8ImGq3fcHBOxM9j/Ojp5mMqxmgwQ1EbK8z0e1SyOJQw==
X-Received: by 2002:aa7:875a:0:b0:736:b3cb:5db with SMTP id d2e1a72fcca58-73b9d4019ddmr4916731b3a.11.1744124663010;
        Tue, 08 Apr 2025 08:04:23 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea097asm11068474b3a.90.2025.04.08.08.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:04:22 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v2 2/2] cpufreq: scpi: Fix null-ptr-deref in scpi_cpufreq_get_rate()
Date: Tue,  8 Apr 2025 23:03:54 +0800
Message-Id: <20250408150354.104532-3-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408150354.104532-1-bsdhenrymartin@gmail.com>
References: <20250408150354.104532-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpufreq_cpu_get_raw() can return NULL when the target CPU is not present
in the policy->cpus mask. scpi_cpufreq_get_rate() does not check for
this case, which results in a NULL pointer dereference.

Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V1 -> V2: Use `if (unlikely(!policy))` instead of `if (!policy)`

 drivers/cpufreq/scpi-cpufreq.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 17cda84f00df..dcbb0ae7dd47 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -29,9 +29,16 @@ static struct scpi_ops *scpi_ops;
 
 static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-	struct scpi_data *priv = policy->driver_data;
-	unsigned long rate = clk_get_rate(priv->clk);
+	struct cpufreq_policy *policy;
+	struct scpi_data *priv;
+	unsigned long rate;
+
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (unlikely(!policy))
+		return 0;
+
+	priv = policy->driver_data;
+	rate = clk_get_rate(priv->clk);
 
 	return rate / 1000;
 }
-- 
2.34.1


