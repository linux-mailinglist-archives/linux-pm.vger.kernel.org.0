Return-Path: <linux-pm+bounces-25066-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E59A836C3
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 04:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6DF3BF915
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 02:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7724D1E9B08;
	Thu, 10 Apr 2025 02:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY5KKEMt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B796437160;
	Thu, 10 Apr 2025 02:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744253141; cv=none; b=c65Ya+6OtMTVuVUiCMwYvzaaV7tnj8OlfH94oW6eMfV0sAju0JjiqtHxR4lq6YH7zVNoNBsdb07OLntcVHzrI8icHfdU7Na1C244rRAqq+p1DRz6RmcggBzotFKznHQP8YO4qAZGj10F8/egUfy4hPuCQp9oO3CLgzn/GX3No48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744253141; c=relaxed/simple;
	bh=Q8AXcXVSVMznwFw+vmhKbYQYPCxaMf2KKKekPLOUUI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ML137JdT5jl1OlqzhMckX9OFzi+VXO5oR3N1wJv/FG6nUPEb5HfkQlWqtD6LTef0M+y8JDw8DT59BVkm4zP6gj9MiCqFfUXU1RkjLxiqUw57FUypHit0VNWgpfZC4uW2tdyABg9tDOnfddBGKP30S5K3xCHOzatFUr6CRUZ2kHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY5KKEMt; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af908bb32fdso301891a12.1;
        Wed, 09 Apr 2025 19:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744253139; x=1744857939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mgEaQVzQ9xUZw5+9pb2jzPcanvYUFUW9ZgEc7iF3zJc=;
        b=hY5KKEMtqptrZUPiJ5tIdONgOhD8im0sM9pWOx0YCcuQpN4bgBvFbxrRQtd6tdccaF
         wkdaVzCeoSawLPFtln3/+0/+Eh5XBopN+xT5ytU3DDjRFObm5om9ZD4bahW47AxiCeFG
         LThOoKffBSraYPJIyk5ZZtagZTQLdxrmtlndJXNS1dTi+t/UPAlNhiXT+ytWQyyYcKOW
         TlZyEEyl4TwyZF3RGup5geW9ZOzRa6lGydm1S6ng59COP4l7HPbzDBovyYcUzzG1/DMC
         QggxjHqXfO2CG4C62FMryEVHY1OCIv+bdrqPeN+odQOn4eLVZ4DFQqEm7iiXVPLpEW4C
         o+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744253139; x=1744857939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgEaQVzQ9xUZw5+9pb2jzPcanvYUFUW9ZgEc7iF3zJc=;
        b=mM1OCOCKipkrihZBB3rGcPMX3Ziit179c/ah6C+g7p4mp51YfCQwFQy6cTr5kX/PvZ
         GumUnNp/+7xwWi8KzJ5nCclUIhVr6mRbXF5b2JaZdW9Im4CM/FqY8VA+K76zArGbEYMs
         skGArLLoEwTU8IXVLKEKbvseVw9VW4lDIJaGiPM4SPAZWhuE8gFklPeo2U3/uTG+bcnT
         p1QGrspiiSUB8cIgwOYfyK+VKKD3LOLKK2Uv/sy0QffORCODheDBAV7y9oPj3w1UWtwG
         q026CQWcXkCZhqjAmYaqs71duBwWTNYjFL41PfHAftSyaWnACc5oVhs7Oz/1mrfwbUlB
         pYEA==
X-Forwarded-Encrypted: i=1; AJvYcCU4Kp/H5nUDnP6SGr+ZphFsfg04bGpoxcCFTEp4sCj9Le69rHg2Ho4eYe8pphim1n7WU5saGD50vms=@vger.kernel.org, AJvYcCVQZ35vLYVKHxkue/iR+AiBXjkH6y81Fa9MWQs9GTaYxCvgKHvHEOTBleKfJN9mloxS1HXWQsfSEhfO/BI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/NIrE/A1Xd/o4wgb3OW8IjNgC+NP5UY3ed6RrkFQ4BjFcGSFm
	b/XrMYZ6kJPk6gpQv4NfN4s7106RdfnK/trNsAbzB7Xh/IBpvEFI
X-Gm-Gg: ASbGnctnRdmYdWmPSQS53pEeM04LSCTSVWODsFNb0Wn4Wel5wWLQfs9R7NXOw7MLC21
	Iv2KmgwSq/bNs13CWzYv717YGIGUogoHlh8bsAJG2chNUwQq81g3SXMBjV0BHUUvIObzg12VvTt
	k/rus6XETBEDKiyg8etSUNsHbmaDLn3v+OVQ0Siot3gkq/7qjjVL474XkfFSkCDxzcpgAdfkBgA
	I2HaXYK9Ofh/rZrxCoVoT9x6Uq+0vzQwZ4fguRBSpyTIm6JJkHalUJKS+X32yBg2Xo99n3XjAYV
	EWZhjmDm9iWJjxfiw4E=
X-Google-Smtp-Source: AGHT+IHLhI98ioM5QSvFbUz3p9lheGgiIL9i5F9PoF5eRULqoR2vYB871TKWwgvhth+s4htE2suL2Q==
X-Received: by 2002:a17:90a:dfcf:b0:2fa:1d9f:c80 with SMTP id 98e67ed59e1d1-30784d58f25mr1703698a91.17.1744253138741;
        Wed, 09 Apr 2025 19:45:38 -0700 (PDT)
Received: from sultan-box.lan ([142.147.89.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd2fe717sm1283682a91.0.2025.04.09.19.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 19:45:38 -0700 (PDT)
Sender: Sultan Alsawaf <sultan.kerneltoast@gmail.com>
From: Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
To: 
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: schedutil: Don't ignore limit changes when util is unchanged
Date: Wed,  9 Apr 2025 19:44:37 -0700
Message-ID: <20250410024439.20859-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sultan Alsawaf <sultan@kerneltoast.com>

When utilization is unchanged, a policy limits update is ignored unless
CPUFREQ_NEED_UPDATE_LIMITS is set. This occurs because limits_changed
depends on the old broken behavior of need_freq_update to trigger a call
into cpufreq_driver_resolve_freq() to evaluate the changed policy limits.

After fixing need_freq_update, limit changes are ignored without
CPUFREQ_NEED_UPDATE_LIMITS, at least until utilization changes enough to
make map_util_freq() return something different.

Fix the ignored limit changes by preserving the value of limits_changed
until get_next_freq() is called, so limits_changed can trigger a call to
cpufreq_driver_resolve_freq().

Reported-and-tested-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Link: https://lore.kernel.org/lkml/Z_Tlc6Qs-tYpxWYb@linaro.org
Fixes: 8e461a1cb43d6 ("cpufreq: schedutil: Fix superfluous updates caused by need_freq_update")
Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 kernel/sched/cpufreq_schedutil.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 1a19d69b91ed3..f37b999854d52 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -82,7 +82,6 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 		return false;
 
 	if (unlikely(sg_policy->limits_changed)) {
-		sg_policy->limits_changed = false;
 		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
 		return true;
 	}
@@ -171,9 +170,11 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	freq = get_capacity_ref_freq(policy);
 	freq = map_util_freq(util, freq, max);
 
-	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
+	if (freq == sg_policy->cached_raw_freq && !sg_policy->limits_changed &&
+	    !sg_policy->need_freq_update)
 		return sg_policy->next_freq;
 
+	sg_policy->limits_changed = false;
 	sg_policy->cached_raw_freq = freq;
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
-- 
2.49.0


