Return-Path: <linux-pm+bounces-25789-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BE3A94D42
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 09:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D7D3AC183
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 07:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4460F202C44;
	Mon, 21 Apr 2025 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VPFj5hwT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4001B67F
	for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220884; cv=none; b=LP7B0lHe3+dWL+77vVTkqNqRjhbYU++WpYIW24M4UC/iRPokX+y5WPNKIWaQSIOpArA44QJiuSDs9KEIBIlod311OJayzx6eE+BQIeKfchvxOSvZIy6ViLLt0BQwcnYoqArvOgnV97By0dfBahrYh6CntuSdPHGEdgkA93Jb/3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220884; c=relaxed/simple;
	bh=fDpRYO1Z2YX/DdTp8WLQGdxmotevsK+NToNkdoq9Sfs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tnJm2pF2TJ1Zih1dZuVdAZ7N+yyW0M3l0OyJtAtRT8Jpu2HfIuzHhuw3bojTHyuWboRsOEHOoBvr9mdD6KWrc7SoHAwWeZZScodyPo9c+auLL6uDTrFBYjihK3+Ejd/NVE8XCZj5vjcQFUwUVCPM3SjY8WUJ1EjUiBJFTxZGwuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VPFj5hwT; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b0b2d1f2845so2486944a12.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Apr 2025 00:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745220880; x=1745825680; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6w0415T9gFcRNt9x+CeiTVi/8+MImaVeGRbe4LdkVb0=;
        b=VPFj5hwTwk9BoneKfBk5z7S6pcSDFCru8tC1tYOp6x+xXQHs8dVzKlW2AkoLjwoZWd
         PRRLQHKKZZYIWY2swWmshoX0Z9XU5LN43LL8D+GgnVYToKlpbyBGNB5Rh4R7R1St76IR
         3KG4/FqZ9qlWQshNuRTZpmUqEjSWhukunUZzO566nSOgq19bYhNE3FKTHMWWdIGnlKFW
         dIpNAiQX2rgth7YfqP2PTprEyFvH+wpZzSjC/2m9+fADKZpsPmw+SoILBBjAaQBrq68Q
         N5bzEeZvZjfbfUhlmoZH2s36zxRNdSYvRzo+mfgWtckKuIaAjLoPHon/qnP/zc2e8WBo
         aHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745220880; x=1745825680;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6w0415T9gFcRNt9x+CeiTVi/8+MImaVeGRbe4LdkVb0=;
        b=rneavnQUuHKTcO2oKzcveXrxYvnZFO6rpjD+Fpna8IBUiLzhyZL3k0L03nH04IBSQ4
         oOiaGruDZnKIPT8TY5vh5r7oJjaiCjiFenYAGtg5ztC3zSKNwxdkIgC+ERWC04x2jGk4
         Vt3V1K7y7v/63D70hZc8pU1RtcxSHk4Zpxy/i6RmhiO8Ts6gIE6yRVZvl6Yp/aDPs6yv
         ckxuOCjSfVaBQ85rdWn35QSeYHYd9Q3f8cUxZLizVApLQW+ra7jyxcmn7vi4HSKAFb0O
         hWtZAe9ISVg2ep7Tf0+5kadWMfMAfAJHgbUAWnKYr+BLhsha8Zm7Hi2QiyevE2R+gRbU
         ku5g==
X-Gm-Message-State: AOJu0YxSy/lTSeQf3S8Caj4UhEL4/lfww8QiekJaKwSLe4eVlBjApO3K
	RdLJOLBwW3JTmImALELE48c7z7SVA2dSDy7nNa2aWDOrYbeht432y83ZUEA5Too=
X-Gm-Gg: ASbGncs3cZJE8p2pqElrGHnFprnuOWvCfl5CHTSHYFAOnPfuZI6u9cxZYQl94Y+J28G
	seSzB2ZsFCFr4+mvZM+jpHlChvLRcSAZg3LkoqRQkvalxucZtcyilHymP2iQffRltF3glzf78jb
	cr1E0vUcWSD9bvSbfyPEGW+QTJKo8YgPYHvjSmpSgIkrzm3+jgawVfxQeJA2hoeyYernmVHQDdU
	6rPeCsQ1ikq/B5HPzrrpEp35k0DlPoZL0KPK5b3JwTOJuT9erwtp2bpGTt9/FfA6WEbrmv2Y2Na
	HHDa3kR0/cwCuoS1oNTgzMuY0OdVSNl/zD8AIrEpag==
X-Google-Smtp-Source: AGHT+IFwYZXeapBI2C26ALdlWm9FLoml6wZus9IPwJYPjrp+Walc02ZRCqTPFVD9Ie/+eaTtqDUmrg==
X-Received: by 2002:a05:6a20:2d0b:b0:1f5:7eb5:72c7 with SMTP id adf61e73a8af0-203cbd212bamr15558562637.29.1745220879922;
        Mon, 21 Apr 2025 00:34:39 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db14488adsm5091026a12.61.2025.04.21.00.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 00:34:39 -0700 (PDT)
Date: Mon, 21 Apr 2025 13:04:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm fixes for 6.15-rc
Message-ID: <20250421073437.u5wfnuvjd2pfqtfr@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-fixes-6.15-rc

for you to fetch changes up to a374f28700abd20e8a7d026f89aa26f759445918:

  cpufreq: fix compile-test defaults (2025-04-17 13:36:29 +0530)

----------------------------------------------------------------
ARM cpufreq fixes for 6.15-rc

- Fix possible out-of-bound / null-ptr-deref in drivers (Andre Przywara
  and Henry Martin).

- Fix Kconfig issues with compile-test (Johan Hovold and Krzysztof
  Kozlowski).

- Fix invalid return value in .get() (Marc Zyngier).

- Add SM8650 to cpufreq-dt-platdev blocklist (Pengyu Luo).

----------------------------------------------------------------
Andre Przywara (1):
      cpufreq: sun50i: prevent out-of-bounds access

Henry Martin (3):
      cpufreq: apple-soc: Fix null-ptr-deref in apple_soc_cpufreq_get_rate()
      cpufreq: scmi: Fix null-ptr-deref in scmi_cpufreq_get_rate()
      cpufreq: scpi: Fix null-ptr-deref in scpi_cpufreq_get_rate()

Johan Hovold (1):
      cpufreq: fix compile-test defaults

Krzysztof Kozlowski (1):
      cpufreq: Do not enable by default during compile testing

Marc Zyngier (1):
      cpufreq: cppc: Fix invalid return value in .get() callback

Pengyu Luo (1):
      cpufreq: Add SM8650 to cpufreq-dt-platdev blocklist

 drivers/cpufreq/Kconfig.arm            | 20 ++++++++++----------
 drivers/cpufreq/apple-soc-cpufreq.c    | 10 ++++++++--
 drivers/cpufreq/cppc_cpufreq.c         |  2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c   |  1 +
 drivers/cpufreq/scmi-cpufreq.c         | 10 ++++++++--
 drivers/cpufreq/scpi-cpufreq.c         | 13 ++++++++++---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 18 ++++++++++++------
 7 files changed, 50 insertions(+), 24 deletions(-)

-- 
viresh

