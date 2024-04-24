Return-Path: <linux-pm+bounces-6965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 348338B00C1
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 07:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DD72B2264E
	for <lists+linux-pm@lfdr.de>; Wed, 24 Apr 2024 05:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D56A15442D;
	Wed, 24 Apr 2024 05:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tkRHMfXa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CDF328DB
	for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 05:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713934957; cv=none; b=Kb1YRgSRpWpni0cZwX4U8w+0SF0Zd9RF3ZPBSnfbORotoqPwLSkJwI0Z+Nez5EPfJooKeKVTedmjG+09J6G0/+gEIyfMCBJMi81NxhrxZAjEcF1VyHa38mvsX8bwBPcwafo5Z0jjyRrLqslTsD2+YeBbKOu6vUILFrjEv+M1z6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713934957; c=relaxed/simple;
	bh=x37nCAEtkzKmnw2FIwieCR2ee+0AhiENTRGgvvQ3L5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LDZXpzi/4TXP+xW6W8CRsMA2C4scTtaMbrX9eLsBE4k7cI0F4OPqZGAfLzAz+7HD4p5DVNweFCsL7iz9TMqqkw+ZXCaSS/dsR7cntZ6bAr9JHOnW5UUsuvOt+rTXJOftw1iShce+6Yg9BJ4jNurOnk2RQEFR+b6rSP5pCFfI08M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tkRHMfXa; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 14F863F15B
	for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2024 05:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713934947;
	bh=5qlSwbqn0yKjajOnnokLTupGDAbqF62Q3ztb6vzSw9g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=tkRHMfXaYWOXt1er9T+rgsJXe04Q8TNg1adx5kR72Tv1d97IcMV+td4Nme4oyztPg
	 yW+LJ6JlvDuzZQlzCy1H2oJZQI9XAWT7GyddudfPv3eSqXWkYBW4nG1mqk5l9L5f6w
	 uJM3VPk71WCpMOPbL13Qm6/HNtbvAIo67c0NU4ufbffF3uddKg8+O3vLwQIg9+IPre
	 SwYmtAIhu+gc2vroiDgI56Tlf3aeuz/lFs3abF3WomVOcd68O6aoWQrwFhJ/yqkD1o
	 sC0pIZdPKBp0riRAqZgkiravS4FrxPwwXaHVP6zOvJdz13OE6Dre+e3gnx7lGNDgl+
	 QxVKtOUMSd6zQ==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1e8bbdc13f9so73174315ad.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 22:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713934945; x=1714539745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qlSwbqn0yKjajOnnokLTupGDAbqF62Q3ztb6vzSw9g=;
        b=kFUpCwY9zDnFVAOM/BFyErmctl5g48pGbxEB45MC2XUMPmRhkfWRXfpc+SiaOkmaO/
         h8wRs8aHREhOI85tXoYqINf5ZTduVsQHdaHN91U6H5roVZrNWe4SEN6j+TF8ic8U29+Z
         zCF57KkPzwGWtN9sbAA7gs5PnOuo+5dER2nfXiJ5JhCjtoNT7AzCLbUNOtGRN6fyAWWi
         38rBTJItH8cpmuYnv5pRXVvEmlUVuPRmPqFb8LMj+8q/tSixWRmJS+FGHgF0qnMpIOAK
         OnA4LScIvsgNeQxXH8KUUWWs33uHrxyePYsgEIp9HOYZV6qzPbDIgRq4Vt0NZyvcC036
         wl1w==
X-Forwarded-Encrypted: i=1; AJvYcCXhawC0dVzbL2nPApQVpY+i2y7+ZLRQjsJc51pGvs/eyAlRQwM2xljCYyOHhvDdr5eFZ0sW8NhIty5vmiajMH2hkHGEsuexD3E=
X-Gm-Message-State: AOJu0Yz3vvPq0/BDV4xXdduf0iLakC6YXY3ewtaEI97Lmaw314cGSbAg
	4TZskkkh04c8NdQDXZiafCcEE/6v3DePQZd00tV+3MDvctOjqSOzkzeAwgykemLFByQD8y3/Oy+
	DCER44H+kGCNUCB+m+UkxJ2WYFwUA9+WiLfmC88jmmUNhRPdpLR+k0BpdmBEa6olkuOmY9F8S
X-Received: by 2002:a17:902:d50e:b0:1e4:3ed8:e264 with SMTP id b14-20020a170902d50e00b001e43ed8e264mr1931935plg.43.1713934945429;
        Tue, 23 Apr 2024 22:02:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfx/iKCRsXuYaLjisAIOV8TYBxO7/bFDwJ1MD1LgF/g+Q24fJgz+P7l0mtak8JWPQHZ4SQhw==
X-Received: by 2002:a17:902:d50e:b0:1e4:3ed8:e264 with SMTP id b14-20020a170902d50e00b001e43ed8e264mr1931921plg.43.1713934945079;
        Tue, 23 Apr 2024 22:02:25 -0700 (PDT)
Received: from localhost ([159.196.41.205])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001e4d22f828fsm10727496plb.33.2024.04.23.22.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 22:02:24 -0700 (PDT)
From: Portia Stephens <portia.stephens@canonical.com>
To: mmayer@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	rafael@kernel.org
Cc: viresh.kumar@linaro.org,
	florian.fainelli@broadcom.com,
	abelova@astralinux.ru,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stephensportia@gmail.com
Subject: [PATCH] cpufreq: brcmstb-avs-cpufreq: ISO C90 forbids mixed declarations
Date: Wed, 24 Apr 2024 15:02:20 +1000
Message-Id: <20240424050220.889814-1-portia.stephens@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a compile warning because a NULL pointer check was added before
a struct was declared. This moves the NULL pointer check to after the
struct is delcared and moves the struct assignment to after the NULL
pointer check.

Fixes: f661017e6d32 ("cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return value")

Signed-off-by: Portia Stephens <portia.stephens@canonical.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 1a1857b0a6f4..ea8438550b49 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -481,9 +481,12 @@ static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
 static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct private_data *priv;
+
 	if (!policy)
 		return 0;
-	struct private_data *priv = policy->driver_data;
+
+	priv = policy->driver_data;
 
 	cpufreq_cpu_put(policy);
 
-- 
2.34.1


