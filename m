Return-Path: <linux-pm+bounces-38093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC89C614BE
	for <lists+linux-pm@lfdr.de>; Sun, 16 Nov 2025 13:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD3BA3607AB
	for <lists+linux-pm@lfdr.de>; Sun, 16 Nov 2025 12:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C5E2D8783;
	Sun, 16 Nov 2025 12:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqPxz/Pe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D61F2D739C;
	Sun, 16 Nov 2025 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763296560; cv=none; b=R3o7Fc7nC1crTOWapCo/NR0BXb20nJl5b92nE6LOecoiPyUK3Ni3J/NE8AaAF99ik5N3r6Zd8m3a863xiPgNgHLMSX5vzLeJdfvAbbxIay4Ev0rjNaVd+ZFeXrap04vi4DrFGLGGdfyurSRgonhe3GC0+MwCfR+YKKLZe/IGXcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763296560; c=relaxed/simple;
	bh=lMcIGBMhy8VqgOVQaDUqczK4kHn7RhAdi1zeCN8h9Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aN64JuxBWnuoZ4usMRwMICG9LyMFErY0HqBDY+z+v6VnitGsUSl7JIsMr0RaEql17j2dJ181bB2s/J6qCzw4o/NLqohQUzb1YKDpApqDYuhepDAPJmulbRXUgaouW7ZIFaaQ7dDl+3SsaJiEGWxWEvA1GXSQJN1b+6bofSZM8yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqPxz/Pe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C755AC16AAE;
	Sun, 16 Nov 2025 12:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763296558;
	bh=lMcIGBMhy8VqgOVQaDUqczK4kHn7RhAdi1zeCN8h9Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OqPxz/PeuZOo9lTICQb8B1B7JEPZR0qQQoq3nQga9wv6IfDq9um+I37zqcs/TGg9p
	 IRgXYSTuOW4CFdZm7mno5clZxPyPULOOUaAPU/Y1ZNYGwBdiMviinvrUkR/D2mig9t
	 9eWEjBOnuBiFhAUKbvBzGI2YlL780f77FLGsS/GKjKMvOjtteWUhMG3lXv56O3rNDq
	 VZ0as7QavSf5fgdJfoKgXHMrG1hAONev06r0LnSXhMTn3N7R8ZfrUUFUnlhp6u63Xq
	 xdhZVpaXhNe0BRd8w7U1Fvw3hk3RK8pax2Ff0DXqUtZpNd3s+tXRbb8JVGDI+gT2T3
	 tSXN70qjR7i4g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1 1/2] cpuidle: governors: teo: Fix tick_intercepts handling in
 teo_update()
Date: Sun, 16 Nov 2025 13:34:29 +0100
Message-ID: <5085160.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12810244.O9o76ZdvQC@rafael.j.wysocki>
References: <12810244.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The condition deciding whether or not to increase cpu_data->tick_intercepts
in teo_update() is reverse, so fix it.

Fixes: d619b5cc6780 ("cpuidle: teo: Simplify counting events used for tick management")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

I'm planning to apply this for 6.19 on top of

https://lore.kernel.org/linux-pm/6228387.lOV4Wx5bFT@rafael.j.wysocki/

because that patch (indirectly) depends on commit d619b5cc6780.

---
 drivers/cpuidle/governors/teo.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -251,7 +251,7 @@ static void teo_update(struct cpuidle_dr
 		cpu_data->state_bins[idx_timer].hits += PULSE;
 	} else {
 		cpu_data->state_bins[idx_duration].intercepts += PULSE;
-		if (TICK_NSEC <= measured_ns)
+		if (measured_ns <= TICK_NSEC)
 			cpu_data->tick_intercepts += PULSE;
 	}
 }




