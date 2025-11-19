Return-Path: <linux-pm+bounces-38225-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3A0C700BB
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 17:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 192003A1DA7
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B0B34104B;
	Wed, 19 Nov 2025 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW355J+o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804A933A709
	for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568915; cv=none; b=P96ajT23Mzo3Do0vlsmJRixkTemXRVDn6lxgZX3kBFLYnJsC+Br/2vYKHj5pZcoog8DmvjlxQTVuMDpDa0kiEF60zDV0ovQWXaAyKM+8JSGVDAxOll5GpCq43XWU4tX3Bu5NVS2WICTJ1L5iYMIQTRowzLFwMV+wWuU3dHtKN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568915; c=relaxed/simple;
	bh=AMdNulyF90GrvI5jQcaBWg2EmKy8e+vZRCvSarDupCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y1R2k7mJmJDjYd23YKto+xTEaVHabQZ77cp3cPolzXcZDHM/br0ysCCEUrvQRp+0YY0wcRfkNXCt6GxCHM8ga3B7XQwb+91QzrQftDx1mBZrlgUP7Jyqi8PvDUatuZTq6+59YYbVRTM1Ogvk/qv1lnOTaTbvhhTXyXyCyqyT3jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lW355J+o; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-450c65f3510so1476742b6e.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 08:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763568911; x=1764173711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e80F78tGX2LDToz7bK2BI34KnSoXvC0PlnH2InXNg1A=;
        b=lW355J+o3sk1TkHt+GCvE0vPL9mujSIZb48psD/DWpzuQFArDbiJwly0fzMdkDg9Vs
         PEIzrAqdXl/Q3RsYIWAhoCNTtZMsPo0tjnxHyPCyhRFeUtqUklga1/vvQ3vgb+gtm141
         7BtfmShJxfhoBLw/qPFcROfR6mBbnOuIHetSowLYQTonIvMrWqSweLNDDYQzHZRuOImr
         asRaGDKQ4Aawufy2C/lZubijJcNX5wv+y6quwLlqLCYc/nVDUApbMWqAz9jDOYc/6020
         HL5h92QLZwqmsIlpxx3EaTgdX7Ao0hRKDSb43YxSiP6SdIKYPuKMhNdI+xLZ86VtRHhs
         cR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763568911; x=1764173711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e80F78tGX2LDToz7bK2BI34KnSoXvC0PlnH2InXNg1A=;
        b=bsB82Qm7ibxNMnINSJtku1hXCi4X+R4G0vSRuFvXVHsWoQ0Uq9Ht+E5PhH6knPAcnm
         OnFWfZbpx9aUHWaaqE6+xikoZKkgYYrr80cfTbr0qSZsJmLLMWhP03Hch2by0ubC542S
         mfvq4ussc4wNd5Sipc5Cj43N/QxRiy99kOQVzXQ8KL9Ff3J7stm/lZ48Y7xjLRJy6R3I
         0+C6I1h1/jnUKOT3TKO/YVm6y3/9W2s9Rl0+AjTbY29yKIUJs9RAXoRfs1Dh2hMGbdYT
         OnIe3cVbtLQElhHecHQo/wp2r19sIB2RQizyY+6TYFCgsWJXGLS07AwUobQ7Jfrdkp55
         1gZA==
X-Gm-Message-State: AOJu0Yxtbc8wPM0PlFGBE+XzMsqFViyur0vc4MTA8xWIsDX7EJ5DqXsg
	qfRkOHoQ9F/IwP2zR0oQvF/HOhV6f9ZCcHd+fqqrA+08eiG7PH8O/0vR
X-Gm-Gg: ASbGncuG2UgACp4zYCnbP2jkLZaEuYlRa7a1LDSTed2200fAujVPmapDd+UPusf/wtD
	yLle2FNBfJuSfg+MyDH++4Mjy1QgXMreZyVsJkv1QBlUAwleyGu2A+EsSMjqtMBBoNQxVP5DN/l
	VshBFsIPKsRfU2dHdw2rgySQ/sR5qNTQPiNa+2dEq7jOkINzJWt2p5KRmf/eBpDS5fw+1kKwrFR
	wuSnKeOcvhmuCxL75UAtWgAGTHkmuEsu1zJ+jfo3tlzvOuFKfgCMilGBY5RL3onndzA/uUP7oFV
	P/9pqLB8KBpRMCF+A5+lL9J72Wykb4kwYIk8RPN839CEfXKGsg68mQMgeyMuPh8hm1lPhcnR/8+
	8yzuCgGU6QW9ddqFdFDS08sO0jYEXtcDfzb3RkIObSFvN1LRAF/jgCNkkW4MqodeqLnFRuPSW2m
	OVKA+mrjW+
X-Google-Smtp-Source: AGHT+IHmGw+4XAxkYHJ5VP5usTst8HwpuYqHgoe7VU2Udxe5jCgmbNdyEhAVl0n5UTd0Eq4ol2T7Jg==
X-Received: by 2002:a05:6808:6706:b0:44f:e1af:21f4 with SMTP id 5614622812f47-450973be299mr8872450b6e.4.1763568911386;
        Wed, 19 Nov 2025 08:15:11 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65782831ed6sm11213eaf.0.2025.11.19.08.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 08:15:10 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org,
	jonas@kwiboo.se,
	pgwipeout@gmail.com,
	finley.xiao@rock-chips.com,
	kever.yang@rock-chips.com,
	shawn.lin@rock-chips.com,
	sebastian.reichel@collabora.com,
	heiko@sntech.de,
	ulf.hansson@linaro.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH] pmdomain: rockchip: quiet regulator error on -EPROBE_DEFER
Date: Wed, 19 Nov 2025 10:12:50 -0600
Message-ID: <20251119161250.60885-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Change the dev_err() to dev_err_probe() under rockchip_pd_power_on()
to prevent errors early in the boot process when the requested
regulator is not yet available. This converts errors like the following
to debug messages:

rockchip-pm-domain fd8d8000.power-management:power-controller: Failed to enable supply: -517

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 1955c6d453e4..3c84a65de1a5 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -688,7 +688,8 @@ static int rockchip_pd_power_on(struct generic_pm_domain *domain)
 
 	ret = rockchip_pd_regulator_enable(pd);
 	if (ret) {
-		dev_err(pd->pmu->dev, "Failed to enable supply: %d\n", ret);
+		dev_err_probe(pd->pmu->dev, ret,
+			      "Failed to enable supply: %d\n", ret);
 		return ret;
 	}
 
-- 
2.43.0


