Return-Path: <linux-pm+bounces-30904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCC4B075C9
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 14:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94441C26363
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 12:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6422F6F8E;
	Wed, 16 Jul 2025 12:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFUkxBhg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D042F5C41
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 12:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669231; cv=none; b=C8LSolL6hZLOw30imyJ8kX7YQ++RUHgCdV533UMBUPHn2J3HXNt9dnpWjyEWO3FMSnWNEoJVkVd/GhPI+9hLGzXsgclWGMuI4GjqRJhY7qY3dYMQFifkYEWhLK+6WEDwdzvsNF14hMrPyrb9GYvfViL5mqVsbRRjCVWduPSGyqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669231; c=relaxed/simple;
	bh=l66YMhhyoUq/kOfTDxnT5FpNrTVvUcvvqXdHjhPBswk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQ/64DRVRPUumhsr2YDqXH5ZB9MOPEgkLQlcq3x9enbOR3TR0WH4KXTOPgQT1WQ+e6GKhFdfcETmPlvnjfljReAHxIWXCPNaITHizwJ0cn24nVAQ0cOLJiyIqMT2/1LXfC8mOmiMUr/XmCVT0OHuDxxuyJSXwxxds9sMDDLsCMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aFUkxBhg; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32ce1b2188dso57639131fa.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 05:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752669227; x=1753274027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORFGIaRZiQ2r3h2UbbHLjv8bRy43CZUiObx53cFsM7M=;
        b=aFUkxBhgTyF/UQHnbpmfylEUNpw02hm8LMViJ5VkKE6YZQMU6IYkJc/8l4MM00W2sv
         I7eVY1GehR9QwVAEmlgTTtWam1bhjuTSIPt6qxtO3wcEEF7bm1LhQJoXxY3lIbRD2Pke
         ogXd6mJWED68dK0X2OMorVo21WH+J8+lBf2a+WRNhO1Vg6gNBFFkJWjjjmIBcT/lXI58
         k8Cb+od2DMnbW2cQCyVhJRZz3CvUN1GCWWt71zUXKtDtTTsg3IT6Oey5S9PbVuotuZSt
         hXzDwY3EUudpXw/Dt74oQ0BefwtJH8vqH1kZidJvsSHkwbKGafjjX8NXaLoVdQ5o2cMC
         j4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669227; x=1753274027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORFGIaRZiQ2r3h2UbbHLjv8bRy43CZUiObx53cFsM7M=;
        b=kSzCI6aUJzjjEzhxZB0e0LPLYaYRJE/GEQs5eHElO1k1UeKz90VewO0nefmCCa1iyg
         yHfOquUGOnSs2ksE2/TBJivSYFnlKkEcOLkXn2n5Sn2Ce1m4a5X+SmCocgk3fjPGV4Fm
         FHyy4cGBnFB+74OKOsf2x/usNiXRYfULPRUEIyuYbr3a5q2m7oVYHqC1La/rK5fAGh1M
         Ieoic3giJujNveBLYucSVXH6ZCGof/fsxEvyZ34D7U9HVrGPJ9RZ2ame9XQNGGrV2pwv
         VsBVkIoVvV8YtagGYDxGxmsNaQh9bY4BXQXsUK5mf3PwCHzjGv0zjI4HZcZ7M77qxJ6T
         OVaA==
X-Forwarded-Encrypted: i=1; AJvYcCXpeAm2B09gU0Huc1lt8RKPSUlOi1SzrGxKVQAYEDmRy2yS9LOS3oYOLhh5mrgHT2znqYSLtFamig==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyU5g3gwXGBiKoCCDdFgqvev+X6T+0pgs2L9vkLF46yt+tYj7X
	rt2zkxVXoWCEBcXMacZVaImEaBexr3Hd2mvYvfwHt2AsAmqA5D/vAxIEkByEuKUFgYY=
X-Gm-Gg: ASbGncsA06BoVa2PrcX5ti8eDC0WfTah6fU04R6q8bQpBRAQBicX4F8fVyeoqG/kVk8
	ArAu8iykKzWSj8efsTGyVH6xZRiNF1a0V618ZoMCXWys0BVT6HOeUVTnTvhZn+ekQCUwQk3RjGz
	PVAPTVwJwnbIgzRNebuQ4Xnmq5qBVYXia6Oqyisxg0rY6jHFBpMD7gcJT6rhKgoOHRV2OMe8OP0
	V+DDfNhRhVg243ihWRDvlYPwW/7gDq7X8lfUYlMvdM1Oh7Kn86tMo9uUAmmTiMCi3sGXQM0tmLO
	3l5zArS+kEgpneWS8+7Fb2s/4C2dR8aMEfVG+AiUSnrXowMyM5ZUvkRX9T1ExKy2E2zKnEktGle
	hiru3u7nsN5jT2UR4EXw9YIZoHd2d8YRBKqTF83s61DU1yl7yurxnChSDDRscS4LFcyax2TeT
X-Google-Smtp-Source: AGHT+IHApt9dKWWo4VZfdfPAEXf4QKxQRQ/nikIwYXMJa5THXkanpElGwpOalL+3xkUK7ywi2MDTCw==
X-Received: by 2002:a05:651c:1a0a:b0:32a:8297:54c9 with SMTP id 38308e7fff4ca-3308e34fc82mr10139451fa.8.1752669227417;
        Wed, 16 Jul 2025 05:33:47 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa29134d4sm21136211fa.22.2025.07.16.05.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:33:46 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@baylibre.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Saravana Kannan <saravanak@google.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 3/3] cpuidle: Respect the system-wakeup QoS limit for s2idle
Date: Wed, 16 Jul 2025 14:33:19 +0200
Message-ID: <20250716123323.65441-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716123323.65441-1-ulf.hansson@linaro.org>
References: <20250716123323.65441-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A system-wakeup QoS limit may have been requested by user-space. To avoid
entering a too deep state during s2idle, let's start to take into account
the QoS limit when selecting a suitable low-power-state.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 0835da449db8..5f6dacb5b134 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -190,14 +190,15 @@ static noinstr void enter_s2idle_proper(struct cpuidle_driver *drv,
  */
 int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
+	u64 constraint_ns = system_wakeup_latency_qos_limit() * NSEC_PER_USEC;
 	int index;
 
 	/*
-	 * Find the deepest state with ->enter_s2idle present, which guarantees
-	 * that interrupts won't be enabled when it exits and allows the tick to
-	 * be frozen safely.
+	 * Find the deepest state with ->enter_s2idle present that meets the
+	 * system-wakeup QoS limit, which guarantees that interrupts won't be
+	 * enabled when it exits and allows the tick to be frozen safely.
 	 */
-	index = find_deepest_state(drv, dev, U64_MAX, 0, true);
+	index = find_deepest_state(drv, dev, constraint_ns, 0, true);
 	if (index > 0) {
 		enter_s2idle_proper(drv, dev, index);
 		local_irq_enable();
-- 
2.43.0


