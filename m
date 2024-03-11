Return-Path: <linux-pm+bounces-4824-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C39877DA4
	for <lists+linux-pm@lfdr.de>; Mon, 11 Mar 2024 11:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79FE4B20A08
	for <lists+linux-pm@lfdr.de>; Mon, 11 Mar 2024 10:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F5518643;
	Mon, 11 Mar 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aRbSefV+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD3E224D7
	for <linux-pm@vger.kernel.org>; Mon, 11 Mar 2024 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151792; cv=none; b=CT0Wi50XBshBt1eYPW89YxmGnYIyIo+apJ49c0bcTTxwvPGbLXdmWv/w6v0VIog+rUMNq9m8QCUprieNstuPI7JPA9LfkrMrsZ/aySRJ/al7HLij+2aTZ2w+H3/qtoAgCKso55zijbzKLZ/4cuFVa3TTPm1wbDqb1uvkRhzV7dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151792; c=relaxed/simple;
	bh=deriJDVZUDDw9mTvK5raeTb6M8wQFbpDU1A9sfSRl5M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Fd9IQle1wosegt/T4Be1d1O1UC+g6wnewg9pVOjdvYa7ONzVDKiWwJN3717Rr3dh475EHGXMdHWYdj7zGcTG0Za06EiHODm5A66+ESGhVMs9Fa6MvTsKJa6tU5SVpa1T55tDtl0cuQixp5U5iWM5FCzAdXfD14iCx2bfHNA+7k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aRbSefV+; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-364f791a428so21251255ab.3
        for <linux-pm@vger.kernel.org>; Mon, 11 Mar 2024 03:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710151790; x=1710756590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOQUSgHU4OS9Zt/s174fpifwFiTMKB/qAl225bv2M6c=;
        b=aRbSefV+QHHozC2pCeEtWHYGRbH353gOJw8dXrH+EwVDz4RfvdaedobLTHZTk0K6iw
         tlzTqlilNrJRXdFmsgbOpWPzlVvOePIhYwYr70hXYzM9YjDzdsOD39wuGaigdT5NRMwX
         RIfpXz2Jx0Qk2hpugxzTlq6S1A5cxLNyeNiXDF0cUudHlzaaRmajEZtgSPZz+ySMMb2/
         cp/yfwxbgOVUhmlLpTzKI0MYJ3cUQzc5/3avKD+PWQ3pSiv8lEuJgBaNgntHCL7xy3DI
         sU8bq8Cl7yGWfRM9DheE0Ysqt8koeMXACog7TfXDXKa9/GWcmYo8jbaRtKJy+BcfEc17
         anfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710151790; x=1710756590;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOQUSgHU4OS9Zt/s174fpifwFiTMKB/qAl225bv2M6c=;
        b=Pl/FfC9MCfGlRjmtDj4HDrp1oCC3V2G6YcvdP2vwc45hR80OE8bQkLKXFcJmafBNeP
         nm8lZbsz/Vkm0/xXC3qBCYNiMLWajaPVDQISBn+aBl5twW0A8heeT7eC3vS1XCmk2Dvz
         RkyZchxCV3bLG7NpHA1K71hYeZmhRFRhx94ll6+AmFzNo962VpgrHKRoaaiM4P/i98tq
         xQCrD6RQm0JX4Vh4ZBbsP54Nd3cq9k1eZPB0yLJjTmV+250wNxpa3nA4ycJ+VtEJUMrD
         JlYdPf8Jwn4TRe255U5BioI4iaX7wI8m+JeL6DsyWTI5kvZ7Caep1psJYxDE38x+yMXL
         u0zg==
X-Gm-Message-State: AOJu0YwltnU8EHdJMlhAvWhh1EYSDRh65JiNKWfev3qOGw4rHhnFJOzn
	t6yatUzluTO2scdizcG9P5UxTU2My1ROigFkkFdBqOBmD0rwsu00lDANXiyKwUw=
X-Google-Smtp-Source: AGHT+IEeKdW0dxln432Jz9PG2qo3xxN9ShAyTsvYY9tymSpH0cn5LrXNAd186acoAZrhCaJYSZeKEg==
X-Received: by 2002:a92:cd84:0:b0:365:25c0:c82d with SMTP id r4-20020a92cd84000000b0036525c0c82dmr9643132ilb.28.1710151789721;
        Mon, 11 Mar 2024 03:09:49 -0700 (PDT)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id fd29-20020a056a002e9d00b006e580678dfbsm4033141pfb.193.2024.03.11.03.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 03:09:49 -0700 (PDT)
Date: Mon, 11 Mar 2024 15:39:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 6.9
Message-ID: <20240311100947.mfbotbjngjvirg7m@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Rafael,

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.9

for you to fetch changes up to ad2a91086e288c9ab1d74eee57edabe08bd90471:

  cpufreq: scmi: Set transition_delay_us (2024-03-06 10:54:24 +0530)

----------------------------------------------------------------
ARM cpufreq updates for 6.9

- General enhancements / cleanups to cpufreq drivers (tianyu2, Nícolas
  F. R. A. Prado, Erick Archer, Arnd Bergmann, Anastasia Belova).
- Update cpufreq-dt-platdev to block/approve devices (Richard Acayan).
- scmi: get transition delay from firmware (Pierre Gondois).

----------------------------------------------------------------
Anastasia Belova (1):
      cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return value

Arnd Bergmann (1):
      cpufreq: qcom-hw: add CONFIG_COMMON_CLK dependency

Erick Archer (1):
      Documentation: power: Use kcalloc() instead of kzalloc()

Nícolas F. R. A. Prado (2):
      cpufreq: mediatek-hw: Wait for CPU supplies before probing
      cpufreq: mediatek-hw: Don't error out if supply is not found

Pierre Gondois (3):
      firmware: arm_scmi: Populate perf commands rate_limit
      firmware: arm_scmi: Populate fast channel rate_limit
      cpufreq: scmi: Set transition_delay_us

Richard Acayan (1):
      cpufreq: dt-platdev: block SDM670 in cpufreq-dt-platdev

tianyu2 (1):
      cpufreq: imx6: use regmap to read ocotp register

 Documentation/power/opp.rst                    |  2 +-
 Documentation/translations/zh_CN/power/opp.rst |  2 +-
 drivers/cpufreq/Kconfig.arm                    |  1 +
 drivers/cpufreq/brcmstb-avs-cpufreq.c          |  2 ++
 drivers/cpufreq/cpufreq-dt-platdev.c           |  1 +
 drivers/cpufreq/imx6q-cpufreq.c                | 45 +++++++++++++++------------------------------
 drivers/cpufreq/mediatek-cpufreq-hw.c          | 19 ++++++++++++++++++-
 drivers/cpufreq/scmi-cpufreq.c                 | 26 ++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/driver.c             |  5 ++++-
 drivers/firmware/arm_scmi/perf.c               | 53 +++++++++++++++++++++++++++++++++++++++++++++++++----
 drivers/firmware/arm_scmi/powercap.c           | 12 ++++++++----
 drivers/firmware/arm_scmi/protocols.h          |  4 +++-
 include/linux/scmi_protocol.h                  |  8 ++++++++
 13 files changed, 137 insertions(+), 43 deletions(-)

-- 
viresh

