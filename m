Return-Path: <linux-pm+bounces-10646-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 107689281B2
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 08:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289C01C22682
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2024 06:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A661713C8F6;
	Fri,  5 Jul 2024 06:07:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F06133C7;
	Fri,  5 Jul 2024 06:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720159637; cv=none; b=kBoywwMAIRuZ2VrHflp/6jlnpVUaL/CEKpRihuOxN56hu2M7cGL8nX3FM9H0lXGPRKlhXsmppeG6pLNZCfZmF5TF0D6aCxu0Us4BCO/5F09paMzN3G1/E+/ikeEV3eYPzD63Q6ddslZOX2MBpO14lvoD00xNNCVacLpHv+zI3fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720159637; c=relaxed/simple;
	bh=z9pwhqwAIL62YzsCyePpOp6we8Xub1j6kh9nnjf4XQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DEKvdXVZZoL71v/kWl3X3iXg71xTyvtrMsPACGFDwSDBKTLbEzmCLc5zbVYFDimS3LUmos2ClqYMGxwexgArjHt/93+9OIk+qJZ54RzYe6mg2f1rmvzWOi9mv4+EGK9ZfFEvE0kwFgBl+8AtVtKHvNXsiHrjVw3JkeVePBP4zMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2C2C116B1;
	Fri,  5 Jul 2024 06:07:14 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V3 0/2] LoongArch: Add Loongson-3 CPUFreq driver support
Date: Fri,  5 Jul 2024 14:06:47 +0800
Message-ID: <20240705060650.243497-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series add architectural preparation and CPUFreq driver for
Loongson-3 (based on LoongArch).

Some of LoongArch processors support DVFS, their IOCSR.FEATURES has
IOCSRF_FREQSCALE set. And they has a micro-core in the package called
SMC (System Management Controller) to scale frequency, voltage, etc.

V1 -> V2:
1, Use module_platform_driver() instead of module_init()/module_exit();
2, Move the lock protection into do_service_request();
3, Add light-weight hotplug support with help of online()/offline() callbacks;
4, Simplify loongson3_freq_data by removing cur_cpu_freq;
5, Remove unneeded cpu_online() checking.

V2 -> V3:
1, Sort header files in alphabetical order;
2, Use devm_kzalloc() instead of kzalloc();
3, Set to the default frequency at module exit and suspend;
4, Simplify loongson3_cpufreq_probe() and loongson3_cpufreq_target();
5, Update and fix comments.

Huacai Chen(2):
 LoongArch: Add architectural preparation for CPUFreq.
 cpufreq: Add Loongson-3 CPUFreq driver support.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
2.27.0


