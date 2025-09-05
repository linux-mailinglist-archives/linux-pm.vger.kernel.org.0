Return-Path: <linux-pm+bounces-33992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A95B459AB
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 15:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CAE5A0372
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4B935CED4;
	Fri,  5 Sep 2025 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTZZUtNK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D9E35CED1;
	Fri,  5 Sep 2025 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080452; cv=none; b=golrRHmHGwgbcm1Ff9ZNIx1NEoo1SBkiAO9UO7C29GwxYq+kFt/2eZ/HBfQ47X9/kK3QwZHHotx0j8yAZcZA2Vggvc+txItKYNKnUsileMHgm5p9Q64PEhd/blusJ/CRMCh3kYY/3DkvPM1yMW3ozvyV4Tlj2/00K1oj8DNXCII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080452; c=relaxed/simple;
	bh=5hFR82aFngQcdQcvd1+b8b9T/pUP9YunoyF6+F+9N0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbII7oV0soohniwJeOdwAL1LL6/Ktp2fkuZ5bneVFShHJ8tEpjDc9gEYC/gfibDU0bSjgCE/JvmPN/3XYaYGeGUoc91BPXX5ZHpNRTJAl4KbtYSrBGjar+m9SvcvP7/1Hk8ghGTF+CUyDDPcQF8DQaSMXImo9lB73R/1q4S+iZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTZZUtNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F7DC4CEF1;
	Fri,  5 Sep 2025 13:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757080451;
	bh=5hFR82aFngQcdQcvd1+b8b9T/pUP9YunoyF6+F+9N0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cTZZUtNKNQC7rw3WkFEpnVdGV/SRYwTP8AKiW5kLkdTEkU6s8VYttO+AeEG8C1l1f
	 D/frXbjxo8ulFtCznMfz7YWcniGkM1nTxvsAZggcHZNSUQniQI8WvykF9rdZyo3IGx
	 86U69iiqOh1BDePwcC0Lz08Or3uR0XugHDEfkZaI5gwFHpHcchCesvB+hYFAnPFMAw
	 YhO6TLjPF9J422SfeXvDuQRIDXGUV5zsO5yja4MllDWzn8o1XaDinb8ZhlA0YtR6Lq
	 YVpsmbqlFKBzBIXEb3l5uBKikfu3D2SkHudWWZ4hc0n2hfe/ZkUkJ/nwTY4cp4qTiu
	 m3HdzWDUXIlJA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Zihuan Zhang <zhangzihuan@kylinos.cn>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject:
 [PATCH v1 3/3] cpufreq: intel_pstate: Adjust frequency percentage
 computations
Date: Fri, 05 Sep 2025 15:53:54 +0200
Message-ID: <3395556.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5028967.GXAFRqVoOG@rafael.j.wysocki>
References: <5028967.GXAFRqVoOG@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Adjust frequency percentage computations in update_cpu_qos_request() to
avoid going above the exact numerical percentage in the FREQ_QOS_MAX
case.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1696,8 +1696,8 @@ unlock_driver:
 static void update_cpu_qos_request(int cpunum, enum freq_qos_req_type type)
 {
 	struct cpudata *cpu = all_cpu_data[cpunum];
+	unsigned int freq = cpu->pstate.turbo_freq;
 	struct freq_qos_request *req;
-	unsigned int freq, perf_pct;
 
 	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpunum);
 	if (!policy)
@@ -1711,14 +1711,12 @@ static void update_cpu_qos_request(int c
 		intel_pstate_get_hwp_cap(cpu);
 
 	if (type == FREQ_QOS_MIN) {
-		perf_pct = global.min_perf_pct;
+		freq = DIV_ROUND_UP(freq * global.min_perf_pct, 100);
 	} else {
 		req++;
-		perf_pct = global.max_perf_pct;
+		freq = (freq * global.max_perf_pct) / 100;
 	}
 
-	freq = DIV_ROUND_UP(cpu->pstate.turbo_freq * perf_pct, 100);
-
 	if (freq_qos_update_request(req, freq) < 0)
 		pr_warn("Failed to update freq constraint: CPU%d\n", cpunum);
 }




