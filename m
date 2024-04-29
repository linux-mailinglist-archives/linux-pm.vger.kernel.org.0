Return-Path: <linux-pm+bounces-7284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EF08B5AE3
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2024 16:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3169A1C20340
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2024 14:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164777FBC1;
	Mon, 29 Apr 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANV24eal"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2BA7E105
	for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2024 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399562; cv=none; b=TDh88nPdGO6htlFWDSUrO6zyfZ+l6zuDiVkH73Yxac47kSc50pflBMmtzDetjxf2x+ZkjVjgkpS0hLxJTmEGWa7aBozepEsVw7YmhiOyZ2GJNs5fCKTu5r5Yf1r8rIEavLRMlWXuRQ+p3KgUYXZGqHGGsrAKHia/XHYAX1K+bWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399562; c=relaxed/simple;
	bh=jSO/TwF193q6NQysycIGd6vDzmh/SnmSAu4Kev3da7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ds86KQxI+wTnG3Q88YyxyE9zQws8f8ZWgr7AHnNlYh1dcw1vQjXgCjdUdgwdjvgqExA4Sy+4EdTDbGoAIc7djY+6bDMl0YCY76DKVJqNOj3Qiqyq50t/w2Hk2wTxGeg7B0qebJSvaBxVhRlgAZ0iJp7OWSjm1rq1lgY11pjDdlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ANV24eal; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so54144071fa.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2024 07:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714399558; x=1715004358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryk8Yjnwcb/TeAS/NSYC6eu7KpbQ2RMUyBm2Fm6rA9s=;
        b=ANV24eal42bpfcOfoK6+3lvgO3RLohrNWPsGMfJ9BCyUxF8xkd8fT5B5Gb2oXMyA7X
         rwiRyNJx5Sh60wn3z/CkEpyLIZIzdqactruq0PJXP9SM4PQkYOZUrlZd2cypR9WzIaT8
         4e8F8dKDJzLiPZFTifQI53szRQL+O2md4i0SPH0KmTg8ZTwndT59MGEDmBPs8y03fg4B
         F/LSSDTfj1zWEHcxC2P7RwH8R7CNRlUbaR/Ux3+Yu8OxkMuLyIWhZwzeGMO3kwhe1bFy
         ABTjdHtsDVj+F561/qjZaXytwDHbLN3BiYgvFIwOoylPL8KSrZZgJle8Jg1fnnv/5W64
         hJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714399558; x=1715004358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryk8Yjnwcb/TeAS/NSYC6eu7KpbQ2RMUyBm2Fm6rA9s=;
        b=f6DSvwMsZgekEw5e33g0BA5cWNpM6RaF+4a/QhN0dSRiXzXZKlQI8nlvRe+VPSWa9r
         nLraagLSaAHQu1iegMgDmxzILyg5CWWByIVOkEr9sgQLKcTBl4VksNl5AFFp5V93wNJ0
         mw+ealzp6KYuLoYexMI6n8bTiej3FN9whteoN6FXFGmpQUKTuOZuJEyRgmbkdreHr/tO
         TNdSkhg4ZzJewg3ZkFFQKXWc20JQ4d8N0qA5PRWVlxNhSz2xTajGhZE+C4BzG4gKLWxG
         KWc0QryHo05ASVw9rS2zDVGVo0IIE3I6Vva5v2xI/If2nGnnMft60OHdG5AG0P0TSsh0
         9ZoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhNjbMQhfChp+bcSVX2l0S21GglH9Y39zuzEB0/eKV4fj7v5v8iFaEQucV0JHdjcZy/l+6JFrK/Dq8YdyuTcsi5JmbTZua5zM=
X-Gm-Message-State: AOJu0YzfEsdhIwuxkSi+NnDI5QwQs9uleHOuFi2JgMwCPhTTDKDf8vte
	RZf6Wi+hdiDba1gIwdBF1hMsBCEvZmbeVS/D03+xMdKKHHabfFjFSiUFIgfD12M=
X-Google-Smtp-Source: AGHT+IHXIApKuUwmhZVbv+qbGSSWrutGduBAYZPG18WJ+SF5X8KY8BLp8xAT7YhpWiZQaddV7NhglA==
X-Received: by 2002:a2e:be08:0:b0:2e0:2661:77fc with SMTP id z8-20020a2ebe08000000b002e0266177fcmr3590162ljq.39.1714399558442;
        Mon, 29 Apr 2024 07:05:58 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e9085000000b002d7095bf808sm3636733ljg.128.2024.04.29.07.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:05:58 -0700 (PDT)
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
Subject: [PATCH 4/6] cpuidle: psci: Drop redundant assignment of CPUIDLE_FLAG_RCU_IDLE
Date: Mon, 29 Apr 2024 16:05:29 +0200
Message-Id: <20240429140531.210576-5-ulf.hansson@linaro.org>
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

When using the hierarchical topology and PSCI OSI-mode we may end up
overriding the deepest idle-state's ->enter|enter_s2idle() callbacks, but
there is no point to also re-assign the CPUIDLE_FLAG_RCU_IDLE for the
idle-state in question, as that has already been set when parsing the
states from DT. See init_state_node().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-psci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 782030a27703..d82a8bc1b194 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -234,7 +234,6 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 	 * of a shared state for the domain, assumes the domain states are all
 	 * deeper states.
 	 */
-	drv->states[state_count - 1].flags |= CPUIDLE_FLAG_RCU_IDLE;
 	drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
 	drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
 	psci_cpuidle_use_cpuhp = true;
-- 
2.34.1


