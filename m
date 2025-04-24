Return-Path: <linux-pm+bounces-26131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BECDA9B3CA
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 18:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B2F925875
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D379E2857E4;
	Thu, 24 Apr 2025 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Czv/FUBV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54E828466B
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511637; cv=none; b=Lm4kNJa2dw70d5avA6IyNLyuFItKtzgMJjWoM/LSagiMVb/HRkLkUat6S2A/qqs1waP4zWjQ4IUqYG+65aeBtHIGyadma+oG/akfZiieJDllAXWyp65pgiYWiZKDjt+HGbh/ewakaCefXHoPrV932wPft24Y50corkFuI/pnPC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511637; c=relaxed/simple;
	bh=N86G+xPvh3Fs6OA8eDZ5k/0ObrQcBlpZHqZBKD5QejE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RiyeHXudrXleb6XNap5lN+0huGsczt0y3MIShSYbw39ARJVyM+qdTHUWGj++6a1lF9C6DMy8SZFt+sT7FO7QC5A4bPKdueoJuyGDEdRXDv1ducBZ6c6HRseZZ03HSCmd0xGGrALF2jyUnjfBDMn3jhkWOJYWRy8Ih3O8FUZB8g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Czv/FUBV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso1640512b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745511633; x=1746116433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29re1A6IAQcw58La3we0Qeu64CWcO3h8durF8s3FMdc=;
        b=Czv/FUBVFtDpsxyQt6JZM3F3PhUj1i65g3DJlWttU/PYQHRSRFkMbt6xDBTBFHdu7B
         FOlSWPD/fmgkcacag1ccoIU0hAHvu5MiPo9WADLP1PVXUz+f1P056PQtPw87PhD5GIKu
         mYtkyucrqvFrysNVqLQIR1yYsPKgA/KPkglu1sgmYdKiY2mufI9GnTRsgYhVG3oUWhC3
         khwdzoWy5BjOr4/LEdSrER1LtdGSu8+9/UPoKVFCnjol9BDjGE2j+fi50Y89VB+eX+cA
         HyS79E+T8e53Obvw39zb5YsHPJmWIXKLEr6hFKGe1nXI869aQ6b8l2EzgYc5Xfo9kld/
         op9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745511633; x=1746116433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29re1A6IAQcw58La3we0Qeu64CWcO3h8durF8s3FMdc=;
        b=qZLhRuzU4PdFs4PA/CHY/9ipyn2U+2+xiozdGJ7XGCa+0fz1clLJUVoaWcE4GZ9HQq
         04OxmS93BNXY0AsIJbJw2twCRFKbbXfqS6NTHj89KXwunRPrHixhuXax8++vjFpfNfHR
         EHOZ0Ehsszousc1Q5ekFSq+0d81TsTW6sDd9jLaTw3PxxrBjXJMcA1MV7tpVGJAPF6W8
         TyarFI1xTkhvzH2PiLmE1+EYAP+6yrcGS4kqz5ZfI4kvn85L9c7htzEXUeX0BpwWZOlV
         GwYHz8JrLctGk2qP3vJNxgXrFSxplbJ+8hIiTUhubg830P2HOVW5HuawzEl2Bc+9kwPy
         I7dg==
X-Gm-Message-State: AOJu0YyccWoKAC3eb8F5Bju+93tT1GjrWyTS5wHqXA2UVPIskLFjb/fs
	x+DSHtcWrwyN9aE7GSKdLZhvoPtn1J5GdCNGnDlTkMGzqPEf8W7Y5rSwPMIJxOzMyhztcLC7CjS
	L
X-Gm-Gg: ASbGncvISs0YHeU62tXv79BSzD2C1PlP+R4ye8AIF3uwKK3xHwx3sh0pyU8PlpNPHpg
	mnmMMs11B0XSj4dBi4VnBxVT8frPOG4w4UM/mkvOBPL9gsqeXx11ijzGawLh3hVUwmyzjrfVrxY
	qUtntrtPQzJH498eZNRUMDJaqXhowqLJ2EbhJ170hLHMFCx7KT05S0q8BI5pfhZtldDNN/lP+ep
	IJGA7ajKBADFtFPpViEA4xvk7BE3zlsKqhtvDz1V8pxnaVCTBdsZF6ZnF9haIpVXP8qegpQzc1J
	BMW6Uc/gey3VY5YuZ762XOI1iIXwtv0Z7UnGJwa0ag==
X-Google-Smtp-Source: AGHT+IG578Ic64K8QbKa3qjFUhYhINjMm+PC0YZTjvGdvoBcCT0kxu+uUXe6zvVhuX1i3Rbt1n0WTQ==
X-Received: by 2002:a05:6a00:3987:b0:73d:b1ff:c758 with SMTP id d2e1a72fcca58-73e247d7bfemr4497488b3a.18.1745511632704;
        Thu, 24 Apr 2025 09:20:32 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a415sm1588401b3a.85.2025.04.24.09.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 09:20:32 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Nicholas Chin <nic.c3.14@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/5] cpufreq: Don't unnecessarily call set_boost()
Date: Thu, 24 Apr 2025 21:50:15 +0530
Message-Id: <3003fbdcc1850128fe7fb653d7ddb8afc4d66170.1745511526.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1745511526.git.viresh.kumar@linaro.org>
References: <cover.1745511526.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The policy specific boost value may already be set correctly in
cpufreq_boost_trigger_state(), don't update it again unnecessarily.

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 3841c9da6cac..e31891c7b500 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2861,7 +2861,7 @@ static int cpufreq_boost_trigger_state(int state)
 
 	cpus_read_lock();
 	for_each_active_policy(policy) {
-		if (!policy->boost_supported)
+		if (!policy->boost_supported || policy->boost_enabled == state)
 			continue;
 
 		policy->boost_enabled = state;
-- 
2.31.1.272.g89b43f80a514


