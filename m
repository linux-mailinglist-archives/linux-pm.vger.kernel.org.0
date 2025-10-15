Return-Path: <linux-pm+bounces-36187-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1774CBDED6D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 15:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA073A4135
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 13:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E82C247281;
	Wed, 15 Oct 2025 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZusvWs72"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070A3245032;
	Wed, 15 Oct 2025 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536185; cv=none; b=KCtkrfYh1Bf1+/sgZ/6bfxEYLOMDIWXeNBwhqMw6RbL6z9LSVbuGH4y8VSvf2+sO5qoJ6ommpSnF945JINVlq1ZXHze1sZzVjPYNUVSENKlxCTFkQBe1mVVMk32+sx7sx1fIkBTn4Fe32bccAHy4btgsW5sZejeDyzwGjZ1x+Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536185; c=relaxed/simple;
	bh=VX55w5LNPSVmsOprzx3zNtIjFsD6cqbwWESSD8jO9JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsGwMT/LAQxby1H7sg/prjf6qTbz1BDPsMY+Qb4em2ILU06NDFavYGmbWKvLoRlIQcuna/N8GtvIcch2nUfjYucWb9yYJ6IzxqP7IlYvBpRUlKn8fhzwZVdm0KjKueuB3B50BgB5+vRycyfXCUWwG5gMrsOA/58Qcu2IBctLhYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZusvWs72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54C4C4CEFB;
	Wed, 15 Oct 2025 13:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760536184;
	bh=VX55w5LNPSVmsOprzx3zNtIjFsD6cqbwWESSD8jO9JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZusvWs72Lm9Ddj1nZyRoyGUtTB5RQsJn8JscndOkUuDI8/TcsIFNbVWWF/+CgZKUy
	 nK21Y61U+JabZ5QT7UAL38msWaD8E7rxBDvOcNHmMBD1uBqFQUmdso0mSTl7i4ECJQ
	 ApFweJiIzavCcoXLUD6EolbxesyM5BvQeuIb/5OUq9ZEq65i8fN0Ds9oNeijedSpk5
	 0LPzx1kBRqyz3W3KuZx8ElY0YmNwJneurkIq3LvYtxwyaAB03dtxlvDSubM1FPhiz5
	 it22lNhcXiPO0i5dWVe6v4Halb7P88lSYjDzCRvhZhsBPTd9ZCQWeL27KFdSpq9DK1
	 POXa5N5fTF3Yg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject:
 [PATCH v2 1/3] cpufreq: intel_pstate: Add and use hybrid_get_cpu_type()
Date: Wed, 15 Oct 2025 15:46:40 +0200
Message-ID: <1954386.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2404176.ElGaqSPkdT@rafael.j.wysocki>
References: <2404176.ElGaqSPkdT@rafael.j.wysocki>
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

v1 -> v2: No changes

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




