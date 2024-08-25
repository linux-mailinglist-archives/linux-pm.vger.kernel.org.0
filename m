Return-Path: <linux-pm+bounces-12865-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD8695E4B4
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 20:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F432815D8
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 18:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45A5155757;
	Sun, 25 Aug 2024 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ln3bzkiZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8F81448C5
	for <linux-pm@vger.kernel.org>; Sun, 25 Aug 2024 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724610683; cv=none; b=rVJD0KiL3V4NN9t9QFxFmY93MFlDnOKR52jbuBdUxI9XMlDC3F4OOnt0WquFHt2798YTBNrIKRqu6v3XQy3UPuzNMrwsxnUTVYDeav+kJAE7uLTC7yD/E1gPXNnlACmsc8DwaYuth+Eixgnb99XQFNkG+UScNFOy2TYoZMt1E0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724610683; c=relaxed/simple;
	bh=0mfH3d3fWKDRTMp6AgLA8pqVSbXOcj6PsmBXH3W5tUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i66jPkfPRiynSWEBdQN5OcvneP6gQCYXcnxPaTRGIv3StZ87fr0fbzpyq0//xo3P9Kl7rcde+bbszlUOrprOjP2mVeMdFdHyH12s+PEh1WYkO/pzDWI+mqWMP/mghc2Tpb8JBOGWt8qkrcgnK2pOhhnP5////u9/dQ8Aw30DZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ln3bzkiZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281e715904so4124315e9.0
        for <linux-pm@vger.kernel.org>; Sun, 25 Aug 2024 11:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724610680; x=1725215480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r5oZsSpqBtpVnxWWek+saFNNQcQXhk4VKnzKr/UGi3k=;
        b=ln3bzkiZWrP48+LIQRaA+K+nYtZfAZUoXjE4Q/NVXCstI4CVW1RP3W27vFKUhSblJm
         QlAukDNhO7ZIc1VNtxn+LGwqs44g265E2oBtizAhv13LOE74WTSWeyGS7tggHdG76DUA
         IetR3X0yTxiVFyobQbtDYJ8l0U0qMDjlNonwvx8QPc29T5FBvaIqLzlSqOAi55Xra+SE
         eaVpicsny/ZQNZQpHP7RtjEoIIkMSNCnrBKbAdDKhHOvGNTdTIZwYdaZBqpgFb27dZa2
         D0XuzxYNmzxPuDeEteObpmmpJKRsWIl0UtphksCiXsxaZK8FqBpuNmJliTNPv/XgQja1
         GU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724610680; x=1725215480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5oZsSpqBtpVnxWWek+saFNNQcQXhk4VKnzKr/UGi3k=;
        b=Pfy2hT4AzAxxvfeGxXJ5RkeyS4q7aZ7Dmk1ioXsLd9v0asLiVCrfaU+9C2i9GYZ4Ep
         jkeRYFmCq8EeYWnKWBoYP6LNLmTUWeBUuVPl5MbXzDW9kZ7lozeVV0xfP5SgahAurszS
         GUeMVwCkWkD8i6VJbUlOkfci54LVHW4niPWBfGXZ6rWw7l+5pX5yFVKdPegyUE0eN3I8
         e289fIq58dTO10D7tojQ5u16g6MBCzhScifWdGeAAdypYo6WfduBNz4AQ8DIe30Qk4GF
         W2Os2ZNZhrvM5XqC8/xknAQ9n6qu6MEQdElRL/lkgxbYe6DR60UIZPxfLssBewMHpnoe
         P+4A==
X-Forwarded-Encrypted: i=1; AJvYcCW9eQZ2BxOQrpEwOzQiOYDIJyO4gwHkhjXUGQTfyDgiOnKesTMiiX/mo5lQkxlb5Lyzj21McCO2dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuvRCZRU8H05IK8EGlgx6NE9c631tX07zoJYfiXpEgDjXpDkII
	sgranOlm7p6t9MxUZuQbYsYIKuGyvwCM66GBqJxDVs/EY1Yo9gfjOJ6rKjJsZC0BQst5VIP7ekB
	J
X-Google-Smtp-Source: AGHT+IExUeevkTIQSWB4GNDROugF9P/4Ht1vXHY2Hj6A+8kgBoxqFRUstIlxcvyBnYWjZpE2OjAmHg==
X-Received: by 2002:a5d:5f8b:0:b0:36d:1d66:554f with SMTP id ffacd0b85a97d-3731185d6camr3061819f8f.3.1724610680074;
        Sun, 25 Aug 2024 11:31:20 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730821ab05sm8937319f8f.98.2024.08.25.11.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 11:31:19 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] pmdomain: rockchip: Simplify dropping OF node reference
Date: Sun, 25 Aug 2024 20:31:16 +0200
Message-ID: <20240825183116.102953-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop OF node reference immediately after using it in
syscon_node_to_regmap(), which is both simpler and typical/expected
code pattern.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pmdomain/rockchip/pm-domains.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 64b4d7120d83..5ee7efbd2ef8 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -716,12 +716,11 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 				goto err_unprepare_clocks;
 			}
 			pd->qos_regmap[j] = syscon_node_to_regmap(qos_node);
+			of_node_put(qos_node);
 			if (IS_ERR(pd->qos_regmap[j])) {
 				error = -ENODEV;
-				of_node_put(qos_node);
 				goto err_unprepare_clocks;
 			}
-			of_node_put(qos_node);
 		}
 	}
 
-- 
2.43.0


