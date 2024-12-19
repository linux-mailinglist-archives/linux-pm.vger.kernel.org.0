Return-Path: <linux-pm+bounces-19542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 838C19F85BD
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 21:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB9397A371D
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 20:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893061BC09F;
	Thu, 19 Dec 2024 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="XhMotE5x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879111BD039
	for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639525; cv=none; b=jHc/35UpK+w3fgSczrG4W2FZBZPuClSt9qr1fZfh9Gu/pntfaQaakNO5P5yj6Am4y9k1mxw8b3fTuBHyDyriedTrA7YAYfggHWai6VHxOO26CzWlwwwv/lpS3gHqozgh6CHM2/zubaxPGyUxp4oa92+agB9TRe9FVxi1gJvKyK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639525; c=relaxed/simple;
	bh=NMXXVilYNKTfG7XSkl0jtmfs1wL4q1PoioCycSVb15s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9GrrLoFtjLJ4Iz5MBY7RSaQtJUgBqLw9tpvfuismRiCYlKmYuT9wD8Nd9o3qmTrL46xy53NHbbWXSJzJNv9xfcYvu3VX17MGK6FgI9fBINzpv71m1pAEFgoupijGJwIrdaFNWirG2zxTlfb9jXL4da6PUV3/GtTS1w8TYCmEzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=XhMotE5x; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4363ae65100so13388795e9.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2024 12:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1734639522; x=1735244322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UNl/KDdgHfnnSxN4lrQJgad4LvdpAF5sjqJPgBUKzjY=;
        b=XhMotE5xcCzJvek/6oUdAIT3aVneodJSV7/8Ggxxd0evtkY/it8WE+a0xhoL6MhG+Y
         XUEHveiduZYUTJeyIIUeMn0IAVz95iZDxfISXX2gfqXZQnnbx6ARUFVBtWpHjRmgVvZc
         HFmZ4ljP6i/WC74WiTT6+wdQTZN0Ul7CEYG5r4O1OUUme/xmsE1ky1qk9D4Lo8+dgBmF
         0c9gx3KctD7nvKfRL07BZ9dkW/FY6nj7/fX72xlOc4SFkcsEW5yrjLI8ehbRyGyP81Cd
         Qyy1MXtGvqlPu0erajExF6QaD8VKNnjONDr3d9IPf7hxMPBGrjjTWIh0fg4MZPvQ/Zud
         C/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734639522; x=1735244322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNl/KDdgHfnnSxN4lrQJgad4LvdpAF5sjqJPgBUKzjY=;
        b=hD8onzj+QQkPBWtGuThP3mwV6XIIikpegezNno5Z76TxfQNB0KuZ+1yRzGywU/WPC7
         GyMT3RJ9ueNQhtGImoZU+NY3Pgw+lBgU6AsGDw9Hv3snZJ/Had7Jd1uDoQnJho5UNYOa
         GKyqsiecnkybc0NfTpstG7W4qyC1iARN5RuM0R6wvSJ/2v0MXuYEx+c1xxt3eMOC8TVZ
         CNVbbJa1SmiswZxU3LnK5lJ3yJ/CHIrLmYgbQndliFbHBKUKOdlDzqJTWPNmBCKNdHwy
         CIMDt364PvLtP2PLWJ7xtR5dPQgDUt8Btnx9Suo6jbuD8BpimNEJjUE42WXkI2/v2F2A
         VpDg==
X-Forwarded-Encrypted: i=1; AJvYcCXFD1SiGcV81MRalZE8Shtkm5QIHov2I01/5f2hVpi7NcBZ8F+oRRzhMF39vJG1zKusfIDTP9N0Yg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/kIebLELFCIM3n+3Q94G0t+Vp6MCMtdbpo96TWvf9qTU/yCOP
	2ksTKzeN6iQYaU2k2sf332UM7w32Q9HStx4MM7JugMds+sfxNsT/onivm0L4jLY=
X-Gm-Gg: ASbGncvXRFE8+ovw3SvnpSBzfBDi+kraEE7gPwArFwqtdUVDXIVkifawdmgmWucT2IM
	4CFq7yJ2ZwO70826BY7IbZmXXXJGewZZbXQd2z+agQtxMzxLfXv+GX3iSCqH7NaMhz9ud45yFce
	vpdRF7hOugeOx1KSpYguP9KrxUsEiGJKHv3i0NfbWjksA1vJhbvAXbdGrZK5dVHO33KDxujqVV2
	WXsQxIh6tiO0CQrWIpx6gmAzOwuv85wa86voRh+Mpk0l0ShId83z68dCd0az3wB1RNnmS7mavoc
	9e6m4KjEWhjYAcFAj07i19GsjJAnsVl1g7J2JNcCdpDzWdbXocVQ
X-Google-Smtp-Source: AGHT+IGhMg/R8CEoO5icdTMg7GvMkGydpQHvuN05PPSivYFehytaR7Euq/MLib9NF/7q84XXTRRN8g==
X-Received: by 2002:a05:600c:5112:b0:431:557e:b40c with SMTP id 5b1f17b1804b1-43668b5f3c2mr2052765e9.27.1734639521754;
        Thu, 19 Dec 2024 12:18:41 -0800 (PST)
Received: from stroh80.lab.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b013a1sm61944385e9.11.2024.12.19.12.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 12:18:40 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Naresh Solanki <naresh.solanki@9elements.com>
Subject: [PATCH v3] cpufreq/amd-pstate: Refactor max frequency calculation
Date: Fri, 20 Dec 2024 01:48:32 +0530
Message-ID: <20241219201833.2750998-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous approach introduced roundoff errors during division when
calculating the boost ratio. This, in turn, affected the maximum
frequency calculation, often resulting in reporting lower frequency
values.

For example, on the Glinda SoC based board with the following
parameters:

max_perf = 208
nominal_perf = 100
nominal_freq = 2600 MHz

The Linux kernel previously calculated the frequency as:
freq = ((max_perf * 1024 / nominal_perf) * nominal_freq) / 1024
freq = 5405 MHz  // Integer arithmetic.

With the updated formula:
freq = (max_perf * nominal_freq) / nominal_perf
freq = 5408 MHz

This change ensures more accurate frequency calculations by eliminating
unnecessary shifts and divisions, thereby improving precision.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

Changes in V3:
1. Also update the same for lowest_nonlinear_freq

Changes in V2:
1. Rebase on superm1.git/linux-next branch
---
 drivers/cpufreq/amd-pstate.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d7b1de97727a..6f6f3220ffe4 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -908,9 +908,8 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 {
 	int ret;
 	u32 min_freq, max_freq;
-	u32 nominal_perf, nominal_freq;
+	u32 highest_perf, nominal_perf, nominal_freq;
 	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
-	u32 boost_ratio, lowest_nonlinear_ratio;
 	struct cppc_perf_caps cppc_perf;
 
 	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
@@ -927,16 +926,12 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 	else
 		nominal_freq = cppc_perf.nominal_freq;
 
+	highest_perf = READ_ONCE(cpudata->highest_perf);
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
-
-	boost_ratio = div_u64(cpudata->highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
-	max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT);
+	max_freq = div_u64((u64)highest_perf * nominal_freq, nominal_perf);
 
 	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
-	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
-					 nominal_perf);
-	lowest_nonlinear_freq = (nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT);
-
+	lowest_nonlinear_freq = div_u64((u64)nominal_freq * lowest_nonlinear_perf, nominal_perf);
 	WRITE_ONCE(cpudata->min_freq, min_freq * 1000);
 	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq * 1000);
 	WRITE_ONCE(cpudata->nominal_freq, nominal_freq * 1000);
-- 
2.42.0


