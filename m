Return-Path: <linux-pm+bounces-38346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB62C78594
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 11:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 8F9F42953F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 10:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6AF345743;
	Fri, 21 Nov 2025 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHa3APnU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AEB3446AF
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719426; cv=none; b=cetlX3oskAg34o3DDR1LDtRJjmkVpFTtWfeILMbbXoNTfLmgYGZZu9oEuuWL/R1aHtsfHAbXNo6WDUlISa89bLIj6fX69nIpbolv6lyoBPPDRfPBR7gToe/zMDgTzkkB0Thcm+mmg92YHKZBH5uk4RvML9ZUQNhe2jh31pk0ye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719426; c=relaxed/simple;
	bh=8POtwl+8gIl6KiVvX3+dIyH9ModDs3FOmNCMp2hDAF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n21JWzv0DZmAv4yBM4+TjPn2byT8N7Z26TQD6AUEpFR+04FRPZrYTHF2Jz2hD88ZLKo5JeAQIdrC9UHTAHxeJZCB5ugKky9M0L6kA0cgLuRvnsIU1W588bDXM3oSNSIb4E5rxVVuySbK5Wn3Sm5TC9SQNS0bBuSrWFLqExx6mM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dHa3APnU; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37a875e3418so11170691fa.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 02:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763719421; x=1764324221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjWIzWz/eyhljtrpfcXseW6nO885XaZnowKeb56K2bo=;
        b=dHa3APnU6Bt507S1cIhflRL9rGDzEnF32TE195mr1RVk2wC+nw/B7SwOCeMEQ9D7l3
         Wyul4mv/t7UpPJ4a/KdhsPc5bei+Aj9g2TPaEPKMA2UW0KxMTS0yxiwaHte5qCbNx4/8
         qOdkKnIWoEawEAv6zGWQZEt53Rtk9SXMtqm7Gjv8akRVGpGiAbqczz+mGm3IVZetNkGl
         FWa8udFaGu9YPUIhSEJERHYrC+bW1AOXkAJgHELfwMURwkuGxIo39S6CeW+nu8TkugjW
         A2DBXmm4FE6Vb9KMmC6gIIYcLGSRbgRn2kVQijDmQ4kqFaH0sGJFBEFVDPQyRHmyLbXW
         QjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763719421; x=1764324221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wjWIzWz/eyhljtrpfcXseW6nO885XaZnowKeb56K2bo=;
        b=j3kHnF7xU7IDKdqSjgqN68ScOqvxZxx3ZcQ3aqHcbANACYkcoEWVcT1vwOjdAg78pv
         F/P3PkKXGxuiGLj8uP1Gfp1yjWSdd8HPvBGlxDaaq2NMogHBMn50MLiGF6b+8d/oBZHf
         KsVWxhMR4lGTzQG/5Xsn5o1dl98C4NDfS084SA3WVIxSQcX45a8l1YxAuor1vqJmpU40
         JltDJYZRPwVlwnBO1D3IUiKA9RPp6Ai1OsMPbmznPqjD8WQSXztyQ9tTbF1Ru1rfl1lG
         CC1ZXIra05wauSkSJhv7KBnSzEgWrd6ryOA7jKCZyzh+PET5NUhVhqhSOyJFiGAp4PBl
         VaSw==
X-Forwarded-Encrypted: i=1; AJvYcCXNiWAnZKISijML55DsTZeURmB/fKbr093SYVRj9r7e6hYRALyhzS968QMslAhZ2mjJrbJJwEQPSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVFy7/DxHshzmNnfl+k3IXYbKy9zOwW9wQ49/PIkzzeTBVa5D4
	w6LPdFO8ateSu/2WKs9eRqRHyc8lW3tW3TPfMGU4aCDzPAD9zqKN5aG5ZpxXuo47Bvs=
X-Gm-Gg: ASbGncsEwKVFexcCBjf6MXw7iW2g2Q/kDXygza/0jlSmHWjHzoLYU4ZZ3EOHT5MNcab
	4VSkl3BMu4woCa3sy752dKnxKYLeWbGt5bGYbdkA8ClbQ9gKeMHxKpQXcjX2DuaSfVlJKlA0T6x
	YkweqQloOx6BArjvEPnx0O+91BFOMmeNHPV7kd5yp56F9s4X6D8FY1sEYVevJxG9x/OyZG/C8nt
	5sAlx6ZufDwBhruBL0+WCe+oJVDIwmTOTj5J6EUkV9MSrb0e8+CwVfY25dbJHBiU4FdhSIdwNmg
	EiiHNTRMLs1hW+mgE/3VwDIyoEPMbh4Rq9ajQS5sXUmF34wOcitIz5ifejWpbhcq49JCxde4MZc
	C0wIjtRDwVWrjHh3BfCjZ2aq3W3zekl9V5Aai/dHGEOdq5RJXAFNpXB1UJWXfrMVFY3BW2T2WnJ
	Fs5N8FyTsm0Pws7/2tX2vLPyzIEItRQ/lJtDnlJEQWoJxO1QJIrhWO4i9ZI2s5
X-Google-Smtp-Source: AGHT+IFSL0xhKngQoCd6w7yuR7+wVAiUcarsUMEIQV5fjj4GKrmC8uuyieReZfwwK4nQsRjrwIWOlg==
X-Received: by 2002:a2e:92cc:0:b0:37b:9d7e:2295 with SMTP id 38308e7fff4ca-37cd92e3665mr3603501fa.41.1763719421288;
        Fri, 21 Nov 2025 02:03:41 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37cc6b597b2sm11056181fa.12.2025.11.21.02.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 02:03:40 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Dhruva Gole <d-gole@ti.com>,
	Deepti Jaggi <quic_djaggi@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] pmdomain: Respect the CPU system wakeup QoS limit for cpuidle
Date: Fri, 21 Nov 2025 11:03:09 +0100
Message-ID: <20251121100315.316300-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121100315.316300-1-ulf.hansson@linaro.org>
References: <20251121100315.316300-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CPU system wakeup QoS limit must be respected for the regular cpuidle
state selection. Therefore, let's extend the genpd governor for CPUs to
take the constraint into account when it selects a domain idle state for
the corresponding PM domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- New patch.

---
 drivers/pmdomain/governor.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index bd1b9d66d4a5..05e68680f34b 100644
--- a/drivers/pmdomain/governor.c
+++ b/drivers/pmdomain/governor.c
@@ -351,7 +351,7 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	ktime_t domain_wakeup, next_hrtimer;
 	ktime_t now = ktime_get();
 	struct device *cpu_dev;
-	s64 cpu_constraint, global_constraint;
+	s64 cpu_constraint, global_constraint, wakeup_constraint;
 	s64 idle_duration_ns;
 	int cpu, i;
 
@@ -362,7 +362,11 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
 		return true;
 
+	wakeup_constraint = cpu_wakeup_latency_qos_limit();
 	global_constraint = cpu_latency_qos_limit();
+	if (global_constraint > wakeup_constraint)
+		global_constraint = wakeup_constraint;
+
 	/*
 	 * Find the next wakeup for any of the online CPUs within the PM domain
 	 * and its subdomains. Note, we only need the genpd->cpus, as it already
-- 
2.43.0


