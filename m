Return-Path: <linux-pm+bounces-7286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE9D8B5AE7
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2024 16:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7F81C21142
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2024 14:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510AD823CC;
	Mon, 29 Apr 2024 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ynNUlOaN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E2880603
	for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399565; cv=none; b=qM7KjxTZu0+Rg5o0qTS6OZFUIVcw19/9sjUYX/MbShr9+yk9oJxsqEMjfdl/C1/CMijceVZVejpQS0RTUBAwHr7ZCEqNL9jbMYV+2eeAmlILbmwf/OAgmY8r5jQ8QQV7KkT/wEil9Ng4FlIiqw+CRr6LaMmUdCW8sA8Yz8tLRZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399565; c=relaxed/simple;
	bh=bIu8MbW3zdEnNCbcclk/lNsKop9RpekiJmMvuMEBXIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ssAHddAz6miTYgMw3UhLzvVC7AKL8hyCNeXjQFREWpfAGLS0/WXtKV7Kdki2j7IWGA+V8lXsuCavSsk1hoNMDuMoyE7GrzN7GLsthikYDdlmdbJYkKJv1Vf1IhDGZgWj6f084jYfFqm6A6q/oJUt9k0L0oSoc/2AIJH5sje/kMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ynNUlOaN; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e01d666c88so14244501fa.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2024 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714399561; x=1715004361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDwOmSA7MQ7+zytHkA+laGeE0LQljf7L1jWo+P70lko=;
        b=ynNUlOaNVD7iZgypmP3lZCl0KpXUrvNBCUIpdi1Eha1nepv9lFYNM/v1anteWxOBY+
         PIf6WkEx/l3Le/oG4cTXCrbJXluBfipnb+wLin7DhzA1oT3fvN6KhjMlozBoOTNwWHhM
         3J5bK7YUquew17u0XdAY/Y/WH8dfpjj9TqHoNfdHd/R8Hb+j0KwMFDHoQsqQPVSvbP1B
         NjWReMvfvlCS2Q56EM7yt9YN4EPA+2gXxylUSStP5JijZ0s3u5L/dGDx6alA+290oln/
         2LV5nrCr1VS37kQvP/bTzGLJKmhE+80adYj/F0ryZWZIsZez2H/hMVWYHXmoFqX5WLD3
         XOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714399561; x=1715004361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDwOmSA7MQ7+zytHkA+laGeE0LQljf7L1jWo+P70lko=;
        b=nkE5hmR62J7Ww2+AqV5C4cRhtujSUGsaq4aa4D2nfngdsxn6T7ouIfdkfihAaz3/CP
         bwgSVcnOb0hWcu/yZogKOG3coKTybtJQLPhey7OXURws4BufImvv6Bx8hN/iB6nlfAt/
         pMoJg6TiYI+XNr2gnANHJC55/h9VCosq/GW2Y4sbYATJbX/+KPxLjdcrkzELxZGlXvPp
         iZ/hYsTKU4eFvImMpHyApbbbbwIfqe3VN6BCEDdS1fSZN+KgrDXnkJiWv74x23oy/OFr
         80dmeCWZ7mF7mG3kGRgGLrgmHPPbELuuzvqD5aj//SrW06gwtRwaLNdaGbJWp85WMJTV
         /sqA==
X-Forwarded-Encrypted: i=1; AJvYcCW+tWGTxPpefjRyc27yTS942nuM3knet4aOll5a6pMUYThtU3YgJPc44JIQx6QFi3jWfVDHVBz9vj/vl8wJmHnwt93RRCb7t0A=
X-Gm-Message-State: AOJu0YzMQ+fS1w1xCvxqc1bLBA+78kS4FCRg2FF879BOHJyE2xz0h0Dd
	Q6ZjfhcUq3mfsV2hupUqniwc98PzTxUbWhFSQIVo7xwMTqoLhUbP6jEhqB4z/Xc=
X-Google-Smtp-Source: AGHT+IHp/AQbEYZZdpmQu1KIboKwTFnhRTHy3IUitMBtdTfQEIp1e8p8oPGMBXNXjtBT0xrYq8GO+w==
X-Received: by 2002:a2e:93d5:0:b0:2dd:6d67:3064 with SMTP id p21-20020a2e93d5000000b002dd6d673064mr6309727ljh.28.1714399560822;
        Mon, 29 Apr 2024 07:06:00 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e9085000000b002d7095bf808sm3636733ljg.128.2024.04.29.07.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:06:00 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] cpuidle: psci: Enable the hierarchical topology for s2idle on PREEMPT_RT
Date: Mon, 29 Apr 2024 16:05:31 +0200
Message-Id: <20240429140531.210576-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429140531.210576-1-ulf.hansson@linaro.org>
References: <20240429140531.210576-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To enable the domain-idle-states to be used during s2idle on a PREEMPT_RT
based configuration, let's allow the re-assignment of the ->enter_s2idle()
callback to psci_enter_s2idle_domain_idle_state().

Similar to s2ram, let's leave the support for CPU hotplug outside
PREEMPT_RT, as it's depending on using runtime PM. For s2idle, this means
that an offline CPU's PM domain will remain powered-on. In practise this
may lead to that a shallower idle-state than necessary gets selected, which
shouldn't be an issue (besides wasting power).

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index ad6ce9fe12b4..2562dc001fc1 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -233,18 +233,17 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 
 	psci_cpuidle_use_syscore = true;
 
-	/* The hierarchical topology is limited to s2ram on PREEMPT_RT. */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		return 0;
-
 	/*
 	 * Using the deepest state for the CPU to trigger a potential selection
 	 * of a shared state for the domain, assumes the domain states are all
-	 * deeper states.
+	 * deeper states. On PREEMPT_RT the hierarchical topology is limited to
+	 * s2ram and s2idle.
 	 */
-	drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
 	drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
-	psci_cpuidle_use_cpuhp = true;
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
+		psci_cpuidle_use_cpuhp = true;
+	}
 
 	return 0;
 }
-- 
2.34.1


