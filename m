Return-Path: <linux-pm+bounces-25316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C5AA86E9C
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 20:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E0A19E39A6
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 18:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F84820468C;
	Sat, 12 Apr 2025 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwAL1EID"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF2C1C3C08;
	Sat, 12 Apr 2025 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744481324; cv=none; b=Cycvbi+RBEQjzsQCaIbVjqjUzU2Na4ZXApy+681FLLYQDWXKKO1np92WBUiMKRcpHbFbc3LmRPQvMazEcLOIwJ4Pu0EwfpuE+CGpohkd93CPVhdW+ocQXrLz5dP1s6GjWK+MP20YJ8rfeT+YE/Pwbfg2CD1qrZf3H5G6Moazp1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744481324; c=relaxed/simple;
	bh=WzZnep/f8/LGuquBOWMDrexuXeGdGB0dhZlDwPeDUnw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=be0r3lzFSsXDLnNcjGqwVuKeNn5Rk9haoXKdo1TGSB7kHEPTj2OWcEPYzsLKjoz4eQm8F7afoo0wadMz8sRxweuH1BlARv0m+NPMhCi/ljd3P7W+jJ2VNe0ssstiy+XbMFO12FHmpgwcFryekNC0LGVUOiCrG2JtRdNgS+tu8M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwAL1EID; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-479009c951cso6142691cf.1;
        Sat, 12 Apr 2025 11:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744481321; x=1745086121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8WYvbjpcGb7KJNUByfcTCd3jRL1lDvJbZkLr6wZ/FRg=;
        b=SwAL1EIDZCUaKwMpagdi+APusSh1SahxWwZbY5El2dw7Yxr/uy8VuiGbz4w9R5pAxt
         Tei2hb0p4P4owduRXx9RiBX8leCt+RDxW2HJeluBy15pA5IBg9Pv+jLYfpYjW+dT9yIY
         OmQMrkwI26EsE6wpU0zi7e3eQDxRV3j3YgA18yH4WI53djGL7KdGKF0Ojs9HZv7MR8I5
         Ij2kaw7YmVReNj3Va3E51jq2z51yvHVtnsQk/BZ1lz5n3VqwIfBIB4MCc3G78lXD2bIw
         BY74Pv2AeZjaFls9C30kQMqaZwMr1PXfuEY0pVmHNZW+X8nbsZf5jyLWmKV/uEGj52dc
         kdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744481321; x=1745086121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WYvbjpcGb7KJNUByfcTCd3jRL1lDvJbZkLr6wZ/FRg=;
        b=sFeumiBIrI0HXo+8+KtJso8mtSMhsg7t4g3YZ7F6cokesyzUisH4lM2yC0G2ZKmn5N
         vxV+GqwZb8LDCh+hLEt7D2yxdMNniD6X8iYT2O9Mjed92ds2oPVSfNm3y663erP0AcFG
         g8zl48oSfjWM0o+YvoSKktifyjvabY1/4Mfv3BZvyZQJ2Jlbh69YL9S6r6ZmO6BicBVk
         dlW1tsXXJ4DjNr9CbXR3OzED59LGpeY7W9RlTkkuQLB07Gx12U4eg23N9kjik2rOwzD9
         IU5o7pFCGzYGJyfoh9PMZBLcBewnbF8ZxUCHEkDWHjR8/WkjVAhk5SMmTrB0DBC+HQ0n
         lzgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb2xlQUuoMINLO9ISuzz/J3pS44Vbo1VHxIbMU0dWz+xiPv19uu5uefLeQfo9M9Dj7Wj7gkmRuNV786BU=@vger.kernel.org, AJvYcCWNXa7M9Xcz3qQJtMek7ogOliKXriP6qmf/ROpCjtUw5k424aSqhPTSolsDglrb+B8h7SaPwSCn2FA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx47amOfCariD77+puJehEqH7nfOp1lcuRdOIZh6N5yE7+woQ54
	KXsAsMJkdn0eILoCmu6z6gQG9Q2KXJXsq+Y/jVXMrIsZ+h5Wh/Q=
X-Gm-Gg: ASbGncsmIHBvVpgI8ZjxcinPWXnPOjyAxqkgFAHmApfPwUfws8t+7YZ2TK9Ef0Auhai
	5tea7M6iYQJ3EHQeJuXruWmzVIpuxBmFdR8bRiIQTI3VKMYxN4QkjfXNFzM1uEFh74D0pJDmrdM
	f5jbNeWhHStB2Mv5jQ/FYmWAlY/pCVM49H68oXLe/0EtqmDM0yGbE5Eg0h+S71iaPSxaN25GS04
	CzTaWooQlVKjYWrW8egQruGq02VBfGMRfHkpogo487JSNCGXu8GMfGpN7l45/DzulcWHxVaMhml
	CNZx4bIQzm8P2Z6qXptE/+P/Ea+yImJQuYWX9g==
X-Google-Smtp-Source: AGHT+IGuWwiwV2pI1FQDLCaq7IMqD3KTq9cCIX3peuLBaw7mxQTWHmOu3rz0clb0aOslnkPCVExtNg==
X-Received: by 2002:a05:6214:19e5:b0:6e8:fcd2:360e with SMTP id 6a1803df08f44-6f23f15d812mr34251246d6.8.1744481321507;
        Sat, 12 Apr 2025 11:08:41 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de95f801sm54141916d6.5.2025.04.12.11.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 11:08:41 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] cpufreq: scmi: Fix possible null pointer dereference
Date: Sat, 12 Apr 2025 13:08:31 -0500
Message-Id: <20250412180831.3252963-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if policy is NULL before dereferencing it.

This is similar to the commit cf7de25878a1
("cppc_cpufreq: Fix possible null pointer dereference").

This is found by our static analysis tool KNighter.

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI message protocol")
---
 drivers/cpufreq/scmi-cpufreq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index c310aeebc8f3..ee916ce9b897 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -38,10 +38,14 @@ static struct cpufreq_driver scmi_cpufreq_driver;
 static unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
-	struct scmi_data *priv = policy->driver_data;
+	struct scmi_data *priv;
 	unsigned long rate;
 	int ret;
 
+	if (!policy)
+		return 0;
+	priv = policy->driver_data;
+
 	ret = perf_ops->freq_get(ph, priv->domain_id, &rate, false);
 	if (ret)
 		return 0;
-- 
2.34.1


