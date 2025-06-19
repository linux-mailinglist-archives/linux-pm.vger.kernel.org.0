Return-Path: <linux-pm+bounces-29023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6E6ADFA09
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 02:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A5617A7A11
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 00:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DFA610B;
	Thu, 19 Jun 2025 00:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sr93ppCz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B78125D6
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 00:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750291785; cv=none; b=V63R/VlyZTSKPS2raZ/uUe3OD0C8vGa7vCI/w9G0kSrJoBscvrVbaAc+QV01lPbBLEXHmHnNLIkzCbXWoEbr3sAGN7bZ60MnUVA7QfX1vmZU3Fe+yI29WyeyjY6ytqLZLzo9JM2Yi5dlWAZg1xCg8MGQhYeKZb7Ny6MtdgNAvKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750291785; c=relaxed/simple;
	bh=+qIMTdK2NCPkOQxAHBlrFY0gHuAzhR9s7EuV7668bG8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=imVwj9KPQrDN8MLmx87etYJcuk+W7dI97cl6rK6NWNub/8Vm78T8DqxatD/57b6F26sitsmzf0oZ4YX0+qVpwNzL73XFu6USJTR0cNbqF35HwR67j9V/bcNc9JFkkBXkKS7H28XOvwfEBaH4FFGw0hvfX8RPKoSpQT1cQ4vURas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sr93ppCz; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2358ddcb1e3so3272295ad.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 17:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750291782; x=1750896582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QpC0/56QK9gvVcyMRwwJWQGp6+fL7PqTqoQ1qu/UYZU=;
        b=sr93ppCz+QPG8IiRwSFt7B+vlHV8uQTbrAQshffn1DlChdirbXpsfWfY4FNKHgAE0S
         JuIsuzWQrDJfeMWIIOLjXcjn3I3PuZBKWDm5M5WmV1q7jREodffDZnchbiweRDKOMCHe
         1atV+3CfQ1szJ0AgVhBZHF+e0tZESMNt+G4w5C3dy+caMWQ9rCAjlXVFBV9cVvg+yUeH
         P5/PfiONXJqLHXIo8kdNpWJD8m3p2Mo9iPe9tA5axLlTLXO0Fa0HqqCPtjuALyJLDwvO
         oCBeNqoBYEviykJc6hDakSLWx3chtv0uLcHWqYxZoKhrLAEkxNLY/zdP79FE/LYKnveg
         3r4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750291782; x=1750896582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpC0/56QK9gvVcyMRwwJWQGp6+fL7PqTqoQ1qu/UYZU=;
        b=wdXkYoCQWnXDiRWRROaF7osF7amoPcpyGJzgefkxJ1e2gIHZIAe3JLwXnEiRsyYF8R
         EcWDgq1H10yW1isb/+VG+/KRpuKMDBwXgM85xO+EMMtXNS8ErHImEaZdpAGm3/5/o7BW
         sxGMdMcNEPmNMfTdtuCu75+Nd+eIpfLN8RUIrgnQ20s/BmQ6vkokKsF8vldT9WT1XzrL
         36USiYHsliZCKabwos+dFSmk/LQ9P1TYatFSiWAUSWfBvadiUYqnKJK7G+Wpfh2zkSTn
         slidG4T3XSSjNBnlaomR838VlREYqENsqf5wTKfzSQKtgul7jdkLQsPn527nbKKCmfjT
         dy5w==
X-Forwarded-Encrypted: i=1; AJvYcCV9QSRz65RXJKtztb2bYYmGhw82LO1U0CIdDrLYuNLH9LlV9HCXgvRRGKlBYHf+CKHhgZQ5O3BaQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyO7+iQqsIRRibo8Hz5+yq77sidxr4F/X6CwEsk3EUubnRwedf7
	lrHRAEB5dNM3sC6HnwstwRGypQ2asj+5gfiEVE/0pKiJU8JajSRpIM6QPrBT84x0b1kgwh4XC6F
	eHqkCKv+Cjw==
X-Google-Smtp-Source: AGHT+IHEEOaCcOMdAMBdQBtaBCFLjNH36AGNabBMUPOCub7dg5uABSx4DqEsASmj5lALImz6DptXxGXuNrcm
X-Received: from pgbx123.prod.google.com ([2002:a63:6381:0:b0:b2f:4c1b:e1a0])
 (user=pmalani job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1cf:b0:234:f4da:7eef
 with SMTP id d9443c01a7336-2366b1773c0mr311198265ad.52.1750291781704; Wed, 18
 Jun 2025 17:09:41 -0700 (PDT)
Date: Thu, 19 Jun 2025 00:09:16 +0000
In-Reply-To: <20250619000925.415528-1-pmalani@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250619000925.415528-1-pmalani@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250619000925.415528-2-pmalani@google.com>
Subject: [PATCH v2 1/2] sched: Expose idle_cpu() to modules
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

idle_cpu() can be helpful in some drivers which can utilize it to make
performance optimizations based on CPU idle state; since these drivers
can be compiled as modules, that prevents them from using idle_cpu().

So, expose the function to be available to modules.

Signed-off-by: Prashant Malani <pmalani@google.com>
---

Patch first introduced in v2.

 kernel/sched/syscalls.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 547c1f05b667..0fd5e2dafcf7 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -216,6 +216,7 @@ int idle_cpu(int cpu)
 
 	return 1;
 }
+EXPORT_SYMBOL_GPL(idle_cpu);
 
 /**
  * available_idle_cpu - is a given CPU idle for enqueuing work.
-- 
2.50.0.rc2.701.gf1e915cc24-goog


