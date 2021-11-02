Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CF344263A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 04:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhKBD4r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Nov 2021 23:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbhKBD4q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Nov 2021 23:56:46 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3690CC061714
        for <linux-pm@vger.kernel.org>; Mon,  1 Nov 2021 20:54:12 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u11so1679006plf.3
        for <linux-pm@vger.kernel.org>; Mon, 01 Nov 2021 20:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zV8VlelAgHX4Y2Cd2GYWibxybxjp9cutuz79DN9ObU8=;
        b=wl1ZuGZXWfwLhNlWlGjOv2q66UeAjAEfbV9VEKFwEuOkIX0w3QzPwmA+HQN3x0MXWH
         9ztkwtdGN0zrVCM6vKGi1rKk4QAod3EYDd8nVIf/Kk5v2nTwLsS5qVB9cBMfpeBFS+au
         gUbcKE1cph2ELhP/xWF7l6FgrQD7ssI3rb9wxSSkjgGJxXI9MSMTBJJ3noyeaSxrGkcE
         3ljOHprjZZJgnKucWQoYd4p/E002yCKySU0SLyDGNK936NDW5x7hoOJon4jxtbvFhD1Q
         CmukLGG97AYujAJz06pPPvA5rURuWL6bZHtiIpVJESFCKHJWSD0NNBk3HGXc1raegZGF
         8OWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zV8VlelAgHX4Y2Cd2GYWibxybxjp9cutuz79DN9ObU8=;
        b=r0fgO/996ME8ImIK+yWLBKDgMu6DP7JNyvv6A8GtvAKGYL/P7ImC8wOL/qEIFdz0Vl
         fGP1URdIQyNQfA8998/6+Va+OiYIe4icKSY0YSLDml9U7PUaAUlJks5IttL97OJZP7Yc
         imUIzrK9gpk6tr9OyLy4Qj6X+2k1PJ4vwgiQm7a21TFlNTe9bQCkbJcKqGZfeKiUbOry
         Aj0y5E7W+CEUCs+HgCpPrbBwI5Hl/plEcRXhWp4ptPMtVnR2+0PNkNK1ujmyzHL01ZWq
         uz+OdpPL259sTiuKcE/NAdZKGxXa/J2xesSBuY/OaBVRsqgikwTzk9l4k7KBIM11ziAi
         jfBA==
X-Gm-Message-State: AOAM532qbzjEnn/ZPH2nnzju70ibmQFuOMSQSfx34+2KyfJvdHL18t54
        SbafxCfLq4hMnZH0hCnqiUyRhw==
X-Google-Smtp-Source: ABdhPJxezWws/+Q+v6hF4MShvzMFzeEPuGFvzsbgD9qKNJxcAR1vC0pQGnUZxx0afuaAAa2P3NHFig==
X-Received: by 2002:a17:90a:e7c3:: with SMTP id kb3mr3661542pjb.5.1635825251768;
        Mon, 01 Nov 2021 20:54:11 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id k14sm1070464pff.64.2021.11.01.20.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 20:54:11 -0700 (PDT)
Date:   Tue, 2 Nov 2021 09:24:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: cpufreq/arm updates for 5.16-rc1
Message-ID: <20211102035409.snv4ehc7n6t52n4x@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request contains following changes:

- Fix tegra driver to handle BPMP errors properly (Mikko Perttunen).

- Fix the parameter usage of the newly added perf-domain API (Hector
  Yuan).

- Minor cleanups to cppc, vexpress and s3c244x drivers (Han Wang,
  Guenter Roeck, and Arnd Bergmann).

Thanks.

--
Viresh

-------------------------8<-------------------------

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

for you to fetch changes up to 4a08e3271c55f8b5d56906a8aa5bd041911cf897:

  cpufreq: Fix parameter in parse_perf_domain() (2021-11-02 09:21:43 +0530)

----------------------------------------------------------------
Arnd Bergmann (1):
      cpufreq: s3c244x: add fallthrough comments for switch

Guenter Roeck (1):
      cpufreq: vexpress: Drop unused variable

Han Wang (1):
      cpufreq: remove useless INIT_LIST_HEAD()

Hector.Yuan (1):
      cpufreq: Fix parameter in parse_perf_domain()

Mikko Perttunen (1):
      cpufreq: tegra186/tegra194: Handle errors in BPMP response

 drivers/cpufreq/cppc_cpufreq.c         | 2 --
 drivers/cpufreq/s3c2440-cpufreq.c      | 2 ++
 drivers/cpufreq/tegra186-cpufreq.c     | 4 ++++
 drivers/cpufreq/tegra194-cpufreq.c     | 8 +++++++-
 drivers/cpufreq/vexpress-spc-cpufreq.c | 1 -
 include/linux/cpufreq.h                | 2 +-
 6 files changed, 14 insertions(+), 5 deletions(-)

