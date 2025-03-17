Return-Path: <linux-pm+bounces-24133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE86EA641BB
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 07:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91BA1890770
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 06:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0994D218AC4;
	Mon, 17 Mar 2025 06:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JCcf2QKt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E65B13C9A3
	for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 06:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193494; cv=none; b=Uc1GoQnpp1yQVhoc7K3EfuNB0zESijmfZjsW9JJ+oHYUJw4AVg4+mRNaZTDXkhyDENWEeA/EULncmXv+q2bxuZSyCBUjgLFFseQbe4d+zcis0kLlP1vhoYlIjce53fIt7m8jqk4oJSnd6uTRbgWKTJIsHUTTETPXw6/eU0B4ulA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193494; c=relaxed/simple;
	bh=L44vppzfQrb0y6GDHp3yxECqGEORGAinbXNdpNR4UCs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XpxZvcdEyVEZ9l/hMNlnJ7IjqeTC/cclrbz09EsAiEqylLuZhBtB6zElPEg9CWQ3tuZ31caNiLumuo0GX3GhMM7DvPu9LQ+/P6HvgFW4DCIrctH7TQ67R0ma8CHAKhEk7nggbvGDC33uEcLRNpDf7opIHifEoQRFZv1CEWVoApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JCcf2QKt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224171d6826so23107585ad.3
        for <linux-pm@vger.kernel.org>; Sun, 16 Mar 2025 23:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742193492; x=1742798292; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOtHqJpoWLVLaDPmellOXnQAonQ2Nnb3MRY73q/qFhs=;
        b=JCcf2QKtLJFCBrz6RnDY7wXmcTKTfUOU3Gr6lJGTdWIotB8QXBPq4FgJPEGGz85+80
         mvXI7avwq6VYd7tBn6OTChqcBnp94UNOhemN6mgbKfiuOCIUH6sLs8exG3kfAOcumf94
         KaRBKg0qYqU1+5/mvd26J1wMpPgZVKX1HycXwIEqixT1fselFGgcX6mOEMJPHS2RM2ps
         wLORIuXpCGPh5EfzNRQ8L3Vfv3bMahoXBV71dITBQKdlI7nqMimPUo0zI5hO4/zB1/UA
         eGGXvfy4ZxuiSjDvvxELQNiMBT+eeOV2aKlVR4p6eM5wSvpveN4T3ykicRji5YNTkf6d
         oYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742193492; x=1742798292;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOtHqJpoWLVLaDPmellOXnQAonQ2Nnb3MRY73q/qFhs=;
        b=Lp9BH97FCjSBT5Rse42pfogjtUSr/8ZLHCGSCiwUq7i9oK9lY7rlLIKgBHwvRahnQm
         YHrJ6pPnhF0++6aiEVHyXVTujT4a/HFW51fMJfq865ixUrq+uWGdhtxDB/jn+uNOKqFb
         uP07C1xxk856apcbste7cfZfiWoqjASvUIitfVbUSGZJNQ87touggEW8JP0ikG08sTzB
         tpAwE2xyR1Vwtf+GCZcBw0rz9jBYSo6QcTtjuHIW5pfMBnaj6/5b8ehzv2MEU9srQHpE
         24zn+h3Af0CuBFMqh0xcDek14GAImqRxRQoH4XVmRGNct2yQ5O/W0VCBcqtLZ/Ki+plO
         1Z2g==
X-Gm-Message-State: AOJu0YzN1a24HVykhJNPa7Fkg7ikJVKCAv6xIQA2Iqd5eo79fD0WSVsk
	OJxew3JOnBY1AP/bR43EFZOjgwytvrWZM8KWQVwC3PKNQyLLa5toO8gX74gaowM=
X-Gm-Gg: ASbGnctKAaVnUV0SDGNmcV+yuW1T6msdIlXLQk3VBgx1B8cQ+ZeMga2ayWG9WZRyzDi
	dO0Rwm8PcyrBk3Z0bWM5j5nm2VoHIxIs8/fLeisSTWcznPCG/cGVWkQlh8ARN+Losa4Dz22xBgJ
	AZNsRXubC951Iyq0XRJP6gLLx+9cvfWdNVb3GIadHST6yQCHbGTbo0p5pelp8zI8oqNBkQ6r+0j
	BTzRtwnD8yTzscsyRs5v4lVP/1yumfpLLJNE3wryLzK7YjFZjNySzeOuJ3GyiaD0uKhAChOQk+n
	L1vhenqPFaMbx/k4nXvQqVc2K49ahC+YZMFZ8SGgXtgE1M5RrxjvLI+P
X-Google-Smtp-Source: AGHT+IGw31FWgsmMqQU8j59PHHQ5H5I/b11ZTEGAtA4www9chpW5YC+yNSUoaTJVj18B7w+gSh5+7g==
X-Received: by 2002:a17:903:1a27:b0:224:1ef:1e00 with SMTP id d9443c01a7336-225e0a8fc06mr147997085ad.19.1742193492247;
        Sun, 16 Mar 2025 23:38:12 -0700 (PDT)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe7ccsm67431415ad.174.2025.03.16.23.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:38:11 -0700 (PDT)
Date: Mon, 17 Mar 2025 12:08:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 6.15
Message-ID: <20250317063809.756syl6yuazp5shb@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0813fd2e14ca6ecd4e6ba005a9766f08e26020d7:

  cpufreq: prevent NULL dereference in cpufreq_online() (2025-02-05 21:02:39 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.15

for you to fetch changes up to 169b9b1db893eca4f008b665d304eee372b6a627:

  dt-bindings: cpufreq: cpufreq-qcom-hw: Narrow properties on SDX75, SA8775p and SM8650 (2025-03-17 11:35:24 +0530)

----------------------------------------------------------------
ARM cpufreq updates for 6.15

- manage sysfs attributes and boost frequencies efficiently from cpufreq
  core to reduce boilerplate code from drivers (Viresh Kumar).

- Minor cleanups to cpufreq drivers (Aaron Kling, Benjamin Schneider,
  Dhananjay Ugwekar, Imran Shaik, and zuoqian).

- Migrate to using for_each_present_cpu (Jacky Bai).

- cpufreq-qcom-hw DT binding fixes (Krzysztof Kozlowski).

- Use str_enable_disable() helper (Lifeng Zheng).

----------------------------------------------------------------
Aaron Kling (2):
      cpufreq: tegra194: Allow building for Tegra234
      cpufreq: tegra186: Share policy per cluster

Benjamin Schneider (1):
      cpufreq: enable 1200Mhz clock speed for armada-37xx

Dhananjay Ugwekar (1):
      cpufreq: amd-pstate: Remove unnecessary driver_lock in set_boost

Imran Shaik (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCS8300 compatible

Jacky Bai (1):
      cpufreq: Init cpufreq only for present CPUs

Krzysztof Kozlowski (3):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add missing constraint for interrupt-names
      dt-bindings: cpufreq: cpufreq-qcom-hw: Drop redundant minItems:1
      dt-bindings: cpufreq: cpufreq-qcom-hw: Narrow properties on SDX75, SA8775p and SM8650

Lifeng Zheng (1):
      cpufreq: Use str_enable_disable() helper

Viresh Kumar (48):
      cpufreq: Always create freq-table related sysfs file
      cpufreq: dt: Stop setting cpufreq_driver->attr field
      cpufreq: acpi: Stop setting common freq attributes
      cpufreq: apple: Stop setting cpufreq_driver->attr field
      cpufreq: bmips: Stop setting cpufreq_driver->attr field
      cpufreq: brcmstb: Stop setting common freq attributes
      cpufreq: davinci: Stop setting cpufreq_driver->attr field
      cpufreq: e_powersaver: Stop setting cpufreq_driver->attr field
      cpufreq: elanfreq: Stop setting cpufreq_driver->attr field
      cpufreq: imx6q: Stop setting cpufreq_driver->attr field
      cpufreq: kirkwood: Stop setting cpufreq_driver->attr field
      cpufreq: longhaul: Stop setting cpufreq_driver->attr field
      cpufreq: loongson: Stop setting cpufreq_driver->attr field
      cpufreq: mediatek: Stop setting cpufreq_driver->attr field
      cpufreq: omap: Stop setting cpufreq_driver->attr field
      cpufreq: p4: Stop setting cpufreq_driver->attr field
      cpufreq: pasemi: Stop setting cpufreq_driver->attr field
      cpufreq: pmac: Stop setting cpufreq_driver->attr field
      cpufreq: powernow: Stop setting cpufreq_driver->attr field
      cpufreq: powernv: Stop setting common freq attributes
      cpufreq: qcom: Stop setting cpufreq_driver->attr field
      cpufreq: qoriq: Stop setting cpufreq_driver->attr field
      cpufreq: sc520_freq: Stop setting cpufreq_driver->attr field
      cpufreq: scmi: Stop setting cpufreq_driver->attr field
      cpufreq: scpi: Stop setting cpufreq_driver->attr field
      cpufreq: sh: Stop setting cpufreq_driver->attr field
      cpufreq: spear: Stop setting cpufreq_driver->attr field
      cpufreq: speedstep: Stop setting cpufreq_driver->attr field
      cpufreq: tegra: Stop setting cpufreq_driver->attr field
      cpufreq: vexpress: Stop setting cpufreq_driver->attr field
      cpufreq: virtual: Stop setting cpufreq_driver->attr field
      cpufreq: Remove cpufreq_generic_attrs
      cpufreq: Stop checking for duplicate available/boost freq attributes
      cpufreq: staticize cpufreq_boost_trigger_state()
      cpufreq: Export cpufreq_boost_set_sw()
      cpufreq: Introduce policy->boost_supported flag
      cpufreq: acpi: Set policy->boost_supported
      cpufreq: amd: Set policy->boost_supported
      cpufreq: cppc: Set policy->boost_supported
      cpufreq: Restrict enabling boost on policies with no boost frequencies
      cpufreq: apple: Set .set_boost directly
      cpufreq: loongson: Set .set_boost directly
      cpufreq: powernv: Set .set_boost directly
      cpufreq: scmi: Set .set_boost directly
      cpufreq: dt: Set .set_boost directly
      cpufreq: qcom: Set .set_boost directly
      cpufreq: staticize policy_has_boost_freq()
      cpufreq: Remove cpufreq_enable_boost_support()

zuoqian (1):
      cpufreq: scpi: compare kHz instead of Hz

 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 35 +++++++++++++++++++++++++++++++----
 drivers/cpufreq/Kconfig.arm                                    |  2 +-
 drivers/cpufreq/acpi-cpufreq.c                                 |  4 +++-
 drivers/cpufreq/amd-pstate.c                                   |  5 ++---
 drivers/cpufreq/apple-soc-cpufreq.c                            | 18 +-----------------
 drivers/cpufreq/armada-37xx-cpufreq.c                          |  6 +-----
 drivers/cpufreq/armada-8k-cpufreq.c                            |  2 +-
 drivers/cpufreq/bmips-cpufreq.c                                |  1 -
 drivers/cpufreq/brcmstb-avs-cpufreq.c                          |  1 -
 drivers/cpufreq/cppc_cpufreq.c                                 |  9 +--------
 drivers/cpufreq/cpufreq-dt.c                                   | 24 ++----------------------
 drivers/cpufreq/cpufreq.c                                      | 46 +++++++++++++++++++++++++++-------------------
 drivers/cpufreq/davinci-cpufreq.c                              |  1 -
 drivers/cpufreq/e_powersaver.c                                 |  1 -
 drivers/cpufreq/elanfreq.c                                     |  1 -
 drivers/cpufreq/freq_table.c                                   | 15 +++++----------
 drivers/cpufreq/imx6q-cpufreq.c                                |  1 -
 drivers/cpufreq/kirkwood-cpufreq.c                             |  1 -
 drivers/cpufreq/longhaul.c                                     |  1 -
 drivers/cpufreq/loongson2_cpufreq.c                            |  1 -
 drivers/cpufreq/loongson3_cpufreq.c                            | 11 +----------
 drivers/cpufreq/mediatek-cpufreq-hw.c                          |  3 +--
 drivers/cpufreq/mediatek-cpufreq.c                             |  3 +--
 drivers/cpufreq/mvebu-cpufreq.c                                |  2 +-
 drivers/cpufreq/omap-cpufreq.c                                 |  1 -
 drivers/cpufreq/p4-clockmod.c                                  |  1 -
 drivers/cpufreq/pasemi-cpufreq.c                               |  1 -
 drivers/cpufreq/pmac32-cpufreq.c                               |  1 -
 drivers/cpufreq/pmac64-cpufreq.c                               |  1 -
 drivers/cpufreq/powernow-k6.c                                  |  1 -
 drivers/cpufreq/powernow-k7.c                                  |  1 -
 drivers/cpufreq/powernow-k8.c                                  |  1 -
 drivers/cpufreq/powernv-cpufreq.c                              | 11 +----------
 drivers/cpufreq/qcom-cpufreq-hw.c                              | 16 ++--------------
 drivers/cpufreq/qcom-cpufreq-nvmem.c                           |  8 ++++----
 drivers/cpufreq/qoriq-cpufreq.c                                |  1 -
 drivers/cpufreq/sc520_freq.c                                   |  1 -
 drivers/cpufreq/scmi-cpufreq.c                                 | 21 ++-------------------
 drivers/cpufreq/scpi-cpufreq.c                                 |  8 ++++----
 drivers/cpufreq/sh-cpufreq.c                                   |  1 -
 drivers/cpufreq/spear-cpufreq.c                                |  1 -
 drivers/cpufreq/speedstep-centrino.c                           |  1 -
 drivers/cpufreq/speedstep-ich.c                                |  1 -
 drivers/cpufreq/speedstep-smi.c                                |  1 -
 drivers/cpufreq/sun50i-cpufreq-nvmem.c                         |  6 +++---
 drivers/cpufreq/tegra186-cpufreq.c                             |  8 +++++++-
 drivers/cpufreq/tegra194-cpufreq.c                             |  1 -
 drivers/cpufreq/vexpress-spc-cpufreq.c                         |  1 -
 drivers/cpufreq/virtual-cpufreq.c                              |  3 +--
 include/linux/cpufreq.h                                        | 21 ++++++---------------
 50 files changed, 109 insertions(+), 204 deletions(-)

-- 
viresh

