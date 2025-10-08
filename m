Return-Path: <linux-pm+bounces-35821-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C80BC6776
	for <lists+linux-pm@lfdr.de>; Wed, 08 Oct 2025 21:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E51E4F1ECD
	for <lists+linux-pm@lfdr.de>; Wed,  8 Oct 2025 19:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762AF2512DE;
	Wed,  8 Oct 2025 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xjyzotxu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2E134BA38;
	Wed,  8 Oct 2025 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759951391; cv=none; b=P7P6rMbf5u8DAOUKCy0UvNMgCqiTa8KW0WCAskuuDhnZXbIMMeRaY1X1G7fr6yYh2flSq2kQhw9o1eDuU1HEFGEA1IuhnYRQsSogVNMh4+wtonFf85QD83YcRYP8m2RqZizM4hI+Q0m2WEZrTGXyOFH/Ix4Bbphwy8eFnl47yZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759951391; c=relaxed/simple;
	bh=3JkAleetMm3DUN6tLijLkkv+W7GTpu9CiH8VgG4UIO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=al51raC/1/S7I6omLQQ/PEb0EVj3qOuQ1sLxvVwNScqJ3COt0TKhCOYAC2fOFCspSl5PWbSbI6K5UalqBc4nImDHslIPd+CGOOv9/+wbh6J4NMad/M4ptqI4RZH7y1J3dBVFURvlfoHhtiRN6UMjGgmjE8+5NS4NgeDQzdwTiBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xjyzotxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C94C4CEE7;
	Wed,  8 Oct 2025 19:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759951388;
	bh=3JkAleetMm3DUN6tLijLkkv+W7GTpu9CiH8VgG4UIO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XjyzotxuVMGHnaf3Ugh08OB6qgvX5TyBanHzbTuqAjRIN+Oh32QLku7E4s8R29pzD
	 MfkwUn1Cq+/HJyGlLUXgYnzWCxVFJt/ylnB9wQsp1bANzZ17Gy3yOlaAu3sWwOnfQd
	 cbIPn61Jx9kmT4xdg8p7m/YFCSVu2jfEQhHFu2QAA9EMZgclvjmXA6LJIenRRtLtOD
	 zFkZSpNLFqHvcCLd/RA3lcf9Ket9aGqLSKr6rE5YRmQDqIxATFfpWaJ3FJEutzIqnq
	 I0IC1QrgGWv+x4/HRarENID1Cii2Kf2f/NSWLnVnYbsdlxVL3T23HPBFNy3kydjDnq
	 tEDX5Te7QgVsw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Christian Loehle <christian.loehle@arm.com>
Subject:
 [PATCH v1 1/3] cpufreq: intel_pstate: Add and use hybrid_get_cpu_type()
Date: Wed, 08 Oct 2025 20:55:38 +0200
Message-ID: <4692569.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5937608.DvuYhMxLoT@rafael.j.wysocki>
References: <5937608.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a function for identifying the type of a given CPU in a
hybrid system, called hybrid_get_cpu_type(), and use if for hybrid
scaling factor determination in hwp_get_cpu_scaling().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -912,6 +912,11 @@ static struct freq_attr *hwp_cpufreq_att
 	[HWP_CPUFREQ_ATTR_COUNT] = NULL,
 };
 
+static u8 hybrid_get_cpu_type(unsigned int cpu)
+{
+	return cpu_data(cpu).topo.intel_type;
+}
+
 static bool no_cas __ro_after_init;
 
 static struct cpudata *hybrid_max_perf_cpu __read_mostly;
@@ -2298,18 +2303,14 @@ static int knl_get_turbo_pstate(int cpu)
 static int hwp_get_cpu_scaling(int cpu)
 {
 	if (hybrid_scaling_factor) {
-		struct cpuinfo_x86 *c = &cpu_data(cpu);
-		u8 cpu_type = c->topo.intel_type;
-
 		/*
 		 * Return the hybrid scaling factor for P-cores and use the
 		 * default core scaling for E-cores.
 		 */
-		if (cpu_type == INTEL_CPU_TYPE_CORE)
+		if (hybrid_get_cpu_type(cpu) == INTEL_CPU_TYPE_CORE)
 			return hybrid_scaling_factor;
 
-		if (cpu_type == INTEL_CPU_TYPE_ATOM)
-			return core_get_scaling();
+		return core_get_scaling();
 	}
 
 	/* Use core scaling on non-hybrid systems. */




