Return-Path: <linux-pm+bounces-38529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DB8C83C37
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 08:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EAD44E142A
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 07:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006742D7DD9;
	Tue, 25 Nov 2025 07:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MslBaQ3U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E662226D18
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 07:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764056700; cv=none; b=YamVgoT2X0/m5+C5NEJdnvAO9aOILeY5GcVm5qZkFaMyCpNkP+ky15AmbxvY6QCZPHfm6frQcR2Ka62l2888zmu+KW6SpEoeJ7Qb4OQs7RKKTcpTGhFw/MiaKqV6YO0ZSuosFK982UkS+Mclp/bVZOO88E/Vx8keD+8NuMOblrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764056700; c=relaxed/simple;
	bh=QyhkHCyDRphw8ixhJ97vNyqJnzWEhunNl9Wm0mQ+AaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RCk++679VjbCr4Rdn/ffFhU0IeC1vvWLWDt9u8P7x2n6rUnenMVSMMeiIg9SzmEiANPyQBvdGlzc+Tna9Yq3Jl353F4CYbWuWXa34qrEjka5DziIbPCaeSqVapvdpv/njEEIDeQLmXA8wbwUDkUcUDmmhmP7P8bRExde/RSVr+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MslBaQ3U; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3436a97f092so6496437a91.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 23:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764056699; x=1764661499; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HVXJfLDu3qGbmQa1stvkcN//CZFb2AMLbqT1mbqfc8s=;
        b=MslBaQ3UiEh+n8qp8ZzbT5v3px4fSsZRBdPaVIFo7P7rlMK14xfllqGWFvSoONBtDn
         ON93i19qgFxMf9YFdwucYLcg+ni848Sf/Zel2c5IDz7zKKxRm86huwPWmd6GXXpYTrey
         OLx/9c6CmpLcrP2r+e2VmeKgFwBT6/N7LtOkOTQhiQrJGSimUH6ndBdd3W1evWFBHOI7
         vbOyjTuvIGrzzr9FiopVNW/0ChNnkmhlbtby5dkwCpTPQqI+RuU94+WraZCRoweAq9Wp
         cCbQtiFsAjfYeUMAFg6UhFMO/TeMfCk5g2Vimd2Mu6QoIo2iC4zdEL4qfdoW7vm7lQ8P
         NmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764056699; x=1764661499;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HVXJfLDu3qGbmQa1stvkcN//CZFb2AMLbqT1mbqfc8s=;
        b=stbZmT66ohcfmI9X8bx66VVb/Vs2r21grLWnaSvjuWckWaQf+G2DjKF9g9ZGv0OQy0
         SU7TaFP7l8o5rk9T7noEBhgu/9WFZBm2ltw8sFNI/WiBuNezozAznpjNyUp6a1VG+57L
         72GgPNkO5LA/M9+GTf1dtorjd/ejtQXe18+1dCbhbRoAryDyTVWCam+Ro8qfosMajGRc
         HLihaiwyjpGqnCBRqFGvz1ZGG4bjrVUKRT02YjQjRM+AGpGOMdGy4ktVvfh5a63nlwKR
         36OddL0Ityz3pBufVy0TP545uSOJAywmlKkMLzp8T2kkmi79ybS9wfO6zTeT9Dpq2cUc
         8SFQ==
X-Gm-Message-State: AOJu0YzmZSzrfMsBu2dBKNC1mybqx29XleuZWEfscOsa1boIzISZ2Yd6
	z4SxBki1LjTGGUqAamOKSwfWPWsh/uVi06qqJ4pUP4Hop299c4aLQkYSArscPxf0EgY=
X-Gm-Gg: ASbGncsGGnnwo7dcZL9rFYA2NMxQ8+0Mj6R3wJ7AxIrPyTyl0KydzHJLRXRmppvGJ5U
	4kWqNdOnsTxmWMlo9MucprSphBFLOulT+ylDpDPi0wMC7jKEVTlongtZAflksDky68OXIEz8TSi
	D0PnsCzeM2Dn610+b8z9iFbodqqkkV9CyGJuvT1I1HG8C8f9uhsK9Wgj1Vx7o3C7NO93CHA6FU8
	18pwMhbc+YtwmkDfi65kofZM2eAyroLOBQe9ZiIMASSZRR9Y2v0QlnMSHqgL2F10nXaN424gCVK
	yIuztMvqAo6RwhohkNsC4gNREcXvSQKA1zjXeoPACf0IbqahAvkCpgJEQn32ZSKRRjj7a5X/TBx
	8FbT4zknrAgSUHA7BBWLU8zqP755ne3DqLLQeF1B7dE1xhLB65Oz3DQS80F7FW7tooU52W9vi+1
	EGqolXrdCosO8=
X-Google-Smtp-Source: AGHT+IF7u2I0kC6OZhv9Cp9K3XK6uxID50kkYe28RYfVDk2Gmo8xRYaqCwxVnSF3TizLsiq4UNj7Wg==
X-Received: by 2002:a17:90b:4983:b0:33f:eca0:47ae with SMTP id 98e67ed59e1d1-3475ed5150bmr2116073a91.28.1764056698435;
        Mon, 24 Nov 2025 23:44:58 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34727c4b64bsm16002652a91.10.2025.11.24.23.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 23:44:57 -0800 (PST)
Date: Tue, 25 Nov 2025 13:14:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 6.19
Message-ID: <gwxigmsrpc55d6aruxhhw7f2vbsmeduirzc6kbtztv6rr5ivgd@nbqeh3rajqib>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.19

for you to fetch changes up to c3852d2ca46503c00866d8eea5e18bb67d981f9b:

  cpufreq: qcom-nvmem: fix compilation warning for qcom_cpufreq_ipq806x_match_list (2025-11-21 10:21:13 +0530)

----------------------------------------------------------------
CPUFreq updates for 6.19

- tegra186: Add OPP / bandwidth support for Tegra186 (Aaron Kling).

- Minor improvements to various cpufreq drivers (Christian Marangi, Hal
  Feng, Jie Zhan, Marco Crivellari, Miaoqian Lin, and Shuhao Fu).

----------------------------------------------------------------
Aaron Kling (1):
      cpufreq: tegra186: add OPP support and set bandwidth

Christian Marangi (2):
      cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SMEM
      cpufreq: qcom-nvmem: fix compilation warning for qcom_cpufreq_ipq806x_match_list

Hal Feng (1):
      cpufreq: dt-platdev: Add JH7110S SOC to the allowlist

Jie Zhan (1):
      cpufreq: CPPC: Don't warn if FIE init fails to read counters

Marco Crivellari (1):
      cpufreq: tegra194: add WQ_PERCPU to alloc_workqueue users

Miaoqian Lin (1):
      cpufreq: nforce2: fix reference count leak in nforce2

Shuhao Fu (1):
      cpufreq: s5pv210: fix refcount leak

 drivers/cpufreq/cppc_cpufreq.c       |  17 ++++++++---------
 drivers/cpufreq/cpufreq-dt-platdev.c |   1 +
 drivers/cpufreq/cpufreq-nforce2.c    |   3 +++
 drivers/cpufreq/qcom-cpufreq-nvmem.c |  35 ++++++++++++++++++++++++++++++++--
 drivers/cpufreq/s5pv210-cpufreq.c    |   6 ++++--
 drivers/cpufreq/tegra186-cpufreq.c   | 150 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 drivers/cpufreq/tegra194-cpufreq.c   |   3 ++-
 7 files changed, 194 insertions(+), 21 deletions(-)

-- 
viresh

