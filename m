Return-Path: <linux-pm+bounces-4974-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D370B87C8AD
	for <lists+linux-pm@lfdr.de>; Fri, 15 Mar 2024 06:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F221F216A4
	for <lists+linux-pm@lfdr.de>; Fri, 15 Mar 2024 05:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008D3846B;
	Fri, 15 Mar 2024 05:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SA3c/wUO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A0712E6A
	for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2024 05:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710482071; cv=none; b=Yd/74d/Lgamt5oLvodd5A19wl73kTO0Fr5I3wsFfCcqca//PZiS+0Ytg4YJRV9f9lZUSnYa45g02GL/k+tI1vj86sx+DbI63Az+JLEbuiSVPS4SDzXMxRPlpT+ULUBdq1RaTuWzjCxzJuwCyqVd/949q29Tnaxs20Zyx1S2JVUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710482071; c=relaxed/simple;
	bh=nEA6y8haCvw37b55C9tYHXmMOxluqE1/UzReyaDvFvk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TjQ6Ky1SkKwedHwfmzb2vN+ArQ11wcw2yaKDOYkUlOopOAZvJks2T2VRJzHqyx6euiRphkjDAphIAWmQ/U6dyoQE4OqFFQG/L6XpyFDG1+VPpjEslIQ5T4weWV3IR/yvS427LckXpaPKT5ELym31yNjMVzvyr9RIOgN1BWG+P5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SA3c/wUO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e6f69e850bso464813b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Mar 2024 22:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710482070; x=1711086870; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76SlF0xlwG/ttgCEeBEYmklKqILSlmcGAmW1iD+D9j0=;
        b=SA3c/wUO2PsaE0EjPiumhYBEpow0lWB1xvYS6NCYAbbHxsmoPuwKeLbPOlQGO0HyLG
         z1822I1wlds6oo30Jxllcg0DHLM0/yPevJERoGkJnzdC0g9BxXRo/JeUdp7V84YlLGDX
         jo18MzFfKALL80NsXruudyqqpTK9ipG8KQCAUy5srqx1j/VUh9elpWJUWsz9Ec0+dlCQ
         nItrcIFenUQ+J4BsMtsxuRTrcDOKgIyo2DOuxSEjKnA0sE30nkE/Unc1UEv3gP7EegXF
         OZEmN2+0JWj07ORdFwsoiuylC727H87V8snRyXa23WTFrP97YSEzbIdBbtitfIjQwuHs
         9MpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710482070; x=1711086870;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76SlF0xlwG/ttgCEeBEYmklKqILSlmcGAmW1iD+D9j0=;
        b=oXDBJTmBeT5OEUAjBl2TJNzotQRVUshS0NBQYxrg/kAy6OSLhwY1ci01gFiqyeeP9W
         5AmwVYCyDEfXMEjbzgXoswYIkjkJPbuxhHAEg3D2TPmf7bjDRTMlhJRXd7dhBKGe53nb
         Oc7pFYnUjkm0dHshFT1n2DA2AEmKgAAdmWSWUYgbOTPTZemAHsnBvv1hEnEv70Q445ak
         SKwWdcK8V2xJFhIiCK3GZUqNCNmRTNWvRTA+8FyL7KgFzp7yUEybSwGXcEWHzTNvwNuy
         rT7UXdr3uh7V+RCg4S2QCx//7m199BgYX1QwbYoUEQdSe9VIv4PWaOMokDQSkS0RpTdt
         TAOg==
X-Gm-Message-State: AOJu0YwxapsEqq7gbYP7ZouYAg7HAwjPWyFCLz3NINc6DJSQEUD6NSDE
	Btw5ruYoPfNVCsEfmIO5UU2MZLJ92yp9TNJx0KLt283Hq2wz2AroeQ5bfis57WU=
X-Google-Smtp-Source: AGHT+IHqhBNjD8wsZ3Va4MoIqhWFTNuO6DrS8mFfGk+r+dui7aVPW3TR13uTFwLU5ot7GS7nyK+X+g==
X-Received: by 2002:a05:6a00:23c6:b0:6e5:e7c5:9120 with SMTP id g6-20020a056a0023c600b006e5e7c59120mr4312504pfc.19.1710482069620;
        Thu, 14 Mar 2024 22:54:29 -0700 (PDT)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id p19-20020a62ab13000000b006e6c0f8ce1bsm2559369pff.47.2024.03.14.22.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 22:54:29 -0700 (PDT)
Date: Fri, 15 Mar 2024 11:24:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] More cpufreq/arm updates for 6.9
Message-ID: <20240315055427.lvhpxvojegoqrcvy@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

The following changes since commit abb3f9717a67a2666b2bc2f19543a657e3d4ad63:

  OPP: Extend dev_pm_opp_data with turbo support (2024-03-11 10:39:24 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.9-2

for you to fetch changes up to a8e949d41c72a0a860b1c3571d6b274e9b77b6bb:

  cpufreq: scmi: Enable boost support (2024-03-15 11:19:27 +0530)

----------------------------------------------------------------
ARM cpufreq updates for 6.9

- zero initialize a cpumask (Marek Szyprowski).
- Boost support for scmi cpufreq driver (Sibi Sankar).

----------------------------------------------------------------
Marek Szyprowski (1):
      cpufreq: dt: always allocate zeroed cpumask

Sibi Sankar (2):
      firmware: arm_scmi: Add support for marking certain frequencies as turbo
      cpufreq: scmi: Enable boost support

Viresh Kumar (1):
      Merge branch 'opp/boost-data' into cpufreq/arm/linux-next

 Documentation/power/opp.rst                    |  2 +-
 Documentation/translations/zh_CN/power/opp.rst |  2 +-
 drivers/cpufreq/Kconfig.arm                    |  1 +
 drivers/cpufreq/brcmstb-avs-cpufreq.c          |  2 ++
 drivers/cpufreq/cpufreq-dt-platdev.c           |  1 +
 drivers/cpufreq/cpufreq-dt.c                   |  2 +-
 drivers/cpufreq/imx6q-cpufreq.c                | 45 +++++++++++++++------------------------------
 drivers/cpufreq/mediatek-cpufreq-hw.c          | 19 ++++++++++++++++++-
 drivers/cpufreq/scmi-cpufreq.c                 | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/firmware/arm_scmi/driver.c             |  5 ++++-
 drivers/firmware/arm_scmi/perf.c               | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 drivers/firmware/arm_scmi/powercap.c           | 12 ++++++++----
 drivers/firmware/arm_scmi/protocols.h          |  4 +++-
 include/linux/scmi_protocol.h                  |  8 ++++++++
 14 files changed, 160 insertions(+), 45 deletions(-)

-- 
viresh

