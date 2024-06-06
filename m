Return-Path: <linux-pm+bounces-8737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC548FF468
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 20:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101521F21ABE
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B101D199383;
	Thu,  6 Jun 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NCe97Jy0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A5F16FF26;
	Thu,  6 Jun 2024 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697565; cv=none; b=DiYTaL1OjwY6o9TU0gCPat9mfGfzWJ5eR3zX3LYoDA8mgE4czmHIukG7PA4bCsMzNXbcRdJHGL56FJKz8wKZ7dNazIKl6AimnOCixsseHlAHR6GfLBr4itAvXz8gN7MHqpN31ObALvp4nmEzE8vPbjMttBVbbGwUWGcMFs/tFMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697565; c=relaxed/simple;
	bh=HiI/oLWPaJYnVHp8ME9u+IoBB1OrV4LXCTP5IlQqX2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GRde3nTLzB8zuprFFWDGqMmDNfW6ppIJ/+W/r9SHyJuL8yEgv+ycKh0qXQ7tORmSV9bEgtV4qh95ubJmRLxmoyDSN0ORuPkrsC++54Zzz0ywl2ShkeHOdh6CSP9PBPzrJlIpf8ZS0K7SrsWkx3/EPbBtBoYYy53FxJt/2rVwtos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NCe97Jy0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717697564; x=1749233564;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HiI/oLWPaJYnVHp8ME9u+IoBB1OrV4LXCTP5IlQqX2g=;
  b=NCe97Jy0bzMzWETnnqAkVwooqTzQc1TmwSOddrA4OVp3IETecWZaU0FQ
   eT/Ti/qK64FpS5OAddriwvQJkPKL7v8Nznnnfsa3k/8uITTmXLKTmHzx7
   AIB6DpMBuZiWRys1eA5Y9/Qcg1+sO5sm/eR6+ycWdmZrL13o9mR2BVJuS
   y/eCRZlq11+4zCAsTVncmHGMI0LSgHvSseuzBoficDvTBxRk8hwlDxzw5
   vHlFVwieb2IgZM9aa2qhfrngBfVcetq4LaIzB44Zq4jXF00TWXVKZWVXK
   eVzRKR3zYEB6pe34VEoVYyc50CVJYcYu/94OqMUawUaeod2z19VIWmaM5
   g==;
X-CSE-ConnectionGUID: cDmcBfENSuaNk+2q/2NbjQ==
X-CSE-MsgGUID: zROOiIJkSiCGtI6jQPSWVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="24963466"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="24963466"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 11:12:36 -0700
X-CSE-ConnectionGUID: XNrJW7EeQ5Wyey27xaw8Zg==
X-CSE-MsgGUID: v3t2HpxhQ1m36LJLjA7yFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38122661"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa009.jf.intel.com with ESMTP; 06 Jun 2024 11:12:36 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Update Meteor Lake EPPs
Date: Thu,  6 Jun 2024 11:12:14 -0700
Message-ID: <20240606181214.2456266-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the default balance_performance EPP to 64. This gives better
performance and also perf/watt compared to current value of 115.

For example:

Speedometer 2.1
	score: +19%
	Perf/watt: +5.25%

Webxprt 4 score
	score: +12%
	Perf/watt: +6.12%

3DMark Wildlife extreme unlimited score
	score: +3.2%
	Perf/watt: +11.5%

Geekbench6 MT
	score: +2.14%
	Perf/watt: +0.32%

Also update balance_power EPP default to 179. With this change:
	Video Playback power is reduced by 52%
	Team video conference power is reduced by 35%

With Power profile daemon now sets balance_power EPP on DC instead of
balance_performance, updating balance_power EPP will help to extend
battery life.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index dbbf299f4219..8b0032d6a519 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3429,7 +3429,7 @@ static const struct x86_cpu_id intel_epp_default[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, HWP_SET_DEF_BALANCE_PERF_EPP(102)),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, HWP_SET_DEF_BALANCE_PERF_EPP(32)),
 	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, HWP_SET_EPP_VALUES(HWP_EPP_POWERSAVE,
-							HWP_EPP_BALANCE_POWERSAVE, 115, 16)),
+								    179, 64, 16)),
 	{}
 };
 
-- 
2.44.0


