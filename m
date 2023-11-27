Return-Path: <linux-pm+bounces-243-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DB27F9856
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 05:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853701C208D9
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 04:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D511215C2;
	Mon, 27 Nov 2023 04:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXs7cF+C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5105111
	for <linux-pm@vger.kernel.org>; Sun, 26 Nov 2023 20:31:47 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5bddf66ed63so2520533a12.1
        for <linux-pm@vger.kernel.org>; Sun, 26 Nov 2023 20:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701059507; x=1701664307; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ugKYBVdJPjjbkqHUFhL7nvjkaAnFJgx8Ph1llxuX9d8=;
        b=UXs7cF+C/Ciklhd3/KpdhUYldOJdMY+VVBmgCJCeYNpWhRwagnbh1JNdm8MI5qkUJg
         gE8LGLtc2ttN1hNmttqweWoViahvQqW5Bky4upJ+36zgfoOZbmlJTNEE9iUxC4hJth9T
         s1UMKSDx5F9JAHX6SsTaFhbRAldsySJJWB39miqi98yiiLz04/DDlUC2enTSJA91w0Xu
         aQG42BKd+5EWrzH5WMKfVHT3kGQd/LXCpuzvtc6seOSQxGCbVpecnw93N/0dJNSC4Ock
         AkknJ24QRC3Oapzzx73d7CDREBIxDzWGC4n6zbcDhwYiWEGUuPhT7mMFRj/5595haiv5
         eCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701059507; x=1701664307;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugKYBVdJPjjbkqHUFhL7nvjkaAnFJgx8Ph1llxuX9d8=;
        b=fLKb5k9xUuI+EE8qUDCff/dhGXN0vS7t7xlR5LBtUrl9mR0dQNlJLuZKD+kbfrM+ii
         K3yBQXQucgcO4JP8XaRMFm6z1Rm013BeLoYYUSel+R4uh/XKfeyMQ29CVb50h53HMVhY
         3A1X+XY+Nbaay35y/5gK58XuSR+OHZ6/O/qVgmuoEBegJSKIfEkVjgX5ho7uT554AJNQ
         h9AThknOLZZVCARvgENfubtaVJ8xpf6TTzE7hyJnw9gdRZ8R23qPSnOmT6GQiLjnldD5
         YmH4NhUymROkih2tjmIJyvGdf2Gg69uV1VkA1b6tAN+80YUfJXUa3Xjquan9QD4JopXi
         uXZQ==
X-Gm-Message-State: AOJu0YxS6LHp6XQkC/CiyTQWjP/JtkOzTM01yIRC93rus4Ey0Ug4elzE
	h6WLZ72+RaPVolh4eYiUXwSE+A==
X-Google-Smtp-Source: AGHT+IH7xpWBPhiUIcwQ43brr43rRA7agIR6K70yHmdDLsuEWvmHJegFBzRTqzObaYm6a4gfAH9aiQ==
X-Received: by 2002:a17:90a:e38c:b0:280:72b:397d with SMTP id b12-20020a17090ae38c00b00280072b397dmr18863724pjz.20.1701059507349;
        Sun, 26 Nov 2023 20:31:47 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902ce8b00b001cfb971edf3sm3091511plg.8.2023.11.26.20.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 20:31:46 -0800 (PST)
Date: Mon, 27 Nov 2023 10:01:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] cpufreq/arm fixes for 6.7-rc4
Message-ID: <20231127043144.kkyyaut4e7gpzr2r@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: *

Hi Rafael,

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

for you to fetch changes up to 8f96e29aae31354191227ad476dc7f6147ef1d75:

  pmdomain: qcom: rpmpd: Set GENPD_FLAG_ACTIVE_WAKEUP (2023-11-23 13:08:01 +0530)

----------------------------------------------------------------
Christoph Niedermaier (1):
      cpufreq: imx6q: Don't disable 792 Mhz OPP unnecessarily

Stephan Gerhold (3):
      cpufreq: qcom-nvmem: Enable virtual power domain devices
      cpufreq: qcom-nvmem: Preserve PM domain votes in system suspend
      pmdomain: qcom: rpmpd: Set GENPD_FLAG_ACTIVE_WAKEUP

 drivers/cpufreq/imx6q-cpufreq.c      |  2 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 73 ++++++++++++++++++++++++++++++++++--
 drivers/pmdomain/qcom/rpmpd.c        |  1 +
 3 files changed, 72 insertions(+), 4 deletions(-)

-- 
viresh

