Return-Path: <linux-pm+bounces-33736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFF7B42434
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 16:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 605001687ED
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 14:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90B63064B4;
	Wed,  3 Sep 2025 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OR6MKdFg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DFD30ACEC;
	Wed,  3 Sep 2025 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911592; cv=none; b=PY/10Iv2HUXNJIKCVaYsva457nz74WXecu0W4LkgN9PuF8W4lBzpGM2jmtPAVfIAJ8JCCs5Z+xm55CG1llfhxBqIrzwTMeYJHevb+0xYnALEkKSEuQHxbzJq8NowUE62uZFJpMnZ4bRjGjveiYBmelhsVYw/1nTYkpVwwM7f9oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911592; c=relaxed/simple;
	bh=txSRCShFHr3LUVNgVFtikONwwhg9swIbp+KxsjlKvho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oHy9XEj6oDMA3yOE2CGtW0NWXl3D2QhCft1hHJFz0scpEA40FK3rSwOU7RhpU0wL0IYs4IUzzrf3eoqhAHY1dvqV8lzcLLcg/0J9otCFnr4Ym84rVUwDdPpvn0l13KOszpuLMs2UEqzvRxw7OFbliKZlapZnGx/LAsD9M1cOZg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OR6MKdFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A90BC4CEE7;
	Wed,  3 Sep 2025 14:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756911592;
	bh=txSRCShFHr3LUVNgVFtikONwwhg9swIbp+KxsjlKvho=;
	h=From:To:Cc:Subject:Date:From;
	b=OR6MKdFgW5sovt5WrAlfdSX69XVFGuWoYxAtbLoHtZVJOo6/2iWBgvGB9nqQuP1WO
	 qtO0kFLtav+DYQ7dHvvdBPfzhIjOqulQnFmOLehQGhkE0fdPPf0DIgBH/WNuXC6PU3
	 +vlFRjVpxNH6HKtmxs7m++P+tC++LlmrQpoZSTqO1jNO5I8HmViMGW+lKWnQvULDiZ
	 ZRv+P3f7V13YPtvwLlbYNt+GplAVue/3UKyL3GnoPlEgli+2DXF9mpOank5ZAws28t
	 I/MJfoG4peFEzf5emAdJFGN3KSkFPsBWcwXC3Li7McBq/yvq4nDs2bv5Txvzjcuf1X
	 aZaier/RyGSoQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Zihuan Zhang <zhangzihuan@kylinos.cn>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1] cpufreq: intel_pstate: Rearrange variable declaration involving
 __free()
Date: Wed, 03 Sep 2025 16:59:47 +0200
Message-ID: <2251447.irdbgypaU6@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Follow cleanup.h recommendations and define and assign a variable
in one statement when __free() is used.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Zhang, I said the code structure here was intentional, but that was before
the cleanup.h recommendation was pointed out to me.

---
 drivers/cpufreq/intel_pstate.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1502,9 +1502,7 @@ static void __intel_pstate_update_max_fr
 
 static bool intel_pstate_update_max_freq(struct cpudata *cpudata)
 {
-	struct cpufreq_policy *policy __free(put_cpufreq_policy);
-
-	policy = cpufreq_cpu_get(cpudata->cpu);
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
 	if (!policy)
 		return false;
 




