Return-Path: <linux-pm+bounces-19440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B7D9F6D4F
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7767D18904F0
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 18:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB321FCCEE;
	Wed, 18 Dec 2024 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/PWD7hM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A551FBC94;
	Wed, 18 Dec 2024 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734546554; cv=none; b=Mii+5itOr0FieLOerEaOoYapnl37BfcpVO7diXMmZWMtOI6DP+El6ilj9aeqldA7Tbs1neQaG99a88E5BHZopYLUmCc4TpEtUDIvGhmiRyhh90jhqCkRxDiWz/hDEcwUNiHE7VCmGrTufnMYWpkeGkIO0a7XFnKbXxbMAy6JVk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734546554; c=relaxed/simple;
	bh=xZAYewJHUZWNR4AiiFT7ZCFsiAmElXgtdpZlXkHdURc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVcj2w0NCieoDUxUlBzF3js8l8kMknFNhgsv6fkQPmmhGoR9NR8y7gTBInvIOarw5Vs2hAb5Bi0MaVxfrysTBaBpUPxn+cNkZWKwiaFeGSUT3y96rJ8VdwDmuUuuVLyhqFdcZhyDjGP2LWccjqlIG5i6ssERcKDa/P68SCyukM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/PWD7hM; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725abf74334so6076295b3a.3;
        Wed, 18 Dec 2024 10:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734546552; x=1735151352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbzFAeUuXXanJwe/RhcZGcox5IaVXp9hGHM//yffMwQ=;
        b=G/PWD7hMU4gyVKd01udc4zkDPgVjB6LOkIW0RyYnsl2kwQFg+7A9juyJCcXr5BRao2
         FrsFAItexpyM6rs/s6YdYi0RTQB+9gUZyFTL6eYGXD5TSgyFjB+SWHzKBmEDCNvaig6S
         8JEJAaUAYbK0iNOhN0+tEss7/2zJnJFawl0ImaE9M+/1fPQeVuoG+3qb/kCtMnGsgQrm
         zfMKXtv0jfTp0bEdCvgOCICnHkAJegyYCsxXuU48R4Fy5JW7lEJPRse7G2u4MandoKIA
         lW/K1b283Qzml6K7vwi8/1yS6sZSvcmYs9+0AGrBNvyUZNrKax4TL1RkOwGn1qmfAWrF
         E/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734546552; x=1735151352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbzFAeUuXXanJwe/RhcZGcox5IaVXp9hGHM//yffMwQ=;
        b=MCThNxh80GE/FYgolmzH4pHzh2z4g6mpyRBNUrIzdr9oLw1GAZHtnGQmBIK8zUa1gd
         woaaIixu3IWSr4sI5VVuoyVD+3VhYKDVedWsIHyH9dHTk9YGK3NYZcqKKKZbB9d1tUfT
         6kzLlFsqmvQvaMUX9lO8hep5nbkcVmWIXiUdZncwqdXOLKuzsk5H7ikArCmSIeRHmzND
         BR8CerQiPKHRpLqJNSNq+cPtm5IFKs9jgwL5SCwKgTX5hg6Ki1QnZOlY77yjdDH7p8jD
         Z1zN0CHWH4AO1je/AQt16RLIn9QIsQ+6wP1Aou0TsR2u1wx3tSXUQsSYJs+RhFSZbRLa
         /HwA==
X-Forwarded-Encrypted: i=1; AJvYcCUtnvs4wZmBVa2MVwaw4rUDJa4SH673Bgx0cSFYdthv8vPpNWks/J1pJGmPIn/Oxl+odc692vawmZp+P4Vi@vger.kernel.org, AJvYcCX4/zrg3fqjDhJ4GpIsIzeq/ZPCQmkYyjKzV4oXNB5HcxWCvyUg4k3ELV3vh+A2BqUp4aQZy7EaqiUD@vger.kernel.org, AJvYcCXfbGS46xdxjSQC+hTRwHM4HyMvXwMKjzkM82E/AYILztrNUXcTYxpA2pM9neSQAYjiNhDalDVGs9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGRE6PzkSuHR/eMPKv6qaBAu0T+n6cbmUXL5TJ7o21hCws3VoH
	zCtCGb4u4N6L1Pg5hsBjBIXx3zmKf34vtieoGN3vqyOcLmMNhWxb
X-Gm-Gg: ASbGncvVcYQivTF8vsc/VCl5VCHdtIQ7maikRnd0koy6DxRMUyC4u5eYilE80wCT+eh
	V4ZdKbvvcFOB9eec8XpLW5KhAKYaGsjaSsENFk2sVHQsJ+QnOjbOYAzyD3AYV3qZzKKFoZH73kB
	7kfkuzLzsmyCIdR4fwVvpetCRbVHrY8r09cBgUP611tvr3vSHKg6D7Z0JfCVIdbM9oNC5msOc4q
	4xGRsGGjquGOm+rh3qsa0NZmlHjmAvbleQ5g4gEjn4jn5yLGyoubDxPKg==
X-Google-Smtp-Source: AGHT+IG6QDCToV6vGIVydE11zTBp/e2m6aHQJC8DmNhZClGIJeJEeU+1619CoVuk/ihQMDgpM2XnQA==
X-Received: by 2002:a17:902:e546:b0:216:3e9a:89e with SMTP id d9443c01a7336-218d725a7b1mr45675445ad.35.1734546551897;
        Wed, 18 Dec 2024 10:29:11 -0800 (PST)
Received: from nick-mbp.. ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-218a1dcb3ffsm79202565ad.75.2024.12.18.10.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 10:29:11 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Asahi Linux <asahi@lists.linux.dev>,
	Linux ARM Kernel Architecture <linux-arm-kernel@lists.infradead.org>,
	Linux power management <linux-pm@vger.kernel.org>,
	Devicetree <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v3 4/7] cpufreq: apple-soc: Use 32-bit read for status register
Date: Thu, 19 Dec 2024 02:25:06 +0800
Message-ID: <20241218182834.22334-5-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218182834.22334-1-towinchenmi@gmail.com>
References: <20241218182834.22334-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apple A7-A9(X) SoCs requires 32-bit reads on the status register. Newer
SoCs accepts 32-bit reads on the status register as well.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/cpufreq/apple-soc-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 90e34105b50b..b27d261fe5a6 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -122,7 +122,7 @@ static unsigned int apple_soc_cpufreq_get_rate(unsigned int cpu)
 	unsigned int pstate;
 
 	if (priv->info->cur_pstate_mask) {
-		u64 reg = readq_relaxed(priv->reg_base + APPLE_DVFS_STATUS);
+		u32 reg = readl_relaxed(priv->reg_base + APPLE_DVFS_STATUS);
 
 		pstate = (reg & priv->info->cur_pstate_mask) >>  priv->info->cur_pstate_shift;
 	} else {
-- 
2.47.1


