Return-Path: <linux-pm+bounces-19102-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C719EDFDC
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 08:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5F1282689
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 07:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F84205E00;
	Thu, 12 Dec 2024 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bqmtqtpd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9207205ACF;
	Thu, 12 Dec 2024 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987095; cv=none; b=Uty/TryGCwEXCUA6uS+M/zOGn3zI5xQcOhORHONpuX+eyOtAIYaWjHzBI/8FCpMYwPwoHa0IhqQCi5L5ej1kGj5e7XuR7QKhy6y5g3vm3A2kzTE4R8IkPEN9g6kAKno5+6ZsOW0wMTThoTmamb2PoPyKyLcPolEfB1i/4kxNd9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987095; c=relaxed/simple;
	bh=xZAYewJHUZWNR4AiiFT7ZCFsiAmElXgtdpZlXkHdURc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZ/GnWvnQlds38IAxBgfbUG49Seq6kLHCXYlCqfySDyn1ZR+Ua1nK+7JXVPzwCG35IqRQ3xBmWOOgrwISYAQfrZfPXDoauR7gVGEku8rFcGyorTMG6rF9I6yYMcFczCLEq3LJL3bBmRdgxzX1KPK6fRWmQpngeMTZjaLHBiEDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bqmtqtpd; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-725f2f79ed9so202701b3a.2;
        Wed, 11 Dec 2024 23:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733987093; x=1734591893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbzFAeUuXXanJwe/RhcZGcox5IaVXp9hGHM//yffMwQ=;
        b=BqmtqtpdBm2wiLsk0hCyF6emLX+xT254gVJDSSzRB3g0BzhjDB4MdKvypvSO/4AMpQ
         ODiJ6gukVifGKxQyPIYnFfMg09d/jjYu05b3NhQgU5uc6INbJ16AKC/aB6RD8QmsvxOj
         uimapykIYm05rpXKBZ+i0xgA8/uGNOVdmDfpbOueA3VceEZEU721HftvbH/yrRJFRWKv
         Cdvt8gwZ70QPNeAfIJ+uWxpqrk622gWpWewZQQBTxqHZRX1mhSIQhuyeeu5UQU6Y2cVA
         CIM1LIpGeu/m/n+DoITvcvUKkUJCFKo0XBg6g9BJq6ANlXFYr7O/FJILoT9fBFRuBE9E
         WA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733987093; x=1734591893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbzFAeUuXXanJwe/RhcZGcox5IaVXp9hGHM//yffMwQ=;
        b=JfFsFj8W3u5+4KBMrEuk0gcOL1NeRcmUfUVDxBOYB4YbytXwTp7tkvsSEIxTweoPor
         6sShOd20IZk35543V0/VQ48TXNpgbS3KDgmgQ5KxgxqQ7uzf1/eH/m5nd3+UTAfGhWDQ
         SDhRbyWqw0O4K8AY55+ZqhpZPeH7qov9Dx+mqj2D2s51E2nOJ1MaKGWoRJcJo4lSsd1t
         mt4v2J40xkgeTKieZ3z5YsvHZCh2IUhcyEThEMS2fRFo17ySu/cEKSXBCIRzwuG9JzzT
         ifwrDG5rJsHGfnJr/ZboDVL1XrxZA57idy44/YvqCFWPDg9axPFmxImm4lCSgc57pfUi
         T6lQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4Y9b08ub0U3oDTAPa+vkCFsCf3c8GWRh7ZAZWslh1VeXwYpcWXCCglEckBFM1Yhx1wBLD9QZgRnOP2akC@vger.kernel.org, AJvYcCUu/UfTGyriShFheY2SvvVYlautLZvo7HW7+V3eF6yAbl736io5B4ELE4E4/7s2engTn9FHCJHKJNg=@vger.kernel.org, AJvYcCXoAV8KK+XyITjwi1RRLoNaCdLEqgHJVVykVjYW9n7OfiEBkTvsuEKAicH5KDuLo4gKzeKd5YQ8LQ5i@vger.kernel.org
X-Gm-Message-State: AOJu0YxmmyzDN/0WM9r0rKLQhwuS6RAE7z7HygEEtFW1m2gNQFlHSUww
	UbP+pOyFF+5Sg5jjtgVUQ0D8TRrxJzaNIkS1SD4+f5niVOlHGN3j
X-Gm-Gg: ASbGnctlqvpRw2+/Dl7aUEcoAmhzWbkh18rvfj+91wXyMiDk4owZigCW/W5GQ5AgcoT
	7a9JfqGwLYvbDpCD2KCkKiLfLFCtxjbFy1zJ/e7YKaDnD8cuUQOybr9MdEGPIboVBUe9W0hqDpN
	OwIr0InzsBy/jOjJ8G0htJtORYwfljz8h6/xYKNmJwpptSbxm/vPeehRYya6hHchclYM2A458ou
	bxCSSi6C97zXNXmkOuGdzqg0WBKYIa+0zW+W+4e8Mtoh/fLNKlcWVuS8jqv7Ghf2y2ciB9L
X-Google-Smtp-Source: AGHT+IEmXq444oBwmD5u2gt6hQ4Y1b6qVPA6zh/gRHg0XG/Uu/LCdJJ6Nmc53XVFX072F+jsIRC8gw==
X-Received: by 2002:a05:6a00:3e09:b0:725:30f3:67d8 with SMTP id d2e1a72fcca58-728fa87787bmr2990369b3a.0.1733987093085;
        Wed, 11 Dec 2024 23:04:53 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-725ee10f928sm6519386b3a.32.2024.12.11.23.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:04:52 -0800 (PST)
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
Subject: [PATCH v2 4/7] cpufreq: apple-soc: Use 32-bit read for status register
Date: Thu, 12 Dec 2024 15:03:03 +0800
Message-ID: <20241212070344.3858-5-towinchenmi@gmail.com>
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


