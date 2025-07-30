Return-Path: <linux-pm+bounces-31642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49775B168DE
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 00:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AFD168C8A
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 22:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE1B2288F7;
	Wed, 30 Jul 2025 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IvPvF4ep"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF1219C556
	for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753913308; cv=none; b=jF5i+v+4x+76E9lsvmLS2dRcNec78nSg5EjcOrPD784xI0EosgQz/rsii8ql5fOCdBa9/5LOvqXBiZnN7VGg5KVvYAmavXUFbTNmHu9huWQUQS+GBKQN/jmrSjG6WNNrdy5//NlUb7xlK0B+JEvc5g9ll/4IBdFwJggMTvV8oTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753913308; c=relaxed/simple;
	bh=PNDe9DmLpP8vQLE52QVnejDJ8eVQpGsQIZ1TWehA3sg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oue5E+nptC8tu1owrxfn+TdldU8qgrUV0YObnMe0VuPNfvO83v932Lw5wun5+53SyqBIvi0EtDqrxgL3lYHDx6Y8BJ+kFoT2P4jOguxRAySr9StlCQRLfQSGPR27DTPc4txMtKj0UhE+hSN58me80AC2U7miJlj2wUTfT2E/LdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IvPvF4ep; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3f38d3cabeso174714a12.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Jul 2025 15:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753913306; x=1754518106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HYPSzgAZClucp9advPGtHTtoMvoPpzZ3Dtwk5mdPmjs=;
        b=IvPvF4epxARvaMU2dcOHI7Sq+MA37Grm6Ef7xZt6iPi8BBQ7fpm9+Q16UMw4fV8qOt
         Share2RzPf9VvT51LUiA/sPra+vgldUvw12bpm17SIuUPokp9kvFoWbHXpT0vl6FPs4c
         iyMS6m3++ARyE5gOAQ1ayCkSEmH6kyV9ZQxpx5xIAe5KclaoUDlFRcwW7Us8RuLy8rSx
         Fq6kh+33E7s/2mhLT4DpJmvCq+eoUJX9A4cZIfcSKV0kbBxzJSmmrFoov8/1llp9FN5/
         RLTM9SNdECGKost5cm3+I2w07iH6eoTNdrbHKrNxwpPCgttOSv9dxemSZ6mdm1HgKEnw
         0vNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753913306; x=1754518106;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HYPSzgAZClucp9advPGtHTtoMvoPpzZ3Dtwk5mdPmjs=;
        b=JYrSz4bdzMuR5uO/sfKlemGJAN2lAgP5dtU9oGfPwmEUzSWC4GM3KJbNk+xzbojfJl
         44wsbLJ6ktym7SC1B++xLz8TRasKsY+wuYBiLp7teilD6dSplIZtfqz7/r0xbg+R0qGk
         Mx0UY1K33pglhrpK5LszQIRt10naWOEjheLxtMaEun7mnPwV1tuauOsR+7di5DN4KcjB
         wGHKg+Qw6hfhrk+72LqqZjStPp7VXlrKYikE6xH/XEs+L6yEE/nu0xG88MZtU8FQDlto
         VjKe2dbYiRzTNdMXrBUArF7a+2Dce+0rkXV/DhteGa+/DhVS+GBY+ONP6sBrpbFSRtmq
         KRgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+Q5oyBab+JU8lEOZFVCNmISBRmscbMw7DyZp2h0ngJaPdXu2/q2zvBF65WuSmRcJ1IU+uNkUeXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCvhsLZZykSlbvTmFP1IZhcxH3gCfBiF7uWsZK5vaffyzyp5um
	GD25iT2vl7u0Kw938uo8hiOaaGkCj2zfNG9EPokSQQiGZWQJuKfVsHZbxSMDJkL9FakyRB87b9J
	tkGldnwGdYw==
X-Google-Smtp-Source: AGHT+IGZ3NDO6jUkDRlidOJBUV0Ja1bR3uiB0LRR/EOuhSKjhT4aH0bvvbHvHtK+qePEip623lThmruu6pu6
X-Received: from pjbnt5.prod.google.com ([2002:a17:90b:2485:b0:2fb:fa85:1678])
 (user=pmalani job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3907:b0:311:fde5:c4be
 with SMTP id 98e67ed59e1d1-31f5ea6b6bbmr6169503a91.35.1753913305877; Wed, 30
 Jul 2025 15:08:25 -0700 (PDT)
Date: Wed, 30 Jul 2025 22:07:58 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730220812.53098-1-pmalani@google.com>
Subject: [PATCH] cpufreq: CPPC: Increase delay between perf counter reads
From: Prashant Malani <pmalani@google.com>
To: open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Prashant Malani <pmalani@google.com>, Yang Shi <yang@os.amperecomputing.com>, 
	Ionela Voinescu <Ionela.Voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"

On a heavily loaded CPU, performance counter reads can be erratic. This is
due to two factors:
- The method used to calculate CPPC delivered performance.
- Linux scheduler vagaries.

As an example, on a CPU which has a max frequency of 3.4 GHz, if we run
stress-ng on the CPU in the background and then read the frequency, we get
invalid readings:

./stress_ng --cpu 108 --taskset 3 -t 30s &
cat /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_cur_freq
3600000
3500000
3600000

Per [1] CPPC performance is measured by reading the delivered and reference
counters at timestamp t0, then waiting 2us, and then repeating the
measurement at t1. So, in theory, one should end up with:
Timestamp t0: ref0, del0
Timestamp t1: ref1, del1

However, since the reference and delivered registers are individual
register reads (in the case of FFH, it even results in an IPI to the CPU in
question), what happens in practice is:
Timestamp t0: del0
Timestamp t0 + m: ref0
Timestamp t1: del1
Timestamp t1 + n: ref1

There has been prior discussion[2] about the cause of these differences;
it was broadly pegged as due to IRQs and "interconnect congestion".

Since the gap between t0 and t1 is very small (2us), differing values of m
and n mean that the measurements don't correspond to 2 discrete timestamps,
since the delivered performance delta is being measured across a
significantly different time period than the reference performance
delta. This has an influence on the perf measurement which is:
((del1 - del0) * reference perf) / (ref1 - ref0)

Previously collected data[4] shows that cppc_get_perf_ctrs() itself
takes anywhere between 4.9us and 3.6us, which further suggests that a
2us delta is too less.

If we increase the time delta to a high enough value (i.e if delay >> m,n)
then the effects of m and n get mitigated, leading to both the register
measurements (ref and del) corresponding to the same timestamp.

When this approach was previously proposed[3], there was concern about
this function being called with interrupts off but that was later found to
be not true [2]. So, waiting for a slightly longer time in between counter
samples should be acceptable.

Increase the time delay between counter reads to 200 us to reduce the
effect of timing discrepancies in reading individual performance registers.

[1] https://docs.kernel.org/admin-guide/acpi/cppc_sysfs.html#computing-average-delivered-performance
[2] https://lore.kernel.org/all/7b57e680-0ba3-0b8b-851e-7cc369050386@os.amperecomputing.com/
[3] https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/
[4] https://lore.kernel.org/all/1ce09fd7-0c1d-fc46-ce12-01b25fbd4afd@os.amperecomputing.com/

Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: Ionela Voinescu <Ionela.Voinescu@arm.com>
Signed-off-by: Prashant Malani <pmalani@google.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 4a17162a392d..086c3b87bd4e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -718,7 +718,7 @@ static int cppc_get_perf_ctrs_sample(int cpu,
 	if (ret)
 		return ret;
 
-	udelay(2); /* 2usec delay between sampling */
+	udelay(200); /* 200usec delay between sampling */
 
 	return cppc_get_perf_ctrs(cpu, fb_ctrs_t1);
 }
-- 
2.50.1.552.g942d659e1b-goog


