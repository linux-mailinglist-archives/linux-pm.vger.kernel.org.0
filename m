Return-Path: <linux-pm+bounces-1771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2923D822BC1
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jan 2024 12:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F174B231A8
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jan 2024 11:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB4918C38;
	Wed,  3 Jan 2024 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eHHzeKTJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCBD18E2B
	for <linux-pm@vger.kernel.org>; Wed,  3 Jan 2024 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d4c27cd502so8507265ad.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jan 2024 03:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704279720; x=1704884520; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lgTk2QY+f63uqVkVsoCKcI6iKJYKNIbUXNcFH6UdUao=;
        b=eHHzeKTJWN5+EtH2hL6K0C7Aq8FL7CkE/X1Bh3cq0uyuBOQOarEISKu3iQMytZrp3B
         xPJ3B2FX9OvH3ykrR9+ExMELTU3Pt01hVJHVEiV7RMnMBg8wQCS0rL/4JAFhG3ZnVbRh
         d6ytKLWZo7dZlu7JJjoKtCkeaT7zxdDk5nNKpK/pIzAGKzBUPU7DLv7+YGs/E+X0c7hr
         vJJB/85hXOTSmfkbPVvEPcRNQUJtBnnHnX2PCQoac0M0hrX8u+iuumkisM5a0Q4nxz/N
         IJZcJGU5FKzY/Ix1Z/2ATY4l3SPieBfXPdfbzedwwpbEh9/5jOW5HjN0OGcOLUOeccEn
         omnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704279720; x=1704884520;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgTk2QY+f63uqVkVsoCKcI6iKJYKNIbUXNcFH6UdUao=;
        b=XN1xeIBaX/22gh1NiZSbJ9lKUEPDyVg7W695xRGvD95guaDU25J/Ym2Avd0kaAbVb5
         FcpDp6rMM0ZJzsxilYL3k54IIOM9J+6pjF4I2cZKyZCKqpQv5O53LbpwSZ2gU5LRVbJQ
         AttYAQ/p/8XfXKwgMYiSzQhFe92qotzcr5K6MSDOa+GW3Vq2mhIW0op0J/Q1Z6cQDn0B
         EdwsNr4Dgd1Xa1PHNDIJ3qXFzcCdgx0A1kgg8Np6R/0KJSzr1u/jPrcB7zC9/pNCA0ST
         14C7Vnsj8632XYSX4ZgQGDA0XWGMjRWTXIUW56JiUxPhubac1nU5IMUvQUkOMoZW79jF
         MZRQ==
X-Gm-Message-State: AOJu0Yx+9KT4EMBk+PPy3xJ4l0m6M3xAc8PT5q10MNTInn0SGKbB40mQ
	Y69sWPiw/XvBQYmJRk9sq9jsSRyP1/tpJw==
X-Google-Smtp-Source: AGHT+IGbUtr0YkCP5Ji0LkpZSX/w4atWDPAXHn3rpZkzi8QLW6xdszJkV1CeL1LZX95x9/73LmXmSw==
X-Received: by 2002:a17:903:2305:b0:1d4:c1b5:7248 with SMTP id d5-20020a170903230500b001d4c1b57248mr2310383plh.96.1704279719737;
        Wed, 03 Jan 2024 03:01:59 -0800 (PST)
Received: from localhost ([122.172.86.168])
        by smtp.gmail.com with ESMTPSA id iz4-20020a170902ef8400b001d08e080042sm23718433plb.43.2024.01.03.03.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 03:01:59 -0800 (PST)
Date: Wed, 3 Jan 2024 16:31:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 6.8
Message-ID: <20240103110157.5yq5o2hzeq3wwjvc@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

The following changes since commit 8f96e29aae31354191227ad476dc7f6147ef1d75:

  pmdomain: qcom: rpmpd: Set GENPD_FLAG_ACTIVE_WAKEUP (2023-11-23 13:08:01 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.8

for you to fetch changes up to 0990319a0400db1d6069b5549327cd9105a266d5:

  cpufreq: armada-8k: Fix parameter type warning (2023-12-18 11:22:57 +0530)

----------------------------------------------------------------
ARM cpufreq updates for 6.8

- Check return value of a function in SCMI cpufreq driver (Alexandra Diupina).
- Use 'NULL' instead of '0' in Armada cpufreq driver (Gregory CLEMENT).

----------------------------------------------------------------
Alexandra Diupina (1):
      cpufreq: scmi: process the result of devm_of_clk_add_hw_provider()

Gregory CLEMENT (1):
      cpufreq: armada-8k: Fix parameter type warning

 drivers/cpufreq/armada-8k-cpufreq.c | 4 ++--
 drivers/cpufreq/scmi-cpufreq.c      | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
viresh

