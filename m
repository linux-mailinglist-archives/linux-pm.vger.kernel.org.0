Return-Path: <linux-pm+bounces-33795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F6DB431F9
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 08:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F88E178500
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 06:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF88523D7D0;
	Thu,  4 Sep 2025 06:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqGAs6I5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CBB1F61C
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 06:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966024; cv=none; b=QtVnr/cNogadmp5RWwOr7qNdHfLNPhYr8EvLiECuwmaR5+XbscsjuQ71OFOj3+P2gPILHfZ0yexwdkaoSRe8GbFIl6964YFhkfvP33raWQUbi30UP5tpHevAPXndoGiSklbCC7Iyt6CkrF9hxaaYXDMnC1WSTk5jfIAeOaiSQ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966024; c=relaxed/simple;
	bh=8VLiRlbdEDGR6S10bYVDOAAlQaQ7lCfTI6kCXLj6o+4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YrV3qV3Ou7XT/LS1ObBCYVWFkw0s3aNoPceSRzUBbFHT12fNpoU/4Go565L9UmOf0wutQsNu1wzPu4uXKrhv6DUMZQS/8QyKzqqFidIW7SkCIipc4wspU3kkKVFSmCip8jDCPf1oxnYemPynAHaP2xu4f1pxjkbYuvpGTssMzQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dqGAs6I5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7723f0924a3so953929b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 23:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756966022; x=1757570822; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XrH5FhNlqSqaASYKthIH8BEM+L5uCH5xK0PYntSpqAs=;
        b=dqGAs6I5X04fo0HtDxaq3AE2+PjStBxw/qVqhHFp07aZJXvypqCQOu7wWZ3R5aMUBq
         lFXHEQzMzq5j6aq7spREJuhXz0wAuxDYg0rUbdhjuunZmmSVkFrzRgSGtfYU5ns8X+vK
         1WtX/PyeczF4X1otx3mNnrWfJIB50wEYHGxI8PzzbaqRk7Su1ACTNFADJdVdRFfJ4KLi
         TgsbQO2kuEMzZFmhaYqWZmhmaJq6BR03mRhmy0iCyj8Xgi8+/al3VzGPgfXwijK8dc2d
         CYIEPPIn8Ydr/hnCbM51ToYltJlOPE3fYq41tgh5RA/uHSlRYtHtDPBaMmipM6+9ZcC4
         OYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756966022; x=1757570822;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XrH5FhNlqSqaASYKthIH8BEM+L5uCH5xK0PYntSpqAs=;
        b=h6pTeXzOJ+nA5rzOLHYCcSSflz7wGkGJ9yqC6Y/8bX/jU4X4SUt3IePV7k+swkP7rq
         lnejYB909R+yII4GQNc3gGvuMUKL2OlgxVHJbgy5W9M391nVJLumbABsfPD+xmPyw5Eq
         0mtAJpA/AD4Lcyvxwn14wsznH1pPxXrd8wXY+aYUQaugH5w0i/Ia+SJnrpE13Xpnyyso
         xJz825s1lkL2k5+85YYjYMIO7dgjAHcWoglYIV/FyGS8BJUGHx1hl75p5a7G7AqgZsNX
         mL229XOPP0tq1sJpZHgtD61nA04ANW+fU/OdVEaEHbr0dPoQ65MsKYG3GzEJcy1TmAv0
         8BPg==
X-Gm-Message-State: AOJu0Yw4D1q4m84PQ3dv7JNQ6E8eo6K+2HsidldO/oPrB2HzE/bboJjs
	cYFfOQqOUH+w7yt+zLp1w+yMMLiNLrlCcB/TO4KJTCR1USbyV3iFt5h1Tu+CWhIeJveKI2x1Tyt
	pqG0q
X-Gm-Gg: ASbGncugyxoMNK5w+uc+3Qn9wRgc4LlV5WmLT5bDNOVf86s7rs/xP0wZ7hUsWPGfUK4
	R4yL3XTbbUmVYH0SwQlXg+7edELuVsUVmW1oXr104USip1V9p9OogGKRH1OS2Zlr8Y81C/UL/hN
	rNQmsvE1dhy3okFEqYaLmCPFblB2ZK2bBH6SKLcbryPGm4ZOg9afvQ35G5bvjJcC2gv4AUm4RfR
	Xnawe2rnqcRxZ/f8+UdIetwR8EBIbRGx6K7U/LWMN9vthiYpvfcOUt2yJUzg4Xf9540t3H7rVSc
	S1vth9DlqN1CZyslbUYOETqwRjRDCZHm7Dbi3XoW/cg2F8/z/fYX0ducX1rOVGtwujN7XQXPJip
	I1Yyv9S3jl+wJQtsRfWHE7HIP
X-Google-Smtp-Source: AGHT+IHnk/l9teAMG9E5B87Jg/EXyeqOB5llncCumUd15rAiQ5fPikP6J8Wqy7iTrp7dKgwZ757QXA==
X-Received: by 2002:a05:6a20:7348:b0:243:c336:7bb0 with SMTP id adf61e73a8af0-243d6e5d4d7mr24894476637.23.1756966022161;
        Wed, 03 Sep 2025 23:07:02 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725b974350sm10545449b3a.72.2025.09.03.23.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:07:01 -0700 (PDT)
Date: Thu, 4 Sep 2025 11:36:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 6.18
Message-ID: <20250904060659.3sdrvfnhscq6wp6d@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

I will out of office until end of September and so the early pull
request.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.18

for you to fetch changes up to 3e681899cc6e6c77eca55dd8c7cc57b27868e8a2:

  cpufreq: mediatek: avoid redundant conditions (2025-09-04 10:20:44 +0530)

----------------------------------------------------------------
CPUFreq updates for 6.18

- Minor improvements to Rust Cpumask APIs (Alice Ryhl, Baptiste Lepers,
  and Shankari Anand).

- Minor cleanups and optimizations to various cpufreq drivers (Akhilesh
  Patil, BowenYu, Dennis Beier, Liao Yuanhong, Zihuan Zhang, Florian
  Fainelli, Taniya Das, Md Sadre Alam, and Christian Marangi).

- Enhancements for TI cpufreq driver (Judith Mendez, and Paresh Bhagat).

- Enhancements for mediatek cpufreq driver (Nicolas Frattaroli).

- Remove outdated cpufreq-dt.txt (Frank Li).

- Update MAINTAINERS for virtual-cpufreq maintainer (Saravana Kannan).

----------------------------------------------------------------
Akhilesh Patil (1):
      cpufreq: armada-37xx: use max() to calculate target_vm

Alice Ryhl (1):
      rust: cpumask: rename CpumaskVar::as[_mut]_ref to from_raw[_mut]

Baptiste Lepers (1):
      rust: cpumask: Mark CpumaskVar as transparent

BowenYu (1):
      cpufreq: Remove unused parameter in cppc_perf_from_fbctrs()

Christian Marangi (1):
      cpufreq: airoha: Add support for AN7583 SoC

Dennis Beier (1):
      cpufreq/longhaul: handle NULL policy in longhaul_exit

Florian Fainelli (1):
      cpufreq: scmi: Account for malformed DT in scmi_dev_used_by_cpus()

Frank Li (1):
      dt-bindings: Remove outdated cpufreq-dt.txt

Judith Mendez (3):
      cpufreq: ti: Support more speed grades on AM62Px SoC
      cpufreq: ti: Allow all silicon revisions to support OPPs
      arm64: dts: ti: k3-am62p: Fix supported hardware for 1GHz OPP

Liao Yuanhong (1):
      cpufreq: mediatek: avoid redundant conditions

Md Sadre Alam (1):
      cpufreq: qcom-nvmem: Enable cpufreq for ipq5424

Nicolas Frattaroli (5):
      dt-bindings: cpufreq: Add mediatek,mt8196-cpufreq-hw binding
      cpufreq: mediatek-hw: Refactor match data into struct
      cpufreq: mediatek-hw: Separate per-domain and per-instance data
      cpufreq: mediatek-hw: Add support for MT8196
      cpufreq: mediatek-hw: don't use error path on NULL fdvfs

Paresh Bhagat (2):
      cpufreq: dt-platdev: Blacklist ti,am62d2 SoC
      cpufreq: ti: Add support for AM62D2

Saravana Kannan (1):
      MAINTAINERS: Add myself as virtual-cpufreq maintainer

Shankari Anand (1):
      rust: opp: update ARef and AlwaysRefCounted imports from sync::aref

Taniya Das (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCS615 compatible

Zihuan Zhang (5):
      cpufreq: brcmstb-avs: Use scope-based cleanup helper
      cpufreq: CPPC: Use scope-based cleanup helper
      cpufreq: s5pv210: Use scope-based cleanup helper
      cpufreq: mediatek: Use scope-based cleanup helper
      cpufreq: tegra186: Use scope-based cleanup helper

 Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt                  |  61 -----------------------------------------
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml            |   2 ++
 Documentation/devicetree/bindings/cpufreq/mediatek,mt8196-cpufreq-hw.yaml |  82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                                                               |   6 +++++
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi                                     |   2 +-
 drivers/cpufreq/airoha-cpufreq.c                                          |   1 +
 drivers/cpufreq/armada-37xx-cpufreq.c                                     |   4 +--
 drivers/cpufreq/brcmstb-avs-cpufreq.c                                     |   4 +--
 drivers/cpufreq/cppc_cpufreq.c                                            |  16 ++++-------
 drivers/cpufreq/cpufreq-dt-platdev.c                                      |   3 +++
 drivers/cpufreq/longhaul.c                                                |   3 +++
 drivers/cpufreq/mediatek-cpufreq-hw.c                                     | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 drivers/cpufreq/mediatek-cpufreq.c                                        |  11 ++++----
 drivers/cpufreq/qcom-cpufreq-nvmem.c                                      |   5 ++++
 drivers/cpufreq/s5pv210-cpufreq.c                                         |   4 +--
 drivers/cpufreq/scmi-cpufreq.c                                            |  10 +++++++
 drivers/cpufreq/tegra186-cpufreq.c                                        |   4 +--
 drivers/cpufreq/ti-cpufreq.c                                              |  12 ++++++---
 rust/kernel/cpufreq.rs                                                    |   2 +-
 rust/kernel/cpumask.rs                                                    |   5 ++--
 rust/kernel/opp.rs                                                        |  13 ++++-----
 21 files changed, 258 insertions(+), 126 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
 create mode 100644 Documentation/devicetree/bindings/cpufreq/mediatek,mt8196-cpufreq-hw.yaml

-- 
viresh

