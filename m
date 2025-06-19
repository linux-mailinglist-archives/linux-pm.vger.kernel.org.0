Return-Path: <linux-pm+bounces-29024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CB1ADFA0A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 02:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D75D3BF651
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 00:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929B6BA36;
	Thu, 19 Jun 2025 00:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QYw2jvXZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AC6184F
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 00:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750291788; cv=none; b=Rz/xmYrtGzx8m0pg6bw4yWZ5rZiEnwMrdTPps7N7Cu3HP4rK+XtiEAyuxLFuOOxQe2WCLSFJ+15y7QoY7HxgE4nKYuRbYJ9g11Vwdq7psTpbnXq5YN3JO+3Yp3Vo3td0VpdZWxKWTyUQcpGoXcyS97TyS/OTfi1DW+6b5rNf9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750291788; c=relaxed/simple;
	bh=Fj3oZkEhJrCAh4Iz/UdI/QOMi2P7+U3l67G0F7JcskY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tbjAH9m+lsVDqsp/DOAJnQioRPZG8JRRWOFirUioJt7sI44jnzCkgg5UEwSloUjyabicMgBS5WGL4c8fcRtzRonFojdyF1SIaP2Yof36w2vZkgUYdHRu3hqtcTGh0uUiuR4fsHRbcMiEN1fL5FIqRZqY1a8+yPW6xhTXbYW9ulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QYw2jvXZ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31c9a9dcc3so264302a12.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 17:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750291785; x=1750896585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fmBkhKQftrBW4wXUW3woXJtxya0xUCL03sCXfSj3h8=;
        b=QYw2jvXZS0UA7snx0fQqENRLEo7mAF1+BTCvMUZ6/pnVOxKw06isAfFYFOwGBHO5vA
         P1QSF7kd7ocIJtMcsnlgq/dDfvrqjR6K7uGJccVd1Pbv8+tdRoGJLzlK7+1RgFgrb8CX
         Yex8tONxSDdaOA6Go5kc5v04EBzcSNuyDW2zPA/uwrhWy9AiNDhwLqDPiunken7sVx9q
         7dGefFVqUJKt5u/nrot17Cj8eDBMbWmf7neJOKXKaVlGuzz2yKmCtGhyeNDifwtx2b8L
         OfS0cojEQ/KG/27qIYGW9QK3IzJ6GCbiDIaDofPQZsGcr8j08uJ74sR4o15aBDDUn0Vj
         u5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750291785; x=1750896585;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+fmBkhKQftrBW4wXUW3woXJtxya0xUCL03sCXfSj3h8=;
        b=Klw4T4sR4KboKRFOpIrXfLb0e0igQZ6KhbingXP5R3wSsHWQnw9xuuBnmxbNt59Xey
         cZ0uw0+MJeVHbDngiwBDly4WrIj8ttf2K3RcBkflLxZ+uh2hI0KtvE8/ZeDYzrpg38O/
         AJS2m7xt74Mj7S0mfdg4ofNVfLalmMp+5yGRi+ucrsVqyU5XEazDvUmpDFseVwFrdD2E
         TQ+Wd3yCA4R7vqRZ+3mrK+UawQ2VHI5li6uA1N5NuuesEU0HQhllpl4TUM35lvjUjvXc
         2aqGZ9ie72sWVJxDCWZMO3ZTG8exr73f+XrBcfrIRisnv2NHAyNrzeNzAEXK/wzP7zPd
         RYLg==
X-Forwarded-Encrypted: i=1; AJvYcCUVLcfII51GIRjD+rOUDf2Zj0wlNDmlqgV1NA5oi6ooIvHAavGc4/0zHUB4Bn5bAjop+zODKxTDIA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyib2rRZaEtLGH2FtazWarsYdssB5uw+9e2lw4pTHyAT3zbd2aL
	dH/0mMFFYxflLl1eZYVXNfjXs2D8i/6fP3VVdGWgB4t8vYEpvnmI9Vw6rtl20rp+vjnPyJv9bgP
	R+D6BBY7j9A==
X-Google-Smtp-Source: AGHT+IFRGZh1ipsvgoWb3xe+LChbHfiIZwC43x4KvlpB3ixADI4MvbOX5asjlo5RBRIIuzw+0m39mBy3lWWq
X-Received: from pjj15.prod.google.com ([2002:a17:90b:554f:b0:312:14e5:174b])
 (user=pmalani job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2787:b0:236:9402:a622
 with SMTP id d9443c01a7336-2369402a9b9mr94092355ad.34.1750291785183; Wed, 18
 Jun 2025 17:09:45 -0700 (PDT)
Date: Thu, 19 Jun 2025 00:09:17 +0000
In-Reply-To: <20250619000925.415528-1-pmalani@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250619000925.415528-1-pmalani@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250619000925.415528-3-pmalani@google.com>
Subject: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
From: Prashant Malani <pmalani@google.com>
To: Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Prashant Malani <pmalani@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

AMU performance counters tend to be inaccurate when measured on idle CPUs.
On an idle CPU which is programmed to 3.4 GHz (verified through firmware),
here is a measurement and calculation of operating frequency:

t0: ref=3D899127636, del=3D3012458473
t1: ref=3D899129626, del=3D3012466509
perf=3D40

For reference, when we measure the same CPU with stress-ng running, we have
a more accurate result:
t0: ref=3D30751756418, del=3D104490567689
t1: ref=3D30751760628, del=3D104490582296
perf=3D34

(t0 and t1 are 2 microseconds apart)

In the above, the prescribed method[1] of calculating frequency from CPPC
counters was used.

The follow-on effect is that the inaccurate frequency is stashed in the
cpufreq policy struct when the CPU is brought online. Since CPUs are mostly
idle when they are brought online, this means cpufreq has an inaccurate
view of the programmed clock rate.

Consequently, if userspace tries to actually set the frequency to the
previously erroneous rate (4 GHz in the above example), cpufreq returns
early without calling in to the CPPC driver to send the relevant PCC
command; it thinks the CPU is already at that frequency.

Update the CPPC get_rate() code to skip sampling counters if we know a CPU
is idle, and go directly to the fallback response of returning the
=E2=80=9Cdesired=E2=80=9D frequency. The code intends to do that anyway if =
the counters
happen to return an =E2=80=9Cidle=E2=80=9D reading.

[1] https://docs.kernel.org/admin-guide/acpi/cppc_sysfs.html#computing-aver=
age-delivered-performance

Signed-off-by: Prashant Malani <pmalani@google.com>
---

Changes in v2:
- Add sched.h header for usage when compiled as module.

 drivers/cpufreq/cppc_cpufreq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.=
c
index b7c688a5659c..5ed04774e569 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -18,6 +18,7 @@
 #include <linux/cpufreq.h>
 #include <linux/irq_work.h>
 #include <linux/kthread.h>
+#include <linux/sched.h>
 #include <linux/time.h>
 #include <linux/vmalloc.h>
 #include <uapi/linux/sched/types.h>
@@ -753,6 +754,10 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int=
 cpu)
=20
 	cpufreq_cpu_put(policy);
=20
+	/* Idle CPUs have unreliable counters, so skip to the end. */
+	if (idle_cpu(cpu))
+		goto out_invalid_counters;
+
 	ret =3D cppc_get_perf_ctrs_sample(cpu, &fb_ctrs_t0, &fb_ctrs_t1);
 	if (ret) {
 		if (ret =3D=3D -EFAULT)
--=20
2.50.0.rc2.701.gf1e915cc24-goog


