Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5D2402295
	for <lists+linux-pm@lfdr.de>; Tue,  7 Sep 2021 06:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhIGEBG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 00:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhIGEBG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Sep 2021 00:01:06 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF23C061575
        for <linux-pm@vger.kernel.org>; Mon,  6 Sep 2021 21:00:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j1so5437959pjv.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Sep 2021 21:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=P6N3k+v1QsznvPwsyxxss9FzEDb00hjXghyZ/Ozv+70=;
        b=OOmqWnecN2I5UcwBMEH+WWiX2uoqCSoT7ukfHGM+idFyxWhr0NVvIijMQhsGL+lGHm
         D8QrTZL4buhjO2vL0DKGJT2hVkHsg5L63MKVAxFht7ZxkOIe9owWaj+Wsasg5x/rej3s
         xt5vmF8AjTVPWXCX9rz1Ayr9uT2N5eMgC0w7nmIZAD1yVsSC7/SwDU6ECjvGWKZVJ4jc
         6gt3uNUdq+CXqnvtBxlPPBLZRIVCzHGtMAMUu6Q9xzw41TSe3ba4CL1kYpOtouRjF5fp
         sPWUrklEcfEOnK1pL71Xgkda8IVUNKE4c+PYYfXBtcLrQwI060vqR5lrvno511rSHfa6
         oWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=P6N3k+v1QsznvPwsyxxss9FzEDb00hjXghyZ/Ozv+70=;
        b=PQLezJz5+m8bmjj4s6bhZyxQ9ZC4z5fCASWqmG7u3dDKRD8DpsHNPeNfeLrYIWH+1o
         jSd7fljzb0ajqG8wI7gTYdHYm5XVaBg7KVD+qlz4TeUV8OoRp97/UeE5RwG1xnoQn761
         xKWolSAQYNAVIVNc6mZACYFsIrRgMV6+lieDeG9yb4z9Imm/hGFQ+D3h3sis15bNYF2q
         tM+/5j6uYHrdgtMqrmcj99gHaMGVj5utrNUPSd3mJ/0zb89iYUx9NboJrN1TvYYO+Pyp
         MsRhLBsf+QxDK0oSnJ+xzzVh0ga/T5n5+HhA+1JWUv8hyuNaF3XIeEARnnc2CtFOXdW5
         QWBw==
X-Gm-Message-State: AOAM532ju1RxGI+0mrMgjkicRDKTtdVFyBu4eYwvK1aTdO9DyAK9UZtf
        SdDXKm4mMqCGexJFvd/Ylulzmw==
X-Google-Smtp-Source: ABdhPJyuaiQhAzfQiFVi+AnFMbHG90nR4zMk7Kh69V8Vj10wX7OabufWY3ccB+HfZflaDuO0xDUG2g==
X-Received: by 2002:a17:90b:ec9:: with SMTP id gz9mr2428127pjb.24.1630987200081;
        Mon, 06 Sep 2021 21:00:00 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id l19sm792155pjq.10.2021.09.06.20.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 20:59:59 -0700 (PDT)
Date:   Tue, 7 Sep 2021 09:29:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 5.15-rc1 - part 2
Message-ID: <20210907035957.lczjqwtwmt4qomcm@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

This pull request adds a new cpufreq driver for Mediatek, which had
been going through reviews since last one year.

Thanks.

--
Viresh

-------------------------8<-------------------------
The following changes since commit f0712ace7fe0723b40733c3b98591d34c1b0bfb9:

  cpufreq: qcom-hw: Set dvfs_possible_from_any_cpu cpufreq driver flag (2021-08-30 10:43:35 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

for you to fetch changes up to 4855e26bcf4d28956f3e33231b961610a0d4a72d:

  cpufreq: mediatek-hw: Add support for CPUFREQ HW (2021-09-06 15:15:19 +0530)

----------------------------------------------------------------
Hector.Yuan (3):
      dt-bindings: cpufreq: add bindings for MediaTek cpufreq HW
      cpufreq: Add of_perf_domain_get_sharing_cpumask
      cpufreq: mediatek-hw: Add support for CPUFREQ HW

 .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      |  70 +++++
 drivers/cpufreq/Kconfig.arm                        |  12 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/mediatek-cpufreq-hw.c              | 308 +++++++++++++++++++++
 include/linux/cpufreq.h                            |  58 +++-
 5 files changed, 448 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek-hw.yaml
 create mode 100644 drivers/cpufreq/mediatek-cpufreq-hw.c

