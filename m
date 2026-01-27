Return-Path: <linux-pm+bounces-41514-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AtdEOKxheGmrpgEAu9opvQ
	(envelope-from <linux-pm+bounces-41514-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 07:56:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59707908A7
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 07:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BBCE30292E9
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 06:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1D232C301;
	Tue, 27 Jan 2026 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ee6f4Zaf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20922E6CD5
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769497000; cv=none; b=BqJppvKAE4a5LoyY2dVvKklDCjeeAUQecHmWv4Ox5a2hw9dAvya57YQPmHVf6iV9ikkNhz3V0GsH/5bR9WzovxmWsq7YCMiF1IK0itnMDwenSTdiJ5A/61weTJq1fTS02tTmCqR3JVm3UGQTuokWwxTMHqtu/XeVsAG6HLZOLtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769497000; c=relaxed/simple;
	bh=AaX1tmRJspEsAi/bC15Y2FA6C9m+5ugGGKracvMrSpI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BLVOQd5ZlR9u2EEq+d3mtHoai8qFc8evysuCnA60lbjCFUW2RASBTcTqhSlSEvfM0/dqr9hGZenaGpHRhEhsDODUSJ59DUBvKznEoMAeY+M6/4YHRGQL7r1bDRp05lPMo4y380BqtPQi5ptRQNqNocMLtrutcMhezuicGlcDOTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ee6f4Zaf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a7bced39cfso58542025ad.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 22:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769496998; x=1770101798; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ZdnqTqXD0uj+h68s3mbFkZF7I8lHgbjhAynpeU9c9M=;
        b=ee6f4Zafv77P3HYdEnqNT34wHvIqL88bMgqLjwyUteJ2NDGYe1ubxQAXtCJBK26w8y
         RQIkreBFu7J0G+Vw6jEYlOcjEIe92D4Yj4KrqBoy/j5+sWRDQIB7IjgkeGFn57FLrr2x
         maipG6GjeI1nrOBXOccufaRNV8opJjLmcPDBx8hudW5o+1sD+2RKvfdZOLF091SGsSp4
         Vi6rq9LASIkgbgMpkQqY5J37NsvSnCfM5f34KMWPX45VKg35GZzFdwue+uHdwZqOz4Qh
         qiTZGjoll3zk2L6/7kJzAjAnROoy4zr26CZ1/NRaZMlMW42yz9B/2jsTSpRoM5xCWdEm
         C8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769496998; x=1770101798;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ZdnqTqXD0uj+h68s3mbFkZF7I8lHgbjhAynpeU9c9M=;
        b=YoAmMyTEJIfc6x3EtTnv1bU05vj9UkND1kHAnQ7RZp4qCSuZRu7+LJdYol90mr/g+i
         Tzk77In3eZAh3IxRcj1VlWWkW05g96GVFWvZvKBax9IonaOQcXCxqdv5pDbgUGii+s+N
         fMJEEB5k2CQ8YfUMvT2GCjVN1V3Q6gZFSsYJ6CzSuYZ/xMSvJO3e8jhxcT1U7X0fY+CQ
         eJuDm88dvvLRcWyY1hYtfrQfUxq+JoQXmO/ldDRPwOlRHGR9G3ovhy4nu136SCdzoTG7
         stfaERvnRXw3ky8fGGNkLcfSwTwpyx6yDCm/AvkVeUCQErmOiK0Q6e5FU3BGt7or5XbO
         DWeA==
X-Gm-Message-State: AOJu0YxROHUQjMubIzPTB1biNUMQ4XMoero//fxgOkSpMIsli0gaeEVe
	aUmHAdn+8Dc77dU3YVIniigtihdhfZ2BDDorkvPeDclJtOPnJPUs//fj0Vl8umxDb42YhEm4npj
	lcnbB
X-Gm-Gg: AZuq6aL3saHvRX6RuZU6gsIDakdzCEFkoL+ARNyLS8eJgdqKO9GcJA1X0VzB5EuYVti
	3jE8FqmESL/PvMfXkzLqsEWabmWPk2G9b8IUY8QaiSssECOAJzzq1YJ+6khI7nlJAwgy7/aZFZU
	AtfwB9PBkDRkCL3dAOawiGfD6/X3Q1OuXOemlCNEkKP0tq1kooAsHPSQyxJERUSffahloQxOyx/
	RJhnkCatYtczEuHIrVlrh64jM2ZnBwvF4tXChzto5HvtGGKR7dHF1QhpDIROug0xdXzkojP+LtZ
	kj7DRW6Oty1jK+AGF8rzmpQzjhG61hVtSV8lK7nsQOgSCUw1B9BJJjZyp7NusO4BS/oSEaisQBB
	V8kTEKVghU6UCS8el+5vre3MVQsa0QiOAiUeAQz5qoUd8WzBsoQPXnjvR+adOd+dmWvXtHEnXA3
	OpWUO0jbkzM3OvAapyufF9CA==
X-Received: by 2002:a17:903:13c8:b0:2a3:e7fe:646e with SMTP id d9443c01a7336-2a870d7bd5amr9624415ad.5.1769496997829;
        Mon, 26 Jan 2026 22:56:37 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802fdd4e8sm107587385ad.99.2026.01.26.22.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 22:56:37 -0800 (PST)
Date: Tue, 27 Jan 2026 12:26:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 7.0
Message-ID: <j4qdid7iqmng4gzb5ozefemjkep3wx2b5z2yki5tnqc3vzvzf4@kvrnarvdod5p>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-41514-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim]
X-Rspamd-Queue-Id: 59707908A7
X-Rspamd-Action: no action

Hi Rafael,

The following changes since commit 7e3debb4c72fe840d60014192cf93950871fb3be:

  cpufreq: qcom-nvmem: add sentinel to qcom_cpufreq_ipq806x_match_list (2026-01-27 11:21:22 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-7.0-rc1

for you to fetch changes up to 0b7fbf9333fa4699a53145bad8ce74ea986caa13:

  cpufreq: scmi: Fix device_node reference leak in scmi_cpu_domain_id() (2026-01-27 11:21:24 +0530)

----------------------------------------------------------------
CPUFreq arm updates for 7.0

- Update cpufreq-dt-platdev list for tegra, qcom, TI (Aaron Kling,
  Dhruva Gole, and Konrad Dybcio).

- Minor improvements to the cpufreq / cpumask rust implementation
  (Alexandre Courbot, Alice Ryhl, Tamir Duberstein, and Yilin Chen).

- Add support for AM62L3 SoC to ti-cpufreq driver (Dhruva Gole).

- Update FIE arch_freq_scale in ticks for non-PCC regs (Jie Zhan).

- Other minor cleanups / improvements (Felix Gu, Juan Martinez, Luca
  Weiss, and Sergey Shtylyov).

----------------------------------------------------------------
Aaron Kling (1):
      cpufreq: Add Tegra186 and Tegra194 to cpufreq-dt-platdev blocklist

Alexandre Courbot (1):
      rust: cpufreq: always inline functions using build_assert with arguments

Alice Ryhl (1):
      rust: cpufreq: add __rust_helper to helpers

Dhruva Gole (2):
      cpufreq: dt-platdev: Add ti,am62l3 to blocklist
      cpufreq: ti-cpufreq: add support for AM62L3 SoC

Felix Gu (1):
      cpufreq: scmi: Fix device_node reference leak in scmi_cpu_domain_id()

Jie Zhan (3):
      ACPI: CPPC: Factor out and export per-cpu cppc_perf_ctrs_in_pcc_cpu()
      cpufreq: CPPC: Factor out cppc_fie_kworker_init()
      cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs

Juan Martinez (1):
      cpufreq/amd-pstate: Add comment explaining nominal_perf usage for performance policy

Konrad Dybcio (1):
      cpufreq: dt-platdev: Block the driver from probing on more QC platforms

Luca Weiss (1):
      dt-bindings: cpufreq: qcom-hw: document Milos CPUFREQ Hardware

Sergey Shtylyov (1):
      cpufreq: scmi: correct SCMI explanation

Tamir Duberstein (1):
      rust: cpufreq: replace `kernel::c_str!` with C-Strings

Yilin Chen (1):
      rust: cpumask: rename methods of Cpumask for clarity and consistency

 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml |  2 ++
 drivers/acpi/cppc_acpi.c                                       | 48 +++++++++++++++++++++++++++---------------------
 drivers/cpufreq/amd-pstate.c                                   | 13 +++++++++++++
 drivers/cpufreq/cppc_cpufreq.c                                 | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------
 drivers/cpufreq/cpufreq-dt-platdev.c                           |  6 ++++++
 drivers/cpufreq/rcpufreq_dt.rs                                 |  5 ++---
 drivers/cpufreq/scmi-cpufreq.c                                 |  3 ++-
 drivers/cpufreq/ti-cpufreq.c                                   | 34 +++++++++++++++++++++++++++++++++-
 include/acpi/cppc_acpi.h                                       |  5 +++++
 rust/helpers/cpufreq.c                                         |  3 ++-
 rust/kernel/cpufreq.rs                                         |  5 +++--
 rust/kernel/cpumask.rs                                         | 10 +++++-----
 12 files changed, 164 insertions(+), 66 deletions(-)

-- 
viresh

