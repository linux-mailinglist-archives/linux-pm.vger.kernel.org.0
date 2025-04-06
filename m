Return-Path: <linux-pm+bounces-24865-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12195A7D03F
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 22:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CECBB3ADD69
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 20:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BAB1ACEDE;
	Sun,  6 Apr 2025 20:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FB6H0U0o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E7D1A5B9F
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 20:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743971258; cv=none; b=DcBygpOsYb22APzritPyXujWUwz1D89ycKXfsQDPsvDpE9WunH+6m0+xz5UmhkqEJRsrJ1hxlhnbEsggKDn87UhSS3l5BsoXXb0oHybIBT/Tk+NSdBvqKUX6EPcKaOKMVZaqDosZr+ljjo/gp3aLzlrPoEEWYZz89/uM6Vo7RdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743971258; c=relaxed/simple;
	bh=jplvHvGl30e07hKf9/3qdUUYwxMmtiNSbU6HW3csuuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8uEme2Wg7Z+wF+kWulsvK4N1tMI1teBrl6cZnqpsVSfGt3JTnceFVVERp6Hg933+d3gwERYPNwyMm+7lkDuuk10dEYkk6nZZ4OdnzjudCOzxa5NtG7GzhVLUJu4RtbkJ124FtZt4BS7RmAtXMXk0qRi6edgFYiUjG221a8xf+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FB6H0U0o; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3978ef9a778so506266f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 06 Apr 2025 13:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743971255; x=1744576055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTRHCroqU6G8v0HJ3YcuO4l6Qf+wdw60CAB5xH0Xlog=;
        b=FB6H0U0oJ6diFEBkQbBlUHKH3awvdFuyg4nImcx/TqUkGzu2LpFPjOiRhXDb8pIQ9q
         1SO3yuQ+VwXZkFz3KAn+S/s8XmvwgQvDm6y+rq6NKONmi0le8Y2kTzOaLURJjMDPt19U
         y2dt+GlHFL66f/rz7OHXU35yEP2/p87mw9vhVLu1SLkRkK0NRrxhQDvtHDe2w0zg7DHQ
         wTRz6915bsJyxt5sNS5SJPWWUZ5NVSSi+0qLhVO5JVUdUfg/ZfS1S0GJYSUlPn0Y7pJH
         AHs2qawgUj7ED2V7d55hEQqwhyV/MOUSLlo6W59qi5/lNuAsf3sIvIMXCPOCwMMueIlG
         OZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743971255; x=1744576055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTRHCroqU6G8v0HJ3YcuO4l6Qf+wdw60CAB5xH0Xlog=;
        b=gY//obXqaFLOfXwv2kwtCEJBUvWSXGTUiWUcyQMc87q+84wtZWjUGD6LXWr6FQFioX
         WGC7aZ+KQ3k64zI/HlpUHJFjIvbEIToVMyJAaZ/tCIxFLDHdPMYEW0TySBZqNpLJeFTu
         yTnLZHuWStTvvW5PHfNOCg7JmqLd1T4DcXxClRNkddGyn+5vQMUbrfalO9F0VOtxa/Xb
         AiGKQw9Y6C/7rdSrcBrFaBiZhi0/SMYaHTZgzNyAyr/lqmSOG+bLWDNUn+44oKbir6/f
         NhCw2NoS5yvIw1VKp+QmXrJVr8dKX88+Xmk28vDNCOi8hUF8h2I1lUbk4G4aDDXIUozt
         Jc8A==
X-Forwarded-Encrypted: i=1; AJvYcCWhl4tZPci6WWFLG575MJSSMnhpyiQdlUpON7nAgPOhPV5nDMwZPnqp/co+HzbmkG/D6LLbT/lT1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTLQXp35dsoNu+fQszLj0bVWDPtJas+BNRthVT+dKcB/NtRcl4
	wwv+dn90KfH6i9msJC0z/N3fMNjzv75HOvMOPG9tmpKBdjKpzHUa/2aDdhGINQQ=
X-Gm-Gg: ASbGncvdT7EUH2SvOH1eFBhXuQsYAv+LPGOQ6PBhHwvi4DM2Raz6Nyu4DlW0ro8Ko2R
	ep5r4Z2aqFJyX1iFY29CUd/7XzbLB3HKQSinrrzKmf6dzZk9fg+G0FYpZnfqYj4exLKWyY8k3w9
	hB0oQEoT4DsCL7nHPgGFTofzNhCRFRbVyZLgOl/vOy9VSPM2meKSqKnGgtWDbRGiiwcZwt3nXdz
	ulTCL+ru5vjS9ZCSSSg8bHjY/mzRpKkRDjB/MTQOdqqWALrHvW1XnU8iWkYjBpR18qv7rSfU0po
	oh7Td6VRAZoT3GhEL0fnRTwNHOAKudxMRrxUlP64glPZBZh4WHi0zw==
X-Google-Smtp-Source: AGHT+IHBPZmuSi77aH/gtx5jaiOFfnhyy6YC06F36BleT4GspLq39QjbR1wa4JPuEuq7P8cBwX2+Vg==
X-Received: by 2002:a05:600c:5247:b0:43b:c228:1ee0 with SMTP id 5b1f17b1804b1-43ecfa45bcfmr35267165e9.7.1743971254779;
        Sun, 06 Apr 2025 13:27:34 -0700 (PDT)
Received: from shite.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1663053sm112207355e9.15.2025.04.06.13.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 13:27:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] power: supply: gpio-charger: Fix wakeup source leaks on device unbind
Date: Sun,  6 Apr 2025 22:27:30 +0200
Message-ID: <20250406202730.55096-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250406202730.55096-1-krzysztof.kozlowski@linaro.org>
References: <20250406202730.55096-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device can be unbound, so driver must also release memory for the wakeup
source.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/power/supply/gpio-charger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 1dfd5b0cb30d..1b2da9b5fb65 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -366,7 +366,9 @@ static int gpio_charger_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, gpio_charger);
 
-	device_init_wakeup(dev, 1);
+	ret = devm_device_init_wakeup(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init wakeup\n");
 
 	return 0;
 }
-- 
2.45.2


