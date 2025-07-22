Return-Path: <linux-pm+bounces-31250-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E734DB0D18B
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 07:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244273BFBB3
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 05:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ADB28CF5C;
	Tue, 22 Jul 2025 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="19xSivaZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C43A95E
	for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2025 05:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163887; cv=none; b=o1pR2Jtg8baA7pjURTRMVXDMP6BsoZoFvjBG0lB7LXWwP+vbT6w1Z/qLix2i1kiYX19WZVImwwRq94ghfqspr5aHJK58z/1VNxc7mRRxa3O6VR+BXuZye64vFwtciFeSZZm2V9v1ZmP7cUeBRtr78056Z421AqqjxSKozr+GYqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163887; c=relaxed/simple;
	bh=n72cdPXZeJHHjVF29bmi3yU2+tOfineR66XrhqtYQ84=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ke7kieYPUIe4BDrtNukKaKJbHZS5eHfEIYjaPCSn09oHzcOg0GhFvmh5LdSt+HqpHxcYhm1WJ4F9G+rXJiNGIaYyfVFam6Gnun+GjuKyqN3wMz55m5Y+Ov4JUJjN6G0WGwH79bpJX9En7gEllKpossWqTl6/DsLUsi1rj6IqUbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=19xSivaZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3132c8437ffso8872599a91.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 22:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753163884; x=1753768684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XDAaESfRoBj6PBmfDe7VrvhxCfzBMJy2IiWm0LqLkHY=;
        b=19xSivaZs08bcqtFK1Vo7WjL57OpufVbxxvnhFadEGHpXOxzRCxgZ2NJvfTjA/Z4zo
         1gBOnMfVZT8U9Sea7z/e7ZrBJorK2TMj/OaSx40mjkyOMkW/vHlhZK3sGv64wDgtH/PU
         wMoZ0wNjEbJ2IiIHcEXLi7I5ie3FB5caL98beNJktZMtA5h593/86fkqAKRvmZ1S6C7L
         yZTHJBFeRKBmE5detRhi9TI6E6p0trEweoiHVZcvfp8rb3xeHyB6xFrNwtpAsttBpKPB
         DyEPDrLf4ZGDVzhjrwMhdC92eu76IawRhOTeV82Zl7A5Yu5shj/kTIdftMUMPDlDzPse
         m8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753163884; x=1753768684;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XDAaESfRoBj6PBmfDe7VrvhxCfzBMJy2IiWm0LqLkHY=;
        b=GbdOs9HMGo56TNT/6ClWMWNTkISTx8m8lHUiq1EI74TdLAiHnuemZ2Km4Vbq4QVTfJ
         DYQ2L8NN1J23aGO+T6+K8I212aMSNEXciomu3wO65cYHZCX47h3nOHO55yruvLzVorVl
         M429UUy0uDdFl/vxcooxHp0xnSxqAV0/2CVjpNl272OwJSVus3cIc2tnhpTOLBoQ23Pn
         u8Q6Q+lJP9x2k3C5te3WTksLRbYkiiwGIFdCleVXEI4YG7Eeg6mlJENw1atT/k9xNpNe
         tui/Fy+ahR0elM3vpE8Y1g2LY/dDjwzaN/FMJN3nl87P2HPvDToymO/7OGg8w+wksb9J
         LdhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeUih/s73YUyPducMXq2+lCNymWnUS+9FckQrzN3TSETIXHlkBevYv9N8/LeI7OOHliMAEHbfSEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5gA3pfQyJjY0Ipa6xfaKDe8zh+Yrtkw22fZmL+x0WWkSLtTyM
	6+8ntySYWu1DsGsHEY2vs8mWiGdNcfK4V44AY6KGq3izOMkcPLmMK7TPIar9+C1UxANB0ibDdY+
	7eOcC+zVv3g==
X-Google-Smtp-Source: AGHT+IE2pHLovgOnNgX0qu5gbs5FeLa7ug3A+DGcUIVn//cp0TcsogJ3mKsYujLB7FQmXE+y53tXZaDOE0Qv
X-Received: from pja3.prod.google.com ([2002:a17:90b:5483:b0:312:1af5:98c9])
 (user=pmalani job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35c7:b0:311:fde5:c4b6
 with SMTP id 98e67ed59e1d1-31c9f3efe45mr33500923a91.6.1753163883862; Mon, 21
 Jul 2025 22:58:03 -0700 (PDT)
Date: Tue, 22 Jul 2025 05:55:40 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722055611.130574-2-pmalani@google.com>
Subject: [PATCH] cpufreq: CPPC: Mark driver with NEED_UPDATE_LIMITS flag
From: Prashant Malani <pmalani@google.com>
To: open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Prashant Malani <pmalani@google.com>, Beata Michalska <beata.michalska@arm.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"

AMU counters on certain CPPC-based platforms tend to yield inaccurate
delivered performance measurements on systems that are idle/mostly idle.
This results in an inaccurate frequency being stored by cpufreq in its
policy structure when the CPU is brought online. [1]

Consequently, if the userspace governor tries to set the frequency to a
new value, there is a possibility that it would be the erroneous value
stored earlier. In such a scenario, cpufreq would assume that the
requested frequency has already been set and return early, resulting in
the correct/new frequency request never making it to the hardware.

Since the operating frequency is liable to this sort of inconsistency,
mark the CPPC driver with CPUFREQ_NEED_UPDATE_LIMITS so that it is always
invoked when a target frequency update is requested.

[1] https://lore.kernel.org/linux-pm/20250619000925.415528-3-pmalani@google.com/

Cc: Beata Michalska <beata.michalska@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Prashant Malani <pmalani@google.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index a1fd0ff22bc5..4a17162a392d 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -910,7 +910,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 };
 
 static struct cpufreq_driver cppc_cpufreq_driver = {
-	.flags = CPUFREQ_CONST_LOOPS,
+	.flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify = cppc_verify_policy,
 	.target = cppc_cpufreq_set_target,
 	.get = cppc_cpufreq_get_rate,
-- 
2.50.0.727.gbf7dc18ff4-goog


