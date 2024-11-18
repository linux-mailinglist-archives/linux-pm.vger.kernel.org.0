Return-Path: <linux-pm+bounces-17686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74B59D0868
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 05:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975B6281971
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 04:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D2C126BFA;
	Mon, 18 Nov 2024 04:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XsQ2xvOo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D645613BAC3
	for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 04:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731904206; cv=none; b=MV60dpulGvpC13AJHKyiP+cKcIz4Qg3tQEYHZfoP0wTqOQX86gPd0Xj0FysD9MZz55QCASDFMCkH0PNvL0m4vDL3+uH9xe755ubqjbDdLXGeMzM0ihKK2UTzsozOTMfMngvjMaHGdKTf8XSSEVY5NbcXtcczEuYpgTQrIk0AQCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731904206; c=relaxed/simple;
	bh=aE4WWrLFENlkR0SMobOBdT0yUGHtgnFBlyKq98aR/RU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XrhKIiFeUbfyg0KCXGzerpEcO5agGMRo3Wpajpov3X1nd/8wocv3Z8OQNu+CVTuAI9ZEcIeXxcoN0leLcYDV3Yi2lxhoEQCsRoi+Nq/PKOo4KIU9ZVY/OZqTYiualOH+FTzL8tAnudSzwW/2Vz4q2X5LkeIMnko36TMMfA7QoeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XsQ2xvOo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21207f0d949so9523225ad.2
        for <linux-pm@vger.kernel.org>; Sun, 17 Nov 2024 20:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731904204; x=1732509004; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2w3LLkwNjpeyMYTc7ukGPMU63vuGa03EzO1ZL3vnUg=;
        b=XsQ2xvOoxW13otLxPLG3y928z/+ayV28xllpaf1NsiAAY3K3m3lkf32UqRqZvd/00j
         mKjZ26nC3PB7ZINieoUmkBQwzxorNZP1l5p4KWCDyGrjDOtH9nc9lvzZsxY+7qfKFfLG
         2/4JNSrvfna7Q4tCo9S+FXWxukBoBltfihG/vWGMZRepyYLAGQaRAp4HOiXEy+vU+547
         qmWLUf75atRbfGHJOZhudm8nUWHICV8eSz+4kzHJ57EwO8ctwwNGgUEYBZXGnALWWeiN
         7tlDekkYRfVVYPglchX4gc7yjP1h/qyrh3/GubdKnYS3y6oKLFa46wyWcUYNVph//dPm
         vNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731904204; x=1732509004;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2w3LLkwNjpeyMYTc7ukGPMU63vuGa03EzO1ZL3vnUg=;
        b=JE+e3izXKThKXDFr7C/7d2c/DAQ0Yb3y6mlUvp5t+FrayCpe5iM/LNx5sYZFk8zLac
         qKI8Ro+7RxXMXYeSp3Ii/teGcjdX1KY3s4ToyggIWv3s6jQQ0HxRxPL7F7hmwgpSqaDA
         Bwr0NOwPojJ3P6VdVV3YVLI/cTh5kRu8F5H1vdC92NZkl93jweJUam71AthgWl9rcLc0
         WwX2UdB+JPJYDkMMlJ+lzxRJwfRqdtoeGlw7/UlJK4oKeiPgO/VgSRcbzxKcUyFh1IVw
         JRWnJha+/q8xbsqMRR/x11/8+kMGXmVoieo2FyiQan7uZkMhjKqRJwGOEB0KbC7yDk+u
         0pjw==
X-Gm-Message-State: AOJu0YxD9gOpmYqMh4vaws2MFAEN/v0a9dcmZ3rHQW7cBjVnaxYL7qHF
	QgpwSt4cBZy59QSEqFshtdllg4+iAsjoUsAeBrp4VB12UdzqHSrxb02aGcECxrU=
X-Google-Smtp-Source: AGHT+IG1owe55RlrTYb0sE9t1SVV27PFTJFDRVzhFJRPUdrzSSishd25nF/O8faxAdpoGPijBqpQCw==
X-Received: by 2002:a17:902:f611:b0:20b:bd8d:427c with SMTP id d9443c01a7336-211d0d8ad0dmr151114655ad.23.1731904203989;
        Sun, 17 Nov 2024 20:30:03 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f4677dsm48089835ad.197.2024.11.17.20.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 20:30:03 -0800 (PST)
Date: Mon, 18 Nov 2024 10:00:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 6.13
Message-ID: <20241118043001.ahyxauzetqrfufzq@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.13

for you to fetch changes up to 5df30684415d5a902f23862ab5bbed2a2df7fbf1:

  arm64: dts: qcom: sc8180x: Add a SoC-specific compatible to cpufreq-hw (2024-11-18 09:55:39 +0530)

----------------------------------------------------------------
ARM cpufreq updates for 6.13

- Add virtual cpufreq driver for guest kernels (David Dai).

- Minor cleanup to various cpufreq drivers (Andy Shevchenko, Dhruva
  Gole, Jie Zhan, Jinjie Ruan, Shuosheng Huang, Sibi Sankar, and Yuan
  Can).

- Revert "cpufreq: brcmstb-avs-cpufreq: Fix initial command check"
  (Colin Ian King).

- Improve DT bindings for qcom-hw driver (Dmitry Baryshkov, Konrad
  Dybcio, and Nikunj Kela).

----------------------------------------------------------------
Andy Shevchenko (1):
      cpufreq: loongson3: Check for error code from devm_mutex_init() call

Colin Ian King (1):
      Revert "cpufreq: brcmstb-avs-cpufreq: Fix initial command check"

David Dai (2):
      dt-bindings: cpufreq: add virtual cpufreq device
      cpufreq: add virtual-cpufreq driver

Dhruva Gole (2):
      cpufreq: ti-cpufreq: Allow backward compatibility for efuse syscon
      cpufreq: ti-cpufreq: Remove revision offsets in AM62 family

Dmitry Baryshkov (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add SAR2130P compatible

Jie Zhan (2):
      cppc_cpufreq: Use desired perf if feedback ctrs are 0 or unchanged
      cppc_cpufreq: Remove HiSilicon CPPC workaround

Jinjie Ruan (5):
      cpufreq: CPPC: Fix possible null-ptr-deref for cpufreq_cpu_get_raw()
      cpufreq: CPPC: Fix possible null-ptr-deref for cppc_get_cpu_cost()
      cpufreq: CPPC: Fix wrong return value in cppc_get_cpu_cost()
      cpufreq: CPPC: Fix wrong return value in cppc_get_cpu_power()
      cpufreq: mediatek-hw: Fix wrong return value in mtk_cpufreq_get_cpu_power()

Konrad Dybcio (2):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add SC8180X compatible
      arm64: dts: qcom: sc8180x: Add a SoC-specific compatible to cpufreq-hw

Nikunj Kela (1):
      dt-bindings: cpufreq: qcom-hw: document support for SA8255p

Shuosheng Huang (1):
      cpufreq: sun50i: add a100 cpufreq support

Sibi Sankar (1):
      cpufreq: scmi: Fix cleanup path when boost enablement fails

Yuan Can (1):
      cpufreq: loongson2: Unregister platform_driver on failure

 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml      |   6 +++
 Documentation/devicetree/bindings/cpufreq/qemu,virtual-cpufreq.yaml |  48 +++++++++++++++++
 arch/arm64/boot/dts/qcom/sc8180x.dtsi                               |   2 +-
 drivers/cpufreq/Kconfig                                             |  14 +++++
 drivers/cpufreq/Makefile                                            |   1 +
 drivers/cpufreq/brcmstb-avs-cpufreq.c                               |   4 +-
 drivers/cpufreq/cppc_cpufreq.c                                      | 136 ++++++++++++++++++-----------------------------
 drivers/cpufreq/cpufreq-dt-platdev.c                                |   1 +
 drivers/cpufreq/loongson2_cpufreq.c                                 |   4 +-
 drivers/cpufreq/loongson3_cpufreq.c                                 |   7 ++-
 drivers/cpufreq/mediatek-cpufreq-hw.c                               |   2 +-
 drivers/cpufreq/scmi-cpufreq.c                                      |   4 +-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c                              |  28 ++++++++++
 drivers/cpufreq/ti-cpufreq.c                                        |  10 ++--
 drivers/cpufreq/virtual-cpufreq.c                                   | 333 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/arch_topology.h                                       |   1 +
 16 files changed, 507 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/qemu,virtual-cpufreq.yaml
 create mode 100644 drivers/cpufreq/virtual-cpufreq.c

-- 
viresh

