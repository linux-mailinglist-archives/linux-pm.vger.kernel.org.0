Return-Path: <linux-pm+bounces-20660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BA4A165B9
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 04:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D2607A0677
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 03:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A254333987;
	Mon, 20 Jan 2025 03:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vVGpsD2S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47E914A4F9
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 03:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737344132; cv=none; b=dlBCQMyT87HkyC4PtcBIxXnCQCmPfwXNN73jS5b1CmxllYAXQ7eLqc1ihARucbfqpJb9Q5lVZTMxmr7MPmfCNo00E9mhwHMsJtU9C0hSXT8kcRGNTFQBg/u5ch4wZvAAwnxkDbqeXL9eS2br4B2aPK5XOfwsvj5H/O7LRqtutvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737344132; c=relaxed/simple;
	bh=KWRCx4xozR/GhpmwGP7oVsCNRlMGA83eCiiTKE8o/f8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dOSS+PoOqIiIZ5yKhAsOMWhNOpxMrexn7KHeuItwPrhqGyylinXGN/a9x3CPyTjyPMbPb8rkFkAYUwONb7/25SRzDxAXbTDzB/5op7Wvx+d5vBYprOIkyjb6cPv/QTsp9fg2rC8VYaLM0ofn+dSIFCgbXNTaj+laW9XsgfC9JNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vVGpsD2S; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-215770613dbso50774035ad.2
        for <linux-pm@vger.kernel.org>; Sun, 19 Jan 2025 19:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737344130; x=1737948930; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XgG1E066ViJFiVwtsV0FQB0JGhNO+nqLMbzNvzOmFag=;
        b=vVGpsD2SksDeqNxnjA0+Jhy+xY2nyKCTxGLit+tVBZxZsFOKxInrgApdj6oQ2q2p+8
         TMSKPZAU5vZc/Qi9z9591hSxvY1ZLc5E5hdv66uspFtW2QYlv6gwT9AJesoaCuSAxLYj
         lrmddDSGGJqFh/5DiqJSI1unq8PEkjJonScpzWDwZJRdmld4AGVYf1/UNPMtdJ1tbHxD
         OQUs6dxLh9j2yKBgFgXYBJlrQygUCxus4gvkkXjy9VZAQAlD++ZnNancYTyhN4OWN1LL
         F7werA49W8Fy+mSvXgw2/rj+c3DE3VAg6X6D42Mjt21+nZq0nR+7iQk+UpvoJosCo/9u
         3Pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737344130; x=1737948930;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgG1E066ViJFiVwtsV0FQB0JGhNO+nqLMbzNvzOmFag=;
        b=dapv+20hZeUP9gWZu+eIfhMeEuBLzQv2mf90EF8LjALKtXFq7UnjaDB71Uhthnd7t0
         MDmVjVIOYZ479YuL8ZpSc4MZD/31ZxoxhHH56hHqWAQTqOzHCT8KHNbyLQTaI9NX6fG8
         g6FOxvVxcs/kv7g2K16TjHRM5qufUFQuyQlPOjtBRMoCO7Kc08Lc678EP3L0R2eSBN60
         c3vfhikbViQs3L4tleroq7VgzIDZoLWyq7GpIa8j+jeaqtaRO34N66TGGSZmiKec38Yf
         g5hAUlAFZn5LmRK5jvU640lrg6ai8b5P52FqPfi7wJ5x4ctRP2ySNfqeroXABjk4lpUB
         JSvA==
X-Gm-Message-State: AOJu0YwG8YR8Hon4I/dGektnKMXkhM7GmRG5HwVw2mMg64l4RZjUiKoH
	fgPdpZ8qSX1YTS/sZDPB9sZFs0POpRgaCFRaY463LUEA4xP4dl+qVOFE0+MoU8M=
X-Gm-Gg: ASbGnctfKkxAZyBgpjtiTcIphjYyjl4dFKrqdXogh0gyov0X0RvB4J9g2Har+0TcZXh
	xAZnAu4yYZm1wEBp05mUdMQ4Pg1nQPyeoZWbnAnwVdb3jEbF4NIfraoy+m0d9wdKe2RunpxBiy/
	CXXlnpWcUwbOccaLIChZFFa9sOF6wt4D32ir9+zV1e7R3OStcMiMl16eEwUgTUZLCEAEi2mkZlY
	rSxJZ6tz3ZJoSOfYnSGQQMN4+jMNjFpNx+XBxO8XAqNqsk8fXoHhNzNbZdV4DL8IqWjO/qj
X-Google-Smtp-Source: AGHT+IH2geBQuQTR1e8z59IdIUFZ544EOHq+qFieB0Jpj4ShSxKjTzNPc7dI5S+nyy5c+7jfKA4eag==
X-Received: by 2002:a05:6a00:3a11:b0:729:597:4faa with SMTP id d2e1a72fcca58-72dafb530bdmr17340921b3a.16.1737344130115;
        Sun, 19 Jan 2025 19:35:30 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dabaa751asm5906473b3a.162.2025.01.19.19.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 19:35:29 -0800 (PST)
Date: Mon, 20 Jan 2025 09:05:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 6.14
Message-ID: <20250120033527.w7s6bzbuw3sa63u3@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.14

for you to fetch changes up to 84cf9e541cccb8cb698518a9897942e8c78f1d83:

  cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver (2025-01-17 09:05:07 +0530)

----------------------------------------------------------------
ARM cpufreq updates for 6.14

- Extended support for more SoCs in apple cpufreq driver (Hector Martin
  and Nick Chan).

- Add new cpufreq driver for Airoha SoCs (Christian Marangi).

- Fix using cpufreq-dt as module (Andreas Kemnade).

- Minor fixes for Sparc, scmi, and Qcom drivers (Ethan Carter Edwards,
  Sibi Sankar and Manivannan Sadhasivam).

----------------------------------------------------------------
Andreas Kemnade (1):
      cpufreq: fix using cpufreq-dt as module

Christian Marangi (2):
      dt-bindings: cpufreq: Document support for Airoha EN7581 CPUFreq
      cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver

Ethan Carter Edwards (1):
      cpufreq: sparc: change kzalloc to kcalloc

Hector Martin (1):
      cpufreq: apple-soc: Drop setting the PS2 field on M2+

Manivannan Sadhasivam (2):
      cpufreq: qcom: Fix qcom_cpufreq_hw_recalc_rate() to query LUT if LMh IRQ is not available
      cpufreq: qcom: Implement clk_ops::determine_rate() for qcom_cpufreq* clocks

Nick Chan (6):
      dt-bindings: cpufreq: apple,cluster-cpufreq: Add A7-A11, T2 compatibles
      cpufreq: apple-soc: Allow per-SoC configuration of APPLE_DVFS_CMD_PS1
      cpufreq: apple-soc: Use 32-bit read for status register
      cpufreq: apple-soc: Increase cluster switch timeout to 400us
      cpufreq: apple-soc: Set fallback transition latency to APPLE_DVFS_TRANSITION_TIMEOUT
      cpufreq: apple-soc: Add Apple A7-A8X SoC cpufreq support

Sibi Sankar (1):
      cpufreq: scmi: Register for limit change notifications

 Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml |  55 +++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml |  10 ++++++++-
 drivers/cpufreq/Kconfig                                              |   2 +-
 drivers/cpufreq/Kconfig.arm                                          |   8 ++++++++
 drivers/cpufreq/Makefile                                             |   1 +
 drivers/cpufreq/airoha-cpufreq.c                                     | 152 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/apple-soc-cpufreq.c                                  |  56 ++++++++++++++++++++++++++++++++++++++++----------
 drivers/cpufreq/cpufreq-dt-platdev.c                                 |   4 ++--
 drivers/cpufreq/qcom-cpufreq-hw.c                                    |  34 +++++++++++++++++++++---------
 drivers/cpufreq/scmi-cpufreq.c                                       |  45 ++++++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/sparc-us2e-cpufreq.c                                 |   2 +-
 drivers/cpufreq/sparc-us3-cpufreq.c                                  |   2 +-
 12 files changed, 344 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
 create mode 100644 drivers/cpufreq/airoha-cpufreq.c

-- 
viresh

