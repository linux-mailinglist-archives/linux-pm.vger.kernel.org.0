Return-Path: <linux-pm+bounces-26134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E7FA9B3CC
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 18:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E8E1BA5168
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 16:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1383288C9F;
	Thu, 24 Apr 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ezjT/iNz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDFC289345
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511644; cv=none; b=eyc15yKjcUs+xVEJoteb2hZmYse0HNXpQ72bwoQXndqdayB2/YJ5AXi9ejL+xGersO9IterwuNHRv36cx8fXvdSKMLLokc5Ymx8Tbr0lOpgHLOHGVXZm5mAspq+bRxRSMdTni6qC51rgteJ7sbEn5vnsUhOhYsNf5+WiRHMQSn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511644; c=relaxed/simple;
	bh=sr91ZCkfh9/+1qgwRvc7NFp+/ypX7PeuKKUTBWh2e5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Am3ewCBKmsKVNKBPjtLQgtqLHqYXMEf4cdvOTTrapnZ4UdK0GdZze8T8iBV4/aw5mNAsmbwjgYLdaaY+tWoQtSDiJC1s7bZxRpsI+uunuH/ZiydLkyv+d5kH7uAESbUu5Fjp+sU9WcCkxeDTn9FW2nZXhIR2MYmHpb+cPQ8mntU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ezjT/iNz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2295d78b45cso19647355ad.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 09:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745511642; x=1746116442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSyaOuxRYv6eWeED9vze/Zx1Ra4wgUaI0r8PRqeWN0U=;
        b=ezjT/iNz+b4drFWmN5xEGoQAS/QQfBWV70zcg4XGRg3+y3mb8py47MBHlkz95iwkqx
         eP4pCK26BXLfmDPwJdR9Xjv5y+P0esh6g58flAlhAIjrDpqh26jK6qzeTwBIxhWZ61rC
         6njYkWiHNdIpoGADe0SWeU5Bsk9S37YZAix2SUwEBA4nLAWRppd+/bmFBodDThMJZwem
         /GQDbAXtTaHuAhgz0JsmaOdR9+zDaxFhCJIyYkpbGmJIJAL3uT7Gowg4H1mHpVNXjpfN
         qasDeD6KLxybk0me0GcHOjMtcW7V9+HMxcpaLQlM/aCVn/HXdXxZ++88tqzKUQRBJbjN
         hAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745511642; x=1746116442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSyaOuxRYv6eWeED9vze/Zx1Ra4wgUaI0r8PRqeWN0U=;
        b=VoNtKczRakzHAO7LZFOFCAQHaIVMiCltQjLNhXSwcNAmqLgGeORwUpNUJ6ToRWTpZK
         rBe4GsjSDhKp74BIZ/VHoBln6DcqMRYBPhpTHhej3jM9iw/nLFHT5GGE2OgxmDRgGzcC
         AfFtMYbbHkd4BjY8sm/GfYajCiAx93fa4FMvJ0rFtH/IV1+r98LENNDWgyfyBGhWpPi8
         IQ/aWEOnv86D31FKN1wvENXwj9MhfoSMP26vsKlBcdedTVvqTT/LygWSlljHnvoTDqPS
         3cZ/LsB4oycWA+4K0GtkTHEWDbBDwd8RsMxA5zj159UUeUdGaurN80mQ1TifMTONs52+
         qFkg==
X-Gm-Message-State: AOJu0YzAfiCWrPtPNg7zfw8YLDH8GmuTm9JAlUcAkrUAllUp1BVimN7L
	CHMP4X2UrcHi+kQBcrrKgiFrLHYMJ3/d6vjL3U0O2YIzE9oOtDRQdIVOOp2hUKY=
X-Gm-Gg: ASbGncvTpcCvCcL1tI/mU8U3YN5/FUQja8jNHgzGF3CUt4NGoQg4dhJKFOujAg63Nn5
	kQD0u7zdvKVDewmUCb67SPcKTysrbJnmekZGzt/tEWO0/vptP3DIQMLF3kGCjJDb4QXThy2gAZ7
	w9+RiNmcsPuydOe+9bC30IfGaE+rTHvRkzSQgz8pW8hGT2MhLlnFNSUJIro5dTFkCxuZ2HwUBco
	IQnUvPreSKYTZeWH3PDPzJMFWXzMrMu0aoYjoX1Kk/F+xlM/ByY7anZEFoaf7Ta/NKGVsJBEMvt
	74DvLjq++75Ttuo4mS6vkA+VVnaVKczo1fagPQMQQw==
X-Google-Smtp-Source: AGHT+IEYPSmkALRG18EbLkZ4r4Mc9Zk2ENSNaMuK68sqW3bha49PXaIcVchPcu5dRFET7GZx/n/KrQ==
X-Received: by 2002:a17:902:f64d:b0:223:f408:c3e2 with SMTP id d9443c01a7336-22dbd41875bmr1217355ad.14.1745511642636;
        Thu, 24 Apr 2025 09:20:42 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5216b7csm15475485ad.232.2025.04.24.09.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 09:20:42 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Nicholas Chin <nic.c3.14@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/5] cpufreq: Force sync policy boost with global boost on sysfs update
Date: Thu, 24 Apr 2025 21:50:18 +0530
Message-Id: <852ff11c589e6300730d207baac195b2d9d8b95f.1745511526.git.viresh.kumar@linaro.org>
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

If the global boost flag is enabled and policy boost flag is disabled, a
call to `cpufreq_boost_trigger_state(true)` must enable the policy's
boost state.

The current code misses that because of an optimization. Fix it.

Suggested-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0ad459bc8f84..4ac5d4fcfdd4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2863,8 +2863,10 @@ static int cpufreq_boost_trigger_state(int state)
 	unsigned long flags;
 	int ret = 0;
 
-	if (cpufreq_driver->boost_enabled == state)
-		return 0;
+	/*
+	 * Don't compare 'cpufreq_driver->boost_enabled' with 'state' here to
+	 * make sure all policies are in sync with global boost flag.
+	 */
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	cpufreq_driver->boost_enabled = state;
-- 
2.31.1.272.g89b43f80a514


