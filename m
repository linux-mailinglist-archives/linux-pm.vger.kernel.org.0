Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C70A31E7F1
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 10:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhBRJXp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 04:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhBRJUD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 04:20:03 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7F3C061574
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:18:52 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id z7so911132plk.7
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZfrYdTwVhl0qfLNFPC0R+RH2gzkng0p7ghdQ/UiF9U0=;
        b=QT0+ucAdL/VqkeP+AFXTamPpid8J3w8Z28c1yrNS4fRPPakmtEAsRRFEYGRwmS/MMd
         5SxKv7lx7c7yZMieFywn+VP6vmA9wK9GbOKyaYjs0ZeiVWsb8cii/FIvMhmtl3ij/52N
         qmm2Y223ET31f/NaHwzvebYvWnn0qUpl2JM5hbqdx40L9psppC4k78Tu9fCTvvm4OZmy
         ImGQKEUm70aiI0ZJddzTh/lg96+F+V00nd3GaAm8FNmZKtgr3tTQ7xsgoK8ZEUvWnNZV
         Er36HcN4j+8mHNXNjUyMyKVPxQBrAlvgj3TMyUCq4CPNAUB6lRuaJiPQbeVXdDYVgEu2
         N+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZfrYdTwVhl0qfLNFPC0R+RH2gzkng0p7ghdQ/UiF9U0=;
        b=TJbK8T8XAc5Z4boZ13Y9P+iORqXRa9a3H2b8vj32og9D1s31Sv9c3x5IJG1UsRkcaw
         76AcehGp7j+Jr4C0Zui/Eijsuc9eDCU1vKIZ15vr7TDG69fBIQ4czFFky7bPg4OEYAQ/
         WpiF7hOhJgkJT/HvG/ou7bRoVCbl19o9TncqV7Bp/JulPH5e70rvPZDzBQ2UNw04v/Qf
         HTJMx2Dk2jaGugeQCdR0HP2VICqb7Q+wuzhwovzPUtMBbJ62b/bJEo8QWfJM4elDwgEl
         kBJgmCo5lH7FxrheX7lQt9yIRYlZ2gSN0s1+3w9OSjYrtYC25j99S+EAI0iKt8I14hgi
         1Bew==
X-Gm-Message-State: AOAM531g2YtQNAGh806KtoJ6MOzcmRkCRPnePcVfROhZ6kf8bWNufpIv
        aGlPXWhlXCJAOu9L5AhnRvoUCA==
X-Google-Smtp-Source: ABdhPJx52OLje2eMiNo+eoG4Hc/c+68bZ7JlWsyCiWVmjo6qfIs0Am1kxAbOZSVftHzg0LnA9yGZwA==
X-Received: by 2002:a17:90a:8e83:: with SMTP id f3mr3373250pjo.70.1613639931853;
        Thu, 18 Feb 2021 01:18:51 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id y7sm4942926pfl.127.2021.02.18.01.18.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Feb 2021 01:18:51 -0800 (PST)
Date:   Thu, 18 Feb 2021 14:48:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm fixes for 5.12
Message-ID: <20210218091849.6lem2iaags3dsrz3@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains a single patch to fix issue with cpu hotplug and
policy recreation for qcom-cpufreq-hw driver..

Thanks.

--
Viresh

-------------------------8<-------------------------

The following changes since commit 7114ebffd330bfc5a95b9832a70b6bd857d26fd8:

  cpufreq: remove tango driver (2021-01-21 09:34:46 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

for you to fetch changes up to 67fc209b527d023db4d087c68e44e9790aa089ef:

  cpufreq: qcom-hw: drop devm_xxx() calls from init/exit hooks (2021-02-18 14:35:18 +0530)

----------------------------------------------------------------
Shawn Guo (1):
      cpufreq: qcom-hw: drop devm_xxx() calls from init/exit hooks

 drivers/cpufreq/qcom-cpufreq-hw.c | 40 +++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)
