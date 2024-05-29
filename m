Return-Path: <linux-pm+bounces-8391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4678D3B89
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 17:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95AA28239A
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63249180A92;
	Wed, 29 May 2024 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hGgsJGqD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qzga3S9d"
X-Original-To: linux-pm@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E602B21A19
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998265; cv=none; b=T1icBq5rwXYS7vV4C7EEk9pp7qHLCXDF4/sHph9Gls7ep2Ne3XwciPJifK3ahzewWEpzhgZ5dX2jC+VFovzKZv+tZPLUUghV3mdPHlF6XQYxrejmYek6z95Vq06zKtMdpmYdghqxYIBPCsUs89TZvYeHRP5r5JNDLE73Gn/TyXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998265; c=relaxed/simple;
	bh=lHr3olXZxyB1ju5NW2zwzlVf1GCslbnJjGx2kCSfrkU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y7+n477CF7065VdSoK2cC8zNmRRxhk3TGyz3oYznsxpDqkZJpFCA0FSNJaXLDj+l4Sgw7O2tAsMi68itrpaZ08U0VulnfXO4lLxJxQjhU70/+ghYi8nPUoLP+8yDm9GHk21lLyUNqANO34aUsVeAapwcF0K0IH++yb07+XWxkRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hGgsJGqD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qzga3S9d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 May 2024 17:57:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716998261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VWLqtdqtcaalMm2GWtw9x7IxLHoV41zWEwnvwc7VjEA=;
	b=hGgsJGqDzZrWeVcNLrRssbad9dHwf6E31nu6FuLiFGZmWNzz8rIuHuUxIbKF4nxuzH5HDg
	jDLzUVHSw2CmBUAHgMV0vd4PUgysLC94v/LKJ/2tqwgIVd7g3xdSmxG4oKwBebe+sAmAaR
	Jg/0b17Bc2wzIxPsSOCsGwjLyU+CEkbeTpdQ2M5BH91srSFFlAM7TwsDx8D3jkfXQaEbu7
	LYMVgKOV30wEZaA1onNzzqtkyOk5co9dykHG40vXpn4xJZO6KxsV4tZ8el41m3wSepOUan
	wCmG76rBclo8AJJn2p9rTnEhrnLoBGb/lbnGOON3x2RN8R9vkF/a2ERlD5Y/fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716998261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VWLqtdqtcaalMm2GWtw9x7IxLHoV41zWEwnvwc7VjEA=;
	b=Qzga3S9dgaeho+zInyb4W/afIoPj5LKJ5heR4BEgRF62crJJqmfYvjt8iteBW7GGpw8dNJ
	kj8pY0Qf1xoixRBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: intel_pstate_get_hwp_cap on wrong CPU
Message-ID: <20240529155740.Hq2Hw7be@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this just popped up:
| [ 6538.614568] unchecked MSR access error: RDMSR from 0x771 at rIP: 0xfff=
fffff817d2250 (__rdmsr_on_cpu+0x20/0x50)
| [ 6538.625714] Call Trace:
| [ 6538.629156]  <TASK>
| [ 6538.675067]  generic_exec_single+0x58/0x120
| [ 6538.680236]  smp_call_function_single+0xbf/0x110
| [ 6538.696333]  rdmsrl_on_cpu+0x46/0x60
| [ 6538.700894]  intel_pstate_get_hwp_cap+0x1b/0x70
| [ 6538.706420]  intel_pstate_update_limits+0x2a/0x60
| [ 6538.712110]  acpi_processor_notify+0xb7/0x140
| [ 6538.717479]  acpi_ev_notify_dispatch+0x3b/0x60
| [ 6538.722910]  acpi_os_execute_deferred+0xf/0x20
| [ 6538.728346]  process_one_work+0x13d/0x350
| [ 6538.733342]  worker_thread+0x2c2/0x3d0
| [ 6538.743066]  kthread+0xca/0x100
| [ 6538.751844]  ret_from_fork+0x2c/0x40
| [ 6538.761073]  ret_from_fork_asm+0x11/0x20
| [ 6538.765993]  </TASK>

| root@h:~# grep . /sys/devices/system/cpu/intel_pstate/*
| /sys/devices/system/cpu/intel_pstate/max_perf_pct:100
| /sys/devices/system/cpu/intel_pstate/min_perf_pct:36
| /sys/devices/system/cpu/intel_pstate/no_turbo:0
| /sys/devices/system/cpu/intel_pstate/num_pstates:4294967285
^ =3D> -EAGAIN

| /sys/devices/system/cpu/intel_pstate/status:passive
| /sys/devices/system/cpu/intel_pstate/turbo_pct:0

|# cpupower frequency-info
|analyzing CPU 0:
|  driver: intel_cpufreq
=E2=80=A6

=66rom turbostat:
| CPUID(0): GenuineIntel 0xf CPUID levels
| CPUID(1): family:model:stepping 0x6:3f:4 (6:63:4) microcode 0x1a
| CPUID(0x80000000): max_extended_levels: 0x80000008
| CPUID(1): SSE3 MONITOR SMX EIST TM2 TSC MSR ACPI-TM HT TM
| CPUID(6): APERF, TURBO, DTS, PTM, No-HWP, No-HWPnotify, No-HWPwindow, No-=
HWPepp, No-HWPpkg, EPB
| cpu4: MSR_IA32_MISC_ENABLE: 0x00850089 (TCC EIST MWAIT PREFETCH TURBO)
| CPUID(7): No-SGX No-Hybrid

This is v6.10.0-rc1.

Sebastian

