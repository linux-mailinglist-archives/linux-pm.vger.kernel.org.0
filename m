Return-Path: <linux-pm+bounces-19103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448ED9EDFDF
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 08:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B98165649
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43811205E26;
	Thu, 12 Dec 2024 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7clhfgZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5411205E1A;
	Thu, 12 Dec 2024 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987098; cv=none; b=an8qbN6u26a+oZRIWVX2rAO49LR2/WfR4YvcNsHzcSuOOE7uP0pPplVgIQCac92wqRmGkol3TATTwmuT76ifV8QH6s3DEsmqAkl3bYz7DQ82amNwTgrBXU8DlAsiiRAswiCcLXK9WFO49wclux4km8Msmf10q/amyc/pnfDO1Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987098; c=relaxed/simple;
	bh=lSmc5lpStkRdh6T2UaHkJlaMrEahYyD8GNIRGOk35wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Johk3d1fYYmuZ5blQS+wLdmS7lfIyenzIGKeF8alUpYZlnpwWfdyVAJuPOqlnpV/gOpT58314gxgAoFFtmtSJrkprR1uzGhwxw01VQfybYDbcyA33qMJBiFqTvNb5ER2mZhfSoO5EcWKg8eQW1Yuscdpc5KweV4nX2qOXaQ0iBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7clhfgZ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7273967f2f0so294215b3a.1;
        Wed, 11 Dec 2024 23:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733987096; x=1734591896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11W4ToO5h1HZTorB4p+IfX/arkj3h4R3MbzsYg+yGqg=;
        b=K7clhfgZbp6azmVflVUJF4GP9TlgdnmHoEg65VE9QzDP8l2yRq6wTm+ivUGKAYNR3R
         33Ty0PW6fYoLMoLW6LgkMhepjRUMo0eLdj9XAeMDKpY9+xJzDHMHMZId8kkXHPz9w0tV
         QbtD4y4emupRm1A8he8GX053UV/+d16cJJYGoK2r7vDD/RoIi7wUMBDIHWveCXpicj5r
         9/lH2AdPI6ryQmRW5sJNXTY4N1OH2ptmNIByGvgNoB40m5zNQjrTSBKnsRF62rJekvY3
         VhgdebbyOtdkE7bukCSyit/EN3+vTBoGXD/BU+BtduDlPSIc145USUl6tT+s8beabGUA
         KbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733987096; x=1734591896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11W4ToO5h1HZTorB4p+IfX/arkj3h4R3MbzsYg+yGqg=;
        b=Y7iFuMdXqVG5tfHwqmVmoz6T205YBWXo1RssyocjptzcvRTwG2+cutBsmbATAfuGkV
         0odncHElmbQUj1S3TIP7Ipr6kH5jaE5ZGEY/olGsboziJjmvjtpRQZqeCAQLJ+mm/iU4
         8Eav6cUtX+OzDl2QlWcCC+m79eVPVq00s8FOemoy+njoLjL9n01NXAKgbAZZIINd9Y7n
         w49UjKz6vQTqUBOuO0uv4aRFadJJceC5K0HawWxMSyOn3ysnZsYZaoj7yGvigZP809BK
         rU0lCzJEB2W3CJPvMoHZN+D1m4G9nhYUhvi9Qq+UksHDE9F2qttyY9W1NG5y34E0II8v
         idfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDAyw5LdDt/GMUN2Swb/kIcAqWHp0lKLitNL/yoHb/NnTpOaxfuuJVN39PdNsH/XG6Vml6UDxnStXq@vger.kernel.org, AJvYcCUtwKxZuW36DeBuqThOFgT+kmN0nQKVYicDzGc5Gbi9mGRzmvUU5ct8PJHsJu0BeGN6vu2D0o0bKrw=@vger.kernel.org, AJvYcCVYU68U9gDM2umcwIAv6qNfrp12WHe+6kqyMnpfZ1dOxLPAtUsCbCcgaMFnRuLiK3X7dy0bvymd9xrp92l1@vger.kernel.org
X-Gm-Message-State: AOJu0YwSOSsSpTModXwflxSHa4+VCqIWNzCClgBsfi+OXBQ9/4UnEToi
	/HbCDaOV2UKF9GZKYUPIebh0gzpvwkU/yO9nKz9rX/cuntZJamjYCq05QBAo
X-Gm-Gg: ASbGncvxDJgFg85tjrV0CUu19KjhkfXP4zkL9biOD1IZ5szFhGfgSfyF7q6s7laJfFr
	I86MuJkdDiVArW21VBJDjdJo4koALCtXjzGaDxDQUu1jjwoWKbeq0v2qmUxkKFk3kwQL42yogds
	VuSbXO3Yc+9FNgXGpFMMFUbjPtNNOyhHUEWRLyFBLAYzSAXmot79e7C7NhGf+TlbhdskFiKvhdE
	1w6tmK/XCf0XcUTjC97DZmoaf7pfXEeXBlpQw1wrC+Uhza4ZQJA9GPHm6k1H4MgxSXnFS7b
X-Google-Smtp-Source: AGHT+IHKPAp1Y9VHLYOP5k5Lmr6P41gM42/smjErSsBmXsfXGl8fcB/4q3SDqlWrJH5E2MTneTUBEw==
X-Received: by 2002:a05:6a00:230a:b0:725:eacf:cfdb with SMTP id d2e1a72fcca58-728faad3a55mr3591696b3a.24.1733987096031;
        Wed, 11 Dec 2024 23:04:56 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-725ee10f928sm6519386b3a.32.2024.12.11.23.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:04:55 -0800 (PST)
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
Subject: [PATCH v2 5/7] cpufreq: apple-soc: Increase cluster switch timeout to 400us
Date: Thu, 12 Dec 2024 15:03:04 +0800
Message-ID: <20241212070344.3858-6-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212070344.3858-1-towinchenmi@gmail.com>
References: <20241212070344.3858-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apple A11 SoC takes a long time to switch. Maximum switch time
observed is 345us, so increase the cluster switch timeout to 400us
to be safe.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/cpufreq/apple-soc-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index b27d261fe5a6..94e57f055a5f 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -53,7 +53,7 @@
 #define APPLE_DVFS_PLL_FACTOR_MULT	GENMASK(31, 16)
 #define APPLE_DVFS_PLL_FACTOR_DIV	GENMASK(15, 0)
 
-#define APPLE_DVFS_TRANSITION_TIMEOUT 100
+#define APPLE_DVFS_TRANSITION_TIMEOUT 400
 
 struct apple_soc_cpufreq_info {
 	bool has_ps2;
-- 
2.47.1


